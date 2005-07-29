From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tutorial problem a/a a/b
Date: Thu, 28 Jul 2005 22:35:14 -0700
Message-ID: <7vy87qkwdp.fsf@assigned-by-dhcp.cox.net>
References: <1122582005.12374.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 07:37:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyNYQ-0003wV-PZ
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 07:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVG2Fgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 01:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVG2Fgl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 01:36:41 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41163 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262370AbVG2FfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 01:35:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729053512.GSIT1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 01:35:12 -0400
To: Darrin Thompson <darrint@progeny.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Darrin Thompson <darrint@progeny.com> writes:

> In the tutorial the user is instructed to create two files: a and b.
>
> Then when the user diffs the files, they see this:
>
> diff --git a/a b/a
>
> That really confused somebody and I had to untangle their brain. :-)

Yes I was confused when I read it for the first time.
How does this look?

------------
[PATCH] Tutorial: use a bit longer sample filenames.

Darrin Thompson noticed when he was showing off GIT to others
that the use of filenames "a" and "b" in the tutorial example
was unnecessarily confusing, especially with our "patch -p1"
prefix a/ and b/, without giving us any patch.  I was very
tempted to change them back to l/ and k/ prefixes, but decided
to restrain myself and update the tutorial instead ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
*** Linus CC'ed for a historical amusement value.

 Documentation/tutorial.txt |   80 ++++++++++++++++++++++----------------------
 1 files changed, 40 insertions(+), 40 deletions(-)

0f6aa6e8db2321678645a979aa3777ed9f852a43
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -104,8 +104,8 @@ Start off with just creating any random 
 in your git archive. We'll start off with a few bad examples, just to
 get a feel for how this works:
 
-	echo "Hello World" > a
-	echo "Silly example" > b
+	echo "Hello World" >hello
+	echo "Silly example" >example
 
 you have now created two files in your working directory, but to
 actually check in your hard work, you will have to go through two steps:
@@ -125,7 +125,7 @@ adding a new entry with the "--add" flag
 
 So to populate the index with the two files you just created, you can do
 
-	git-update-cache --add a b
+	git-update-cache --add hello example
 
 and you have now told git to track those two files.
 
@@ -155,11 +155,11 @@ regular file), and you can see the conte
 	git-cat-file "blob" 557db03de997c86a4a028e1ebd3a1ceb225be238
 
 which will print out "Hello World".  The object 557db...  is nothing
-more than the contents of your file "a". 
+more than the contents of your file "hello". 
 
