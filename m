From: Klaus Weidner <kweidner@pobox.com>
Subject: PATCH: fix cg-mkpatch "-f" option
Date: Fri, 14 Oct 2005 09:23:45 -0500
Message-ID: <20051014142345.GB30663@w-m-p.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 14 16:28:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQQVA-00009Y-JH
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 16:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVJNOYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 10:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVJNOYF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 10:24:05 -0400
Received: from mail.atsec.com ([195.30.252.105]:60904 "EHLO mail.atsec.com")
	by vger.kernel.org with ESMTP id S1750756AbVJNOYE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2005 10:24:04 -0400
Received: (qmail 14751 invoked by uid 10125); 14 Oct 2005 14:23:59 -0000
X-SpaceNet-Virusscan: Sophos Version: 3.97; Last IDE Update: 2005-10-14 15:30
    no information about results
Received: from unknown (HELO io.lan.w-m-p.com) (24.105.57.222)
  by mail.atsec.com with SMTP; 14 Oct 2005 14:23:59 -0000
X-SpaceNet-Authentification: SMTP AUTH verified <klaus@atsec.com>
Received: by io.lan.w-m-p.com (Postfix, from userid 501)
	id A09D314AF2; Fri, 14 Oct 2005 09:23:47 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10109>

Hello, 

in cogito-0.15.1, the "-f" option to specify a format string for output
filenames didn't work, it was getting an empty OPTARG. The following
patch fixes it for me.

-Klaus

--- cogito/cg-mkpatch.orig	2005-10-14 09:16:04.000000000 -0500
+++ cogito/cg-mkpatch	2005-10-14 09:16:33.000000000 -0500
@@ -119,7 +119,7 @@
 		mergebase=1
 	elif optparse -d=; then
 		outdir="$OPTARG"
-	elif optparse -f; then
+	elif optparse -f=; then
 		fileformat="$OPTARG"
 	else
 		optfail
