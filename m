Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D209C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiGKNhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGKNhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 09:37:54 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 06:37:53 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5CC3DBF9
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657546306;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hqm7ThDt9agAe+RpyBB/d6cUGF8KIFcR9Db4AeBPQnQ=;
    b=aEs9jz8cylKSGnBj/L2Drnl/IUt5f6XW/1GA4GlZ7Ak599UfWsVwdRktO+hZ0gRyzr
    2e7AspSHBamYFTWcLeqHBNxPRp3VnzhR8SuqCwa1BQyVv5telwYExYHbJziiN2Sq/8dW
    e/bYrpodgLi7uuTPLYJC/UBWpykcoWQNmqiuj3sDHh6fXh9UEaYsMt9sh6gixDOcckT3
    ARIHbBrrBx1U3qRUH2bXA8WAk69nuqL58HL7geg+xK397pscq8CIeFq8k/85b4iEwbl9
    xpNIAn1wmojbyaYGdNIPNH88Q4nRVjIbeM2RV7k6AMFE+n0LIBHkLCmhhaHobTvn0FuN
    4EEg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuDsbSEit9KU5r3k6L5NRbajILDt10="
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 47.46.4 AUTH)
    with ESMTPSA id k61132y6BDVk0rb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <git@vger.kernel.org>;
    Mon, 11 Jul 2022 15:31:46 +0200 (CEST)
Date:   Mon, 11 Jul 2022 15:31:35 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     git@vger.kernel.org
Subject: git tag triggers out-of-memory killer
Message-ID: <20220711153135.35b1b135.olaf@aepfle.de>
X-Mailer: Claws Mail 20220621T115632.b389e5f8 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HXomLddaDJcqjYk/0CsBJOd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/HXomLddaDJcqjYk/0CsBJOd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

What knobs exist inside git to restrict the amount of memory for each indiv=
idual git process?

Running a large number of "git tag --sort=3Dtaggerdate --contains " process=
es in parallel triggers the OOM killer because each one allocates more than=
 one gigabyte resident memory.

I tried to set all knobs from git-config(1) that appear to be related to me=
mory usage, but nothing seems to have an effect.


Thanks,
Olaf

--Sig_/HXomLddaDJcqjYk/0CsBJOd
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmLMJjcACgkQ86SN7mm1
DoCxOg/+LYr6LyreJ7AQBQnqe8oJbR7XLtARqnNipFPXz3LPD/GsHS2s91JM/0j5
9UbhIMLyTagOG5H7h3R6Wql8SEf3OyjakNpXrG/MJqCApmzKmQYfAbIAouogKVtY
WvNePl6Vecvny2+9fVtlmVZEr9N+JO70LtOqWMUuVXqpmOamGElgcBJYoIFOdYEY
vinGr+r1nRhHv07OZ+8Uea2rX4OLyaqV6e+xmNS6imB+pa0I/59CVSRLWLq9X2fA
OX8rWnlh1k0TdTpCvWPYcAC/JSgIk3//8h+zkSr5sXMrOK79WX1+4dodVIkFrg/d
RG/RAultqEwhXzSyNWddrvnaSm1fw+piGCIiDKcpWlplyX5pvV4TI5jFXKMrPsnz
G/Fd/JlGEGvQP5pC9jvvNptRP6Wu/sp4uHdGtT4TVn2dsubvDcbuWZCYaUel9PPq
fAgEHLts6oFHkxUrHOdyTBqWznQcN1Zpmt/061yTbSPH2uWdur4Qiw9dY49+2IWt
RdYNVkjou2dAy70rzhbgHId1ucVI1Q1eTA3TUkh9ds1IEMjRxiEwu++ByqzAkFOF
tkfFu4vwui0LPWGGHAamsE/otZny04QL+4vhPubJPrH3Te1kRVO80wHjCxB4VlmN
vk8KqdgcM/7+K4QkGpRaKaQlEUwKTs7dVbqfIvR4DNuHoGW02aE=
=qEdX
-----END PGP SIGNATURE-----

--Sig_/HXomLddaDJcqjYk/0CsBJOd--
