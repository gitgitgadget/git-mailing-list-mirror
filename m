Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EA3C433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5550660F02
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJaTBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJaTB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 15:01:28 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E31C061570
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 11:58:56 -0700 (PDT)
Message-ID: <3939e806-8bb8-b6ac-1e3b-870f31746603@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635706734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taPA0ZmsW7zU4l+78jhok88l85sYqOief1Zcxh9ic+U=;
        b=Da8Ews91YybRWG8mKGAme8syxMRyN0L+n+bRhgBKEs1VJwzlzVE//3KOACOSrUxScWxYW+
        s4RWy3Dhc+sdsJmMrXn8TXDAohoogQhbqHd8hv8saBT4NtgX5TdaXdlsJ/r7fMWwvE6F8N
        WUSTfHeubfM5hxL579b96wWZoWOkjMTTkJNJ/RZEkUej/cFzHHoFEuccbDP9C34x9Bw0kR
        ZKWK0m3KsY6IZliD5/vzPb2HSoiRRX6tYFFppTKoXfVH2GjJbQS3loerIZMQ35e/KMrd9I
        Qw9yqrfntfrP7uUBv9m8kyK2gnG1MrYKZ8YPx29VZFdkfQJikxrGbf4TBjLMnGWuFLo2z5
        TdCp1jat1+ec8Z+mSI/lzT4nXEsTGgP7us7BNDKXMfNw5i2CKa/aFd8mGaUaY4A++IYv9F
        sD/dTGmJtIM5BRx38ZRu6+ZfCpIcHps4q7BZMPmhPYuqxO4k3e0a5TmTyj+M4U8vIZ26x9
        V2258k/oqoP4TQ1AqKaujebnJR3dKSOhJ1hJk3TN5+h0feEntmspmvEQ4nN1JzYvXZjMFX
        +zMmROeKd6OBgl28CSCWYMPmCylQiR2ZVn4BGBKZLT/gi7WHEXALzev0KkPd/JojAEVLhE
        1NOgNvTQBaF4m8itLQ3FGpdcF2qoBXQb4+r2nfvBz//t/0ihkpaBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635706734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taPA0ZmsW7zU4l+78jhok88l85sYqOief1Zcxh9ic+U=;
        b=hGfvxxyN2UT+r0vFVt4vjMFQGUO7DekJcoaZXnYwhd4dvP5crUOtDvjVv0rdZyixn7P/Ru
        YTZAyGDNh0e0NjBQ==
Date:   Sun, 31 Oct 2021 14:58:48 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] pretty: add tag option to %(describe)
Content-Language: en-US-large
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211031171510.1646396-1-eschwartz@archlinux.org>
 <20211031171510.1646396-3-eschwartz@archlinux.org>
 <xmqqh7cxdq4k.fsf@gitster.g>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <xmqqh7cxdq4k.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8uV3gRQYyLmsnK7HJnYA3TQP"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8uV3gRQYyLmsnK7HJnYA3TQP
Content-Type: multipart/mixed; boundary="------------mQp4zKnOnpa0eG72JJicjs9j";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Jean-No=c3=abl_Avila?=
 <jn.avila@free.fr>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Message-ID: <3939e806-8bb8-b6ac-1e3b-870f31746603@archlinux.org>
Subject: Re: [PATCH v4 2/3] pretty: add tag option to %(describe)
References: <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211031171510.1646396-1-eschwartz@archlinux.org>
 <20211031171510.1646396-3-eschwartz@archlinux.org>
 <xmqqh7cxdq4k.fsf@gitster.g>
In-Reply-To: <xmqqh7cxdq4k.fsf@gitster.g>

--------------mQp4zKnOnpa0eG72JJicjs9j
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/31/21 2:07 PM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@archlinux.org> writes:
>=20
>> The %(describe) placeholder by default, like `git describe`, only
>> supports annotated tags. However, some people do use lightweight tags
>> for releases, and would like to describe those anyway. The command lin=
e
>> tool has an option to support this.
>>
>> Teach the placeholder to support this as well.
>>
>> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
>> ---
>>
>> I use lowercase "bool" here not "boolean-value" because I don't see
>> utility in the word "value" here.
>=20
> Such a comment is much more useful if it is sent as a review to the
> patch that touches the same area as your patch does, namely,
>=20
> https://lore.kernel.org/git/984b6d687a2e779c775de6ea80536afe6ecc0aaf.16=
35438124.git.gitgitgadget@gmail.com/
>=20
> not here.


Indeed, done. (I had to unexpectedly step away for a bit after sending
my updated series.)


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------mQp4zKnOnpa0eG72JJicjs9j--

--------------8uV3gRQYyLmsnK7HJnYA3TQP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF+52oACgkQzrFn77Vy
K9ZQ9RAAvvp8qfPKuUeP6j03YRyY2tTzseUUZ7TbHyF5JZTRmADns+NII5KmcsbI
R9RKAMH4bwxbBJVNIA447p++UjDny7JbXTJm3IkEroFA66RgftL8tUEBo88/173c
3ueH+DWXj3Oc7ZyuV/6Iny3ygLdpwJ27DyVuwM5tfVtYmq1amopw/XKwwJ09WOgc
6MviVh2LXqcCwfgL2hrq2+f0Te8YNe3oDlGfjLg0vjBiOKN3slNtYg3y1Mx8j8uw
ijk7FthBwFb2sJ/xIpY1nFmaalgwElGRyLUke4YdVTFcqo4F4STJzLUJP1Ademh/
UrNxUbPAp2C+CJswQHrtEAGY1TRLkEsGLKVnGWHwi8+ZWyuyMiE/U23+XdA3z5yk
WQxyY1uIJtl1yqm/3TvB/hmnzfkqm5CIkau2la0GdHbBBQL9EVNLEh3NboMNie49
k2V7vUrZIWE9PJeovKVk0Dxg0qG7IjBUJnmpLeI/cjz9E2MYwTO75P8h57iNlIs0
CqzX5KQBVmP86hHHBn5dFSf94RekWQ3HdJFyIWYzIgwN3NslkdYq8HT1+hPyA1Ar
3EpPOzByd9oQQmqhuTHxDSF5Mft0t/Or199USA+8o7H+ABi+j23CFv94DlxLeQbO
UzCr+ar2tKZdGDuwlQEyzVyxFcWH327BOvb+hDw2pupwwlJzGOw=
=kxEd
-----END PGP SIGNATURE-----

--------------8uV3gRQYyLmsnK7HJnYA3TQP--
