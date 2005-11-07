From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Use consistent shell prompts and example style.
Date: Mon, 07 Nov 2005 08:33:51 -0600
Message-ID: <E1EZ84F-0006uQ-SL@jdl.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 15:36:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ84O-0007ph-LI
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 15:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVKGOd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 09:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVKGOdz
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 09:33:55 -0500
Received: from jdl.com ([66.118.10.122]:59330 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964829AbVKGOdy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 09:33:54 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EZ84F-0006uQ-SL
	for git@vger.kernel.org; Mon, 07 Nov 2005 08:33:55 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11263>


Signed-off-by: Jon Loeliger <jdl@freescale.com>


---

 Documentation/tutorial.txt |  226 +++++++++++++++++++++++++++-----------------
 1 files changed, 138 insertions(+), 88 deletions(-)

applies-to: 5ebec76efaa72d55bc18eaadad6e85f03e8173a3
291987d85077f3ce3a9beefe39ab5730262c2317
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 6d2c153..22f21fd 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -36,14 +36,16 @@ To start up, create a subdirectory for i
 subdirectory, and initialize the git infrastructure with `git-init-db`:
 
 ------------------------------------------------
-mkdir git-tutorial
-cd git-tutorial
-git-init-db
+$ mkdir git-tutorial
+$ cd git-tutorial
+$ git-init-db
 ------------------------------------------------
 
 to which git will reply
 
-	defaulting to local storage area
+----------------
+defaulting to local storage area
+----------------
 
 which is just git's way of saying that you haven't been doing anything
 strange, and that it will have created a local `.git` directory setup for
@@ -114,8 +116,8 @@ in your git repository. We'll start off 
 get a feel for how this works:
 
 ------------------------------------------------
-echo "Hello World" >hello
-echo "Silly example" >example
+$ echo "Hello World" >hello
+$ echo "Silly example" >example
 ------------------------------------------------
 
 you have now created two files in your working tree (aka 'working directory'), but to
@@ -137,7 +139,7 @@ adding a new entry with the `\--add` fla
 So to populate the index with the two files you just created, you can do
 
 ------------------------------------------------
-git-update-index --add hello example
+$ git-update-index --add hello example
 ------------------------------------------------
 
 and you have now told git to track those two files.
@@ -146,12 +148,17 @@ In fact, as you did that, if you now loo
 you'll notice that git will have added two new objects to the object
 database. If you did exactly the steps above, you should now be able to do
 
-	ls .git/objects/??/*
+
+----------------
+$ ls .git/objects/??/*
+----------------
 
 and see two files:
 
-	.git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238 
-	.git/objects/f2/4c74a2e500f5ee1332c86b94199f52b1d1d962
+----------------
+.git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238 
+.git/objects/f2/4c74a2e500f5ee1332c86b94199f52b1d1d962
+----------------
 
 which correspond with the objects with names of 557db... and f24c7..
 respectively.
@@ -159,13 +166,17 @@ respectively.
 If you want to, you can use `git-cat-file` to look at those objects, but
 you'll have to use the object name, not the filename of the object:
 
-	git-cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
+----------------
+$ git-cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
+----------------
 
 where the `-t` tells `git-cat-file` to tell you what the "type" of the
 object is. git will tell you that you have a "blob" object (ie just a
 regular file), and you can see the contents with
 
-	git-cat-file "blob" 557db03
+----------------
+$ git-cat-file "blob" 557db03
+----------------
 
 which will print out "Hello World". The object 557db03 is nothing
 more than the contents of your file `hello`.
@@ -202,7 +213,7 @@ In particular, let's not even check in t
 start off by adding another line to `hello` first:
 
 ------------------------------------------------
-echo "It's a new day for git" >>hello
+$ echo "It's a new day for git" >>hello
 ------------------------------------------------
 
 and you can now, since you told git about the previous state of `hello`, ask
@@ -210,7 +221,7 @@ git what has changed in the tree compare
 `git-diff-files` command:
 
 ------------
-git-diff-files
+$ git-diff-files
 ------------
 
 Oops. That wasn't very readable. It just spit out its own internal
@@ -222,12 +233,7 @@ To make it readable, we can tell git-dif
 differences as a patch, using the `-p` flag:
 
 ------------
-git-diff-files -p
-------------
-
-which will spit out
-
-------------
+$ git-diff-files -p
 diff --git a/hello b/hello
 index 557db03..263414f 100644
 --- a/hello
@@ -264,13 +270,15 @@ filenames with their contents (and their
 creating the equivalent of a git "directory" object:
 
 ------------------------------------------------
-git-write-tree
+$ git-write-tree
 ------------------------------------------------
 
 and this will just output the name of the resulting tree, in this case
 (if you have done exactly as I've described) it should be
 
-	8988da15d077d4829fc51d8544c097def6644dbb
+----------------
+8988da15d077d4829fc51d8544c097def6644dbb
+----------------
 
 which is another incomprehensible object name. Again, if you want to,
 you can use `git-cat-file -t 8988d\...` to see that this time the object
@@ -299,14 +307,16 @@ that's exactly what `git-commit-tree` sp
 all with a sequence of simple shell commands:
 
 ------------------------------------------------
-tree=$(git-write-tree)
-commit=$(echo 'Initial commit' | git-commit-tree $tree)
-git-update-ref HEAD $commit
+$ tree=$(git-write-tree)
+$ commit=$(echo 'Initial commit' | git-commit-tree $tree)
+$ git-update-ref HEAD $commit
 ------------------------------------------------
 
 which will say:
 
-	Committing initial tree 8988da15d077d4829fc51d8544c097def6644dbb
+----------------
+Committing initial tree 8988da15d077d4829fc51d8544c097def6644dbb
+----------------
 
 just to warn you about the fact that it created a totally new commit
 that is not related to anything else. Normally you do this only *once*
@@ -349,7 +359,9 @@ didn't have anything to diff against. 
 
 But now we can do
 
-	git-diff-index -p HEAD
+----------------
+$ git-diff-index -p HEAD
+----------------
 
 (where `-p` has the same meaning as it did in `git-diff-files`), and it
 will show us the same difference, but for a totally different reason. 
@@ -360,7 +372,9 @@ are obviously the same, so we get the sa
 Again, because this is a common operation, you can also just shorthand
 it with
 
-	git diff HEAD
+----------------
+$ git diff HEAD
+----------------
 
 which ends up doing the above for you.
 
@@ -396,7 +410,7 @@ work through the index file, so the firs
 update the index cache:
 
 ------------------------------------------------
-git-update-index hello
+$ git-update-index hello
 ------------------------------------------------
 
 (note how we didn't need the `\--add` flag this time, since git knew
@@ -417,7 +431,7 @@ this wasn't an initial commit any more),
 already, so let's just use the helpful script this time:
 
 ------------------------------------------------
-git commit
+$ git commit
 ------------------------------------------------
 
 which starts an editor for you to write the commit message and tells you
@@ -450,7 +464,9 @@ give it just a single commit object, and
 of that commit itself, and show the difference directly. Thus, to get
 the same diff that we've already seen several times, we can now do
 
-	git-diff-tree -p HEAD
+----------------
+$ git-diff-tree -p HEAD
+----------------
 
 (again, `-p` means to show the difference as a human-readable patch),
 and it will show what the last commit (in `HEAD`) actually changed.
@@ -505,13 +521,17 @@ activities.
 To see the whole history of our pitiful little git-tutorial project, you
 can do
 
-	git log
+----------------
+$ git log
+----------------
 
 which shows just the log messages, or if we want to see the log together
 with the associated patches use the more complex (and much more
 powerful)
 
-	git-whatchanged -p --root
+----------------
+$ git-whatchanged -p --root
+----------------
 
 and you will see exactly what has changed in the repository over its
 short history. 
@@ -547,14 +567,16 @@ it in the `.git/refs/tags/` subdirectory
 So the simplest form of tag involves nothing more than
 
 ------------------------------------------------
-git tag my-first-tag
+$ git tag my-first-tag
 ------------------------------------------------
 
 which just writes the current `HEAD` into the `.git/refs/tags/my-first-tag`
 file, after which point you can then use this symbolic name for that
 particular state. You can, for example, do
 
-	git diff my-first-tag
+----------------
+$ git diff my-first-tag
+----------------
 
 to diff your current state against that tag (which at this point will
 obviously be an empty diff, but if you continue to develop and commit
@@ -568,7 +590,9 @@ you really did
 that tag. You create these annotated tags with either the `-a` or
 `-s` flag to `git tag`:
 
-	git tag -s <tagname>
+----------------
+$ git tag -s <tagname>
+----------------
 
 which will sign the current `HEAD` (but you can also give it another
 argument that specifies the thing to tag, ie you could have tagged the
@@ -584,8 +608,8 @@ name for the state at that point.
 Copying repositories
 --------------------
 
-git repositories are normally totally self-sufficient, and it's worth noting
-that unlike CVS, for example, there is no separate notion of
+git repositories are normally totally self-sufficient and relocatable
+Unlike CVS, for example, there is no separate notion of
 "repository" and "working tree". A git repository normally *is* the
 working tree, with the local git information hidden in the `.git`
 subdirectory. There is nothing else. What you see is what you got.
@@ -602,8 +626,10 @@ This has two implications: 
 
  - if you grow bored with the tutorial repository you created (or you've
    made a mistake and want to start all over), you can just do simple
-
-	rm -rf git-tutorial
++
+----------------
+$ rm -rf git-tutorial
+----------------
 +
 and it will be gone. There's no external repository, and there's no
 history outside the project you created.
@@ -618,8 +644,10 @@ Note that when you've moved or copied a 
 file (which caches various information, notably some of the "stat"
 information for the files involved) will likely need to be refreshed.
 So after you do a `cp -a` to create a new copy, you'll want to do
-
-	git-update-index --refresh
++
+----------------
+$ git-update-index --refresh
+----------------
 +
 in the new repository to make sure that the index file is up-to-date.
 
@@ -633,8 +661,10 @@ repositories you often want to make sure
 known state (you don't know *what* they've done and not yet checked in),
 so usually you'll precede the `git-update-index` with a
 
-	git-read-tree --reset HEAD
-	git-update-index --refresh
+----------------
+$ git-read-tree --reset HEAD
+$ git-update-index --refresh
+----------------
 
 which will force a total index re-build from the tree pointed to by `HEAD`.
 It resets the index contents to `HEAD`, and then the `git-update-index`
@@ -645,7 +675,9 @@ tells you they need to be updated.
 
 The above can also be written as simply
 
-	git reset
+----------------
+$ git reset
+----------------
 
 and in fact a lot of the common git command combinations can be scripted
 with the `git xyz` interfaces.  You can learn things by just looking
@@ -665,20 +697,26 @@ first create your own subdirectory for t
 raw repository contents into the `.git` directory. For example, to
 create your own copy of the git repository, you'd do the following
 
-	mkdir my-git
-	cd my-git
-	rsync -rL rsync://rsync.kernel.org/pub/scm/git/git.git/ .git
+----------------
+$ mkdir my-git
+$ cd my-git
+$ rsync -rL rsync://rsync.kernel.org/pub/scm/git/git.git/ .git
+----------------
 
 followed by 
 
-	git-read-tree HEAD
+----------------
+$ git-read-tree HEAD
+----------------
 
 to populate the index. However, now you have populated the index, and
 you have all the git internal files, but you will notice that you don't
 actually have any of the working tree files to work on. To get
 those, you'd check them out with
 
-	git-checkout-index -u -a
+----------------
+$ git-checkout-index -u -a
+----------------
 
 where the `-u` flag means that you want the checkout to keep the index
 up-to-date (so that you don't have to refresh it afterward), and the
@@ -689,9 +727,11 @@ files). 
 
 Again, this can all be simplified with
 
-	git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git
-	cd my-git
-	git checkout
+----------------
+$ git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git
+$ cd my-git
+$ git checkout
+----------------
 
 which will end up doing all of the above for you.
 
@@ -719,7 +759,7 @@ used earlier, and create a branch in it.
 saying that you want to check out a new branch:
 
 ------------
-git checkout -b mybranch
+$ git checkout -b mybranch
 ------------
 
 will create a new branch based at the current `HEAD` position, and switch
@@ -733,7 +773,7 @@ just telling `git checkout` what the bas
 In other words, if you have an earlier tag or branch, you'd just do
 
 ------------
-git checkout -b mybranch earlier-commit
+$ git checkout -b mybranch earlier-commit
 ------------
 
 and it would create the new branch `mybranch` at the earlier commit,
@@ -743,27 +783,27 @@ and check out the state at that time.
 You can always just jump back to your original `master` branch by doing
 
 ------------
-git checkout master
+$ git checkout master
 ------------
 
 (or any other branch-name, for that matter) and if you forget which
 branch you happen to be on, a simple
 
 ------------
-ls -l .git/HEAD
+$ ls -l .git/HEAD
 ------------
 
 will tell you where it's pointing (Note that on platforms with bad or no
 symlink support, you have to execute
 
 ------------
-cat .git/HEAD
+$ cat .git/HEAD
 ------------
 
 instead). To get the list of branches you have, you can say
 
 ------------
-git branch
+$ git branch
 ------------
 
 which is nothing more than a simple script around `ls .git/refs/heads`.
@@ -773,7 +813,7 @@ Sometimes you may wish to create a new b
 checking it out and switching to it. If so, just use the command
 
 ------------
-git branch <branchname> [startingpoint]
+$ git branch <branchname> [startingpoint]
 ------------
 
 which will simply _create_ the branch, but will not do anything further. 
@@ -792,9 +832,9 @@ being the same as the original `master` 
 that branch, and do some work there.
 
 ------------------------------------------------
-git checkout mybranch
-echo "Work, work, work" >>hello
-git commit -m 'Some work.' hello
+$ git checkout mybranch
+$ echo "Work, work, work" >>hello
+$ git commit -m 'Some work.' hello
 ------------------------------------------------
 
 Here, we just added another line to `hello`, and we used a shorthand for
@@ -807,7 +847,7 @@ does some work in the original branch, a
 to the master branch, and editing the same file differently there:
 
 ------------
-git checkout master
+$ git checkout master
 ------------
 
 Here, take a moment to look at the contents of `hello`, and notice how they
@@ -815,9 +855,9 @@ don't contain the work we just did in `m
 hasn't happened in the `master` branch at all. Then do
 
 ------------
-echo "Play, play, play" >>hello
-echo "Lots of fun" >>example
-git commit -m 'Some fun.' hello example
+$ echo "Play, play, play" >>hello
+$ echo "Lots of fun" >>example
+$ git commit -m 'Some fun.' hello example
 ------------
 
 since the master branch is obviously in a much better mood.
@@ -826,7 +866,9 @@ Now, you've got two branches, and you de
 work done. Before we do that, let's introduce a cool graphical tool that
 helps you view what's going on:
 
-	gitk --all
+----------------
+$ gitk --all
+----------------
 
 will show you graphically both of your branches (that's what the `\--all`
 means: normally it will just show you your current `HEAD`) and their
@@ -840,7 +882,7 @@ script called `git merge`, which wants t
 to resolve and what the merge is all about:
 
 ------------
-git merge "Merge work in mybranch" HEAD mybranch
+$ git merge "Merge work in mybranch" HEAD mybranch
 ------------
 
 where the first argument is going to be used as the commit message if
@@ -851,6 +893,7 @@ merge will need to be fixed up by hand, 
 of it as it can automatically (which in this case is just merge the `example`
 file, which had no differences in the `mybranch` branch), and say:
 
+----------------
 	Trying really trivial in-index merge...
 	fatal: Merge requires file-level merging
 	Nope.
@@ -859,6 +902,7 @@ file, which had no differences in the `m
 	ERROR: Merge conflict in hello.
 	fatal: merge program failed
 	Automatic merge failed/prevented; fix up by hand
+----------------
 
 which is way too verbose, but it basically tells you that it failed the
 really trivial merge ("Simple merge") and did an "Automatic merge"
@@ -879,7 +923,7 @@ Work, work, work
 and once you're happy with your manual merge, just do a
 
 ------------
-git commit hello
+$ git commit hello
 ------------
 
 which will very loudly warn you that you're now committing a merge
@@ -929,17 +973,19 @@ to the `master` branch. Let's go back to
 resolve to get the "upstream changes" back to your branch.
 
 ------------
-git checkout mybranch
-git merge "Merge upstream changes." HEAD master
+$ git checkout mybranch
+$ git merge "Merge upstream changes." HEAD master
 ------------
 
 This outputs something like this (the actual commit object names
 would be different)
 
-	Updating from ae3a2da... to a80b4aa....
-	 example |    1 +
-	 hello   |    1 +
-	 2 files changed, 2 insertions(+), 0 deletions(-)
+----------------
+Updating from ae3a2da... to a80b4aa....
+ example |    1 +
+ hello   |    1 +
+ 2 files changed, 2 insertions(+), 0 deletions(-)
+----------------
 
 Because your branch did not contain anything more than what are
 already merged into the `master` branch, the resolve operation did
@@ -972,7 +1018,9 @@ followed by a `git resolve`.
 Fetching from a remote repository is done by, unsurprisingly,
 `git fetch`:
 
-	git fetch <remote-repository>
+----------------
+$ git fetch <remote-repository>
+----------------
 
 One of the following transports can be used to name the
 repository to download from:
@@ -1017,7 +1065,7 @@ This transport was designed for anonymou
 transport, it finds out the set of objects the downstream side
 lacks and transfers (close to) minimum set of objects.
 
-HTTP(s)::
+HTTP(S)::
 	`http://remote.machine/path/to/repo.git/`
 +
 HTTP and HTTPS transport are used only for downloading.  They
@@ -1047,7 +1095,9 @@ However -- it's such a common thing to `
 immediately `resolve`, that it's called `git pull`, and you can
 simply do
 
-	git pull <remote-repository>
+----------------
+$ git pull <remote-repository>
+----------------
 
 and optionally give a branch-name for the remote end as a second
 argument.
@@ -1075,8 +1125,8 @@ the remote repository URL in a file unde
 directory, like this:
 
 ------------------------------------------------
-mkdir -p .git/remotes/
-cat >.git/remotes/linus <<\EOF
+$ mkdir -p .git/remotes/
+$ cat >.git/remotes/linus <<\EOF
 URL: http://www.kernel.org/pub/scm/git/git.git/
 EOF
 ------------------------------------------------
@@ -1086,7 +1136,7 @@ The URL specified in such file can even 
 of a full URL, like this:
 
 ------------------------------------------------
-cat >.git/remotes/jgarzik <<\EOF
+$cat >.git/remotes/jgarzik <<\EOF
 URL: http://www.kernel.org/pub/scm/linux/git/jgarzik/
 EOF
 ------------------------------------------------
@@ -1299,7 +1349,7 @@ project `my-git`. After logging into the
 an empty directory:
 
 ------------
-mkdir my-git.git
+$ mkdir my-git.git
 ------------
 
 Then, make that directory into a git repository by running
@@ -1307,7 +1357,7 @@ Then, make that directory into a git rep
 `.git`, we do things slightly differently:
 
 ------------
-GIT_DIR=my-git.git git-init-db
+$ GIT_DIR=my-git.git git-init-db
 ------------
 
 Make sure this directory is available for others you want your
@@ -1333,7 +1383,7 @@ Come back to the machine you have your p
 there, run this command:
 
 ------------
-git push <public-host>:/path/to/my-git.git master
+$ git push <public-host>:/path/to/my-git.git master
 ------------
 
 This synchronizes your public repository to match the named
@@ -1345,7 +1395,7 @@ repository. Kernel.org mirror network ta
 propagation to other publicly visible machines:
 
 ------------
-git push master.kernel.org:/pub/scm/git/git.git/ 
+$ git push master.kernel.org:/pub/scm/git/git.git/ 
 ------------
 
 
@@ -1360,7 +1410,7 @@ immutable once they are created, there i
 storage by "packing them together". The command
 
 ------------
-git repack
+$ git repack
 ------------
 
 will do it for you. If you followed the tutorial examples, you
@@ -1386,7 +1436,7 @@ Once you have packed objects, you do not
 unpacked objects that are contained in the pack file anymore.
 
 ------------
-git prune-packed
+$ git prune-packed
 ------------
 
 would remove them for you.
---
0.99.9.GIT
