Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC1C0015E
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 00:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjGNAsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 20:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGNAsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 20:48:30 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B312D51
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 17:48:28 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9C2E15A210;
        Fri, 14 Jul 2023 00:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1689295707;
        bh=Evp55xZQTEoyYkfCo1sGL+0yuaglh8ma/8c5XoHk/Jc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RUEERZYqad/rHKklkhgx3b1elT5CgaRUphqXQfpTcuJWaMnMs0rGUKBkfx7lHWMOv
         wsJ58HZTZ+MD5UZ8K+++hZZydOQx8Zyq8MpILQLuNNe6N8y0OVZ9OiJYCL6tbeIbKI
         yi6vOScce1ZyfL52nEDzF8qefvQQeMJp2HAk689pKqbzxR7MFRSdJi9ldNiSPG0d6z
         OYZF6+DynVnzh4dHQ/M5EE+b5aFIFBpRnc5awIAoSZ0MFIhsjXuvIzXXo1YcktSd6k
         tSvtPr+ZXZan0DzmIX0efxloECuyxsDe7ExBvZ3fwDSZzCoF6B+ceS08O2tuwTz9e0
         dS8eZOwZC0zqMuip7Topy5wgO6CEl2zET2BLswGBFxpME+1LwHAecVb0o21IfKO2OS
         LTXEy0LRm1XItA9LmO72uqs/HhxXiAtwNwKdr6QLvOk0znFFUGdT0rIiGMMnbwYvdX
         GZWjXBPsN/twvmPgsMT/sgbBMUgUHrvXEi6C4YuS15Q43HtBMPa
Date:   Fri, 14 Jul 2023 00:48:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     uxecw <uxecw@student.kit.edu>
Cc:     git@vger.kernel.org
Subject: Re: Bug Report - Git does not require a space between shorthand
 flags and the commit-message
Message-ID: <ZLCbWn2qXZhmf8XD@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        uxecw <uxecw@student.kit.edu>, git@vger.kernel.org
References: <fcdf19b3-269b-aa9f-38c2-d0f775524a89@student.kit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3E3nYnC8sdeQ53K"
Content-Disposition: inline
In-Reply-To: <fcdf19b3-269b-aa9f-38c2-d0f775524a89@student.kit.edu>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--O3E3nYnC8sdeQ53K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-13 at 13:04:37, uxecw wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> Rebasing.
> I entered `git commit =E2=80=94amend` (one hypen istead of two) accidentl=
y and it
> passed as defacto `git commit =E2=80=94all =E2=80=94message "end"`.
> I think because of the missing space git should have rejected the given
> input.
>=20
> What did you expect to happen? (Expected behavior)
> Input should have been rejected
>=20
> What happened instead? (Actual behavior)
> `git commit =E2=80=94all =E2=80=94message "end"`

I believe this is standard Unix behaviour.  One can combine
single-character options, including a final single-character option that
takes an argument, and the argument can be appended to the option.

For example, I frequently type "git commit -svS", and I could well type
"git commit -svS0223b187" (my OpenPGP key ID).  That also works
similarly with OpenSSH: the command "ssh -CoUser=3Dfoo server" works just
fine.

So I think it's best for Git to preserve the existing behaviour since
it's standard for other tools as well (and, I believe, the
POSIX-mandated behaviour).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--O3E3nYnC8sdeQ53K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZLCbWgAKCRB8DEliiIei
gaqeAQCnOue73rs8gMAG7WrThlQbPw5iE+sYRxTRDuqlvaFdowEA7keyeuTZB8Ac
qfKpcJ1jTrMiupK7PrrKlgKsFPadfw4=
=A7TU
-----END PGP SIGNATURE-----

--O3E3nYnC8sdeQ53K--
