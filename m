Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0831F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 23:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeK1KkM (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 05:40:12 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46274 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1KkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 05:40:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so20492241edt.13
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 15:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=nmmstIBlk6o9eA8IZJO+cIjxdE6RbzydZD+MlnG68Rs=;
        b=DJ0r0hRH9D7fJ7fshdytpw/NIRAMCFxPlejLp3fUmH5cxuR1MgnF1D2usQlnY53sfx
         CGOo1HqtEk3P/09YphAGoYAWbo1M/xfxbXu/o2YKXmX86+H+1z0/nR4ytYsQSoScKWGv
         bbO45ElixWRV19LYTXkoQLyC+LApP3vSyle/SHe20kSgFTs6Etfg5S0Sefj8S7BXvlRM
         F3lgAvhuLG/nso5TTLE+DmQ4wEFnEZXDK8RLU/RyIx+zTgo2JaIIy4SO/Jbrxz40ScgF
         nHMBz7sMtgH6s8Jdrhg+qF+GFqMfl30LshSvUBd/vonQ4bHbHrklOEn3b+YqN6Vk57N2
         4dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=nmmstIBlk6o9eA8IZJO+cIjxdE6RbzydZD+MlnG68Rs=;
        b=mMXIldIcTY2Jf3j+asdW73xhBtgvuqdtd0fTRRV5ZUdnYbklVDvbEp4WpOC2z2dLg1
         HkofnTQtvdaJkJvEO3E5DTGwRUsxvyIOVEZ5fXl+YouaONoVQA4rBWgmRTEDblk/ly1D
         asozsAVfQ8V5aZo2J3oqsgnS3R8VCipJPs2Ry2fSaYpMsBf0Bm0B89y6csq4DdcXc0bJ
         Si6qOsxqSM7MwgcQDdK51OOtMEjaROsmix+2rFb0lnAP3L6umx2nD/zibCSx6Ku86T75
         DUZQQf/FmKx3uJaGWCqaGrxHGozeBxEZt4u+2h7/enFAofXOjbtyrf1Y+rqXU7LbbhuC
         5j/A==
X-Gm-Message-State: AA+aEWbUJrlJCNsQy1PnoQY9TaAu4oZP9RQKCf8uEBBXbJ0mw93dFudd
        AtxaiLRCs/z3h/ud2GcxUvAz7mVE
X-Google-Smtp-Source: AFSGD/XIYoayhLTHfwNlKCvWvwY/a4NXOoK3R/holrfRJRi6bLf9x1K3fP2Ur9LxEKY8FIlM49/WcQ==
X-Received: by 2002:a50:8163:: with SMTP id 90mr12941353edc.174.1543362038280;
        Tue, 27 Nov 2018 15:40:38 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id x10sm1319652edb.58.2018.11.27.15.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:40:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v11 20/22] stash: convert `stash--helper.c` into `stash.c`
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com> <de2ebf96ee5f94a1cdadee67e436f5bd1b0fb6a5.1542925164.git.ungureanupaulsebastian@gmail.com> <xmqqefb8z9qh.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811271438310.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1811271438310.41@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Nov 2018 00:40:36 +0100
Message-ID: <87ftvmytqj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 27 2018, Johannes Schindelin wrote:

> Hi Junio & Paul,
>
> On Mon, 26 Nov 2018, Junio C Hamano wrote:
>
>> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
>>
>> > The old shell script `git-stash.sh`  was removed and replaced
>> > entirely by `builtin/stash.c`. In order to do that, `create` and
>> > `push` were adapted to work without `stash.sh`. For example, before
>> > this commit, `git stash create` called `git stash--helper create
>> > --message "$*"`. If it called `git stash--helper create "$@"`, then
>> > some of these changes wouldn't have been necessary.
>> >
>> > This commit also removes the word `helper` since now stash is
>> > called directly and not by a shell script.
>> >
>> > Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
>> > ---
>> >  .gitignore                           |   1 -
>> >  Makefile                             |   3 +-
>> >  builtin.h                            |   2 +-
>> >  builtin/{stash--helper.c => stash.c} | 157 +++++++++++++++------------
>> >  git-stash.sh                         | 153 --------------------------
>> >  git.c                                |   2 +-
>> >  6 files changed, 92 insertions(+), 226 deletions(-)
>> >  rename builtin/{stash--helper.c => stash.c} (91%)
>> >  delete mode 100755 git-stash.sh
>>
>> Seeing the recent trouble in "rebase in C" and how keeping the
>> scripted version as "git legacy-rebase" helped us postpone the
>> rewritten version without ripping the whole thing out, I wonder if
>> we can do the same here.
>
> Feel very free to cherry-pick
> https://github.com/git-for-windows/git/commit/004da7e7faa36c872868ae938e06594ea1c2f01c
> and
> https://github.com/git-for-windows/git/commit/cedfcd39f5a4e4beb33e16fa67c4659fd4bdabf6
> which is what we carry in Git for Windows.

...and then something similar to 62c23938fa ("tests: add a special setup
where rebase.useBuiltin is off", 2018-11-14) so those of us who're
smoking next for bugs can test both and report if some of the test
setups (odd OS's etc) show a difference in behavior.

I did some of this the last time around, but then I had to e.g. smoke
next against pu, and look at the general fallout there and see what was
due to stash-in-C, it would be much better to have a
GIT_TEST_STASH_USE_BUILTIN.


>> Also, the remaining two patches should be done _before_ this step, I
>> would think.  I can understand it if the reason you have those two
>> after this step is because you found the opportunity for these
>> improvements after you wrote this step, but in the larger picture
>> seen by the end users of the "stash in C" and those developers who
>> follow the evolution of the code, the logical place for this "now we
>> have everything in C, we retire the scripted version" step to happen
>> is at the very end.
>>
>> Thanks.
>>
