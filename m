From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: [PATCH] Fix git rpull.
Date: Thu, 5 May 2005 12:30:25 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0505051228170.5082@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 13:24:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTeSf-0007LZ-Me
	for gcvg-git@gmane.org; Thu, 05 May 2005 13:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVEELah (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 07:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVEELah
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 07:30:37 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:6305 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262035AbVEELaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 07:30:30 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:47317)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:aia21) id 1DTeYj-0008FH-3M (Exim 4.51)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 05 May 2005 12:30:25 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1DTeYj-0001mi-0W (Exim 4.43)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 05 May 2005 12:30:25 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Linus,

Please apply the below patch which fixes rpull.c to call git-rpush rather 
than rpush which no longer exists after the Big Rename(TM)...  Thanks.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

--- git.git/rpull.c.old	2005-05-05 12:00:07.000000000 +0100
+++ git.git/rpull.c	2005-05-05 12:00:13.000000000 +0100
@@ -43,7 +43,7 @@ int main(int argc, char **argv)
 	commit_id = argv[arg];
 	url = argv[arg + 1];
 
-	if (setup_connection(&fd_in, &fd_out, "rpush", url, arg, argv + 1))
+	if (setup_connection(&fd_in, &fd_out, "git-rpush", url, arg, argv + 1))
 		return 1;
 
 	if (pull(commit_id))
