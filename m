From: Christoph Egger <christoph@christoph-egger.org>
Subject: Re: [PATCH] Implement https public key pinning
Date: Mon, 15 Feb 2016 14:58:26 +0100
Organization: Privat
Message-ID: <87y4amcby5.fsf@mitoraj.siccegge.de>
References: <20160211225437.GA33955@mitoraj.siccegge.de>
	<alpine.DEB.2.20.1602120030120.5268@tvnag.unkk.fr>
	<87oabmg24u.fsf@mitoraj.siccegge.de> <20160212100226.GB13775@hank>
	<20160212183710.GC19973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 14:58:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVJfm-0001Be-Sz
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 14:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbcBON6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 08:58:39 -0500
Received: from chadwick.siccegge.de ([185.44.107.74]:20225 "EHLO
	chadwick.siccegge.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBON6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 08:58:38 -0500
Received: by chadwick.siccegge.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.86 (FreeBSD))
	(envelope-from <christoph@christoph-egger.org>)
	id 1aVJfV-0006vR-5Z; Mon, 15 Feb 2016 13:58:26 +0000
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/kfreebsd)
X-SA-Exim-Connect-IP: 131.188.6.21
X-SA-Exim-Mail-From: christoph@christoph-egger.org
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on chadwick.siccegge.de
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS
	autolearn=unavailable autolearn_force=no version=3.4.1
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on chadwick.siccegge.de)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286205>

--=-=-=
Content-Type: text/plain

Jeff King <peff@peff.net> writes:
> We can't do this perfectly, because older versions of git do not yet
> know about the option, and will therefore just silently ignore it. And
> for consistency there, we usually do the same for features that we know
> about but are unsupported.

Jep that's why I originally did it this way. But if I (the user) just
have to check the git version to know I'm fine (and not also check which
version of curl it is linked with) to be sure I'd assume that's an
improvement still.

> But I agree for something with security implications like this, we are
> better off warning when we know support is not built in. That's not
> perfect, but it's better than nothing.

I'll add an updated patch taking this into account

> I wonder if there are other options which should get the same treatment.
> Most of the obvious ones I could think of (e.g., http.sslverify) do not
> need it, because either they always have support built, or they
> fail-closed, or both.

does CURLOPT_CAPATH add to CURLOPT_CAINFO or replace it? The
documentation [0] is inconclusive to me in this regard.

  Christoph

[0] https://curl.haxx.se/libcurl/c/CURLOPT_CAPATH.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWwdmCAAoJEKv/7bJACMb5oxYP/idhMmD7hLVEdnMFaWQ/uhC6
1BvA8AQelp3G7h2kd9uonFFdTHSUYYuOHww8VNoBF/O/sYKgtjmxRwmaohNWzWRG
SRQjs0L1ey4ghc3Yni/WVku3IqHZqqD4TsBV2WcVIC8p0NH/RrfvPe4Jhn5KSvgw
Dq1ncku0mhWYl4b3rmq7DT65IlQ0QiFlxa8OZs/qfekg+xGH4YxWoCw0SuDWC9UL
PGo0XjJEz4YCDYMqEcbFbRdORnsQ1gaqAQpiUj3J2qyaeH1ADSXh6/nisQkaT6WJ
pTw7PhRzI30nkJvafig/KzxSAeV8ZhA3svE5pGVqEvCBtAg6Nh5ghslOF0O6jQWa
WNnN078HjULYRyZY0Mf5FmkcTi2FR6Emmw9kzGHtCAOlsXN3U0OHMPBcLH1zZ1Cp
Y8j4GXBWTqQ8qNZ+JP3X6vz+NI1HhCMeMwJ3yoTqfjE3uCVFLjNNN6yEDxZqKlEJ
fvU4zuxDbH8V7PKXpLLQzu4hJwkH18Q14txPBsYipxcVrZun5rfUpkQ10QAT/4gJ
PJ/g9P1RTHv8ueNeL55xZhhVcyZLOqwFoYEj/8DUcn9wloEnJcb8CSY2+XsXU+K9
UYvFXQ9F/x7Cibw2MyYnQc488cbIWHm+Sml1/dqidKIOT1+5C9a1A5R6ZbtIRCHq
tS2E9v7sccG1ECw8NRJS
=dYLL
-----END PGP SIGNATURE-----
--=-=-=--
