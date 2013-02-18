From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 5/9] user-manual: Standardize backtick quoting
Date: Sun, 17 Feb 2013 19:15:57 -0500
Message-ID: <4f89fdc5b3c11868614ce5ac9f8aa0fbd9c00ba4.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EQ8-0000ml-Nc
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756889Ab3BRAQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:38 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:44899 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788Ab3BRAQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:30 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE00JD33EW0G80@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:10 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id D3C4D885663; Sun,
 17 Feb 2013 19:16:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146567; bh=i5exG2sHayW+aYeUabK4LATsEXi3smAs1L43jINmGxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=U5kIf+bq6Ps2/6LNb2JORAGg/xoWrsUysZWcrN/3LB7DR9MqjtJZEjpGAM57XMcYU
 8vMIwgUtbY2GH2Ja3M3EmYUsgMs3lxBXj4AEAQaJIlV5YMBDBqFMfOlx1tqkwCXvqc
 eXdNkVYZekBzA+AhnPa1tglCJPOG61yiom1v1b9E=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216419>

From: "W. Trevor King" <wking@tremily.us>

I tried to always use backticks for:
* Paths and filenames (e.g. `.git/config`)
* Compound refs (e.g. `origin/HEAD`)
* Git commands (e.g. `git log`)
* Command arguments (e.g. `--pretty`)
* URLs (e.g. `git://`), as a subset of command arguments
* Special characters (e.g. `+` in diffs).
* Config options (e.g. `branch.<name>.remote`)

Branch and tag names are sometimes set off with double quotes,
sometimes set off with backticks, and sometimes left bare.  I tried to
judge when the intention was introducing new terms or conventions
(double quotes), to reference a recently used command argument
(backticks), or to reference the abstract branch/commit (left bare).
Obviously these are not particularly crisp definitions, so my
decisions are fairly arbitrary ;).  When a reference had already been
introduced, I changed further double-quoted instances to backticked
instances.

When new backticks increased the length of a line beyond others in
that block, I re-wrapped blocks to 72 columns.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 288 +++++++++++++++++++++---------------------
 1 file changed, 145 insertions(+), 143 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 91f1822..a79b3e31 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -19,7 +19,7 @@ Further chapters cover more specialized topics.
 
 Comprehensive reference documentation is available through the man
 pages, or linkgit:git-help[1] command.  For example, for the command
-"git clone <repo>", you can either use:
+`git clone <repo>`, you can either use:
 
 ------------------------------------------------
 $ man git-clone
@@ -66,11 +66,11 @@ $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 The initial clone may be time-consuming for a large project, but you
 will only need to clone once.
 
-The clone command creates a new directory named after the project ("git"
-or "linux-2.6" in the examples above).  After you cd into this
+The clone command creates a new directory named after the project (`git`
+or `linux-2.6` in the examples above).  After you cd into this
 directory, you will see that it contains a copy of the project files,
 called the <<def_working_tree,working tree>>, together with a special
-top-level directory named ".git", which contains all the information
+top-level directory named `.git`, which contains all the information
 about the history of the project.
 
 [[how-to-check-out]]
@@ -188,7 +188,7 @@ As you can see, a commit shows who made the latest change, what they
 did, and why.
 
 Every commit has a 40-hexdigit id, sometimes called the "object name" or the
