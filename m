Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDCE31F405
	for <e@80x24.org>; Tue, 18 Dec 2018 21:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeLRV4F (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 16:56:05 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:46512 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbeLRV4F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 16:56:05 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id CC17D335C39
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 21:56:04 +0000 (UTC)
Received: (qmail 27120 invoked by uid 10000); 18 Dec 2018 21:56:01 -0000
Date:   Tue, 18 Dec 2018 21:56:01 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Skipping history and save bandwidth: how can I jump between shallow
 clones, without sending unused blobs
Message-ID: <robbat2-20181218T203023-954479960Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zGa1rFMfQatMxgJk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zGa1rFMfQatMxgJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think this is encapsulated in the v2/promisor work, but wanted to
check how close that was to fruition, and that it would indeed be
possible.

This would enable replacement of any workflow that presently uses rsync
to update.

If I have a clone (ideally shallow already) at A, I'd like to update it
to the latest remote tip at F, ALSO at depth 1, without fetching the
intermediate history (B..E), or blobs unique to the intermediate history
[and no longer referenced from any tree at F].

I critically want to ensure:
- that the remote does NOT send any blobs that I already have.
- that the remote does NOT send any blobs that are not reachable from
  the new tip (e.g. blobs that existed between the old state and the new
  state, but aren't needed anymore).

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--zGa1rFMfQatMxgJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlwZbPBfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsRv/xAAgBZ7qytVqGz/rMnI5khIyuWcjPNA+IarUThXe+Q43j9XVTF/J7hbDp78
mKfmoINaOzSfG9yGfM5C4MHlr2/z2NXKrTA8skL8TgGAbRQXKLFiOFViSjHBC+k9
v15E9Bfy+iCkIr9oi9x93vawMF61oZQpuKVELWbxI06+QBjq1MHL/yBVmI/T155Z
JVBvePWPiy+EKxD1Orqh5Q8ntbPd93E6R+NMNym6lFs6I2E7AeMe2vl6swgYBrVa
OqdZny7CA65eFLt8Io/Q60jA8ceYXphInnT7yCRjLty7SJnefRPJGVtSzcv5sTkX
oUDR6grwdb45MrKY3YAaWX7StnD+PtuTGS7LT/peP1lviKlFfwCgCjiK4Uzf3u4M
q0dZ+x9LScqjklpN3Zkipq+Tz2zAbiWIQPXuU019l3/vuebIvt1f3vJDi943jlYS
x5xNSGQj+ApOyhkf3azKbcNIKmaUCAZh7UmtGMsFLbjkRgE8ljmW3ExXKphJvaoq
7x/TrdGgxUNdVjnLE6+jX2r45bQeA1xM+LMqWHMEDXQnnMdfPKVAZozU9Z7DUW9E
bKUH5cowRBG+chP/ZJAb/qWyhZ86mZrIh2x2rLcx54yZ+m9iVrSTWik7QPPgynPN
oPGJWEo8v4ydLrwfZqLaCp1qGdJn9gJRL//8tugTM1MCMAxKS5c=
=BV2T
-----END PGP SIGNATURE-----

--zGa1rFMfQatMxgJk--
