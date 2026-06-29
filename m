Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87316348465
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718484; cv=none; b=UhiLtsU5WLXDtk6KMaUvahUmeG52N91aDciwyEqluAqS0SCrj5ffIAkz/auP+/jLkZG1DlfgI2OnOLZmqpPEb59xNKVDoLI+UE/linAx0KlkIXobhQg7k5iVG4mhKPaQHu3DfiCneTn0rmn9qQQu4A96iu7m626x9ncOIcgAwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718484; c=relaxed/simple;
	bh=BoCRny8B1HIA5phIt7u1Az47xZSKEcotksXkZcoge4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0Kcx2oyLHCcWdjmZ16gRlS5eIAxEr8jyG67BO+LK40svYAq4kNCsmcBxzhgbEVPXrp+xEMIZim+SLLVgqp2w3Xu+H1vcC6e1vfzBZNu6GM/z580XcPLcPaxKOuX4crpn5ypyc1aaXVOGpcajSCm8H9PKhYoDNGagOENV11SO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m690XLcQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WjFvpfjK; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m690XLcQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjFvpfjK"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6074F1D00025;
	Mon, 29 Jun 2026 03:34:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 29 Jun 2026 03:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718476;
	 x=1782804876; bh=nL+cOu++KTNKkl0hLcvF1ZuElDovMuxp2XFq9QUqArQ=; b=
	m690XLcQW31RS4WdAgLKKyQgesL0SgUYUbUqV3nWaD5+FgZ0QnTlx+swBsgJ5nOr
	Lj1k2OM7oxIbGGFCbhaGHS1f8dtzTzZ48fVtib2rpyT/fnMI9EUjM2rIUCn02L2O
	N4lpksm0RtWKzdXbmtuBjtgIQip07BMEFzjGD7yIQEhd5ZA1OmPE5HA1tUf+SQ6i
	8DL2POTEumXflZolun0Gar1dlRt7rV1b6IkEF2zCfnT6Qk+P6752mnL/ww1mUTSG
	yLeZzVJIwxuilUn+QOElieAhp0nLl1Rmo4zrAZXoGWEaE/t2rkKegAOT7ul/wMNQ
	ESpmE/HTv6D89QF1yfP1GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718476; x=
	1782804876; bh=nL+cOu++KTNKkl0hLcvF1ZuElDovMuxp2XFq9QUqArQ=; b=W
	jFvpfjKyT51mTVyHF1Xiy1oB1C9aZlDEo9m0SdOPSIJ9EiF2MW/m81z2TC0R60TF
	b810AWoXMAmjg82yROut/rMfl9egLiAFhPq/XleTK2knQFzDNqqMgBebcOicYpk/
	wV8k8oMnwTGX+HJko11YN1bQmVmg3mCEtquZjtLIGPgDfTxyd89gHcExvjoWuUjO
	n9PMcOp+9jM90p+WV0bRfOylU2Q7UTE+jvuSXrYaqsCszzbc9Hu0SIOKeyXcOs3N
	MkLuqJs3nMqfsn+13ZxJiBzCD3cu/1aXrKukcsjEKoJsHKd3etZ5H7yi32KjZTVg
	mMZQtE2p4yZsavnuy9yhw==
X-ME-Sender: <xms:DCBCalxbTwKihW5e3ABO8Ns7y3-sKqQZP91vqaYHLaOErav2XL2wiA>
    <xme:DCBCaun9myxVqLc9oTXJUZTAUiYMBy5948Rx51Siss6SnFgowP88EmaLI6BULAHUK
    PFszy3ytIIBZTyWFUxGvubahy0fggixFP4l1jrDKsSxdzkZCL4cCw>
