From: "Neal Kreitzinger" <neal@rsss.com>
Subject: submodule add -f errs on un-ignored path
Date: Sat, 7 Jan 2012 16:59:50 -0600
Message-ID: <jeaip7$meo$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 00:00:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjfFI-0004hM-Ph
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 00:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab2AGXAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 18:00:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:40171 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578Ab2AGXAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 18:00:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RjfF6-0004aX-78
	for git@vger.kernel.org; Sun, 08 Jan 2012 00:00:04 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 00:00:04 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 00:00:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188088>

git submodule add tells me to use -f because the path is ignored in 
gitconfig (even though I un-ignored it in .git/info/exclude), but with -f it 
give usage error.  (git 1.7.1)  Is this rejection by git intentional or 
unexpected?  (This is my first foray into submodules.)

/etc/gitconfig is set to excludesfile that ignores:  "WebPortal/Images/" 
entry

local .git/info/exclude is set to un-ignore it:
cat .git/info/exclude
!WebPortal/Images/
!WebPortal/Images
!WebPortal\/Images\/
!WebPortal\/Images
!WebPortal\/Images/

$ git submodule add file:///home/me/super/Images.git WebPortal/Images
Adding existing repo at 'WebPortal/Images' to the index
The following paths are ignored by one of your .gitignore files:
WebPortal/Images
Use -f if you really want to add them.
fatal: no files added
Failed to add submodule 'WebPortal/Images'
$ git submodule add -f file:///home/me/super/Images.git WebPortal/Images
Usage: git submodule [--quiet] add [-b branch] [--reference <repository>] 
[--] <
repository> [<path>]
   or: git submodule [--quiet] status [--cached] [--recursive] [--] 
[<path>...]
   or: git submodule [--quiet] init [--] [<path>...]
   or: git submodule [--quiet] update [--init] [-N|--no-fetch] [--rebase] 
[--ref
erence <repository>] [--merge] [--recursive] [--] [<path>...]
   or: git submodule [--quiet] summary [--cached|--files] [--summary-limit 
<n>]
[commit] [--] [<path>...]
   or: git submodule [--quiet] foreach [--recursive] <command>
   or: git submodule [--quiet] sync [--] [<path>...]

v/r,
neal
