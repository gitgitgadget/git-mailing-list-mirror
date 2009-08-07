From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Fri, 7 Aug 2009 08:08:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908070806350.8306@pacific.mpi-cbg.de>
References: <op.ux8i6hrbtdk399@sirnot.private> <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de> <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net> <alpine.LFD.2.00.0908070031160.16073@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 08:08:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZIcY-0005Ck-BG
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 08:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbZHGGH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 02:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbZHGGH7
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 02:07:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:57056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752873AbZHGGH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 02:07:58 -0400
Received: (qmail invoked by alias); 07 Aug 2009 06:07:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 07 Aug 2009 08:07:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OOFUEFpROxJKZj+khoHsBZswswKURWR3YqQIm3H
	jQdhpU5REqZVGE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0908070031160.16073@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125184>

Hi,

On Fri, 7 Aug 2009, Nicolas Pitre wrote:

> On Fri, 7 Aug 2009, Sam Vilain wrote:
> 
> > Johannes Schindelin wrote:
> > >> the short answer is that cache slices are totally independant of 
> > >> pack files.
> > >>     
> > >
> > > My idea with that was that you already have a SHA-1 map in the pack 
> > > index, and if all you want to be able to accelerate the revision 
> > > walker, you'd probably need something that adds yet another mapping, 
> > > from commit to parents and tree, and from tree to sub-tree and blob 
> > > (so you can avoid unpacking commit and tree objects).
> > >   
> > 
> > Tying indexes together like that is not a good idea in the database 
> > world. Especially as in this case as Nick mentions, the domain is 
> > subtly different (ie pack vs dag). Unfortunately you just can't try to 
> > pretend that they will always be the same; you can't force a full 
> > repack on every ref change!
> 
> Right.  And the rev cache must work even if the repository is not 
> packed.

Umm, why?  AFAICT the principal purpose of the rev cache is to help work 
loads on, say, www.kernel.org.

I am unlikely to notice the improvements in my regular "git log" calls 
that only show a couple of pages before I quit the pager.

Ciao,
Dscho
