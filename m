From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git + mod_auth_kerb
Date: Tue, 22 Jul 2014 23:32:44 +0000
Message-ID: <20140722233243.GE5616@vauxhall.crustytoothpaste.net>
References: <CAPYmS35cgcEOfKvT17tULYyxL5GgXBavkD6anhV6yJtdoXVE9Q@mail.gmail.com>
 <20140721231721.GB5616@vauxhall.crustytoothpaste.net>
 <xmqqfvhtgwgp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Cc: Jean-Francois Bouchard <jfbouchard@accedian.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9jYF-0002zR-LS
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 01:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229AbaGVXcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 19:32:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49031 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757220AbaGVXcv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jul 2014 19:32:51 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:ddea:7b17:bda6:4f9d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C177E2808E;
	Tue, 22 Jul 2014 23:32:49 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Jean-Francois Bouchard <jfbouchard@accedian.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <xmqqfvhtgwgp.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254050>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2014 at 10:00:22AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > So git uses libcurl with CURLAUTH_ANY.  In order for authentication to
> > work with libcurl, you have to supply a username.  If you specify it in
> > the URL, the libcurl realizes that it can use Kerberos, and goes on its
> > merry way.
> >
> > If you don't specify the username in the URL, git notices that
> > authentication has failed, and asks the credential store for a username
> > and password.  git does not know that a password is not needed, so the
> > credential subsystem prompts for one anyway.
>=20
> Hmmm, does this hint that we might want to be able to tell the
> credential subsystem that it is sufficient to have name without
> password, or allow the credential subsystem to say "I am giving you
> sufficient information" when it returns only username without
> password?

Possibly.  In the --negotiate documentation of the curl man page, it
says:

  When using this option, you must also provide a fake -u, --user option
  to activate the authentication code properly. Sending a '-u :' is
  enough as the user name and password from the -u option aren't
  actually used.

That implies to me that setting an empty value for CURLOPT_USERNAME in
git might be sufficient to solve the problem.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTzvSbAAoJEL9TXYEfUvaLFUwP/06LNYCGKYHDuDSGTiIyuGjF
QN1JQ3AbPwZwWSh0an3FaJtkkaz+z0BHJ4JqxRJNB/P187U1jvNVVuSPwc0M2KhL
HfCtA/gvqgUIiYqTUi7admoU9UxWPL2WRa+uCRI2u2zY+najNlBYR/ZBYLCybApZ
V+o5NUZ4SPfncdF/5V9nxR0L1hB2CtxIowCbLOobW01P4VUwEgqDBgVV6SmzzMBB
j2KgL0FtN0V5u0fSqMdH844lM9UXQGr1Hk22pmGCe7AMMxC+AshYU4G98spw21W5
7n5Zp/4TODLbuXFTziKxZ8qFjNj9pSyMR9YsKHgAM27QIyBjUt2YiZY9HKovuwfo
nmof82t0jeVu66woI03wOHYiWGgYlvTwrcbRbdyN0GN31nGKraeuNHl7i1QcVzgQ
U2EsHUXJds4DoiPfxssXKqvnawvNPTE737OCYq6MeH0sRkPVpxgUVEDSBSx8Bsuy
pACdpwN5xQy/vkNG5pIGAyq9D6nO4hX4o2RmS2cGKf3wdngTttzl7wwEIxFm3Dfa
jTDJKkslonzRgfmLOeS7l9SVy8zQeWBMDIbvf8Q9HmnOdvX9/nlJTWk32E6mNZJk
v+OQfCSLlG84XHxOPU3QJNRC0aazUT2DZ3sfxfPVMnKj6lBpsT/yU0WW2F1vcPrv
QFDzqCdbuuUPLUOyVB3R
=1/kb
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
