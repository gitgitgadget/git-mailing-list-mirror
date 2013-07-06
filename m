From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Sat, 6 Jul 2013 14:32:56 +0000
Message-ID: <20130706143256.GX862789@vauxhall.crustytoothpaste.net>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-2-git-send-email-artagnon@gmail.com>
 <51D82970.5070108@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dZHW955j1vPFHE0Q"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 06 16:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvTY2-0006An-LV
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 16:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963Ab3GFOdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 10:33:08 -0400
Received: from qmta13.emeryville.ca.mail.comcast.net ([76.96.27.243]:56146
	"EHLO qmta13.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750912Ab3GFOdG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jul 2013 10:33:06 -0400
Received: from omta13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by qmta13.emeryville.ca.mail.comcast.net with comcast
	id x2Lf1l00317UAYkAD2Z5Tu; Sat, 06 Jul 2013 14:33:05 +0000
Received: from castro.crustytoothpaste.net ([173.11.243.49])
	by omta13.emeryville.ca.mail.comcast.net with comcast
	id x2Z31l00K14fh3h8Z2Z4h5; Sat, 06 Jul 2013 14:33:05 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F148B28057;
	Sat,  6 Jul 2013 14:33:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51D82970.5070108@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373121185;
	bh=U8j3unNG0nsRZai9+QJakXL7XNX4iU6F61X/ac0LnDo=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=VjXi6+nLUXDzClOVaTlCGRkUvTj5x9qB9vDopEfOMhIMllb1yhzFTKYRYHrLtC9Vu
	 ewYlLuEqYGWOW1QBXlGlvTzKHpVvrCiryfU4VCJYoDurzUm2vT+3mT4z2kyX/2c2br
	 WwdSm3XbOhWSf+g9UpsN8/Pqw1YusGGosLv/wYxZvhnPTrXXP6+OVuG98Ww16xJ/9V
	 4NnM+ROnLtKuoO81ahtQnLrMDOw/QXAFdC5/HzKLxnMD2tyaidin+wjgf4Uuf+d41f
	 frWpT71DI+4ao2b5zWbCR2Mz/V0GyJ/6QhLqWJLmkKoYDhbvCcRLvjgmDjTburMwHC
	 Pq4oxfIsofwwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229702>


--dZHW955j1vPFHE0Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2013 at 04:28:00PM +0200, Torsten B=C3=B6gershausen wrote:
> On 2013-07-05 14.05, Ramkumar Ramachandra wrote:
> > Due to a recent change in the Net::SMTP::SSL module, send-email emits
> > the following ugly warning everytime a email is sent via SSL:
> >=20
> > *******************************************************************
> >  Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
> >  is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
> >  together with SSL_ca_file|SSL_ca_path for verification.
> >  If you really don't want to verify the certificate and keep the
> >  connection open to Man-In-The-Middle attacks please set
> >  SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
> > *******************************************************************
> >=20
> > Fix this by explicitly specifying SSL_verify_mode =3D> SSL_VERIFY_NONE =
in
> > Net::SMTP::SSL->start_SSL().
> >=20
> > Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > ---
> >  git-send-email.perl | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index ecbf56f..758100d 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1193,10 +1193,12 @@ X-Mailer: git-send-email $gitversion
> >  						 Debug =3D> $debug_net_smtp);
> >  			if ($smtp_encryption eq 'tls' && $smtp) {
> >  				require Net::SMTP::SSL;
> > +				use IO::Socket::SSL qw(SSL_VERIFY_NONE);
> >  				$smtp->command('STARTTLS');
> >  				$smtp->response();
> >  				if ($smtp->code =3D=3D 220) {
> > -					$smtp =3D Net::SMTP::SSL->start_SSL($smtp)
> > +					$smtp =3D Net::SMTP::SSL->start_SSL($smtp,
> > +									  SSL_verify_mode =3D> SSL_VERIFY_NONE)
> >  						or die "STARTTLS failed! ".$smtp->message;
> >  					$smtp_encryption =3D '';
> >  					# Send EHLO again to receive fresh
> >=20
> Hm, this doesn't work on my system, and t9001 fails:
>=20
> "SSL_VERIFY_PEER" is not exported by the IO::Socket::SSL module
>  "SSL_VERIFY_NONE" is not exported by the IO::Socket::SSL module
> Can't continue after import errors at /Users/tb/projects/git/git.pu/git-s=
end-email line 1090

What version of IO::Socket::SSL do you have, and what source did you get
it from?

perl -MIO::Socket::SSL -e 'print "$IO::Socket::SSL::VERSION\n";'

This should be available in 1.31 or later.  It might end up that we need
to adjust the use/require statement to require 1.31.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--dZHW955j1vPFHE0Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR2CqYAAoJEL9TXYEfUvaLqbUP/1D7TOVlfxKi0BwZ8816hbst
XFfKc2mdwpf/Qrb3oJsj49Z0+YDgwUg3lKyDC2GwPX0RxCwsyCN3R6lk+tEb+xrh
dqlO2/eiHTPr9kz3DCg8qxzL4oDLHTajOZv2TV7lY/PcnovLmbV+tSHyjfkIHde1
+vJ5XHWeGk6LA7qZNzeNjwNRAJJAS5EkixyCGyWE/PCT4JlufR1mfMGN3Ydl3+I8
SrKJP4y33e+Witv72KsPLN75re9xHr7vbKjYVdHwpMZy2VWwfWQwFGb1H9fjZOk6
GELicdvixBO0sgQHUOk7QWYDwlimE3pstgKicViKsRNyaC4Aa30L9XuCvp7nXDTv
5HjgxFAgDhEG6d8NTHBxatbVI+FblhPm7N8G+/QfGgKu8J1YJTvPH00VGv29UKY5
sLLCxx5g8wdPotQv+32w15JIjUiY5CBYEBt36CRz+OBtJNuCXKoYM7QFqS5S+inj
0Kuyflv/VO4eDjkoGRHqits87TWeU0wNEoVOo08w+Fym9jhHxuzNWtSzrpNqVdxp
vV0TdMQcILcWVZDaIBiqv5kKuXVedD5HWv1qo2rd7uAaqMTtkafwlbBwt37rH8C8
EYatchSDoZ1GxCWpTyvIXEfwb7H9Z3HhLlAKdVrTZ6YcfAjPph/VgB4BEARtX962
HxQlJLGpYYYwvJWo1YRB
=u2SF
-----END PGP SIGNATURE-----

--dZHW955j1vPFHE0Q--
