From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Mon, 15 Sep 2008 11:19:58 +0200
Message-ID: <1221470398-8698-3-git-send-email-trast@student.ethz.ch>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
 <1221470398-8698-2-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 11:21:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfAGt-0006I0-B9
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 11:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYIOJUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 05:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbYIOJUO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 05:20:14 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:47761 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbYIOJUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 05:20:09 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Sep 2008 11:20:03 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Sep 2008 11:20:03 +0200
X-Mailer: git-send-email 1.6.0.2.451.ga9ffc
In-Reply-To: <1221470398-8698-2-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Sep 2008 09:20:03.0235 (UTC) FILETIME=[3C20FF30:01C91714]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95896>

Replaces all ^ and ~ that are not part of a "literal" paragraph with
{caret} and {tilde}.

Tildes and carets are ordinarily used for ~sub~ and ^super^scripts.
This only triggers if a suitable chunk of text is found within the
current paragraph, so in most cases nothing happens (and the
tilde/caret is taken literally).  However, it is a pitfall for anyone
who later adds more text to the same paragraph, so we might as well do
it right.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-bundle.txt           |   10 +++++-----
 Documentation/git-check-ref-format.txt |    4 ++--
 Documentation/git-commit-tree.txt      |    2 +-
 Documentation/git-config.txt           |    6 +++---
 Documentation/git-daemon.txt           |    4 ++--
 Documentation/git-fast-export.txt      |    2 +-
 Documentation/git-fast-import.txt      |    2 +-
 Documentation/git-push.txt             |    2 +-
 Documentation/git-rebase.txt           |    2 +-
 Documentation/git-reset.txt            |    2 +-
 Documentation/git-rev-parse.txt        |    2 +-
 Documentation/git-show-branch.txt      |    2 +-
 Documentation/git-show.txt             |    2 +-
 Documentation/git-tools.txt            |    2 +-
 Documentation/gitcore-tutorial.txt     |    2 +-
 Documentation/gitignore.txt            |    2 +-
 Documentation/rev-list-options.txt     |    2 +-
 Documentation/user-manual.txt          |    8 ++++----
 18 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 1b66ab7..5b255af 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -60,7 +60,7 @@ unbundle <file>::
 [git-rev-list-args...]::
        A list of arguments, acceptable to 'git-rev-parse' and
        'git-rev-list', that specify the specific objects and references
-       to transport.  For example, "master~10..master" causes the
+       to transport.  For example, "master{tilde}10..master" causes the
        current master reference to be packaged along with all objects
        added since its 10th ancestor commit.  There is no explicit
        limit to the number of references and objects that may be
@@ -79,12 +79,12 @@ SPECIFYING REFERENCES
 
 'git-bundle' will only package references that are shown by
 'git-show-ref': this includes heads, tags, and remote heads.  References
-such as master~1 cannot be packaged, but are perfectly suitable for
+such as master{tilde}1 cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g., ^master~10), or implicitly (e.g.,
-master~10..master, master --since=10.days.ago).
+specified explicitly (e.g., {caret}master{tilde}10), or implicitly (e.g.,
+master{tilde}10..master, master --since=10.days.ago).
 
 It is very important that the basis used be held by the destination.
 It is okay to err on the side of conservatism, causing the bundle file
