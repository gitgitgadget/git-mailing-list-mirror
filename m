From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Tue, 01 May 2012 16:02:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205011547060.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
 <20120501171640.GA16623@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205011348090.21030@xanadu.home>
 <20120501193537.GA26245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 22:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJHx-0001wE-Du
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab2EAUDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 16:03:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56014 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab2EAUDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:03:03 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3D00JUG10X9N60@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2012 16:02:58 -0400 (EDT)
In-reply-to: <20120501193537.GA26245@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196737>

On Tue, 1 May 2012, Jeff King wrote:

> On Tue, May 01, 2012 at 01:59:08PM -0400, Nicolas Pitre wrote:
> 
> > One final quick test if you feel like it: I've never been sure that 
> > the last comparison in type_size_sort() is correct.  Maybe it should be 
> > the other way around.  Currently it reads:
> > 
> > 	return a < b ? -1 : (a > b);
> 
> I think it is right. At least it should put recent things near the
> front of the array, just as we are putting bigger things there.

Right.  In fact, it seems that _I_ did think about it *five* years ago 
(man... time flies by) given commit adcc70950e, and then I reversed the 
whole order in commit b904166ccb to get what we have today.

> > replace this line with:
> > 
> > 	return b < a ? -1 : (b > a);
> 
> No, it's not better. A few of the pack sizes are better, but some of
> them are worse. And the CPU times are still quite bad.

OK.  We can scratch that.


Nicolas
