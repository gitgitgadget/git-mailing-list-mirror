From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git's directory is _prepended_ to PATH when called with an
 absolute path
Date: Wed, 22 Apr 2015 17:02:06 +0000
Message-ID: <20150422170205.GA827497@vauxhall.crustytoothpaste.net>
References: <5536C319.4000402@gmail.com>
 <20150422054737.GA11889@inner.h.apk.li>
 <553787A0.40707@gmail.com>
 <20150422153109.GO23476@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Cc: David =?utf-8?Q?Rodr=C3=ADguez?= <deivid.rodriguez@gmail.com>,
	git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yky2U-0006Di-FT
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 19:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbbDVRCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 13:02:14 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44370 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753814AbbDVRCN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 13:02:13 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3544:5b75:6b3:b192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2B2B62808D;
	Wed, 22 Apr 2015 17:02:11 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andreas Krey <a.krey@gmx.de>,
	David =?utf-8?Q?Rodr=C3=ADguez?= <deivid.rodriguez@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150422153109.GO23476@inner.h.apk.li>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267596>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 05:31:09PM +0200, Andreas Krey wrote:
> On Wed, 22 Apr 2015 08:36:00 +0000, David Rodr=C3=ADguez wrote:
> ...
> > * User is relying on a custom path to select their Ruby version. For
> > example, let's say the first folder in path is "~/.rubies/2.2.2/bin".
> > * User runs "/usr/bin/git commit" and a pre-commit hook is triggered.
> > * The pre-commit hook starts with "#!/us/bin/env ruby" to select the
> > Ruby to be used in the hook,
>=20
> Yes...but shouldn't the hook itself know which ruby version it needs?
>=20
> After all, if I go into that directory with another ruby setup in my
> PATH, the hook should still work, and presumably that requires that
> the hook itself selects its version, and not the user's context.

More generally, #!/usr/bin/env ruby is saying, "I want whatever ruby the
user chooses."  If you want a ruby that has certain gems, or certain
features (e.g. Array#to_h), then that's not what you want.
#!/usr/bin/env ruby is basically only safe if you're willing to accept
any potential version that might show up.

You can use a multiline shebang[0] if you need to execute shell code to
make the decision at runtime, such as if you need to use $HOME in the
path to your ruby, or select from multiple different options.

[0] http://rosettacode.org/wiki/Multiline_shebang
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVN9QNAAoJEL9TXYEfUvaLIjcQAK+H1hjT7RPQLOFTi5uyu9nx
g5b8qggr33goviB63+DiPF9BX3IOFukDh8gyyvJOdlm/1XU+EgY6vM6CdN2ayCw2
qP87zK45lflqV0X/tvAdjtjEGXfY0SWRvzjiLEKYXJImjuWv4kdr4+jawS+Y2d64
1peZnmi4tDBeCGU5BIoKePcrW4TF6ghFthQ6t6cP6DeaewXNG46wt8rvEWgkVdRh
md9xry6UTmEiJ0+ruirl7ZGlsWtt6y27O8EKhu/1czfgnVsN+M7y6zlWL6BfPMjg
VA3QSJJenvNxrMnp8Vk/1UeoCMAW9AYpxfV9tE9ze6zcXRwK19KCBe1Mj62FoXyC
5YFEO7toTHGdMc3u7Pr+TLLRRrGU/FR0ZHkRpNDxkMOOb4c6XwrrbfTAS6+XlMX1
eHtDEpLDLWz5biv8U8fiH82dh3v/zlxGsgNUd155Rq8lHPTLRamM8fi2goCNT8C7
7qSsMfb7hhcyEDTs+Y3uMJ6DUPmsrCQFCbThQvq98lYFA/JzOxrKxC/y1uSTrMvP
fewfz/5DTyAR0+hOOAHl61uodJ1p+nrTrf+Fo7koWdMN12agF/cElSzKOd9IJdJp
N8DbsqW/QHPn6VP+nIG54zjJ19OBwHA14aL7OdHvdZrQZl9dEu5yhHHSXQvS8seF
MXjmfb/1Y8wl0FE5S7ay
=rlTa
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
