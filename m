From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 20:53:31 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0505262036500.16829@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 21:52:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbOOe-0005ix-VN
	for gcvg-git@gmane.org; Thu, 26 May 2005 21:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVEZTxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 15:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVEZTxz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 15:53:55 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:25014 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261557AbVEZTxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 15:53:37 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:56559)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:aia21) id 1DbOQ7-0007cu-Nm (Exim 4.51)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 26 May 2005 20:53:31 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1DbOQ7-0003Mo-81 (Exim 4.43)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 26 May 2005 20:53:31 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 26 May 2005, Linus Torvalds wrote:
> On Thu, 26 May 2005, Linus Torvalds wrote:
> > 
> > So we'd change it from
> > 
> > 	deleted file mode 100644
> > 
> > to
> > 
> > 	deleted file mode 100644 arch/um/kernel/checksum.c
> > 
> > in this case..
> 
> I just realized that this same thing is equally true of just plain mode 
> changes, where wif we don't have any content we just get
> 
> 	diff --git a/name b/name
> 	old mode xxxx
> 	new mode yyyy
> 
> so I might as well parse the diff header here (I don't want to repeat the 
> name twice for mode changes). Oh well.

Given that git already has the metadata lines in the diff ("old mode", 
"deleted file mode", etc) why not simply add another metadata line "name" 
and what follows that is the name until an end of line character (or a NUL 
if you want file names with embedded new lines).  You can then only emit 
the "name" metadata line when no actual diff is present and hence the name 
is uncertain.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
