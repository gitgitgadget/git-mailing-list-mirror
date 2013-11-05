From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: error when git-diff get pipe args
Date: Tue, 5 Nov 2013 00:08:44 +0000
Message-ID: <20131105000843.GD183446@vauxhall.crustytoothpaste.net>
References: <CABk77Dj6RUaY9bBShiUJkZp0SdURCNR0SbpS3HFXdmeEAOMYow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Cc: git@vger.kernel.org
To: chunguang qu <quchunguang@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 01:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdUCS-00007L-B0
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 01:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab3KEAIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 19:08:48 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33560 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752151Ab3KEAIr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Nov 2013 19:08:47 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:b0ef:4a47:7a46:7dd2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4E2812807A;
	Tue,  5 Nov 2013 00:08:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABk77Dj6RUaY9bBShiUJkZp0SdURCNR0SbpS3HFXdmeEAOMYow@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237318>


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2013 at 08:03:28AM +0800, chunguang qu wrote:
> $ cat a
> 111
> fdsf
> 333
> $ cat b
> 111
> 222
> 333
> $ git diff a b                             # OK
> diff --git a/a b/b
> index 768560b..641d574 100644
> --- a/a
> +++ b/b
> @@ -1,3 +1,3 @@
>  111
> -fdsf
> +222
>  333
> $ git diff <(cat a) <(cat b)          # ERROR: no result print out
> diff --git a/dev/fd/63 b/dev/fd/62
> index 311e262..554e9f4 120000
> --- a/dev/fd/63
> +++ b/dev/fd/62
> @@ -1 +1 @@
> -pipe:[729963]
> \ No newline at end of file
> +pipe:[729965]
> \ No newline at end of file

This is because git diff compares symlinks instead of dereferencing
them, as diff does.  On Linux, /dev/fd is a symlink to /proc/self/fd,
and the items in that directory are all symlinks.

git diff is not generally intended to diff arbitrary files from
arbitrary locations.  For that, you want plain old diff, which works as
you expect.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSeDcLAAoJEL9TXYEfUvaLFNwQAKvYFcXUmUGzl693qk5iNki6
029R0lao9bmji5/CsgNGApIEkG7NwGIQO/RJmIIjoXoWIacjcaKa9F/a8yfAP38U
qqQEr7ovn0LfzenLXZ6w04hFi+TrIIZ14N6PwZD2Yy6M6h0RP/QxiUOPskWJhf3l
TfevSsNS2HGlOo6cJyz677pjqfhSChrD8xwiVQuKhTg8C56V5z+e9JAUVcAdHOm0
IZNVpJLpif9KMavwOyz42stk/wa81+fA3VoSk9ANcOsWtDqQM52ozir24STLCGOo
ExQclMwR7qZJMCbLbwVYO8PtcjrSsyHenUWbnDvc1c95qkAzmHThmGKsX+q5v3iF
8xYvGyUnP/SpJKvhbxA/+rUVAv9wQ63IucQpZzw3a8IslNUrrqcd9gd69CSP5FyI
2uwZ1of8OR8Z8DO1nO3vzJ3MyjORGkthtsOuhSJznNUHpvl2gdpyW7zjShLTPzkp
DfmpFG6nq3DFQg4IyBcbD7Z9f4mbYSnEfuf2gdLPRlkJ7I2nJEz06CqWxH4N1rvG
29dtWQyeRVr2rPIRvWfvLTfrNcCdEA5jTBYA32C+KbzEbHIsRneXnZnp2m2pMm9d
PZRZN46w2/lvlXd5DuFD9JYQIoaiaGUwWcrinttpkYCwcrSS6shrZIMvZrvx5Dej
1Qh+bsNhuLEfWT+EVF+C
=UDVr
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
