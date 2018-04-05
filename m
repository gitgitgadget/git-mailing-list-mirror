Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074281F424
	for <e@80x24.org>; Thu,  5 Apr 2018 07:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeDEHYG (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 03:24:06 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:32012 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeDEHYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 03:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1522913043;
        s=strato-dkim-0002; d=aepfle.de;
        h=Content-Type:Message-ID:Subject:To:From:Date:X-RZG-CLASS-ID:
        X-RZG-AUTH:From:Subject:Sender;
        bh=hqzWsWJQOtdHYuI8zepdp4T2LwcCtpIq3ruhkDX0irM=;
        b=hG3ooYaGVYrtmsE2J6IFa5zRzGtV/ggGI1sW5dC3LQcy50Yy4zmWdcC6CfqLV/UOJN
        c+SKkjpBV35V+tEGX9zuYWMl0jhz2g9LCnU1a5RhIi8SQ4m1Hz6pTdJBbw0gUFKYh8Z/
        n+DNWalGrdE4pixVVLRNzBmJLPh28agtTOFFjh8/B1AO4Pz+MByZxx7ScRvEoLxbgQvG
        ckTwVqyiZDnuxywBxIwVbkTjCx6fyfLpxo1jNFg96WKuLyR9CwNikf7tBUexD5wTB7et
        eabPhoO7cljaA/t88bhFj66b8zWPhadFnjktqk7/WDKyc9YuQnYH+UAibvSGIVIMjYs8
        PfBQ==
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsBRtyRe2qcrldJj63vYUTRQR/0RqPSgWq+RVwc
X-RZG-CLASS-ID: mo00
Received: from sender ([2001:a62:816:91ff:a572:884d:f51d:1a86])
        by smtp.strato.de (RZmta 43.1 AUTH)
        with ESMTPSA id K08137u357O3Uzv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <git@vger.kernel.org>;
        Thu, 5 Apr 2018 09:24:03 +0200 (CEST)
Date:   Thu, 5 Apr 2018 09:23:58 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     git@vger.kernel.org
Subject: How to configure sendemail for no-auth?
Message-ID: <20180405092358.569e0315.olaf@aepfle.de>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/8hhCRXVumEercKC9xZkK4aj"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/8hhCRXVumEercKC9xZkK4aj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

My ~/.gitconfig looks like this, because all cloned repositories require th=
ese settings:
[sendemail]
        from =3D Olaf Hering <olaf@aepfle.de>
        envelopesender =3D olaf@aepfle.de
        chainreplyto =3D false
        ccover =3D yes
        smtpencryption =3D tls
        smtpdomain =3D sender
        smtppass =3D smtppass
        smtpAuth =3D PLAIN
        smtpserver =3D smtp.strato.de
        smtpuser =3D smtpuser
        confirm =3D always
        assume8bitEncoding =3D yes
        transferEncoding =3D 8bit

Now there is that one repo that requires this:

[sendemail]
        from =3D Olaf Hering <a@b.c>
        envelopesender =3D a@b.c
        smtpserver =3D otherhost

That "otherhost" does just plain oldstyle unencrypted SMTP.

How do I undo the global sendemail settings for that one repo?
Setting the knobs to empty strings does not help:
Command unknown: 'AUTH' at /usr/lib/git/git-send-email line 1455.

It seems the global smtpuser is causing the error.

Olaf

--Sig_/8hhCRXVumEercKC9xZkK4aj
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWsXPDgAKCRBdQqD6ppg2
fucMAKD6YRSYS3U353zIIjqGvxX+/WQWlgCdFYowLNm7sFfGXHOXR4qs6EKFfkA=
=4WKo
-----END PGP SIGNATURE-----

--Sig_/8hhCRXVumEercKC9xZkK4aj--
