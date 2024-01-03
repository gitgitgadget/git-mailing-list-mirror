Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B012C18053
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V7g+B+xF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ToUNbGvU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B78165C019A;
	Wed,  3 Jan 2024 01:22:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 01:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262939; x=1704349339; bh=Fxf4ccFifo
	Mq7CopDOK6rkoC+1syMSYWoybI9T2OtC4=; b=V7g+B+xFuu5ronayLDUZ/W6V9E
	mTYMNd0oyR1W6q+tbm8OahMopx3VMNqa3K4i8CiJ2Rxa2juv1BS+OrNSo8snyL5Y
	aLdrDiCAQKK9J2nDGZJG8C/RKXJsb71ID/MauYgLIQJvH1/3fn3JsjRSPgEOalAN
	V+sYYIuOJwtEOme3bbyxWuz9+VTsw5RMqaFJa10oZG5BeT10ay+89WhN/c7hi+IC
	rzebiA9LgWeJiRfoV9U7IVdRDsDEGc5ZnsqlIs5tIgyL+YTQRKZF2McuhvVMGQyr
	sNygw5BOKbCymFWUgpqxoemADx3dUXOBTLZR+ROJ7ddOYN2IqkVsGx2phBsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262939; x=1704349339; bh=Fxf4ccFifoMq7CopDOK6rkoC+1sy
	MSYWoybI9T2OtC4=; b=ToUNbGvUC9csq2XGb3fkIjQ4qY//TA/WEaIKRSR0naIk
	PBn9KSR2RaLihLGruRNCByx9lI7RmDJfmWQiYwqo+FTQ7QAj+zNm8p1WNzfO5Usk
	kt2ko4kQHSas2LYluIVKlj5Xosu8rhiz/v5RkXJe4erExSYgeDM78ll9noi3Ske1
	PabGa6cmvFCbBQClaBRX5u8uvfbfqbV6W9oJ8xASENaiYGGrkW1gnMIFGUDe72YP
	0NTY5AuObqRugCa/aY3Hg7psQhXQS2vk8sCVQcZashO+iiFmN/8PeBrepm+vDMUV
	ZNcrBX2+P+hS0WYivKesYhAa5Wf0TSmv4ePCq1/aWw==
X-ME-Sender: <xms:G_2UZbxfWiW5crMV5xtn02ZwPIKhaAF21Tz3caNEsxDeKjbEAXZ3Vw>
    <xme:G_2UZTTHw6rbgaKQg2FDPtXhUZyxJ6nBWCRZzt9Dg5oSea-j9Gg0WuQy2mXqscJhj
    YLj_dRmUyGW4FUltg>
X-ME-Received: <xmr:G_2UZVXhpE3y79WsPUeppfrdVtQ0Qv0BUamF_Wq3uVSavGsB4aN-2GyQXyPCbuGmBChg3cHY59PkYkCrZrne6l_69hthLSVshYzCWDWeU9LRxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:G_2UZVi75eaNmMxvPnNxrcbFjP50d7zUrDKseIPXJq0b_OSYasy6iQ>
    <xmx:G_2UZdCYhfdAgKmmIutqDTmPwyd845lnQEHS835Rg3fgzSVxcxanow>
    <xmx:G_2UZeKM0ytnG4Y9LyASb9OrIpScK_w9gEzEh7jirbtzOhl0SYPT9g>
    <xmx:G_2UZa7ZB0qq_oupWJvUkML_ZyQD5LTgif-23uPJROPKSqLQkIHnzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9f7b756 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:19:53 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/8] reftable/stack: do not auto-compact twice in
 `reftable_stack_add()`
Message-ID: <eccc34a4b68ccbc5097e807dcb349e2dd9f5b58e.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XaJB+aSmv2TG/h7K"
Content-Disposition: inline
In-Reply-To: <cover.1704262787.git.ps@pks.im>


--XaJB+aSmv2TG/h7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 5c086453ff (reftable/stack: perform auto-compaction with
transactional interface, 2023-12-11), we fixed a bug where the
transactional interface to add changes to a reftable stack did not
perform auto-compaction by calling `reftable_stack_auto_compact()` in
`reftable_stack_addition_commit()`. While correct, this change may now
cause us to perform auto-compaction twice in the non-transactional
interface `reftable_stack_add()`:

  - It performs auto-compaction by itself.

  - It now transitively performs auto-compaction via the transactional
    interface.

Remove the first instance so that we only end up doing auto-compaction
once.

Reported-by: Han-Wen Nienhuys <hanwenn@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 8729508dc3..7ffeb3ee10 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -425,9 +425,6 @@ int reftable_stack_add(struct reftable_stack *st,
 		return err;
 	}
=20
-	if (!st->disable_auto_compact)
-		return reftable_stack_auto_compact(st);
-
 	return 0;
 }
=20
--=20
2.43.GIT


--XaJB+aSmv2TG/h7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/RgACgkQVbJhu7ck
PpRIgA//UHCmZ9h7hWFUyaL6OMppH3V8tdxsUmLzbtpAmlRw/bExJEGSNOBRFGc9
yTCYKmxF2AaGfHYNPG1Qx5sIrNPMPl7dCBG2Ix2T9pOC64PJYhxhrGgnmtQrNbg9
OB98ir5QG4yypGgL+vNrbkVsHNAn5o+CQWO2IFoy+yAtd9U1QQsNF72TKmM213Vt
184A8jycJeUA3l4xq8uU7ygiY3wb7dpPdxn0zTbtGRxavOmYzIvMgIAquFcntqTy
EOTpwjs0PickV/1yQU7TW/5skDZp66VF7lnpvwJe5FrcERAu3sKcD32HivEAhY4r
uakFZSjwlHixkpzL4hM+SxsG5OLdM7K4xr0vQPG4uJ/p98p1ouWhv1FC7SE2OhGP
8thtQI4mBTv2LI//HX333zUVivgIJCVYj48D3DtolWmbbAOhhCFgvi/PV0sMeNhZ
5fFLhyUOXd6ByJA3hhpQJdnF6QHzDtbcTgUvOGTLilxFxFpI1lQDZj8ulWuHhLrp
I2NJjpOaZwAlbjzkpOXpHSY8A9i0WZEs3faw8paFC19rDg3R9Mcr9r0XGXPIr+ay
RiFIRhjsRrtgR5TNjAH9qeKmglUUVnxcfQowkYRPmpRSlALUvI3nUNVOXmPe5OD5
NFkem7FxqO/1zNiangRomaxp04KGFwwPtnkCi5N3A6Xh729SQxo=
=TyQq
-----END PGP SIGNATURE-----

--XaJB+aSmv2TG/h7K--
