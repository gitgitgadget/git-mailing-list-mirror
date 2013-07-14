From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Sun, 14 Jul 2013 17:03:16 +0000
Message-ID: <20130714170316.GE11097@vauxhall.crustytoothpaste.net>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-2-git-send-email-artagnon@gmail.com>
 <51D82970.5070108@web.de>
 <20130706143256.GX862789@vauxhall.crustytoothpaste.net>
 <51D83C7E.8000902@web.de>
 <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 19:03:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyPhr-0007QN-Lv
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 19:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab3GNRD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 13:03:27 -0400
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:43531
	"EHLO qmta14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751267Ab3GNRD0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jul 2013 13:03:26 -0400
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by qmta14.emeryville.ca.mail.comcast.net with comcast
	id 0Gzk1m0061Y3wxoAEH3RTA; Sun, 14 Jul 2013 17:03:25 +0000
Received: from castro.crustytoothpaste.net ([173.11.243.49])
	by omta15.emeryville.ca.mail.comcast.net with comcast
	id 0H3P1m00c14fh3h8bH3QoH; Sun, 14 Jul 2013 17:03:25 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6085D28074;
	Sun, 14 Jul 2013 17:03:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373821405;
	bh=iHydf9jW2Fdwc4R22/0X2PkFg8ypFOHoHy/g7EDen/c=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=Xu6FTXZ3C9OvTsqPSclCBfBsjZ2rPtjUW8zKzvc/pYZ2CbeJjVIuOW+lm+53VHFjH
	 pevwZ2jqQ89tm0nGFUZU2Ilgc5s83A8uZMpp8SQL8f4MWnPxtChopvcywZtuwK7GQb
	 F+bU1JxDfcIfIaQJk2KO+avSKfxNG2NGKUS7mOfCvqrP0qItoOfPmLfp82ayXsosJq
	 TkupVE5BQP+n7yJ79+9J1uEfk8OlS1L/EeQyv3ohMcAm5fRZ49tokiFou3HuTGg+T1
	 jWci3lMGsL+udJAVeQaCpn86u0qcDjKmKiKmF5nmMBmLkxO8fZkO4X/5XadctE8bxH
	 ob6m8GCuWJOeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230377>


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2013 at 07:19:10PM +0530, Ramkumar Ramachandra wrote:
> Torsten B=C3=B6gershausen wrote:
> > /usr/bin/perl -MIO::Socket::SSL -e 'print "$IO::Socket::SSL::VERSION\n"=
;'
> > 1.22
>=20
> This is ancient!  (I have 1.84).  Is it not possible to do an
> ssl-verify-peer in older versions (is it exported as something else)?
> The older versions don't display the warning anyway, and this series
> is about squelching the warning in newer versions.  Does
>=20
>   require IO::Socket::SSL qw(SSL_VERIFY_NONE SSL_VERIFY_PEER) or print
> "warning: not using SSL_VERIFY_PEER due to outdated IO::Socket::SSL"

require doesn't take a list of symbols to import, and the import dies if
it fails.  You need:

require IO::Socket::SSL;
eval {
	IO::Socket::SSL->import(qw(SSL_VERIFY_NONE SSL_VERIFY_PEER));
};
if ($@) {
	warn "Not using SSL_VERIFY_PEER due to outdated IO::Socket::SSL\n";
	# Do something different here.
}

I didn't stick the require in the eval because git-send-email will fail
in this case anyway if you don't have it, since Net::SMTP::SSL requires
it.  Let me know if you want a patch for this on top of the existing two
in this series and I'll provide one.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR4tnUAAoJEL9TXYEfUvaL4yQP/3b8jSDUyg95nu1rIyiO0aKe
G5ssBRtDoG9KbOSz0Y2MJSeqbXDddbpqT9LDoT4uOOTqPZYAKHAZPJ+G2FXyxPrd
3dPa4CbplmZF/gne70Q1lzxrf6vIVoQaLNmsxadEiFSvMg5sMS1KzO1AjEzKlr7y
/lrD5GNrVl6LP3tbD28+ipQpRVMRTBKKylzoayAq+q7ZwwF2Yq7RzTS7ypx2LJwJ
moSzUK3A1s9fLXWFq7AVGEZMqPuFG+5WV8/SdEUoej+pS+j7BmbzdxQIOymanQWB
pezyZxHDAUMmVTxbp2vhmvvKAaWZalTRwIssVY45eSv4Ppcpopt8Cr8cadebmBEF
bmEyXfkaMdwQzU2va9eHEIUVqfmmFQceGGeXfcqGw4B3TpKuy0O+iUnkQxm3FIQI
UsLLTSLZFEqJGk0iOQkXKT1c1YHxp9IunBGNX7OhYIbyT1E5OcZcuTOEIRQoMwCT
9zXz7kNhzZ5S49iBfBkqLTa6GkamgQBdj7+mu9M25jDG/GnCGp9yZiclO7RYAktn
194/GEOLVbQHkqIjaNH3apmZnUGj7yZB0dQM+eb6t5OsGzJEXIwGQk8e4zRuzLg1
ti3Xw4ohFy8SwxSC9OVSVZvRYuGmTOi/L8vvAw5kkL91CVTUpu9b+xm3/XaPij0R
ZRO7dYuezX5f15I25hjy
=Clt2
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
