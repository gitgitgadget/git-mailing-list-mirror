From: David =?utf-8?q?=E2=80=98Bombe=E2=80=99_Roden?= 
	<bombe@pterodactylus.net>
Subject: Re: [PATCH] handle http urls with query string ("?foo") correctly
Date: Thu, 5 Jun 2008 10:37:58 +0200
Message-ID: <200806051037.58675.bombe@pterodactylus.net>
References: <200806050128.33467.bombe@pterodactylus.net> <alpine.DEB.1.00.0806050758210.21190@racer> <7vtzg82u18.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1609164.mX3qtCb6LQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 10:39:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Azw-0007xp-7i
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 10:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbYFEIiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 04:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbYFEIiK
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 04:38:10 -0400
Received: from wing.pterodactylus.net ([89.207.253.13]:34178 "HELO
	pterodactylus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752000AbYFEIiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 04:38:09 -0400
Received: (qmail 24500 invoked from network); 5 Jun 2008 08:38:05 -0000
Received: from unknown (HELO ?192.168.178.19?) (10.98.86.10)
  by 10.98.86.1 with SMTP; 5 Jun 2008 08:38:05 -0000
User-Agent: KMail/1.9.9
In-Reply-To: <7vtzg82u18.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83882>

--nextPart1609164.mX3qtCb6LQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 05 June 2008 09:57:39 Junio C Hamano wrote:

> my understanding is that this peculiar http-hosted git repository
> takes:
> 	http://foo.bar.xz/serve.cgi?repo=3Dfoo.git/
> as the base URL, and the patch author wants us to ask for (for example)
> "info/alternates" as
> 	http://foo.bar.xz/serve.cgi/info/alternates?repo=3Dfoo.git/

Actually the base URL is more like

	http://foo.bar.xz/foo.git/0?type=3Dtext/plain

and I want to retrieve objects with

	http://foo.bar.xz/foo.git/0/info/refs?type=3Dtext/plain

but the gist is basically the same. My patch will indeed break git for URLs=
=20
like the one you gave.


>  (2) If that is indeed the issue being tackled, sorry, it is not how "dumb
>      protocol" http server is expected to behave.  Your server needs
>      fixing.
> If the protocol being used is still the "dumb commit walker" protocol,
> then, given the base URL of the repository $URL, "info/refs" must exist at
> "$URL/info/refs", and a loose object deadbeef... must exist at
> "$URL/objects/de/adbeef...".  That's how the protocol is defined.

If that is indeed the case, you're right. That could probably be tackled by=
=20
some small fixes in Freenet's http-gateway. I'll talk to the other develope=
rs=20
about that.


Thanks,

	David

--nextPart1609164.mX3qtCb6LQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhHpeYACgkQsh8Hgp5TwkOiVwCfeRdxEWOYMEUHeCOmLu/hTZDV
BQkAnjeEfI0cMqYckDn3O5nbWnRgTNCm
=dHai
-----END PGP SIGNATURE-----

--nextPart1609164.mX3qtCb6LQ--
