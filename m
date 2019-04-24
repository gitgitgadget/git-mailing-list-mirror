Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12AD21F453
	for <e@80x24.org>; Wed, 24 Apr 2019 10:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfDXKyA (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 06:54:00 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46405 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbfDXKyA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Apr 2019 06:54:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4C1BF49D;
        Wed, 24 Apr 2019 06:53:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 24 Apr 2019 06:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xkqr.org; h=from
        :to:cc:cc:subject:in-reply-to:references:date:message-id
        :mime-version:content-type; s=fm1; bh=J8ihio6up1evVKEqh/ogMKznEk
        Ijud3pu+XThNW9bj0=; b=nwGQ6xkKJeRe3y2BFyHKz8YMi7Jn2kk46kVm0tcNMB
        rAz03X4PCjHCP9u4Hlj780CT+/UEwH/e77+4lszvUHxkTaUGzVZPy/fadmNmTzy+
        TeMloqLNK84mStY2aL2K8ANa7TR0PdzJfc6XfubjZkAh2YX1ncJSmkhb4pk9DbcD
        hvYlET964mEdG4dJVccXAiRGHFjIPUNf9s2RJ6zG6p34kPiosCqh6Bk8EsGdYQdM
        imq6QTAYBBQNTOQqQYL2MbrsOs28y8icyQf8vneiQiBNjXVCI9FE6XuOczavnUFq
        QVitX8Qn9s8YEIl9ABAjos8Eg4B233qPNymVEut9hJTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=J8ihio
        6up1evVKEqh/ogMKznEkIjud3pu+XThNW9bj0=; b=RmiCQzMdKF6j/CQ2IdPaS4
        Q+ZHrY+tS5ng9oBhR5TvCDjvIx336g/ay2w28XpiMr5g/UChjf93T7K2KCYgFK+1
        8m/B9OZ5K0E1nWDCx2hYsEpsbX9ShMg24mYI2GeU6MEu7Se6bNGW5cnevGVITfCZ
        9zD4EpQcLJUKs+M/zYgaiEe8wtXe6QeHF5PEKLwqympY1YXw7I3v0WBTNx/oXHsD
        L8pxk0QXX6lP9I3cbrsIlLuHM3gXyUlFDjrCkXFuDtW+Ncscvkuovi6cooqE9TTp
        MGkTEOIx95LlBLI2BWcWKd5L2RQLZdKlodlB37Txk4SHqGjjk2A0nu0/6u73BGrw
        ==
X-ME-Sender: <xms:RkDAXPY5bzAcGMYJLrDh9bONZCO4RxEgCw-p2K8biSimI-GibJL6qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrhedtgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfggtgesghdtreertd
    dtjeenucfhrhhomhepvehhrhhishhtohhffhgvrhcuufhtjhgvrhhnlhpnfhcuoegrseig
    khhqrhdrohhrgheqnecukfhppedutdelrdejgedrvddtiedrheehnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrseigkhhqrhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:RkDAXCqnW_HpCewTOLkNr0lBW_8TeYtuhzk3OPRrDUGHd8PCc-IXBg>
    <xmx:RkDAXM_VmGQvdluTnhTi0zNgbMMXLouSekNiAEXHSa8MmL9VAwvKfw>
    <xmx:RkDAXJ8M_tBJBt8b4Uv4OLZZ19S8R0LZwgAyyF3FN3w5rCdPyxBlYw>
    <xmx:RkDAXIlgiV_6NhIcwdpNIL30ddf6iHIERdZ0y6OnFTimHhbbk1x4gw>
Received: from localhost (vps.xkqr.org [109.74.206.55])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C184103C9;
        Wed, 24 Apr 2019 06:53:58 -0400 (EDT)
From:   Christoffer =?utf-8?Q?Stjernl=C3=B6f?= <a@xkqr.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: git branch returns EXIT_SUCCESS when no branches found
In-Reply-To: <xmqqimv31y3n.fsf@gitster-ct.c.googlers.com>
References: <875zr3iucd.fsf@xkqr.org> <xmqqmukf1yh9.fsf@gitster-ct.c.googlers.com> <xmqqimv31y3n.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 24 Apr 2019 10:53:56 +0000
Message-ID: <87wojjhdx7.fsf@xkqr.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Dear Junio,

Junio C Hamano (gitster@pobox.com) 2019-04-24:
> if cs/topic branch does not exist, of if the branch
> does not contain 'master', the command will show "here are the
> branches that match the criteria you gave me" by giving no lines in
> its standard output, and exits with 0 to signal that what you see on
> the screen indeed was computed correctly (as opposed to the command
> internally crashing and failing to produce a result, in which case
> you would want to be told with non-zero exit status).

Thank you for taking the time to elaborate on your already detailed
answer. I can see the concern about separating internal command errors
from correctly computed results, even if those results seem to indicate
something being amiss. Is this not a place where different error codes
can be useful?

Sincerely yours,
Christoffer

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSnhhl1PrVuOSPiCuJ63EO1dkwMBQUCXMBARAAKCRB63EO1dkwM
BaFMAQD1Ve9nLSWvitaNGi30r0xlCMNPqSWGJH2xdClI+lsc4gEAtsTyrzvTOCae
8WIRYTckg6m06NkMJhowpMvtSpNZ/gs=
=katU
-----END PGP SIGNATURE-----
--=-=-=--
