Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BF820450
	for <e@80x24.org>; Wed,  1 Nov 2017 01:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbdKABf5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 21:35:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55752 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753486AbdKABf4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2017 21:35:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 56FCD6046C;
        Wed,  1 Nov 2017 01:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509500155;
        bh=+UCKmfYovMMIGd3UOhKsHwfsF0jEKCfGfSf+xipWeMk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=b4U2Zb2HzpKl829TPzYZt1LcvdFDBhrzBok/WoJuQlPMEkmqGBwMcrOTuQ2k88Xt6
         eIK8aHA/PrkavgRuuN9YHa7XBTeH/3cxu6PREu0371BcjJteor45ejIMjW9BGhZvRF
         7B+30i0bk2BCnjelT8biCV9zVMjuNZzaLJB7oyCAbhF+AFJzIc7raeYHpwAJVJqGX4
         5vf/bugQIR+tc1btrp4u28qSyvNt4pYDUVfV55d1SlL83r/jzqbbEW7Vn7zVifCYps
         xruhUHYHKn/q1zw+6B2CLJJBrLZP7Mr3zMTbq3eUP2icwSeG6snfT/oXi4FsSCali6
         9CbdOgrfC743f4BRuGPWQo0Bb2Hb4ykm5jXXE/gJWFu60GsxjbyeV1MeI+edyEs4ix
         N5dtOg09vhGBIdnd5Q5CI/K0RLTnZYddf9DaphPJKcTamH7SLsJRVnlG2qAfb67ttp
         WTsUmmxJzqF1FXAmwNYxRRSCwtWwzNNTYy+R7iA643RxYZIc6HH
Date:   Wed, 1 Nov 2017 01:35:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 2/4] Add structure representing hash algorithm
Message-ID: <20171101013549.np2zr7kq3uqvtel4@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
 <20171028181239.59458-3-sandals@crustytoothpaste.net>
 <20171030233615.GA94048@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncdadaqnn7eac3jk"
Content-Disposition: inline
In-Reply-To: <20171030233615.GA94048@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ncdadaqnn7eac3jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 04:36:15PM -0700, Brandon Williams wrote:
> On 10/28, brian m. carlson wrote:
> > Since in the future we want to support an additional hash algorithm, add
> > a structure that represents a hash algorithm and all the data that must
> > go along with it.  Add a constant to allow easy enumeration of hash
> > algorithms.  Implement function typedefs to create an abstract API that
> > can be used by any hash algorithm, and wrappers for the existing SHA1
> > functions that conform to this API.
> >=20
> > Expose a value for hex size as well as binary size.  While one will
> > always be twice the other, the two values are both used extremely
> > commonly throughout the codebase and providing both leads to improved
> > readability.
> >=20
> > Don't include an entry in the hash algorithm structure for the null
> > object ID.  As this value is all zeros, any suitably sized all-zero
> > object ID can be used, and there's no need to store a given one on a
> > per-hash basis.
> >=20
> > The current hash function transition plan envisions a time when we will
> > accept input from the user that might be in SHA-1 or in the NewHash
> > format.  Since we cannot know which the user has provided, add a
> > constant representing the unknown algorithm to allow us to indicate that
> > we must look the correct value up.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > I believe I did get the format_id constant for SHA-1 right, but
> > sanity-checking would be appreciated.  We don't want another Referer
> > mess.
> >=20
> >  cache.h     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> >  sha1_file.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> >=20
> > diff --git a/cache.h b/cache.h
> > index 6440e2bf21..9e9eb08f05 100644
> > --- a/cache.h
> > +++ b/cache.h
>=20
> Maybe it would be good to place this interface in its own header file
> that way we can avoid cluttering cache.h with more stuff?

Sure, if you like.  It will end up needing to be included in cache.h
because of the blob and tree code, but I'm happy to split it out.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ncdadaqnn7eac3jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln5JPUACgkQv1NdgR9S
9osBZxAAmxwSMlAbZrhGDwLRSCIOxEPFMKoBZI7y/QRxMYwOdpbbomKKkmaAa+nQ
tmI8mlI1Xlt65iZxVWzeC0gLRkrURn/Gc4hni7fnXmDizxPED26Xan0bkR6nU5Wp
GbcksaOlqKa//3wuJpdm6VkXXY1E9J/uwLPZh8bAzAeIyWDTOjo4gl+MDuN7FweZ
WL1yFDFtcbAzIij+NQIhR8V9rYRQbE4iE3U+DdnvzlTqKMWDu84r8vsJg1HoRdsd
EBkVP4EXccHkWWY6jOZALbslbe/Mgnxwo7W5fUayc63V3yFfwYhpJM3N4UnxqBa6
WUZRJ4G3S91u9Yq4SzOJiQiqUlEYYQcnUqYxYSq/o0S1wCyeUy8dzOWMTncpHZb3
rd/k/C8KEzDYFAyRyAupkj6T5KeOe9W4UTQzLgzIPgf6huTPBisY3aDCcxrdsYY2
mHe/AosKUogSh5Dnozv2DqkzgVCWaq2X6mmEjmEkupb73n1uy0/rlQaEz6QFHsCm
+5ChI9Om+4Sb98SuWqYQHAjb7f2P0JZaXdkAWLG5S2lD6x2JH8zEMbXBxdfhhqCq
yULFE3wz7InTfC7r/omfZu/KcK9GigbZdscgROsG2pWDcArMjHJc9I/6ocq6zwhe
riXmCBIQ8S4Wo+DbB2Viw9lPxYvb/ckzqicttNOFcBruS8RWCMw=
=R6vC
-----END PGP SIGNATURE-----

--ncdadaqnn7eac3jk--
