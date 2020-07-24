Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA52C433DF
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 01:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350EB20714
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 01:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BNMNyIPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGXBUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:20:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbgGXBUW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Jul 2020 21:20:22 -0400
Received: from crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B4460607A2;
        Fri, 24 Jul 2020 01:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595553591;
        bh=YnUc40r5aFkdQ9DOLMH6sy8h+rOn/tcxWVaSmXkpx/0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BNMNyIPd2nzT1bXs/Lil9dFK2bPkOlhAygqOwRwLy6rUR2i2MAEiEhJd964Nfszct
         roumqb/R8uSVCr+zxyez+pvndgCNT4qIF8k2JiPm6Gm8VoDVza3ITmIpLmaqmLXMpn
         F4MOLrdId8uP3YGzHjRgxGmO0BMDpv1vRN035TDSw1QoHElZbM2Ozm08ynuI84LEfH
         BhxIUTmex/Uv56h5PDRGYyCSQIpK5733pa1cFHf66oDu3nRLjSR4TzN3dapYOBJcMj
         XDgwhUnl8K+eeJXl8mdQO1/TnI01ZTc0CxgDqIeJNqD45A+LRzgu+B7Edq+SzClY3d
         RiXaa1qpfFNOa3ywvv1RspPK7f4ZUBa/c4v9AAEiHtnCeMoTjE+p5b2j00ohiLPGiI
         MJAG+cJZcPmcbovGhmapAui7HDh2+mA9gHq/xl9o/XqTjlZ24o9Q50Fd2k88MrNR/o
         GMUsLLaqQnr9/MZ/Qw2YBXfhWwmRkLGiPU2xqqsMftTf3RGwnNF
Date:   Fri, 24 Jul 2020 01:19:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Casey Meijer <cmeijer@strongestfamilies.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG FOLLOWUP: Case insensitivity in worktrees
Message-ID: <20200724011944.GD1758454@crustytoothpaste.net>
References: <EEA65ED1-2BE0-41AD-84CC-780A9F4D9215@strongestfamilies.com>
 <8BABB6F0-517F-4AA0-9FF9-92AF8C33CD0E@strongestfamilies.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline
In-Reply-To: <8BABB6F0-517F-4AA0-9FF9-92AF8C33CD0E@strongestfamilies.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-23 at 15:20:50, Casey Meijer wrote:
> This just bit me; it seems quite old, and I wanted to propose an alternat=
ive solution (maybe it doesn=E2=80=99t work for some reason I=E2=80=99m una=
ware of):
> https://marc.info/?l=3Dgit&m=3D154473525401677&w=3D2
> =C2=A0
> Why not just preserve the existing semantics of the main worktree by chec=
king the worktree refs first unconditionally and only fall back to the main=
 refs when the ref doesn=E2=80=99t exist locally in the worktree?
> =C2=A0
> This would have the added benefit of allowing power users to override ref=
s in their worktrees and would, if I=E2=80=99m not mistaken, preserve the s=
emantics of the main worktree in case-insensitive and case-sensitive filesy=
stems.

It isn't clear to me exactly what you're suggesting.  Are you suggesting
that we allow "head" instead of "HEAD" in worktrees, or that we allow
refs in general to be case insensitive, or something else?

> Anywho, just a thought.=C2=A0 I could work on a patch if this approach ma=
kes sense at least as an intermediary until there=E2=80=99s a pluggable sto=
rage backend for non-FS stores =F0=9F=98=89   (I'd also be somewhat interes=
ted in implementing a postgres/sql storage backend if this project is movin=
g forwards __ ).

There is a proposal for a ref storage backend called "reftable" which
will not store the ref names in the file system, and work is being done
on it.  There has been a suggestion for an SQLite store in the past, but
that causes problems for certain implementations, such as JGit, which do
not want to have C bindings.
--=20
brian m. carlson: Houston, Texas, US

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXxo3MAAKCRB8DEliiIei
gaqIAQD4z63fSbwnDqKAQF3Xy2+F8iHCGNslM0hSiRdy3iYLoQD/Xx2DPX48fCyn
2ZBYflDtRUPekuClxs5TrBk8Q41sTgk=
=BFLH
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
