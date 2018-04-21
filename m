Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBAA1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeDUK5e (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:57:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:46415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeDUK5d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:57:33 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LobGI-1eTblX2g8I-00gboP; Sat, 21
 Apr 2018 12:57:25 +0200
Date:   Sat, 21 Apr 2018 12:57:08 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v8 15/16] rebase -i: introduce
 --rebase-merges=[no-]rebase-cousins
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.1804211255440.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5nMXacn4we10N1qT3On/2BXee2g/Er16HSQ33964aa1KNuCHGpT
 oPa6//MvjPUXBJgblGL58lYHtpFSn6HpzofUCvybkqOW3hhq2zkkjFtE8FtYMZYnF+EgFHE
 yxv1Cv72J8LTO07apxNsZ4vAyxC7kmVkBy9NJ70LMLk6VbQd+RudVySU5mQXsmg/wsPvRnb
 lbIpXVgXBvLccc8KaoOUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vHyYBca5kog=:/qho8TcPfL83hlmznPuWbv
 +KnUW9tXxsBBQpqtMH0L8fy6dwK+W1AxkoOrq21wTTNE6d+ZQffORzpkn5i0pzst1Yr8WNR0d
 6G6dteVbrA5P8c27vvpJ+iv3AOauChyOy9fgxoRZzY2vdKnkowaaDkortTv7MpWE+Trj2hO3r
 z7MrUEdRuy3SQes3WnKmJiLOwTlOB5v/ytFEIF88WpVrCefYvOhKnreKJsUK2Ub0zre0rntfJ
 rJHZ2LTqbuasInjSqPf1TDC3Q4V1F+hegRDfvpzLNH4bbHjKapPKIE8WRyQiwTwqZQoPrj3Wc
 hJ2wxahfE4MVEI3XBp8KxlKKYfVrBapN15zL9HhKS1UFtxQwYU+SupGI79mmvMC+Kc9R4Gf6C
 Vd0EI8A94VWPxGCzY1fHAccoiKSPgvbOsM53Fq/7gKpEv6hVJPTlNACNXQLZFAmxiPGadDy3t
 QntPj/yk0ZQD3VFs87DcNnttMhqez4z2Vb745Sr/wOos5zVZ6tlqTGn0nVFohoe6mEG+S7KSY
 f7r/M2au8S40PZVF23AWuuoZFYulCra1hB506CYHyICk/RwE9xXNhWYMxR3ifcZSdr9nrI3gf
 GB2ZhZkYzWQD9picfvAJ/hETXy/TqNREOCSB5N5Pzl6myZphadUkugCklvc0xVoAGeavv1FKj
 pu8glRepnpZHKK1eqXy/Iz05cas6jUNH48PAITq+pRhCiET09aMC8LUZdqLtL4C/tXZhVs35n
 P7UY7h/VI/gRkhA6saW30lJRP6sE6YyYxUZIAmLmbY5Ia2gufhnhR/F5q8wRdpjN86phjMeTG
 CEFgDdxuuCJbeaI62YS7fZEJ8f7rZlh/2hzW5NYLcPEqHUiCcY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This one is a bit tricky to explain, so let's try with a diagram:

        C
      /   \
A - B - E - F
  \   /
    D

To illustrate what this new mode is all about, let's consider what
happens upon `git rebase -i --rebase-merges B`, in particular to
the commit `D`. So far, the new branch structure would be:

       --- C' --
      /         \
A - B ------ E' - F'
      \    /
        D'

This is not really preserving the branch topology from before! The
reason is that the commit `D` does not have `B` as ancestor, and
therefore it gets rebased onto `B`.

This is unintuitive behavior. Even worse, when recreating branch
structure, most use cases would appear to want cousins *not* to be
rebased onto the new base commit. For example, Git for Windows (the
heaviest user of the Git garden shears, which served as the blueprint
for --rebase-merges) frequently merges branches from `next` early, and
these branches certainly do *not* want to be rebased. In the example
above, the desired outcome would look like this:

       --- C' --
      /         \
A - B ------ E' - F'
  \        /
   -- D' --

