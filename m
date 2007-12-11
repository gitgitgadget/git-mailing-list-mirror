From: Nicolas Pitre <nico@cam.org>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 08:59:28 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712110853350.555@xanadu.home>
References: <20071022061115.GR14735@spearce.org>
 <7vodeecyni.fsf@gitster.siamese.dyndns.org>
 <7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
 <7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
 <7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
 <7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
 <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
 <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
 <7v63zjgoel.fsf@gitster.siamese.dyndns.org>
 <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
 <7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
 <7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
 <7vve78qhtf.fsf@gitster.siamese.dyndns.org>
 <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.0.99999.0712102249180.555@xanadu.home>
 <Pine.LNX.4.64.2903301355300.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 11 14:59:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J25eM-0000ML-2u
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 14:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbXLKN7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 08:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbXLKN7b
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 08:59:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9510 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbXLKN7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 08:59:31 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW0023V1J4WG10@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 08:59:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.2903301355300.27959@racer.site>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67857>

On Fri, 30 Mar 2029, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 10 Dec 2007, Nicolas Pitre wrote:
> 
> > On Mon, 10 Dec 2007, Junio C Hamano wrote:
> > 
> > > There are outstanding issues that need to be resolved:
> > > 
> > >  * We need to do something about "gc --aggressive".  The documentation
> > >    removal patch from Linus, if it ever materializes, would be better
> > >    than nothing, but I have this nagging suspicion that the explosion is
> > >    merely a bad interation between -A and -f option to the repack, which
> > >    are not meant to be used together.
> > 
> > Well, with the gcc repo, simply using 'git repack -a -f' with current 
> > default window size does produce a 2.1GB pack, while changing the window 
> > size to 100 (keeping default delta depth) produces a 400MB pack for me.
> > 
> > So this is really a matter of not having a sufficiently large window for 
> > some data sets.
> 
> So my dumb patch to simply default to window and depth 250 with 
> aggressive was not _that_ dumb after all?

Probably not, although this might be rather wasteful on some 
repositories.  But that's what expectations are for --aggressive.

I wish we could find a way to set some good window default dynamically 
though.  Or perhaps the filename hashing needs improvements.


Nicolas
