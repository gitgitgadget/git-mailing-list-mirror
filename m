From: Justin Lebar <jlebar@google.com>
Subject: [PATCH v5 1/4] Documentation: Fix misuses of "nor"
Date: Mon, 31 Mar 2014 15:11:44 -0700
Message-ID: <1396303907-23291-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 00:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkR6-0007ON-P2
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbaCaWLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:11:55 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:46304 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbaCaWLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:11:52 -0400
Received: by mail-qa0-f74.google.com with SMTP id w5so1232123qac.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jBMN2KbBJvT2lSLj/Ls5iOG42c/C+OdQEQCVD/F7o1E=;
        b=Yx3MsvFv964RFdsL0Sy2H6f2zArQUtKyy51dpRwgvWK/D5s4R1zR+nvwl33uAY1udg
         xk4cjzVSzOD/zu5iE/O0NZoIogcgG7nVjUoXHXSWpVw8mhfdKWlDwSfl0sMhhJ2Bpv8z
         wXhMAxnjjlttMde1YOeDRWYBEHPkcM+hGdrdSt4sCU3zpcTlJRPhO5cvjtDgWj4s8CnZ
         ocXsPiAz3EABmPrhZ4UOO3LvZs/A/pjYoUhRkmEANYCh4+XPN/95189KaqERNnZRQ85H
         olA96kZCECQxlYHoboV9ThB0bYmmiMWZrJP42pfytxRS7TzqsoYT5Dksxbak+618r/3x
         uZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jBMN2KbBJvT2lSLj/Ls5iOG42c/C+OdQEQCVD/F7o1E=;
        b=X5lHE9zEUIxUoGVgG1NekA7QDWlLvl6stoSpjoOeEGOC7ian7SDbk0u2bEnBRQFfan
         93f8McX05tnBjx0DtBAPw70uiKBLGb8+kjibolg+Tbg+aLy4Daa1OayCtG7N4lMjTnXN
         EmHUCXx/IfW3gRvmuClJR43XLC767vThXnzfLtDARkUa+rGgxQhwKhGZZ14Fjpv36lox
         Oef+uDD/+cbE1sNGKZw8BsJ5tfh851wYAYI3AZqfS/bruEXwy4gQl9VDQ//WAiMIpmZv
         MYMFvwXMdyX/z7cy4abpu6fKTe/PAz0QwsoCGyzn18BWFHJDylwpb83/k1p0v8NRU5ym
         cC2w==
X-Gm-Message-State: ALoCoQlN+zq7dc6648L7JGlM+DVnRkcsaJAfYogujQvjcb4MzZh1jBNEd76fzMeo5bWwHyE879Q0BlLIFjq2Js7zw0qxvSkuBhNsQc2DlJvqKekRA/tCQTJXBPDkzyzDL6nogO5HueKpZtyAQVoNy5lhxZlVoIc5E8BWnjRy/h3Q17r9l1G/xoY8/8YpK/jCib2YaccG6Joi
X-Received: by 10.236.87.73 with SMTP id x49mr8982184yhe.30.1396303911386;
        Mon, 31 Mar 2014 15:11:51 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si2809114yhb.6.2014.03.31.15.11.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Mar 2014 15:11:51 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 178C031C1DD;
	Mon, 31 Mar 2014 15:11:51 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id BB2121A08FA; Mon, 31 Mar 2014 15:11:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245551>

Signed-off-by: Justin Lebar <jlebar@google.com>
---
 Documentation/CodingGuidelines                      |  4 ++--
 Documentation/config.txt                            |  6 +++---
 Documentation/diff-generate-patch.txt               |  2 +-
 Documentation/diff-options.txt                      |  2 +-
 Documentation/everyday.txt                          |  2 +-
 Documentation/git-add.txt                           |  4 ++--
 Documentation/git-count-objects.txt                 |  4 ++--
 Documentation/git-diff.txt                          |  4 ++--
 Documentation/git-prune.txt                         |  2 +-
 Documentation/git-push.txt                          |  2 +-
 Documentation/git-read-tree.txt                     |  2 +-
 Documentation/git-reset.txt                         |  6 +++---
 Documentation/git-show-branch.txt                   |  2 +-
 Documentation/git-show-ref.txt                      |  2 +-
 Documentation/howto/rebase-from-internal-branch.txt |  2 +-
 Documentation/howto/revert-a-faulty-merge.txt       |  4 ++--
 Documentation/howto/revert-branch-rebase.txt        |  2 +-
 Documentation/merge-options.txt                     | 15 +++++++--------
 Documentation/pretty-formats.txt                    |  2 +-
 Documentation/pretty-options.txt                    |  2 +-
 Documentation/rev-list-options.txt                  |  2 +-
 Documentation/technical/api-gitattributes.txt       |  2 +-
 Documentation/technical/pack-protocol.txt           |  8 ++++----
 Documentation/technical/protocol-common.txt         |  2 +-
 Documentation/user-manual.txt                       |  2 +-
 25 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index ef67b53..b99fa87 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -91,13 +91,13 @@ For shell scripts specifically (not exhaustive):
    E.g.: my_function () {
 
  - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
-   [::], [==], nor [..]) for portability.
+   [::], [==], or [..]) for portability.
 
    - We do not use \{m,n\};
 
    - We do not use -E;
 
