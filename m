Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379FBCA0EC8
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 02:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjILCZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjILCZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 22:25:42 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102C1E2F1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 15:07:41 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 159095A225;
        Mon, 11 Sep 2023 22:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1694469931;
        bh=6ANQE0l8KYbLXaBy3SpYbYoI6bVnWOOU19/EQ+Ja7iI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ImItry4qYCk+6NPQalHdzhR2TCItsd6qBoBPllZj0UA2ZUg0dvjMZcG32vpKOfJzE
         npTgIZt/fKi4ghgaJOjDlnYgWo5B1MzLdQjVHLo74GN4ilwS5ipRqLfH1897TMOZYL
         Yhh3+oc6bYa66b1u5fXbf0b4pAhiuSmIebbxAK096iTsiKwWy3oDfd9X6NrTUvMgAC
         I3UXdi0Kxq6hWON0mIB0tE7HZeiFl5N7GPlorxN1AhuAqbxxVC4dUw+XIGhRLJ0765
         mI3MhuN6YWhUoGPe25A/drrRBV2FxAyQdC/hvhlvRmMVTbRFXtbRNIKzv+eMXjHwIK
         NWpj/jC+JvLoIOzp7LDG1NZe/tud70P61EC22yMlHGfn7fMg9TnfA9GecUXsx6a96X
         y6nxC04i5+hXdHNzOJ09LTz72BsdifJS8Li+8ki0e2IjLfmTlbE6y+DT+aDL0I6bDY
         88p9DbmZSOfKedJyIrFWSTTUeyQypNbvtT4uPm73vSb8EN6ztH7
Date:   Mon, 11 Sep 2023 22:05:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
Message-ID: <ZP+PKa3N1N1PXROM@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
 <xmqq8r9di5ba.fsf@gitster.g>
 <87cyyoeli0.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9wlwHfHdQWXUOkxC"
Content-Disposition: inline
In-Reply-To: <87cyyoeli0.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9wlwHfHdQWXUOkxC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-11 at 16:13:27, Eric W. Biederman wrote:
> Junio, brian for the very warm reception of this, it is very
> encouraging.
>=20
> I am not worried about what it will take time to get the changes I
> posted into the integration.  I had only envisioned them as good enough
> to get the technical ideas across, and had never envisioned them as
> being accepted as is.
>=20
> What I am envisioning as my future directions are:
>=20
> - Post non controversial cleanups, so they can be merged.
>   (I can only see about 4 of them the most significant is:
>    bulk-checkin: Only accept blobs)
>=20
> - Sort out the configuration options
>=20
> - Post the smallest patchset I can that will allow testing the code in
>   object-file-convert.c.  Unfortunately for that I need configuration
>   options to enable the mapping.
>=20
>   In starting to write the tests I have already found a bug in
>   the conversion of tags (an extra newline is added), and I haven't
>   even gotten to testing the tricky bits with signatures.

I wonder if unit tests are a possibility here now that we're starting to
use them.  They're not obligatory, of course, but it may be more
convenient for you if they turn out to be a suitable option.  If not, no
big deal.

> - Once the object file conversion is tested and is solid work on
>   the more substantial pieces.
>=20
> Does that sound like a reasonable plan?

Yeah, that seems fine.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9wlwHfHdQWXUOkxC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZP+PKQAKCRB8DEliiIei
gRPvAQDkSmNrIJVy4klHwKbl07U6wdzyftF4Rw3pcBzkCakFlgEA4S2KsD1KczP6
soQ60BrYgJ3xIesxOfQiIFwu6U8+Ug4=
=Fwxt
-----END PGP SIGNATURE-----

--9wlwHfHdQWXUOkxC--
