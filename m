From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] user-manual: general quoting improvements (p1)
Date: Sat, 23 Jan 2010 02:18:54 +0200
Message-ID: <1264205935-19203-2-git-send-email-felipe.contreras@gmail.com>
References: <1264205935-19203-1-git-send-email-felipe.contreras@gmail.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:21:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTkO-00005Y-EN
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab0AWAUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597Ab0AWATr
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:19:47 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44817 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568Ab0AWATH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:19:07 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1544233bwz.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nyQ/J8HTz2sofEgVzCtBqc2Qoz10YmT9AkXk/BZbsLk=;
        b=fJDwMSFQwmTffw7JY1RaTG7ZlFMSxkyrAv61E0jtykZWNxjAz19Pf8ChFEBVJvgNdw
         0+yDaeW1yDYqprrzQQz5oWERWIBVWoRLrhJMd5XEACEFVKKu/367CYKRK9wqxfheNG4B
         ZBq2WlIYIVZr6Q0eNfOoFZzmKyOGYiAcwNZzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IFDAM7JH37IFxy3p82/eXxPiwgmS+nw1n+3HjbHyBC3dkR+ewVUTcHd06JodkpaN0R
         wljuaGTrbeNPXQxVx5PX5QAeeWGsM3ogrSd27/QUxdmTMr/OG3z7SD6C1a0WJ1n/9lCz
         uhNXKIgswyF9UKUKTkGtQaqmIclEPCPSHuFrY=
Received: by 10.204.8.202 with SMTP id i10mr1472394bki.133.1264205946143;
        Fri, 22 Jan 2010 16:19:06 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 16sm1238278bwz.15.2010.01.22.16.19.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:19:04 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264205935-19203-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137793>

This standarizes the way quotes are handled following semantic rules,
that make the final text easier to read.

Here are the general rules:

 * A command (something that the user must type), goes in backticks. So
   that the final text appears in monospaced text. e.g. `git clone
   <repo>`

 * A common concept (or git lingo), also goes in backticks. So that it
   appears uniquely different from the rest of the text. e.g. `HEAD`

 * An example (something that can be easily replaced), goes into
   typewriter quotes. The final text is not formatted further, so they
   still appear as typewriter quotes. e.g. "linux-2.6"

 * A text that can be confused with normal text also goes into
   typewriter quotes. e.g. "path/to/file" "A"

 * Text that needs to be emphasized goes in single typewriter quotes. So
   that it's not confused as normal text. e.g. we often just use the
   term 'branch'.

 * Something that needs proper quotation goes into proper double quotes.
   So that it gets a dramatic effect, as in sombody is using his four
   quoting fingers. e.g. ``the index''

 * Something that needs strong emphasis so that the reader can't
   possibly miss it goes enclosed in asterisks. e.g. *not* tracking

These rules are not automatic, which one to use depends on the context,
and often they can be used together. For example, consider this:

	The branch 'test' is short for '"refs/heads/test"'

In this case we want to highligh 'test' and 'refs/heads/test' so they go
in single typewriter quotes, but also, we want to make clear the full
refname is not confused as multiple words, so it goes inside double
typewriter quotes.

Also, sometimes a text can be both a command, and an example, but only
one quoting format must be chosen.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |  426 ++++++++++++++++++++--------------------
 1 files changed, 213 insertions(+), 213 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b169836..8ab8968 100644
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
+The clone command creates a new directory named after the project ('git'
+or 'linux-2.6' in the examples above).  After you cd into this
 directory, you will see that it contains a copy of the project files,
 called the <<def_working_tree,working tree>>, together with a special
-top-level directory named ".git", which contains all the information
+top-level directory named `.git`, which contains all the information
 about the history of the project.
 
 [[how-to-check-out]]
@@ -98,7 +98,7 @@ $ git branch
 ------------------------------------------------
 
 A freshly cloned repository contains a single branch head, by default
-named "master", with the working directory initialized to the state of
+named 'master', with the working directory initialized to the state of
 the project referred to by that branch head.
 
 Most projects also use <<def_tag,tags>>.  Tags, like heads, are
@@ -130,7 +130,7 @@ $ git checkout -b new v2.6.13
 ------------------------------------------------
 
 The working directory then reflects the contents that the project had
-when it was tagged v2.6.13, and linkgit:git-branch[1] shows two
+when it was tagged 'v2.6.13', and linkgit:git-branch[1] shows two
 branches, with an asterisk marking the currently checked-out branch:
 
 ------------------------------------------------
@@ -140,7 +140,7 @@ $ git branch
 ------------------------------------------------
 
 If you decide that you'd rather see version 2.6.17, you can modify
-the current branch to point at v2.6.17 instead, with
+the current branch to point at 'v2.6.17' instead, with
 
 ------------------------------------------------
 $ git reset --hard v2.6.17
@@ -187,8 +187,8 @@ index 65898fa..b002dc6 100644
 As you can see, a commit shows who made the latest change, what they
 did, and why.
 