@@ -152,7 +152,7 @@ With something like this in the config in R2:
     fetch = refs/heads/*:refs/remotes/origin/*
 ------------------------
 
-You can first sneakernet the bundle file to ~/tmp/file.bdl and
+You can first sneakernet the bundle file to {tilde}/tmp/file.bdl and
 then these commands on machine B:
 
 ------------
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 034223c..cbc8507 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -26,7 +26,7 @@ imposes the following rules on how refs are named:
 . It cannot have two consecutive dots `..` anywhere;
 
 . It cannot have ASCII control character (i.e. bytes whose
-  values are lower than \040, or \177 `DEL`), space, tilde `~`,
+  values are lower than \040, or \177 `DEL`), space, tilde `{tilde}`,
   caret `{caret}`, colon `:`, question-mark `?`, asterisk `*`,
   or open bracket `[` anywhere;
 
@@ -41,7 +41,7 @@ refname expressions (see linkgit:git-rev-parse[1]).  Namely:
   context this notation means `{caret}ref1 ref2` (i.e. not in
   ref1 and in ref2).
 
-. tilde `~` and caret `{caret}` are used to introduce postfix
+. tilde `{tilde}` and caret `{caret}` are used to introduce postfix
   'nth parent' and 'peel onion' operation.
 
 . colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index b8834ba..351a2d2 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -71,7 +71,7 @@ present, system user name and fully qualified hostname.
 
 A commit comment is read from stdin. If a changelog
 entry is not provided via "<" redirection, 'git-commit-tree' will just wait
-for one to be entered and terminated with ^D.
+for one to be entered and terminated with {caret}D.
 
 
 Diagnostics
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 28e1861..8dc5c28 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -84,10 +84,10 @@ OPTIONS
 	Also outputs the key names.
 
 --global::
-	For writing options: write to global ~/.gitconfig file rather than
+	For writing options: write to global {tilde}/.gitconfig file rather than
 	the repository .git/config.
 +
-For reading options: read only from global ~/.gitconfig rather than
+For reading options: read only from global {tilde}/.gitconfig rather than
 from all available files.
 +
 See also <<FILES>>.
@@ -197,7 +197,7 @@ ENVIRONMENT
 
 GIT_CONFIG::
 	Take the configuration from the given file instead of .git/config.
-	Using the "--global" option forces this to ~/.gitconfig. Using the
+	Using the "--global" option forces this to {tilde}/.gitconfig. Using the
 	"--system" option forces this to $(prefix)/etc/gitconfig.
 
 See also <<FILES>>.
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index b08a08c..5c64647 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -110,9 +110,9 @@ OPTIONS
 
 --user-path::
 --user-path=path::
-	Allow ~user notation to be used in requests.  When
+	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, requests to
-	git://host/~alice/foo is taken as a request to access
+	git://host/{tilde}alice/foo is taken as a request to access
 	'foo' repository in the home directory of user `alice`.
 	If `--user-path=path` is specified, the same request is
 	taken as a request to access `path/foo` repository in
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index b974e21..8f92545 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -83,7 +83,7 @@ $ git fast-export master~5..master |
 	git fast-import
 -----------------------------------------------------
 
-This makes a new branch called 'other' from 'master~5..master'
+This makes a new branch called 'other' from 'master{tilde}5..master'
 (i.e. if 'master' has linear history, it will take the last 5 commits).
 
 Note that this assumes that none of the blobs and commit messages
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..39494e3 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -103,7 +103,7 @@ amount of memory usage and processing time.  Assuming the frontend
 is able to keep up with fast-import and feed it a constant stream of data,
 import times for projects holding 10+ years of history and containing
 100,000+ individual commits are generally completed in just 1-2
-hours on quite modest (~$2,000 USD) hardware.
+hours on quite modest ({tilde}$2,000 USD) hardware.
 
 Most bottlenecks appear to be in foreign source data access (the
 source just cannot extract revisions fast enough) or disk IO (fast-import
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 45c9643..89fbc3d 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -37,7 +37,7 @@ OPTIONS
 	the destination ref.
 +
 The <src> side represents the source branch (or arbitrary
-"SHA1 expression", such as `master~4` (four parents before the
+"SHA1 expression", such as `master{tilde}4` (four parents before the
 tip of `master` branch); see linkgit:git-rev-parse[1]) that you
 want to push.  The <dst> side represents the destination location.
 +
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 59c1b02..9cf9940 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -334,7 +334,7 @@ errors), the loop will stop to let you fix things, and you can continue
 the loop with `git rebase --continue`.
 
 For example, if you want to reorder the last 5 commits, such that what
-was HEAD~4 becomes the new HEAD. To achieve that, you would call
+was HEAD{tilde}4 becomes the new HEAD. To achieve that, you would call
 'git-rebase' like this:
 
 ----------------------
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 6abaeac..c25ff2a 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -80,7 +80,7 @@ $ git commit ...
 $ git reset --hard HEAD~3   <1>
 ------------
 +
-<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
+<1> The last three commits (HEAD, HEAD{caret}, and HEAD{tilde}2) were bad
 and you do not want to ever see them again.  Do *not* do this if
 you have already given these commits to somebody else.
 
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2921da3..823ff52 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -221,7 +221,7 @@ when you run 'git-merge'.
 
 * A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
-  commit object, following only the first parent.  I.e. rev~3 is
+  commit object, following only the first parent.  I.e. rev{tilde}3 is
   equivalent to rev{caret}{caret}{caret} which is equivalent to
   rev{caret}1{caret}1{caret}1.  See below for a illustration of
   the usage of this form.
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index d3f2588..853eec4 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -87,7 +87,7 @@ OPTIONS
 
 --sha1-name::
 	Instead of naming the commits using the path to reach
-	them from heads (e.g. "master~2" to mean the grandparent
+	them from heads (e.g. "master{tilde}2" to mean the grandparent
 	of "master"), name them with the unique prefix of their
 	object names.
 
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 48b612e..2ec3e88 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -54,7 +54,7 @@ git show v1.0.0::
 git show v1.0.0^\{tree\}::
 	Shows the tree pointed to by the tag `v1.0.0`.
 
-git show next~10:Documentation/README::
+git show next{tilde}10:Documentation/README::
 	Shows the contents of the file `Documentation/README` as
 	they were current in the 10th last commit of the branch
 	`next`.
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index a96403c..0592e56 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -100,7 +100,7 @@ Foreign SCM interface
 Others
 ------
 
-   - *(h)gct* (http://www.cyd.liu.se/users/~freku045/gct/)
+   - *(h)gct* (http://www.cyd.liu.se/users/{tilde}freku045/gct/)
 
    Commit Tool or (h)gct is a GUI enabled commit tool for git and
    Mercurial (hg). It allows the user to view diffs, select which files
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index a417e59..1ba1188 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1650,7 +1650,7 @@ independent changes (if the order mattered, then they are not
 independent by definition).  You could instead merge those two
 branches into the current branch at once.  First let's undo what
 we just did and start over.  We would want to get the master
-branch before these two merges by resetting it to 'master~2':
+branch before these two merges by resetting it to 'master{tilde}2':
 
 ------------
 $ git reset --hard master~2
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 59321a2..a10f2e4 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -53,7 +53,7 @@ the repository but are specific to one user's workflow) should go into
 the `$GIT_DIR/info/exclude` file.  Patterns which a user wants git to
 ignore in all situations (e.g., backup or temporary files generated by
 the user's editor of choice) generally go into a file specified by
-`core.excludesfile` in the user's `~/.gitconfig`.
+`core.excludesfile` in the user's `{tilde}/.gitconfig`.
 
 The underlying git plumbing tools, such as
 'git-ls-files' and 'git-read-tree', read
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 0ce916a..c917237 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -535,7 +535,7 @@ These options are mostly targeted for packing of git repositories.
 --objects::
 
 	Print the object IDs of any object referenced by the listed
-	commits.  '--objects foo ^bar' thus means "send me
+	commits.  '--objects foo {caret}bar' thus means "send me
 	all object IDs which I need to download if I have the commit
 	object 'bar', but not 'foo'".
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 08d1310..7e25b69 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -570,7 +570,7 @@ $ git show HEAD~4   # the great-great-grandparent
 -------------------------------------------------
 
 Recall that merge commits may have more than one parent; by default,
-^ and ~ follow the first parent listed in the commit, but you can
+{caret} and {tilde} follow the first parent listed in the commit, but you can
 also choose:
 
 -------------------------------------------------
@@ -1836,7 +1836,7 @@ We explain how to do this in the following sections.
 Setting up a public repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Assume your personal repository is in the directory ~/proj.  We
+Assume your personal repository is in the directory {tilde}/proj.  We
 first create a new clone of the repository and tell git-daemon that it
 is meant to be public:
 
@@ -3200,7 +3200,7 @@ Usually, dangling blobs and trees aren't very interesting. They're
 almost always the result of either being a half-way mergebase (the blob
 will often even have the conflict markers from a merge in it, if you
 have had conflicting merges that you fixed up by hand), or simply
-because you interrupted a "git-fetch" with ^C or something like that,
+because you interrupted a "git-fetch" with {caret}C or something like that,
 leaving _some_ of the new objects in the object database, but just
 dangling and useless.
 
@@ -3991,7 +3991,7 @@ $ git cat-file blob cc44c73... >hello.c~3
 $ git merge-file hello.c~2 hello.c~1 hello.c~3
 ------------------------------------------------
 
-This would leave the merge result in `hello.c~2` file, along
+This would leave the merge result in `hello.c{tilde}2` file, along
 with conflict markers if there are conflicts.  After verifying
 the merge result makes sense, you can tell git what the final
 merge result for this file is by:
-- 
1.6.0.2.451.ga9ffc
