From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: [PATCH] builtin-mailinfo.c: Trim only first pair of square
 brackets in subject
Date: Mon, 29 Jun 2009 22:49:20 +0100
Message-ID: <20090629214919.GB5397@codelibre.net>
References: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
 <1246310220-16909-1-git-send-email-rleigh@debian.org>
 <m3ljnawx3h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Cc: Roger Leigh <rleigh@debian.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOjC-0001Ck-HF
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbZF2VtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbZF2VtT
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:49:19 -0400
Received: from nagini.codelibre.net ([80.68.93.164]:33310 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbZF2VtT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 17:49:19 -0400
Received: by nagini.codelibre.net (Postfix, from userid 107)
	id 58B3D18223; Mon, 29 Jun 2009 22:49:20 +0100 (BST)
Received: from hardknott (unknown [78.148.79.113])
	by nagini.codelibre.net (Postfix) with ESMTPSA id EA3AD181C0;
	Mon, 29 Jun 2009 22:49:19 +0100 (BST)
Received: by hardknott (Postfix, from userid 1000)
	id 44C99120C1; Mon, 29 Jun 2009 22:49:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <m3ljnawx3h.fsf@localhost.localdomain>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 19:33:15 up 8 min,  2 users,  load average: 0.92, 0.41, 0.18
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122466>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2009 at 02:26:45PM -0700, Jakub Narebski wrote:
> Roger Leigh <rleigh@debian.org> writes:
>=20
> > Use a regular expression to match text after "Re:" or any text in the
> > first pair of square brackets such as "[PATCH n/m]".  This replaces
> > the complex hairy string munging with a simple single  pattern match.
>=20
> [...]
> > +	/* Strip off 'Re:' and/or the first text in square brackets, such as
> > +	   '[PATCH]' at the start of the mail Subject. */
> > +	status =3D regcomp(&regex,
> > +			 "^([Rr]e:)?([^]]*\\[[^]]+\\])(.*)$",
> > +			 REG_EXTENDED);
>=20
> Sidenote: it probably didn't worked before either, but there are some
> broken mail readers in the wold (*cough* MS Outlook *cough*), that
> misinterpret RFCs and use translated form of "Re:" e.g. "Odp:" (Polish),
> or not strip "Re:" when replying resulting in string of "Re: Re: Re: ...",
> or use capitalized form of "Re:", i.e. "RE:", or use yet another form=20
> e.g. compact form of repeated "Re: Re: Re: ..." in form of "Re(3):".
>=20
> But I guess it didn't worked before either.

One could update the regex to cope with that easily enough such as

  "^([Rr]e:[[:space:]]*)*([^]]*\\[[^]]+\\])(.*)$"

for the "Re: Re: Re:" case, though I can't say I've seen anything
except "Re:" for years.  Maybe I just don't get mail and patches
=66rom Outlook users ;-)


Regards,
Roger

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkpJNt8ACgkQVcFcaSW/uEi5tgCeKN8Dg+KazdljHXbM0GEJUP7j
hjEAoMOtu4H6ayKUezSWtGgCdq8IvoLP
=Ov6l
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
