From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 14:21:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161419140.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <2EA3BEC9-5B13-44D3-B190-CA77499F642C@zib.de>
 <Pine.LNX.4.64.0710161331440.25221@racer.site> <4D822762-D344-465E-B77D-90A64D61F5A9@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Eli Zaretskii <eliz@gnu.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>, tsuna@lrde.epita.fr,
	Andreas Ericsson <ae@op5.se>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmNB-0005q8-D7
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbXJPNWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbXJPNWB
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:22:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:54153 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932325AbXJPNWA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:22:00 -0400
Received: (qmail invoked by alias); 16 Oct 2007 13:21:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 16 Oct 2007 15:21:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WAO5Qzf8WbCxa3WjmWqCgExhMSD1T6AktwGvO9Q
	Vm7mc1/VYdoLgu
X-X-Sender: gene099@racer.site
In-Reply-To: <4D822762-D344-465E-B77D-90A64D61F5A9@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61169>

Hi,

On Tue, 16 Oct 2007, Steffen Prohaska wrote:

> On Oct 16, 2007, at 2:33 PM, Johannes Schindelin wrote:
> 
> > > Maybe we need a configuration similar to core.autocrlf (which controls
> > > newline conversion) to control filename comparison and normalization?
> > > 
> > > Most obviously for the case (in-)sensitivity on Windows, but I also
> > > remember the unicode normalization happening on Mac's HFS filesystem
> > > that caused trouble in the past.
> > 
> > Robin Rosenberg has some preliminary code for that.  The idea is to wrap
> > all filesystem operations in cache.h, and do a filename normalisation
> > first.
> 
> At that point we could add a safety check. Paths that differ only by
> case, or whitespace, or ... (add general and project specific rules here)
> should be denied. This would guarantee that tree objects can always be
> checked out. Even if the filesystem capabilities are limited.

This would be an independent change.  The method I talked about only ever 
looks at one filename, never what is already there.

What you want would probably be all too easy with a pre-commit hook.  No 
need to clutter the git-core with code that is usually not needed (you'd 
only ever activate it on Linux when other developers use Windows or 
MacOSX).

Ciao,
Dscho
