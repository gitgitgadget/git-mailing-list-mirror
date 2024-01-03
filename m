Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CB1864E
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xDrDuSeA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tJCOWOQ+"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DB24A5C00E2;
	Wed,  3 Jan 2024 01:22:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Jan 2024 01:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262965; x=1704349365; bh=FqbAHKp6GZ
	pMNU6U9RvoV84G+vN6lNcnKBEXD1pYKy4=; b=xDrDuSeANg0OubpLbcQRkbqg+C
	pzdd6DMKztyX0LoOJgdqUhO9m8VMNv2UWod/lr/2KfzI2zpUzGfIO88JfyFrZrik
	tc9I0dMrfl1L4Kj9nR/gxZDbLHAkK4aZ3fT6EAXY9rMTydeAWmm0/wl0GGFl+wFa
	2PlYRy6fX45Hn3Snl0mR9I5UjkkC0KxDPRnd20QX7QWhRODSN7P4Ncu+1UpkCTKt
	CJPSPiRwW072UqztVvwCXuMCLSwAPd6i90LRNlwMS2zPli7iG0WMI3Nzu2Zi35IX
	IUYwYEbWDCGyLeaqC8crCpdFBCZZVaLNRgbM9elN9s1pTHHt4QGNvebBGVqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262965; x=1704349365; bh=FqbAHKp6GZpMNU6U9RvoV84G+vN6
	lNcnKBEXD1pYKy4=; b=tJCOWOQ+m5mSc/riWQkkTJRkYamud4uTvW0flj3Bidj6
	+Lo6BXRWTsyyTLG1bSfWup/bKJomhMlsqrz9gi6c+b25zs3pR1c2/YIcc15qDkX6
	8Vqrteb/+/mkx+19QE5d6ij6Zl8UvvYPG1Y8O563d6Ji5kTRydbzcfBL7KHSxqgS
	VBCa47k97+C9DQMLSUCIjhO+lzf5QJt2upioR4mQMdi7Zmz67I0ZQsvih4Uo5MxI
	Fm4Spd5SLMdopVUQ2J4uZ7lBdQGV1PSZbV2xIZFZCWpqXvKv9FDBXlOrgt8beyw9
	vI7umEszWegJCHXQ095v4L2S5HzVIadz1FG38MCREg==
X-ME-Sender: <xms:Nf2UZfHJU-z30hsfKx7ucOtB41BMYYuxytiBztArkzBAiQueSA9zSw>
    <xme:Nf2UZcWdPVdg_gi13C5Y2kP_BY_lLoJWsE7-3m9-P9qoZE4CbxQsAlnhlAZf0DYw6
    zZ9DLQP9A-04mDcDg>
X-ME-Received: <xmr:Nf2UZRKD97_iqVHyC_n7chWnMQQTbWy9wB6O4hwpYx6tzM7zVt1eOuJb9NnYyGt2TeVoSLNywYP0wOfC1O51KPFaSuV1xeLxaUKrzYDkEBIYcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Nf2UZdFmoNF1ztsyzrUXnZDervwaaRcYTwLwsPUh1dUjLbD-Y6h6WQ>
    <xmx:Nf2UZVVRm6D3tU_YL7fDzob6gO_3qjjBbWcBS_TBsQcCzi7j-AUJPg>
    <xmx:Nf2UZYObdh7n799MdfGhMPcITA77oOaONEsLQha1VwhcJX29CTQf2w>
    <xmx:Nf2UZUcbFWyLw2E58WTtcUJKsdYThuNYxNJJhele64eW0omHE_kq3w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63004312 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:20:19 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/8] reftable/merged: transfer ownership of records when
 iterating
Message-ID: <eea0e161adca68e986cd7af0a195e60b8d4cbc9f.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IK3gTZSBVwkAcZ6/"
Content-Disposition: inline
In-Reply-To: <cover.1704262787.git.ps@pks.im>


--IK3gTZSBVwkAcZ6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating over records with the merged iterator we put the records
into a priority queue before yielding them to the caller. This means
that we need to allocate the contents of these records before we can
pass them over to the caller.

The handover to the caller is quite inefficient though because we first
deallocate the record passed in by the caller and then copy over the new
record, which requires us to reallocate memory.

Refactor the code to instead transfer ownership of the new record to the
caller. So instead of reallocating all contents, we now release the old
record and then copy contents of the new record into place.

The following benchmark of `git show-ref --quiet` in a repository with
around 350k refs shows a clear improvement. Before:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 708,058 allocs, 707,865 frees, 36,783,255 bytes all=
ocated

After:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 357,007 allocs, 356,814 frees, 24,193,602 bytes all=
ocated

This shows that we now have roundabout a single allocation per record
that we're yielding from the iterator. Ideally, we'd also get rid of
this allocation so that the number of allocations doesn't scale with the
number of refs anymore. This would require some larger surgery though
because the memory is owned by the priority queue before transferring it
over to the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index a28bb99aaf..a52914d667 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -124,10 +124,12 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 		reftable_record_release(&top.rec);
 	}
=20
-	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
+	reftable_record_release(rec);
+	*rec =3D entry.rec;
=20
 done:
-	reftable_record_release(&entry.rec);
+	if (err)
+		reftable_record_release(&entry.rec);
 	return err;
 }
=20
--=20
2.43.GIT


--IK3gTZSBVwkAcZ6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/TIACgkQVbJhu7ck
PpTuDg/+PpQ8esEJFnNShZrTmsSe2p1YU4aNcCa9Bpkya/UtbQi4FvsDRgtJCqOi
sJMUhbkRcIeQxK5np8G2jH+56Er032VA4GeOi9j/65BAT1oshN859C2ybboSWNLc
1Rt7q7tX7ww9MxjCOVjWC4RxKcq9zeyd9DtP8HrjFVYvH8RvG22dYRLm8Ejd5g9l
ufpvsaKbj+XgI1Xs5/bFngZi7k/LIPJDRykutcWbNSq590UW9mM4Yfj1nqoOsM4K
PUfldB4i37dpmmlIo9KEnAy+ztoVWkLuRS9sEgBh5QdF1PqpCnw4DyZhJ8AR1eFt
rseCIXS/p2AOJyfVgpPkwTxcXMLgl+V54NODmjpBsm3jOjyHWFWwUp+r2FMMJy3L
f/hl9LtoFEPUyTiQGOx63vIYlMgmQli/BbLVlmeRh7ohc5CgtR7OqleL9IQJfa9L
Uh7iBqBhZqR8jyo1OIJvI3U7Fl23ZYq/IiAxPmEydWDkXBM6EycvKMIhvqe49oA9
9+xr97wzX9L1qi87NkHh4aX3MSTFNGYXs88zlp3vJYrtEIDYKlzZaJCV+4VMESfr
K7eIfkVg4dOSiUzPStXGFj0PfPeWmzxJBeXh8nC+TN7Uw0DQg+we58C9jMbz3DDG
hDqs5EDzQxTBb+tyztRfgQvS8DQjn0pFfTzclMZ1BZQOIN5kiCU=
=v90e
-----END PGP SIGNATURE-----

--IK3gTZSBVwkAcZ6/--
