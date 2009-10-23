From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Write and Submit Your First Kernel Patch
Date: Fri, 23 Oct 2009 16:33:04 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910231621550.14365@iabervon.org>
References: <dc1d0f40910231146y14028f4el9753debdf334103@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-581943078-1256329969=:14365"
Cc: linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Kevyn-Alexandre_Par=E9?= 
	<kevyn.alexandre.pare@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 22:33:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Qoy-0006Fr-5b
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 22:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbZJWUdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 16:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbZJWUdA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 16:33:00 -0400
Received: from iabervon.org ([66.92.72.58]:34896 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbZJWUc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 16:32:59 -0400
Received: (qmail 8451 invoked by uid 1000); 23 Oct 2009 20:33:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Oct 2009 20:33:04 -0000
In-Reply-To: <dc1d0f40910231146y14028f4el9753debdf334103@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0910231633000.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131130>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-581943078-1256329969=:14365
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0910231633001.14365@iabervon.org>

On Fri, 23 Oct 2009, Kevyn-Alexandre Paré wrote:

> Hi,
> 
> Just before I send my patch I got this error with:
> ./scripts/checkpatch.pl --terse --file
> 0001-Staging-comedi-driver-fix-coding-style.patch

You're using checkpatch --file on a patch. I hope you don't intend your 
patch to be added to the kernel source as a file, but rather applied to 
the kernel source, changing other files. (I bet "gcc 0001-Staging*.patch" 
will get interesting errors, too...) The patch format adds a single 
character at the beginning of each line to say whether it's a addition, a 
deletion, or a context line, and the context lines are identified by a 
space character. This means that a blank context line consists of just 
this space character, which is therefore a trailing space. We get the same 
type of complaints when we have expected diff output in our test scripts.

I'm kind of surprised that checkpatch doesn't completely blow up when it's 
expecting a source file and getting a patch (and maybe tell you what 
you've done). But that's the source of your errors, anyway.

	-Daniel
*This .sig left intentionally blank*
--1547844168-581943078-1256329969=:14365--
