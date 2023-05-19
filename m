Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BAC77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 15:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjESPct (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjESPcs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 11:32:48 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4444713E
        for <git@vger.kernel.org>; Fri, 19 May 2023 08:32:46 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [67.221.154.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EED745AF40;
        Fri, 19 May 2023 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1684510366;
        bh=banFCDm5SZbFtqNo39cFFelCZ6TpbgsZ+3j/1iF/Ls8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SnZ//nitoFY9jwQjUUsSjaiDLRz8zKvh+JzPHDNpj+PzsiAJcyuCOZ+7ZGsUE+tJt
         HptbD0Fcy+lu+iZnZCETnEUssi9eFuf6V/TRs7DL4CWwV0JlO+TncvV6qsUQffFyS1
         Kh4tsUybicPcKqgL01bIRlLUvkJfXkvPuQshv2xt1LESgWBio73b3yH3FNCcJwPGGl
         dZIP4o07kseHlp0IDIi7bj3kCGASbNMqX+uRWLeg74Jo9oxz2IK4BKi3J1k10JvYZ/
         MQO6TZsoNREuoC89LNGLV12/5NXwYFgPTn4aFfIzOMI8xEuAUzdae6GjacYEFBRC4q
         CY/f6MtE/kF9SYV2/6fnLgBWij8Msx8MJPHKmKRKGJsPIR1R7ANqUKXaVEz9c4Demy
         Wz/c4cJcUZrVSn9t+whLxaxpdGfWiPvbqlebPN3FTPPgjhbmJBrIiDvkJcPAjLvbur
         87Mxafc1FRTHZ+fIVIQt2uR9ZWxs/UKpCDm1BCB9oR+GN0738rU
Date:   Fri, 19 May 2023 15:32:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH v3 0/1] Fix empty SHA-256 clones with v0 and v1
Message-ID: <ZGeWmZzbPFviQBmB@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Adam Majer <adamm@zombino.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230517192443.1149190-1-sandals@crustytoothpaste.net>
 <20230518182838.GB557383@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jVajtK9hFhlleI63"
Content-Disposition: inline
In-Reply-To: <20230518182838.GB557383@coredump.intra.peff.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jVajtK9hFhlleI63
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-05-18 at 18:28:38, Jeff King wrote:
> I'm still a little puzzled why we need http tests both in t5551 and
> t5700. Not too big a deal to have redundant tests, obviously, but I
> wonder if I am missing something.

Technically, they work with v0 and v1, which are separate, and I wanted
to test both, not just v0.  I realize that practically, they are very
similar, but I prefer to be a bit more thorough.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--jVajtK9hFhlleI63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZGeWmQAKCRB8DEliiIei
gblRAQCAd0XNeoUT3mOuQIA5uxqHO3ewtoMYklPWwAeRsUfYpAD+LDinZHpuXw3N
paqGO9/3MV0rGVrMhs73r/USN/rYzQo=
=Muh0
-----END PGP SIGNATURE-----

--jVajtK9hFhlleI63--
