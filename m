From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 2/5] implement submodule config cache for lookup of
 submodule names
Date: Thu, 5 Jun 2014 10:46:10 -0700
Message-ID: <20140605174610.GS21803@odin.tremily.us>
References: <20140605060425.GA23874@sandbox-ub>
 <20140605060750.GC23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6pbY/KU4ayLo+qis"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 19:46:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsbk2-0002G8-Ib
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 19:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbaFERqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 13:46:14 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:49947
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751655AbaFERqN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2014 13:46:13 -0400
Received: from omta09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id Adij1o0040SCNGk53hmDyL; Thu, 05 Jun 2014 17:46:13 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta09.westchester.pa.mail.comcast.net with comcast
	id AhmB1o00Q152l3L3VhmC5y; Thu, 05 Jun 2014 17:46:13 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id ABD50120A51C; Thu,  5 Jun 2014 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1401990370; bh=1fuV2HPr+Ns6BaVjzOPmEo1EtSwDH8car/xXQlUL7Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n5lmdaXZcB9foFQ2wJH+XHy8cSTBYrL3u1paGnidyL0a/ZdI3CMXxn6vLpC79CmCO
	 BC6RBtairdXCjjgdPhkPOoIk4Whri460TfZVhXxykdJ+kFPxUd0D1aO+S0Agh+VASQ
	 H05UWddvxD6cY3QvdpvTaJz8aJ5Ub/vNmqXYIWmc=
Content-Disposition: inline
In-Reply-To: <20140605060750.GC23874@sandbox-ub>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401990373;
	bh=TXDRHmCVR5bPmhGTtsTgYE1MAQ+2CU1REPfOb6zVGcY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=gZvCD4yLgOzjFYpSEepJzF1XvkbCmKOheEKYY/iMPZRrQ/JfBUvCrdYiBoaTGxAZa
	 f3j+g8MJlv7aU6jtz48rZdB6oBgKmDsmSu1qV6rV6D/aFQ/U/rHVB3sbT3jD5DuBrJ
	 Zo1bQuCDBxBemwpAoF/guMbStSt6XL/CxdWzcA+/lapEdXC88q4LB+8GSyb1Wc9ygY
	 sMRSPr19bP31gVdhUr82Oin5SA6nfFH6OZfMhbknrRSgWvhsa3dMaHEC3rqf7ju7mg
	 U3p8kr6VefzazCPBrNSBhPHrcnz2zjq0ZiYAjjlXxlVPWCH2vTSo24z6PWttUexeFN
	 Ath3A9LElBxBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250852>


--6pbY/KU4ayLo+qis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2014 at 08:07:50AM +0200, Heiko Voigt wrote:
> +The caller can look up information about submodules by using the
> +`submodule_from_path()` or `submodule_from_name()` functions.

That's for an already-known submodule.  Do we need a way to list
submodules (e.g. for 'submodule foreach' style operations) or is the
preferred way to do that just walking the tree looking for gitlinks?
The cases where .gitmodules would lead you astray (e.g. via sloppy
commits after removing a submodule) are:

* Listing a submodule that wasn't in the tree anymore.  Easy to check
  for and ignore.

* Not listing a submodule that is in the tree.  You'd need to walk the
  tree to check for this, but it's a pretty broken situation already,
  so I'd be fine just ignoring the orphaned gitlink.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--6pbY/KU4ayLo+qis
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkKziAAoJEG8/JgBt8ol8h2gP/iC9ai16sRDUVWSxaGGozPJj
9fScPAeeF7xu2QTDb8VWT3Oead+z8kIDxJNJK8pW+AutNI6IjLEUV9C0c5Mj7pJG
EMJgB9ItsfpHx9jWK1HV2rNfxlBohWIYs4156yCvBBI2t/MCL1nDZ6UtrTLBGzmM
AMCQyaQyr/ptq2PwXgBE92Va8o1kr9+UTQntNIEXq0V7qAPa9A5ifTQipT70goZI
TW0yRCy5Zzkkj5EInqPzuOqMbBmCyPUAAIrwqBk+G1ofi/VaiAw3EZeu4nUKW/YY
e1l4dlUyG57D8UTV8yDktZtpgnLq/bl/rGxtg/gawva2BAnL3dwPkQEu+apxeAZT
JK9ac2XtezmDKPG5lADD/JTlD+LB3ZWEiLNP4/1tcwMqlbGb48ABLHK3Lax6aOlu
qo4io8wfmcsCmdw3CtvhQmEvvHW55PA2LApjAs3dkeqULEeoLOpI5VEMkMwvru6f
W+zG9D1c4xgEi7aKmuvNrUeMlUzAiJ9pbk3cd3BCPfrtbZL5GZeg5ZsUv9Cb6juT
5PkFV1iejoVYpPXmXXoilHVdTwyZqc6TXFERC2yvNqUYLwW6b5MJ8V9dEwZP3oxs
yC3InmaTI4pJ/BJ2oksIWsksDMTwqEd8ElCs9B+mfpJFZmBLy6xFcZHwV5bX99Mq
nRxg4tbyEycQLy8Z8qPg
=vivj
-----END PGP SIGNATURE-----

--6pbY/KU4ayLo+qis--
