Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836A18623
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V9XFQHpz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eueJjhDQ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B39AD5C01EC;
	Wed,  3 Jan 2024 01:22:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 01:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262961; x=1704349361; bh=ZVLHiZ2Hii
	FnyoYQac5W3gZUnnqU8PyqnnHeSaBy7Sw=; b=V9XFQHpzVnG97Lh8LMiSMKq1Su
	NsJk6yy0pV8t5RyV0D4xCHgDVq787ATvATDiSV2djw2LeKVxNvlt5aQYxDlaj2FI
	M6cRO8OniJDsnwFiiBfU5C1Z0zwXLGeHeFSzwqDyC7k3s7uPhA5mTWMDoqmvq75i
	6NJy25GC57cDIUiah24z80iDL6zEiK0CFI91W8lLUcviyleWUePge/aEwtsyR5cu
	IuI0IlpenYHUp4b/Cx/dNC/ZtpZRanqMArc3ppax4S0U3FrTxnMTdwODuxyEOjDC
	9TnObGlzrwgew53Ec+3hKcqVhWLl2aEUc5aMD6FlQDAXSETUaDTZVd6t60UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262961; x=1704349361; bh=ZVLHiZ2HiiFnyoYQac5W3gZUnnqU
	8PyqnnHeSaBy7Sw=; b=eueJjhDQzKuw337rq/TSZgwbrSmL1ubKPBc/hOZjgbmI
	m+h5TQSiWXOJ43npUrnJs226rUlnG0jA5zVlY28V2yoelII/4NR97CC7bWQsvi8C
	vHiXcF1K/kdTePsPbZeLXWMpBhcg4VhRkf1xxj8nVd+mm+mX2b07rocZV+lBSceW
	EGh6bA5z39RiLMeMwcMk+jYTDnRSTVP5FMA/d/GGfgdNnShYDPgHWNpSDCyn4zHv
	M/kw8qkUNevFehp6AMnwLdiReeVrm7iW2VK8vcd4AQDuuuXBczQG81ZVbHaAs3Kk
	A+9/Zprrf9xfbZke1pfyzwv5b0kRZSgKEzC4LB5iTQ==
X-ME-Sender: <xms:Mf2UZXXKg8DMTBv-KZ-bfZUmsfYv9djdUpXzudStRf7bEmNIjVGXXQ>
    <xme:Mf2UZflt1MExJMA6eswrPIwe45jIHd9cBLau_3dfRKloLrbJHIKV8gy1rzJw4ktjN
    mrm-KfnQ9vX5o77Hg>
X-ME-Received: <xmr:Mf2UZTbhLKk-XET47bCPF12kGcvPep5lYDDpKRQMBt0EqviAFB61bl4bLIoQPCV0fDXFnzC6NOyeDqv9bPP4KwcpcFzWf_uzx6LOmFN63G-M4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Mf2UZSXUHRHsIInqs96A7sRwuadVNt4DfX2_W7ewjyBxvKYP_8lUJA>
    <xmx:Mf2UZRlWrPqOFVbzl0x7Hxm_e50JwodOyVoLsaBmBR52iqxYOXsi3w>
    <xmx:Mf2UZfe6rR5UzTQYZKJJJw3BjLS68xh7dq7fBpvpZ_SCYsOnynd7mg>
    <xmx:Mf2UZRtfS3ssnuNS2djagcnAkzEgfwG9iGfJJA5vhkCnWoHxUQ-9aw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b1c86c43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:20:15 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/8] reftable/merged: really reuse buffers to compute
 record keys
Message-ID: <845dec239019886575ba6796f34b0181c78981de.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4OCtDok4Oz54658"
Content-Disposition: inline
In-Reply-To: <cover.1704262787.git.ps@pks.im>


--l4OCtDok4Oz54658
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 829231dc20 (reftable/merged: reuse buffer to compute record keys,
2023-12-11), we have refactored the merged iterator to reuse a pair of
long-living strbufs by relying on the fact that `reftable_record_key()`
tries to reuse already allocated strbufs by calling `strbuf_reset()`,
which should give us significantly fewer reallocations compared to the
old code that used on-stack strbufs that are allocated for each and
every iteration. Unfortunately, we called `strbuf_release()` on these
long-living strbufs that we meant to reuse on each iteration, defeating
the optimization.

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


--l4OCtDok4Oz54658
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/S4ACgkQVbJhu7ck
PpSmYBAApEIT+VpnSnhemYrYStuwkO3BwJr0zHHNjCgUjgnwVCBONV7fGkSiXqCU
DOFhVRpuwcRT68pmW0FJAaKp8isLkeupOljdTAW2A/VFgjqeyhfTlrGv0+gNBpv8
pbFuD/2d8+4sKqan2pzZmzDXSe5+QjYIYH3ujaUarviBZNadE20mKQzvsOLYlrri
HavMnDTQnbj+jcby0+8I18ekCu9m4HV2rtd8YF+dxrsU+EpPM/DJ+5TmB1TUAEIU
J5xiky5IhLUFSJ/VvxdktRcR2thfB0ndYPkJn8EuyjUK7tsj6M/8ODWOO2fWQj5K
ndra5PUJ/T0k0gOWMjQy0WCLWx6awIIlpEJ+vjmXfCEIOcyJNadRqJOfIxbD/BU1
/qI2ivRCF4QpQ1L6A4GfL45i5dy/oAtuyJR2SrSXeM5rfB9pjIt5tg6GGYYFIrMf
IEB0W/zS5PPagzYb+zX/2hOQCqsLEay/X1YuBmtbcTkD2QPELTiqz09foflkVu0m
E9V6ejtopQNeQhtEhiCP4gH60jY18zuLQxQn6USn+Qv6UaNTqUiM2dmPCZ+Ftqwi
b7/aQpARHYUINXCAlJpH3eGCRsSxhau9ixmNoj9hIMkJADm6xnu6Mj4wI01CSWcz
O+yXMcN93CtljMu1Xe5pQQWz1cnrsi9FkaUJLV8PvoonR2WNihQ=
=DOZd
-----END PGP SIGNATURE-----

--l4OCtDok4Oz54658--
