From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sun, 19 Dec 2010 23:46:56 -0500
Message-ID: <20101220044655.GB5942@sigill.intra.peff.net>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
 <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
 <20101218161337.GB18643@sigill.intra.peff.net>
 <20101218205514.GA21249@landau.phys.spbu.ru>
 <7vk4j6fnta.fsf@alter.siamese.dyndns.org>
 <20101219121059.GA10985@landau.phys.spbu.ru>
 <7vd3oxdv3h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 05:47:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUXeL-0002TX-84
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 05:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab0LTEq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 23:46:59 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35392 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963Ab0LTEq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 23:46:59 -0500
Received: (qmail 25089 invoked by uid 111); 20 Dec 2010 04:46:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 20 Dec 2010 04:46:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Dec 2010 23:46:56 -0500
Content-Disposition: inline
In-Reply-To: <7vd3oxdv3h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163981>

On Sun, Dec 19, 2010 at 06:41:22PM -0800, Junio C Hamano wrote:

> > I'm not that familiar with git internals involved, so here is updated
> > patch with added paragraph about "df->sha1_valid=0 means files from
> > worktree with unknown sha1", and appropriate excerpt from Jeff's post.
> > That's the most reasonable I could come up with.
> [...]
> Here is how I would describe it.
> 
> commit 87bb04bb760659dd33d7a173333329cd900620a9
> Author: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> Date:   Sat Dec 18 17:54:12 2010 +0300
> 
>     fill_textconv(): Don't get/put cache if sha1 is not valid
>     
>     When blaming files in the working tree, the filespec is marked with
>     !sha1_valid, as we have not given the contents an object name yet.  The
>     function to cache textconv results (keyed on the object name), however,
>     didn't check this condition, and ended up on storing the cached result
>     under a random object name.
>     
>     Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

FWIW, I think that is a good description.

-Peff
