Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CBEC433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10706613B3
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 12:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhKGMnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 07:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhKGMm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 07:42:59 -0500
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF0C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 04:40:16 -0800 (PST)
Message-ID: <13499fc1-1ac0-0a3a-b328-3aab5c37602b@archlinux.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1636288813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/2FogQ0p8gYBPQwr/LzVbZ81cNWF25KEVoO/j/uN+Y=;
        b=g4NApDhs0Q7qFwNpS/oJ1LSpirKNYqSYJ7vcB92OJK1qLOGVlXws+h3LcK/f96FfeXrTg+
        4W3Vf8l8AkTslhDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1636288813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/2FogQ0p8gYBPQwr/LzVbZ81cNWF25KEVoO/j/uN+Y=;
        b=Jalco36DiTiQQ7T6c9fcEcNZVsf2TFYf2YPBPFP8VVsyqvBRpWm6mDlgaxtjsxtGOrUFFk
        g7x0axIaOxGv0GZKX/34DwHGCX5rVBTlRWJ9R++gMsgHeoSejGNvn7MlXoMShbNGNJY53x
        7ePrBcCfp3t8quQfuwbqEUrh5TtNPH0up7hk/6FM9y3L+d7xQC4mn2OcnLrm5AN4TPP2j5
        rm4UyH/3pcCvp2rbJRkcGUxCW67WvfNlwr1WpgQepy/Pnh+pR0HHLDTfK/X/9VMSG8beyt
        08uK/QgdpNBOtiRgY7/QoWREnTpyXHIQJWcrhSNqkbrMTVcfaKtpuseIg3VABb87ZPsBpP
        9Ow0vwgJdyipkOuPYv6IsNmCgmbXdtASdQAv6MM09q//etb2/WfZhwUDqgUp0v6bxUTT1Z
        d2yj/7QtkgmNU1xsxQIB+IkmKYvY5H2DsUBCm/wKyXN+kUX/oTQGJvCMC78dBNucDzxE8H
        heskZumlAm1RdUef6h/BOx2p3czKZ3a3X4v7e7pyy7t9/4zTbXvoabPpko4Iinpv243cqg
        DLIRCxiXaotjI3C+n6xU1PG8pH9l6J4Qg0ClqDmM6YAqEIbdTq5hvnf1yPuISWv5xEWwkI
        GdPAgmz7nfSUm9mHC7MfYLfotyDLn77I2TlECFdZBxuKK0Tu0sujk=
Date:   Sun, 7 Nov 2021 07:39:23 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
Content-Language: en-US-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-4-eschwartz@archlinux.org>
 <YXfvY3n9wEwctjUR@danh.dev>
 <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
 <nycvar.QRO.7.76.6.2111040018240.56@tvgsbejvaqbjf.bet>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <nycvar.QRO.7.76.6.2111040018240.56@tvgsbejvaqbjf.bet>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ludLlcNy1FLPTUqanvqUh05B"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ludLlcNy1FLPTUqanvqUh05B
Content-Type: multipart/mixed; boundary="------------Eo8jeb01DKnUBMbRldx6Slpb";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
 git@vger.kernel.org
Message-ID: <13499fc1-1ac0-0a3a-b328-3aab5c37602b@archlinux.org>
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-4-eschwartz@archlinux.org>
 <YXfvY3n9wEwctjUR@danh.dev>
 <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
 <nycvar.QRO.7.76.6.2111040018240.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2111040018240.56@tvgsbejvaqbjf.bet>

--------------Eo8jeb01DKnUBMbRldx6Slpb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/3/21 7:20 PM, Johannes Schindelin wrote:
> Hi Eli,
>=20
> On Tue, 26 Oct 2021, Eli Schwartz wrote:
>=20
>> My system has a custom compiled glibc from git roughly around the 2.34=

>> release (a similar environment could be obtained by using Fedora rawhi=
de
>> I guess), and this commit looks mighty suspicious:
>> https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3Da1561c3bb=
e8e72c6e44280d1eb5e529d2da4ecd0
>>
>> For this reason, I did not bother to try testing v2 under a developer
>> build, leading to my overlooking this issue. ;)
>=20
> It seems that this issue now hit an official version. As I explained in=

> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2111040007170.56@tvgsbejv=
aqbjf.bet/T/#u,
> my colleague Victoria Dye will send a fix for this later.
>=20
> Stay tuned,


FWIW this was present in the official version of glibc released in
August... the problem is finding an official version of a distro that
ships it. :D

Thanks for the heads up.


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------Eo8jeb01DKnUBMbRldx6Slpb--

--------------ludLlcNy1FLPTUqanvqUh05B
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmGHyP8ACgkQzrFn77Vy
K9Zkiw/+KHozy2AG/VZrCqTd5DinfliRRKt0sopQVGe44j/iNf0XWh1nsJjhfdij
vk56/bXkLGfaiqxkrUuUO5WBqlVuL5otrilAY2LSv/kDK17HugDVTLOy6Ba3MD9+
4RVIWHDvfJSlizQayGrXBO4U6R/0k3nAYnjsW9ZbXgmbV35dtEqy61xgpZ018NF3
p1K7YkNzj70vKrKBZFOIxhQw6AjyTW2M1AYM2aHGcmCkL3SuliHU11vSxtURdlul
lP08b+wEE/a2nBlcZEJEmJ9cmyVjzWbxin5eE7ASt88prH1PVVxWoUpk0xqdqjv1
ruWVIFeA3nNBuPn7XvK1nxpfIXM/uDJ7j6zw+uFzDOTQueCR3ryGy/nlfntRpsKL
KKeu0wrSgxREkwr1LapJKUa413Jy1Z9Z3m3IQ0I1OLDsIIwC3MklK/pkBHmVPJi1
C3G3ttKrGSiBGz3qa1h1rBW3UnsgzlCmm1yomefYuA2MP4Kk+hyrZzISZL57nbL+
Po33kg7+7W/qdWl3pz1IAD5rxIHJPLSeXHpp7AegKrbCzEIQMcft34CFhmhDP91d
LpeCNDz0OOrVBXNithfkzcAeFdsk/tGmXd8ZooVerR7o+TM110rpWfH+d9XUNxcN
P9ve+5Ga4R/t9jDm5Lfw+plYAPfV7K7XJhBLIJTTSAiTOPS9NE4=
=zEid
-----END PGP SIGNATURE-----

--------------ludLlcNy1FLPTUqanvqUh05B--
