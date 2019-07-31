Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51BD1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfGaPSl (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56064 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfGaPSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so61237283wmj.5
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u/qvJ0USHxtknWo+utcHDX1LNrb5QJ7MepXNYJGyUHU=;
        b=aa+aSaPUYOyZuo8PVGwv0ho7lq+3toU7nXPR1hZr3Iwo5CJceIMZIeBrVHlqEJnCup
         gS7ljfux/0SCMT7ytM8w3nVOwvDMHOt+hwSAmAin//tSWmWp4cnubC7s+60N11rfCA4b
         lgtlrWGXyeDEFQqEJ/m9ZjJvxJgTA4nNZSx30ptPX9lB2ZpfryvyUYnNeJj72pEpin/c
         QKl6u0RDxhgi1pcJuXo2Eam3u+6tZaIQeQeuYK8aTM+SjVSlvhAllvWuyTguLy6i9T23
         Moof1ZPIkUqXkpX/+NWbFS1Swzg7ItT6t37JR4QhyarGLMMEet/k8YTj4zUMEZBc3WJe
         OrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u/qvJ0USHxtknWo+utcHDX1LNrb5QJ7MepXNYJGyUHU=;
        b=ds9littSOJOFv0JY6+aYbhuz0M8rx35Cu6YCTHfuGH3cXxVgNrFK/SUDKosCm4ml4B
         Vd6HVDjVZfcVlrmGidc9LF1eFzs1RcIoKF+89KtapYPHyDzZ0dOvb5xuOvN2j0bz5rrV
         RCHqXcNOoMXLmj4NODmFWlExZqwPb0cnWf8fZnu2P5tH+E5Co/4nVfGTZb/4m8QVqm5I
         AedfDfL/CIuKtRI3z9tNv9yHLoNnEU6DTFlPiUdiJXqPAYEzx4VJO9Dbj+IjeMM5kzmk
         /8xe6aG321c45Q/m3MgKQ9Z4qMsvYFth1W+DMJdMasM08W/N4ux9kZEwV3YNwNsbNGmj
         qrog==
X-Gm-Message-State: APjAAAV9BYm5zYD9MrVEOX/mAiq9kS5DpeJ+w/oHjY1GrpTNv+cr/6DE
        csH69/9vqruJExTPMJHhoNJTAMyk
X-Google-Smtp-Source: APXvYqyjHcbrjCgt2p/8e6vR6c8CdlylCjoPIzw6uIlldpeXj4JemKnLhujsSTAAH/RVY2mvsXmfaQ==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr106019120wmk.99.1564586317926;
        Wed, 31 Jul 2019 08:18:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm89086573wrp.72.2019.07.31.08.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:37 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:37 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:20 GMT
Message-Id: <pull.294.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/16] rebase -r: support merge strategies other than recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the most notable shortcoming that --rebase-merges has, still,
relative to --preserve-merges' capabilities: it does not support passing
custom merge strategies or custom merge strategy options.

Let's fix this.

While working on this patch series, of course I tried to copy-edit the test
cases we have, to cover --preserve-merges' support for merge strategies. Oh
my, did I regret this decision as soon as my eyes set sight on 
t3427-rebase-subtree.sh!

At first I tried my best to make heads or tails of t3427, for way too long.
In the end the only way to understand what the heck it tries to do was to
actually fix it. That's why this patch series looks as if it focuses on
t3427 rather than on adding support for custom merge strategies to the 
--rebase-merges mode.

As a consolation to myself, this work was actually worth it, surprising as
that may look. Not only is t3427 now really easy to understand, adding that
test case for --rebase-merges -Xsubtree tickled the sequencer enough to
reveal a long-standing bug: the --onto option was simply ignored when passed
together with --rebase-merges and --root. For good measure, this patch
series addresses this bug, too.

Changes since v1:

 * Rebased to the current js/rebase-cleanup: that branch itself was rebased,
   and as a consequence, one already-applied patch was dropped from this
   patch series.
 * Forward-fixed the fakesha handling, just in case that anybody wants to
   use it with a regular pick command in the future (thanks, brian).