-"SHA-1 id", shown on the first line of the "git show" output.  You can usually
+"SHA-1 id", shown on the first line of the `git show` output.  You can usually
 refer to a commit by a shorter name, such as a tag or a branch name, but this
 longer name can also be useful.  Most importantly, it is a globally unique
 name for this commit: so if you tell somebody else the object name (for
@@ -268,35 +268,35 @@ Manipulating branches
 Creating, deleting, and modifying branches is quick and easy; here's
 a summary of the commands:
 
-git branch::
+`git branch`::
 	list all branches
-git branch <branch>::
-	create a new branch named <branch>, referencing the same
+`git branch <branch>`::
+	create a new branch named `<branch>`, referencing the same
 	point in history as the current branch
-git branch <branch> <start-point>::
-	create a new branch named <branch>, referencing
-	<start-point>, which may be specified any way you like,
+`git branch <branch> <start-point>`::
+	create a new branch named `<branch>`, referencing
+	`<start-point>`, which may be specified any way you like,
 	including using a branch name or a tag name
-git branch -d <branch>::
-	delete the branch <branch>; if the branch you are deleting
+`git branch -d <branch>`::
+	delete the branch `<branch>`; if the branch you are deleting
 	points to a commit which is not reachable from the current
 	branch, this command will fail with a warning.
-git branch -D <branch>::
+`git branch -D <branch>`::
 	even if the branch points to a commit not reachable
 	from the current branch, you may know that that commit
 	is still reachable from some other branch or tag.  In that
 	case it is safe to use this command to force Git to delete
 	the branch.
-git checkout <branch>::
-	make the current branch <branch>, updating the working
-	directory to reflect the version referenced by <branch>
-git checkout -b <new> <start-point>::
-	create a new branch <new> referencing <start-point>, and
+`git checkout <branch>`::
+	make the current branch `<branch>`, updating the working
+	directory to reflect the version referenced by `<branch>`
+`git checkout -b <new> <start-point>`::
+	create a new branch `<new>` referencing `<start-point>`, and
 	check it out.
 
 The special symbol "HEAD" can always be used to refer to the current
-branch.  In fact, Git uses a file named "HEAD" in the .git directory to
-remember which branch is current:
+branch.  In fact, Git uses a file named `HEAD` in the `.git` directory
+to remember which branch is current:
 
 ------------------------------------------------
 $ cat .git/HEAD
@@ -346,7 +346,7 @@ of the HEAD in the repository that you cloned from.  That repository
 may also have had other branches, though, and your local repository
 keeps branches which track each of those remote branches, called
 remote-tracking branches, which you
-can view using the "-r" option to linkgit:git-branch[1]:
+can view using the `-r` option to linkgit:git-branch[1]:
 
 ------------------------------------------------
 $ git branch -r
@@ -364,7 +364,7 @@ In this example, "origin" is called a remote repository, or "remote"
 for short. The branches of this repository are called "remote
 branches" from our point of view. The remote-tracking branches listed
 above were created based on the remote branches at clone time and will
-be updated by "git fetch" (hence "git pull") and "git push". See
+be updated by `git fetch` (hence `git pull`) and `git push`. See
 <<Updating-a-repository-With-git-fetch>> for details.
 
 You might want to build on one of these remote-tracking branches
@@ -374,7 +374,7 @@ on a branch of your own, just as you would for a tag:
 $ git checkout -b my-todo-copy origin/todo
 ------------------------------------------------
 
-You can also check out "origin/todo" directly to examine it or
+You can also check out `origin/todo` directly to examine it or
 write a one-off patch.  See <<detached-head,detached head>>.
 
 Note that the name "origin" is just the name that Git uses by default
@@ -386,17 +386,17 @@ Naming branches, tags, and other references
 
 Branches, remote-tracking branches, and tags are all references to
 commits.  All references are named with a slash-separated path name
-starting with "refs"; the names we've been using so far are actually
+starting with `refs`; the names we've been using so far are actually
 shorthand:
 
-	- The branch "test" is short for "refs/heads/test".
-	- The tag "v2.6.18" is short for "refs/tags/v2.6.18".
-	- "origin/master" is short for "refs/remotes/origin/master".
+	- The branch `test` is short for `refs/heads/test`.
+	- The tag `v2.6.18` is short for `refs/tags/v2.6.18`.
+	- `origin/master` is short for `refs/remotes/origin/master`.
 
 The full name is occasionally useful if, for example, there ever
 exists a tag and a branch with the same name.
 
-(Newly created refs are actually stored in the .git/refs directory,
+(Newly created refs are actually stored in the `.git/refs` directory,
 under the path given by their name.  However, for efficiency reasons
 they may also be packed together in a single file; see
 linkgit:git-pack-refs[1]).
@@ -418,7 +418,7 @@ Eventually the developer cloned from will do additional work in her
 repository, creating new commits and advancing the branches to point
 at the new commits.
 
-The command "git fetch", with no arguments, will update all of the
+The command `git fetch`, with no arguments, will update all of the
 remote-tracking branches to the latest version found in her
 repository.  It will not touch any of your own branches--not even the
 "master" branch that was created for you on clone.
@@ -438,7 +438,7 @@ $ git fetch linux-nfs
 -------------------------------------------------
 
 New remote-tracking branches will be stored under the shorthand name
-that you gave "git remote add", in this case linux-nfs:
+that you gave `git remote add`, in this case `linux-nfs`:
 
 -------------------------------------------------
 $ git branch -r
@@ -446,10 +446,10 @@ linux-nfs/master
 origin/master
 -------------------------------------------------
 
-If you run "git fetch <remote>" later, the remote-tracking branches for the
-named <remote> will be updated.
+If you run `git fetch <remote>` later, the remote-tracking branches
+for the named `<remote>` will be updated.
 
-If you examine the file .git/config, you will see that Git has added
+If you examine the file `.git/config`, you will see that Git has added
 a new stanza:
 
 -------------------------------------------------
@@ -462,7 +462,7 @@ $ cat .git/config
 -------------------------------------------------
 
 This is what causes Git to track the remote's branches; you may modify
-or delete these configuration options by editing .git/config with a
+or delete these configuration options by editing `.git/config` with a
 text editor.  (See the "CONFIGURATION FILE" section of
 linkgit:git-config[1] for details.)
 
@@ -499,7 +499,7 @@ Bisecting: 3537 revisions left to test after this
 [65934a9a028b88e83e2b0f8b36618fe503349f8e] BLOCK: Make USB storage depend on SCSI rather than selecting it [try #6]
 -------------------------------------------------
 
-If you run "git branch" at this point, you'll see that Git has
+If you run `git branch` at this point, you'll see that Git has
 temporarily moved you in "(no branch)". HEAD is now detached from any
 branch and points directly to a commit (with commit id 65934...) that
 is reachable from "master" but not from v2.6.18. Compile and test it,
@@ -545,11 +545,11 @@ id, and check it out with:
 $ git reset --hard fb47ddb2db...
 -------------------------------------------------
 
-then test, run "bisect good" or "bisect bad" as appropriate, and
+then test, run `bisect good` or `bisect bad` as appropriate, and
 continue.
 
-Instead of "git bisect visualize" and then "git reset --hard
-fb47ddb2db...", you might just want to tell Git that you want to skip
+Instead of `git bisect visualize` and then `git reset --hard
+fb47ddb2db...`, you might just want to tell Git that you want to skip
 the current commit:
 
 -------------------------------------------------
@@ -561,8 +561,8 @@ bad one between some first skipped commits and a later bad commit.
 
 There are also ways to automate the bisecting process if you have a
 test script that can tell a good from a bad commit. See
-linkgit:git-bisect[1] for more information about this and other "git
-bisect" features.
+linkgit:git-bisect[1] for more information about this and other `git
+bisect` features.
 
 [[naming-commits]]
 Naming commits
@@ -591,7 +591,7 @@ $ git show HEAD~4   # the great-great-grandparent
 -------------------------------------------------
 
 Recall that merge commits may have more than one parent; by default,
-^ and ~ follow the first parent listed in the commit, but you can
+`^` and `~` follow the first parent listed in the commit, but you can
 also choose:
 
 -------------------------------------------------
@@ -640,7 +640,7 @@ running
 $ git tag stable-1 1b2e1d63ff
 -------------------------------------------------
 
-You can use stable-1 to refer to the commit 1b2e1d63ff.
+You can use `stable-1` to refer to the commit 1b2e1d63ff.
 
 This creates a "lightweight" tag.  If you would also like to include a
 comment with the tag, and possibly sign it cryptographically, then you
@@ -669,7 +669,7 @@ $ git log -S'foo()'	# commits which add or remove any file data
 -------------------------------------------------
 
 And of course you can combine all of these; the following finds
-commits since v2.5 which touch the Makefile or any file under fs:
+commits since v2.5 which touch the `Makefile` or any file under `fs`:
 
 -------------------------------------------------
 $ git log v2.5.. Makefile fs/
@@ -681,7 +681,7 @@ You can also ask git log to show patches:
 $ git log -p
 -------------------------------------------------
 
-See the "--pretty" option in the linkgit:git-log[1] man page for more
+See the `--pretty` option in the linkgit:git-log[1] man page for more
 display options.
 
 Note that git log starts with the most recent commit and works
@@ -742,8 +742,8 @@ Examples
 Counting the number of commits on a branch
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Suppose you want to know how many commits you've made on "mybranch"
-since it diverged from "origin":
+Suppose you want to know how many commits you've made on `mybranch`
+since it diverged from `origin`:
 
 -------------------------------------------------
 $ git log --pretty=oneline origin..mybranch | wc -l
@@ -780,7 +780,7 @@ $ git rev-list master
 e05db0fd4f31dde7005f075a84f96b360d05984b
 -------------------------------------------------
 
-Or you could recall that the ... operator selects all commits
+Or you could recall that the `...` operator selects all commits
 contained reachable from either one reference or the other but not
 both: so
 
@@ -880,7 +880,7 @@ Showing commits unique to a given branch
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Suppose you would like to see all the commits reachable from the branch
-head named "master" but not from any other head in your repository.
+head named `master` but not from any other head in your repository.
 
 We can list all the heads in this repository with
 linkgit:git-show-ref[1]:
@@ -894,7 +894,7 @@ a07157ac624b2524a059a3414e99f6f44bebc1e7 refs/heads/master
 1e87486ae06626c2f31eaa63d26fc0fd646c8af2 refs/heads/tutorial-fixes
 -------------------------------------------------
 
-We can get just the branch-head names, and remove "master", with
+We can get just the branch-head names, and remove `master`, with
 the help of the standard utilities cut and grep:
 
 -------------------------------------------------
@@ -935,7 +935,7 @@ $ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
 -------------------------------------------------
 
 will use HEAD to produce a tar archive in which each filename is
-preceded by "project/".
+preceded by `project/`.
 
 If you're releasing a new version of a software project, you may want
 to simultaneously make a changelog to include in the release
@@ -993,7 +993,7 @@ Telling Git your name
 
 Before creating any commits, you should introduce yourself to Git.  The
 easiest way to do so is to make sure the following lines appear in a
-file named .gitconfig in your home directory:
+file named `.gitconfig` in your home directory:
 
 ------------------------------------------------
 [user]
@@ -1045,7 +1045,7 @@ at step 3, Git maintains a snapshot of the tree's contents in a
 special staging area called "the index."
 
 At the beginning, the content of the index will be identical to
-that of the HEAD.  The command "git diff --cached", which shows
+that of the HEAD.  The command `git diff --cached`, which shows
 the difference between the HEAD and the index, should therefore
 produce no output at that point.
 
@@ -1084,7 +1084,7 @@ $ git diff
 
 shows the difference between the working tree and the index file.
 
-Note that "git add" always adds just the current contents of a file
+Note that `git add` always adds just the current contents of a file
 to the index; further changes to the same file will be ignored unless
 you run `git add` on the file again.
 
@@ -1155,8 +1155,9 @@ annoying to have these untracked files lying around; e.g. they make
 `git add .` practically useless, and they keep showing up in the output of
 `git status`.
 
-You can tell Git to ignore certain files by creating a file called .gitignore
-in the top level of your working directory, with contents such as:
+You can tell Git to ignore certain files by creating a file called
+`.gitignore` in the top level of your working directory, with contents
+such as:
 
 -------------------------------------------------
 # Lines starting with '#' are considered comments.
@@ -1180,10 +1181,10 @@ for other users who clone your repository.
 
 If you wish the exclude patterns to affect only certain repositories
 (instead of every repository for a given project), you may instead put
-them in a file in your repository named .git/info/exclude, or in any file
-specified by the `core.excludesfile` configuration variable.  Some Git
-commands can also take exclude patterns directly on the command line.
-See linkgit:gitignore[5] for the details.
+them in a file in your repository named `.git/info/exclude`, or in any
+file specified by the `core.excludesfile` configuration variable.
+Some Git commands can also take exclude patterns directly on the
+command line.  See linkgit:gitignore[5] for the details.
 
 [[how-to-merge]]
 How to merge
@@ -1196,10 +1197,10 @@ linkgit:git-merge[1]:
 $ git merge branchname
 -------------------------------------------------
 
-merges the development in the branch "branchname" into the current
+merges the development in the branch `branchname` into the current
 branch.
 
-A merge is made by combining the changes made in "branchname" and the
+A merge is made by combining the changes made in `branchname` and the
 changes made up to the latest commit in your current branch since
 their histories forked. The work tree is overwritten by the result of
 the merge when this combining is done cleanly, or overwritten by a
@@ -1321,7 +1322,7 @@ that part is not conflicting and is not shown.  Same for stage 3).
 
 The diff above shows the differences between the working-tree version of
 file.txt and the stage 2 and stage 3 versions.  So instead of preceding
-each line by a single "+" or "-", it now uses two columns: the first
+each line by a single `+` or `-`, it now uses two columns: the first
 column is used for differences between the first parent and the working
 directory copy, and the second for differences between the second parent
 and the working directory copy.  (See the "COMBINED DIFF FORMAT" section
@@ -1602,7 +1603,7 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 
 You will see informational messages on dangling objects. They are objects
 that still exist in the repository but are no longer referenced by any of
-your branches, and can (and will) be removed after a while with "gc".
+your branches, and can (and will) be removed after a while with `gc`.
 You can run `git fsck --no-dangling` to suppress these messages, and still
 view real errors.
 
@@ -1614,9 +1615,9 @@ Recovering lost changes
 Reflogs
 ^^^^^^^
 
-Say you modify a branch with +linkgit:git-reset[1] \--hard+, and then
-realize that the branch was the only reference you had to that point in
-history.
+Say you modify a branch with <<fixing-mistakes,`git reset --hard`>>,
+and then realize that the branch was the only reference you had to
+that point in history.
 
 Fortunately, Git also keeps a log, called a "reflog", of all the
 previous values of each branch.  So in this case you can still find the
@@ -1627,8 +1628,8 @@ $ git log master@{1}
 -------------------------------------------------
 
 This lists the commits reachable from the previous version of the
-"master" branch head.  This syntax can be used with any Git command
-that accepts a commit, not just with git log.  Some other examples:
+`master` branch head.  This syntax can be used with any Git command
+that accepts a commit, not just with `git log`.  Some other examples:
 
 -------------------------------------------------
 $ git show master@{2}		# See where the branch pointed 2,
@@ -1732,8 +1733,8 @@ one step:
 $ git pull origin master
 -------------------------------------------------
 
-In fact, if you have "master" checked out, then this branch has been
-configured by "git clone" to get changes from the HEAD branch of the
+In fact, if you have `master` checked out, then this branch has been
+configured by `git clone` to get changes from the HEAD branch of the
 origin repository.  So often you can
 accomplish the above with just a simple
 
@@ -1748,11 +1749,11 @@ the current branch.
 More generally, a branch that is created from a remote-tracking branch
 will pull
 by default from that branch.  See the descriptions of the
-branch.<name>.remote and branch.<name>.merge options in
+`branch.<name>.remote` and `branch.<name>.merge` options in
 linkgit:git-config[1], and the discussion of the `--track` option in
 linkgit:git-checkout[1], to learn how to control these defaults.
 
-In addition to saving you keystrokes, "git pull" also helps you by
+In addition to saving you keystrokes, `git pull` also helps you by
 producing a default commit message documenting the branch and
 repository that you pulled from.
 
@@ -1760,7 +1761,7 @@ repository that you pulled from.
 <<fast-forwards,fast-forward>>; instead, your branch will just be
 updated to point to the latest commit from the upstream branch.)
 
-The `git pull` command can also be given "." as the "remote" repository,
+The `git pull` command can also be given `.` as the "remote" repository,
 in which case it just merges in a branch from the current repository; so
 the commands
 
@@ -1785,7 +1786,7 @@ $ git format-patch origin
 -------------------------------------------------
 
 will produce a numbered series of files in the current directory, one
-for each patch in the current branch but not in origin/HEAD.
+for each patch in the current branch but not in `origin/HEAD`.
 
 `git format-patch` can include an initial "cover letter". You can insert
 commentary on individual patches after the three dash line which
@@ -1807,7 +1808,7 @@ Importing patches to a project
 Git also provides a tool called linkgit:git-am[1] (am stands for
 "apply mailbox"), for importing such an emailed series of patches.
 Just save all of the patch-containing messages, in order, into a
-single mailbox file, say "patches.mbox", then run
+single mailbox file, say `patches.mbox`, then run
 
 -------------------------------------------------
 $ git am -3 patches.mbox
@@ -1815,7 +1816,7 @@ $ git am -3 patches.mbox
 
 Git will apply each patch in order; if any conflicts are found, it
 will stop, and you can fix the conflicts as described in
-"<<resolving-a-merge,Resolving a merge>>".  (The "-3" option tells
+"<<resolving-a-merge,Resolving a merge>>".  (The `-3` option tells
 Git to perform a merge; if you would prefer it just to abort and
 leave your tree and index untouched, you may omit that option.)
 
@@ -1891,7 +1892,7 @@ We explain how to do this in the following sections.
 Setting up a public repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Assume your personal repository is in the directory ~/proj.  We
+Assume your personal repository is in the directory `~/proj`.  We
 first create a new clone of the repository and tell `git daemon` that it
 is meant to be public:
 
@@ -1901,10 +1902,10 @@ $ touch proj.git/git-daemon-export-ok
 -------------------------------------------------
 
 The resulting directory proj.git contains a "bare" git repository--it is
-just the contents of the ".git" directory, without any files checked out
+just the contents of the `.git` directory, without any files checked out
 around it.
 
-Next, copy proj.git to the server where you plan to host the
+Next, copy `proj.git` to the server where you plan to host the
 public repository.  You can use scp, rsync, or whatever is most
 convenient.
 
@@ -1915,8 +1916,8 @@ Exporting a Git repository via the Git protocol
 This is the preferred method.
 
 If someone else administers the server, they should tell you what
-directory to put the repository in, and what git:// URL it will appear
-at.  You can then skip to the section
+directory to put the repository in, and what `git://` URL it will
+appear at.  You can then skip to the section
 "<<pushing-changes-to-a-public-repository,Pushing changes to a public
 repository>>", below.
 
@@ -1951,7 +1952,7 @@ $ mv hooks/post-update.sample hooks/post-update
 (For an explanation of the last two lines, see
 linkgit:git-update-server-info[1] and linkgit:githooks[5].)
 
-Advertise the URL of proj.git.  Anybody else should then be able to
+Advertise the URL of `proj.git`.  Anybody else should then be able to
 clone or pull from that URL, for example with a command line like:
 
 -------------------------------------------------
@@ -1974,8 +1975,8 @@ access, which you will need to update the public repository with the
 latest changes created in your private repository.
 
 The simplest way to do this is using linkgit:git-push[1] and ssh; to
-update the remote branch named "master" with the latest state of your
-branch named "master", run
+update the remote branch named `master` with the latest state of your
+branch named `master`, run
 
 -------------------------------------------------
 $ git push ssh://yourserver.com/~you/proj.git master:master
@@ -1991,7 +1992,7 @@ As with `git fetch`, `git push` will complain if this does not result in a
 <<fast-forwards,fast-forward>>; see the following section for details on
 handling this case.
 
-Note that the target of a "push" is normally a
+Note that the target of a `push` is normally a
 <<def_bare_repository,bare>> repository.  You can also push to a
 repository that has a checked-out working tree, but the working tree
 will not be updated by the push.  This may lead to unexpected results if
@@ -2018,9 +2019,9 @@ which lets you do the same push with just
 $ git push public-repo master
 -------------------------------------------------
 
-See the explanations of the remote.<name>.url, branch.<name>.remote,
-and remote.<name>.push options in linkgit:git-config[1] for
-details.
+See the explanations of the `remote.<name>.url`,
+`branch.<name>.remote`, and `remote.<name>.push` options in
+linkgit:git-config[1] for details.
 
 [[forcing-push]]
 What to do when a push fails
@@ -2155,7 +2156,7 @@ linkgit:git-fetch[1] to keep them up-to-date; see
 
 Now create the branches in which you are going to work; these start out
 at the current tip of origin/master branch, and should be set up (using
-the --track option to linkgit:git-branch[1]) to merge changes in from
+the `--track` option to linkgit:git-branch[1]) to merge changes in from
 Linus by default.
 
 -------------------------------------------------
@@ -2174,7 +2175,7 @@ Important note!  If you have any local changes in these branches, then
 this merge will create a commit object in the history (with no local
 changes Git will simply do a "fast-forward" merge).  Many people dislike
 the "noise" that this creates in the Linux history, so you should avoid
-doing this capriciously in the "release" branch, as these noisy commits
+doing this capriciously in the `release` branch, as these noisy commits
 will become part of the permanent history when you ask Linus to pull
 from the release branch.
 
@@ -2216,7 +2217,7 @@ patches), and create a new branch from a recent stable tag of
 Linus's branch. Picking a stable base for your branch will:
 1) help you: by avoiding inclusion of unrelated and perhaps lightly
 tested changes
