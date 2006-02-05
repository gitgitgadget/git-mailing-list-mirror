From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add a "git show" command to show a commit
Date: Sun, 5 Feb 2006 14:59:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602051458460.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
 <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
 <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
 <Pine.LNX.4.64.0602020027400.21884@g5.osdl.org> <7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602051141020.3854@g5.osdl.org> <Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
 <7vd5i1h1bx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602051451360.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:59:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5srA-0005qE-Ng
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 23:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWBEW7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 17:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWBEW7m
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 17:59:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbWBEW7l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 17:59:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k15MxcDZ009068
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Feb 2006 14:59:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k15Mxbah017446;
	Sun, 5 Feb 2006 14:59:38 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602051451360.3854@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15642>



On Sun, 5 Feb 2006, Linus Torvalds wrote:
> 
> You're right. The "--cc" should be in the default flags (instead of -p), 
> not unconditionally on the command line.

In that vein, for "git diff":

		Linus

----
diff --git a/git-diff.sh b/git-diff.sh
index 4812ae4..7b3dbe3 100755
--- a/git-diff.sh
+++ b/git-diff.sh
@@ -22,13 +22,13 @@ case "$rev" in
 	esac
 esac
 
-# If we do not have --name-status, --name-only nor -r, default to -p.
+# If we do not have --name-status, --name-only nor -r, default to --cc.
 # If we do not have -B nor -C, default to -M.
 case " $flags " in
 *" '--name-status' "* | *" '--name-only' "* | *" '-r' "* )
 	;;
 *)
-	flags="$flags'-p' " ;;
+	flags="$flags'--cc' " ;;
 esac
 case " $flags " in
 *" '-"[BCM]* | *" '--find-copies-harder' "*)
