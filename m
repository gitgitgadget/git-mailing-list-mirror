Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9EFC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347158AbiDRRk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241994AbiDRRkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:40:24 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28533465C
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:37:44 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 262345A410;
        Mon, 18 Apr 2022 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1650303464;
        bh=S/2BNzdhfCHQD7MiUwuIps27314Osnjo9CHiLMWUhiQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0CNF3y50mbGKnW1Qzn4y1LqkaUQuiFTgMBtqu21APvMbiWzVHzxvbjN8/xweBQngF
         6uCi5VJr88NUyGOtTpjPCfLmmU56aH7RQBg+2VJSHdh5qTNUdIL4MTpIYHZ7nr8rrY
         Pe1sv+dAn0A26lvINmRYDkXFwIHxPiu9MyQDWjGZwCG6ZH0kcMHiTMPmDdqlL28nIb
         qTwaIiUJMDBWpmix01FVdjtneCF8DF1fKpNK6UEEfsNfGAlA6+LyxsmiRK7UIkfU0+
         BpIGikdDh+SKRZ8wRQUQ24uAnAQUWU7iriU7IN7iCtQFgaKJcO10Y1b+UQCdka/R7R
         8SYYuGYaB2U8l+xCaaMeAsr397S+ujvoxmawNrZ9r4TlKkveMCPw9Sg+IlQuRLe8tw
         xDhsk5XWl3BS4di/38UpMhiDOKXX2tjGosfQ7ZA36QlNb9WJqxhg+LW2lEn4UR2b84
         l/sJs2EsLtdtqzMvIHfxExlRX5hQmYNXQk2bG5Yk7DpLIpnVN/W
Date:   Mon, 18 Apr 2022 17:37:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Attila Csosz <csosza@designsoftware.com>
Cc:     git@vger.kernel.org
Subject: Re: Git bug report - disk errors on Windows after push
Message-ID: <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Attila Csosz <csosza@designsoftware.com>, git@vger.kernel.org
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjsfsyCAAKs5qnG4"
Content-Disposition: inline
In-Reply-To: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xjsfsyCAAKs5qnG4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On 2022-04-18 at 07:47:07, Attila Csosz wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> Pushing to a directory directly.
>=20
> What did you expect to happen? (Expected behavior)
> Good behavior
>=20
> What happened instead? (Actual behavior)
> Disk errors. After pushing to a directory (my origin field is C:\Work for
> example) the git repository will be corrupted.
> Moreover causing disk errors not only in the target git bare repository.
> I've loosed some other files.
> Cannot be reproduced exactly. However I have decided to report this probl=
em.
> I've experienced this problem for several years.

There's nothing that Git should be able to do as a normal operating
system that causes disk errors.  If you're seeing those kinds of errors,
the likelihood is that your disk is bad and you need to replace it.

Do note that if you're storing your data in a directory managed by a
cloud syncing service (e.g., Dropbox or OneDrive), then it is known that
those file systems corrupt Git repositories and you shouldn't use them
with Git.  That's due to the way they sync data.

However, if this is a regular file system (e.g., NTFS), then Git
shouldn't be able to cause disk problems, and if it could, that would be
a serious defect in Windows, so it's almost certainly going to be a
hardware problem.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--xjsfsyCAAKs5qnG4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYl2h5AAKCRB8DEliiIei
gR3XAQDkEV87JkhULZZD18XyEcKQAYxsstwBbJ9DbRsM4vYuMQEAxLx6LO3RMu0s
ELX1UkfNZvnbb7cu8fx05P7iCer59g4=
=j6En
-----END PGP SIGNATURE-----

--xjsfsyCAAKs5qnG4--