-2) help future bug hunters that use "git bisect" to find problems
+2) help future bug hunters that use `git bisect` to find problems
 
 -------------------------------------------------
 $ git checkout -b speed-up-spinlocks v2.6.35
@@ -2241,9 +2242,9 @@ It is unlikely that you would have any conflicts here ... but you might if you
 spent a while on this step and had also pulled new versions from upstream.
 
 Some time later when enough time has passed and testing done, you can pull the
-same branch into the "release" tree ready to go upstream.  This is where you
+same branch into the `release` tree ready to go upstream.  This is where you
 see the value of keeping each patch (or patch series) in its own branch.  It
-means that the patches can be moved into the "release" tree in any order.
+means that the patches can be moved into the `release` tree in any order.
 
 -------------------------------------------------
 $ git checkout release && git pull . speed-up-spinlocks
@@ -2276,7 +2277,7 @@ If it has been merged, then there will be no output.)
 
 Once a patch completes the great cycle (moving from test to release,
 then pulled by Linus, and finally coming back into your local
-"origin/master" branch), the branch for this change is no longer needed.
+`origin/master` branch), the branch for this change is no longer needed.
 You detect this when the output from:
 
 -------------------------------------------------
@@ -2291,8 +2292,8 @@ $ git branch -d branchname
 
 Some changes are so trivial that it is not necessary to create a separate
 branch and then merge into each of the test and release branches.  For