-   - We do not use ? nor + (which are \{0,1\} and \{1,\}
+   - We do not use ? or + (which are \{0,1\} and \{1,\}
      respectively in BRE) but that goes without saying as these
      are ERE elements not BRE (note that \? and \+ are not even part
      of BRE -- making them accessible from BRE is a GNU extension).
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..c26a7c8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -78,8 +78,8 @@ be escaped: use `\"` for `"` and `\\` for `\`.
 
 The following escape sequences (beside `\"` and `\\`) are recognized:
 `\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
-and `\b` for backspace (BS).  No other char escape sequence, nor octal
-char sequences are valid.
+and `\b` for backspace (BS).  Other char escape sequences (including octal
+escape sequences) are invalid.
 
 Variable values ending in a `\` are continued on the next line in the
 customary UNIX fashion.
@@ -827,7 +827,7 @@ color.diff::
 	commands will only use color when output is to the terminal.
 	Defaults to false.
 +
-This does not affect linkgit:git-format-patch[1] nor the
+This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 55f499a..843a20b 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -174,7 +174,7 @@ added, from the point of view of that parent).
 In the above example output, the function signature was changed
 from both files (hence two `-` removals from both file1 and
 file2, plus `++` to mean one line that was added does not appear
-in either file1 nor file2).  Also eight other lines are the same
+in either file1 or file2).  Also eight other lines are the same
 from file1 but do not appear in file2 (hence prefixed with `+`).
 
 When shown by `git diff-tree -c`, it compares the parents of a
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9b37b2a..6cb083a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -358,7 +358,7 @@ endif::git-log[]
 --irreversible-delete::
 	Omit the preimage for deletes, i.e. print only the header but not
 	the diff between the preimage and `/dev/null`. The resulting patch
-	is not meant to be applied with `patch` nor `git apply`; this is
+	is not meant to be applied with `patch` or `git apply`; this is
 	solely for people who want to just concentrate on reviewing the
 	text after the change. In addition, the output obviously lack
 	enough information to apply such a patch in reverse, even manually,
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 2a18c1f..b2548ef 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -263,7 +263,7 @@ that are not quite ready.
 <5> create topic branch as needed and apply, again with my
 sign-offs.
 <6> rebase internal topic branch that has not been merged to the
-master, nor exposed as a part of a stable branch.
+master or exposed as a part of a stable branch.
 <7> restart `pu` every time from the next.
 <8> and bundle topic branches still cooking.
 <9> backport a critical fix.
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 48754cb..f3ab374 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -296,9 +296,9 @@ patch::
 
        y - stage this hunk
        n - do not stage this hunk
-       q - quit; do not stage this hunk nor any of the remaining ones
+       q - quit; do not stage this hunk or any of the remaining ones
        a - stage this hunk and all later hunks in the file
-       d - do not stage this hunk nor any of the later hunks in the file
+       d - do not stage this hunk or any of the later hunks in the file
        g - select a hunk to go to
        / - search for a hunk matching the given regex
        j - leave this hunk undecided, see next undecided hunk
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index b300e84..2ff3568 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -33,8 +33,8 @@ size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
 +
-garbage: the number of files in object database that are not valid
-loose objects nor valid packs
+garbage: the number of files in object database that are neither valid loose
+objects nor valid packs
 +
 size-garbage: disk space consumed by garbage files, in KiB (unless -H is
 specified)
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 56fb7e5..bbab35f 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -158,8 +158,8 @@ $ git diff --name-status                <2>
 $ git diff arch/i386 include/asm-i386   <3>
 ------------
 +
-<1> Show only modification, rename and copy, but not addition
-nor deletion.
+<1> Show only modification, rename, and copy, but not addition
+or deletion.
 <2> Show only names and the nature of change, but not actual
 diff output.
 <3> Limit diff output to named subtrees.
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 058ac0d..7a493c8 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -56,7 +56,7 @@ OPTIONS
 EXAMPLE
 -------
 
-To prune objects not used by your repository nor another that
+To prune objects not used by your repository or another that
 borrows from your repository via its
 `.git/objects/info/alternates`:
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2b7f4f9..d0b9e2f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -385,7 +385,7 @@ will now start building on top of B.
 The command by default does not allow an update that is not a fast-forward
 to prevent such loss of history.
 
-If you do not want to lose your work (history from X to B) nor the work by
+If you do not want to lose your work (history from X to B) or the work by
 the other person (history from X to A), you would need to first fetch the
 history from the repository, create a history that contains changes done
 by both parties, and push the result back.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index c4bde65..056c0db 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -57,7 +57,7 @@ OPTIONS
 -n::
 --dry-run::
 	Check if the command would error out, without updating the index
-	nor the files in the working tree for real.
+	or the files in the working tree for real.
 
 -v::
 	Show the progress of checking files out.
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f445cb3..24bf4d5 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -21,7 +21,7 @@ to HEAD in all forms.
 
 'git reset' [-q] [<tree-ish>] [--] <paths>...::
 	This form resets the index entries for all <paths> to their
-	state at <tree-ish>.  (It does not affect the working tree, nor
+	state at <tree-ish>.  (It does not affect the working tree or
 	the current branch.)
 +
 This means that `git reset <paths>` is the opposite of `git add
@@ -51,7 +51,7 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 --
 --soft::
-	Does not touch the index file nor the working tree at all (but
+	Does not touch the index file or the working tree at all (but
 	resets the head to <commit>, just like all modes do). This leaves
 	all your changed files "Changes to be committed", as 'git status'
 	would put it.
@@ -115,7 +115,7 @@ and changes with these files are distracting.
 <2> Somebody asks you to pull, and the changes sounds worthy of merging.
 <3> However, you already dirtied the index (i.e. your index does
 not match the HEAD commit).  But you know the pull you are going
-to make does not affect frotz.c nor filfre.c, so you revert the
+to make does not affect frotz.c or filfre.c, so you revert the
 index changes for these two files.  Your changes in working tree
 remain there.
 <4> Then you can pull and merge, leaving frotz.c and filfre.c
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index a515648..b91d4e5 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -25,7 +25,7 @@ and/or refs/tags) semi-visually.
 It cannot show more than 29 branches and commits at a time.
 
 It uses `showbranch.default` multi-valued configuration items if
-no <rev> nor <glob> is given on the command line.
+no <rev> or <glob> is given on the command line.
 
 
 OPTIONS
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ffd1b03..2a6f89b 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -89,7 +89,7 @@ OPTIONS
 	Show references matching one or more patterns. Patterns are matched from
 	the end of the full name, and only complete parts are matched, e.g.
 	'master' matches 'refs/heads/master', 'refs/remotes/origin/master',
-	'refs/tags/jedi/master' but not 'refs/heads/mymaster' nor
+	'refs/tags/jedi/master' but not 'refs/heads/mymaster' or
 	'refs/remotes/master/jedi'.
 
 OUTPUT
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
index 19ab604..02cb5f7 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -139,7 +139,7 @@ You fetch from upstream, but not merge.
     $ git fetch upstream
 
 This leaves the updated upstream head in .git/FETCH_HEAD but
-does not touch your .git/HEAD nor .git/refs/heads/master.
+does not touch your .git/HEAD or .git/refs/heads/master.
 You run "git rebase" now.
 
     $ git rebase FETCH_HEAD master
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index acf3e47..462255e 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -54,7 +54,7 @@ where C and D are to fix what was broken in A and B, and you may already
 have some other changes on the mainline after W.
 
 If you merge the updated side branch (with D at its tip), none of the
-changes made in A nor B will be in the result, because they were reverted
+changes made in A or B will be in the result, because they were reverted
 by W.  That is what Alan saw.
 
 Linus explains the situation:
@@ -90,7 +90,7 @@ with:
     $ git revert W
 
 This history would (ignoring possible conflicts between what W and W..Y
-changed) be equivalent to not having W nor Y at all in the history:
+changed) be equivalent to not having W or Y at all in the history:
 
  ---o---o---o---M---x---x-------x----
 	       /
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
index 85f69db..149508e 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -137,7 +137,7 @@ $ make clean test ;# make sure it did not cause other breakage.
 ------------------------------------------------
 
 Everything is in the good order.  I do not need the temporary branch
