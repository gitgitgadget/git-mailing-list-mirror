Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72190C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F145A222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="aW04KhmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbgJTBGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 21:06:24 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:56106 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgJTBGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 21:06:23 -0400
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id E68D1E472;
        Tue, 20 Oct 2020 01:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603155982;
        bh=PHoPYElVBjpDHSxihog5IgJQ0tU/pobf66qqoqTacOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aW04KhmDJjCJclghZJMk8AFisSk/k1UkucxJmW23SCNHA3GvkT5cUabMY+F633BUt
         Rwc+S5jj/tyxfttqkCdVgrN/WSAQhpVSzvaNx6TlE6nydpffgQxrgKHyL6lW3CwWdx
         ddM8ccbF2cMgZtPgh7OgE/oKDrSLD5gmVnkWxvxA0m0ck6fxIOC5nQ0pIKJnDjTDKx
         mZkcW6s8dqwBP/teThyBADnLO6+f9U9CssVH/R81FMx3wAbA9rSZRq42eO1k/ejNUy
         R2xfrrDx6b+qIe2oipHr/tFU3a8yA7wzKmkKzcUjC3jjMnGIpOct0Q1cOM6WlKgE/E
         NBis6tqe3KH7w==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 4/4] Documentation: stylistically normalize references to Signed-off-by:
Date:   Mon, 19 Oct 2020 18:03:55 -0700
Message-Id: <448b9d464eafdb0ee8faa8cd41ee08f844e27701.1603155607.git.bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1603155607.git.bkuhn@sfconservancy.org>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com> <cover.1603155607.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Organization: Software Freedom Conservancy, Inc.
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ted reported an old typo in the git-commit.txt and merge-options.txt.
Namely, the phrase "Signed-off-by line" was used without either a
definite nor indefinite article.

Upon examination, it seems that the documentation (including items in
Documentation/, but also option help strings) have been quite
inconsistent on usage when referring to `Signed-off-by`.

First, very few places used a definite or indefinite article with the
phrase "Signed-off-by line", but that was the initial typo that led
to this investigation.  So, normalize using either an indefinite or
definite article consistently.

The original phrasing, in Commit 3f971fc425b (Documentation updates,
2005-08-14), is "Add Signed-off-by line".  Commit 6f855371a53 (Add
--signoff, --check, and long option-names. 2005-12-09) switched to
using "Add `Signed-off-by:` line", but didn't normalize the former
commit to match.  Later commits seem to have cut and pasted from one
or the other, which is likely how the usage became so inconsistent.

Junio stated on the git mailing list in
<xmqqy2k1dfoh.fsf@gitster.c.googlers.com> a preference to leave off
the colon.  Thus, prefer `Signed-off-by` (with backticks) for the
documentation files and Signed-off-by (without backticks) for option
help strings.

Additionally, Junio argued that "trailer" is now the standard term to
refer to `Signed-off-by`, saying that "becomes plenty clear that we
are not talking about any random line in the log message".  As such,
prefer "trailer" over "line" anywhere the former word fits.

However, leave alone those few places in documentation that use
Signed-off-by to refer to the process (rather than the specific
trailer), or in places where mail headers are generally discussed in
comparison with Signed-off-by.

Reported-by: "Theodore Y. Ts'o" <tytso@mit.edu>
Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>
Acked-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/MyFirstContribution.txt |  2 +-
 Documentation/SubmittingPatches       | 10 +++++-----
 Documentation/config/format.txt       |  2 +-
 Documentation/git-am.txt              |  2 +-
 Documentation/git-cherry-pick.txt     |  2 +-
 Documentation/git-format-patch.txt    |  2 +-
 Documentation/git-rebase.txt          |  2 +-
 Documentation/git-revert.txt          |  2 +-
 Documentation/git-send-email.txt      |  4 ++--
 Documentation/git-svn.txt             |  4 ++--
 Documentation/githooks.txt            |  2 +-
 Documentation/signoff-option.txt      |  2 +-
 builtin/am.c                          |  2 +-
 builtin/commit.c                      |  2 +-
 builtin/log.c                         |  2 +-
 builtin/merge.c                       |  2 +-
 builtin/pull.c                        |  2 +-
 builtin/rebase.c                      |  2 +-
 builtin/revert.c                      |  2 +-
 commit.c                              |  2 +-
 20 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 4f85a089ef..492f3998f7 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -249,7 +249,7 @@ component you're working on, followed by a blank line (always required) and then
 the body of your commit message, which should provide the bulk of the context.
 Remember to be explicit and provide the "Why" of your change, especially if it
 couldn't easily be understood from your diff. When editing your commit message,