-[ Digression: don't confuse that object with the file "a" itself.  The
+[ Digression: don't confuse that object with the file "hello" itself.  The
   object is literally just those specific _contents_ of the file, and
-  however much you later change the contents in file "a", the object we
+  however much you later change the contents in file "hello", the object we
   just looked at will never change.  Objects are immutable.  ]
 
 Anyway, as we mentioned previously, you normally never actually take a
@@ -180,11 +180,11 @@ However, since git knows about them, you
 most basic git commands to manipulate the files or look at their status. 
 
 In particular, let's not even check in the two files into git yet, we'll
-start off by adding another line to "a" first:
+start off by adding another line to "hello" first:
 
-	echo "It's a new day for git" >> a
+	echo "It's a new day for git" >>hello
 
-and you can now, since you told git about the previous state of "a", ask
+and you can now, since you told git about the previous state of "hello", ask
 git what has changed in the tree compared to your old index, using the
 "git-diff-files" command:
 
@@ -192,7 +192,7 @@ git what has changed in the tree compare
 
 oops.  That wasn't very readable.  It just spit out its own internal
 version of a "diff", but that internal version really just tells you
-that it has noticed that "a" has been modified, and that the old object
+that it has noticed that "hello" has been modified, and that the old object
 contents it had have been replaced with something else.
 
 To make it readable, we can tell git-diff-files to output the
@@ -202,14 +202,14 @@ differences as a patch, using the "-p" f
 
 which will spit out
 
-	diff --git a/a b/a
-	--- a/a
-	+++ b/a
+	diff --git a/hello b/hello
+	--- a/hello
+	+++ b/hello
 	@@ -1 +1,2 @@
 	 Hello World
 	+It's a new day for git
 
-ie the diff of the change we caused by adding another line to "a".
+ie the diff of the change we caused by adding another line to "hello".
 
 In other words, git-diff-files always shows us the difference between
 what is recorded in the index, and what is currently in the working
@@ -243,10 +243,10 @@ creating the equivalent of a git "direct
 and this will just output the name of the resulting tree, in this case
 (if you have does exactly as I've described) it should be
 
-	3ede4ed7e895432c0a247f09d71a76db53bd0fa4
+	8988da15d077d4829fc51d8544c097def6644dbb
 
 which is another incomprehensible object name. Again, if you want to,
-you can use "git-cat-file -t 3ede4.." to see that this time the object
+you can use "git-cat-file -t 8988d.." to see that this time the object
 is not a "blob" object, but a "tree" object (you can also use
 git-cat-file to actually output the raw object contents, but you'll see
 mainly a binary mess, so that's less interesting).
@@ -273,7 +273,7 @@ shell pipeline:
 
 which will say:
 
-	Committing initial tree 3ede4ed7e895432c0a247f09d71a76db53bd0fa4
+	Committing initial tree 8988da15d077d4829fc51d8544c097def6644dbb
 
 just to warn you about the fact that it created a totally new commit
 that is not related to anything else. Normally you do this only _once_
@@ -293,13 +293,13 @@ instead, and it would have done the abov
 	Making a change
 	---------------
 
-Remember how we did the "git-update-cache" on file "a" and then we
-changed "a" afterward, and could compare the new state of "a" with the
+Remember how we did the "git-update-cache" on file "hello" and then we
+changed "hello" afterward, and could compare the new state of "hello" with the
 state we saved in the index file? 
 
 Further, remember how I said that "git-write-tree" writes the contents
 of the _index_ file to the tree, and thus what we just committed was in
-fact the _original_ contents of the file "a", not the new ones. We did
+fact the _original_ contents of the file "hello", not the new ones. We did
 that on purpose, to show the difference between the index state, and the
 state in the working directory, and how they don't have to match, even
 when we commit things.
@@ -362,19 +362,19 @@ in the working directory that we want to
 work through the index file, so the first thing we need to do is to
 update the index cache:
 
-	git-update-cache a
+	git-update-cache hello
 
 (note how we didn't need the "--add" flag this time, since git knew
 about the file already).
 
 Note what happens to the different git-diff-xxx versions here.  After
-we've updated "a" in the index, "git-diff-files -p" now shows no
+we've updated "hello" in the index, "git-diff-files -p" now shows no
 differences, but "git-diff-cache -p HEAD" still _does_ show that the
 current state is different from the state we committed.  In fact, now
 "git-diff-cache" shows the same difference whether we use the "--cached"
 flag or not, since now the index is coherent with the working directory. 
 
-Now, since we've updated "a" in the index, we can commit the new
+Now, since we've updated "hello" in the index, we can commit the new
 version.  We could do it by writing the tree by hand again, and
 committing the tree (this time we'd have to use the "-p HEAD" flag to
 tell commit that the HEAD was the _parent_ of the new commit, and that
@@ -585,7 +585,7 @@ create your own copy of the git reposito
 
 	mkdir my-git
 	cd my-git
-	rsync -rL rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git .git
+	rsync -rL rsync://rsync.kernel.org/pub/scm/git/git.git/ .git
 
 followed by 
 
@@ -683,12 +683,12 @@ being the same as the original "master" 
 that branch, and do some work there.
 
 	git checkout mybranch
-	echo "Work, work, work" >> a
-	git commit a
+	echo "Work, work, work" >>hello
+	git commit hello
 
-Here, we just added another line to "a", and we used a shorthand for
-both going a "git-update-cache a" and "git commit" by just giving the
-filename directly to "git commit". 
+Here, we just added another line to "hello", and we used a shorthand for
+both going a "git-update-cache hello" and "git commit" by just giving the
+filename directly to "git commit".
 
 Now, to make it a bit more interesting, let's assume that somebody else
 does some work in the original branch, and simulate that by going back
@@ -696,13 +696,13 @@ to the master branch, and editing the sa
 
 	git checkout master
 
-Here, take a moment to look at the contents of "a", and notice how they
+Here, take a moment to look at the contents of "hello", and notice how they
 don't contain the work we just did in "mybranch" - because that work
 hasn't happened in the "master" branch at all. Then do
 
-	echo "Play, play, play" >> a
-	echo "Lots of fun" >> b
-	git commit a b
+	echo "Play, play, play" >>hello
+	echo "Lots of fun" >>example
+	git commit hello example
 
 since the master branch is obviously in a much better mood.
 
@@ -734,20 +734,20 @@ of it as it can automatically (which in 
 file, which had no differences in the "mybranch" branch), and say:
 
 	Simple merge failed, trying Automatic merge
-	Auto-merging a.
+	Auto-merging hello.
 	merge: warning: conflicts during merge
-	ERROR: Merge conflict in a.
+	ERROR: Merge conflict in hello.
 	fatal: merge program failed
 	Automatic merge failed, fix up by hand
 
 which is way too verbose, but it basically tells you that it failed the
 really trivial merge ("Simple merge") and did an "Automatic merge"
-instead, but that too failed due to conflicts in "a".
+instead, but that too failed due to conflicts in "hello".
 
-Not to worry. It left the (trivial) conflict in "a" in the same form you
+Not to worry. It left the (trivial) conflict in "hello" in the same form you
 should already be well used to if you've ever used CVS, so let's just
-open "a" in our editor (whatever that may be), and fix it up somehow.
-I'd suggest just making it so that "a" contains all four lines:
+open "hello" in our editor (whatever that may be), and fix it up somehow.
+I'd suggest just making it so that "hello" contains all four lines:
 
 	Hello World
 	It's a new day for git
@@ -756,7 +756,7 @@ I'd suggest just making it so that "a" c
 
 and once you're happy with your manual merge, just do a
 
-	git commit a
+	git commit hello
 
 which will very loudly warn you that you're now committing a merge
 (which is correct, so never mind), and you can write a small merge
