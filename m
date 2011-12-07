From: Jeff King <peff@peff.net>
Subject: Re: git auto-repack is broken...
Date: Wed, 7 Dec 2011 17:53:19 -0500
Message-ID: <20111207225318.GA21852@sigill.intra.peff.net>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
 <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:53:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYQMg-0004vH-2f
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757747Ab1LGWxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:53:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42926
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757465Ab1LGWxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 17:53:21 -0500
Received: (qmail 21026 invoked by uid 107); 7 Dec 2011 22:59:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 17:59:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 17:53:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186516>

On Wed, Dec 07, 2011 at 05:12:14PM -0500, Nicolas Pitre wrote:

> Maybe  FETCH_HEAD should have a reflog too?

That might be nice. However, there is a complication, in that FETCH_HEAD
may contain many sha1s, but each reflog entry only has room for a single
sha1 transition. You could obviously encode it as a series of reflog
entries, but then "git show FETCH_HEAD@{1}" is not very meaningful.

-Peff