-don't remove the Signed-off-by line which was added by `-s` above.
+don't remove the `Signed-off-by` trailer which was added by `-s` above.
 
 ----
 psuh: add a built-in by popular demand
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f83a050b35..3bf2147787 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -209,7 +209,7 @@ send them as replies to either an additional "cover letter" message
 (see below), the first patch, or the respective preceding patch.
 
 If your log message (including your name on the
-Signed-off-by line) is not writable in ASCII, make sure that
+`Signed-off-by` trailer) is not writable in ASCII, make sure that
 you send off a message in the correct encoding.
 
 WARNING: Be wary of your MUAs word-wrap
@@ -229,7 +229,7 @@ previously sent.
 The `git format-patch` command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
 patch should come your commit message, ending with the
-Signed-off-by: lines, and a line that consists of three dashes,
+`Signed-off-by` trailers, and a line that consists of three dashes,
 followed by the diffstat information and the patch itself.  If
 you are forwarding a patch from somebody else, optionally, at
 the beginning of the e-mail message just before the commit
@@ -298,7 +298,7 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 patch.
 
 [[sign-off]]
-=== Certify your work by adding your "Signed-off-by: " line
+=== Certify your work by adding your `Signed-off-by` trailer
 
 To improve tracking of who did what, we ask you to certify that you
 wrote the patch or have the right to pass it on under the same license
@@ -345,7 +345,7 @@ this:
 This line can be added by Git if you run the git-commit command with
 the -s option.
 
-Notice that you can place your own Signed-off-by: line when
+Notice that you can place your own `Signed-off-by` trailer when
 forwarding somebody else's patch with the above rules for
 D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
@@ -357,7 +357,7 @@ your patch differs from project to project, so it may be different
 from that of the project you are accustomed to.
 
 [[real-name]]
-Also notice that a real name is used in the Signed-off-by: line. Please
+Also notice that a real name is used in the `Signed-off-by` trailer. Please
 don't hide your real name.
 
 [[commit-trailers]]
diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index c2efd8758a..851bf410a3 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -79,7 +79,7 @@ format.thread::
 
 format.signOff::
 	A boolean value which lets you enable the `-s/--signoff` option of
-	format-patch by default. *Note:* Adding the Signed-off-by: line to a
+	format-patch by default. *Note:* Adding the `Signed-off-by` trailer to a
 	patch should be a conscious act and means that you certify you have
 	the rights to submit this work under the same open source license.
 	Please see the 'SubmittingPatches' document for further discussion.
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 38c0852139..06bc063542 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -33,7 +33,7 @@ OPTIONS
 
 -s::
 --signoff::
-	Add a `Signed-off-by:` line to the commit message, using
+	Add a `Signed-off-by` trailer to the commit message, using
 	the committer identity of yourself.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 75feeef08a..5d750314b2 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -104,7 +104,7 @@ effect to your index in a row.
 
 -s::
 --signoff::
-	Add Signed-off-by line at the end of the commit message.
+	Add a `Signed-off-by` trailer at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
 -S[<keyid>]::
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0f81d0437b..bf1bb40f63 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -119,7 +119,7 @@ include::diff-options.txt[]
 
 -s::
 --signoff::
-	Add `Signed-off-by:` line to the commit message, using
+	Add a `Signed-off-by` trailer to the commit message, using
 	the committer identity of yourself.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 38e15488f6..a0487b5cc5 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -496,7 +496,7 @@ See also INCOMPATIBLE OPTIONS below.
 See also INCOMPATIBLE OPTIONS below.
 
 --signoff::
-	Add a Signed-off-by: trailer to all the rebased commits. Note
+	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
 +
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 044276e9da..bb92a4a451 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -99,7 +99,7 @@ effect to your index in a row.
 
 -s::
 --signoff::
-	Add Signed-off-by line at the end of the commit message.
+	Add a `Signed-off-by` trailer at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
 --strategy=<strategy>::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0a69810147..b7bbbeadef 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -313,7 +313,7 @@ Automating
 	the value of `sendemail.identity`.
 
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in Signed-off-by: or Cc: lines to the
+	If this is set, add emails found in the `Signed-off-by` trailer or Cc: lines to the
 	cc list. Default is the value of `sendemail.signedoffbycc` configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
@@ -340,7 +340,7 @@ Automating
   except for self (use 'self' for that).
 - 'bodycc' will avoid including anyone mentioned in Cc lines in the
   patch body (commit message) except for self (use 'self' for that).
-- 'sob' will avoid including anyone mentioned in Signed-off-by lines except
+- 'sob' will avoid including anyone mentioned in the Signed-off-by trailers except
   for self (use 'self' for that).
 - 'misc-by' will avoid including anyone mentioned in Acked-by,
   Reviewed-by, Tested-by and other "-by" lines in the patch body,
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 6624a14fbd..67b143cc81 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -701,7 +701,7 @@ creating the branch or tag.
 
 --use-log-author::
 	When retrieving svn commits into Git (as part of 'fetch', 'rebase', or
-	'dcommit' operations), look for the first `From:` or `Signed-off-by:` line
+	'dcommit' operations), look for the first `From:` line or `Signed-off-by` trailer
 	in the log message and use that as the author string.
 +
 [verse]
