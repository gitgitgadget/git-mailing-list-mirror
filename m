Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1E31F461
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfHYJL7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:11:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40212 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYJL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:11:59 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so30240650ios.7
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XvJDDXuaQWzeuCIsVU3sDolbxzi/PRVsSgkC6dyzTYA=;
        b=DTCgnfxmcG/2eixHw+m0u9cqE9VX/IQ5g17Sp3ggFK3kwxxxmQmH3ukJ+J7TgMBpWk
         zpEqikC6eHMbaRNKHg6mbmdjyI+CgXUK6fCrCEK6q0zXasLc31F4/anSUZ+YdSVHbQWM
         YV2O0TeoLdJ/ugFpeWa4tFRb5AO/zLcHvcGW18C6wQVkt9qsS0z38fzfVZAtEPjiuzS5
         zmab6OJSLxLetMX3KOlt6T+Svef1saGoh/egMZa/nnHw6DWspEdHR5b3XKV/9+7ba4C8
         iEgU1QsqanZIjoOwxPRWBkeoS6VI+dMq/ijunG8kMfXhXo5WIoRLE2sAQrBGYALDb9vL
         sChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XvJDDXuaQWzeuCIsVU3sDolbxzi/PRVsSgkC6dyzTYA=;
        b=skxIP0EYmZfUJXxqqyQUg+bVq6v/QuL3qz7dUHkVRXeXQDKTpBOHQpyC2EDINRoVP3
         wXnPuvJlgqbnMEuaOurM4OrqCFORMlSov8S0nho12rnK6dx0ayR2FgNlHREOGFUiUr1d
         OC+5/DmnRMP85Sw4wNpNEPL3g0095z7qaAkW0kAU5UK5gkC6q9fRVFtehR4wW7g65K3r
         mmh2hetnKFQ7ro+el1J8Vzns7hMSGWjqGEOS3ocQS2OiK7k6BpIydt45471W0ecqDhFC
         1JRa+yI3xfPCC8R9+irWd9cN4iYhkLCvtf/gp3d/5UCcAHWE7EpkK9Oh1X6HjfKTM8pL
         Jg2g==
X-Gm-Message-State: APjAAAWEmlvjviHtle4m3NyI8raUQF/xuDWG3Oy2zd7gwinpkEQcEc4Y
        mUSlbBTnFnhA2X5MmKaCY0XeflZ3
X-Google-Smtp-Source: APXvYqxuTmyTaWjQ9QyxB/yE/UYfQk9TMpzUSkZZxrhczD2XoxEqhn4Q4ZZsBJjLVmcElhGFfHUVMQ==
X-Received: by 2002:a05:6638:627:: with SMTP id h7mr3921384jar.33.1566724317514;
        Sun, 25 Aug 2019 02:11:57 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id m20sm6395787ioh.4.2019.08.25.02.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:11:56 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:11:54 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 0/9] rebase: learn --keep-base and improvements on
 fast-forward behaviour
Message-ID: <cover.1566724236.git.liu.denton@gmail.com>
References: <20190508001252.15752-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508001252.15752-1-avarab@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, it's been a while but I guess now's a good time as any to
resurrect this topic. This is basically a resubmission of Ævar's WIP v8
but I fixed a couple of minor whitespace issues.

In addition, I opted to drop patches 9-13 from v8 since I don't think I
can do a good enough job polishing them up and I don't really understand
the intricacies of this part of the rebase code. Hopefully, Ævar will
pick them up at a later time.

Changes since v1:

* Squashed old set into one patch
* Fixed indentation style and dangling else
* Added more documentation after discussion with Ævar

Changes since v2:

* Add testing for rebase --fork-point behaviour
* Add testing for rebase fast-forward behaviour
* Make rebase --onto fast-forward in more cases
* Update documentation to include use-case

Changes since v3:

* Fix tests failing on bash 4.2
* Fix typo in t3431 comment

Changes since v4:

* Make rebase --fork-point fast-forward in more cases

Changes since v5:

* Fix graph illustrations so that the "branch off" is visually in the
  correct place
* Refactor if-else in can_fast_forward into one-level-deep ifs to
  increase clarity

Changes since v6:

* Remove redundant braces around if
* Update comment around can_fast_forward call
* Add completion for rebase

Changes since v7:

* Ævar sent in his WIP patchset

Changes since v8:

* Drop patches 9-13
* Fix some minor whitespace issues from v7

