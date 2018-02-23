Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEBA1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeBWMir (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:38:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:57739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbeBWMir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:38:47 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN748-1en0lT2c6S-006brV; Fri, 23
 Feb 2018 13:38:39 +0100
Date:   Fri, 23 Feb 2018 13:38:24 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 08/12] rebase: introduce the --recreate-merges option
In-Reply-To: <cover.1519389319.git.johannes.schindelin@gmx.de>
Message-ID: <31098ae586dcd2c5b08e3f7db1a99d1ccef64ed8.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3e3Y28vVO84XOYfzuaBkir9pXk0MyjPRVPeJgrETxpaajH3/clX
 4dWi2zpJBgaPKiwP8iQmqkWz0mtjvUaJM1hnWsju/k0Vn33QJ6pB7tXgB4ErlcbtrMRKhVk
 xtXY8MpF1O+UtXBF4wxUtQJ7v2H3adu1qVURumRi9U3JdqtS0skVLdeX5BiJdFgUkHz0XmU
 z+s/G54QAdJJGIvJKGe4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wrzZSN7U3ic=:XFmukmTVljTsEwcmJdrTst
 1g4S/v5Id/pNtyT5zaIOsVypcwjQIJH9SL4ALxGU8VM4yS/XvWSuRh21xeEtMbK07Fh1ecin2
 zAiqaqEW39SGhRbMJ/HBP5NbVjCCIpqNpCxwhWvScBSa321zPGMcmymBc8S6itA6l50zwums6
 d4SyxGGvPcezFv2nJaWmjECt5GBgI+TOXidBq1SRLcf2olNWDaM9YI09AwL0s2TfboGoYeu6d
 m4QJACTLXsXuA7ED7j2xPzWgOv+n5h3muLauT6RrEvJ9wy3B/9mJ30GXfoLuUrOpiYwPIBogV
 trddMzCfPLKf0cjyfm2T3lbnQNc7zWPTRoJPj93DkTx9qE+HEQtfC/plfUH+TkwzyDxsBU339
 GYNoRUyVpeiNfrbqpoDwW4iqGoehbv9YFoUmNthK/SQUuFW0qt8ryxv1or4DI5TYK9u+SvS9l
 Du6V8xxLUi8KOL+bEmZFuy60KZzDy1JVuQeuPYbJqIqXRum0Z/XbSeGU5JoTPUcmNqStU7wum
 3dkPhcjRUaRPIUNdT4UflOeMZmWY1y0XFhMBvRM2CEUKNjY6inyBSHr9S4UijDewNk8Ulx/M4
 8RDuenYDh+edxXN/i7qH4lbd2fOtFbKVnHGD1a5LbSx27pJCn03x/8gpEGEFAy5xAI1eg6exs
 p0a5pa5cwRIwLimJOptCNdqAtoHpQUUxdYBWNOcTlROxxCuQBdsvpK6je3GkolQVWrdH22ZU1
 p/PcfJgt1KUHwBpra2OH13s3Ijvv/Bf8aZJfZhQecmEmOJuajWQPBh1nuZ5E0qcPuRJjPCi3l
 fWN+jOqJkoZIPWF6TjaI6a9+NtgF4GFGiIXv3wETgMKGyo2HX8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, this here developer thought: wouldn't it be nice if,
say, Git for Windows' patches on top of core Git could be represented as
a thicket of branches, and be rebased on top of core Git in order to
maintain a cherry-pick'able set of patch series?

The original attempt to answer this was: git rebase --preserve-merges.

However, that experiment was never intended as an interactive option,
and it only piggy-backed on git rebase --interactive because that
command's implementation looked already very, very familiar: it was
designed by the same person who designed --preserve-merges: yours truly.

