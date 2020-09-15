Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E737C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 01:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276AB20829
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 01:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIOBcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:32:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59844 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbgIOBcu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Sep 2020 21:32:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 51C1760129;
        Tue, 15 Sep 2020 01:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600133569;
        bh=d4iTfXWF03zwRv6WJFUn51ZLFlZCzN/K01YiCayc4wM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GT5vd6vp0ArN+cGFJGOXitT3v1L18sgbAuk1sVUhO6vff6xOj1o+twcEGMWxVGm93
         BcjJaTZaGe2Or7AqQT8vL1V467RQTSiWgiKxD4WPUpRWQtQm5RLvryqNs+nKWMz+lm
         zPCbC5mrDfptyrTcaTKGgNCDCkKgy48QhSCCOZtLXY6xrl74Hi0AetBTv3DDQVMksk
         BTXECzpC8mlAauKsEqcEMD0ujT+MmwXtjGj4CYhd0sD8nE47xVtv3VuatiPV3uJ/Ts
         gtjYUJc1CJb/Rdm7I7kQsP2mflXq55h8MaOS3qnGlOtzWzpQ9NAPdGIum4s0zdi2qN
         qEHyR0rPjx/q+6JnQLhDlvUep0FvdAUvv3z8pNE24mqbeVTfzU8xBwM+SSX1glOgiV
         AW82PyzhxDZjmEgsp/nt6N4P1rZIqt13K/49Df9fy3qEYaL5itUQInhWwETXoiB4Cn
         JvFNBpc0bq+H9CmpoqTeJAtELV/BXN75nmB17+x+pjAbE0x6i83
Date:   Tue, 15 Sep 2020 01:32:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH] builtin/clone: avoid failure with GIT_DEFAULT_HASH
Message-ID: <20200915013244.GF2866143@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
References: <20200911151717.43475-1-matheus.bernardino@usp.br>
 <20200911233815.2808426-1-sandals@crustytoothpaste.net>
 <20200912032448.GB1988@nand.local>
 <20200912195256.GN241078@camp.crustytoothpaste.net>
 <xmqqo8m811mf.fsf@gitster.c.googlers.com>
 <xmqqk0ww119u.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <xmqqk0ww119u.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-14 at 21:44:45, Junio C Hamano wrote:
> Actually I have to take it back.  I have this directly on top of
> v2.28.0 and it already breaks tests big time.  For example, here is
> how "cd t && sh t0021-conversion.sh -i -v" breaks:
>=20
>     ...
>     Cloning into 'repo-cloned'...
>     fatal: could not unset 'extensions.objectformat'
>     fatal: the remote end hung up unexpectedly
>     not ok 25 - delayed checkout in process filter
>=20
> The story is the same if it is applied on top of 'master' (which is
> expected, as we haven't done anything to affect this area since
> v2.28.0).

Ah, yes.  I build with GIT_TEST_DEFAULT_HASH=3Dsha256, but if you run the
tests with SHA-1, it fails.  Feel free to drop it for now and I'll send
out a v2 soon.  Sorry about that.
--=20
brian m. carlson: Houston, Texas, US

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2AZvAAKCRB8DEliiIei
gcc/AQDhkMxOzvJ3dAm935w/qzOtrPjEPuJ/stl9+pqAbG4h2AEAsl7h4Sb4S91l
+OiUuOEHURYPhWTpzRdZad0fcs4jfQE=
=MA5L
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
