Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF43208B4
	for <e@80x24.org>; Mon,  7 Aug 2017 14:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbdHGOjh (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:39:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34822 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdHGOjg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:39:36 -0400
Received: by mail-pg0-f65.google.com with SMTP id l64so557402pge.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kRWnkZShnL6Rbz2Jb9UF9xBV3qd7/Gz6Jlq8Hf3+gek=;
        b=umgs5JoPCQleGvJ6u+8OAZDzCTsLA+VqQEyDJ5euNUNPXJagTIhT8DgNCIr6W32oG2
         BQTaW51hN0BWLHHPsDF4D3JAP8h1tJJgPzTeZFT7eN/1vR00iNIICUBuQkDl8nxehDlA
         FLaH8SUb3x2KkIw9kNPlhzeB6s8MWcGcT689aeCSgvCaBn4i3sWy33eUm8yUicydCyKf
         zw96otOB0e2CDZCKV23jrSQUO26+UbEcXTa5+k0LtgkLjZgtXUYoSXbmCfDYZ3HewN1r
         0rdWUc0CsBlRn8qcGiACvS1qWHh2CPk77YzWFvOqY7pcUmDYPISjts7rOX2lYyovihNC
         Jg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=kRWnkZShnL6Rbz2Jb9UF9xBV3qd7/Gz6Jlq8Hf3+gek=;
        b=NWcschm6GM8uwfyN2MEpo2BeB8VFnRotTsOp8fYhL9XmIrwbYDw+w8lAkprDGsKOtd
         GJkINMjzgn5LX5wCu8FXB9iIkCR8Ifur3DGMxXgaBiKMYM+xdeeatlCvYFnUXVTrVExu
         3zILZbNbNaTR8g8NRSCnK/u+7ynxPwYOG+ndnigYZq2xjeISG1lbSvx9GL6cQveXT138
         GPJUmt1QCYwQQhpUJgfx9VZ2zS8DodFuZeTFqPT8nMoJBHWNo1de/dhtiWUrhlts8eh3
         f3CQl3+Q8WqYLCu0lpw304gXCoVYf/fKK+ruSdol+MzRbN8cP2v10mROI0HGBvBAmYQb
         iGbw==
X-Gm-Message-State: AHYfb5j/M5kLQFHG34LKLkBjXXrtxP0WkBvSWIBz4NraudPkEScYxSmW
        CvXu5OYIboAHJ7+eAaE=
X-Received: by 10.99.186.7 with SMTP id k7mr787077pgf.0.1502116775337;
        Mon, 07 Aug 2017 07:39:35 -0700 (PDT)
Received: from localhost.localdomain ([117.249.222.33])
        by smtp.gmail.com with ESMTPSA id u69sm15279812pfa.70.2017.08.07.07.39.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 07:39:34 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2 / RFC] builtin/branch: remove the deprecated '--set-upstream' option
Date:   Mon,  7 Aug 2017 20:09:37 +0530
Message-Id: <20170807143938.5127-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <20170807143938.5127-1-kaarticsivaraam91196@gmail.com>
References: <xmqq1sp2q1cc.fsf@gitster.mtv.corp.google.com>
 <20170807143938.5127-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--set-upstream' option of branch was deprecated in,

    b347d06bf branch: deprecate --set-upstream and show help if we detect
    possible mistaken use (Thu, 30 Aug 2012 19:23:13 +0200)

It was deprecated for the reasons specified in the commit message of
the referenced commit.

Refactor 'branch' so that it doesn't accept '--set-upstream'.

Note that, 'git branch' still *accepts* '--set-upstream' as a consequence
of "unique prefix can be abbrievated in option names". '--set-upstream'
is a unique prefix of '--set-upstream-to' after '--set-upstream' has
been removed.

The before/after behaviour for a simple case follows,

    $ git remote
    origin

Before,

    $ git branch
    * master

    $ git branch --set-upstream origin/master
    The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
    Branch origin/master set up to track local branch master.

    $ git branch
    * master
      origin/master

After,

    $ git branch
    * master

    $ git branch --set-upstream origin/master
    Branch master set up to track remote branch master from origin.

    $ git branch
    * master

Note that the option used in the after sequence is still '--set-upstream'
though the behaviour is that of '--set-upstream-to'.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/git-branch.txt | 10 ++-------
 builtin/branch.c             | 24 ---------------------
 t/t3200-branch.sh            | 50 ++------------------------------------------
 3 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 81bd0a7b7..23c47b850 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[(--merged | --no-merged) [<commit>]]
 	[--contains [<commit]] [--no-contains [<commit>]]
 	[--points-at <object>] [--format=<format>] [<pattern>...]
-'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -81,7 +81,7 @@ OPTIONS
 --delete::
 	Delete a branch. The branch must be fully merged in its
 	upstream branch, or in `HEAD` if no upstream was set with