-these changes, just apply directly to the "release" branch, and then
-merge that into the "test" branch.
+these changes, just apply directly to the `release` branch, and then
+merge that into the `test` branch.
 
 To create diffstat and shortlog summaries of changes to include in a "please
 pull" request to Linus you can use:
@@ -2467,8 +2468,8 @@ you are rewriting history.
 Keeping a patch series up to date using git rebase
 --------------------------------------------------
 
-Suppose that you create a branch "mywork" on a remote-tracking branch
-"origin", and create some commits on top of it:
+Suppose that you create a branch `mywork` on a remote-tracking branch
+`origin`, and create some commits on top of it:
 
 -------------------------------------------------
 $ git checkout -b mywork origin
@@ -2480,7 +2481,7 @@ $ git commit
 -------------------------------------------------
 
 You have performed no merges into mywork, so it is just a simple linear
-sequence of patches on top of "origin":
+sequence of patches on top of `origin`:
 
 ................................................
  o--o--O <-- origin
@@ -2489,7 +2490,7 @@ sequence of patches on top of "origin":
 ................................................
 
 Some more interesting work has been done in the upstream project, and
-"origin" has advanced:
+`origin` has advanced:
 
 ................................................
  o--o--O--o--o--o <-- origin
@@ -2497,7 +2498,7 @@ Some more interesting work has been done in the upstream project, and
          a--b--c <-- mywork
 ................................................
 