X-ME-Received: <xmr:DCBCamlBzKvR01HTc9uNgu8jkeRXf6xwr7ZrQvHByssV_KdjHJPN0pP_j4QmCLUbJg7wR8_cJL032-3XBa1g-rna-oCFsQhOG1h03_DDIbDR>
X-ME-Proxy-Cause: dmFkZTFc4uQ6Qti1Zi9h94m4od3eMpCQCnDSYXEx7QOqzgywygLB3u2mJuU4WGTziEY0sP
    vssB/gclRg1ee6qJz/HkTNvVUAGJRzObGlYhlIWy2H0VizAeVI4Xeth5sjhla/To+149l/
    DnpD73+tyoScl3p4zN9NQkkGKn6ia0XiF6ce1fQg3g/N5exLIvyhMvPBClJO8fJfSQamiA
    fdVPH07ySGubvtRJl5FYb7NHirzBLueiOcGXimA9yqyRycKngriJVEG34RByO5A/F6lB6i
    kYa8uD5/S+7zMXFZ52b65RCnTypiqCWEjwut/seJuRz24f133R4jeJf+/yzbcKsEf0+eTO
    OYxfBjlbhrUi4A3LU7ztNbkG9Hhqp/2G5UdqYr65wpM6ABiuDg0g8PS+v2Qg8hmzqAAKZ0
    Qvi05lucJMp31AywzIAIBezsy1zzLX9tIfwTcFs4xyHSkyDTf9VQhSWd/rSMjBwCdoUoBN
    xhsUHPbBqeEPgG6yMmHAS8zjq8AfWhb+C7g5OsrhXihd3kg4QLJYqr2Yq5v2fPilamEaqu
    FV4qttk8zmpswmZXi9iB/JhuHc+xTudjQt9mqkbLP3rQs+1cG6Mg9lu8niKvMX3dYcu0UY
    cVv7PiaZfoeV0bpLP7lCC5PqX7lKmkm8oN7mv372FEWTYWIJ6ISeKmRFX9aA
X-ME-Proxy: <xmx:DCBCaoxOuJJ0l-nrNdC219Z20z_JZfNJQtvGrUgfJhwJlHgfcHZgqA>
    <xmx:DCBCajqwI-7EXYz3PTnHYrF3xaqGC0TEpseznc1TlJOjYVCII_Tc3Q>
    <xmx:DCBCav4ozDVAFsL6V9raSkDQHCb2Rm2B2ZMNfM1s0UFOJkc6lLqBww>
    <xmx:DCBCaieELU5pRz6j4mVFjiHPE4jWbWVAzuTnUBHgkgfxHBnzw0Pdjg>
    <xmx:DCBCasOfMlOHNpJku-jUgHuQgyuyJUN5Di9ohi7-0wXF9QFSmI-eF2s9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a08484b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:27 +0200
Subject: [PATCH v7 01/11] read-cache: split out function to drop unmerged
 entries to stage 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-1-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

In `repo_read_index_unmerged()` we read the index and then drop any
unmerged entries to stage 0. In a subsequent commit we'll want to
perform this operation on arbitrary indexes, not only the one of the
given repository.

Prepare for this by splitting out the functionality into a new function
that can act on an arbitrary index.

While at it, fix a signedness mismatch when iterating through the index
cache entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache-ll.h |  1 +
 read-cache.c    | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2c8b4b21b1..71b87615eb 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -309,6 +309,7 @@ int write_locked_index(struct index_state *, struct lock_file *lock, unsigned fl
 void discard_index(struct index_state *);
 void move_index_extensions(struct index_state *dst, struct index_state *src);
 int unmerged_index(const struct index_state *);
+int index_state_unmerged_to_stage0(struct index_state *istate);
 
 /**
  * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..799a5bc719 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3403,13 +3403,15 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
  */
 int repo_read_index_unmerged(struct repository *repo)
 {
-	struct index_state *istate;
-	int i;
+	repo_read_index(repo);
+	return index_state_unmerged_to_stage0(repo->index);
+}
+
+int index_state_unmerged_to_stage0(struct index_state *istate)
+{
 	int unmerged = 0;
 
-	repo_read_index(repo);
-	istate = repo->index;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
 		int len;

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

