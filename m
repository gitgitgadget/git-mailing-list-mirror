Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740181F453
	for <e@80x24.org>; Wed, 24 Apr 2019 10:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfDXKrN (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 06:47:13 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54889 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfDXKrN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Apr 2019 06:47:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D797C308;
        Wed, 24 Apr 2019 06:47:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 24 Apr 2019 06:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xkqr.org; h=from
        :to:cc:cc:subject:in-reply-to:references:date:message-id
        :mime-version:content-type; s=fm1; bh=kQi8W13be6JeVNcR83xt/9nZub
        Ioox9tn8kmNuex6AI=; b=o8G3E8nr+3cN6iz9hzQvurIJTXywEwj8fHBo+ScYdU
        l1/dB1Ow7a09viHJQa1uXMs7vTWlJs9/AKOMVVAmUyE3fhYHvdXB87r+bEipiIMN
        Cb8Org0FkYHqCOIgCOAnSb9NzKUxHLH0O50SsQifRXPJtmtMSSu17yVPp9YUUtiG
        IpNIZ3aHyA3/uH5d+kmxfYamKmXTDZYa3stbYmn2IHRUJGaZg++YEd0OybF1FRtk
        lQcOeStscMEUB/Z4tm3/pehU+sthb5flyyXs3HCe2Asv+ojIUzc3j0sFyOBLcdLh
        4Akjca5OYkU8pMSqGyUKCw9gyyhVPgoEEd5NKXMsXG/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kQi8W1
        3be6JeVNcR83xt/9nZubIoox9tn8kmNuex6AI=; b=UkmWmyfN3i7uBltRB+vqLv
        NcYPUicXKIJWHi5EzqqGdFCxI9WXc+5mlk8npW7Jp2e/ErASX2bQkCo0F9L9tp7x
        yUdI3rO5h4ADYrQbGi8wrPzAYUoGQ2WjajiJ1YtlBoFTaFSY92c6oHvwJgevNpg6
        0TtW9M69AXYXvdQCT8ThBXvom+W0z/hVomnPlYzKe8OrzBYjWqiPTH1FDPkVDFND
        V3pJ54V9pe/nWrP0uYCKv+WZ0n+K8lXieGoLygTeCnkF29pFNjqb2x6w7nXeWPmw
        vVw7IEMMG2K1a/n5FJuEg3td1Uqd8kbOIoclF8UAgD4591YOYU/WtmdXP+4EIHOA
        ==
X-ME-Sender: <xms:rz7AXOElAlDaX7LTPeBNcUzO47VMwiu6xjigwm0frF0MnImhceVlFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrhedtgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfggtgesghdtreertd
    dtjeenucfhrhhomhepvehhrhhishhtohhffhgvrhcuufhtjhgvrhhnlhpnfhcuoegrseig
    khhqrhdrohhrgheqnecukfhppedutdelrdejgedrvddtiedrheehnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrseigkhhqrhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:rz7AXET86hWDBMfIm8jskvRdTIG47mV7z94JveUHu1DhYqsdukMP6A>
    <xmx:rz7AXMaw4nv2JgS6qKkvHnIsl8EI2G4pUvE4P7s69Gowxk9qpAN8gw>
    <xmx:rz7AXH3egCbY_r7mIzNqHlQbNPofVesf0YaPUQI7g3yrKqlnReeUQA>
    <xmx:rz7AXH0Dg_SCq__uM9V5Yifqj02Udgn1mX6OD7xYqXjrmAxIptsOiw>
Received: from localhost (vps.xkqr.org [109.74.206.55])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0671D103C9;
        Wed, 24 Apr 2019 06:47:10 -0400 (EDT)
From:   Christoffer =?utf-8?Q?Stjernl=C3=B6f?= <a@xkqr.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: git branch returns EXIT_SUCCESS when no branches found
In-Reply-To: <xmqqmukf1yh9.fsf@gitster-ct.c.googlers.com>
References: <875zr3iucd.fsf@xkqr.org> <xmqqmukf1yh9.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 24 Apr 2019 10:47:09 +0000
Message-ID: <871s1rissy.fsf@xkqr.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Dear Junio,

Junio C Hamano (gitster@pobox.com) 2019-04-24:
> This invocation is not in line with how "git branch" subcommand is
> designed to work.

This is fair. I completely accept a "you're wielding it wrong" answer!
However, your explanation sounds to me like that invocation is exactly
in line with how git branch is designed to work! What might I be
missing?


Junio C Hamano (gitster@pobox.com) 2019-04-24:
> If you want to ask "does the tip of $DEV_BRANCH reach commit
> 'master'?", the right way would probably be to ask
>
> 	if git merge-base --is-ancestor master "$DEV_BRANCH"
> 	then
> 		echo "master is an ancestor of $DEV_BRANCH"
> 	else
> 		echo "master has commits not in $DEV_BRANCH"B
> 		git --no-pager log "master..$DEV_BRANCH" --
> 	fi

This seems like a more convenient command for my current purpose,
although it's not a complete replacement for git branch. Thank you!

Sincerely yours,
Christoffer

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSnhhl1PrVuOSPiCuJ63EO1dkwMBQUCXMA+rQAKCRB63EO1dkwM
BW4uAQC4ducAE3SSh0rM95IXtuliDxicVWYb7qxfffbKjuRp9gEA6SuY77QQIecB
XHiIZhIBMq29QwGduS9CiV6RGkzItAQ=
=eH+d
-----END PGP SIGNATURE-----
--=-=-=--
