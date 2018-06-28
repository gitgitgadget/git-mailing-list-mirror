Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917DD1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 02:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeF1Coy (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 22:44:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47470 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752384AbeF1Cox (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 22:44:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc1e:cd98:6cd:4087])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 85E7E60102;
        Thu, 28 Jun 2018 02:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530153892;
        bh=zHcXA0AeUs1VA8S20oyBPm0EOvXMm0t38UNnMaxCniw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=efML8yfz/Z173MK01YghYBOM/nBgrAWQLzaHAJFIdQS9an7IMxvd4vESwvc6FVM6R
         qw7Ljl2HaigQbx1eAt790fdw1ZgARrbeQ82u9ynXG1Z9ckxUvSAbOmOiJiFWllMhM7
         7RmhkEx02vjAMTmWfRMzZMU/EXdmC6djgP0bBW3fCHsQWYREZl6/NxlrQy+hW6dlAu
         j6MjSOPR/16OupcyjHW2hgVFK66oXw3iDcnRXfS11ywSROjd/03sQ1JWwsbtAGpH50
         90vqcZDEOZj3O+jeLICZLEFLoPEAr2MylOuA4iHeyBX5zv9QVuMEei9MC0F4FRkMkv
         ZqfkdG/r2HaljL3ZNDu182tdk0IeumrlXwifmIjT8+D7nVynMhkaRhilW56xoPktDV
         DGkK7DZsG4EdO8pXkxitsHmMz7j+rmbTcDH5G2avlnzNRsckD2+bJLCMAfM4Ez3omu
         08t1bT+L/S2K6dQuEDv4tkqBhkdUNlx1fwQed/beMzMWQeesuLj
Date:   Thu, 28 Jun 2018 02:44:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Steve Groeger <GROEGES@uk.ibm.com>
Cc:     git@vger.kernel.org
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
Message-ID: <20180628024446.GD644867@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
References: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline
In-Reply-To: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 07:54:52AM +0000, Steve Groeger wrote:
> We have common code that is supposed to be usable across different platfo=
rms and hence different file encodings. With the full support of the workin=
g-tree-encoding in the latest version of git on all platforms, how do we ha=
ve files converted to different encodings on different platforms?
> I could not find anything that would allow us to say 'if platform =3D z/O=
S then encoding=3DEBCDIC else encoding=3DASCII'.   Is there a way this can =
be done?

I don't believe there is such functionality.  Git doesn't have
attributes that are conditional on the platform in that sort of way.
You could use a smudge/clean filter and adjust the filter for the
platform you're on, which might meet your needs.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls0S54ACgkQv1NdgR9S
9osD8A//etgcpdXSkW3vDnJ4q65TZ6nuUV3nkdN7RvzI6osx03h4+p2QfSVxONaI
oTlzQ737djMipWr9XDNJoWLSo8QdndK7J9iscc4tuR2GL0vMyWZWHYIg6KIQOyUR
BaLA1myBVz3jzS6SxcrxFlGyCmd6505IOrBG9PsXOOSDXWkCTlaEhSK3jaot3cYt
p1BlwgE2jYAj0IOHOmvBkiXyeAERvVSWvdqIlqTdyGyuEynQdHdeIl3osZMDvpaJ
QBSNS/b/Q0Qb097Urh03kLugAWTk3LcL/HEwUHs1/OGr/ugA5e4yUP38GlESgNku
SD1Rl+D6XQplcGQhy9C3mALPKFJXXjUDx75TWqmLtwcGWzETc4/Zh9zpKoFRyuPF
Fn5V2yszaohEqKqvqev4s401YPnREVAafMR1DxsxujRlQC78vJ0N1GUsO1iZuCpT
Ss/8uO4m5N1B9i8E448f+XxVUYk/w4EqSfzCgzyUH2bw2qwkQCXlrSpZuhMRdPNd
7sqghv9MbxkqWnmwd0nPXeoxuzm0fdcEE+XeV9HoDb24m+UBhBXcMgTEO3+ce48u
ItBSqZnfOLFh48lupWmzRYfAGXljawRscY3cdQxOrTXUezBWo2VoD9JdWOKrmjcK
6OQcYxc5bYFpOlGyCPYdpDJ00zJcNVkk+vHDFbverjlh9ZcMr6U=
=ua53
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
