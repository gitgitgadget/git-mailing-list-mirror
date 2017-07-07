Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9B6A202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdGGJjk (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:39:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32816 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdGGJjj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:39:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id t72so3158514lff.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mTiOtjcGooeGf/OVDjngKtVd9JukjxU0K7H6HJOAmiU=;
        b=kX70ZAEasukvGT+JEug4EN7ZZsts0l0MfbSAArDG9Pw6A+amBzb28Ngr6siWYorzUS
         T4c5xSYgc2L4853H/jn8CZZGC0fof971xFiaKE9nkczP9/cDl7piDHKBQqVZU78SiBmu
         pjv9LTS/hCtq1HuEZfD4eZ+J+eN52kTvnTAzbKBpnqFUGHn8pQHe1kW+aVp51UGMyOvW
         ug/NjCt2uPQDq5wyyGlANf4GYFPQyr/XQGntLlZWjlYaNqtMxTBLf4zbFzmEyVaF0NXS
         FieHsDFIgL8QWwDzwlO9rrtbFc9r+z75yW1laFae8+fKlaLbbYXHj0D0SzY8tr3f3GLV
         r26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mTiOtjcGooeGf/OVDjngKtVd9JukjxU0K7H6HJOAmiU=;
        b=o30igbBRT7K7lpFOc9g6w52GMJmNRKPnQUkMMEpNKyDZsSYoRZfBmnt0p51hftmMbl
         FBr1b/PlrtG7We+4PtRXwYKRUEBjcyTXHFvbyXp2c8yFifKQ7SySb8x/yOgqOcAbxUoj
         uiLLzNOl+E4WYBP0RwWYRLTtzdLbAqW8rgWpkmFty2uW/OL7hgmEvNliCQ8chypMrJCw
         xrM1dV3Igy6b46J898A5LwsLUn+0qSvs17FKOilW+o3tl62AJq7HiiApOnDgPkXYyFXU
         XDenOslTH4yiGOn12ZyCxybEqwbG/J514GcGl+nm3SSkb2CNyb0doXjq4iqwesUHtmz0
         JueA==
X-Gm-Message-State: AIVw113U8/lqoSsXmPS5jmZPpdaz7BPgQXVY57A/z2CLaoZ0OHVWDrPA
        PCXm+G8xMUhYybSwE5Q=
X-Received: by 10.28.147.200 with SMTP id v191mr1589057wmd.95.1499420377707;
        Fri, 07 Jul 2017 02:39:37 -0700 (PDT)
Received: from snth ([5.57.20.48])
        by smtp.gmail.com with ESMTPSA id b72sm3851682wma.27.2017.07.07.02.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 02:39:35 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dTPja-00055H-Pl; Fri, 07 Jul 2017 11:39:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Stefan Haller <haller@ableton.com>,
        Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com> <1n47so5.9e6qvf1bbqww4M%haller@ableton.com> <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com> <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com> <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com> <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com> <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
Date:   Fri, 07 Jul 2017 11:39:34 +0200
Message-ID: <877ezkbn6x.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 06 2017, Junio C. Hamano jotted:

> "git push --force-with-lease=<branch>:<expect>" makes sure that
> there is no unexpected changes to the branch at the remote while you
> prepare a rewrite based on the old state of the branch.  This
> feature came with an experimental option that allows :<expect> part
> to be omitted by using the tip of remote-tracking branch that
> corresponds to the <branch>.
>
> It turns out that some people use third-party tools that fetch from
> remote and update the remote-tracking branches behind users' back,
> defeating the safety relying on the stability of the remote-tracking
> branches.  We have some warning text that was meant to be scary
> sounding in our documentation, but nevertheless people seem to be
> bitten.  cf. https://public-inbox.org/git/1491617750.2149.10.camel@mattmccutchen.net/
> for a recent example.
>
> Let's disable the form that relies on the stability of remote-tracking
> branches by default, and allow users who _know_ their remote-tracking
> branches are stable to enable it with a configuration variable.
>
> This problem was predicted from the very beginning; see 28f5d176
> (remote.c: add command line option parser for "--force-with-lease",
> 2013-07-08).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is a bit overdue safety fix that we should have done long
>    time ago.  If we had this, I do not think it makes it riskier to
>    forbid --force and tell people to use --force-with-lease.
>
>  Documentation/config.txt   |  5 +++++
>  Documentation/git-push.txt |  5 +++--
>  builtin/send-pack.c        |  5 +++++
>  remote.c                   | 16 ++++++++++++----
>  remote.h                   |  2 ++
>  send-pack.c                |  1 +
>  t/t5533-push-cas.sh        | 19 +++++++++++++++++--
>  transport-helper.c         |  5 +++++
>  transport.c                |  5 +++++
>  9 files changed, 55 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 06898a7498..2f929315a2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2588,6 +2588,11 @@ new default).
>
>  --
>
> +push.allowLazyForceWithLease::
> +	If set to true, allow the `--force-with-lease` option
> +	without the expected object name (i.e. expecting the objects
> +	at the tip of corresponding remote-tracking branches).
> +

Just a note on the implementation. Re what I mentioned in
871spxchvm.fsf@gmail.com it would be more consistent to add a
--lazy-force-with-lease option, and have a corresponding
push.LazyForceWithLease config, which we'd turn off by default.

Then if/when I polish the patch to make CLI options configurable this
doesn't have to be handled by a special case, either by code or in the
mind of users.

But perhaps adding new CLI options is a bit too much of a hassle to
maintain such consistency.
