From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: QGit: Shrink used memory with custom git log format
Date: Wed, 28 Nov 2007 12:01:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281200070.27959@racer.site>
References: <e5bfff550711240014n78f24b46qf012957d92b1a8e1@mail.gmail.com>
 <20071127015248.GK14735@spearce.org> <Pine.LNX.4.64.0711271045430.27959@racer.site>
 <20071127191915.GB9174@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:02:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxLcD-0005bX-Am
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 13:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbXK1MBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 07:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbXK1MBq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 07:01:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:55047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754929AbXK1MBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 07:01:45 -0500
Received: (qmail invoked by alias); 28 Nov 2007 12:01:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 28 Nov 2007 13:01:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZX7ZR8nlZp/CCl4Mn35RcY+BB3PAecnWHOPru99
	SGo/g2lcbnr/RF
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127191915.GB9174@efreet.light.src>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66293>

Hi,

On Tue, 27 Nov 2007, Jan Hudec wrote:

> On Tue, Nov 27, 2007 at 10:48:00 +0000, Johannes Schindelin wrote:
> > On Mon, 26 Nov 2007, Shawn O. Pearce wrote:
> > > [...]
> > > Otherwise I think what you really want here is a libgit that you can
> > > link into your process and that can efficiently inflate an object
> > > on demand for you.  Like the work Luiz was working on this past
> > > summer for GSOC.  Lots of downsides to that current tree though...
> > > like die() kills the GUI...
> > 
> > But then, die() calls die_routine, which you can override.  And C++ has 
> > this funny exception mechanism which just begs to be used here.  The only 
> > thing you need to add is a way to flush all singletons like the object 
> > array.
> 
> Unfortunately, exceptions won't really work. Why? Because to use 
> exceptions, you need to have an exception-safe code. That is the code 
> needs to free any allocated resources when it's aborted by exception. 
> And git code is not exceptions safe. Given the lack of destructors in C, 
> it means registering all resource allocation in some kind of pool, so 
> they can be freed en masse in case of failure. Than you can also use 
> longjmp for die (for C they really behave the same).

Sorry, I just assumed that you can read my mind (or alternatively remember 
what I suggested a few months ago, namely to "override" xmalloc(), 
xcalloc(), xrealloc() and xfree() (probably you need to create the 
latter)).

Ciao,
Dscho
