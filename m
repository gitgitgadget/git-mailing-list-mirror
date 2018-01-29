Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E52D1FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeA2WzI (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:55:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:63193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbeA2WzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:55:03 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lrviw-1el8yV0ZtG-013e0b; Mon, 29 Jan 2018 23:54:57 +0100
Date:   Mon, 29 Jan 2018 23:54:56 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 06/10] rebase: introduce the --recreate-merges option
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <9f0b001eca49d0cd3c8baf9230e49330034fab4b.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2mREihs5Zk7634G3QjWowwOIOBbGrkReKMiL6UO7zwNU0fALPNb
 t7S7AoGdbTD73X54nR1neDaC6IvdoEeJMTVwH2WHMiDDU5B1//qV/p4eW5qK3NSenL6uQbA
 0y26dPigyiJs5IomgqkSdKquZyIRK0EV403w/syGotjPTj+7qYK//yPOMFaiBfugkAbpGSq
 QHClTFGk5fOtcCZ1rYZxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h51XImaGFIQ=:j1AqyY0WMjL+b3WIineeAz
 lRfaWsF8nknChlO1vN4MxThIFye4CPkQpJbxR6Dbeb0BeYNYkl9+Nd3sSkw6PZPmcoZOBgQ7a
 8IqtfQBOo7qIAEgnZgPuSBxHWn0t7OtcEeI65GDLU50/tavuqOa/5BcDqxb6ChEk7s08uLjW2
 dUwiMsxmNOdGqFuSqKCGNk13AesZYjaxSIXMA60pa21H7qMChJKYI9DejWBAhnYpejXIN+mf3
 IYi2494/mOu5WZmrXXw/4oc5KdNRdp815SQTe2IAWp4MB0Ci1tR4xli08YJTiJw+MggshC8zM
 bVsYZM6cT0F9ediuNjKDZC2m1tPztHoLYCsr4O6+ZBQj7RAyAaEzyHJ3+o8LsT2dZxVtSfXxt
 0AMeZG5y4ENvYZemBd8DH3vx8s4bRa3byMqdUKnaAVj3bb9n5bL1cwvQEtoE1+EG1etn8D1cd
 hEc/U2e3EUwqAhxqZv6c1QRTQ9G0dmuvyElkouGwgNGeeA9TrSn1cog2a0C+06n/A4tHZAw7W
 uxnyqlRVmqemc+zCoWXxcjYndUWjpvpwlaRuuZqf7JVdoMLIa1Rb62FPOmCBn0IyqdzBwbfOy
 14vF/1gfOf563VMvjWe6a/c6o57YOHqLPx71MFzGuAbHC7t8U3/BLFpgTgBSLHyGQHldR3VUq
 SG8VVFEGG9emG3wLyBS8KAlOewrwKcHaIEj8dE3rAYmbSfk4jeNtCs7rHEdMnJcUQG9alWJLC
 fM51xzAERGYTPTetqYqwGs4Lo3YSd+zZ17ZKhZfUBSJqEaviyf96tb999/AcFTtk4g7413LdI
 nrOAMwEcJnKCFmmZp35AywV9w+7Frt6CZ4V3J6NdcLk724fKbV+X8zhHGsf1eh3hurnf7G8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, this here developer thought: wouldn't it be nice if,
say, Git for Windows' patches on top of core Git could be represented as
a thicket of branches, and be rebased on top of core Git in order to
maintain a cherry-pick'able set of patch series?

The original attempt at an answer was: git rebase --preserve-merges.

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
`label` commands and calling `merge - <label> <oneline>`. And once this
mode has become stable and universally accepted, we can deprecate the
design mistake that was `--preserve-merges`.

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
index 8a861c1e0d6..e9da7e26329 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -368,6 +368,12 @@ The commit list format can be changed by setting the configuration option
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
@@ -770,7 +776,8 @@ BUGS
 The todo list presented by `--preserve-merges --interactive` does not
 represent the topology of the revision graph.  Editing commits and
 rewording their commit messages should work fine, but attempts to
-reorder commits tend to produce counterintuitive results.
+reorder commits tend to produce counterintuitive results. Use
+--recreate-merges for a more faithful representation.
 
 For example, an attempt to rearrange
 ------------
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c55..6893c3adabc 100644
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
index d6fd30f6c09..97b7954f7d3 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -902,6 +902,7 @@ fi
 if test t != "$preserve_merges"
 then
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+		${recreate_merges:+--recreate-merges} \
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 else
diff --git a/git-rebase.sh b/git-rebase.sh
index fd72a35c65b..d69bc7d0e0d 100755
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
@@ -86,6 +87,7 @@ type=
 state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
+recreate_merges=
 preserve_merges=
 autosquash=
 keep_empty=
@@ -262,6 +264,10 @@ do
 	--keep-empty)
 		keep_empty=yes
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
index 00000000000..b5ea4130bb5
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
+merge H second
+merge - onebranch Merge the topic branch 'onebranch'
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
+	merge 2051b56 E E
+	merge 233d48a H H
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
2.16.1.windows.1