-Every commit has a 40-hexdigit id, sometimes called the "object name" or the
-"SHA-1 id", shown on the first line of the "git show" output.  You can usually
+Every commit has a 40-hexdigit id, sometimes called the 'object name' or the
+"SHA1-1 id", shown on the first line of the `git show` output.  You can usually
 refer to a commit by a shorter name, such as a tag or a branch name, but this
 longer name can also be useful.  Most importantly, it is a globally unique
 name for this commit: so if you tell somebody else the object name (for
@@ -213,26 +213,26 @@ beginning of the project.
 
 However, the commits do not form a simple list; git allows lines of
 development to diverge and then reconverge, and the point where two
-lines of development reconverge is called a "merge".  The commit
+lines of development reconverge is called a 'merge'.  The commit
 representing a merge can therefore have more than one parent, with
 each parent representing the most recent commit on one of the lines
 of development leading to that point.
 
 The best way to see how this works is using the linkgit:gitk[1]
-command; running gitk now on a git repository and looking for merge
+command; running `gitk` now on a git repository and looking for merge
 commits will help understand how the git organizes history.
 
-In the following, we say that commit X is "reachable" from commit Y
-if commit X is an ancestor of commit Y.  Equivalently, you could say
-that Y is a descendant of X, or that there is a chain of parents
-leading from commit Y to commit X.
+In the following, we say that commit 'X' is 'reachable' from commit 'Y'
+if commit 'X' is an ancestor of commit 'Y'.  Equivalently, you could say
+that 'Y' is a descendant of 'X', or that there is a chain of parents
+leading from commit 'Y' to commit 'X'.
 
 [[history-diagrams]]
 Understanding history: History diagrams
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 We will sometimes represent git history using diagrams like the one
-below.  Commits are shown as "o", and the links between them with
+below.  Commits are shown as '"o"', and the links between them with
 lines drawn with - / and \.  Time goes left to right:
 
 
@@ -244,22 +244,22 @@ lines drawn with - / and \.  Time goes left to right:
          o--o--o <-- Branch B
 ................................................
 
-If we need to talk about a particular commit, the character "o" may
+If we need to talk about a particular commit, the character '"o"' may
 be replaced with another letter or number.
 
 [[what-is-a-branch]]
 Understanding history: What is a branch?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-When we need to be precise, we will use the word "branch" to mean a line
-of development, and "branch head" (or just "head") to mean a reference
+When we need to be precise, we will use the word 'branch' to mean a line
+of development, and 'branch head' (or just 'head') to mean a reference
 to the most recent commit on a branch.  In the example above, the branch
-head named "A" is a pointer to one particular commit, but we refer to
+head named '"A"' is a pointer to one particular commit, but we refer to
 the line of three commits leading up to that point as all being part of
-"branch A".
+'"branch A"'.
 
 However, when no confusion will result, we often just use the term
-"branch" both for branches and for branch heads.
+'branch' both for branches and for branch heads.
 
 [[manipulating-branches]]
 Manipulating branches
@@ -271,14 +271,14 @@ a summary of the commands:
 git branch::
 	list all branches
 git branch <branch>::
-	create a new branch named <branch>, referencing the same
+	create a new branch named '<branch>', referencing the same
 	point in history as the current branch
 git branch <branch> <start-point>::
-	create a new branch named <branch>, referencing
-	<start-point>, which may be specified any way you like,
+	create a new branch named '<branch>', referencing
+	'<start-point>', which may be specified any way you like,
 	including using a branch name or a tag name
 git branch -d <branch>::
-	delete the branch <branch>; if the branch you are deleting
+	delete the branch '<branch>'; if the branch you are deleting
 	points to a commit which is not reachable from the current
 	branch, this command will fail with a warning.
 git branch -D <branch>::
@@ -288,14 +288,14 @@ git branch -D <branch>::
 	case it is safe to use this command to force git to delete
 	the branch.
 git checkout <branch>::
-	make the current branch <branch>, updating the working
-	directory to reflect the version referenced by <branch>
+	make the current branch '<branch>', updating the working
+	directory to reflect the version referenced by '<branch>'
 git checkout -b <new> <start-point>::
-	create a new branch <new> referencing <start-point>, and
+	create a new branch '<new>' referencing '<start-point>', and
 	check it out.
 
-The special symbol "HEAD" can always be used to refer to the current
-branch.  In fact, git uses a file named "HEAD" in the .git directory to
+The special symbol `HEAD` can always be used to refer to the current
+branch.  In fact, git uses a file named `HEAD` in the `.git` directory to
 remember which branch is current:
 
 ------------------------------------------------
@@ -320,8 +320,8 @@ If you want to create a new branch from this checkout, you may do so
 HEAD is now at 427abfa... Linux v2.6.17
 ------------------------------------------------
 
-The HEAD then refers to the SHA-1 of the commit instead of to a branch,
-and git branch shows that you are no longer on a branch:
+The `HEAD` then refers to the `SHA-1` of the commit instead of to a branch,
+and `git branch` shows that you are no longer on a branch:
 
 ------------------------------------------------
 $ cat .git/HEAD
@@ -331,7 +331,7 @@ $ git branch
   master
 ------------------------------------------------
 
-In this case we say that the HEAD is "detached".
+In this case we say that the `HEAD` is 'detached'.
 
 This is an easy way to check out a particular version without having to
 make up a name for the new branch.   You can still create a new branch
@@ -341,11 +341,11 @@ make up a name for the new branch.   You can still create a new branch
 Examining branches from a remote repository
 -------------------------------------------
 
-The "master" branch that was created at the time you cloned is a copy
-of the HEAD in the repository that you cloned from.  That repository
+The `master` branch that was created at the time you cloned is a copy
+of the `HEAD` in the repository that you cloned from.  That repository
 may also have had other branches, though, and your local repository
 keeps branches which track each of those remote branches, which you
-can view using the "-r" option to linkgit:git-branch[1]:
+can view using the `-r` option to linkgit:git-branch[1]:
 
 ------------------------------------------------
 $ git branch -r
@@ -359,14 +359,14 @@ $ git branch -r
   origin/todo
 ------------------------------------------------
 
-You cannot check out these remote-tracking branches, but you can
+You cannot check out these 'remote-tracking' branches, but you can
 examine them on a branch of your own, just as you would a tag:
 
 ------------------------------------------------
 $ git checkout -b my-todo-copy origin/todo
 ------------------------------------------------
 
-Note that the name "origin" is just the name that git uses by default
+Note that the name 'origin' is just the name that git uses by default
 to refer to the repository that you cloned from.
 
 [[how-git-stores-references]]
@@ -375,42 +375,42 @@ Naming branches, tags, and other references
 
 Branches, remote-tracking branches, and tags are all references to
 commits.  All references are named with a slash-separated path name
-starting with "refs"; the names we've been using so far are actually
+starting with 'refs'; the names we've been using so far are actually
 shorthand:
 
-	- The branch "test" is short for "refs/heads/test".
-	- The tag "v2.6.18" is short for "refs/tags/v2.6.18".
-	- "origin/master" is short for "refs/remotes/origin/master".
+	- The branch 'test' is short for '"refs/heads/test"'.
+	- The tag 'v2.6.18' is short for '"refs/tags/v2.6.18"'.
+	- 'origin/master' is short for '"refs/remotes/origin/master"'.
 
 The full name is occasionally useful if, for example, there ever
 exists a tag and a branch with the same name.
 
-(Newly created refs are actually stored in the .git/refs directory,
+(Newly created refs are actually stored in the `.git/refs` directory,
 under the path given by their name.  However, for efficiency reasons
 they may also be packed together in a single file; see
 linkgit:git-pack-refs[1]).
 
-As another useful shortcut, the "HEAD" of a repository can be referred
-to just using the name of that repository.  So, for example, "origin"
-is usually a shortcut for the HEAD branch in the repository "origin".
+As another useful shortcut, the `HEAD` of a repository can be referred
+to just using the name of that repository.  So, for example, '"origin"'
+is usually a shortcut for the `HEAD` branch in the repository '"origin"'.
 
 For the complete list of paths which git checks for references, and
 the order it uses to decide which to choose when there are multiple
-references with the same shorthand name, see the "SPECIFYING
-REVISIONS" section of linkgit:git-rev-parse[1].
+references with the same shorthand name, see the '"SPECIFYING
+REVISIONS"' section of linkgit:git-rev-parse[1].
 
 [[Updating-a-repository-With-git-fetch]]
-Updating a repository with git fetch
+Updating a repository with `git fetch`
 ------------------------------------
 
 Eventually the developer cloned from will do additional work in her
 repository, creating new commits and advancing the branches to point
 at the new commits.
 
-The command "git fetch", with no arguments, will update all of the
+The command `git fetch`, with no arguments, will update all of the
 remote-tracking branches to the latest version found in her
 repository.  It will not touch any of your own branches--not even the
-"master" branch that was created for you on clone.
+`master` branch that was created for you on clone.
 
 [[fetching-branches]]
 Fetching branches from other repositories
@@ -427,7 +427,7 @@ $ git fetch linux-nfs
 -------------------------------------------------
 
 New remote-tracking branches will be stored under the shorthand name
-that you gave "git remote add", in this case linux-nfs:
+that you gave `git remote add`, in this case "linux-nfs":
 
 -------------------------------------------------
 $ git branch -r
@@ -435,10 +435,10 @@ linux-nfs/master
 origin/master
 -------------------------------------------------
 
-If you run "git fetch <remote>" later, the tracking branches for the
-named <remote> will be updated.
+If you run `git fetch <remote>` later, the tracking branches for the
+named '<remote>' will be updated.
 
-If you examine the file .git/config, you will see that git has added
+If you examine the file `.git/config`, you will see that git has added
 a new stanza:
 
 -------------------------------------------------
@@ -451,8 +451,8 @@ $ cat .git/config
 -------------------------------------------------
 
 This is what causes git to track the remote's branches; you may modify
-or delete these configuration options by editing .git/config with a
-text editor.  (See the "CONFIGURATION FILE" section of
+or delete these configuration options by editing `.git/config` with a
+text editor.  (See the '"CONFIGURATION FILE"' section of
 linkgit:git-config[1] for details.)
 
 [[exploring-git-history]]
@@ -461,7 +461,7 @@ Exploring git history
 
 Git is best thought of as a tool for storing the history of a
 collection of files.  It does this by storing compressed snapshots of
-the contents of a file hierarchy, together with "commits" which show
+the contents of a file hierarchy, together with commits which show
 the relationships between these snapshots.
 
 Git provides extremely flexible and fast tools for exploring the
@@ -474,8 +474,8 @@ commit that introduced a bug into a project.
 How to use bisect to find a regression
 --------------------------------------
 
-Suppose version 2.6.18 of your project worked, but the version at
-"master" crashes.  Sometimes the best way to find the cause of such a
+Suppose version '2.6.18' of your project worked, but the version at
+'master' crashes.  Sometimes the best way to find the cause of such a
 regression is to perform a brute-force search through the project's
 history to find the particular commit that caused the problem.  The
 linkgit:git-bisect[1] command can help you do this:
@@ -488,10 +488,10 @@ Bisecting: 3537 revisions left to test after this
 [65934a9a028b88e83e2b0f8b36618fe503349f8e] BLOCK: Make USB storage depend on SCSI rather than selecting it [try #6]
 -------------------------------------------------
 
-If you run "git branch" at this point, you'll see that git has
-temporarily moved you in "(no branch)". HEAD is now detached from any
-branch and points directly to a commit (with commit id 65934...) that
-is reachable from "master" but not from v2.6.18. Compile and test it,
+If you run `git branch` at this point, you'll see that git has
+temporarily moved you to '"(no branch)"'. `HEAD` is now detached from any
+branch and points directly to a commit (with commit id '65934...') that
+is reachable from 'master' but not from 'v2.6.18'. Compile and test it,
 and see whether it crashes. Assume it does crash. Then:
 
 -------------------------------------------------
@@ -526,19 +526,19 @@ run
 $ git bisect visualize
 -------------------------------------------------
 
-which will run gitk and label the commit it chose with a marker that
-says "bisect".  Choose a safe-looking commit nearby, note its commit
+which will run `gitk` and label the commit it chose with a marker that
+says '"bisect"'.  Choose a safe-looking commit nearby, note its commit
 id, and check it out with:
 
 -------------------------------------------------
 $ git reset --hard fb47ddb2db...
 -------------------------------------------------
 
-then test, run "bisect good" or "bisect bad" as appropriate, and
+then test, run '"bisect good"' or '"bisect bad"' as appropriate, and
 continue.
 
-Instead of "git bisect visualize" and then "git reset --hard
-fb47ddb2db...", you might just want to tell git that you want to skip
+Instead of '"git bisect visualize"' and then '"git reset --hard
+fb47ddb2db..."', you might just want to tell git that you want to skip
 the current commit:
 
 -------------------------------------------------
@@ -550,8 +550,8 @@ bad one between some first skipped commits and a later bad commit.
 
 There are also ways to automate the bisecting process if you have a
 test script that can tell a good from a bad commit. See
-linkgit:git-bisect[1] for more information about this and other "git
-bisect" features.
+linkgit:git-bisect[1] for more information about this and other `git
+bisect` features.
 
 [[naming-commits]]
 Naming commits
@@ -567,7 +567,7 @@ We have seen several ways of naming commits already:
 	  <<how-git-stores-references,references>>).
 	- HEAD: refers to the head of the current branch
 
-There are many more; see the "SPECIFYING REVISIONS" section of the
+There are many more; see the '"SPECIFYING REVISIONS"' section of the
 linkgit:git-rev-parse[1] man page for the complete list of ways to
 name revisions.  Some examples:
 
@@ -580,7 +580,7 @@ $ git show HEAD~4   # the great-great-grandparent
 -------------------------------------------------
 
 Recall that merge commits may have more than one parent; by default,
-^ and ~ follow the first parent listed in the commit, but you can
+'^' and '~' follow the first parent listed in the commit, but you can
 also choose:
 
 -------------------------------------------------
@@ -588,24 +588,24 @@ $ git show HEAD^1   # show the first parent of HEAD
 $ git show HEAD^2   # show the second parent of HEAD
 -------------------------------------------------
 
-In addition to HEAD, there are several other special names for
+In addition to `HEAD`, there are several other special names for
 commits:
 
 Merges (to be discussed later), as well as operations such as
 `git reset`, which change the currently checked-out commit, generally
-set ORIG_HEAD to the value HEAD had before the current operation.
+set `ORIG_HEAD` to the value `HEAD` had before the current operation.
 
 The `git fetch` operation always stores the head of the last fetched
-branch in FETCH_HEAD.  For example, if you run `git fetch` without
+branch in `FETCH_HEAD`.  For example, if you run `git fetch` without
 specifying a local branch as the target of the operation
 
 -------------------------------------------------
 $ git fetch git://example.com/proj.git theirbranch
 -------------------------------------------------
 
-the fetched commits will still be available from FETCH_HEAD.
+the fetched commits will still be available from `FETCH_HEAD`.
 
-When we discuss merges we'll also see the special name MERGE_HEAD,
+When we discuss merges we'll also see the special name `MERGE_HEAD`,
 which refers to the other branch that we're merging in to the current
 branch.
 
@@ -629,9 +629,9 @@ running
 $ git tag stable-1 1b2e1d63ff
 -------------------------------------------------
 
-You can use stable-1 to refer to the commit 1b2e1d63ff.
+You can use 'stable-1' to refer to the commit '1b2e1d63ff'.
 
-This creates a "lightweight" tag.  If you would also like to include a
+This creates a 'lightweight' tag.  If you would also like to include a
 comment with the tag, and possibly sign it cryptographically, then you
 should create a tag object instead; see the linkgit:git-tag[1] man page
 for details.
@@ -658,22 +658,22 @@ $ git log -S'foo()'	# commits which add or remove any file data
 -------------------------------------------------
 
 And of course you can combine all of these; the following finds
-commits since v2.5 which touch the Makefile or any file under fs:
+commits since 'v2.5' which touch the 'Makefile' or any file under 'fs':
 
 -------------------------------------------------
 $ git log v2.5.. Makefile fs/
 -------------------------------------------------
 
-You can also ask git log to show patches:
+You can also ask `git log` to show patches:
 
 -------------------------------------------------
 $ git log -p
 -------------------------------------------------
 
-See the "--pretty" option in the linkgit:git-log[1] man page for more
+See the `--pretty` option in the linkgit:git-log[1] man page for more
 display options.
 
-Note that git log starts with the most recent commit and works
+Note that `git log` starts with the most recent commit and works
 backwards through the parents; however, since git history can contain
 multiple independent lines of development, the particular order that
 commits are listed in may be somewhat arbitrary.
@@ -731,15 +731,15 @@ Examples
 Counting the number of commits on a branch
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Suppose you want to know how many commits you've made on "mybranch"
-since it diverged from "origin":
+Suppose you want to know how many commits you've made on '"mybranch"'
+since it diverged from '"origin"':
 
 -------------------------------------------------
 $ git log --pretty=oneline origin..mybranch | wc -l
 -------------------------------------------------
 
 Alternatively, you may often see this sort of thing done with the
-lower-level command linkgit:git-rev-list[1], which just lists the SHA-1's
+lower-level command linkgit:git-rev-list[1], which just lists the `SHA-1s`
 of all the given commits:
 
 -------------------------------------------------
@@ -769,7 +769,7 @@ $ git rev-list master
 e05db0fd4f31dde7005f075a84f96b360d05984b
 -------------------------------------------------
 
-Or you could recall that the ... operator selects all commits
+Or you could recall that the '"..."' operator selects all commits
 contained reachable from either one reference or the other but not
 both: so
 
@@ -783,15 +783,15 @@ will return no commits when the two branches are equal.
 Find first tagged version including a given fix
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Suppose you know that the commit e05db0fd fixed a certain problem.
+Suppose you know that the commit 'e05db0fd' fixed a certain problem.
 You'd like to find the earliest tagged release that contains that
 fix.
 
 Of course, there may be more than one answer--if the history branched
-after commit e05db0fd, then there could be multiple "earliest" tagged
+after commit 'e05db0fd', then there could be multiple earliest tagged
 releases.
 
-You could just visually inspect the commits since e05db0fd:
+You could just visually inspect the commits since 'e05db0fd':
 
 -------------------------------------------------
 $ gitk e05db0fd..
@@ -827,8 +827,8 @@ e05db0fd4f31dde7005f075a84f96b360d05984b
 
 The merge-base command finds a common ancestor of the given commits,
 and always returns one or the other in the case where one is a
-descendant of the other; so the above output shows that e05db0fd
-actually is an ancestor of v1.5.0-rc1.
+descendant of the other; so the above output shows that 'e05db0fd'
+actually is an ancestor of 'v1.5.0-rc1'.
 
 Alternatively, note that
 
@@ -836,8 +836,8 @@ Alternatively, note that
 $ git log v1.5.0-rc1..e05db0fd
 -------------------------------------------------
 
-will produce empty output if and only if v1.5.0-rc1 includes e05db0fd,
-because it outputs only commits that are not reachable from v1.5.0-rc1.
+will produce empty output if and only if 'v1.5.0-rc1' includes 'e05db0fd',
+because it outputs only commits that are not reachable from 'v1.5.0-rc1'.
 
 As yet another alternative, the linkgit:git-show-branch[1] command lists
 the commits reachable from its arguments with a display on the left-hand
@@ -861,15 +861,15 @@ then search for a line that looks like
 available
 -------------------------------------------------
 
-Which shows that e05db0fd is reachable from itself, from v1.5.0-rc1, and
-from v1.5.0-rc2, but not from v1.5.0-rc0.
+Which shows that 'e05db0fd' is reachable from itself, from 'v1.5.0-rc1', and
+from 'v1.5.0-rc2', but not from 'v1.5.0-rc0'.
 
 [[showing-commits-unique-to-a-branch]]
 Showing commits unique to a given branch
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Suppose you would like to see all the commits reachable from the branch
-head named "master" but not from any other head in your repository.
+head named '"master"' but not from any other head in your repository.
 
 We can list all the heads in this repository with
 linkgit:git-show-ref[1]:
@@ -883,7 +883,7 @@ a07157ac624b2524a059a3414e99f6f44bebc1e7 refs/heads/master
 1e87486ae06626c2f31eaa63d26fc0fd646c8af2 refs/heads/tutorial-fixes
 -------------------------------------------------
 
-We can get just the branch-head names, and remove "master", with
+We can get just the branch-head names, and remove 'master', with
 the help of the standard utilities cut and grep:
 
 -------------------------------------------------
@@ -894,7 +894,7 @@ refs/heads/tutorial-2
 refs/heads/tutorial-fixes
 -------------------------------------------------
 
-And then we can ask to see all the commits reachable from master
+And then we can ask to see all the commits reachable from 'master'
 but not from these other heads:
 
 -------------------------------------------------
@@ -909,7 +909,7 @@ commits reachable from some head but not from any tag in the repository:
 $ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
 -------------------------------------------------
 
-(See linkgit:git-rev-parse[1] for explanations of commit-selecting
+(See linkgit:git-rev-parse[1] for explanations of 'commit-selecting'
 syntax such as `--not`.)
 
 [[making-a-release]]
@@ -923,8 +923,8 @@ any version of a project; for example:
 $ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
 -------------------------------------------------
 
-will use HEAD to produce a tar archive in which each filename is
-preceded by "project/".
+will use `HEAD` to produce a tar archive in which each filename is
+preceded by '"project/"'.
 
 If you're releasing a new version of a software project, you may want
 to simultaneously make a changelog to include in the release
@@ -937,7 +937,7 @@ then running:
 $ release-script 2.6.12 2.6.13-rc6 2.6.13-rc7
 -------------------------------------------------
 
-where release-script is a shell script that looks like:
+where 'release-script' is a shell script that looks like:
 
 -------------------------------------------------
 #!/bin/sh
@@ -982,7 +982,7 @@ Telling git your name
 
 Before creating any commits, you should introduce yourself to git.  The
 easiest way to do so is to make sure the following lines appear in a
-file named .gitconfig in your home directory:
+file named `.gitconfig` in your home directory:
 
 ------------------------------------------------
 [user]
@@ -990,7 +990,7 @@ file named .gitconfig in your home directory:
 	email = you@yourdomain.example.com
 ------------------------------------------------
 
-(See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
+(See the '"CONFIGURATION FILE"' section of linkgit:git-config[1] for
 details on the configuration file.)
 
 
@@ -1031,11 +1031,11 @@ Creating a new commit takes three steps:
 In practice, you can interleave and repeat steps 1 and 2 as many
 times as you want: in order to keep track of what you want committed
 at step 3, git maintains a snapshot of the tree's contents in a
-special staging area called "the index."
+special staging area called ``the index''.
 
 At the beginning, the content of the index will be identical to
-that of the HEAD.  The command "git diff --cached", which shows
-the difference between the HEAD and the index, should therefore
+that of the `HEAD`.  The command '"git diff --cached"', which shows
+the difference between the `HEAD` and the `index`, should therefore
 produce no output at that point.
 
 Modifying the index is easy:
@@ -1064,7 +1064,7 @@ After each step you can verify that
 $ git diff --cached
 -------------------------------------------------
 
-always shows the difference between the HEAD and the index file--this
+always shows the difference between the `HEAD` and the index file--this
 is what you'd commit if you created the commit now--and that
 
 -------------------------------------------------
@@ -1116,7 +1116,7 @@ $ git status	    # a brief per-file summary of the above.
 You can also use linkgit:git-gui[1] to create commits, view changes in
 the index and the working tree files, and individually select diff hunks
 for inclusion in the index (by right-clicking on the diff hunk and
-choosing "Stage Hunk For Commit").
+choosing '"Stage Hunk For Commit"').
 
 [[creating-good-commit-messages]]
 Creating good commit messages
@@ -1126,22 +1126,22 @@ Though not required, it's a good idea to begin the commit message
 with a single short (less than 50 character) line summarizing the
 change, followed by a blank line and then a more thorough
 description.  Tools that turn commits into email, for example, use
-the first line on the Subject line and the rest of the commit in the
+the first line on the 'Subject' line and the rest of the commit in the
 body.
 
 [[ignoring-files]]
 Ignoring files
 --------------
 
-A project will often generate files that you do 'not' want to track with git.
+A project will often generate files that you do *not* want to track with git.
 This typically includes files generated by a build process or temporary
-backup files made by your editor. Of course, 'not' tracking files with git
-is just a matter of 'not' calling `git add` on them. But it quickly becomes
+backup files made by your editor. Of course, *not* tracking files with git
+is just a matter of *not* calling `git add` on them. But it quickly becomes
 annoying to have these untracked files lying around; e.g. they make
 `git add .` practically useless, and they keep showing up in the output of
 `git status`.
 
-You can tell git to ignore certain files by creating a file called .gitignore
+You can tell git to ignore certain files by creating a file called `.gitignore`
 in the top level of your working directory, with contents such as:
 
 -------------------------------------------------
@@ -1157,16 +1157,16 @@ foo.txt
 -------------------------------------------------
 
 See linkgit:gitignore[5] for a detailed explanation of the syntax.  You can
-also place .gitignore files in other directories in your working tree, and they
+also place `.gitignore` files in other directories in your working tree, and they
 will apply to those directories and their subdirectories.  The `.gitignore`
-files can be added to your repository like any other files (just run `git add
-.gitignore` and `git commit`, as usual), which is convenient when the exclude
+files can be added to your repository like any other files (just run '"git add
+.gitignore"' and '"git commit"', as usual), which is convenient when the exclude
 patterns (such as patterns matching build output files) would also make sense
 for other users who clone your repository.
 
 If you wish the exclude patterns to affect only certain repositories
 (instead of every repository for a given project), you may instead put
-them in a file in your repository named .git/info/exclude, or in any file
+them in a file in your repository named '.git/info/exclude', or in any file
 specified by the `core.excludesfile` configuration variable.  Some git
 commands can also take exclude patterns directly on the command line.
 See linkgit:gitignore[5] for the details.
@@ -1182,10 +1182,10 @@ linkgit:git-merge[1]:
 $ git merge branchname
 -------------------------------------------------
 
-merges the development in the branch "branchname" into the current
+merges the development in the branch '"branchname"' into the current
 branch.
 
-A merge is made by combining the changes made in "branchname" and the
+A merge is made by combining the changes made in 'branchname' and the
 changes made up to the latest commit in your current branch since
 their histories forked. The work tree is overwritten by the result of
 the merge when this combining is done cleanly, or overwritten by a
@@ -1213,10 +1213,10 @@ Automatic merge failed; fix conflicts and then commit the result.
 
 Conflict markers are left in the problematic files, and after
 you resolve the conflicts manually, you can update the index
-with the contents and run git commit, as you normally would when
+with the contents and run `git commit`, as you normally would when
 creating a new file.
 
-If you examine the resulting commit using gitk, you will see that it
+If you examine the resulting commit using `gitk`, you will see that it
 has two parents, one pointing to the top of the current branch, and
 one to the top of the other branch.
 
@@ -1237,7 +1237,7 @@ $ git commit
 file.txt: needs merge
 -------------------------------------------------
 
-Also, linkgit:git-status[1] will list those files as "unmerged", and the
+Also, linkgit:git-status[1] will list those files as '"unmerged"', and the
 files with conflicts will have conflict markers added, like this:
 
 -------------------------------------------------
@@ -1287,11 +1287,11 @@ index 802992c,2b60207..0000000
 
 Recall that the commit which will be committed after we resolve this
 conflict will have two parents instead of the usual one: one parent
-will be HEAD, the tip of the current branch; the other will be the
-tip of the other branch, which is stored temporarily in MERGE_HEAD.
+will be `HEAD`, the tip of the current branch; the other will be the
+tip of the other branch, which is stored temporarily in `MERGE_HEAD`.
 
 During the merge, the index holds three versions of each file.  Each of
-these three "file stages" represents a different version of the file:
+these three ``file stages'' represents a different version of the file:
 
 -------------------------------------------------
 $ git show :1:file.txt	# the file in a common ancestor of both branches
@@ -1306,11 +1306,11 @@ mixed (in other words, when a hunk's merge results come only from stage 2,
 that part is not conflicting and is not shown.  Same for stage 3).
 
 The diff above shows the differences between the working-tree version of
-file.txt and the stage 2 and stage 3 versions.  So instead of preceding
-each line by a single "+" or "-", it now uses two columns: the first
+'file.txt' and the stage 2 and stage 3 versions.  So instead of preceding
+each line by a single '"+"' or '"-"', it now uses two columns: the first
 column is used for differences between the first parent and the working
 directory copy, and the second for differences between the second parent
-and the working directory copy.  (See the "COMBINED DIFF FORMAT" section
+and the working directory copy.  (See the '"COMBINED DIFF FORMAT"' section
 of linkgit:git-diff-files[1] for a details of the format.)
 
 After resolving the conflict in the obvious way (but before updating the
@@ -1328,9 +1328,9 @@ index 802992c,2b60207..0000000
 ++Goodbye world
 -------------------------------------------------
 
-This shows that our resolved version deleted "Hello world" from the
-first parent, deleted "Goodbye" from the second parent, and added
-"Goodbye world", which was previously absent from both.
+This shows that our resolved version deleted '"Hello world"' from the
+first parent, deleted '"Goodbye"' from the second parent, and added
+'"Goodbye world"', which was previously absent from both.
 
 Some special diff options allow diffing the working directory against
 any of these stages:
@@ -1352,11 +1352,11 @@ $ git log --merge
 $ gitk --merge
 -------------------------------------------------
 
-These will display all commits which exist only on HEAD or on
-MERGE_HEAD, and which touch an unmerged file.
+These will display all commits which exist only on `HEAD` or on
+`MERGE_HEAD`, and which touch an unmerged file.
 
 You may also use linkgit:git-mergetool[1], which lets you merge the
-unmerged files using external tools such as Emacs or kdiff3.
+unmerged files using external tools such as 'Emacs' or 'kdiff3'.
 
 Each time you resolve the conflicts in a file and update the index:
 
@@ -1364,7 +1364,7 @@ Each time you resolve the conflicts in a file and update the index:
 $ git add file.txt
 -------------------------------------------------
 
-the different stages of that file will be "collapsed", after which
+the different stages of that file will be '"collapsed"', after which
 `git diff` will (by default) no longer show diffs for that file.
 
 [[undoing-a-merge]]
@@ -1400,7 +1400,7 @@ were merged.
 
 However, if the current branch is a descendant of the other--so every
 commit present in the one is already contained in the other--then git
-just performs a "fast-forward"; the head of the current branch is moved
+just performs a '``fast-forward'''; the head of the current branch is moved
 forward to point at the head of the merged-in branch, without any new
 commits being created.
 
@@ -1425,7 +1425,7 @@ fundamentally different ways to fix the problem:
 
 	2. You can go back and modify the old commit.  You should
 	never do this if you have already made the history public;
-	git does not normally expect the "history" of a project to
+	git does not normally expect the `history' of a project to
 	change, and cannot correctly perform repeated merges from
 	a branch that has had its history changed.
 
@@ -1441,7 +1441,7 @@ commit; for example, to revert the most recent commit:
 $ git revert HEAD
 -------------------------------------------------
 
-This will create a new commit which undoes the change in HEAD.  You
+This will create a new commit which undoes the change in `HEAD`.  You
 will be given a chance to edit the commit message for the new commit.
 
 You can also revert an earlier change, for example, the next-to-last:
@@ -1498,7 +1498,7 @@ name: the command
 $ git checkout HEAD^ path/to/file
 -------------------------------------------------
 
-replaces path/to/file by the contents it had in the commit HEAD^, and
+replaces '"path/to/file"' by the contents it had in the commit 'HEAD^', and
 also updates the index to match.  It does not change branches.
 
 If you just want to look at an old version of the file, without
@@ -1571,7 +1571,7 @@ Checking the repository for corruption
 
 The linkgit:git-fsck[1] command runs a number of self-consistency checks
 on the repository, and reports on any problems.  This may take some
-time.  The most common warning by far is about "dangling" objects:
+time.  The most common warning by far is about 'dangling' objects:
 
 -------------------------------------------------
 $ git fsck
@@ -1598,11 +1598,11 @@ Recovering lost changes
 Reflogs
 ^^^^^^^
 
-Say you modify a branch with `linkgit:git-reset[1] --hard`, and then
+Say you modify a branch with `git reset --hard`, and then
 realize that the branch was the only reference you had to that point in
 history.
 
-Fortunately, git also keeps a log, called a "reflog", of all the
+Fortunately, git also keeps a log, called a `reflog`, of all the
 previous values of each branch.  So in this case you can still find the
 old history using, for example,
 
@@ -1611,8 +1611,8 @@ $ git log master@{1}
 -------------------------------------------------
 
 This lists the commits reachable from the previous version of the
-"master" branch head.  This syntax can be used with any git command
-that accepts a commit, not just with git log.  Some other examples:
+'master' branch head.  This syntax can be used with any git command
+that accepts a commit, not just with `git log`.  Some other examples:
 
 -------------------------------------------------
 $ git show master@{2}		# See where the branch pointed 2,
@@ -1622,19 +1622,19 @@ $ gitk master@{"1 week ago"}	# ... or last week
 $ git log --walk-reflogs master	# show reflog entries for master
 -------------------------------------------------
 
-A separate reflog is kept for the HEAD, so
+A separate `reflog` is kept for the `HEAD`, so
 
 -------------------------------------------------
 $ git show HEAD@{"1 week ago"}
 -------------------------------------------------
 
-will show what HEAD pointed to one week ago, not what the current branch
+will show what `HEAD` pointed to one week ago, not what the current branch
 pointed to one week ago.  This allows you to see the history of what
 you've checked out.
 
 The reflogs are kept by default for 30 days, after which they may be
 pruned.  See linkgit:git-reflog[1] and linkgit:git-gc[1] to learn
-how to control this pruning, and see the "SPECIFYING REVISIONS"
+how to control this pruning, and see the '"SPECIFYING REVISIONS"'
 section of linkgit:git-rev-parse[1] for details.
 
 Note that the reflog history is very different from normal git history.
@@ -1673,7 +1673,7 @@ history that is described by the dangling commit(s), but not the
 history that is described by all your existing branches and tags.  Thus
 you get exactly the history reachable from that commit that is lost.
 (And notice that it might not be just one commit: we only report the
-"tip of the line" as being dangling, but there might be a whole deep
+``tip of the line'' as being dangling, but there might be a whole deep
 and complex commit history that was dropped.)
 
 If you decide you want the history back, you can always create a new
@@ -1716,8 +1716,8 @@ one step:
 $ git pull origin master
 -------------------------------------------------
 
-In fact, if you have "master" checked out, then by default "git pull"
-merges from the HEAD branch of the origin repository.  So often you can
+In fact, if you have 'master' checked out, then by default `git pull`
+merges from the `HEAD` branch of the origin repository.  So often you can
 accomplish the above with just a simple
 
 -------------------------------------------------
@@ -1726,11 +1726,11 @@ $ git pull
 
 More generally, a branch that is created from a remote branch will pull
 by default from that branch.  See the descriptions of the
-branch.<name>.remote and branch.<name>.merge options in
+'branch.<name>.remote' and 'branch.<name>.merge' options in
 linkgit:git-config[1], and the discussion of the `--track` option in
 linkgit:git-checkout[1], to learn how to control these defaults.
 
-In addition to saving you keystrokes, "git pull" also helps you by
+In addition to saving you keystrokes, `git pull` also helps you by
 producing a default commit message documenting the branch and
 repository that you pulled from.
 
@@ -1738,7 +1738,7 @@ repository that you pulled from.
 <<fast-forwards,fast-forward>>; instead, your branch will just be
 updated to point to the latest commit from the upstream branch.)
 
-The `git pull` command can also be given "." as the "remote" repository,
+The `git pull` command can also be given '"."' as the 'remote' repository,
 in which case it just merges in a branch from the current repository; so
 the commands
 
@@ -1763,7 +1763,7 @@ $ git format-patch origin
 -------------------------------------------------
 
 will produce a numbered series of files in the current directory, one
-for each patch in the current branch but not in origin/HEAD.
+for each patch in the current branch but not in 'origin/HEAD'.
 
 You can then import these into your mail client and send them by
 hand.  However, if you have a lot to send at once, you may prefer to
@@ -1776,9 +1776,9 @@ Importing patches to a project
 ------------------------------
 
 Git also provides a tool called linkgit:git-am[1] (am stands for
-"apply mailbox"), for importing such an emailed series of patches.
+``apply mailbox''), for importing such an emailed series of patches.
 Just save all of the patch-containing messages, in order, into a
-single mailbox file, say "patches.mbox", then run
+single mailbox file, say '"patches.mbox"', then run
 
 -------------------------------------------------
 $ git am -3 patches.mbox
@@ -1786,7 +1786,7 @@ $ git am -3 patches.mbox
 
 Git will apply each patch in order; if any conflicts are found, it
 will stop, and you can fix the conflicts as described in
-"<<resolving-a-merge,Resolving a merge>>".  (The "-3" option tells
+"<<resolving-a-merge,Resolving a merge>>".  (The `-3` option tells
 git to perform a merge; if you would prefer it just to abort and
 leave your tree and index untouched, you may omit that option.)
 
@@ -1812,7 +1812,7 @@ Another way to submit changes to a project is to tell the maintainer
 of that project to pull the changes from your repository using
 linkgit:git-pull[1].  In the section "<<getting-updates-With-git-pull,
 Getting updates with `git pull`>>" we described this as a way to get
-updates from the "main" repository, but it works just as well in the
+updates from the '"main"' repository, but it works just as well in the
 other direction.
 
 If you and the maintainer both have accounts on the same machine, then
@@ -1840,7 +1840,7 @@ from.  This is usually more convenient, and allows you to cleanly
 separate private work in progress from publicly visible work.
 
 You will continue to do your day-to-day work in your personal
-repository, but periodically "push" changes from your personal
+repository, but periodically '"push"' changes from your personal
 repository into your public repository, allowing other developers to
 pull from that repository.  So the flow of changes, in a situation
 where there is one other developer with a public repository, looks
@@ -1862,7 +1862,7 @@ We explain how to do this in the following sections.
 Setting up a public repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Assume your personal repository is in the directory ~/proj.  We
+Assume your personal repository is in the directory '~/proj'.  We
 first create a new clone of the repository and tell `git daemon` that it
 is meant to be public:
 
@@ -1871,12 +1871,12 @@ $ git clone --bare ~/proj proj.git
 $ touch proj.git/git-daemon-export-ok
 -------------------------------------------------
 
-The resulting directory proj.git contains a "bare" git repository--it is
-just the contents of the ".git" directory, without any files checked out
+The resulting directory 'proj.git' contains a '"bare"' git repository--it is
+just the contents of the `.git` directory, without any files checked out
 around it.
 
-Next, copy proj.git to the server where you plan to host the
-public repository.  You can use scp, rsync, or whatever is most
+Next, copy 'proj.git' to the server where you plan to host the
+public repository.  You can use 'scp', 'rsync', or whatever is most
 convenient.
 
 [[exporting-via-git]]
@@ -1886,7 +1886,7 @@ Exporting a git repository via the git protocol
 This is the preferred method.
 
 If someone else administers the server, they should tell you what
-directory to put the repository in, and what git:// URL it will appear
+directory to put the repository in, and what 'git://' URL it will appear
 at.  You can then skip to the section
 "<<pushing-changes-to-a-public-repository,Pushing changes to a public
 repository>>", below.
@@ -1894,7 +1894,7 @@ repository>>", below.
 Otherwise, all you need to do is start linkgit:git-daemon[1]; it will
 listen on port 9418.  By default, it will allow access to any directory
 that looks like a git directory and contains the magic file
-git-daemon-export-ok.  Passing some directory paths as `git daemon`
+'git-daemon-export-ok'.  Passing some directory paths as `git daemon`
 arguments will further restrict the exports to those paths.
 
 You can also run `git daemon` as an inetd service; see the
@@ -1922,7 +1922,7 @@ $ mv hooks/post-update.sample hooks/post-update
 (For an explanation of the last two lines, see
 linkgit:git-update-server-info[1] and linkgit:githooks[5].)
 
-Advertise the URL of proj.git.  Anybody else should then be able to
+Advertise the URL of 'proj.git'.  Anybody else should then be able to
 clone or pull from that URL, for example with a command line like:
 
 -------------------------------------------------
@@ -1945,8 +1945,8 @@ access, which you will need to update the public repository with the
 latest changes created in your private repository.
 
 The simplest way to do this is using linkgit:git-push[1] and ssh; to
-update the remote branch named "master" with the latest state of your
-branch named "master", run
+update the remote branch named 'master' with the latest state of your
+branch named 'master', run
 
 -------------------------------------------------
 $ git push ssh://yourserver.com/~you/proj.git master:master
@@ -1962,7 +1962,7 @@ As with `git fetch`, `git push` will complain if this does not result in a
 <<fast-forwards,fast-forward>>; see the following section for details on
 handling this case.
 
-Note that the target of a "push" is normally a
+Note that the target of a 'push' is normally a
 <<def_bare_repository,bare>> repository.  You can also push to a
 repository that has a checked-out working tree, but the working tree
 will not be updated by the push.  This may lead to unexpected results if
@@ -1984,8 +1984,8 @@ you should be able to perform the above push with just
 $ git push public-repo master
 -------------------------------------------------
 
-See the explanations of the remote.<name>.url, branch.<name>.remote,
-and remote.<name>.push options in linkgit:git-config[1] for
+See the explanations of the 'remote.<name>.url', 'branch.<name>.remote',
+and 'remote.<name>.push' options in linkgit:git-config[1] for
 details.
 
 [[forcing-push]]
@@ -2061,9 +2061,9 @@ advantages over the central shared repository:
 	  trivial for another developer to take over maintenance of a
 	  project, either by mutual agreement, or because a maintainer
 	  becomes unresponsive or difficult to work with.
-	- The lack of a central group of "committers" means there is
-	  less need for formal decisions about who is "in" and who is
-	  "out".
+	- The lack of a central group of ``committers'' means there is
+	  less need for formal decisions about who is ``in'' and who is
+	  ``out''.
 
 [[setting-up-gitweb]]
 Allowing web browsing of a repository
@@ -2071,7 +2071,7 @@ Allowing web browsing of a repository
 
 The gitweb cgi script provides users an easy way to browse your
 project's files and history without having to install git; see the file
-gitweb/INSTALL in the git source tree for instructions on setting it up.
+'gitweb/INSTALL' in the git source tree for instructions on setting it up.
 
 [[sharing-development-examples]]
 Examples
@@ -2086,16 +2086,16 @@ IA64 architecture for the Linux kernel.
 
 He uses two public branches:
 
- - A "test" tree into which patches are initially placed so that they
+ - A '"test"' tree into which patches are initially placed so that they
    can get some exposure when integrated with other ongoing development.
-   This tree is available to Andrew for pulling into -mm whenever he
+   This tree is available to Andrew for pulling into '-mm' whenever he
    wants.
 
- - A "release" tree into which tested patches are moved for final sanity
+ - A '"release"' tree into which tested patches are moved for final sanity
    checking, and as a vehicle to send them upstream to Linus (by sending
-   him a "please pull" request.)
+   him a ``please pull'' request.)
 
-He also uses a set of temporary branches ("topic branches"), each
+He also uses a set of temporary branches (``topic branches''), each
 containing a logical grouping of patches.
 
 To set this up, first create your work tree by cloning Linus's public
@@ -2108,13 +2108,13 @@ $ cd work
 
 Linus's tree will be stored in the remote branch named origin/master,
 and can be updated using linkgit:git-fetch[1]; you can track other
-public trees using linkgit:git-remote[1] to set up a "remote" and
+public trees using linkgit:git-remote[1] to set up a 'remote' and
 linkgit:git-fetch[1] to keep them up-to-date; see
 <<repositories-and-branches>>.
 
 Now create the branches in which you are going to work; these start out
-at the current tip of origin/master branch, and should be set up (using
-the --track option to linkgit:git-branch[1]) to merge changes in from
+at the current tip of 'origin/master' branch, and should be set up (using
+the `--track` option to linkgit:git-branch[1]) to merge changes in from
 Linus by default.
 
 -------------------------------------------------
@@ -2129,11 +2129,11 @@ $ git checkout test && git pull
 $ git checkout release && git pull
 -------------------------------------------------
 
-Important note!  If you have any local changes in these branches, then
+*Important note!*  If you have any local changes in these branches, then
 this merge will create a commit object in the history (with no local
-changes git will simply do a "fast-forward" merge).  Many people dislike
-the "noise" that this creates in the Linux history, so you should avoid
-doing this capriciously in the "release" branch, as these noisy commits
+changes git will simply do a 'fast-forward' merge).  Many people dislike
+the ``noise'' that this creates in the Linux history, so you should avoid
+doing this capriciously in the 'release' branch, as these noisy commits
 will become part of the permanent history when you ask Linus to pull
 from the release branch.
 
@@ -2187,7 +2187,7 @@ $ ... patch ... test  ... commit [ ... patch ... test ... commit ]*
 -------------------------------------------------
 
 When you are happy with the state of this change, you can pull it into the
-"test" branch in preparation to make it public:
+'test' branch in preparation to make it public:
 
 -------------------------------------------------
 $ git checkout test && git pull . speed-up-spinlocks
@@ -2197,9 +2197,9 @@ It is unlikely that you would have any conflicts here ... but you might if you
 spent a while on this step and had also pulled new versions from upstream.
 
 Some time later when enough time has passed and testing done, you can pull the
-same branch into the "release" tree ready to go upstream.  This is where you
+same branch into the 'release' tree ready to go upstream.  This is where you
 see the value of keeping each patch (or patch series) in its own branch.  It
-means that the patches can be moved into the "release" tree in any order.
+means that the patches can be moved into the 'release' tree in any order.
 
 -------------------------------------------------
 $ git checkout release && git pull . speed-up-spinlocks
@@ -2232,7 +2232,7 @@ If it has been merged, then there will be no output.)
 
 Once a patch completes the great cycle (moving from test to release,
 then pulled by Linus, and finally coming back into your local
-"origin/master" branch), the branch for this change is no longer needed.
+'origin/master' branch), the branch for this change is no longer needed.
 You detect this when the output from:
 
 -------------------------------------------------
@@ -2247,11 +2247,11 @@ $ git branch -d branchname
 
 Some changes are so trivial that it is not necessary to create a separate
 branch and then merge into each of the test and release branches.  For
-these changes, just apply directly to the "release" branch, and then
-merge that into the "test" branch.
+these changes, just apply directly to the 'release' branch, and then
+merge that into the 'test' branch.
 
-To create diffstat and shortlog summaries of changes to include in a "please
-pull" request to Linus you can use:
+To create diffstat and shortlog summaries of changes to include in a ``please
+pull'' request to Linus you can use:
 
 -------------------------------------------------
 $ git diff --stat origin..release
@@ -2420,11 +2420,11 @@ use them, and then explain some of the problems that can arise because
 you are rewriting history.
 
 [[using-git-rebase]]
-Keeping a patch series up to date using git rebase
+Keeping a patch series up to date using `git rebase`
 --------------------------------------------------
 
-Suppose that you create a branch "mywork" on a remote-tracking branch
-"origin", and create some commits on top of it:
+Suppose that you create a branch '"mywork"' on a remote-tracking branch
+'"origin"', and create some commits on top of it:
 
 -------------------------------------------------
 $ git checkout -b mywork origin
@@ -2435,8 +2435,8 @@ $ git commit
 ...
 -------------------------------------------------
 
-You have performed no merges into mywork, so it is just a simple linear
-sequence of patches on top of "origin":
+You have performed no merges into 'mywork', so it is just a simple linear
+sequence of patches on top of 'origin':
 
 ................................................
  o--o--o <-- origin
@@ -2445,7 +2445,7 @@ sequence of patches on top of "origin":
 ................................................
 
 Some more interesting work has been done in the upstream project, and
-"origin" has advanced:
+'origin' has advanced:
 
 ................................................
  o--o--O--o--o--o <-- origin
@@ -2453,7 +2453,7 @@ Some more interesting work has been done in the upstream project, and
          a--b--c <-- mywork
 ................................................
 
-At this point, you could use "pull" to merge your changes back in;
+At this point, you could use `git pull` to merge your changes back in;
 the result would create a new merge commit, like this:
 
 ................................................
@@ -2462,7 +2462,7 @@ the result would create a new merge commit, like this:
          a--b--c--m <-- mywork
 ................................................
 
-However, if you prefer to keep the history in mywork a simple series of
+However, if you prefer to keep the history in 'mywork' a simple series of
 commits without any merges, you may instead choose to use
 linkgit:git-rebase[1]:
 
@@ -2471,10 +2471,10 @@ $ git checkout mywork
 $ git rebase origin
 -------------------------------------------------
 
-This will remove each of your commits from mywork, temporarily saving
-them as patches (in a directory named ".git/rebase-apply"), update mywork to
-point at the latest version of origin, then apply each of the saved
-patches to the new mywork.  The result will look like:
+This will remove each of your commits from 'mywork', temporarily saving
+them as patches (in a directory named '.git/rebase-apply'), update 'mywork' to
+point at the latest version of 'origin', then apply each of the saved
+patches to the new 'mywork'.  The result will look like:
 
 
 ................................................
@@ -2495,7 +2495,7 @@ $ git rebase --continue
 and git will continue applying the rest of the patches.
 
 At any point you may use the `--abort` option to abort this process and
-return mywork to the state it had before you started the rebase:
+return 'mywork' to the state it had before you started the rebase:
 
 -------------------------------------------------
 $ git rebase --abort
-- 
1.6.6.1
