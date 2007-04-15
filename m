From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Expose subprojects as special files to "git diff" machinery
Date: Sun, 15 Apr 2007 14:03:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704151402130.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
 <200704152116.26773.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBsp-0002OA-K7
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 23:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbXDOVDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 17:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbXDOVDf
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 17:03:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36105 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbXDOVDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 17:03:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3FL3RIs025587
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Apr 2007 14:03:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3FL3Qaa020330;
	Sun, 15 Apr 2007 14:03:27 -0700
In-Reply-To: <200704152116.26773.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44527>



On Sun, 15 Apr 2007, Andy Parkins wrote:
> > 	+++ b/sub-A
> > 	@@ -1 +1 @@
> > 	-Subproject commit 2de597b5ad348b7db04bd10cdd38cd81cbc93ab5
> > 	+Subproject commit e8f11a45c5c6b9e2fec6d136d3fb5aff75393d42
> 
> Isn't this dangerous because it looks just like a normal diff with a 
> file being rewritten, when in truth it is a tree entry record being 
> rewritten.

Well, that's exactly what symlinks do too.

You have to look at the mode to know what the rewriting *means*.

But yeah, I wouldn't object at all to making it an "extended git header" 
instead (possibly just for subprojects, possibly for symlinks too)

		Linus
