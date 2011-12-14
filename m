From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Tue, 13 Dec 2011 21:33:20 -0500
Message-ID: <20111214023320.GA22141@sigill.intra.peff.net>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
 <7v7h21xps9.fsf@alter.siamese.dyndns.org>
 <4EE6E61F.8080405@alum.mit.edu>
 <7vk461vuy9.fsf@alter.siamese.dyndns.org>
 <4EE7A387.3070400@alum.mit.edu>
 <4EE7CDF2.3040408@alum.mit.edu>
 <7vzkewt5qu.fsf@alter.siamese.dyndns.org>
 <7vborct37c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 03:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raeev-0001yA-LL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 03:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab1LNCdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 21:33:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49896
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048Ab1LNCdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 21:33:23 -0500
Received: (qmail 26491 invoked by uid 107); 14 Dec 2011 02:40:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 21:40:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 21:33:20 -0500
Content-Disposition: inline
In-Reply-To: <7vborct37c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187092>

On Tue, Dec 13, 2011 at 04:19:19PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Namely, we should figure out what code wants to set extra refs and or
> >> wants to include extra refs in its iteration over references. The
> >> setters don't have to be changed, but the readers should be.
> >
> > You read me correctly. That is exactly what I meant by "extra ref API" in
> > my earlier response.
> 
> Actually, I do not think it even needs to be the "extra *REF* API". The
> only thing that matters is that these commits are considered to be extra
> anchor point in the history, in addition to the usual rule of considering
> that everything reachable from our refs is complete. The data structure to
> hold them does not even have to be a "struct ref". Just an array of object
> names (or "struct object *") should suffice.

Since my cff38a5 (receive-pack: eliminate duplicate .have refs,
2011-05-19), receive-pack simply has a packed array of binary sha1s (in
a "struct sha1_array" object). That might be the simplest thing.

-Peff
