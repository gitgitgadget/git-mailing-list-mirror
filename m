Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2381DA50
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mAo/jkhG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BltLfGTB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id EABF35C00D5
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 04:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703063848; x=1703150248; bh=c+bkSn9K8f
	55TeF00jgUIPh4PUQKYah/DXHNF+bB8o4=; b=mAo/jkhG8qV2hY8KIvuO87Uszk
	4eK3rLdBX+OeSo1P+Vt9PvBkezg4XaFIDy1VTqQwcLZT09K2EWHWqqgbgiwgK/g8
	6k3212f+85f+VgZ0nT3DVCrOrruvgbBbZnl7ZKWs+EeFmpFw6UwJaySYsgj9tVe9
	LyuhHrgSvoMt8bI6HVMRizp4ENsCujYJih/C5TyPBQK1s4zk7tYquzzKrnfpWsAI
	bCXLcChiX8BKm4zr+L1HRTPUHkP6L7y8StNWT26U35DNa9pTx2BRN4fH9pmDdov9
	9Ni39N+5pbXxWjt6ATC0YdHNOFWrk1msO7ANyld5kAoL641MHUD3cr9PNT7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703063848; x=1703150248; bh=c+bkSn9K8f55TeF00jgUIPh4PUQK
	Yah/DXHNF+bB8o4=; b=BltLfGTBS8J2B0ko2uH7U9maFDtKsstxVEkDGueFxqVL
	rk5ORou4cBp4/I2GPYY5SnyrTM5rGVsNa9Vx8Ts4JpDAcAjmYeLE/5/furBRQFsu
	1nuVIGxyJ1MEhtahdiilZNgWVXv2Aw0H0RIsu6aSgE6fIRiyoQ33ZINJh9igZGCp
	N1sKGxeVZGfvIdFoJ9TbUy+dMbaWwS2dcDEF/di7S3T6H34s5n+6wKhvTQxShd0A
	nNvNZoFyaP5q8asJinowhuHskJYoa1Acz5UV/JgPA7kiAuwLeMjFinASzbzgRHTq
	KVttAcHaOSkbdFUzAAdGboX1CMkfVaZ/Tmp4E/pQHw==
X-ME-Sender: <xms:KLGCZdE6QHFbyaRzkW8kQb1ZcLX-uwApU7XTGTnh0DKGR0h6WXyTkg>
    <xme:KLGCZSXt0quv5_cfkXVd9GqdSsQByE5DO9HUWSG6a9HdneoylRw07-ao9LZrEDn4v
    rBQ_Mh-qVbWBfOjYA>
X-ME-Received: <xmr:KLGCZfKOWlUXw7FwIDscvTqp3cpq-DA9NvX068zkXXcEA8gt0gkxdLahLFK5TE01Vq5MyeQ9R3FYOVhohycoPnGu66EoY__biYXjR-S9a6nTmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KLGCZTG195tKkOLeM69TEfM_m-GvXTw5X5X7TcVXr3xKNGZUc7UolA>
    <xmx:KLGCZTXwsbhYHHNjQu3MSFM4nGPHGxmj1qsRQETLfSeEBVWuNzThTg>
    <xmx:KLGCZeOAVWnsZpvuQ18XINdsIRAUCJ-IjQly-AAgwllfUn5nB4VQLQ>
    <xmx:KLGCZaC_l9gOQBKQcaR8vE-8wb5GTFlCWQBYmAfJu0MivhuL3_DQuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 52a6f5aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:15:33 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:17:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/7] reftable/merged: really reuse buffers to compute record
 keys
Message-ID: <32b7ddee28243922ae2754ec69252ff87635202a.1703063544.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bo7J/LYVlSzBBPUI"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--bo7J/LYVlSzBBPUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 829231dc20 (reftable/merged: reuse buffer to compute record keys,
2023-12-11), we have refactored the merged iterator to reuse a set of
buffers that it would otherwise have to reallocate on every single
iteration. Unfortunately, there was a brown-paper-bag-style bug here as
we continue to release these buffers after the iteration, and thus we
have essentially gained nothing.

Fix this performance issue by not releasing those buffers on iteration
anymore, where we instead rely on `merged_iter_close()` to release the
buffers for us.

Using `git show-ref --quiet` in a repository with ~350k refs this leads
to a significant drop in allocations. Before:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 1,410,148 allocs, 1,409,955 frees, 61,976,068 bytes=
 allocated

After:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 708,058 allocs, 707,865 frees, 36,783,255 bytes all=
ocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 556bb5c556..a28bb99aaf 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -128,8 +128,6 @@ static int merged_iter_next_entry(struct merged_iter *m=
i,
=20
 done:
 	reftable_record_release(&entry.rec);
-	strbuf_release(&mi->entry_key);
-	strbuf_release(&mi->key);
 	return err;
 }
=20
--=20
2.43.GIT


--bo7J/LYVlSzBBPUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsSUACgkQVbJhu7ck
PpRlfBAAjDqmUlS9WwkiWKDCvc2LYiQuWSjWBezLMJ2CraX9+dhOK73rPatJTO+f
+HkvlArkEP305dNAjWC6pV3FDz79/OuX6ELHMGg6vLcr8kkHGc162ZyuSQQHMoBp
EY0V+StMD92I/MNGhkTJD3yAWAr4rdW0YWLuJpggFKTA0MvOJ339eWi8hUXaxjMy
uecrTtl0kOgkcfcxG05idnIUPPp/ZCGXY05bInM6vT3swuYvG9wX3FCGmbTxvoA1
pc6LL74GIZ/H6lsLuK8/MdWg2Uf1xigc7iQDbluLYO2W3rrPbfsRpFVC9zXlN76P
y4r6ojjRUuoKZMT7YVjzyMu5tYgtmqId3YVldUHNAeLOZZl+Q9nh0JUhPHNTJqAC
MXOAIDnST7iNlTn0su857hbbVrhNZrqL6rymhlU2xYBDlQp4MFT2SsgdMUDUThUz
fmuXWYWboSXjTxmpb2hSj7j24SJREZfgxbaqss1mzEzUfsFBI7yLJmauAhyqKrFU
uhjDmxmkWLtbWB5Wy5PPrSLkQWFAr+KnxyTEIu7UZQFdJRoGRiW8fyUfuNB1VI/y
Kwuvrompm8cS0oKb6OiBAeKoWksj5GesiLuui81S86qlz4/Vw8Fy3pHdCi+niGFW
yXf4lyVPAU8WCzOkMwonTOyRKDSoUcFNtvtzrpOmHEAjbcoPRF8=
=ItSR
-----END PGP SIGNATURE-----

--bo7J/LYVlSzBBPUI--
