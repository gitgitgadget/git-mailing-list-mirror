Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EAEE1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfAGQRx (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 11:17:53 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53643 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbfAGQRx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Jan 2019 11:17:53 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 625BB1573
        for <git@vger.kernel.org>; Mon,  7 Jan 2019 11:17:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 07 Jan 2019 11:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        date:from:to:subject:message-id:mime-version:content-type; s=
        mesmtp; bh=crNvwcak9fN01rbbiyMfwI3bodkswkazWrAJhcJ+odw=; b=d+o2w
        n+quY/MkQautGhnxALGrXyPn7X4Wg+jPlJPQUWbmePKm21K8KWnQC/276gU6RicH
        /HmBur5QE5HECvEY7ALfhdg5svjQojBoAArrQYD1nUdnOm7lAD0C2vOeeat7stSo
        SmEe55ZpEIPTVk3AZOKLsOIxKi0SKK5Xmjqvjo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=crNvwcak9fN01rbbiyMfwI3bodksw
        kazWrAJhcJ+odw=; b=N4DIzEeeeiqShAum66jtLF/4lRx0z84+KoZ4pWqe8dE47
        Hd0He7we4r1V/+40LSRmXu3v6odr5RvjqW7pYdEbQy7L7mmqNlmyb0RO/8Ld/+DF
        LydoTz1V/Npk+DNh3VjpBVJfIbB+/Rd/0/usOhGnxQu2VWnFWS9BYdrXdCs+yJGm
        uSXaWEccms54wzwPEAfk7+MvOSq/d/qlZno3d0ULlXB3qnQgRSzVrQqnVws73YbE
        Fy1vJkS7nPWYOffKMSaFj/HFCXLZfOK4811rmSV0cMdAc8zVavr6QCz74JRw2jJ0
        xVpfUoo+eDWNLYHDHD14z3bOznG/S9E7Zqp8QkVvw==
X-ME-Sender: <xms:r3szXHFq-zvmeBNhwm5SaWUhydYgnqorbUojz-lXtM22_aHPHMudLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdekheculddtuddrgedtkedrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehgtderre
    dtredvnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhs
    qeenucfkphepkedurddukeejrddvvdegrddufedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehhihesrghlhihsshgrrdhishenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:r3szXEdZa5TZ5xRUKnbhYKTc7E9Zb3pa9Mmmbj3d3zXGN62O8KRNIA>
    <xmx:r3szXBHXMfFIX_DU7e3GEgzph1lGXJT5ppy36yZg8F_GwbjDeL5AAg>
    <xmx:r3szXNWYTN5zHQIkbbGMiv60geoTV4RZ_R90UWhhOS0aFMFQG4qc-Q>
    <xmx:sHszXCm27CPLsVgu2oSmj4WTkbB4N2gUgMEr44w0rR4FoGY_ZXl5iw>
Received: from localhost (130.224.187.81.in-addr.arpa [81.187.224.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A33A100B9
        for <git@vger.kernel.org>; Mon,  7 Jan 2019 11:17:51 -0500 (EST)
Date:   Mon, 7 Jan 2019 16:17:48 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     git@vger.kernel.org
Subject: Recovering from a "detached from" HEAD
Message-ID: <20190107161748.pyhgpewymdgjmgoh@x220>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nugazjq4owwqvbuq"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nugazjq4owwqvbuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If I detach my head, then use `git subtree add` to generate a commit,
the output from `git status` changes from "detached at SHA" to
"detached from SHA". The sha doesn't change, but HEAD has updated.

I don't understand why `git status` doesn't tell me that I'm
"detached at" the sha of the new commit, but not only that, it seems to
be extremely difficult to get `git status` to reflect my actual HEAD.
`git checkout HEAD` doesn't change it, `git checkout NEWSHA` doesn't
work.

So my question is, what's going on here? Is this intentional behaviour,
or a bug? How should I get my working tree back to a normal state?

--nugazjq4owwqvbuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYJiwim6S7nrCK5qc2f/n8MS4v1AFAlwze6sACgkQ2f/n8MS4
v1BMaQ/9EIsakha+QXNplp8zwpU/oW4G7N6YK6MhxAglvKq/goGkM4kRz10FMlEe
6jWIN24eNgZ3t9aqMnCOZnE0xcGXAuTxw+b8D8sz250+WlIOsdtmknFXND5o2RKt
Ei+nlmLMxtQmYrJ09ARFaAo0ssmuzNyDPFLQ3XEmOkSHNmPk8dDMNTGoB+/EUOqw
x9XBLJUbOP3Dhrn/eCiRGiZEsFuCsS3UuM3kshuTma6ICrrdcX0W+cHsuE0t2xx6
8PtLSLZNsoyWz3WBlWMWif9jo0m1bONI3mQQhsA+0yxsl62T6/Wpqg2SGZnPLBPi
7Ve//3ZHa6fa6WWONHL8B+P9YU3rEocI3llBODjRlvsr7/sUhsapet+l2jZmaHss
leCGI33R6BfBxSdv2FgHQlR+v49L3bqwIdYDfZJHGqqxSemyu3fv5YptCGW3ESLL
Ak8NpNBjOJkXEHeINUk/QNzRFrTnmsJiRF+RqMp/FpPOikDRneBSTQIMvYJXWz0M
BFPrdEwdUigkagydQlYK2iN4Z4KV4dIAYAqFa9q8fVAICesHHhfDlBA2BP0xDUWQ
StDqdPPUGH/a6SF+hxUheWXQk28PF1/tNO5iKMp4uAPPo5Y4hxlnZ3pfQOa7QsXL
i6r4v9B975dtiS246Futr1lMnrSZ4BFQCDSHtj1gcNlagoANrnk=
=+n+R
-----END PGP SIGNATURE-----

--nugazjq4owwqvbuq--
