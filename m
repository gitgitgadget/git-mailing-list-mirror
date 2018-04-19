Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785EE1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDSMWU (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:22:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:53255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeDSMWS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:22:18 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M82zV-1eEA8R00eX-00vg00; Thu, 19
 Apr 2018 14:22:10 +0200
Date:   Thu, 19 Apr 2018 14:21:53 +0200 (DST)
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
Subject: [PATCH v7 10/17] rebase: introduce the --rebase-merges option
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <2a8aad696b1af9a218ab1581cc6906ca32302d3f.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6HLK/acZ03yhzcqrqyLsLGgxaK7XuegqJvs0yKG9UJxhtRu+4PP
 pc7CTlVKsuQWo6JeG1H+73FiOvAoA8CZx9XYe3b+yB8YQJrvF12VOH2gabTiGBpWWINZx80
 cdoA8jr7QFCzm3yXKT+9VQujm8Ob4jsxSt1+2jXPALKYxovNmu7zP9WrZPw9RtLKAK7QgMU
 pBKi6AVOMWccm/5MqTCWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3N1aKnGTGGs=:xLsc+jXOrz/jIdjzfve+yu
 94SKc7uqS/bw7ldok2MR9GWIaj6hiVPvU7wuvwhEAzbMmco0hq66xLVseLssqLoHHc0LZ1OD2
 BWrT6hsBtTiKUIrTWfGu60EQjvHcgbPYHt8oLr3p/CZgEzbRSkbd6CWmlx4SGoE+oQFQ05AIz
 +m8nsKqR1d88lFrtlPCp1ndD04CjKWwSoEVuGSTFfnclfEVRB5UU8iSq54ICZSVQhl6EXsu6E
 UKBS8X/V3mcfJFOtGTgJgMv1K81WDgi0bcrENgRYYcndybSG7KAJ/a4CwVBS3dd/tc9o4eUgT
 M4jGTd0NeqRBgJtGW1mlILsdv+GqmvPDvd2+ploNTaV3TqsoJURBLe1wqqb6ofUdYkKVuI2vL
 L/HXpHyRKsXGa34s50xdeTTxM3g/7zV4x4UnpZv0BCC1rXnFaDPlTwj9PteWas5ZZLx36obf1
 St+ZO3B6fWNtofLZOIA4J/L8dRqt2JAx7Mt2v965N+GMdvUfzXkkgcJ/p40RTYQjdqt4vmUML
 VJnIsjqqsaByBgrSGFgIA1fhw22P+RgVQ+fi5r+vD/SgeP30XEultuM6Lk+ucjr8Titrk9uuU
 7cJjQ3cxuo7VaGK8EMKOMYc7DVT9RjPgu6XtBLqyR2s5sdehGVnFvzsSmNFo6W/3zWcDR8kr3
 fbDPx97OI5dq7yxv7DO4ocsMSHJFGZX+zFSQznAcpr+c/fqarND5KzMJ2cuPEOfI76GMr1p0n
 28XtDyvL9x1cElM4oW6ARLguPkGIPAnkwaZD1Lzr+VfuadGVU7U2wc2dSSJBqSX/dJFj5Abaj
 S0pOiS00hxpKeieq8Cw7OC6QXzFg6MslgR9sKUb0KVgZZzb8DI=
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
rebase -i` itself. Passing the `--rebase-merges` option will generate
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
 Documentation/git-rebase.txt           |  10 +-
 contrib/completion/git-completion.bash |   2 +-
 git-rebase--interactive.sh             |   1 +
 git-rebase.sh                          |   6 +
 t/t3430-rebase-merges.sh               | 156 +++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100755 t/t3430-rebase-merges.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3277ca14327..936c5619b42 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -378,6 +378,13 @@ The commit list format can be changed by setting the configuration option
 rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
 
+-r::
+--rebase-merges::
+	Rebase merge commits instead of flattening the history by replaying
+	merges. Merge conflict resolutions or manual amendments to merge
+	commits are not rebased automatically, but have to be applied
+	manually.
+
 -p::
 --preserve-merges::
 	Recreate merge commits instead of flattening the history by replaying
@@ -780,7 +787,8 @@ BUGS
 The todo list presented by `--preserve-merges --interactive` does not
 represent the topology of the revision graph.  Editing commits and
 rewording their commit messages should work fine, but attempts to
-reorder commits tend to produce counterintuitive results.
+reorder commits tend to produce counterintuitive results. Use
+--rebase-merges for a more faithful representation.
 
 For example, an attempt to rearrange
 ------------
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a7570739454..d4c0a995c39 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1949,7 +1949,7 @@ _git_rebase ()
 	--*)
 		__gitcomp "
 			--onto --merge --strategy --interactive
-			--preserve-merges --stat --no-stat
+			--rebase-merges --preserve-merges --stat --no-stat
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=
 			--autosquash --no-autosquash
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ccd5254d1c9..7a3daf3e40c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -970,6 +970,7 @@ git_rebase__interactive () {
 	init_revisions_and_shortrevisions
 
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+		${rebase_merges:+--rebase-merges} \
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
diff --git a/git-rebase.sh b/git-rebase.sh
index fb64ee1fe42..a64460fd25a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -17,6 +17,7 @@ q,quiet!           be quiet. implies --no-stat
 autostash          automatically stash/stash pop before and after
 fork-point         use 'merge-base --fork-point' to refine upstream
 onto=!             rebase onto given branch instead of upstream
+r,rebase-merges!   try to rebase merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
@@ -88,6 +89,7 @@ type=
 state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
+rebase_merges=
 preserve_merges=
 autosquash=
 keep_empty=
@@ -270,6 +272,10 @@ do
 	--allow-empty-message)
 		allow_empty_message=--allow-empty-message
 		;;
+	--rebase-merges)
+		rebase_merges=t
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
 	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
new file mode 100755
index 00000000000..e80fa068d05
--- /dev/null
+++ b/t/t3430-rebase-merges.sh
@@ -0,0 +1,156 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Johannes E. Schindelin
+#
+
+test_description='git rebase -i --rebase-merges
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
+test_cmp_graph () {
+	cat >expect &&
+	git log --graph --boundary --format=%s "$@" >output &&
+	sed "s/ *$//" <output >output.trimmed &&
+	test_cmp expect output.trimmed
+}
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
+test_expect_success 'create completely different structure' '
+	cat >script-from-scratch <<-\EOF &&
+	label onto
+
+	# onebranch
+	pick G
+	pick D
+	label onebranch
+
+	# second
+	reset onto
+	pick B
+	label second
+
+	reset onto
+	merge -C H second
+	merge onebranch # Merge the topic branch '\''onebranch'\''
+	EOF
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_tick &&
+	git rebase -i -r A &&
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
+test_expect_success '`reset` refuses to overwrite untracked files' '
+	git checkout -b refuse-to-reset &&
+	test_commit dont-overwrite-untracked &&
+	git checkout @{-1} &&
+	: >dont-overwrite-untracked.t &&
+	echo "reset refs/tags/dont-overwrite-untracked" >script-from-scratch &&
+	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
+	test_must_fail git rebase -r HEAD &&
+	git rebase --abort
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
+	git rebase -i -r upstream-with-a2 &&
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
2.17.0.windows.1.4.g7e4058d72e3


