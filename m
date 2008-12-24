From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Dec 2008, #03; Sun, 21)
Date: Wed, 24 Dec 2008 12:55:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812241252080.30769@pacific.mpi-cbg.de>
References: <7vr641pvid.fsf@gitster.siamese.dyndns.org> <20081223120534.GA21633@coredump.intra.peff.net> <alpine.DEB.1.00.0812231725270.30769@pacific.mpi-cbg.de> <20081223163811.GA25658@coredump.intra.peff.net> <alpine.DEB.1.00.0812231746250.30769@pacific.mpi-cbg.de>
 <20081223173438.GA25699@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 24 12:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFSHA-0001Ol-12
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 12:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbYLXLuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 06:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbYLXLuZ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 06:50:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:37554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751578AbYLXLuY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 06:50:24 -0500
Received: (qmail invoked by alias); 24 Dec 2008 11:50:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 24 Dec 2008 12:50:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bwux6ocUbZgSxAUiV1z+0RrJrPBlZusQExK2dCH
	kzbOQr90ZAS9SY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081223173438.GA25699@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103859>

Hi,

On Tue, 23 Dec 2008, Jeff King wrote:

> On Tue, Dec 23, 2008 at 05:52:54PM +0100, Johannes Schindelin wrote:
> 
> > However, note that without something like core.notesref you will never 
> > be able to have private and public notes.
> > 
> > And I very much want to have private notes _and_ public notes on the 
> > very same commits of the very same branches.
> 
> Right. I think core.notesref doesn't go far enough, because it doesn't
> provide a way to talk about notes from two sources at the same time.
> Like:
> 
>   git log --pretty=format:'%N(my-private-notes:foo) %N(public-notes:bar)'

Ah.  That should be easy to do incrementally, by adding a ref_name 
parameter to the functions in notes.h, which can be NULL (falling back to 
the default ref).

> > And while I am almost sure that there is a stupid bug lurking that 
> > will kick the performance again, I think the basic design is sound, 
> > and it should be easy to modify no matter which way you want to change 
> > the behavior with regards to trees/blobs or refs.
> 
> I agree that the data structure is sound, so I can probably work on top
> of what you posted, too. I was planning on doing git-notes in C, though.

Sure.  git-notes.sh is only in shell script to provide a proof-of-concept, 
and an example how to have an ultra-narrow "checkout" of the notes ref's 
tree.

Ciao,
Dscho
