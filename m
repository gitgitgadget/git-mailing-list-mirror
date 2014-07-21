From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Documentation: fix missing text for rev-parse --verify
Date: Mon, 21 Jul 2014 23:35:55 +0000
Message-ID: <20140721233554.GC5616@vauxhall.crustytoothpaste.net>
References: <1405983635-77468-1-git-send-email-sandals@crustytoothpaste.net>
 <20140721231438.GZ12427@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 01:36:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9N7r-0006Qv-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 01:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbaGUXgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 19:36:03 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48997 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750846AbaGUXgC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2014 19:36:02 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c1ea:6730:f7e1:6379])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 148402808E;
	Mon, 21 Jul 2014 23:35:59 +0000 (UTC)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20140721231438.GZ12427@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254004>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 04:14:38PM -0700, Jonathan Nieder wrote:
> brian m. carlson wrote:
>=20
> > The caret (^) is used as a markup symbol in AsciiDoc.  Due to the
> > inability of AsciiDoc to parse a line containing an unmatched caret, it
> > omitted the line from the output, resulting in the man page missing the
> > end of a sentence.
>=20
> Wow.  Usually asciidoc is more forgiving than that.  Are there other
> pages affected by this too (e.g., "the commit HEAD^" in
> user-manual.txt)?

I didn't look at any other pages before submitting this.  I noticed when
I was looking up git rev-parse --verify on my Debian sid laptop at work.

I just looked, and the place you mentioned in user-manual.txt wasn't
affected.  It looks like this is the only place in running text that we
don't use backticks around the caret-containing text.

> > --- a/Documentation/git-rev-parse.txt
> > +++ b/Documentation/git-rev-parse.txt
> > @@ -102,7 +102,7 @@ eval "set -- $(git rev-parse --sq --prefix "$prefix=
" "$@")"
> >  +
> >  If you want to make sure that the output actually names an object in
> >  your object database and/or can be used as a specific type of object
> > -you require, you can add "^{type}" peeling operator to the parameter.
> > +you require, you can add "\^{type}" peeling operator to the parameter.
>=20
> Does using {caret} for ^ work, too?  Generally in asciidoc using a
> backslash to escape delimiter characters leads to trouble when the
> number of delimiters changes or the text is copy+pasted, since in a
> context where the backslash is unneeded it ends up being rendered as a
> literal backslash.

{caret} does not work; it leaves the sentence broken still.  `^{type}`
does work.  Since that seems a bit cleaner, and I think the resultant
formatting is fine, I'll reroll with that change.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTzaPaAAoJEL9TXYEfUvaLxREP/32oFYCZFPHeCXbW397JXMno
2Ln0soD+4sZpx4+SIC4ZydqSfG2hD1vryLHgiqGU8X+DWFNKtk3tk+Fy5ri5JAAN
1NnVBOidn5BCppAtAQMoJ+dYX7dcst0zovUgJ6ubB7ubIyDCi5hve6DwJKepiu2V
zmRgidd0+nr3rFoHzmB6RtCScXk8DIGbhNovKGeitnkkza33hQTS3M6WBwPQy4d+
Y/p1sU8OiwkSWvH9aOzLKaL7FcnMzlwc9FWwShV8SDwfR4AVudk7Oje7SBS7AZ5B
jFHQ4Jw3BZkaYHIQRliN6lu6pU5He6Uh4ZI1szhQ4uvIh5yrPWSB+AzSAyjo2co7
CS/WoTkdL0taMk7lvRb9mBde7h9XGWZiTWCHeBVJjdQPG7x6pVVk/gG/pQg5cFMZ
9nRJnpyLX6boacHaZMFbaVoEyYc9rM9DcwV6gUWCsjalfwxzzy5ZbUX9l/oGGuJA
jT+vWaQD+XJLcAKAuL2e+MUiJHJQ2phVfk3YDKOQMPH6qJsyCaH/sYWdTo+cHg1l
79Ujgdn3TpnJXeUnysKWoghLSN5eJmyUIRVgk/CeudUncG3sihqbofhOt1oLi5yD
1b71rHEVMpr625uVAbfQ8hYVs5fWFTihad+MjLlyU8RcbAwNwoGMUjN9gjTUS7df
pcyjtQ4OaW5auOcqzIyn
=bT5w
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
