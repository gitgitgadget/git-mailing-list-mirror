From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Tue, 27 Nov 2007 11:25:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271123360.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org>
 <Pine.LNX.4.64.0711230050270.27959@racer.site>
 <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com>
 <Pine.LNX.4.64.0711230149430.27959@racer.site> <20071123205958.GC14735@spearce.org>
 <20071125170019.GB25800@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0711261647400.27959@racer.site>
 <20071127101614.GB26072@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwyZw-00078H-Sg
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbXK0LZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 06:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbXK0LZy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:25:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:46445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751261AbXK0LZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:25:53 -0500
Received: (qmail invoked by alias); 27 Nov 2007 11:25:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 27 Nov 2007 12:25:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WkjAb6ogWwqLziSNrHDZUUKatFlFpZ1CuGLAt+q
	ll7TWYd+CsrbUw
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127101614.GB26072@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66189>

Hi,

On Tue, 27 Nov 2007, Karl Hasselstr?m wrote:

> On 2007-11-26 16:48:14 +0000, Johannes Schindelin wrote:
> 
> > On Sun, 25 Nov 2007, Karl Hasselstr?m wrote:
> >
> > > On 2007-11-23 15:59:58 -0500, Shawn O. Pearce wrote:
> > >
> > > > I have been considering creating a "git-gui daemon" process that 
> > > > links to libgit.a and can be driven bidirectionally through its 
> > > > stdin/stdout. Based on git-fast-export, sorta. But I haven't even 
> > > > started it...
> > > >
> > > > But the idea is sort of what Han-Wen wants. Why should I fork 
> > > > rev-parse to get a ref value? Or update-ref to change one?
> > >
> > > Obviously, something like this would be very valuable for StGit as 
> > > well.
> >
> > Could you be a little more specific _what_ you want to do, and _how_ 
> > this could be done with fast-export | fast-import?
> 
> Currently, a single StGit command can result in quite a few invocations 
> of git-cat-file, for example, each of which forks off a new process. If 
> it could start just one daemon such as Shawn proposed, and feed it 
> simple questions and commands about blobs, trees, commits, and refs, 
> that would probably be quite a lot faster.
> 
> From what I understand, this is not something that would fit a 
> fast-export | fast-import pipeline. Which is why I didn't take the time 
> to elaborate on (or indeed find out) exactly which commands StGit would 
> like such a daemon to support.
> 
> By the way: one command one _would_ likely want in the daemon is "list 
> modified files". Being long-lived (not when driven by StGit, perhaps, 
> but definitely when driven by git-gui or qgit), the daemon would be able 
> to use inotify for that.

Ah, so you would like something like "git --interactive"?  This is indeed 
a completely different scope than the fast-export thingie, which is meant 
as kind of a mysqldump tool.  Indeed, you could use it even as a (kind of 
a) stash of the repo instead of the working tree.

Ciao,
Dscho