Johannes Schindelin (16):
  Drop unused git-rebase--am.sh
  t3400: stop referring to the scripted rebase
  .gitignore: there is no longer a built-in `git-rebase--interactive`
  sequencer: the `am` and `rebase--interactive` scripts are gone
  rebase: fold git-rebase--common into the -p backend
  t3427: add a clarifying comment
  t3427: simplify the `setup` test case significantly
  t3427: move the `filter-branch` invocation into the `setup` case
  t3427: condense the unnecessarily repetitive test cases into three
  t3427: fix erroneous assumption
  t3427: accommodate for the `rebase --merge` backend having been
    replaced
  t3427: fix another incorrect assumption
  rebase -r: support merge strategies other than `recursive`
  t/lib-rebase: prepare for testing `git rebase --rebase-merges`
  t3418: test `rebase -r` with merge strategies
  rebase -r: do not (re-)generate root commits with `--root` *and*
    `--onto`

 .gitignore                             |   3 -
 Documentation/git-rebase.txt           |   2 -
 Makefile                               |   2 -
 builtin/rebase.c                       |  23 +---
 git-rebase--am.sh                      |  85 --------------
 git-rebase--common.sh                  |  69 -----------
 git-rebase--preserve-merges.sh         |  55 +++++++++
 sequencer.c                            |  20 +++-
 sequencer.h                            |   6 +
 t/lib-rebase.sh                        |   9 +-
 t/t3400-rebase.sh                      |   2 +-
 t/t3418-rebase-continue.sh             |  14 +++
 t/t3422-rebase-incompatible-options.sh |  10 --
 t/t3427-rebase-subtree.sh              | 155 +++++++++++--------------
 t/t3430-rebase-merges.sh               |  21 ++++
 15 files changed, 193 insertions(+), 283 deletions(-)
 delete mode 100644 git-rebase--am.sh
 delete mode 100644 git-rebase--common.sh


base-commit: 80dfc9242ebaba357ffedececd88641a1a752411
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-294%2Fdscho%2Frebase-r-with-strategies-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-294/dscho/rebase-r-with-strategies-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/294

