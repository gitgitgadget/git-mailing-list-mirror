From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: C standard compliance?
Date: Wed, 29 Jan 2014 23:33:21 +0000
Message-ID: <20140129233321.GC91854@vauxhall.crustytoothpaste.net>
References: <87iot25y0r.fsf@fencepost.gnu.org>
 <xmqqwqhiikpg.fsf@gitster.dls.corp.google.com>
 <87eh3q5x42.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 30 00:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8edR-0001Ue-45
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 00:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbaA2Xd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 18:33:29 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51464 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126AbaA2Xd2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jan 2014 18:33:28 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f5a9:eaf8:ef0c:ad71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9F2E428071
	for <git@vger.kernel.org>; Wed, 29 Jan 2014 23:33:25 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87eh3q5x42.fsf@fencepost.gnu.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241231>


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2014 at 09:52:45PM +0100, David Kastrup wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Hmm... if you were to implement a set of pointers in such a way that
> > you can cheaply tell if an unknown pointer belongs to that set, you
> > would use a hashtable, keyed with something that is derived from the
> > value of the pointer casted to uintptr_t, I would think.
>=20
> The types intptr_t and uintptr_t are optional in ISO/IEC 9899:1999
> (C99).  So it would seem that I'd be covering fewer cases rather than
> more in that manner.

I think we already use uintptr_t in the codebase, and if it's not
present, we typedef it to unsigned long.  So I think it should be fine
(and well-defined) if instead of doing

  void *p, *q;
  ...
  if (p < q)
    ...

you do:

  void *p, *q;
  ...
  if ((uintptr_t)p < (uintptr_t)q)
    ...

Then on those systems where the compiler has some bizarre undefined
behavior checking, the code will work.  On systems that don't have
uintptr_t, the compiler is probably not smart enough to perform such a
check anyway.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS6Y/BAAoJEL9TXYEfUvaLr5cQAMsY6hp7isor2ecLgqXQ4sMr
Nnt3lW8LEk2cBnH6I86VZBlWbz1c6aDVoZnyJk0TL62m3CYZbLYnSV0yfEqgIAGN
7ktrUzW9GwWweOPphxsU63Uk1ydfUcsQ13vGyHAcCWmwqCIMsfztl6YgQ0Arb97+
hrshD3+rhbLwB9pivmkAeu74NNUMLSZi2lEgrOVXD4JCUBSDziF00gcBlvFGaGjP
Cktzv0tc6l72jnZDbODtbx5Jd9k6SMCHAhDmE8RSEwuLMtm1Yi1ja4wbVWPSuUOd
EWOq/U9AXrYA7yPfTT20Vr9IF+qGhvBJ5KhWSb6oNNoxryQra0p2niE7c7hmujf0
Y66qxhu2VflFYjvQugQXDDTMU6OHv70mtEEawXbfERFLCcH44ZlU2EW6nCCqoZhh
wy35r0hTe4trGMwitnbe43IpsxhvsKc/eaM1r8STJALRT5nTmpdd0aJEGwVsTWcE
spTQJpHIFCPP56AgBfQcVZc1e7V5+WkW45pINDr0FjFnfg9uy+KqeWuEhbgHz9/0
LDvtoxCKCFnwHjzB68xrXSqrkAEqoYJBWKUFKSTDC1xQ7PxjQkVt8lQDP8uJIKs/
XtekWCqTt3pLJroDRZNlsfEHfGWDnz5Z3zECsykh4blcv6gCCuEZMbC2Sj+RV/b6
vpLHDjxoIXdijXW2Dj1n
=r//e
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