-nor tag anymore, so remove them:
+or tag anymore, so remove them:
 
 ------------------------------------------------
 $ rm -f .git/refs/tags/pu-anchor
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index e134315..f08e9b8 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -63,14 +63,13 @@ merge.
 
 --squash::
 --no-squash::
-	Produce the working tree and index state as if a real
-	merge happened (except for the merge information),
-	but do not actually make a commit or
-	move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
-	cause the next `git commit` command to create a merge
-	commit.  This allows you to create a single commit on
-	top of the current branch whose effect is the same as
-	merging another branch (or more in case of an octopus).
+	Produce the working tree and index state as if a real merge
+	happened (except for the merge information), but do not actually
+	make a commit, move the `HEAD`, or record `$GIT_DIR/MERGE_HEAD`
+	(to cause the next `git commit` command to create a merge
+	commit).  This allows you to create a single commit on top of
+	the current branch whose effect is the same as merging another
+	branch (or more in case of an octopus).
 +
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1d174fd..85d6353 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -78,7 +78,7 @@ The 'raw' format shows the entire commit exactly as
 stored in the commit object.  Notably, the SHA-1s are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
-true parent commits, without taking grafts nor history
+true parent commits, without taking grafts or history
 simplification into account.
 
 * 'format:<string>'
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index eea0e30..8569e29 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -39,7 +39,7 @@ people using 80-column terminals.
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
 	for `git log`, `git show` and `git whatchanged` commands when
