Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DA81749
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159525; cv=none; b=tbl7IvVjBRsXhttYMQbQeFMxvpcnewSJgwlQCRQwPo5sIe3JEsz3nuQZH9PbloqrwCQB1w/Yqr9++fgA6lDnjCq0UFmY4gvgDOzgSLZG4tqAzBCmd2w9uMcwbiH4TkN6vl2CPUdOS0n0FhRSWrZJeXwAn8G2JfsFbW2c4KG8J2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159525; c=relaxed/simple;
	bh=IjikH6vm5wc4fLWTdqe8ayEuldOnlg/oiDHd1BG+M2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvw1i66v/vCfvM2vpdvsPbFTC/yHmNaETPacK+JWlePXNLR71kxUX+GX3uQ/jBYPeCeZTNOtMTaZ/iRPuWjUkdw+nMmlThuTP6DA1+rqS6HrPFMxGe5zxps0Bdu+YDuHv8XUyCjYKnNySCjRw0pbtml7KWiVAxW0qMIKYzd/ZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aDg09We7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3whQLx3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aDg09We7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3whQLx3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 294471140302;
	Tue, 24 Sep 2024 02:32:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Sep 2024 02:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159522; x=1727245922; bh=PBf06YxzOs
	ueTYY4ppGTCh8x5orFv4h5rxmtgVf6LLM=; b=aDg09We7B5RRb/7I9Yzc230kt4
	98cW/LluZ5fJGpeKoI+OF4TEgooFSIaLIlT87PbROsPL95rKEL65jjKpIORvrJyY
	VNepekVF6Mf+PWk7t9DqJb2TcTmu124ioy8j4dwIYFCxkv9+JuG6BldccuqsZNcI
	WizRX7YfIZbcuOVOd+Jno3OqCSAd0mH1spW/UfVFJm5U6dH5zchSYioZC5yfJhv0
	9bGQugriOth0tTCQ5OZcDDqD61ZzA+FMRsyREIT146xPqDYxNGCwOQBui7fxIzYu
	7WavDYtAH+7uWDqGRCn+N7b88dmcmcrzvxxaX0MzHEBZ4EPnvwtOFxX8/j3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159522; x=1727245922; bh=PBf06YxzOsueTYY4ppGTCh8x5orF
	v4h5rxmtgVf6LLM=; b=l3whQLx3kXZ8SG8v8J6r/yb/guLtKT034zfGnMdSmu7M
	JzzePKJio4bWADh82cT4872xVVkGZBnlFONu7YwBrtpvuHNW1SCOt8Zfdr0QANCI
	M0AeM2IlB1w/Wy17mkx470FhVQ1uMPejntq1jHDcXqBNcku2t1dPRimov0SW89Pz
	U+q2tzpRuzQNZAVUcNbf9FXHgWxUwSysADWdy2SaN/SEe6OM7zP4MWqIVAjIpyim
	1GDIqyIv7v3oC7rlDWbqFwFHpO2UE72fedJ5rJZmqfTqk3eHer/EQ9hh2qRzUxqs
	c9OBKeC/fp+c+GNMdTqxBgY5A6+DsEwgaCsYZaU2Bg==
X-ME-Sender: <xms:4VzyZggEwcAumc43FAFklOj9gnOM8-_CFDeJf94_2eoQMt_BYeLPSQ>
    <xme:4VzyZpADJGtTWGgO6jGdMRsO-xR8lI0-4qgAjxJSmyJTCpKvBWmvXl-uatXVVdROc
    z8jsbYOckDqmEWUcw>
X-ME-Received: <xmr:4VzyZoE8qRl5P_Bsu4vTa9P3iZP_7FvuQzhRen7xn2D_c2X_Sfv3rxV0kUTn_rJ4xXilH7SSibJYWNi_hF1CQ-GS2AEEECaLDHaG4e9vLs80pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4VzyZhQVOuNMl0tY0VpJwgZOifYHS3i0Kf3PS6RgFQs0mk_JK4qXpA>
    <xmx:4lzyZty1XvET1Yk9y5Eo6BkLgeGqpNH3SLUHMXcQTc8McwZ2ACi4-A>
    <xmx:4lzyZv6ybcye1F2KhvYRI3O--KUoWcSC6QLwl7zCOY5PP-gzRhLSBQ>
    <xmx:4lzyZqz7SlKUKiQKa8U7x9-8gUmtDQn6Ob8VQlFs7Gr4C_CcQtx0Zw>
    <xmx:4lzyZl86rgLJe8dm4t7_bNBDNvUlp044xIr7MhRWtUuGgp4t3rY1zBGW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 281f4a3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:27 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:31:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/22] reftable: introduce `reftable_strdup()`
Message-ID: <21fa9b15d96809728455943877c1b32781364041.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

The reftable library provides the ability to swap out allocators. There
is a gap here though, because we continue to use `xstrdup()` even in the
case where all the other allocators have been swapped out.

Introduce `reftable_strdup()` that uses `reftable_malloc()` to do the
allocation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 10 ++++++++++
 reftable/basics.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index cf072935c88..4adc98cf5de 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -43,6 +43,16 @@ void *reftable_calloc(size_t nelem, size_t elsize)
 	return p;
 }
 
+char *reftable_strdup(const char *str)
+{
+	size_t len = strlen(str);
+	char *result = reftable_malloc(len + 1);
+	if (!result)
+		return NULL;
+	memcpy(result, str, len + 1);
+	return result;
+}
+
 void reftable_set_alloc(void *(*malloc)(size_t),
 			void *(*realloc)(void *, size_t), void (*free)(void *))
 {
diff --git a/reftable/basics.h b/reftable/basics.h
index 4e2e76014aa..f107e148605 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -54,6 +54,7 @@ void *reftable_malloc(size_t sz);
 void *reftable_realloc(void *p, size_t sz);
 void reftable_free(void *p);
 void *reftable_calloc(size_t nelem, size_t elsize);
+char *reftable_strdup(const char *str);
 
 #define REFTABLE_ALLOC_ARRAY(x, alloc) (x) = reftable_malloc(st_mult(sizeof(*(x)), (alloc)))
 #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
-- 
2.46.0.551.gc5ee8f2d1c.dirty