-At this point, you could use "pull" to merge your changes back in;
+At this point, you could use `pull` to merge your changes back in;
 the result would create a new merge commit, like this:
 
 ................................................
@@ -2516,7 +2517,7 @@ $ git rebase origin
 -------------------------------------------------
 
 This will remove each of your commits from mywork, temporarily saving
-them as patches (in a directory named ".git/rebase-apply"), update mywork to
+them as patches (in a directory named `.git/rebase-apply`), update mywork to
 point at the latest version of origin, then apply each of the saved
 patches to the new mywork.  The result will look like:
 
@@ -2780,10 +2781,10 @@ arbitrary name:
 $ git fetch origin todo:my-todo-work
 -------------------------------------------------
 
-The first argument, "origin", just tells Git to fetch from the
+The first argument, `origin`, just tells Git to fetch from the
 repository you originally cloned from.  The second argument tells Git
-to fetch the branch named "todo" from the remote repository, and to
-store it locally under the name refs/heads/my-todo-work.
+to fetch the branch named `todo` from the remote repository, and to
+store it locally under the name `refs/heads/my-todo-work`.
 
 You can also fetch branches from other repositories; so
 
@@ -2791,8 +2792,8 @@ You can also fetch branches from other repositories; so
 $ git fetch git://example.com/proj.git master:example-master
 -------------------------------------------------
 