-	there is no `--pretty`, `--format` nor `--oneline` option given
+	there is no `--pretty`, `--format`, or `--oneline` option given
 	on the command line.
 +
 By default, the notes shown are from the notes refs listed in the
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 03533af..47c8dcc 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -237,7 +237,7 @@ list.
 	reflog entries from the most recent one to older ones.
 	When this option is used you cannot specify commits to
 	exclude (that is, '{caret}commit', 'commit1..commit2',
-	nor 'commit1\...commit2' notations cannot be used).
+	and 'commit1\...commit2' notations cannot be used).
 +
 With `--pretty` format other than `oneline` (for obvious reasons),
 this causes the output to have two extra lines of information
diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index ce363b6..2602668 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -99,7 +99,7 @@ static void setup_check(void)
 		The attribute is Unset, by listing the name of the
 		attribute prefixed with a dash - for the path.
 	} else if (ATTR_UNSET(value)) {
-		The attribute is not set nor unset for the path.
+		The attribute is neither set nor unset for the path.
 	} else if (!strcmp(value, "input")) {
 		If none of ATTR_TRUE(), ATTR_FALSE(), or ATTR_UNSET() is
 		true, the value is a string set in the gitattributes
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 39c6410..18dea8d 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -237,10 +237,10 @@ The client now sends the maximum commit history depth it wants for
 this transaction, which is the number of commits it wants from the
 tip of the history, if any, as a 'deepen' line.  A depth of 0 is the
 same as not making a depth request. The client does not want to receive
-any commits beyond this depth, nor objects needed only to complete
-those commits. Commits whose parents are not received as a result are
-defined as shallow and marked as such in the server. This information
-is sent back to the client in the next step.
+any commits beyond this depth, nor does it want objects needed only to
+complete those commits. Commits whose parents are not received as a
+result are defined as shallow and marked as such in the server. This
+information is sent back to the client in the next step.
 
 Once all the 'want's and 'shallow's (and optional 'deepen') are
 transferred, clients MUST send a flush-pkt, to tell the server side
diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
index fb7ff08..889985f 100644
--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/technical/protocol-common.txt
@@ -39,7 +39,7 @@ More specifically, they:
   caret `^`, colon `:`, question-mark `?`, asterisk `*`,
   or open bracket `[` anywhere.
 
-. They cannot end with a slash `/` nor a dot `.`.
+. They cannot end with a slash `/` or a dot `.`.
 
 . They cannot end with the sequence `.lock`.
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d4f9804..022e74e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4074,7 +4074,7 @@ the `HEAD` tree, and stage 3 to the `$target` tree.
 
 Earlier we said that trivial merges are done inside
 `git read-tree -m`.  For example, if the file did not change
-from `$orig` to `HEAD` nor `$target`, or if the file changed
+from `$orig` to `HEAD` or `$target`, or if the file changed
 from `$orig` to `HEAD` and `$orig` to `$target` the same way,
 obviously the final outcome is what is in `HEAD`.  What the
 above example shows is that file `hello.c` was changed from
-- 
1.9.1.423.g4596e3a