Some time later, some other developer (I am looking at you, Andreas!
;-)) decided that it would be a good idea to allow --preserve-merges to
be combined with --interactive (with caveats!) and the Git maintainer
(well, the interim Git maintainer during Junio's absence, that is)
agreed, and that is when the glamor of the --preserve-merges design
started to fall apart rather quickly and unglamorously.

The reason? In --preserve-merges mode, the parents of a merge commit (or
for that matter, of *any* commit) were not stated explicitly, but were
*implied* by the commit name passed to the `pick` command.

This made it impossible, for example, to reorder commits. Not to mention
to flatten the branch topology or, deity forbid, to split topic branches
into two.

Alas, these shortcomings also prevented that mode (whose original
purpose was to serve Git for Windows' needs, with the additional hope
that it may be useful to others, too) from serving Git for Windows'
needs.

Five years later, when it became really untenable to have one unwieldy,
big hodge-podge patch series of partly related, partly unrelated patches
in Git for Windows that was rebased onto core Git's tags from time to
time (earning the undeserved wrath of the developer of the ill-fated
git-remote-hg series that first obsoleted Git for Windows' competing
approach, only to be abandoned without maintainer later) was really
untenable, the "Git garden shears" were born [*1*/*2*]: a script,
piggy-backing on top of the interactive rebase, that would first
determine the branch topology of the patches to be rebased, create a
pseudo todo list for further editing, transform the result into a real
todo list (making heavy use of the `exec` command to "implement" the
missing todo list commands) and finally recreate the patch series on
top of the new base commit.

That was in 2013. And it took about three weeks to come up with the
design and implement it as an out-of-tree script. Needless to say, the
implementation needed quite a few years to stabilize, all the while the
design itself proved itself sound.

With this patch, the goodness of the Git garden shears comes to `git
rebase -i` itself. Passing the `--recreate-merges` option will generate
a todo list that can be understood readily, and where it is obvious
how to reorder commits. New branches can be introduced by inserting
`label` commands and calling `merge <label>`. And once this mode will
have become stable and universally accepted, we can deprecate the design
mistake that was `--preserve-merges`.

Link *1*:
https://github.com/msysgit/msysgit/blob/master/share/msysGit/shears.sh
Link *2*:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt           |   9 +-
 contrib/completion/git-completion.bash |   2 +-
 git-rebase--interactive.sh             |   1 +
 git-rebase.sh                          |   6 ++
 t/t3430-rebase-recreate-merges.sh      | 146 +++++++++++++++++++++++++++++++++
 5 files changed, 162 insertions(+), 2 deletions(-)
 create mode 100755 t/t3430-rebase-recreate-merges.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d713951b86a..5e056c8ab6b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -373,6 +373,12 @@ The commit list format can be changed by setting the configuration option
 rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
 
+--recreate-merges::
+	Recreate merge commits instead of flattening the history by replaying
+	merges. Merge conflict resolutions or manual amendments to merge
+	commits are not recreated automatically, but have to be recreated
+	manually.
+
 -p::
 --preserve-merges::
 	Recreate merge commits instead of flattening the history by replaying
@@ -775,7 +781,8 @@ BUGS
 The todo list presented by `--preserve-merges --interactive` does not
 represent the topology of the revision graph.  Editing commits and
 rewording their commit messages should work fine, but attempts to
-reorder commits tend to produce counterintuitive results.
+reorder commits tend to produce counterintuitive results. Use
+--recreate-merges for a more faithful representation.
 
 For example, an attempt to rearrange
 ------------
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 88813e91244..38bba3835c6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2008,7 +2008,7 @@ _git_rebase ()
 	--*)
 		__gitcomp "
 			--onto --merge --strategy --interactive
-			--preserve-merges --stat --no-stat
+			--recreate-merges --preserve-merges --stat --no-stat
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=
 			--autosquash --no-autosquash
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2d8bbe20b74..f5c8db2fdf8 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -906,6 +906,7 @@ fi
 if test t != "$preserve_merges"
 then
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+		${recreate_merges:+--recreate-merges} \
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 else
diff --git a/git-rebase.sh b/git-rebase.sh
index b353c33d417..528fa0073ac 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -17,6 +17,7 @@ q,quiet!           be quiet. implies --no-stat
 autostash          automatically stash/stash pop before and after
 fork-point         use 'merge-base --fork-point' to refine upstream
 onto=!             rebase onto given branch instead of upstream
+recreate-merges!   try to recreate merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
@@ -87,6 +88,7 @@ type=
 state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
+recreate_merges=
 preserve_merges=
 autosquash=
 keep_empty=
@@ -267,6 +269,10 @@ do
 	--allow-empty-message)
 		allow_empty_message=--allow-empty-message
 		;;
+	--recreate-merges)
+		recreate_merges=t
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
 	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
new file mode 100755
index 00000000000..0073601a206
--- /dev/null
+++ b/t/t3430-rebase-recreate-merges.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 Johannes E. Schindelin
+#
+
+test_description='git rebase -i --recreate-merges
+
+This test runs git rebase "interactively", retaining the branch structure by
+recreating merge commits.
+
+Initial setup:
+
+    -- B --                   (first)
+   /       \
+ A - C - D - E - H            (master)
+       \       /
+         F - G                (second)
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup' '
+	write_script replace-editor.sh <<-\EOF &&
+	mv "$1" "$(git rev-parse --git-path ORIGINAL-TODO)"
+	cp script-from-scratch "$1"
+	EOF
+
+	test_commit A &&
+	git checkout -b first &&
+	test_commit B &&
+	git checkout master &&
+	test_commit C &&
+	test_commit D &&
+	git merge --no-commit B &&
+	test_tick &&
+	git commit -m E &&
+	git tag -m E E &&
+	git checkout -b second C &&
+	test_commit F &&
+	test_commit G &&
+	git checkout master &&
+	git merge --no-commit G &&
+	test_tick &&
+	git commit -m H &&
+	git tag -m H H
+'
+
+cat >script-from-scratch <<\EOF
+label onto
+
+# onebranch
+pick G
+pick D
+label onebranch
+
+# second
+reset onto
+pick B
+label second
+
+reset onto
+merge -C H second
+merge onebranch # Merge the topic branch 'onebranch'
+EOF
+
+test_cmp_graph () {
+	cat >expect &&
+	git log --graph --boundary --format=%s "$@" >output &&
+	sed "s/ *$//" <output >output.trimmed &&
+	test_cmp expect output.trimmed
+}
+
+test_expect_success 'create completely different structure' '
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i --recreate-merges A &&
+	test_cmp_graph <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	* |   H
+	|\ \
+	| |/
+	|/|
+	| * B
+	|/
+	* A
+	EOF
+'
+
+test_expect_success 'generate correct todo list' '
+	cat >expect <<-\EOF &&
+	label onto
+
+	reset onto
+	pick d9df450 B
+	label E
+
+	reset onto
+	pick 5dee784 C
+	label branch-point
+	pick ca2c861 F
+	pick 088b00a G
+	label H
+
+	reset branch-point # C
+	pick 12bd07b D
+	merge -C 2051b56 E # E
+	merge -C 233d48a H # H
+
+	EOF
+
+	grep -v "^#" <.git/ORIGINAL-TODO >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'with a branch tip that was cherry-picked already' '
+	git checkout -b already-upstream master &&
+	base="$(git rev-parse --verify HEAD)" &&
+
+	test_commit A1 &&
+	test_commit A2 &&
+	git reset --hard $base &&
+	test_commit B1 &&
+	test_tick &&
+	git merge -m "Merge branch A" A2 &&
+
+	git checkout -b upstream-with-a2 $base &&
+	test_tick &&
+	git cherry-pick A2 &&
+
+	git checkout already-upstream &&
+	test_tick &&
+	git rebase -i --recreate-merges upstream-with-a2 &&
+	test_cmp_graph upstream-with-a2.. <<-\EOF
+	*   Merge branch A
+	|\
+	| * A1
+	* | B1
+	|/
+	o A2
+	EOF
+'
+
+test_done
-- 
2.16.1.windows.4