[1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com/


Denton Liu (6):
  t3431: add rebase --fork-point tests
  t3432: test rebase fast-forward behavior
  rebase: refactor can_fast_forward into goto tower
  rebase: fast-forward --onto in more cases
  rebase: fast-forward --fork-point in more cases
  rebase: teach rebase --keep-base

Ævar Arnfjörð Bjarmason (3):
  t3432: distinguish "noop-same" v.s. "work-same" in "same head" tests
  t3432: test for --no-ff's interaction with fast-forward
  rebase tests: test linear branch topology

 Documentation/git-rebase.txt           |  30 +++++-
 builtin/rebase.c                       |  85 ++++++++++++-----
 contrib/completion/git-completion.bash |   2 +-
 t/t3400-rebase.sh                      |   2 +-
 t/t3404-rebase-interactive.sh          |   2 +-
 t/t3416-rebase-onto-threedots.sh       |  57 +++++++++++
 t/t3421-rebase-topology-linear.sh      |  29 ++++++
 t/t3431-rebase-fork-point.sh           |  57 +++++++++++
 t/t3432-rebase-fast-forward.sh         | 125 +++++++++++++++++++++++++
 9 files changed, 361 insertions(+), 28 deletions(-)
 create mode 100755 t/t3431-rebase-fork-point.sh
 create mode 100755 t/t3432-rebase-fast-forward.sh

Range-diff against v8:
 1:  eb64f6c91d !  1:  03f769d410 t3431: add rebase --fork-point tests
    @@ t/t3431-rebase-fork-point.sh (new)
     +	test_commit G
     +'
     +
    -+test_rebase() {
    ++test_rebase () {
     +	expected="$1" &&
     +	shift &&
     +	test_expect_success "git rebase $*" "
 2:  4c087ec041 !  2:  bc8998079d t3432: test rebase fast-forward behavior
    @@ t/t3432-rebase-fast-forward.sh (new)
     +	git checkout -t -b side
     +'
     +
    -+test_rebase_same_head() {
    ++test_rebase_same_head () {
     +	status="$1" &&
     +	shift &&
     +	test_expect_$status "git rebase $* with $changes is no-op" "
 -:  ---------- >  3:  5c08e2b81f t3432: distinguish "noop-same" v.s. "work-same" in "same head" tests
 -:  ---------- >  4:  48b4e41a17 t3432: test for --no-ff's interaction with fast-forward
 3:  3d348d2c37 =  5:  9bd34b4a40 rebase: refactor can_fast_forward into goto tower
 4:  27cbcfaeae !  6:  becb924232 rebase: fast-forward --onto in more cases
    @@ Commit message
         Add '-f' to test cases that failed as a result of this change because
         they were not expecting a fast-forward so that a rebase is forced.
     
    -    While we're at it, remove a trailing whitespace from rebase.c.
    -
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      		int flag;
      
      		if (!(options.flags & REBASE_FORCE)) {
    -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 	strbuf_addf(&msg, "%s: checkout %s",
    - 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
    - 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
    --		       RESET_HEAD_DETACH | RESET_ORIG_HEAD | 
    -+		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
    - 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
    - 		       NULL, msg.buf))
    - 		die(_("Could not detach HEAD"));
     
      ## t/t3400-rebase.sh ##
    -@@ t/t3400-rebase.sh: test_expect_success 'rebase--am.sh and --show-current-patch' '
    +@@ t/t3400-rebase.sh: test_expect_success 'rebase --am and --show-current-patch' '
      		echo two >>init.t &&
      		git commit -a -m two &&
      		git tag two &&
    @@ t/t3404-rebase-interactive.sh: test_expect_success C_LOCALE_OUTPUT 'rebase --edi
      '
     
      ## t/t3432-rebase-fast-forward.sh ##
    -@@ t/t3432-rebase-fast-forward.sh: test_expect_success 'add work to upstream' '
    +@@ t/t3432-rebase-fast-forward.sh: test_expect_success 'add work same to upstream' '
      changes='our and their changes'
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    --test_rebase_same_head failure --onto master... master
    -+test_rebase_same_head success --onto master... master
    - test_rebase_same_head failure --fork-point --onto B B
    - test_rebase_same_head failure --fork-point --onto B... B
    --test_rebase_same_head failure --fork-point --onto master... master
    -+test_rebase_same_head success --fork-point --onto master... master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    +-test_rebase_same_head failure work same success work diff --onto master... master
    ++test_rebase_same_head success noop same success work diff --onto master... master
    + test_rebase_same_head failure work same success work diff --fork-point --onto B B
    + test_rebase_same_head failure work same success work diff --fork-point --onto B... B
    +-test_rebase_same_head failure work same success work diff --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work diff --fork-point --onto master... master
      
      test_done
 5:  8254730810 !  7:  4dab5847cb rebase: fast-forward --fork-point in more cases
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      		if (!(options.flags & REBASE_FORCE)) {
     
      ## t/t3432-rebase-fast-forward.sh ##
    -@@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    - test_rebase_same_head success --no-fork-point
    - test_rebase_same_head success --fork-point master
    --test_rebase_same_head failure --fork-point --onto B B
    --test_rebase_same_head failure --fork-point --onto B... B
    -+test_rebase_same_head success --fork-point --onto B B
    -+test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    +@@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head_ () {
    + }
    + 
    + changes='no changes'
    +-test_rebase_same_head success work same success work same
    ++test_rebase_same_head success noop same success work same
    + test_rebase_same_head success noop same success noop-force same master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success noop-force same --onto master... master
    + test_rebase_same_head success noop same success noop-force same --no-fork-point
    +-test_rebase_same_head success work same success work same --fork-point master
    +-test_rebase_same_head failure noop same success work diff --fork-point --onto B B
    +-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
    +-test_rebase_same_head success work same success work same --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work same --fork-point master
    ++test_rebase_same_head success noop same success work diff --fork-point --onto B B
    ++test_rebase_same_head success noop same success work diff --fork-point --onto B... B
    ++test_rebase_same_head success noop same success work same --fork-point --onto master... master
      
    - test_expect_success 'add work to side' '
    -@@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    - test_rebase_same_head success --no-fork-point
    - test_rebase_same_head success --fork-point master
    --test_rebase_same_head failure --fork-point --onto B B
    --test_rebase_same_head failure --fork-point --onto B... B
    -+test_rebase_same_head success --fork-point --onto B B
    -+test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    + test_expect_success 'add work same to side' '
    + 	test_commit E
    + '
      
    - test_expect_success 'add work to upstream' '
    -@@ t/t3432-rebase-fast-forward.sh: changes='our and their changes'
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    --test_rebase_same_head failure --fork-point --onto B B
    --test_rebase_same_head failure --fork-point --onto B... B
    -+test_rebase_same_head success --fork-point --onto B B
    -+test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    + changes='our changes'
    +-test_rebase_same_head success work same success work same
    ++test_rebase_same_head success noop same success work same
    + test_rebase_same_head success noop same success noop-force same master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success noop-force same --onto master... master
    + test_rebase_same_head success noop same success noop-force same --no-fork-point
    +-test_rebase_same_head success work same success work same --fork-point master
    +-test_rebase_same_head failure work same success work diff --fork-point --onto B B
    +-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
    +-test_rebase_same_head success work same success work same --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work same --fork-point master
    ++test_rebase_same_head success noop same success work diff --fork-point --onto B B
    ++test_rebase_same_head success noop same success work diff --fork-point --onto B... B
    ++test_rebase_same_head success noop same success work same --fork-point --onto master... master
      
    - test_done
    + test_expect_success 'add work same to upstream' '
    + 	git checkout master &&
 -:  ---------- >  8:  4699a90993 rebase tests: test linear branch topology
 6:  f18d3ee3fa !  9:  6927aba617 rebase: teach rebase --keep-base
    @@ Commit message
         in order to preserve the merge base. This is useful when contributing a
         patch series to the Git mailing list, one often starts on top of the
         current 'master'. However, while developing the patches, 'master' is
    -    also developed further and it is sometimes not the bst idea to keep
    +    also developed further and it is sometimes not the best idea to keep
         rebasing on top of 'master', but to keep the base commit as-is.
     
         Alternatively, a user wishing to test individual commits in a topic
    @@ Documentation/git-rebase.txt: git-rebase - Reapply commits on top of another bas
     +	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
      'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
      	--root [<branch>]
    - 'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
    + 'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
     @@ Documentation/git-rebase.txt: As a special case, you may use "A\...B" as a shortcut for the
      merge base of A and B if there is exactly one merge base. You can
      leave out at most one of A and B, in which case it defaults to HEAD.
    @@ Documentation/git-rebase.txt: NOTE: While an "easy case recovery" sometimes appe
     
      ## builtin/rebase.c ##
     @@
    - #include "branch.h"
    + #include "rebase-interactive.h"
      
      static char const * const builtin_rebase_usage[] = {
     -	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
    @@ builtin/rebase.c
      		"--root [<branch>]"),
      	N_("git rebase --continue | --abort | --skip | --edit-todo"),
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 	};
    + 	struct rebase_options options = REBASE_OPTIONS_INIT;
      	const char *branch_name;
      	int ret, flags, total_argc, in_progress = 0;
     +	int keep_base = 0;
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      			 N_("allow pre-rebase hook to run")),
      		OPT_NEGBIT('q', "quiet", &options.flags,
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 		usage_with_options(builtin_rebase_usage,
    - 				   builtin_rebase_options);
    + 		warning(_("git rebase --preserve-merges is deprecated. "
    + 			  "Use --rebase-merges instead."));
      
     +	if (keep_base) {
     +		if (options.onto_name)
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     +			die(_("cannot combine '--keep-base' with '--root'"));
     +	}
     +
    - 	if (action != NO_ACTION && !in_progress)
    + 	if (action != ACTION_NONE && !in_progress)
      		die(_("No rebase in progress?"));
      	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    @@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase -i --onto master..
      test_done
     
      ## t/t3431-rebase-fork-point.sh ##
    -@@ t/t3431-rebase-fork-point.sh: test_rebase() {
    +@@ t/t3431-rebase-fork-point.sh: test_rebase () {
      
      test_rebase 'G F E D B A'
      test_rebase 'G F D B A' --onto D
    @@ t/t3431-rebase-fork-point.sh: test_rebase() {
      test_done
     
      ## t/t3432-rebase-fast-forward.sh ##
    -@@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head success master
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    -+test_rebase_same_head success --keep-base master
    -+test_rebase_same_head success --keep-base
    - test_rebase_same_head success --no-fork-point
    -+test_rebase_same_head success --keep-base --no-fork-point
    - test_rebase_same_head success --fork-point master
    - test_rebase_same_head success --fork-point --onto B B
    - test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    -+test_rebase_same_head success --fork-point --keep-base master
    +@@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head success noop same success noop-force same master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success noop-force same --onto master... master
    ++test_rebase_same_head success noop same success noop-force same --keep-base master
    ++test_rebase_same_head success noop same success noop-force same --keep-base
    + test_rebase_same_head success noop same success noop-force same --no-fork-point
    ++test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
    + test_rebase_same_head success noop same success work same --fork-point master
    + test_rebase_same_head success noop same success work diff --fork-point --onto B B
    + test_rebase_same_head success noop same success work diff --fork-point --onto B... B
    + test_rebase_same_head success noop same success work same --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work same --keep-base --keep-base master
      
    - test_expect_success 'add work to side' '
    + test_expect_success 'add work same to side' '
      	test_commit E
    -@@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head success master
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    -+test_rebase_same_head success --keep-base master
    -+test_rebase_same_head success --keep-base
    - test_rebase_same_head success --no-fork-point
    -+test_rebase_same_head success --keep-base --no-fork-point
    - test_rebase_same_head success --fork-point master
    - test_rebase_same_head success --fork-point --onto B B
    - test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    -+test_rebase_same_head success --fork-point --keep-base master
    +@@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head success noop same success noop-force same master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success noop-force same --onto master... master
    ++test_rebase_same_head success noop same success noop-force same --keep-base master
    ++test_rebase_same_head success noop same success noop-force same --keep-base
    + test_rebase_same_head success noop same success noop-force same --no-fork-point
    ++test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
    + test_rebase_same_head success noop same success work same --fork-point master
    + test_rebase_same_head success noop same success work diff --fork-point --onto B B
    + test_rebase_same_head success noop same success work diff --fork-point --onto B... B
    + test_rebase_same_head success noop same success work same --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work same --fork-point --keep-base master
      
    - test_expect_success 'add work to upstream' '
    + test_expect_success 'add work same to upstream' '
      	git checkout master &&
     @@ t/t3432-rebase-fast-forward.sh: changes='our and their changes'
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    -+test_rebase_same_head success --keep-base master
    -+test_rebase_same_head success --keep-base
    - test_rebase_same_head success --fork-point --onto B B
    - test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    -+test_rebase_same_head success --fork-point --keep-base master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success work diff --onto master... master
    ++test_rebase_same_head success noop same success work diff --keep-base master
    ++test_rebase_same_head success noop same success work diff --keep-base
    + test_rebase_same_head failure work same success work diff --fork-point --onto B B
    + test_rebase_same_head failure work same success work diff --fork-point --onto B... B
    + test_rebase_same_head success noop same success work diff --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work diff --fork-point --keep-base master
      
      test_done
-- 
2.23.0.248.g3a9dd8fb08