@@ -710,7 +710,7 @@ config key: svn.useLogAuthor
 --add-author-from::
 	When committing to svn from Git (as part of 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
-	`From:` or `Signed-off-by:` line, append a `From:` line based on the
+	`From:` or `Signed-off-by` trailer, append a `From:` line based on the
 	Git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
 +
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 6e461ace6e..4e097dc4e9 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -164,7 +164,7 @@ can also be used to refuse the commit after inspecting the message
 file.
 
 The default 'commit-msg' hook, when enabled, detects duplicate
-"Signed-off-by" lines, and aborts the commit if one is found.
+`Signed-off-by` trailers, and aborts the commit if one is found.
 
 post-commit
 ~~~~~~~~~~~
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index fbff8dd5be..12aa2333e4 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -3,7 +3,7 @@ ifdef::git-commit[]
 endif::git-commit[]
 --signoff::
 --no-signoff::
-	Add a Signed-off-by trailer by the committer at the end of the commit
+	Add a `Signed-off-by` trailer by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project
 	to which you're committing.  For example, it may certify that
 	the committer has the rights to submit the work under the
diff --git a/builtin/am.c b/builtin/am.c
index 2c7673f74e..26f53cdc09 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2237,7 +2237,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_SET_INT('s', "signoff", &state.signoff,
-			N_("add a Signed-off-by line to the commit message"),
+			N_("add a Signed-off-by trailer to the commit message"),
 			SIGNOFF_EXPLICIT),
 		OPT_BOOL('u', "utf8", &state.utf8,
 			N_("recode into utf8 (default)")),
diff --git a/builtin/commit.c b/builtin/commit.c
index 1dfd799ec5..505fe60956 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1507,7 +1507,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
+		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef9..9f939e6cdf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1738,7 +1738,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('N', "no-numbered", &numbered, NULL,
 			    N_("use [PATCH] even with multiple patches"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, no_numbered_callback),
-		OPT_BOOL('s', "signoff", &do_signoff, N_("add Signed-off-by:")),
+		OPT_BOOL('s', "signoff", &do_signoff, N_("add a Signed-off-by trailer")),
 		OPT_BOOL(0, "stdout", &use_stdout,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..4c133402a6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -289,7 +289,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_AUTOSTASH(&autostash),
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
-	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
+	OPT_BOOL(0, "signoff", &signoff, N_("add a Signed-off-by trailer")),
 	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
 	OPT_END()
 };
diff --git a/builtin/pull.c b/builtin/pull.c
index 425950f469..17aa63cd35 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -142,7 +142,7 @@ static struct option pull_options[] = {
 		N_("add (at most <n>) entries from shortlog to merge commit message"),
 		PARSE_OPT_OPTARG),
 	OPT_PASSTHRU(0, "signoff", &opt_signoff, NULL,
-		N_("add Signed-off-by:"),
+		N_("add a Signed-off-by trailer"),
 		PARSE_OPT_OPTARG),
 	OPT_PASSTHRU(0, "squash", &opt_squash, NULL,
 		N_("create a single commit instead of doing a merge"),
diff --git a/builtin/rebase.c b/builtin/rebase.c
index eeca53382f..7b65525301 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1324,7 +1324,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("do not show diffstat of what changed upstream"),
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
-			 N_("add a Signed-off-by: line to each commit")),
+			 N_("add a Signed-off-by trailer to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
diff --git a/builtin/revert.c b/builtin/revert.c
index f61cc5d82c..da8997dc86 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -107,7 +107,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
-		OPT_BOOL('s', "signoff", &opts->signoff, N_("add Signed-off-by:")),
+		OPT_BOOL('s', "signoff", &opts->signoff, N_("add a Signed-off-by trailer")),
 		OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
 			     N_("select mainline parent"), option_parse_m),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
diff --git a/commit.c b/commit.c
index f53429c0ac..fe1fa3dc41 100644
--- a/commit.c
+++ b/commit.c
@@ -1586,7 +1586,7 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 
 /*
  * Inspect the given string and determine the true "end" of the log message, in
- * order to find where to put a new Signed-off-by: line.  Ignored are
+ * order to find where to put a new Signed-off-by trailer.  Ignored are
  * trailing comment lines and blank lines.  To support "git commit -s
  * --amend" on an existing commit, we also ignore "Conflicts:".  To
  * support "git commit -v", we truncate at cut lines.
-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

