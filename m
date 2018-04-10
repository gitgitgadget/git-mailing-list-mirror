Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862821F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeDJMag (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:30:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:53261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753176AbeDJMad (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:30:33 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MLOMM-1f6QNc448Y-000b9q; Tue, 10 Apr 2018 14:30:27 +0200
Date:   Tue, 10 Apr 2018 14:30:26 +0200 (DST)
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
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 14/15] rebase -i: introduce
 --rebase-merges=[no-]rebase-cousins
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <349021284f5b3b9c57a49f88221cef1eb4643020.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PqcQfDYFVeVWDf+hSvsMgWiRw+4dsxgrTTJo1iDopMMLNt516yN
 BL5uhSBpLzAq9zhDA0+vz7oYvskaTvZpPc895F74vagC00q0zHrh67kETZywEgJcITMJR3L
 hmrUbiQVEaKJJ+Bu9MuzS9Nll1WuIev75/2fNsKbG4U5w/v9DriU6RmbDX0C4qiFgEl1pxK
 T5d3lvRGJrRZc7fF8Vf0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WaacETCdZ2c=:bw5uIiEM7Ly6jTWxL5bAK6
 u6HAjWVZTVuLd3IiYlWcqdx/t6gp+9ItF+/TMtLkrrSGI9+OlK71mYX/qwJ2oq2lQASdQzGZY
 QtW6F1oMDuDBzk2WSEyJ1BKerc2Y9DGj0+2ZfBbPl97Vq+CElX3EExuTZ0ir7h07Zq7GqpYNu
 gb5f6GRsPo+MVRHGz8cb0hqMQTnzKyBwWEQ46TM8EKbOpa0V8vy5aXBSBJLiPH4mB/lGRWAMY
 0OYWmhLKqhDSdcYOmFvAObLWJuEeY5HlLvPwq5gq1kTewnRf0w6H5sPghlyENKdweh1uc0cxw
 4nmWlqiJew22n3CpiJjbI3tFlIb7znwBd84PQe+XPhAK/6Nenlu486+aFGUrta+Yxk/kqy824
 +SQhrVl7gR6LOXcsOpxh4VvCPqj11lcIq+EmPcaQn5n/vyEqwQH/D3yCSbxsLA+krFveXGpQw
 MvERTiwpFS89yFyNUQcIMWxFi51ZXUXdJj0nqLO3i5u6YAV5T30P8Ohg5hENfmrbkd07wtfc0
 Wa0lKp8kJ+J9f1U9ii+Erx8UZnaL6aAgTDOhDDuK0bZTKiFr2bDA400U/ehqjtWrg8B5zehoy
 U5jzkJCkg+/P0PHJXK6irXDhYzxQV1bpDMQZwGFCwnXKTnxWKnhii9SNIEByLWctydqoxkTOn
 4MgXHrES1aS0rpnrmzFkhYqPoexxwclkJgb/VLPq2pnl7UeBWPW6zRo1S1t1va/4PtGefnDM1
 aWWj+QrCqbmr37wH17G4fRCvkpz1lLK2qqQhSTupFWAQ5d3AWpBK0d9YvMPmwsIF95/uOxub2
 kc0gqiGxA/ABf1WiqlJib1ufl7rAXYnmXNVqfZtMlvlT0J/bBs=
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
index 936c5619b42..8feadf6e663 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -379,11 +379,16 @@ rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
 
 -r::
---rebase-merges::
+--rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
 	Rebase merge commits instead of flattening the history by replaying
 	merges. Merge conflict resolutions or manual amendments to merge
 	commits are not rebased automatically, but have to be applied
 	manually.
++
+By default, or when `no-rebase-cousins` was specified, commits which do not
+have `<upstream>` as direct ancestor will keep their original branch point.
+If the `rebase-cousins` mode is turned on, such commits are rebased onto
+`<upstream>` (or `<onto>`, if specified).
 
 -p::
 --preserve-merges::
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
index 60bad5708c6..809df1ce484 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3499,6 +3499,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				   unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
+	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -3676,6 +3677,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
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
index 63faf7c2246..ee006810573 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -143,6 +143,24 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
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
2.17.0.windows.1.4.g7e4058d72e3


