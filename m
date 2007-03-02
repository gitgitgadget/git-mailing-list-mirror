From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 02 Mar 2007 15:46:26 +0100
Organization: At home
Message-ID: <es9d7l$egh$2@sea.gmane.org>
References: <20070228151516.GC57456@codelabs.ru> <200703011931.32170.andyparkins@gmail.com> <Pine.LNX.4.63.0703012140370.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200703021005.13620.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 15:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN92a-0004gC-Dx
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 15:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992494AbXCBOrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 09:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992497AbXCBOrV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 09:47:21 -0500
Received: from main.gmane.org ([80.91.229.2]:57192 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992494AbXCBOrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 09:47:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HN91j-0005Tc-Au
	for git@vger.kernel.org; Fri, 02 Mar 2007 15:46:31 +0100
Received: from host-81-190-24-11.torun.mm.pl ([81.190.24.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 15:46:31 +0100
Received: from jnareb by host-81-190-24-11.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 15:46:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-11.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41212>

Andy Parkins wrote:


> What about this though:
>  * Tag a release
>  * Export the working tree into a fresh directory
>  * Edit each source file to put the hash of the tagged revision into
>    every file.
>  * Edit the makefile to include the tag hash in the released version
>  * tar it up
>  * Release
> It's such a mundane, useless waste of time to edit the hash in by hand - why 
> can't the version control system do it?

What about this (that is roughtly what git and Linux kernel use):
 * Tag a release
 * Issue "make dist" which would automatically replace @@STH_VERSION@@
   (or ++STH_VERSION++ for example in Perl files) with result of
   "git describe" (although I think that plain old "make" also does this)
   _and_ create proper STH_VERSION file
 * tar it up using "git archive --format=tar" which would add version
   as a tar comment
 * Release
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
