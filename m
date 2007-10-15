From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 19:56:06 +0200
Message-ID: <20071015175606.GE2966@steel.home>
References: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eli Zaretskii <eliz@gnu.org>, ae@op5.se,
	tsuna@lrde.epita.fr, make-w32@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 21:02:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhUAx-0007nl-4Z
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 19:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757644AbXJOR4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 13:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757071AbXJOR4L
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 13:56:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:10021 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbXJOR4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 13:56:09 -0400
Received: from tigra.home (Fc8e3.f.strato-dslnet.de [195.4.200.227])
	by post.webmailer.de (klopstock mo11) (RZmta 13.4)
	with ESMTP id 003315j9FHoqRy ; Mon, 15 Oct 2007 19:56:07 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 28C7E277AE;
	Mon, 15 Oct 2007 19:56:07 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 060CC56D22; Mon, 15 Oct 2007 19:56:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710150217120.25221@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow2U+g=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61023>

Johannes Schindelin, Mon, Oct 15, 2007 03:22:53 +0200:
> On Sun, 14 Oct 2007, Brian Dessent wrote:
> > Johannes Schindelin wrote:
> > > The problem is that on Windows, you cannot keep a file open and delete 
> > > it at the same time.  This is an issue in Windows' equivalent of VFS.
> > > 
> > > A neat trick to work with temporary files without permission issues is 
> > > to open the file and delete it right after that.  This does not work 
> > > on Windows.
> > 
> > You can achieve the same thing on Windows with CreateFile() by setting 
> > the dwShareMode parameter to zero and setting the 
> > FILE_FLAG_DELETE_ON_CLOSE attribute on dwFlagsAndAttributes.  This 
> > results in a file that cannot be opened or read by any other process and 
> > that will be automatically deleted when all open handles are closed.
> 
> Aha.  So to support Windows, we have to wrap all sites that use that 
> trick, and special case that #ifdef __MINGW32__. 

He misunderstood. It is not what you meant. You cannot remove the open
file. What he talks about is removing the file after it is _closed_.
Junk.
