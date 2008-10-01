From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH, resent] fix openssl headers conflicting with custom SHA1
 implementations
Date: Wed, 01 Oct 2008 12:35:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810011222090.3635@xanadu.home>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home>
 <20080930203928.GN21310@spearce.org>
 <alpine.LFD.2.00.0809301645340.3635@xanadu.home>
 <20080930205122.GO21310@spearce.org>
 <20081001034712.GE24513@coredump.intra.peff.net>
 <20081001155458.GF21310@spearce.org>
 <20081001160418.GA13917@coredump.intra.peff.net>
 <20081001161047.GG21310@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 18:39:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl4gx-0005jQ-Jo
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 18:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbYJAQfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 12:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753097AbYJAQfh
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 12:35:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28976 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbYJAQfg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 12:35:36 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8200B7QJEJ9IE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Oct 2008 12:35:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081001161047.GG21310@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97247>

On Wed, 1 Oct 2008, Shawn O. Pearce wrote:

> Jeff King <peff@peff.net> wrote:
> > On Wed, Oct 01, 2008 at 08:54:58AM -0700, Shawn O. Pearce wrote:
> > 
> > > I think its easy enough to just rename our SHA_CTX and SHA_*
> > > functions to something more git specific.  Since its mostly a global
> > 
> > I think that is the cleanest and simplest solution. As for merging pain,
> > I think Junio would generally do a mechanical change like this as the
> > first thing after a release. However, in this case, I think we might
> > want it sooner if the conflict is causing breakage.
> 
> Oh, yea, that's probably true.  But with ARM broken according to
> Nico I'd almost just want this fixed in the upcoming 1.6.1 release.

Not only ARM, but PPC as well, and any configuration using the Mozilla 
SHA1 implementation and linking openssl (although I don't know why one 
would want that in the later case).

> Its simple enough to do.  We can even do something like this during
> the transition period until right before the 1.6.1 final:

Because it's easy to do then I'd do it sooner than later.  Right now the 
master branch is broken for ARM and PPC which is not nice.  And I don't 
think there is much work to be merged which would conflict with such a 
change.


Nicolas
