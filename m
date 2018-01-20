Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE6D1F404
	for <e@80x24.org>; Sat, 20 Jan 2018 00:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756027AbeATAX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 19:23:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58152 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755728AbeATAXz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 19:23:55 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4BB6160402;
        Sat, 20 Jan 2018 00:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516407832;
        bh=FLlqZGXYWnzUfFa5dLrFSle9of/b5y5hreoGaCut57Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zNHItZUe0jCUV1SZTuZ9XxygntanXWa+KwtbdOfMA6hnacczNzErRVl6BppU6P6nQ
         76otz3q0yGaYU0yoo7cjqsx+lyvWA4s04b6LfdGEdKxQlTHiJ5F1gfO/O/XBxnFzil
         fGI/rzYUrm5UPBcc9DZscS97JoqAR8HJIxiXmTbAIdT6/wo8VakCs0AD1+gcP/jG4p
         JjbMmnlwHcLtnuuXzE5/vHngL1qKC8cPsIrHbfeFcyGgAWYd4La0m/AJkisspaN9FS
         E1C09r0mRZX+H3jkJjPxSfKoKzsMbQh0rJELEOnr1pW6P3bi7IqEb2TuNsSUNekC/n
         +D+ZQH7q6Od6J0Mt+/U9gyX6RAN2Y/XMjMl+9XEdWLoKFfDJgY4AO0PQr7gJSJ2F2m
         pLEDls+VD8szqAba5UjjkCtLxwoIQ5N1cSkznuSWv/TszZ/tiQST19ocDsxdImcA+w
         R0oh/UxXSg2DoVhpUkYlYCcGHhAELzVPLs/F+IuK48UDWtEwirw
Date:   Sat, 20 Jan 2018 00:23:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
Message-ID: <20180120002346.GA8965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= <aleks.bulaev@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net>
 <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net>
 <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
 <20180119074001.GA55929@flurp.local>
 <20180119223130.GC222163@genre.crustytoothpaste.net>
 <CAPig+cQmWqQWQrRQHHn=3hn6UFzJxT=9d5kKnJht_dt8sCgwkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <CAPig+cQmWqQWQrRQHHn=3hn6UFzJxT=9d5kKnJht_dt8sCgwkQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 07:15:45PM -0500, Eric Sunshine wrote:
> Oh, I agree. My original question of its practical value was based
> upon my belief that the full test suite is very rarely run on MacOS
> (partly because there are so few Git developers on MacOS and partly
> because it runs so slowly on the platform, though not nearly as slowly
> as on Windows). However, as soon as I hit "Send", it hit me that the
> problem would also manifest on Windows, and we know that Dscho runs
> the tests regularly on Windows, so I changed my mind. I did consider
> Travis but wasn't sure if it was testing on case-insensitive
> filesystems.
>=20
> Are you planning on submitting the test as a proper patch as follow-up
> to [1]? I couldn't quite decide in which test script it should reside.

Sure, I can.  Since you wrote it, may I have permission to add your
sign-off?

I'll try to set up a temporary FAT device and verify that I can
reproduce the problem on Linux as well.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpijBIACgkQv1NdgR9S
9otbIQ//e8npwCoHHWAlPEp/nrwUgWB5MOHdSPbrLvhVFkoqdST99DIJkG9FOB2l
kqi3k81XjNCeyHgcn/R4x36Ont3TLQ6/U1V0k8EQXVccWBrgZ4+PN/IwzSORRA96
Pzctmpj9ht+/VKZNThnVrEMkxEMJkjXtJ7Utey13tMuehn47i54/mEYrQlzLrCqA
zdM33dG0LvN7tBjxj4NxCdvBer+I+Y9zV4a+6/RWf8cll04tDfIF6tOZLWuk19O0
APH7X//DQuULAb3sKMkzjvjjYnr5InLbjYXzy6aUxoVMm29UHD/sRUNm4CAWyroP
jAh44jlAJ0u/E9GQlQlCAeAWKf6O/YyYxyaYCLi+rYRpIx5ref8+C5/h9YYCiUqR
oQMEnfzHR0Qh9LIAzkDyV2R2lXe8MhDe7qthcak/QDiP5UYW8yEaIPFZkaUNlqBI
HJ9oy10QiNcMS2Zt8s629yCEpzbLJT2CHbDlS206CA15pgnKcBEmUoAn/Kh1BITI
ohnJgptJasUCHugVtXCZJSkRG5rtsphD3FOx7hRye5U+iWz64OWSqzs6x1MAOkpK
juxGqGVfRj8pEV9naDxSxQy6rercg8uJ08lOVYvSicIw/EJW9YmMtoTk+R37RPfM
A9pOr7GcX5J7gsI5dUDJcKGBq9mvwI7B6P7c/1TAgGGuOyLyDbg=
=RzJx
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
