Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816C1C433F5
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 19:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJBTHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Oct 2022 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJBTHT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2022 15:07:19 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07E3913D
        for <git@vger.kernel.org>; Sun,  2 Oct 2022 12:07:18 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D18495A0E6;
        Sun,  2 Oct 2022 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1664737636;
        bh=5zFshucKw+kD4Bo1kKyP+MmrkAZEIKmNvpfx6oT9I2Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZRCephRwv2Whs12r2zBNZkJfLnU9/jnkO0Diwj0wT8yGa6JxFNmrEf8wm3sVWuvrE
         q1LIGakUjBrooqmqJUrpGLMt16rV2mevSJ8V+HOA/6hOXPrzGtSfWDI7RP6fDgLBti
         VMCw+YektK07BmCz4Zl0LCYbbC0tKaH9jKXHbpkIK9PKgFwpIzcdIGMNrDXaQtYGVr
         TqzoR6GqnsutV86UowOQmo5C7u8ck5BoNXkpnaFp+VrE4LghaIroGxhbJuDZRUUPIc
         8AkhGA+N6ERkk2veS1kZ7Au2RIDzD/radOIxyED5XF86krsQgLQS7y4FBBypFMpWoN
         S4/vkcC+ZMvKs3xZDiQllccJS/dUGqMEXJIW3AIa7UI9Zihb1AShv6ylXGEh+Ibyr7
         PPWE2TVms8mJkGW2coFvbPbvauunvRq9BuQfDRUIAK8cM0evQuqCgq+7/I8aa5ctfG
         VYQ4hOLTfxXCT9hMwxqMmIdhFmxKeVcLpXszgO6tccwW39nrnbL
Date:   Sun, 2 Oct 2022 19:07:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: icase pathspec magic support in ls-tree
Message-ID: <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aTuUfakb8uK/GF49"
Content-Disposition: inline
In-Reply-To: <220930.86r0ztufwd.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aTuUfakb8uK/GF49
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-30 at 13:53:16, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> You might find ASCII-only sufficient, but note that even if you get this
> working you won't catch the more complex Unicode normalization rules
> various filesystems perform, see the fsck code we carefully crafted to
> make sure we don't get something those FS's will mistake for a ".git"
> directory in-tree.

What's even worse is that different OSes case-fold differently and the
behaviour differs based on the version of the OS that formatted the file
system (which is of course not exposed to userspace), so in general it's
impossible to know exactly how case folding works on a particular
system.

It might be possible to implement some general rules that are
overzealous (in that they will catch patterns that will case-fold on
_some_ system), but in general this is very difficult.  The rules will
also almost certainly change with newer versions of Unicode.

I'll also point out that there is no locale-independent way to correctly
case-fold Unicode text.  Correct case-folding is sensitive to the
language, script, and region.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--aTuUfakb8uK/GF49
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYznhYwAKCRB8DEliiIei
gRrJAP4i1XzGI0Do0Is4XsBS2SGGg2plSwIv4iLfhvxszSClIAEA/fyen6ufVvLb
sMbENLu/kEGq3A+uSyIcKLmddfHxgwo=
=ynw7
-----END PGP SIGNATURE-----

--aTuUfakb8uK/GF49--
