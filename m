From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Mon, 20 Dec 2010 22:28:34 +0300
Message-ID: <20101220192834.GA6464@landau.phys.spbu.ru>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
 <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
 <20101218161337.GB18643@sigill.intra.peff.net>
 <20101218205514.GA21249@landau.phys.spbu.ru>
 <7vk4j6fnta.fsf@alter.siamese.dyndns.org>
 <20101219121059.GA10985@landau.phys.spbu.ru>
 <7vd3oxdv3h.fsf@alter.siamese.dyndns.org>
 <20101220044655.GB5942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 20 20:28:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUlPd-0003nz-74
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 20:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960Ab0LTT2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 14:28:37 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:45856 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730Ab0LTT2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 14:28:36 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 82921FF6FA; Mon, 20 Dec 2010 22:28:34 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20101220044655.GB5942@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164008>

On Sun, Dec 19, 2010 at 11:46:56PM -0500, Jeff King wrote:
> On Sun, Dec 19, 2010 at 06:41:22PM -0800, Junio C Hamano wrote:
> 
> > > I'm not that familiar with git internals involved, so here is updated
> > > patch with added paragraph about "df->sha1_valid=0 means files from
> > > worktree with unknown sha1", and appropriate excerpt from Jeff's post.
> > > That's the most reasonable I could come up with.
> > [...]
> > Here is how I would describe it.
> > 
> > commit 87bb04bb760659dd33d7a173333329cd900620a9
> > Author: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> > Date:   Sat Dec 18 17:54:12 2010 +0300
> > 
> >     fill_textconv(): Don't get/put cache if sha1 is not valid
> >     
> >     When blaming files in the working tree, the filespec is marked with
> >     !sha1_valid, as we have not given the contents an object name yet.  The
> >     function to cache textconv results (keyed on the object name), however,
> >     didn't check this condition, and ended up on storing the cached result
> >     under a random object name.
> >     
> >     Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> 
> FWIW, I think that is a good description.

Junio, Jeff, thanks for re-wording it. Though I think my v2 text was
saying the same, only with more info + examples. My english is pretty
bad this days, so I kind of understand why it was tempting to be redone :)


Thanks anyway, and for picking this into next,
Kirill


P.S. somehow 'Acked-by: Jeff King <peff@peff.net>' was dropped.
