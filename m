From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path
 to do sparse clone
Date: Fri, 25 Jul 2008 02:12:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807250210090.4140@eeepc-johanness>
References: <20080723145718.GA29134@laptop>  <20080724171952.GB21043@sigill.intra.peff.net>  <alpine.DEB.1.00.0807241837441.8986@racer>  <20080724185332.GQ32184@machine.or.cz> <bd6139dc0807241201v50cd5ef2m58ee7efc05119e20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jul 25 02:12:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAvC-0005wF-7d
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbYGYALe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbYGYALe
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:11:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:57160 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752146AbYGYALd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:11:33 -0400
Received: (qmail invoked by alias); 25 Jul 2008 00:11:31 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp028) with SMTP; 25 Jul 2008 02:11:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YgtBs7iEY6ixevSQ4S363uk9z/AX1MJyRj3WoIW
	h3AO25g3/22vxG
X-X-Sender: user@eeepc-johanness
In-Reply-To: <bd6139dc0807241201v50cd5ef2m58ee7efc05119e20@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89981>

Hi,

On Thu, 24 Jul 2008, Sverre Rabbelier wrote:

> On Thu, Jul 24, 2008 at 8:53 PM, Petr Baudis <pasky@suse.cz> wrote:
> >  I don't follow how these two issues arise, if the server will do the 
> > pruning for you. It will just skip entering some tree objects when 
> > doing object traversal; why opening the git protocol or faking 
> > commits? This would be a simple extra capability in the protocol.
> 
> Wouldn't that be as simple as passing a pathspec to git-rev-list? Not a 
> lot of overhead there I reckon.

So the server would _not_ have to deflate the objects to inspect them?  I 
thought you knew more about Git's object database.

> > One question is what to do with delta chains including unwanted 
> > objects, but I think that given the objects' associativity for delta 
> > chains, this shouldn't be huge practical issues and it could be 
> > affordable in principle to include even unwanted objects.
> 
> Just keep them?

You'd still have to inspect the objects, which is way more work than the 
current code has to do.  Remember: in the optimal case, upload-pack does 
not more than just serve the existing deltas/base objects.

Ciao,
Dscho
