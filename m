Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DEAR_SOMETHING,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6505E1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 10:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfDXKUR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 06:20:17 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:39213 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728254AbfDXKUR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Apr 2019 06:20:17 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 06:20:16 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4788349E;
        Wed, 24 Apr 2019 06:13:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 24 Apr 2019 06:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xkqr.org; h=from
        :to:cc:subject:date:message-id:mime-version:content-type; s=fm1;
         bh=nD8Z5CJheogTyjAlxzfpgLxoITxcU+w0OIXa+Lwbxyo=; b=F1fl5HEKSJj7
        6tndPWaEPH81QQ7lPRjTDTp6/uUP8WFElwYmF4OpQV9Nt5H4DV8DV56jig1uQnof
        R/87EJz2U4tzIask+P9syuLuzw1CTKrgCpllA/a/UPiq0gowpwv+yh0m8zHiCY3+
        bZZF8JDQimnXYqQ5lIi5fiPDL/E6eDm2R2qCy2yi3NUzjT5bW0Da5CTQe/yP1lF2
        dkeE0hbv2uxjLfHhpNDG9O2VO2oEfOkFkimyGHalWSgZFg5EOIlSyTRyEPmPDCl3
        T4GZSB2GvCBjZkrK+fbVBzLHUEftdro9XHgkFJiJW7DGBPz7tZYPL8nukv/kev4Y
        +1i0V9Aoug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=nD8Z5CJheogTyjAlxzfpgLxoITxcU
        +w0OIXa+Lwbxyo=; b=FCcW2+GHT+recgU+JafASDDe+QVxjyH41KoF5SwbFY0Va
        9ELpXepto33qLCjGOhHR5gnDhRrAEVYg2kbAE9rvCySSTRH1FnrYbfde7ZvzXAie
        AkSpaSOBacNb7S9V89BG6dtMQhvEsoko80EXEbaIECaX+oFZyVKI0EvXfeWT1pLA
        3ziVCROTr6kq2TgKju4qsZzC8X7l5oPrDglaSepKmc2qK4qU83StUCFQzIA21+s7
        vdUKcVYTbO5Cxr5RcN1GXiWcAX9LnzccylXJ5KTYFpRc8HNRqYPtss+KQgFab1XR
        JhmuXR49QrpS6Oca9i/NZxdWXpegJAGsXwVTpFRAw==
X-ME-Sender: <xms:5DbAXJOxyIxZgvdVMN6ypo2QQnU9Ebna42EtgSKCghdrI2m1PPKFWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrhedtgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkfggtgesghdtreertddtje
    enucfhrhhomheprgesgihkqhhrrdhorhhgucdlvehhrhhishhtohhffhgvrhcuufhtjhgv
    rhhnlhpnfhdmnecukfhppedutdelrdejgedrvddtiedrheehnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrseigkhhqrhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:5DbAXFz17OGbB9UCwRNN7atfQt_n308zVcS8Tjhr9kbQgGaM3g9VFQ>
    <xmx:5DbAXHELzhTAt9rEfOkRDLvyg21KACUAMvtVpGe2Esp2K9hDqRT0fQ>
    <xmx:5DbAXBGPkyKy8ebCE-kDSew12AdVzmC9QRMN_ntc6WJ3y2OMMdlzqw>
    <xmx:5DbAXDerSnwTleGu1HSgM62SrWBtFyjsKkZTRKzK8grSrWUuR5GKIQ>
Received: from localhost (vps.xkqr.org [109.74.206.55])
        by mail.messagingengine.com (Postfix) with ESMTPA id 45DE8E4382;
        Wed, 24 Apr 2019 06:13:56 -0400 (EDT)
From:   a@xkqr.org (Christoffer =?utf-8?Q?Stjernl=C3=B6f?=)
To:     git@vger.kernel.org
Cc:     a@xkqr.org
Subject: Bug: git branch returns EXIT_SUCCESS when no branches found
Date:   Wed, 24 Apr 2019 10:13:54 +0000
Message-ID: <875zr3iucd.fsf@xkqr.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Sirs/Madams,

A common use case of git branch =E2=80=93 for me =E2=80=93 is to use it to =
test whether
a particular branch satisfies some conditions. A recent example is this:

    if ! git branch "$DEV_BRANCH" --contains master; then
        echo "The development branch ($DEV_BRANCH) is not up to date"
        echo "with the latest master."
        exit 1
    fi

Except this doesn't work, because git branch returns success even though
it failed to list any branches satisfying the condition. My workaround
has been to rewrite the condition as

    git branch "$DEV_BRANCH" --contains master \
        | grep -xE '\* *'"$DEV_BRANCH"

but this is obviously not desirable in comparison.

The syntax of e.g. --contains makes it seem almost like this use case of
mine was intended, but the exit code makes me doubt it. Is there any
consideration I'm missing that's a reason for not returning a failure
code when not matching any branches?

Yours faithfully,
Chris

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSnhhl1PrVuOSPiCuJ63EO1dkwMBQUCXMA24gAKCRB63EO1dkwM
BSIHAP9ugx2q/aF8KPIFtpB5fNHpirC3Y6CQWEZzVP4jItkQ7wEAu0NlebCsoEq1
O6hRI4IS6rkbxDGuRq32ThOfZ5K6bwQ=
=9hD+
-----END PGP SIGNATURE-----
--=-=-=--
