Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE75C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBBXBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjBBXBk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:01:40 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBFF7C72E
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:01:33 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3D3E55A1E1;
        Thu,  2 Feb 2023 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675378892;
        bh=I2wGKFRkfKYaJbkfhAZ6q1GWRGoT82go3MalJpswkbU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GMzB/UP6UTcsjBZFNIE2I0B8S+zHn52W5ndxHohueFiMgMMX+8J6+LYMfLsXG5gbS
         4LS64dJiJ6oBe0vSzIUlmm9tUcMIiFx7QDosdQ7UhT47H8ey3ATxUWO+V3ETm9Gxp9
         keGtGZUL65jsEVooudlaastF/RBZzATcJwRcBOg51VxUFw8/MD2c+hyAqpTSDfOYxS
         a7jgqUAx3FX2dG/hQSRDPb+wcxZcPJ3/yxiCdfcwW+BZMgZnRkAzjZFIWfkyltKFyD
         kif2BIqxDxNRnrnrXhss77DUC8Th1YOENNI21Qh2whzNUeXAsGbYNiSd2TTB/M4GhD
         GKSeRTVWAy+HaSuIrrxyh/UuAmkktKGJW1z04cWrAGFWqUE++6L1EE/9PMFDK+eCLb
         cloT6nDCe+fI6HXeG240LcSlI7x2PrBuuBZXIroBDHkO4f4gl/jGad3Y4XnLsH6lhB
         QmayU352YH790plT6jtSg2rsloWwuL+wHyylse6gg0Z3lAzuisQ
Date:   Thu, 2 Feb 2023 23:01:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9xAv1reHJRj7iKA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
 <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <Y9ry5Wxck4s/X2B+@tapette.crustytoothpaste.net>
 <xmqqh6w5x8i8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ruvbDxxm/CH/Wug"
Content-Disposition: inline
In-Reply-To: <xmqqh6w5x8i8.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2ruvbDxxm/CH/Wug
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-01 at 23:37:19, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I don't think a blurb is necessary, but you're basically underscoring
> > the problem, which is that nobody is willing to promise that compression
> > is consistent, but yet people want to rely on that fact.  I'm willing to
> > write and implement a consistent tar spec and to guarantee compatibility
> > with that, but the tension here is that people also want gzip to never
> > change its byte format ever, which frankly seems unrealistic without
> > explicit guarantees.  Maybe the authors will agree to promise that, but
> > it seems unlikely.
>=20
> Just to step back a bit, where does the distinction between
> guaranteeing the tar format stability and gzip compressed bitstream
> stability come from?  At both levels, the same thing can be
> expressed in multiple different ways, I think, but spelling out how
> exactly the compressor compresses is more involved than spelling out
> how entries in a tar archive is ordered and each entry is expressed,
> or something?

Yes, at least with my understanding about how gzip and compression in
general work.

The tar format (and the pax format which builds on it) can mostly be
restricted by explaining what data is to be included in the pax and tar
headers and how it is to be formatted.  If we say, we will always write
such and such information in the pax header and sort the keys, and we
write such and such information in the tar header, then the format is
completely deterministic, and we can make nice guarantees.

My understanding about how Lempel-Ziv-based compression algorithms work
is that there's a lot more freedom to decide how best to compress things
and that there isn't always a logical obvious choice, but I will admit
my understanding is relatively limited.  If someone thinks we can
effectively succeed in supporting compression more than just relying on
gzip, I would be delighted to be shown to be wrong.

> > That would probably break things, because gzip is GPLv3, and we'd need
> > to ship a much older GPLv2 gzip, which would probably differ from the
> > current behaviour, and might also have some security problems.
>=20
> Yup, security issues may make bit-for-bit-stability unrealistic.
> IIRC, the last time we had discussion on this topic, we settled
> on stability across the same version of Git (i.e. deterministic
> result)?

Yes, I think that's what we agreed.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--2ruvbDxxm/CH/Wug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9xAywAKCRB8DEliiIei
gfI/AP0eAZvTzkUE3gaQcxE+yw5HzRGLfw3JtDTnU4Y6vJJgcQD9HQ8lVsl8MTtn
DRoiIy7NU4BYfLnyhdFiGuOPaDR5Ow4=
=YIvB
-----END PGP SIGNATURE-----

--2ruvbDxxm/CH/Wug--