-	`--track` or `--set-upstream`.
+	`--track` or `--set-upstream-to`.
 
 -D::
 	Shortcut for `--delete --force`.
@@ -194,12 +194,6 @@ start-point is either a local or remote-tracking branch.
 	Do not set up "upstream" configuration, even if the
 	branch.autoSetupMerge configuration variable is true.
 
---set-upstream::
-	If specified branch does not exist yet or if `--force` has been
-	given, acts exactly like `--track`. Otherwise sets up configuration
-	like `--track` would when creating the branch, except that where
-	branch points to is not changed.
-
 -u <upstream>::
 --set-upstream-to=<upstream>::
 	Set up <branchname>'s tracking information so <upstream> is
diff --git a/builtin/branch.c b/builtin/branch.c
index a3bd2262b..a70fa8bc6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -557,8 +557,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
 		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
 			BRANCH_TRACK_EXPLICIT),
-		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
-			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("Unset the upstream info")),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
@@ -755,8 +753,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
-		int branch_existed = 0, remote_tracking = 0;
-		struct strbuf buf = STRBUF_INIT;
 
 		if (!strcmp(argv[0], "HEAD"))
 			die(_("it does not make sense to create 'HEAD' manually"));
@@ -767,29 +763,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 
-		if (track == BRANCH_TRACK_OVERRIDE)
-			fprintf(stderr, _("The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to\n"));
-
-		strbuf_addf(&buf, "refs/remotes/%s", branch->name);
-		remote_tracking = ref_exists(buf.buf);
-		strbuf_release(&buf);
-
-		branch_existed = ref_exists(branch->refname);
 		create_branch(argv[0], (argc == 2) ? argv[1] : head,
 			      force, reflog, 0, quiet, track);
 
-		/*
-		 * We only show the instructions if the user gave us
-		 * one branch which doesn't exist locally, but is the
-		 * name of a remote-tracking branch.
-		 */
-		if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
-		    !branch_existed && remote_tracking) {
-			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
-			fprintf(stderr, "    git branch -d %s\n", branch->name);
-			fprintf(stderr, "    git branch --set-upstream-to %s\n", branch->name);
-		}
-
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd37ac47c..3ae87c238 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -561,7 +561,8 @@ test_expect_success 'use --set-upstream-to modify a particular branch' '
 	git branch my13 &&
 	git branch --set-upstream-to master my13 &&
 	test "$(git config branch.my13.remote)" = "." &&
-	test "$(git config branch.my13.merge)" = "refs/heads/master"
+	test "$(git config branch.my13.merge)" = "refs/heads/master" &&
+	git branch --unset-upstream my13
 '
 
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
@@ -605,40 +606,6 @@ test_expect_success 'test --unset-upstream on a particular branch' '
 	test_must_fail git config branch.my14.merge
 '
 
-test_expect_success '--set-upstream shows message when creating a new branch that exists as remote-tracking' '
-	git update-ref refs/remotes/origin/master HEAD &&
-	git branch --set-upstream origin/master 2>actual &&
-	test_when_finished git update-ref -d refs/remotes/origin/master &&
-	test_when_finished git branch -d origin/master &&
-	cat >expected <<EOF &&
-The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
-
-If you wanted to make '"'master'"' track '"'origin/master'"', do this:
-
-    git branch -d origin/master
-    git branch --set-upstream-to origin/master
-EOF
-	test_i18ncmp expected actual
-'
-
-test_expect_success '--set-upstream with two args only shows the deprecation message' '
-	git branch --set-upstream master my13 2>actual &&
-	test_when_finished git branch --unset-upstream master &&
-	cat >expected <<EOF &&
-The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
-EOF
-	test_i18ncmp expected actual
-'
-
-test_expect_success '--set-upstream with one arg only shows the deprecation message if the branch existed' '
-	git branch --set-upstream my13 2>actual &&
-	test_when_finished git branch --unset-upstream my13 &&
-	cat >expected <<EOF &&
-The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
-EOF
-	test_i18ncmp expected actual
-'
-
 test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
 	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
 	cat >expected <<-\EOF &&
@@ -961,19 +928,6 @@ test_expect_success 'attempt to delete a branch merged to its base' '
 	test_must_fail git branch -d my10
 '
 
-test_expect_success 'use set-upstream on the current branch' '
-	git checkout master &&
-	git --bare init myupstream.git &&
-	git push myupstream.git master:refs/heads/frotz &&
-	git remote add origin myupstream.git &&
-	git fetch &&
-	git branch --set-upstream master origin/frotz &&
-
-	test "z$(git config branch.master.remote)" = "zorigin" &&
-	test "z$(git config branch.master.merge)" = "zrefs/heads/frotz"
-
-'
-
 test_expect_success 'use --edit-description' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
-- 
2.14.0.rc1.434.g6eded367a

