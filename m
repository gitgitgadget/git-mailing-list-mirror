From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Thu, 24 Feb 2011 13:04:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102241252000.26358@xanadu.home>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie> <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
 <20110223045143.GA11846@sigill.intra.peff.net>
 <7vlj16aeih.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102231213280.26358@xanadu.home>
 <1298502543.28664.19.camel@drew-northup.unet.maine.edu>
 <alpine.LFD.2.00.1102231908340.26358@xanadu.home>
 <1298567455.19041.39.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Feb 24 19:04:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsfYE-0003Ui-OT
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 19:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab1BXSEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 13:04:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48292 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab1BXSEW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 13:04:22 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LH400C4SVIKFWF0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 24 Feb 2011 13:03:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1298567455.19041.39.camel@drew-northup.unet.maine.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167843>

On Thu, 24 Feb 2011, Drew Northup wrote:

> 
> On Wed, 2011-02-23 at 19:14 -0500, Nicolas Pitre wrote:
> > On Wed, 23 Feb 2011, Drew Northup wrote:
> > 
> > > Besides, if we move anything around into a deeper directory structure we
> > > are inevitably going to have to deal with more recursive make problems.
> > > We can't just commit to master a tree that has everything moved about
> > > and get around to dealing with the Makefiles later.
> > 
> > The initial set of patches simply moved files into subdirectories and 
> > made the corresponding renames within the Makefile.
> > 
> > Reorganizing the Makefile into a better Makefile or sub-makefiles can be 
> > done subsequently.  That's my point.
> 
> It can be done as a separate patch, but it should all be done in the
> public branch (pu?) as atomically as possible (one merge from Junio's
> workspace). In other words, the public branch should never fail to build
> because of this work.

Who said this would fail to compile?

If you move bar.c into the foo directory, then in the existing Makefile 
you simply have to make a mechanical rename of bar.c to foo/bar.c.  
Restructuring the Makefile can be done separately from the file move 
without ever breaking the build (except for unintentional mistakes of 
course).

> As for making an authoritative publicly available branch containing this
> reorganization work (due solely to the extreme effect it will have on
> other development), I will leave it an open question as to whether this
> belongs in pu while a 1.7.5 release is still a possibility. It looks
> like a headache either way.

Oh sure.  But if we the developers of Git can't deal with that ourselves 
then it is a really good sign that our own tool is crappy in that area 
and probably needs to be improved.  Such a tree reorganization is 
something that happens in other projects as well, so it is a good 
opportunity to improve Git to cope well with such a situation if it 
isn't up to it yet.


Nicolas
