Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72CD920370
	for <e@80x24.org>; Fri,  6 Oct 2017 18:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbdJFSNo (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 14:13:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34637 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752292AbdJFSNn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2017 14:13:43 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 59A6C20B63
        for <git@vger.kernel.org>; Fri,  6 Oct 2017 14:13:43 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 06 Oct 2017 14:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=DjLLwDv/XNb4oM8Vjv
        BrlhLzmL/1qmyFTpxRHe0Hek4=; b=dRxB8gszSnBIJHDiHlFeOfYbS5BNjK7yjN
        SONCMD204whTVZHoJzUunH8NIVb2IrJr0S3SRDgC/2cQvSm2HoUg270QmU40IB2e
        sYxIrj0b9q/VPAz1DHXy38K42TgWULkV0wX6X/W76raNDEdJ4EeMxeqGSr4mYGpe
        WTcKnOwcifXd4UVl+EheywCCXTHTLoyVw/BxatxocSzexY9AK4Ihl9uFHAAi84bZ
        sJf72Dh4oiZr81zTifh5mRDj4i6kRgh1TRPkSmfpBve437CutFyy+3qMXT7pq+gy
        tiZdSeIkyx6Y04jaDzt/znxOgDC/mKm8hT7pvZa4k4DpcSqsFk6Q==
X-ME-Sender: <xms:18fXWfaQRNzbEfmO2DF8lRBzuna2k_-TvOwdDETM-F8SC9kKquvSsg>
X-Sasl-enc: Ab+7/js+uQOFpR39u7Kf7tMWSlj+oOHVAn6MBJ7Uu5An 1507313623
Received: from [192.168.1.8] (c-75-72-214-216.hsd1.mn.comcast.net [75.72.214.216])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0ACCB7E8E6
        for <git@vger.kernel.org>; Fri,  6 Oct 2017 14:13:42 -0400 (EDT)
From:   Jake Bell <jake@theunraveler.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_486E988E-2820-48C5-BC10-74B028982701";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: git add --patch displays diff and exits
Date:   Fri, 6 Oct 2017 13:13:42 -0500
References: <AE36B16D-0284-4AC0-BD5E-CD346036D69D@theunraveler.com>
 <74010545-3186-4224-9A54-649284FB2933@theunraveler.com>
To:     git@vger.kernel.org
In-Reply-To: <74010545-3186-4224-9A54-649284FB2933@theunraveler.com>
Message-Id: <B0494C9A-EDFC-4069-BAD1-8E5AFDD08C8F@theunraveler.com>
X-Mailer: Apple Mail (2.3445.1.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_486E988E-2820-48C5-BC10-74B028982701
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Sorry, please disregard---this is a duplicate of some other messages =
already sent to the list. Setting "color.ui =3D auto" fixed the issue =
for me.


-- Jake

> On Oct 6, 2017, at 1:13 PM, Jake Bell <jake@theunraveler.com> wrote:
>=20
> Sorry, please disregard---this is a duplicate of some other messages =
already sent to the list. Setting "color.ui =3D auto" fixed the issue =
for me.
>=20
>=20
> -- Jake
>=20
>> On Oct 6, 2017, at 1:09 PM, Jake Bell <jake@theunraveler.com> wrote:
>>=20
>> Hello,
>>=20
>> I'm not sure if this is the right place to report this issue, so =
apologies in advance if it isn't.
>>=20
>> Recently, I upgraded from git 2.14.1 to 2.14.2, and noticed that "git =
add --patch" does not work properly. It just prints a diff of what's =
changed and exits, instead of presenting the dialogs to add changes to =
the index. I did some bisecting and tracked the bug down to this commit: =
https://github.com/git/git/commit/136c8c8b8fa39f1315713248473dececf20f8fe7=
.
>>=20
>> Unfortunately, I'm not familiar with the codebase and don't know C =
well enough to debug the issue. Please let me know what additional =
information I can provide to help you all figure it out.
>> Thanks!
>>=20
>> -- Jake
>>=20
>=20


--Apple-Mail=_486E988E-2820-48C5-BC10-74B028982701
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENFtmcOhOFMZ2oYMozkHV3VyCET4FAlnXx9YACgkQzkHV3VyC
ET6NOA/+Nr61cAF60o+0oqxEgJQvnoIyBNYngD6jZi0MJ4cDN56zZTHddAB9ocxW
OKdM7ddWCInWcqICvZPrcjIGdIahFetrAIgjjYXSFY8r3xyDYB/y7Axx/d/ukm/W
zryhoNJYjQBY+ugUhyKzXjNso7K0FLdy8hlVdxIINfwakcPOL2KnXELRaPwIkF/Y
1afPNDkr4acEI8MnmrJfmRdxm+PkM/SVq57v3gZvIvhWU1IIVI8n9Lhvcpg4S3cg
S+JR3ZrGo1nwQHj7F7YxxGD9x0Lhjq6bCElxZ+fJ1BnmtE0uBaU9mqisxqWrCwm7
xmU099IPxgzt8U4oi28OwVq/h22HM6HRccKsi3ko1y03LNGnPNIPD3u52eIyP+w6
DyymJSO5OO6KDY04B+3Z+nLLVTYzp5je9qXYBbbinCEfMrGxbeZ2BH5rMB5M1ogl
KBrwC+jrs5gl3a81ulbH0nJUT2xE2nB9qtOUaK/XUBlUuVquADnvK04Gel0MET/O
ED0lhCiIEkPqNOTK0gkbBsPfM/4DHKeRxNFEgsLJ72AhWal6XUBiv9lx4I9sP5nj
O5F/rPnwqqVfJRDGvU/z9Hbd4HG12Q9ila2cPebzH5tv6HAeQSoV5RyhaUujvftf
jN3YrVeWkI/+E5VEwP90YID3hfwyyi4bS8vAdj7A1xYTjMFzdxQ=
=c8D3
-----END PGP SIGNATURE-----

--Apple-Mail=_486E988E-2820-48C5-BC10-74B028982701--
