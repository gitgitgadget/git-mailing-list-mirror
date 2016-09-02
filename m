Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A6E1F859
	for <e@80x24.org>; Fri,  2 Sep 2016 11:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbcIBLlN (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 07:41:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33398 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbcIBLlL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 07:41:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id w207so2513081wmw.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/SXzOOyuHcrbES9u5UonDIOe1G87fFJe3qkqnASSxN4=;
        b=B4HSIIftIfzFNXnBLEywuR4fxwJWZQxWIPYZSEr0dBQVainkhjkuBU9v4x82CFdUYO
         kXSfCp8cAPUc7+AhOhq/knr5onPOH6G17OSzkayxc4v1enqNDBGka3iyrAW3v9atqwNn
         2WUNgWkyGwn2os9ypewPbqgQUYbc4BjGEDfGOGcGIuBQ2j64fhpdStOz6Qw6aqdwr1jd
         bpo9R/BdsNXNccGDWx+/IEHySid/2mWocltHCjtoxv3MiX+6qbCLNlI9cEWOilOS0cIb
         oaTV82PHOwMmgdHpaxrdQfP0VlVl9fiAunTQFqI7fP7INBwWAt0HKAt909pjGRwCfhsd
         p4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/SXzOOyuHcrbES9u5UonDIOe1G87fFJe3qkqnASSxN4=;
        b=jPojYhMyyMmsJ+Se6xtVLkuS216fwnC758SVcKGrgTIV83zDOUeqYY8BQHXgYb3RhN
         DsyEdEr58Rk3GHx4dFj5hKbEqzrvlBwjw4qTGU31as60tWObhsu/C8wRJCZ5faGh761A
         vq6uOxSYmFVkFkKF4SZhCHZgvEdrQIAaAiEq2CKMCGomyH8PKRUiWp/3n9sucRdIq6XA
         wiX/cEyZeLjVroLGIv2fpyXafysWdmfi0k6oSqwRAtxKxbE56Z2mKLzshNhD2QPXzz3z
         dMBp/pz+n6xry8dt8JFivtBPjsQ6iZdGrcoGv9BF1CWZfgomBG+V8Arnfu6RbGM3q6yG
         lD6Q==
X-Gm-Message-State: AE9vXwOPs4VkDkbEOzEkh431VIZdPq6EsEDZr2OaDi478irJALLar32fIxKG0QI6y2sEPw==
X-Received: by 10.28.104.6 with SMTP id d6mr2669537wmc.73.1472816469026;
        Fri, 02 Sep 2016 04:41:09 -0700 (PDT)
Received: from [192.168.1.26] (elz182.neoplus.adsl.tpnet.pl. [83.21.219.182])
        by smtp.googlemail.com with ESMTPSA id ka5sm9389612wjb.7.2016.09.02.04.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 04:41:08 -0700 (PDT)
Subject: Re: [PATCH 00/22] Prepare the sequencer for the upcoming rebase -i
 patches
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Johannes Sixt <j6t@kdbg.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ced4a190-6a79-e608-ca0b-3815267c5f93@gmail.com>
Date:   Fri, 2 Sep 2016 13:41:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:03, Johannes Schindelin pisze:

> This patch series marks the  '4' in the countdown to speed up rebase -i
> by implementing large parts in C. It is based on the `libify-sequencer`
> patch series that I submitted last week.

Which of those got reviewed (and perhaps accepted), and which of those
needs review still?  What is subject of their cover letter?

> 
> The patches in this series merely prepare the sequencer code for the
> next patch series that actually teaches the sequencer to run an
> interactive rebase.
> 
> The reason to split these two patch series is simple: to keep them at a
> sensible size.

That's good.

> 
> The two patch series after that are much smaller: a two-patch "series"
> that switches rebase -i to use the sequencer (except with --root or
> --preserve-merges), and a couple of patches to move several pretty
> expensive script processing steps to C (think: autosquash).

I can understand --preserve-merges, but what is the problem with --root?

> 
> The end game of this patch series is a git-rebase--helper that makes
> rebase -i 5x faster on Windows (according to t/perf/p3404). Travis says
> that even MacOSX and Linux benefit (4x and 3x, respectively).

So do I understand correctly that end goal for *this* series is to move
most of processing to git-rebase--helper, but full builtin-ification
(and retiring git-rebase.sh to contrib/examples/) would have to wait
for later?

[...]

I'd like here to summarize the discussion (my review, Dennis review,
Johannes Sixt and Junio comments).

If there are no comments, it means no problems or minor changes.

> Johannes Schindelin (22):
>   sequencer: use static initializers for replay_opts
There is no need for putting zeros in static initializer.  Commit
message expanded.

>   sequencer: use memoized sequencer directory path
>   sequencer: avoid unnecessary indirection
>   sequencer: future-proof remove_sequencer_state()
Leftover unrelated chunk removed.

>   sequencer: allow the sequencer to take custody of malloc()ed data
Is introducing new *_entrust() mechanism (which needs docs, at least
as comments) worth it, instead of just strdup everything and free?
If it is: naming of function parameter + example in commit message.

>   sequencer: release memory that was allocated when reading options
See above.

>   sequencer: future-proof read_populate_todo()
Possibly mention which functions were not future-proofed because
of planned for the subsequent patch full rewrite.

>   sequencer: remove overzealous assumption
Overzealous assumptions, or a worthy check?  Perhaps just remove check
for rebase -i in future commit, and keep test.  Perhaps remove test
temporarily.

>   sequencer: completely revamp the "todo" script parsing
This removes check; it should return if it was worthy.  Some discussion
about eager versus lazy parsing of commits, but IMHO it should be left
for later, if considered worth it.

>   sequencer: avoid completely different messages for different actions
Fix l10n or drop (and not introduce lego translation).

>   sequencer: get rid of the subcommand field
>   sequencer: refactor the code to obtain a short commit name
Explain reason behind this change in the commit mesage.

>   sequencer: remember the onelines when parsing the todo file
Lazy or eager again; "exec", "noop" and --preserve-merges.

>   sequencer: prepare for rebase -i's commit functionality
Add helper function, possibly extract helper function.  Rephrase block
comment.

"[PATCH] am: refactor read_author_script()" from Junio.

>   sequencer: introduce a helper to read files written by scripts
Perhaps add why not use open + strbuf_getline to commit message...

>   sequencer: prepare for rebase -i's GPG settings
Possibly fixes bug.  Use *_entrust() or strdup to not leak memory
(and to not crash when freeing memory).

>   sequencer: allow editing the commit message on a case-by-case basis
Enhance the commit message.

>   sequencer: support amending commits
>   sequencer: support cleaning up commit messages
>   sequencer: remember do_recursive_merge()'s return value
>   sequencer: left-trim the lines read from the script
>   sequencer: refactor write_message()
Enhance the commit message.  Quote path in messages while at it.


HTH

> 
>  builtin/commit.c                |   2 +-
>  builtin/revert.c                |  42 ++-
>  sequencer.c                     | 573 +++++++++++++++++++++++++++-------------
>  sequencer.h                     |  27 +-
>  t/t3510-cherry-pick-sequence.sh |  11 -
>  5 files changed, 428 insertions(+), 227 deletions(-)
> 
> Based-On: libify-sequencer at https://github.com/dscho/git
> Fetch-Base-Via: git fetch https://github.com/dscho/git libify-sequencer
> Published-As: https://github.com/dscho/git/releases/tag/prepare-sequencer-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git prepare-sequencer-v1

An unrelated question: Dscho, how are you generating above lines?

-- 
Jakub Narębski
 