Let's introduce the term "cousins" for such commits ("D" in the
example), and let's not rebase them by default, introducing the new
"rebase-cousins" mode for use cases where they should be rebased.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt |  7 ++++++-
 builtin/rebase--helper.c     |  9 ++++++++-
 git-rebase--interactive.sh   |  1 +
 git-rebase.sh                | 12 +++++++++++-
 sequencer.c                  |  4 ++++
 sequencer.h                  |  6 ++++++
 t/t3430-rebase-merges.sh     | 18 ++++++++++++++++++
 7 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 34e0f6a69c1..841cf9cf385 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -379,7 +379,7 @@ rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
 
 -r::
---rebase-merges::
+--rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
 	By default, a rebase will simply drop merge commits and only rebase
 	the non-merge commits. With this option, it will try to preserve
 	the branching structure within the commits that are to be rebased,
@@ -387,6 +387,11 @@ have the long commit hash prepended to the format.
 	or contained manual amendments, then they will have to be re-applied
 	manually.
 +
+By default, or when `no-rebase-cousins` was specified, commits which do not
+have `<upstream>` as direct ancestor will keep their original branch point.
+If the `rebase-cousins` mode is turned on, such commits are instead rebased
+onto `<upstream>` (or `<onto>`, if specified).
++
 This mode is similar in spirit to `--preserve-merges`, but in contrast to
 that option works well in interactive rebases: commits can be reordered,
 inserted and dropped at will.
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 781782e7272..f7c2a5fdc81 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,7 +13,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
-	int abbreviate_commands = 0;
+	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
@@ -25,6 +25,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
 			N_("allow commits with empty messages")),
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
+		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
+			 N_("keep original branch points of cousins")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -59,8 +61,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
+	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
+	if (rebase_cousins >= 0 && !rebase_merges)
+		warning(_("--[no-]rebase-cousins has no effect without "
+			  "--rebase-merges"));
+
 	if (command == CONTINUE && argc == 1)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7a3daf3e40c..b4ad130e8b1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -971,6 +971,7 @@ git_rebase__interactive () {
 
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 		${rebase_merges:+--rebase-merges} \
+		${rebase_cousins:+--rebase-cousins} \
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
diff --git a/git-rebase.sh b/git-rebase.sh
index a64460fd25a..157705d2a72 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -17,7 +17,7 @@ q,quiet!           be quiet. implies --no-stat
 autostash          automatically stash/stash pop before and after
 fork-point         use 'merge-base --fork-point' to refine upstream
 onto=!             rebase onto given branch instead of upstream
-r,rebase-merges!   try to rebase merges instead of skipping them
+r,rebase-merges?   try to rebase merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
@@ -90,6 +90,7 @@ state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
 rebase_merges=
+rebase_cousins=
 preserve_merges=
 autosquash=
 keep_empty=
@@ -276,6 +277,15 @@ do
 		rebase_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
+	--rebase-merges=*)
+		rebase_merges=t
+		case "${1#*=}" in
+		rebase-cousins) rebase_cousins=t;;
+		no-rebase-cousins) rebase_cousins=;;
+		*) die "Unknown mode: $1";;
+		esac
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
 	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
diff --git a/sequencer.c b/sequencer.c
index 443a0a0ee87..9ffadbb3d3c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3566,6 +3566,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
+	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -3743,6 +3744,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 					   &commit->object.oid);
 			if (entry)
 				to = entry->string;
+			else if (!rebase_cousins)
+				to = label_oid(&commit->object.oid, NULL,
+					       &state);
 
 			if (!to || !strcmp(to, "onto"))
 				fprintf(out, "%s onto\n", cmd_reset);
diff --git a/sequencer.h b/sequencer.h
index 6bc4da17243..d9570d92b11 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -60,6 +60,12 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
 #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 #define TODO_LIST_REBASE_MERGES (1U << 3)
+/*
+ * When rebasing merges, commits that do have the base commit as ancestor
+ * ("cousins") are *not* rebased onto the new base by default. If those
+ * commits should be rebased onto the new base, this flag needs to be passed.
+ */
+#define TODO_LIST_REBASE_COUSINS (1U << 4)
 int sequencer_make_script(FILE *out, int argc, const char **argv,
 			  unsigned flags);
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 1628c8dcc20..3d4dfdf7bec 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -176,6 +176,24 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success 'do not rebase cousins unless asked for' '
+	git checkout -b cousins master &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase -r HEAD^ &&
+	test_cmp_rev HEAD $before &&
+	test_tick &&
+	git rebase --rebase-merges=rebase-cousins HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	|/
+	o H
+	EOF
+'
+
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.17.0.windows.1.15.gaa56ade3205


