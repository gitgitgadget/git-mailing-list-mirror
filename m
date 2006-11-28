X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Hyphens and hiding core commands
Date: Tue, 28 Nov 2006 01:15:27 -0800
Message-ID: <7vu00k3pao.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<20061128054032.GC11122@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 09:15:45 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061128054032.GC11122@thunk.org> (Theodore Tso's message of
	"Tue, 28 Nov 2006 00:40:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32499>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goz3s-00005E-P6 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 10:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935741AbWK1JPa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 04:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935744AbWK1JPa
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 04:15:30 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52380 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S935741AbWK1JP3
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 04:15:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128091528.FFRH4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 04:15:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id s9Fc1V00Z1kojtg0000000; Tue, 28 Nov 2006
 04:15:37 -0500
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> Carl was saying that the totorial should be changed to do this.  I
> would change "perhaps" to "DEFINITELY".  

You are right.

How about doing something like this?  I tried to make it neutral
to be usable whichever default we end up taking.

---

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 35af81a..5ddd2e9 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -11,6 +11,18 @@ diff" with:
 $ man git-diff
 ------------------------------------------------
 
+It is a good idea to introduce yourself to git before doing any
+operation.  The easiest way to do so is:
+
+------------------------------------------------
+$ cat >~/.gitconfig
+[user]
+	name = Your Name Comes Here
+	email = you@yourdomain.example.com
+^D
+------------------------------------------------
+
+
 Importing a new project
 -----------------------
 
@@ -31,7 +43,8 @@ defaulting to local storage area
 
 You've now initialized the working directory--you may notice a new
 directory created, named ".git".  Tell git that you want it to track
-every file under the current directory with
+every file under the current directory with (notice the dot '.'
+that means the current directory):
 
 ------------------------------------------------
 $ git add .
@@ -40,7 +53,7 @@ $ git add .
 Finally,
 
 ------------------------------------------------
-$ git commit -a
+$ git commit
 ------------------------------------------------
 
 will prompt you for a commit message, then record the current state
@@ -55,11 +68,17 @@ $ git diff
 to review your changes.  When you're done,
 
 ------------------------------------------------
-$ git commit -a
+$ git commit file1 file2...
 ------------------------------------------------
 
 will again prompt your for a message describing the change, and then
-record the new versions of the modified files.
+record the new versions of the files you listed.  It is cumbersome
+to list all files and you can say `-a` (which stands for 'all')
+instead.
+
+------------------------------------------------
+$ git commit -a
+------------------------------------------------
 
 A note on commit messages: Though not required, it's a good idea to
 begin the commit message with a single short (less than 50 character)
@@ -75,7 +94,7 @@ $ git add path/to/new/file
 ------------------------------------------------
 
 then commit as usual.  No special command is required when removing a
-file; just remove it, then commit.
+file; just remove it, then tell `commit` about the file as usual.
 
 At any point you can view the history of your changes using
 
