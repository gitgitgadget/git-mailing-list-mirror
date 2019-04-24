Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931361F453
	for <e@80x24.org>; Wed, 24 Apr 2019 01:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfDXBQY (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 21:16:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35640 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729013AbfDXBQX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 21:16:23 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 33E2F60FF7;
        Wed, 24 Apr 2019 01:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556068582;
        bh=DJnd8cz4/dkDb1hiBFnMCCvDf4Kt8D6lOb1Q6xb+Ms4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HyTXaP7scBi9BvWzY1/chIEvAAdmMFjXkLPn12aErKmm74W1+Z3898OauqchXCbOZ
         0IkO9MDsXUKfJL/ag2RTzHBsTDFuUZKj8DaftEfV6deC8lHhAvTptpS90dsvddfSkM
         sYyXEoW4AwtXt1tiCFwFW37DwAFI6oD8/PRVgtGIbMCRTZuzfFR0hNzaxfZ6JrMdF0
         1HEw7h4UiXHicgVP+OqP7jx30yPbnD1B+2UpJshcmnmm2++LXrxc7ApuSm1XGg9rAc
         ZrjN0Ie695IN2o+IDsqAgZOo5ZxJN7iPCJBXV4W7I2SGBowCoPvmAMo+7DTH+5lZr5
         I1vJ/WYAB7F0OsQftLwHJaLsfkcZM5mNVaqfqcQtsSBBN+6GYPfPIT+kdAPlJFrr1B
         s685eqDlNxKF2kunn8hIFFMfAby8sxjwDWh+SjjqUop6rDkMBoCEzqohDcUpYyxVBG
         j6Ica/Mvr8I+Yp3yC6n71m/+PJMmukx2st1tUbyx5iy8Ekx0QKy
Date:   Wed, 24 Apr 2019 01:16:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "CHIGOT, CLEMENT" <clement.chigot@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-compat-util: work around for access(X_OK) under root
Message-ID: <20190424011617.GG6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        "CHIGOT, CLEMENT" <clement.chigot@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
 <xmqq4l6p57x6.fsf@gitster-ct.c.googlers.com>
 <AM6PR02MB495010DED643EC262D116DD0EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
 <20190423235526.GF6316@genre.crustytoothpaste.net>
 <xmqqsgu843yv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q6STzHxy03qt/hK9"
Content-Disposition: inline
In-Reply-To: <xmqqsgu843yv.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q6STzHxy03qt/hK9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 09:55:04AM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > What POSIX says on this is the following:
> >
> >   If any access permissions are checked, each shall be checked
> >   individually, as described in XBD File Access Permissions, except that
> >   where that description refers to execute permission for a process with
> >   appropriate privileges, an implementation may indicate success for
> >   X_OK even if execute permission is not granted to any user.
>=20
> Do I take this "not granted to any user" as "no +x bit is set for
> owner, group or other", and "a process with appropriate privileges"
> as "running as root"?

Yes. The language of the former is designed to allow ACLs or other
mechanisms, and "appropriate privileges" is the POSIX term for "root
permissions". The latter is also designed to allow implementations
leeway to implement an alternate mechanism.

Sorry for not explaining that up front; I'm so used to POSIX-speak by
now that it doesn't seem strange to me.

> The latter half feels iffy, if the system is still allowed to fail
> execution by "a process with appropriate privileges", leading to
> inconsistent answer from access(2) and behaviour by execv(2).  But
> at least that explains what was observed.

Yeah, I don't love that POSIX makes this exception, but it is what it
is.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Q6STzHxy03qt/hK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAly/uOEACgkQv1NdgR9S
9osHnBAAp5p2zxI1/B8YsbiRMDVvlNQSL5bLyEzVpxYoONig4S74nVOrtKdWKdN2
kuiHFGzvsbO0acMhhjXG4v0prugnGCNkgI85wla45x87DbTfQi1w5AdQwzNeKhB1
aLFj0vWo/z38ErUlwK9ngQmGJ7qkf8maMyNaBGy+FwF/z7N+IGVthiIDSTY30gb0
2QPpt1SLQlBtAp0C7DBGY6jJV9mHRKFV4LtiCm80hWsJsgZtW8Y2tdKKJfeMVOs7
e9m1sW8x64eMHlSLMEFvMJlIrirdayGDkZg7MeRQiGjKD/MYD1tvfTQbHqSB5lA8
Hw5qComa9Pc419tK2URm4TvIZLxFCmRJY/oY38Nku5XiZBTyXwGsXQrswPJRzrdH
tPiSr1KxT6Dw9Aa+/d7RqEkjSTfeQAIGd66bC9S/yc5uYyPqPejczoASJhPEZst7
8JhnJf16l6T3DEodWgT2k/R1+8nSqYNIaNrHRx8SABeVoNUC328+1R5Gzw4J2XQF
MCvxAS/iGHl72IKMYq/y53zNnLkF9JNTUoNL8pwjWFY1iMzxY4f7mKEpirfltbqb
Ejcv1nbiahguLEaRVQYzoqXZCUhJyOOvrAdIXK2O7WIOyNX0LZPKlEvgnUwxHEeA
F8cf/x6x00grI2hfWJlyf/Jzm9Utn/RRmJMfOPrg3N0EyCSTH1s=
=7xxF
-----END PGP SIGNATURE-----

--Q6STzHxy03qt/hK9--