Range-diff vs v1:

  -:  ---------- >  1:  e0645b3ad7 Drop unused git-rebase--am.sh
  -:  ---------- >  2:  6e8be7d873 t3400: stop referring to the scripted rebase
  -:  ---------- >  3:  9e00e66dc7 .gitignore: there is no longer a built-in `git-rebase--interactive`
  -:  ---------- >  4:  db9ec248e1 sequencer: the `am` and `rebase--interactive` scripts are gone
  -:  ---------- >  5:  38c8e3e284 rebase: fold git-rebase--common into the -p backend
  1:  05be92d921 =  6:  b3daf078e8 t3427: add a clarifying comment
  2:  df096e054d =  7:  c168c4499b t3427: simplify the `setup` test case significantly
  3:  a3944c5480 !  8:  138ff362fb t3427: move the `filter-branch` invocation into the `setup` case
     @@ -29,7 +29,8 @@
       '
       
       # FAILURE: Does not preserve master4.
     - test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 4' '
     + test_expect_failure REBASE_P \
     + 	'Rebase -Xsubtree --preserve-merges --onto commit 4' '
       	reset_rebase &&
      -	git checkout -b rebase-preserve-merges-4 master &&
      -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
     @@ -39,8 +40,8 @@
       	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
       '
      @@
     - # FAILURE: Does not preserve master5.
     - test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 5' '
     + test_expect_failure REBASE_P \
     + 	'Rebase -Xsubtree --preserve-merges --onto commit 5' '
       	reset_rebase &&
      -	git checkout -b rebase-preserve-merges-5 master &&
      -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
     @@ -50,8 +51,8 @@
       	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
       '
      @@
     - # FAILURE: Does not preserve master4.
     - test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
     + test_expect_failure REBASE_P \
     + 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
       	reset_rebase &&
      -	git checkout -b rebase-keep-empty-4 master &&
      -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
     @@ -61,8 +62,8 @@
       	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
       '
      @@
     - # FAILURE: Does not preserve master5.
     - test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
     + test_expect_failure REBASE_P \
     + 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
       	reset_rebase &&
      -	git checkout -b rebase-keep-empty-5 master &&
      -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
     @@ -72,8 +73,8 @@
       	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
       '
      @@
     - # FAILURE: Does not preserve Empty.
     - test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
     + test_expect_failure REBASE_P \
     + 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
       	reset_rebase &&
      -	git checkout -b rebase-keep-empty-empty master &&
      -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
  4:  9aeb57fa8f !  9:  46ef005365 t3427: condense the unnecessarily repetitive test cases into three
     @@ -25,8 +25,9 @@
       '
       
       # FAILURE: Does not preserve master4.
     --test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 4' '
     -+test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit' '
     +-test_expect_failure REBASE_P \
     +-	'Rebase -Xsubtree --preserve-merges --onto commit 4' '
     ++test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
       	reset_rebase &&
      -	git checkout -b rebase-preserve-merges-4 to-rebase &&
      -	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
     @@ -34,7 +35,8 @@
      -'
      -
      -# FAILURE: Does not preserve master5.
     --test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 5' '
     +-test_expect_failure REBASE_P \
     +-	'Rebase -Xsubtree --preserve-merges --onto commit 5' '
      -	reset_rebase &&
      -	git checkout -b rebase-preserve-merges-5 to-rebase &&
      +	git checkout -b rebase-preserve-merges to-rebase &&
     @@ -44,8 +46,9 @@
       '
       
       # FAILURE: Does not preserve master4.
     --test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
     -+test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
     +-test_expect_failure REBASE_P \
     +-	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
     ++test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
       	reset_rebase &&
      -	git checkout -b rebase-keep-empty-4 to-rebase &&
      -	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
     @@ -53,7 +56,8 @@
      -'
      -
      -# FAILURE: Does not preserve master5.
     --test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
     +-test_expect_failure REBASE_P \
     +-	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
      -	reset_rebase &&
      -	git checkout -b rebase-keep-empty-5 to-rebase &&
      -	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
     @@ -61,7 +65,8 @@
      -'
      -
      -# FAILURE: Does not preserve Empty.
     --test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
     +-test_expect_failure REBASE_P \
     +-	'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
      -	reset_rebase &&
      -	git checkout -b rebase-keep-empty-empty to-rebase &&
      +	git checkout -b rebase-keep-empty to-rebase &&
  5:  3196413c2a = 10:  8afec74cfc t3427: fix erroneous assumption
  6:  261825fe44 = 11:  d73b0a05d9 t3427: accommodate for the `rebase --merge` backend having been replaced
  7:  f7452d3740 = 12:  57c63309bf t3427: fix another incorrect assumption
  8:  7f60b8e745 <  -:  ---------- t3427: mark two test cases as requiring support for `git rebase -p`
  9:  30405df99f = 13:  75b1395dae rebase -r: support merge strategies other than `recursive`
 10:  ae9e72b73b ! 14:  8f74bfbc53 t/lib-rebase: prepare for testing `git rebase --rebase-merges`
     @@ -6,6 +6,26 @@
          `--rebase-merges` mode; Let's prepare the fake editor to handle those
          todo lists properly, too.
      
     +    The original idea was that we keep the original command unless
     +    overridden, and because the original todo lists only had `pick` lines
     +    anyway, we could be sloppy and "override" the command by the same
     +    command (i.e. use the sed replacement pattern "pick" instead of "&").
     +
     +    This actually would not have worked with `fixup` and `squash` commands,
     +    but it would appear that we never tried to use the fake editor with
     +    `--autosquash`.
     +
     +    However, in the next commit we want to use the fake editor in
     +    conjunction with `--rebase-merges`, so let's use the correct sed
     +    replacement pattern.
     +
     +    Technically, it is not necessary to take care of the `fakesha` thing
     +    (where we reuse the sed replacement pattern to craft a new todo
     +    command), at least for now, as the only user of that thing overrides the
     +    `action` anyway. Nevertheless, for completeness' sake, we do take care
     +    of it.
     +
     +    Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
     @@ -25,6 +45,10 @@
       		exec_*|x_*|break|b)
       			echo "$line" | sed 's/_/ /g' >> "$1";;
      @@
     + 		bad)
     + 			action="badcmd";;
     + 		fakesha)
     ++			test \& != "$action" || action=pick
       			echo "$action XXXXXXX False commit" >> "$1"
       			action=pick;;
       		*)
 11:  a326be77aa = 15:  0c938d02b3 t3418: test `rebase -r` with merge strategies
 12:  e6713568dc = 16:  be62d267cb rebase -r: do not (re-)generate root commits with `--root` *and* `--onto`

-- 
gitgitgadget
