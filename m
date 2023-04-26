Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183CC77B61
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 00:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbjDZAUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 20:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjDZAUD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 20:20:03 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DFAB208
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 17:20:02 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0D8E95A2B2;
        Wed, 26 Apr 2023 00:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682468402;
        bh=ReSH82f7Jnyf4jbbe8hvsQu+fZsr97BR6TsQ/EgZIqY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SHuRHXUei2eeWn3J0uDroE55cjV4fjQM7HD9jOUJUy5CE6aIpBNTTZmQzDHSdu7ES
         HEt7+s1BgOo/cKa82e1oTDFafOE7WIdHulZArbvnz2Fgmv5JICX40jOmG2a3pUkt5V
         LQzdrbKTI4r+g6J5yg70VzdWsi56WPbgxs5Y9PNXh+ijlpH03v32XsmrOmnPk2a5HB
         IwmtoxQ9uOeOhdfbts/LO2FfszWnCcp9Us7tEO1d0lH5RBaNAI1SWTWnsFgwi0QQ55
         NQkgU5CdUj92ih5Gas5GD21CHqFDKDPa1+Q/xZ+QyIKqs85l3UoWtYCsvp8DXymQnk
         BwJURWDgM4tnjymtiLVWqkWIPTZmXVa6WdAB2zoGjrYXIQkfazBYI9aaHPK1HWQSwn
         Eof6hFVm4KoYgud3ZLYl+Me+V2Dj1hj6w+z1sDtQyxrCM8Ws0NzZOcNy1Kh+fRUG3m
         a9UFDtj6RYRGk3efDBxnZvVtLQ8zOBR6fLmvCIWKlDEXGkNIe6V
Date:   Wed, 26 Apr 2023 00:20:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <ZEhuMML6n8F+cNLg@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
 <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
 <xmqqcz3ry2sw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MskhheecASTW31FO"
Content-Disposition: inline
In-Reply-To: <xmqqcz3ry2sw.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MskhheecASTW31FO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-25 at 23:12:15, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > If nobody looks at this, I'll take a look tomorrow and hopefully send a
> > patch.  I just wanted to point this out to the list right away in the
> > interest of getting it noticed.
>=20
> Thanks. =20
>=20
> The topic in question has been in 'master' for 2 weeks, since it was
> merged at 96f4113a (Merge branch 'jc/clone-object-format-from-void',
> 2023-04-11), and as I said, what your test demonstrates is not a
> regression caused by the topic but "was broken, did not get
> addressed, is still broken".  So it does not sound like it needs
> "right away" kind of attention.

In my case, the clone is over HTTP, so this may not be the ideal way to
reproduce it and it may need a better testcase, but it does bisect to
the patch above and it is new in master (and doesn't reproduce in
2.40.0).  Note that in our case in the Git LFS testsuite, we're using
GIT_DEFAULT_HASH=3Dsha256.

I believe what is happening is that for some reason, the object-format
data in v0 and v1 is not being read properly, and so we're now setting
it to sha1 whereas before we were reading the value from the default
setting of the repository (sha256).

It very well may be that it's always been broken and this has just made
it obvious that it's broken, but I'll look tomorrow and probably send a
patch.  I don't think we should revert this change, but I do think we
need to fix it before 2.41, since I think it means right now that all
clones over protocol v0 and v1 end up with a SHA-1 repository.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--MskhheecASTW31FO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZEhuMAAKCRB8DEliiIei
gV37AP0S+77WsavXsXQFbdfpbcB+7kiSfPKUUVLHR2hJEKoZpAD9Hg3pIuTwqGP6
DvV+ERIX8iz7HdQsTKDWqaPbOjYGug4=
=V1BM
-----END PGP SIGNATURE-----

--MskhheecASTW31FO--