-will create a new branch named "example-master" and store in it the
-branch named "master" from the repository at the given URL.  If you
+will create a new branch named `example-master` and store in it the
+branch named `master` from the repository at the given URL.  If you
 already have a branch named example-master, it will attempt to
 <<fast-forwards,fast-forward>> to the commit given by example.com's
 master branch.  In more detail:
@@ -2801,7 +2802,7 @@ master branch.  In more detail:
 git fetch and fast-forwards
 ---------------------------
 
-In the previous example, when updating an existing branch, "git fetch"
+In the previous example, when updating an existing branch, `git fetch`
 checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
@@ -2827,11 +2828,11 @@ resulting in a situation like:
             o--o--o <-- new head of the branch
 ................................................
 
-In this case, "git fetch" will fail, and print out a warning.
+In this case, `git fetch` will fail, and print out a warning.
 
 In that case, you can still force Git to update to the new head, as
 described in the following section.  However, note that in the
-situation above this may mean losing the commits labeled "a" and "b",
+situation above this may mean losing the commits labeled `a` and `b`,
 unless you've already created a reference of your own pointing to
 them.
 
@@ -2846,7 +2847,7 @@ descendant of the old head, you may force the update with:
 $ git fetch git://example.com/proj.git +master:refs/remotes/example/master
 -------------------------------------------------
 
