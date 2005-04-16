From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Add --stage to show-files for new stage dircache.
Date: Sat, 16 Apr 2005 03:35:00 -0700
Message-ID: <7vfyxrau23.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
	<7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
	<Pine.LNX.4.58.0504152256520.7211@ppc970.osdl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 12:32:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMkbP-0001VT-SJ
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 12:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVDPKgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 06:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVDPKgI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 06:36:08 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:42968 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261930AbVDPKf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 06:35:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416103501.VDKX4787.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 06:35:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis2ncf8j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Apr 2005 01:12:12 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JNH" == Junio C Hamano <junkio@cox.net> writes:
>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I should make "ls-files" have a "-l" format, which shows the
LT> index and the mode for each file too.

JNH> You probably meant "ls-tree".  You used the word "mode" but it
JNH> already shows the mode so I take it to mean "stage".

I was *wrong*.  Of course you meant "show-files".

Instead of sending you an apology, I am sending you the one I
wrote myself.  Please find it in the next message ;-).

Here is its sample output.  It shows file-mode, SHA1, stage and
pathname.  I am attaching this one because this is a
verification that your read-tree -m passed the test.

$ ../show-files --stage
100664 578cc900ed980b72acfbdd1eea63e688a893c458 2 AA
100664 f355077379fce072c210628691da232b59b6f25c 3 AA
100664 d698ebc45d0edfe6e5b95aebb5983cb5c760960b 2 AN
100664 0fa6a8e41814531679e1c76e968a9066fceb689d 1 DD
100664 aff448a9467a4d83b164ef969cfe92ff18eb96be 1 DM
100664 4bfe111723f11cb4a4deec7c837e12601030285f 3 DM
100664 9b0f86e5cded99b9de3bd9d234747ec2d1a4cddd 1 DN
100664 9b0f86e5cded99b9de3bd9d234747ec2d1a4cddd 3 DN
100664 a6772f2a2c15bac796d8c7bb55885891956534cf 1 MD
100664 dc2088ce13f659f2bd554b2c1b343f4966143b9b 2 MD
100664 e4310204563a9059828644464779874c3a406fee 1 MM
100664 fe5ddcd7618d26384cf98c6fcd15780c7125e6d6 2 MM
100664 53a9d14868dbe346a9f0cf01fcda742545b55987 3 MM
100664 f48f37ea0205a7e5591777b4d3ae0d153d3ef131 1 MN
100664 d7600381b69b92f61bad50c5f8408e831b622ef0 2 MN
100664 f48f37ea0205a7e5591777b4d3ae0d153d3ef131 3 MN
100664 67fb1517ea8d59949a8e4f5f07f0422b212f64dc 3 NA
100664 0e5842253af8881b2c9f579029d7b50a8e03d7f6 1 ND
100664 0e5842253af8881b2c9f579029d7b50a8e03d7f6 2 ND
100664 0d45c04c9d05fa9c21edf95fc2c1a43519a8c440 1 NM
100664 0d45c04c9d05fa9c21edf95fc2c1a43519a8c440 2 NM
100664 849bfa41d15951f5e97cb93e22cbcc2924ce4517 3 NM
100664 83d94b8fd056921f22ad2ca0122dd7f64974be7c 0 NN

This is taken from the dircache after I ran

    $ read-tree -m O A B

using the merge testcase I prepared earlier.  Very trivial,
single ancestor O, with two branches A & B merge case.  This
covers all possible patterns, except file vs directory
conflicts.  The filenames are all two letters, first letter
being what the first branch does to that file while the second
one encodes what the second branch does to it.  The actions are:

 - A means "Added in this branch --- did not exist in the ancestor."

 - N means "No change in this branch."

 - D means "Deleted in this branch."

 - M means "Modified in this branch."

So, for example, the first branch modified file MN while the
second one did not touch it.  Of course it existed in the
ancestor.  You can see that read-tree did the right thing
because SHA1 for stage 1 and stage 3 match, and stage 2 is
different.

    100664 f48f37ea0205a7e5591777b4d3ae0d153d3ef131 1 MN
    100664 d7600381b69b92f61bad50c5f8408e831b622ef0 2 MN
    100664 f48f37ea0205a7e5591777b4d3ae0d153d3ef131 3 MN

I verified all of the above result and it shows your algorithm
is doing exactly what is expected.

For those of you who are interested, this is the recipe to
reproduce this merge testcase.  NOTE! NOTE! NOTE!  Do not run
this in your working tree, because it trashes .git in its
working directory.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

