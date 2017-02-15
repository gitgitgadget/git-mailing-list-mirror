Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8D92013C
	for <e@80x24.org>; Wed, 15 Feb 2017 02:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdBOCNx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 21:13:53 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53368 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750791AbdBOCNw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Feb 2017 21:13:52 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 67CA8280AD;
        Wed, 15 Feb 2017 02:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487124831;
        bh=j5+SQlcA6ArLj0f3LgoFLmBSailTzfOj1eM0pNNmIvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmxPa9ULlKY3I0QTeEJz6xXEvGssWHx2QZXALAbftZQXsLEX9VLrd+IIFtS1wXbVe
         8PCr/kObeU4rkttHhOTaQi2CYJRFH5m4y3BnEXJzPjMaM+QaVSLruuhc/9G9t4Ty4K
         LgFt06ZcprsXnvYMywZopc6IkDLKc/P7HsBEmbyl96v/tFavL/epvBhZF2l9ZhgrRf
         UPUzmU+1+3Y2hCkQ3G1Nz5jTZJ1J+q9DDORrJ8plQlzWlfBHGIMhKRWIxyBjmo2DSz
         y8SOdvEwbece5aiy06AjFurAfrgb/tJ2JBH2cmKQRXcJBC8grhBW0oGmmvGeZjEoUe
         RY6NlwC6oj0FgYhbFJcVT6DiAVbB9tcd6p8ZAfgCV+fJ9LKDpmuB5D1zRTfkp5wXej
         NgZ2qiFuyyv7u7NtkuQpd1a2W4bzQZIlRFEFd+Q8kMvg45Wdy4ygwBer7tWjZhMj/t
         aSSJ12AhwcW+PJUbPWphAmBhqToGq6CqPhDIzytZK7VNmWuiZ1X
Date:   Wed, 15 Feb 2017 02:13:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        gitster@pobox.com
Subject: Re: [RFCv3 PATCH 00/14] Checkout aware of Submodules!
Message-ID: <20170215021347.q6ko55eqj64roqcp@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        bmwill@google.com, jrnieder@gmail.com, gitster@pobox.com
References: <20170215003423.20245-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmvqlekaspoze56s"
Content-Disposition: inline
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nmvqlekaspoze56s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 04:34:09PM -0800, Stefan Beller wrote:
> Integrate updating the submodules into git checkout, with the same
> safety promises that git-checkout has, i.e. not throw away data unless
> asked to. This is done by first checking if the submodule is at the same
> sha1 as it is recorded in the superproject. If there are changes we stop
> proceeding the checkout just like it is when checking out a file that
> has local changes.
>=20
> The integration happens in the code that is also used in other commands
> such that it will be easier in the future to make other commands aware
> of submodule.
>=20
> This also solves d/f conflicts in case you replace a file/directory
> with a submodule or vice versa.
>=20
> The patches are still a bit rough, but the overall series seems
> promising enough to me that I want to put it out here.
>=20
> Any review, specifically on the design level welcome!

Overall, I'm very pleased with this.  I don't really have any
design-level comments at this point, only small nits.  I'm considering
building and testing it out at work, where this would be extremely
useful.  I'm therefore hoping to see how it works under real-world
conditions shortly.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nmvqlekaspoze56s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlijuVsACgkQv1NdgR9S
9ouxXg/+IF1XKeoEmRWw6IJSbRob5X+vtdzAp/DPHTUgGSnGDJk0OelnWBOZm49Z
4WCF0FHjnnusAZoCKC4ARHrSZQkH05oxm45vNq8DCHIgNUOX1ef/p6N8JjcXKU7Y
7eyVlYzO9o2UBGYLtf5OA/LgdjkEfevrI48nOqmxgB02ZXZghxbrHs0J1+OGpTsn
EsNzocwrEoFmw9yF1dlm5qgrkyRNaAjJ5WCqjnHRoevFKheZbIm54r7suoydPNKE
RAUeEVDRNH1bAHCv2KnAl0ClWu3PrBlhdjx6UVNEGacsePwOeXUyROhC5WCFf1U6
vjFqvCWw8k7c/4eGy9aNM47OC5QFT5oUZxDO+WLeqFmfutOtnjHJViOahHNFPdlV
49YgJ1fAqE7EAPcxxFXuZIVZ2Q7r5t6/RZqbtR+h/6gyHFi+ONqPvk4A4SKA8/bm
l1PaEV2CCWcWaQNIOdKz2yEY0U8DlaOIOZIvd4afROF27c6ikUOkXsegiho7ovGp
0EuPXQn14t5iETFZ8iaTF9sCT0L39R5CnF1+4E7ny5LeobczjS1S2ZgwBob5FKQh
HJlrHqWqhQAbgvXYVUWHdxUajzqbw8jxCZlcJjZ0GvokjFwnJDjt+3b9kSkZPtNV
evhEdKity8rVmp+qGbUuDOuqKGgGamwzCUSAEYCQysPB2mPqXJE=
=aQjQ
-----END PGP SIGNATURE-----

--nmvqlekaspoze56s--
