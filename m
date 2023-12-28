Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785B5668
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D4XlzK0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvL2AChi"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E1A5B5C00F1;
	Thu, 28 Dec 2023 01:28:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 01:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744887; x=1703831287; bh=AaSujXthqc
	aQt1joya1InvSufKRHWDKM19exfXAiYtQ=; b=D4XlzK0XYYibUm60iOZ3WlZPaY
	KvO4HcXvj372dogspidIw04iJueWvkEp2mHqeENzN7ivkqbAwqSwSa5lwstD4WYT
	LzK+EaY4aPTUlAO4/KxKIffQkGrriBBnyEr9vh9iR9T7VZIUWrr4ejCBid0KLT+8
	Dp2ltHzA5OuXh06c5JJ8LUk1lTLE9UHsdi30uSGtTNG2V3ZTBlUozg+kOi5hJwEA
	SIInVTjuPH5VdWnBkc1jRK++a8VFlGZv4MicoaDrtUyxNbjJtsw7LfQ59rKGhasc
	nwuJTssF90RkvF49zqIhdeQYpgXUalyaAcT2oat8shildeSwbIdkTmUxUjZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744887; x=1703831287; bh=AaSujXthqcaQt1joya1InvSufKRH
	WDKM19exfXAiYtQ=; b=RvL2AChiWvsKJe8qtnk0g1lR+of9vPamD6l40hId7Ntm
	gcGoqAh7BPD5SucnSOzSqITive5RggWQSWLxNGnE5LXZinpoNG1/2f1OsqnVwD7a
	498yHZyTBUob8k5SBttFmSj73Ah1ADiAUwPLb9NlxQOJd7fRr+gb/+gHVKjh4QGM
	Y2w/gBjSVu0ANZYPeVqNK61x/kW1t4ZgyPE9N8ECrBv1oEtOHVimbX3jcsxmV2G/
	tN8rzodLf0NgsD12Cn7kUBsanf81wCidwkcB7P9Nlr93qitUAQXDl55VxOqfcxnQ
	cf277px0qlgO1/KNXAZXuNGSfo2BQHdMEtRaUmq2hA==
X-ME-Sender: <xms:dxWNZdtIwNSMx4PBbPjWvUsjB7KZiCRATQO__539_ByVQKFaMkbBXg>
    <xme:dxWNZWfjLbMMdiqFlfeafdnh0mkXuuyITuH31BQTcNy4MVzMgYrdLH0qUfKIeqLXv
    cWBD6HBfIQftu0vVw>
X-ME-Received: <xmr:dxWNZQy1LHGlymzHUCbmGBmczVzh1jrR0OXr9TW39y3bJigkRCtHHZ5_-4tFKpTBb4PRaUn-itZirCBpFClm6xFwhgbmQb4E_d9xQBD6f2Wstw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeegnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:dxWNZUNKpe68LKnp9TdeHWWeuoMtlerCyGMfAzUlsqykj286P0lPrw>
    <xmx:dxWNZd-UIOmRSXxw8tbdltKkNJxRBcbQgrrgTMZ5X7EkLgHXubdC0g>
    <xmx:dxWNZUVZGqnAyXkwkIe_d1JCeCh7oqrgRgW4Hj7_i2QDIIM4tfrOzA>
    <xmx:dxWNZfk6dOAN-DobBJJ-tiv8XviBO3T0Cv7vTg2K3qPuAxTQ4lBulQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:28:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93ce307d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:52 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:28:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/8] reftable/merged: really reuse buffers to compute
 record keys
Message-ID: <6313f8affdc136b183c1bd411d481efe5c676aee.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1703743174.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1j4kxMiXwdOxC4Rn"
Content-Disposition: inline
In-Reply-To: <cover.1703743174.git.ps@pks.im>


--1j4kxMiXwdOxC4Rn
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


--1j4kxMiXwdOxC4Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFXMACgkQVbJhu7ck
PpQV+A//QJRu/mCRNC9g0B5z0pufhIcNSZvqzl9UUfQZ/4bXTX+Y7vxeqUAjC2Va
gVt/RmzTeGBklQFqspZGej128Gse6pfunBjL5lSDnitkGRpoRsKTBZMpWQsiI/F0
SIMmEl+ZWCFfpkIP8zlUzRe6oecdBuUQyI2SLeDeEFskTZkN3XAVM7HBYBDHcVIC
RlwSYAkEFxnk2nEwrlBpTt8eLHxiH9iA1qvkIYJWArNh2zUcJ45E5C3AsT6x6hti
hMTPUxdTrHACGPcJBy9cDN41HefsUKV6fmhfd7oVdjn2F6Qwtwzw3ed79jas3xwp
HD3McHhZ+xiac3M6xbVIxrcCjhV9aNKRaBdi+7bN1sIVvGxAefs+Xb4/GyT1cfsW
nP0O0TvraNFYpwD1W4eztYlMwBw9bkrWUocLOTO8xXB2MiG6JdxFCqAA0fWtn4IO
s8cMawa7quvdgYpFPPiTmgb4Vn4deALRjRpVCJjw/7eOdIJTcOPWNF1Km2WFzZNe
T2bMPAdrFKMIyCnwYGZdA6IzsG76osf3EAhKTxc/wAxwLP1krXpecl+bXgiMdOyv
TWUiewJEAdxuTLK/L6+08UxvncGrIf49pH90jkDpHTnM7V9kRbdpCg32Chz4MGNV
biUIMXEoFvRGCsSiYyqNubA75HZfN//swlJi3JP0bvtiKRO7b7U=
=eiu8
-----END PGP SIGNATURE-----

--1j4kxMiXwdOxC4Rn--
