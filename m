From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Mon, 25 May 2015 22:22:16 +0000
Message-ID: <20150525222215.GI26436@vauxhall.crustytoothpaste.net>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DozTQjXnjm3C9Xhk"
Cc: git@vger.kernel.org
To: Christian Brabandt <cblists@256bit.org>,
	Christian Brabandt <cb@256bit.org>
X-From: git-owner@vger.kernel.org Tue May 26 00:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx0lQ-0000JF-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 00:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbbEYWWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 18:22:25 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51077 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859AbbEYWWX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 18:22:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fd6a:414d:f0e6:5f35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7B0392808F;
	Mon, 25 May 2015 22:22:21 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Brabandt <cblists@256bit.org>,
	Christian Brabandt <cb@256bit.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269914>


--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2015 at 11:11:34PM +0200, Christian Brabandt wrote:
> Here is my use case: I have been working in a team repository,
> reformatting the source and wondered, why my reformatting did introduce
> some trailing whitespace. I suspected a bug in Vim and started to debug
> it, until I found out, that git-diff simply does not show trailing
> whitespace in the deleted lines. Therefore, I'd like to have an option,
> to also show trailing whitespace in the deleted lines of a diff. So here
> is the patch.

I like this idea.  My use case is determining whether a patch to a
pristine-tar repository introduced trailing whitespace (which is not
okay) or just left it there (which is okay).

> As far as I can see, this does not break any tests and also the
> behaviour of git-diff --check does not change.

Perhaps you'd care to implement a test or two to make sure that this
continues to work properly?

>  Documentation/config.txt | 2 ++
>  cache.h                  | 1 +
>  diff.c                   | 8 +++++++-
>  ws.c                     | 8 ++++++--
>  4 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0f668bb..f73f0f7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -670,6 +670,8 @@ core.whitespace::
>  +
>  * `blank-at-eol` treats trailing whitespaces at the end of the line
>    as an error (enabled by default).
> +* `blank-at-eol-old` like `blank-at-eol`, but for the deleted lines

You might want to insert "works" before "like" so that it's a complete
sentence.

> +  of a patch (i.e. those preceeded with a '-') (not enabled by default)

I believe this should be "preceded".
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVY6CXAAoJEL9TXYEfUvaL9dAP/1V0LucwMFMv0EiHTwseCYvq
pF0lr/Hnuyx7BboYg46aWxGxViTLc7vtyXLjccWpTGoXTP3PBB9I3GUkohEjk6gN
+uqTnZXmvykfOnIdV87kvcHCWZtZOcUJgWcTFiV5Mf+7LkMB8/CEpEImZL4cJPON
2xhUcharTFP98dFH5VDnU/Rm7EpGTZOTq9eJTtrduqLN7jwCnm2XhLLbk+wtwZ/V
hG8xnbG5/n5g5Gl0hZGP+0TC9mK2DpMKNgmqADTb76r60CbgAHYBgSzJbCyzgus0
Ow5jOyBXAcebce5500r8WeRI0UdzBnoPUH3hTz3I1+GzwQ03qMt8Cpbaa32Q8P8J
AMhGZ7uBLbi2qN5B5baJgovjbfU2FEMetVwg3T/Q2RawnOz4QqgMf+3U8c6SlKAe
0RwEZqpDeIhzTuUo6rNHMbUAAxHRnlGjKitgJUKi1PnwZQj0m/+f3I6oTvNOhYAh
TjUBPlM+OkPOypUb3lYjaRIztVDi5ZKk8sJ6vJfcNgHX59DCmtqqCAEIGrA7MpdC
dHStyVYDOwx/Y/9GlBOm3jFOzUJ4/OxbTT5a7poYcnn+67Ez2Ua9EncG0a7PSxtb
b4nvVWN4ATLYNItnqBw92ZyF4QkLHLCyYMTu/b2NEXZxOPoSJ+n4gmvlWm+obhej
i7n0HBYgpGlocr6r6rPl
=YP8O
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
