Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F41EE14D8
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 14:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbjIJOe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIJOez (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 10:34:55 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C6CCC
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 07:34:51 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BCEC15DA04;
        Sun, 10 Sep 2023 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1694356490;
        bh=zlMALO/xtKChr9MHsqeTEOk4vGRzF003laJ9XQ9R+PQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=W8AhRcFQHOdWURVB6bimjGZtg9naa7CAsgjCa7PH5RPamDVuHuffHqwnLKW9PD6L7
         fIOMyzoOpfBSTdhZL1KEuExKpX1bWxg1S7LsnoIWxhbFN6RE73fOPGAQR9pfze3rFc
         HJzihWk8pVJAJOD3lPe3LmRj2diOHvDCvDe5z5bwt7eZqtKDaxffwm0O322KLiPRSe
         q5zqXzByiOA4Sln8IdAycJVhgrpCKvbNNfEYsfaLGdj99c+QZKbL6D/LjMxcXXzXag
         CSMU5E+f7m/OepyhfhHWVWitGe82G+JUOJaBk+/MXTK2Ls5xd9N1CNJxb7hso/UdKH
         qBTfU3Gl5hT2rq6Q9IXBW35zFb9u/XI4E4EEa6KYqZEzjKHnO+0dVpbz6RIa2X4Se9
         w59HdGWFH8rcxS101/VrK2GQ5uz7s2BC9cOpOxa3g69W+wJY5+aTITCJ6FTWp/g6fi
         iQjMvG/m7mDmJCRAldyxgsG7jtvgYuW2bIEo7rBE1dIvE8cWt4R
Date:   Sun, 10 Sep 2023 14:34:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/32] doc hash-function-transition: Replace
 compatObjectFormat with compatMap
Message-ID: <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
 <20230908231049.2035003-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mZx6aG9uZ+OOgyck"
Content-Disposition: inline
In-Reply-To: <20230908231049.2035003-2-ebiederm@xmission.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mZx6aG9uZ+OOgyck
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-08 at 23:10:19, Eric W. Biederman wrote:
> Ir makes a lot of sense for the hash algorithm that determines how all

Minor nit: "It".

> diff --git a/Documentation/technical/hash-function-transition.txt b/Docum=
entation/technical/hash-function-transition.txt
> index 4b937480848a..10572c5794f9 100644
> --- a/Documentation/technical/hash-function-transition.txt
> +++ b/Documentation/technical/hash-function-transition.txt
> @@ -148,14 +148,14 @@ Detailed Design
>  Repository format extension
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  A SHA-256 repository uses repository format version `1` (see
> -Documentation/technical/repository-version.txt) with extensions
> -`objectFormat` and `compatObjectFormat`:
> +Documentation/technical/repository-version.txt) with the extension
> +`objectFormat`, and an optional core.compatMap configuration.
> =20
>  	[core]
>  		repositoryFormatVersion =3D 1
> +		compatMap =3D on
>  	[extensions]
>  		objectFormat =3D sha256
> -		compatObjectFormat =3D sha1

While I'm in favour of an approach that uses the compat map, the
situation we've implemented here doesn't specify the extra hash
algorithm.  We want this approach to work just as well for moving from
SHA-1 to SHA-256 as it might for a future transition from SHA-256 to,
say, SHA-3-512, if that becomes necessary.

Making a future transition easier has been a goal of my SHA-256 work
(because who wants to write several hundred patches in such a case?), so
my hope is we can keep that here as well by explicitly naming the
algorithm we're using.

I also wonder if an approach that doesn't use an extension is going to
be helpful.  Say, that I have a repository that is using Git 3.x, which
supports interop, but I also need to use Git 2.x, which does not.  While
it's true that Git 2.x can read my SHA-256 repository, it won't write
the appropriate objects into the map, and thus it will be practically
very difficult to actually use Git 3.x to push data to a repository of a
different hash function.  We might well prefer to have Git 2.x not work
with the repository at all rather than have incomplete data preventing
us from, well, interoperating.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--mZx6aG9uZ+OOgyck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZP3UCQAKCRB8DEliiIei
gTW2AQCLTxREsCS8rzdE7A7SfLdKV3IoYoYdda8wyQlPeoZhpwEAjUhKP2yeevvW
MDFhiwWeK7hE42TlwHD72Sf+dAR1qQY=
=etX+
-----END PGP SIGNATURE-----

--mZx6aG9uZ+OOgyck--
