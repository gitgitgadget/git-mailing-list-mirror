From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 01/16] refs: convert struct ref_entry to use struct
 object_id
Date: Fri, 24 Apr 2015 22:36:03 +0000
Message-ID: <20150424223603.GA322887@vauxhall.crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
 <1429745061-295908-2-git-send-email-sandals@crustytoothpaste.net>
 <CAGZ79kbjBbuE=KGrW_7a7AOCGgEJgYb9fEE_MLq89ytkaBctRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:36:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlmCm-000746-AC
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 00:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbbDXWgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 18:36:11 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:46892 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755900AbbDXWgK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 18:36:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6A5142808D;
	Fri, 24 Apr 2015 22:36:09 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>
Content-Disposition: inline
In-Reply-To: <CAGZ79kbjBbuE=KGrW_7a7AOCGgEJgYb9fEE_MLq89ytkaBctRQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267762>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 05:52:09PM -0700, Stefan Beller wrote:
> So you're switching the code for a possible future
> In an earlier series/cover letter you wrote
>=20
> > The goal of this series to improve type-checking in the codebase and to
> > make it easier to move to a different hash function if the project
> > decides to do that.  This series does not convert all of the codebase,
> > but only parts.  I've dropped some of the patches from earlier (which no
> > longer apply) and added others.
>=20
> Which yields the question if you also want to take care of the error mess=
age
> (It may not be a SHA1 any more but some $HASHFUNCTION)?

This is true.  However, I'll clean those up with a future patch series
when we get to that point.  I'll need to pass through the documentation
as well to make it accurate and consistent, and I'll want to discuss the
words we want to use before I make those changes.

> That said I'll focus on the type checking part in this review
> and not annotate the SHA1s I find any more. ;)

Please do comment on any hardcoded 20s or 40s (or quantities based off
those), as I do want to fix those up.  I want to fix up any hardcoded
assumptions we may have about the hash that don't involve text or
documentation at this point, if only for maintainability reasons.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVOsVTAAoJEL9TXYEfUvaLl/sQAIIkDirVLaNc+pWa6/CnQpT3
t7ghCzZPS/GtArccV4VMB3blx/eyo7DqUxHc8Nnhq8Q1O9PDKRH8Ki8ny5dHgu7g
rzGgoesLUFpXsBJAkT4U94GRFMyYP2VpSD8n+Pp2JfG07/hNIOu/PHeXt9fjRgBz
+BpRzO89ImfS/0nWlGKI4gaXB1UhLO0pV4zWeeKEVrgYxJ3mMct7/663L0VPR8LK
tpNX+UB+bFqAdOL1PYWEKeA0l6NND7U5B9LLfW1do0KV/MbCYNW4dftt0VSfRudW
quoOcFT0gP7vEckI6JAvl0H2QDO1ATIikejUDhjcditRxFtzsOfynLAqlU81aKEM
DLsy5WcXtEMBPP0OU+AJki8+ERe1WVUQApDmf0L+r1WgR4Cv5u2FOn+C5mp15MAw
4EmBV04ShW8jTviWeHNdxxhtUjMXNvXXZ5xdGfgOyete2HtBIsGp5NPznueIDXNS
qrdv8q+bIagxgxLxF0zzp3m88mjTwgqF8EK50bKsdV90KiZS7HznTb9jt5NppeAl
6vRAcOwf7HZmy8C+J4DnwRO5cdZxlUrcjdrC2rkKO2oK+BhPAmlCcN1G/iUHsvf+
IGNm6iDpblo6CZ0YDx4Ts/202FM4NL/boefxnjGlkUpk/DgyQl5ceDUG7YRJ+OSN
HfxabTyH7IuEjB3mJusE
=AFfT
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
