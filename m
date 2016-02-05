From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Fri, 5 Feb 2016 21:06:24 +0000
Message-ID: <20160205210623.GC7403@vauxhall.crustytoothpaste.net>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
 <xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
 <20160202232952.GA6503@vauxhall.crustytoothpaste.net>
 <CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
 <20160205204648.GA7403@vauxhall.crustytoothpaste.net>
 <xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Cc: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnaO-0000lO-CE
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217AbcBEVGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:06:31 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54598 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757161AbcBEVG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 16:06:29 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2A102282CA;
	Fri,  5 Feb 2016 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1454706387;
	bh=WATOErQ4nv5D53EPHocZPMlZ0k4/N+9N0Oz3KaR31t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=whBKSW19P0pcrzrhNzFH7BuunzzmXFU8Ng9kpieaKy6kY7EChaRHHUMHks/1IEPm0
	 LKK9PE9rFiDlKFYGpe+1inOX6p8BZEngAZ3Op1GsvIu1PyPyWcLD6Sm62i7pw89l55
	 5kTc1ipXv4fATC9n6fFkne6qdqzJZ2WP6pE+LlkC2wKJIOSy9ITClUGqdELxdD10PD
	 5+5tyUk+kA+f9++O1y64YV3q7Yc5yGC3GmUR3om2S2ji67nidp68F3BQfzMlRxk0aq
	 LNklPquwZfZa3wzbn7NxiALoMwZpSqWbptRcIyoGTVdmmAQqqkN7NRtuat33qOsmue
	 9vBgZoHGPeCCeOWOr6La6IyR1DF5iYLS3vq5ea5sP6xg4OHB1JettWNAeAPaVuJ7Kp
	 CglFapmsQOFw45Akmf+6OatlpvBEPNAkosY5CjJyrdU/4WTVFMrN7e0xKRCnFOeWOA
	 qpu7tNA2EBsgBHsPWTXnxI5Z+gh0pb2AjBjqPPGmuWF2RPzPxO7
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285633>


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 01:02:58PM -0800, Junio C Hamano wrote:
> Hmph, so documenting that <emptyname>:<emptypassword>@<repository>
> as a supported way might be an ugly-looking solution to the original
> problem.  A less ugly-looking solution might be a boolean that can
> be set per URL (we already have urlmatch-config infrastructure to
> help us do so) to tell us to pass the empty credential to lubCurl,
> bypassing the step to ask the user for password that we do not use.
>=20
> The end-result of either of these solution would strictly be better
> than the patch we discussed in that the end user will not have to
> interact with the prompt at all, right?

Yes, that's true.  I'll try to come up with a patch this weekend that
implements that (maybe remote.forceAuth =3D true or somesuch).
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWtQ7PAAoJEL9TXYEfUvaLn78P/iq+QpCJmQr71Di4ZlPAivcL
d57B+jdJ/yiMLg0hY3M9UpVX8m2kkbNObI+UpJN63zexMqRU/2vr1SOB9CpgdDJ2
5Y9dJB9yQkSpIebIwlOfmOtyPRLyVO2/FWzc3R28i5EdqrUcmuFn4nFhCRrB8T1l
fZ2P8exT7u1vb3f1iUcUo2wCFPKtjMhH/R6/YhO2FfwYiSEneuTOWwj5HjsZl/mf
5VLcr1gfjj3q1z94CKtPl7H+sUX6rhaemoXOOpQt4mZJoxP/ejgL4mIWCxjxeXBC
QjoB8UP1OU7U2b9G3G3e0A9WyM/Ahc1R9ZBvSeLsEgBXAg5u/32m5thehZb4Y5W0
qwG1egzq3HIrHxBh279SX/2yoUJaJGQqUd45Hg0tLUsrLQOYNiviaA2vhlYg954W
HqacQhjxYhK1dWvMaU1vbIhAg2WnY7LXomqUxZG+R/zY3bBgoC0qOgT6VErV1ToJ
yJ3LCs8EQllxjHuzMW3oQkwX5VERNqZFdsgrvmY5ge/sQV6SG8FUD8wfSDLW1adu
J7SEYL3XsbqnY9+cZXMiLFt3atz+H6bZq2gxssG8/Dkrk26gtlJxMfNYr31ZUy/O
Na/pWLo53z0qHDi/hhGEJcd4YedUQrSyGVGu2OhAKWa8mDgm01aTwSESZl2GARqx
Zrd4uGPtXMtfydS5l+Ge
=OuU8
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