-Note the addition of the "+" sign.  Alternatively, you can use the "-f"
+Note the addition of the `+` sign.  Alternatively, you can use the `-f`
 flag to force updates of all the fetched branches, as in:
 
 -------------------------------------------------
@@ -2860,7 +2861,7 @@ may be lost, as we saw in the previous section.
 Configuring remote-tracking branches
 ------------------------------------
 
-We saw above that "origin" is just a shortcut to refer to the
+We saw above that `origin` is just a shortcut to refer to the
 repository that you originally cloned from.  This information is
 stored in Git configuration variables, which you can see using
 linkgit:git-config[1]:
@@ -2969,7 +2970,7 @@ Commit Object
 ~~~~~~~~~~~~~
 
 The "commit" object links a physical state of a tree with a description
-of how we got there and why.  Use the --pretty=raw option to
+of how we got there and why.  Use the `--pretty=raw` option to
 linkgit:git-show[1] or linkgit:git-log[1] to examine your favorite
 commit:
 
@@ -3011,7 +3012,7 @@ of the tree referred to by this commit with the trees associated with
 its parents.  In particular, Git does not attempt to record file renames
 explicitly, though it can identify cases where the existence of the same
 file data at changing paths suggests a rename.  (See, for example, the
--M option to linkgit:git-diff[1]).
+`-M` option to linkgit:git-diff[1]).
 
 A commit is usually created by linkgit:git-commit[1], which creates a
 commit whose parent is normally the current HEAD, and whose tree is
@@ -3062,7 +3063,7 @@ Blob Object
 ~~~~~~~~~~~
 
 You can use linkgit:git-show[1] to examine the contents of a blob; take,
-for example, the blob in the entry for "COPYING" from the tree above:
+for example, the blob in the entry for `COPYING` from the tree above:
 
 ------------------------------------------------
 $ git show 6ff87c4664
@@ -3145,14 +3146,14 @@ nLE/L9aUXdWeTFPron96DLA=
 See the linkgit:git-tag[1] command to learn how to create and verify tag
 objects.  (Note that linkgit:git-tag[1] can also be used to create
 "lightweight tags", which are not tag objects at all, but just simple
-references whose names begin with "refs/tags/").
+references whose names begin with `refs/tags/`).
 
 [[pack-files]]
 How Git stores objects efficiently: pack files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Newly created objects are initially created in a file named after the
-object's SHA-1 hash (stored in .git/objects).
+object's SHA-1 hash (stored in `.git/objects`).
 
 Unfortunately this system becomes inefficient once a project has a
 lot of objects.  Try this on an old project:
@@ -3193,9 +3194,9 @@ $ git prune
 
 to remove any of the "loose" objects that are now contained in the
 pack.  This will also remove any unreferenced objects (which may be
-created when, for example, you use "git reset" to remove a commit).
+created when, for example, you use `git reset` to remove a commit).
 You can verify that the loose objects are gone by looking at the
-.git/objects directory or by running
+`.git/objects` directory or by running
 
 ------------------------------------------------
 $ git count-objects
@@ -3222,7 +3223,7 @@ branch still exists, as does everything it pointed to. The branch
 pointer itself just doesn't, since you replaced it with another one.
 
 There are also other situations that cause dangling objects. For
-example, a "dangling blob" may arise because you did a "git add" of a
+example, a "dangling blob" may arise because you did a `git add` of a
 file, but then, before you actually committed it and made it part of the
 bigger picture, you changed something else in that file and committed
 that *updated* thing--the old state that you added originally ends up
@@ -3265,14 +3266,14 @@ $ git show <dangling-blob/tree-sha-goes-here>
 ------------------------------------------------
 
 to show what the contents of the blob were (or, for a tree, basically
-what the "ls" for that directory was), and that may give you some idea
+what the `ls` for that directory was), and that may give you some idea
 of what the operation was that left that dangling object.
 
 Usually, dangling blobs and trees aren't very interesting. They're
 almost always the result of either being a half-way mergebase (the blob
 will often even have the conflict markers from a merge in it, if you
 have had conflicting merges that you fixed up by hand), or simply
-because you interrupted a "git fetch" with ^C or something like that,
+because you interrupted a `git fetch` with ^C or something like that,
 leaving _some_ of the new objects in the object database, but just
 dangling and useless.
 
@@ -3283,16 +3284,16 @@ state, you can just prune all unreachable objects:
 $ git prune
 ------------------------------------------------
 
-and they'll be gone. But you should only run "git prune" on a quiescent
+and they'll be gone. But you should only run `git prune` on a quiescent
 repository--it's kind of like doing a filesystem fsck recovery: you
 don't want to do that while the filesystem is mounted.
 
