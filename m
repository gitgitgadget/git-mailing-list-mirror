From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] sha1-lookup: fix handling of duplicates in sha1_pos()
Date: Wed, 1 Oct 2014 08:33:44 -0400
Message-ID: <20141001123343.GA10772@peff.net>
References: <542BCBFC.5000509@web.de>
 <542BCCB9.4050908@web.de>
 <20141001105006.GB10332@peff.net>
 <542BE114.9070300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 14:33:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZJ6M-0006eu-3s
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 14:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaJAMdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 08:33:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:53645 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751063AbaJAMdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 08:33:45 -0400
Received: (qmail 21564 invoked by uid 102); 1 Oct 2014 12:33:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 07:33:45 -0500
Received: (qmail 26354 invoked by uid 107); 1 Oct 2014 12:33:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 08:33:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2014 08:33:44 -0400
Content-Disposition: inline
In-Reply-To: <542BE114.9070300@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257746>

On Wed, Oct 01, 2014 at 01:10:12PM +0200, Ren=C3=A9 Scharfe wrote:

> >I wonder if it is worth adding a test (you test only that "not found=
"
> >produces a negative index, but not which index). Like:
>=20
> api-sha1-array.txt says about sha1_array_lookup: "If not found, retur=
ns a
> negative integer", and that's what the test checks.

Hmm. I do not recall intentionally leaving the value unspecified; I
think it is more that I was simply not thorough when writing the
documentation. That being said...

> I actually like that the value is not specified for that case because=
 no
> existing caller actually uses it and it leaves room to implement the
> function e.g. using bsearch(3).

Yeah, if no callers actually care right now, that is a reasonable
argument for leaving the exact return value unspecified (and testing
only what the documentation claims).

> I agree that adding a "lookup non-existing entry with duplicates" tes=
t would
> make t0064 more complete, though.

Agreed.

-Peff
