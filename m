Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524BC19F102
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775717; cv=none; b=LF5XtL7hmk4fsHcozx8qHhmSQQgt+NmGXdtnYB06gqfZND9ZaYGzXDeP7dENNvvM1yFehpISGrLA53yaPe6qLpPbDdMRFeyHpDLPOY/NLBQx8LM80yINlczll5NTvtHCvy/B0tRU/tg5h6mNJ7TzD2Og2XTcBFyt9lNN0b0xOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775717; c=relaxed/simple;
	bh=b2gm5e6VuNcFw4M9Tw2VQu8j+T/hUd4g9wcPToddLhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKcP6DlODo/JFpBsWhZN7rueYzTXIBlIwEjdm1RjaDljcXk/hmT8Ybok1xC5TUAV+7hFRtAPCVror2LMTfs7Wx9oCk7TvrVlLW+IYfVoYTuX6dAxtlKb7RWKnKGhEjS/F6XBrGv9R7EPT87H6w3QjSvHZLaSsVFFRMLvUJQsUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CAa5Lqex; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNVDtnKA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CAa5Lqex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNVDtnKA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9BF1D1140A72;
	Tue,  1 Oct 2024 05:41:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 05:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775714; x=1727862114; bh=kaL379fZ/R
	biuQABPX9C936DoOsFwVDWSc6IHeiN1qE=; b=CAa5LqexahXl8hrd/nSTRzNo+M
	hkBdH51gbqCpePAJEQx6qpWtNtfGJJ6o0Z2Sia986x8hKeRHLnGluMB0S+JhgplK
	XUCc4NExxo0qAde71Xb+nCWgeAbeWCg4+RXmfhohmgIUaUeBPHPYC6gZXlt4NRIa
	33a9CuGmhBAa5M5yV+9U2QRHkmgSIw076ybpbFbVdh55uaawpE1VtLl1URYY7qie
	4Tf6Xoh3EXGqfi7USfssLN+xuSgKf//Hu5lewl1zO5WDX0OtpRSvwhDXv6EUoiC7
	PYiHHb3Ggld3G96hAplZJDabkVTk2GdXKUzXKo6uDAA1kOGvuTCJvQJZQuPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775714; x=1727862114; bh=kaL379fZ/RbiuQABPX9C936DoOsF
	wVDWSc6IHeiN1qE=; b=eNVDtnKAN+nyakE//MC78+n794+zzkP+JtrUT1NC4EPl
	CJeSFlOVcgi26EBgzHLBQDwtm915NNiOtNFmcSl54AZaRFslsEEAE5Rx86R8tXSw
	eSl3AeVj4H1Z6kgts7P28PJ5BSsRbS8+snOnAEh+nhOwq47QCmf74Jn2FHR0TWfa
	30r/9B8miWh9/K1LvYTSCh9orR2EHXZClyjBtr92vsnQT9MDYktTMYtUxuJqetjt
	yoXbFKBPNuREuq/C8kP4iWatzSGT6IKshZHQj9JrQUwTMdAQkiFXlcWXqdMan8wC
	/DtLju+AoA0NLpv8jdpEhq2E/3i9UJPGhaabFXWF6A==
X-ME-Sender: <xms:4sP7ZnnvnOwqraWL5rAfzWTH4Qerv7cfF-MynSYkkvBosiMpxLmnPw>
    <xme:4sP7Zq3IerexSeNkyMYHxvEfFI_VJJK7MfIUcys3FvG3yb4nbUGn9qBjK8mmSIbv6
    QkuZeKMvjmtLEHbpw>
X-ME-Received: <xmr:4sP7Zto3b2z9MCorBZ4u4J6dWSURT-AVeLuJc4Qs5u0NIzxZohQdYbISvMUoXZ4mFcAw1Bm-ZNuTR_TPO8Ebr4tknqhLnvZ2ptbkoDlTKhZQvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:4sP7ZvkPZOVb8LcyanlVorttFrV4bqHI0SAQiFCC8COuUsZfAi671g>
    <xmx:4sP7Zl1HxHWAGaPJeVYeaoq6i19DHLF35yiWih_v5_m86ibeiCDYgQ>
    <xmx:4sP7ZuuMUm07ygOPB2Y4dku3PiQVGslSXiBzPmd4iF5CS3P5a00Ajw>
    <xmx:4sP7ZpWzAtwBiU02gPOTZQ2hQzrKK593ghTBeyhDvvMWpjWDgnPX-A>
    <xmx:4sP7ZgRAXd4-8ud0sGPqdv5kM7KZzL7VyMs8nbnvazWvMxBiNi3MmPHr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:41:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 535c4f54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:05 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:41:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 03/25] reftable: introduce `reftable_strdup()`
Message-ID: <b1a10d41d3798c98c53b251df9077fcc5eaef560.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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
index cf072935c8..4adc98cf5d 100644
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
index 4e2e76014a..f107e14860 100644
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
2.47.0.rc0.dirty