--- /dev/null
+++ generate-merge-test.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+
+: Skip execution up to <<\End_of_Commentary
+
+This directory is to hold a test case for merges.
+
+There is one ancestor (called O for Original) and two branches A
+and B derived from it.  We want to do 3-way merge between A and
+B, using O as the common ancestor.
+
+    merge A O B
+    diff3 A O B
+
+Decisions are made by comparing contents of O, A and B pathname
+by pathname.  The result is determined by the following guiding
+principle:
+
+ - If only A does something to it and B does not touch it, take
+   whatever A does.
+
+ - If only B does something to it and A does not touch it, take
+   whatever B does.
+
+ - If both A and B does something but in the same way, take
+   whatever they do.
+
+ - If A and B does something but different things, we need a
+   3-way merge:
+
+   - We cannot do anything about the following cases:
+
+     * O does not have it.  A and B both must be adding to the
+       same path independently.
+
+     * A deletes it.  B must be modifying.
+
+   - Otherwise, A and B are modifying.  Run 3-way merge.
+
+
+First, the case matrix.
+
+ - Vertical axis is for A's actions.
+ - Horizontal axis is for B's actions.
+
+.----------------------------------------------------------------.
+| A        B | No Action  |   Delete   |   Modify   |    Add     |
+|------------+------------+------------+------------+------------|
+| No Action  |            |            |            |            |
+|            | select O   | delete     | select B   | select B   |
+|            |            |            |            |            |
+|------------+------------+------------+------------+------------|
+| Delete     |            |            | ********** |    can     |
+|            | delete     | delete     | merge      |    not     |
+|            |            |            |            |  happen    |
+|------------+------------+------------+------------+------------|
+| Modify     |            | ********** | ?????????? |    can     |
+|            | select A   | merge      | select A=B |    not     |
+|            |            |            | merge      |  happen    |
+|------------+------------+------------+------------+------------|
+| Add        |            |    can     |    can     | ?????????? |
+|            | select A   |    not     |    not     | select A=B |
+|            |            |  happen    |  happen    | merge      |
+.----------------------------------------------------------------.
+
+End_of_Commentary
+
+rm -fr [NDMA][NDMA] S .git Trivial
+init-db
+
+# Original tree.
+mkdir S
+for a in N D M
+do
+    for b in N D M
+    do
+        p=$a$b
+	echo This is $p from the original tree. >$p
+	echo This is S/$p from the original tree. >S/$p
+	update-cache --add $p || exit
+	update-cache --add S/$p || exit
+    done
+done
+cat >Trivial <<\EOF
+This is a trivial merge sample text.
+Branch A is expected to upcase this word.
+There are some filler words to foil diff contexts here,
+like this one,
+and this one,
+and this one is yet another one of them.
+At the very end, here comes another line, that is
+the word, expected to be upcased by Branch B.
+This concludes the trivial merge sample file.
+EOF
+update-cache --add Trivial || exit
+tree_O=$(write-tree)
+commit_O=$(echo 'Original tree for the merge test.' | commit-tree $tree_O)
+
+# Branch A and B makes the changes according to the above matrix.
+# Branch A
+to_remove=$(echo D? S/D?)
+rm -f $to_remove
+update-cache --remove $to_remove || exit
+
+for p in M? S/M?
+do
+    echo This is modified $p in the branch A. >$p
+    update-cache $p || exit
+done
+
+for p in AN AA
+do
+    echo This is added $p in the branch A. >$p
+    update-cache --add $p || exit
+done
+mv Trivial ,,Trivial
+sed -e '/Branch A/s/word/WORD/g' <,,Trivial >Trivial
+rm -f ,,Trivial
+update-cache Trivial || exit
+
+tree_A=$(write-tree)
+commit_A=$(echo 'Branch A for the merge test.' |
+           commit-tree $tree_A -p $commit_O)
+	   
+
+# Branch B
+# Start from O
+rm -rf [NDMA][NDMA] S Trivial
+mkdir S
+../read-tree $tree_O
+checkout-cache -a
+
+to_remove=$(echo ?D S/?D)
+rm -f $to_remove
+update-cache --remove $to_remove || exit
+
+for p in ?M S/?M
+do
+    echo This is modified $p in the branch B. >$p
+    update-cache $p || exit
+done
+
+for p in NA AA
+do
+    echo This is added $p in the branch B. >$p
+    update-cache --add $p || exit
+done
+mv Trivial ,,Trivial
+sed -e '/Branch B/s/word/WORD/g' <,,Trivial >Trivial
+rm -f ,,Trivial
+update-cache Trivial || exit
+
+tree_B=$(write-tree)
+commit_B=$(echo 'Branch B for the merge test.' |
+           commit-tree $tree_B -p $commit_O)
+
+for commit in $commit_O $commit_A $commit_B
+do
+    echo ================
+    echo commit $commit
+    cat-file commit $commit
+done
+echo ================
+



