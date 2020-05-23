Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5F8C433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 12:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BB320814
	for <git@archiver.kernel.org>; Sat, 23 May 2020 12:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KrrBN/DT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgEWMWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 08:22:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38626 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgEWMWO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 May 2020 08:22:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4C0E060427;
        Sat, 23 May 2020 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590236533;
        bh=DhF/+1Id8ECVT8dyV1Co7Rtu+zumInlHWqHfrxpdQQA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KrrBN/DTjHBgFV8U/NZVFVrpU0AhNVR0MVBW5NMMZbEtQa4iWwOD0Ki54uo19nyuG
         M50nDNY9YLL3Re8WG4+rRFKt4oB3YAB+rlGyHqQMSIx3iSLFhmP/Z8s0PdzwpkNFX+
         dM25MoEXa2aN4pNri+whzGn6WG+Hi8TknXEmygpwBPfJlKG4ymGrTdSKh8ImwtMSUv
         EXnC05sEmAOXhdo4hBe2yOMUaQxHCxobyrKn2zjUsETcZsIm9pe7E81DVIb2E+aCCw
         pNV+uBxnBBenymNhHQpkzhUmc0/OObQysEjmXMtycGP+w669QwZplE2dG4ac1PPQJD
         iNslcQrMs7qJMsAmaVokmVgrBc0DE9tsSTgUeJUDXKD20Nt+W6Lp+/gXmBraffKIEo
         dP0M3AaCmysZVAGgzgkPNVRuZfbD0OhehBOLpakSw3XcfwooNDPmjWyUja5t7cYNBi
         ynKKIpURAG6GPtNevWlnVCYGiiGgXJHi78uiG9LStFubk8NgI6W
Date:   Sat, 23 May 2020 12:22:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] builtin/checkout: simplify metadata initialization
Message-ID: <20200523122205.GA1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <20200521020712.1620993-1-sandals@crustytoothpaste.net>
 <20200521020712.1620993-2-sandals@crustytoothpaste.net>
 <xmqq1rndtcmd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <xmqq1rndtcmd.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-21 at 17:35:22, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > ...  The only case in which we do not have a commit object is when
> > invoking git switch with --orphan.  Moreover, we can only hit this code
> > path without a commit object additionally with either --force or
> > --discard-changes.
>=20
> It was easy for me to trace the codepath to see when these options
> are used we end up with no commit object, but I ran out of time
> trying to see if the "forced orphan" is the only way to end up with
> a NULL in new_branch_info->commit.  Assuming that is true, of course
> the following perfectly makes sense.

I believe it is.  The only case in which we have a NULL commit as far as
I can tell is with switch and an orphan, and in merge_working_tree we
call reset_tree either if the changes are discarded or unpack_trees
couldn't do a trivial merge.  Since I'm pretty sure unpack_trees can
indeed merge with the empty tree, we would only call reset_trees with
--discard-changes or --force.  And reset_tree is only called from
merge_working_tree.

In addition, I did try other situations plus the entire testsuite with
my erroneous first patch and was unable to cause a segfault anywhere
(which would have been a trivial NULL dereference) in case I missed
something, which leads me to believe that this is in fact the only
situation in which this occurs.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXskVbAAKCRB8DEliiIei
gUvBAP9E3mdLX8ZEFhSkvB2FL9HahCu/QA4oKZgRWAI0WjkFZAD9FbXJKFh1Af1I
rnpDWCYdftIGij40hdP0qUX4ljGfcwI=
=TEsB
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
