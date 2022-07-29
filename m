Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B98C19F2C
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiG2VZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiG2VY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:24:58 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4D8BA8B
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:24:56 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AB6685A1A8;
        Fri, 29 Jul 2022 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1659129895;
        bh=rvmh1ziylhkgzmeMvW0x1aMSCs1OIOpjmPj7MsYlp+k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hTpTlK94yQLv4coNOkyvl0QRU5veAg+E9WnVtIOE2e4DLH/aDqcfHxB1SrTpyEHHm
         RjN42GcnvTV9uWvSPlqFC2e/3/2PugWd7dPTIVwFoUY/seMUiVUZRABgfyntNBaCT2
         sTEhVkFjDjU5Dgp9IE6je98POxWbppXte/ysQm7qpMOZOlwBd+/LLL6pAoPsi767ls
         b2UYz1Hg9vfINP6HCxWZ/Y66h85CSVe3K1TYFLQsVPYJU8T5ye5Y6Tk61Ebk5/qCd2
         Kb2PISxg/Yj3PGE5aQYocJvUlcljK36oPzK+nJAo2MOXFzKApFM1Wv8Ocrjwx9boFy
         gnJ8ep7LMucxWwLNVEyYhwZyGCzYCnOWo5PQCkA0kuKAVQGQOtqWqf58UFrhvuNua7
         8xnaCdDK69F8xdL07dnk0ls6jXVQf+W6Q/xbcOrNa+NNemAsJLR5eU+qClxTng9hbB
         b+fCuq43cHpiJempE+mTpjKYoS3XRw5HVAmSsAHqifRZgS5cId8
Date:   Fri, 29 Jul 2022 21:24:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh <neerajsi@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5351: avoid relying on `core.fsyncMethod = batch`
 to be supported
Message-ID: <YuRQJTzA1EtDUFSv@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
 <501a89aa0b2de396b0c7b82b2e24046b9c98c382.1659097724.git.gitgitgadget@gmail.com>
 <xmqq1qu3aoml.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4XwuWTwAPe9LKrPv"
Content-Disposition: inline
In-Reply-To: <xmqq1qu3aoml.fsf@gitster.g>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4XwuWTwAPe9LKrPv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-29 at 16:07:46, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On FreeBSD, this mode is not supported. But since 3a251bac0d1a (trace2:
> > only include "fsync" events if we git_fsync(), 2022-07-18) t5351 will
> > fail if this mode is unsupported.
> >
> > Let's address this in the minimal fashion, by detecting that that mode
> > is unsupported and expecting a different count of hardware flushes in
> > that case.
> >
> > This fixes the CI/PR builds on FreeBSD again.
> >
> > Note: A better way would be to test only what is relevant in t5351.6
> > "unpack big object in stream (core.fsyncmethod=3Dbatch)" again instead =
of
> > blindly comparing the output against some exact text. But that would
> > pretty much revert the idea of above-mentioned commit, and that commit
> > was _just_ accepted into Git's main branch so one must assume that it
> > was intentional.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  bulk-checkin.c                  |  2 ++
> >  t/t5351-unpack-large-objects.sh | 10 ++++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> I am inclined to take this as-is for now.

I think this patch is a strict improvement over the status quo, despite
what I'm going to mention below.

> But it inherits from 3a251bac0d1a the general "we should be able to
> count the value" expectation, which may not be the best approach to
> run this test; asking Acks from those originally involved in this
> area and possibly ideas to test this in a more robust way.

While it may not matter in this test, I noticed that the metrics we use
need not be accurate in multi-threaded programs.  We use integers of
static intmax_t which isn't necessarily atomic across threads.  Even if
we assumed word-sized increments were atomic[0], this type might be 64
bits on a 32-bit system.

I am aware that we don't use threads in many places, but in general we
should be safely able to assume that we can perform an fsync on any
thread without thread safety problems because that's the assumption a
reasonable Unix programmer would make.  Even if it's not a problem now,
it could well be in the future, and we should either fix this (say, with
C11 atomic integers[1]) or put a note on the metrics functions that they
may be wrong and stop using them in tests.

I would, in general, prefer that if we add wrappers that wrap common
Unix functions we ensure that they provide the same guarantees as the
common Unix functions we're wrapping.  I realize I may sound fussy, but
I've been fixing giant thread-safety problems recently and it's not fun.

[0] This is not, in general, a safe assumption to make, since most RISC
architectures are load-store.
[1] This would necessitate moving to C11, which is fine with me (and
already required on Windows), but others may have objections to.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--4XwuWTwAPe9LKrPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYuRQJAAKCRB8DEliiIei
gWx4AP48ZO86HNSqu8TON/NiDLKHk2L07cswuYoCq/Gl1H3cMAEA/wd35XNCRAGB
4AZb9VJKOQJw0yB3fasg//BpfiA2Bg4=
=tLgN
-----END PGP SIGNATURE-----

--4XwuWTwAPe9LKrPv--