-(The same is true of "git fsck" itself, btw, but since
+(The same is true of `git fsck` itself, btw, but since
 `git fsck` never actually *changes* the repository, it just reports
 on what it found, `git fsck` itself is never 'dangerous' to run.
 Running it while somebody is actually changing the repository can cause
 confusing and scary messages, but it won't actually do anything bad. In
-contrast, running "git prune" while somebody is actively changing the
+contrast, running `git prune` while somebody is actively changing the
 repository is a *BAD* idea).
 
 [[recovering-from-repository-corruption]]
@@ -3330,7 +3331,7 @@ missing blob 4b9458b3786228369c63936db65827de3cc06200
 Now you know that blob 4b9458b3 is missing, and that the tree 2d9263c6
 points to it.  If you could find just one copy of that missing blob
 object, possibly in some other repository, you could move it into
-.git/objects/4b/9458b3... and be done.  Suppose you can't.  You can
+`.git/objects/4b/9458b3...` and be done.  Suppose you can't.  You can
 still examine the tree that pointed to it with linkgit:git-ls-tree[1],
 which might output something like:
 
@@ -3345,10 +3346,10 @@ $ git ls-tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
 ------------------------------------------------
 
 So now you know that the missing blob was the data for a file named
-"myfile".  And chances are you can also identify the directory--let's
-say it's in "somedirectory".  If you're lucky the missing copy might be
+`myfile`.  And chances are you can also identify the directory--let's
+say it's in `somedirectory`.  If you're lucky the missing copy might be
 the same as the copy you have checked out in your working tree at
-"somedirectory/myfile"; you can test whether that's right with
+`somedirectory/myfile`; you can test whether that's right with
 linkgit:git-hash-object[1]:
 
 ------------------------------------------------
@@ -3403,7 +3404,7 @@ $ git hash-object -w <recreated-file>
 
 and your repository is good again!
 
-(Btw, you could have ignored the fsck, and started with doing a
+(Btw, you could have ignored the `fsck`, and started with doing a
 
 ------------------------------------------------
 $ git log --raw --all
@@ -3417,7 +3418,7 @@ just missing one particular blob version.
 The index
 -----------
 
-The index is a binary file (generally kept in .git/index) containing a
+The index is a binary file (generally kept in `.git/index`) containing a
 sorted list of path names, each with permissions and the SHA-1 of a blob
 object; linkgit:git-ls-files[1] can show you the contents of the index:
 
@@ -3557,7 +3558,7 @@ $ ls -a
 
 The `git submodule add <repo> <path>` command does a couple of things:
 
-- It clones the submodule from <repo> to the given <path> under the
+- It clones the submodule from `<repo>` to the given `<path>` under the
   current directory and by default checks out the master branch.
 - It adds the submodule's clone path to the linkgit:gitmodules[5] file and
   adds this file to the index, ready to be committed.
@@ -3685,11 +3686,11 @@ Unable to checkout '261dfac35cb99d380eb966e102c1197139f7fa24' in submodule path
 
 In older Git versions it could be easily forgotten to commit new or modified
 files in a submodule, which silently leads to similar problems as not pushing
-the submodule changes. Starting with Git 1.7.0 both "git status" and "git diff"
+the submodule changes. Starting with Git 1.7.0 both `git status` and `git diff`
 in the superproject show submodules as modified when they contain new or
-modified files to protect against accidentally committing such a state. "git
-diff" will also add a "-dirty" to the work tree side when generating patch
-output or used with the --submodule option:
+modified files to protect against accidentally committing such a state. `git
+diff` will also add a `-dirty` to the work tree side when generating patch
+output or used with the `--submodule` option:
 
 -------------------------------------------------
 $ git diff
@@ -3863,7 +3864,7 @@ or, if you want to check out all of the index, use `-a`.
 
 NOTE! `git checkout-index` normally refuses to overwrite old files, so
 if you have an old version of the tree already checked out, you will
-need to use the "-f" flag ('before' the "-a" flag or the filename) to
+need to use the `-f` flag ('before' the `-a` flag or the filename) to
 'force' the checkout.
 
 
@@ -3874,7 +3875,7 @@ from one representation to the other:
 Tying it all together
 ~~~~~~~~~~~~~~~~~~~~~
 
-To commit a tree you have instantiated with "git write-tree", you'd
+To commit a tree you have instantiated with `git write-tree`, you'd
 create a "commit" object that refers to that tree and the history
 behind it--most notably the "parent" commits that preceded it in
 history.
@@ -4135,8 +4136,9 @@ As a result, the general consistency of an object can always be tested
 independently of the contents or the type of the object: all objects can
 be validated by verifying that (a) their hashes match the content of the
 file and (b) the object successfully inflates to a stream of bytes that
-forms a sequence of <ascii type without space> {plus} <space> {plus} <ascii decimal
-size> {plus} <byte\0> {plus} <binary object data>.
+forms a sequence of
+`<ascii type without space> + <space> + <ascii decimal size> +
+<byte\0> + <binary object data>`.
 
 The structured objects can further have their structure and
 connectivity to other objects verified. This is generally done with
@@ -4615,10 +4617,10 @@ Think about how to create a clear chapter dependency graph that will
 allow people to get to important topics without necessarily reading
 everything in between.
 
-Scan Documentation/ for other stuff left out; in particular:
+Scan `Documentation/` for other stuff left out; in particular:
 
 - howto's
-- some of technical/?
+- some of `technical/`?
 - hooks
 - list of commands in linkgit:git[1]
 
-- 
1.8.1.336.g94702dd
