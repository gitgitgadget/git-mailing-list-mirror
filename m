Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5D2E8E0A
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024788; cv=none; b=LtFJbgKOQ3IXmQZGTz4et2QsSwzmpEJO/HxZbm2yPcoB49B05Ygmjwj74HyT1t5kyHlF8JWXZBdp/+u6d79UI1xITy7dSmOAdO1OrcpRq0tXtmAEr65+NlrlJ3rXN6073Bu9ov4za80AFVjXS+dxaJ6W1PCpTCX/OURs/ipxWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024788; c=relaxed/simple;
	bh=ZvIere/czRFfGO3uFx2LTnKWTh1AwufeHtUCKMAN15M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fLbKrkp5x101YHq/ZX4GjNekXz3rhauFh9ts4GUFU7BWDdQSD3JtV3pgU4NgpViWMmtVVPvsWyMuu9/CiVgFu0eBYNw2aKISefgsLHkuX2yWTLnrZcbP+cOtz+lW3H4ErmJ3yo99gQwUmCcB8iXj1QQDURZwobTdbzrp6+PcTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ihxjrhCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bcS9B8xG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ihxjrhCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bcS9B8xG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CE657A013D;
	Thu,  4 Sep 2025 18:26:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 04 Sep 2025 18:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757024783;
	 x=1757111183; bh=k4ZuW2EugajKwdmZxXTXiW3xXK0pAzlaB1+mebFvNG4=; b=
	ihxjrhCSzL+AJJZvmXCb0UyYwRHWWqgvscnMDBci5RH3DVlpzAcTADhgWLde9C/9
	ifdhN7MC5KHTcX3jhg7mUfw/YFhjJ3/mZx79WQHLmXtMXHKq2Hu6xkbidApCxGCb
	1YkqVm2jtnNZtq8T+fT8gmaGZ98s5mm2ORwL/ZxPvpAgLa9Cvr/wZbY2xdz4NLj9
	PmrD7sluLRctwW+iwoEZHurVluQx92GhlCBrpX+Asl+KMdmbwqwHYAbnSBd87XKB
	ktWCKtisqfLoZ6W7sTnDUUQhPCQtS/g1KwpgrPh1NRTU6177VBLlKlE8UfEQRVPy
	Z9gPEXbB9gemkhC8CJFvSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757024783; x=
	1757111183; bh=k4ZuW2EugajKwdmZxXTXiW3xXK0pAzlaB1+mebFvNG4=; b=b
	cS9B8xGOhjlDDVzIehicLfHMCpA39UWmcvR18lwZlBSya27R+nmQ0w02lVbE54/9
	PZle45QY05KVtHC4ATdkY0cnngfKt2skeDGFirvbkalDTdLzJIljYX6YQL+Nkis6
	1GspQhOk7mdoQInjevKpdnRD1ZfFEHAwdJcie0pu+q4y0He/qFSvfI8vffS8R+mm
	8+pffxkisw06Tn/IZD7KgpcaGlE/LZuG3pNojP5VzJv7efSONEblImuophmS2F56
	37gY1IbX6RNXtQFesJkxtpCI6V1+tCkF2eWtUJG74BVaHp1+0SezmoYWdAck6jAL
	scAc9HWh0m0RgSbVO86Bw==
X-ME-Sender: <xms:DxK6aEGGquPsFmVocVk4mOjcOhZLcI_ZvqLzGnMkt0HrT6Hp8jsxIQ>
    <xme:DxK6aO25xsv71c7DR3Wi7Kp54c9Mn2_tkECvj1_exuFP_onYZz2oAC-hNrOsdr9cR
    GduOk1Hvce6BUqG_A>
X-ME-Received: <xmr:DxK6aOPUOXAIMoeiCrkTauXYsDW5NcEuFsMSyQot1T_r2OEXTIXg-mZwgulhGZF75NPstmstx8mHwz2EYK11-Ckf3nuxQIzz3HscWNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnohhurhgrvghllhhmsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DxK6aF7wI93CJjiGxm1_wfWWhMNUxSvPvUq_ya0R1jvQIz0J-Dzg5Q>
    <xmx:DxK6aA0UI-NL9OTu_6LH5QPY-ZwuNZN0Syykd6uNmNuYVBtK_ZhSkQ>
    <xmx:DxK6aOx4YPOVGGbSc0bLOcvEv0iSRumBO3YdVUpiiUgMLR5OUeXcbA>
    <xmx:DxK6aCvfCrezWOhZDNpC2gFRR18WB3zcncT2--BcFtw7l2jKUtyj8Q>
    <xmx:DxK6aEym_Y2yExcdK5eCX_FcaJlLcvE-GUe_MQFzGqWDpWPZOms1UV08>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 18:26:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?44OO44Km44Op?= | Flare via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?B?44OO44Km44Op?= | Flare
 <nouraellm@gmail.com>
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <20250904204932.GD30633@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 4 Sep 2025 16:49:32 -0400")
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
	<pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
	<20250904204932.GD30633@coredump.intra.peff.net>
Date: Thu, 04 Sep 2025 15:26:21 -0700
Message-ID: <xmqqjz2d7t2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> It's probably not worth going back and forth on this too much, but I
> thought the happy medium was:
>
>   if (!s)
> 	return;
>
> That is, it is perfectly reasonable and friendly for it to be a noop to
> free-and-null a NULL value (either never initialized, or already freed).
> The overkill was worrying about whether somebody passed in a NULL
> double-pointer. I.e., doing:
>
>   alloc_state_free_and_null(&foo);
>
> is reasonable and should be idempotent

... when foo == NULL, e.g., after alloc_state_free_and_null(&foo)
has just successfully returned?

I can by that argument with the reasoning in the updated log message
below.  Does it good to everybody?

Thanks.

--- >8 ---
From: ノウラ | Flare <nouraellm@gmail.com>
Subject: [PATCH] alloc: fix dangling pointer in alloc_state cleanup

All callers of clear_alloc_state() immediately free what they
cleared, so currently it does not hurt anybody that the
alloc_state is left in an unreusable state, but it is an
error-prone API. Replace it with a new function that clears but
in addition frees the structure, as well as NULLing the pointer
that points at it and adjust existing callers.

As it is a moral equivalent of FREE_AND_NULL(), except that what it
frees has internal structure that needs to be cleaned, allow the
helper to be called twice in a row, by making a call with a pointer
to a pointer variable that already is NULLed.

While at it, rename allocate_alloc_state() and name the new
function alloc_state_free_and_null(), to follow more closely the
function naming convention specified in the CodingGuidelines
(namely, functions about S are named with S_ prefix and then
verb).

Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 alloc.c  | 10 ++++++++--
 alloc.h  |  4 ++--
 object.c | 26 ++++++++++----------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 377e80f5dd..533a045c2a 100644
--- a/alloc.c
+++ b/alloc.c
@@ -36,19 +36,25 @@ struct alloc_state {
 	int slab_nr, slab_alloc;
 };
 
-struct alloc_state *allocate_alloc_state(void)
+struct alloc_state *alloc_state_alloc(void)
 {
 	return xcalloc(1, sizeof(struct alloc_state));
 }
 
-void clear_alloc_state(struct alloc_state *s)
+void alloc_state_free_and_null(struct alloc_state **s_)
 {
+	struct alloc_state *s = *s_;
+
+	if (!s)
+		return;
+
 	while (s->slab_nr > 0) {
 		s->slab_nr--;
 		free(s->slabs[s->slab_nr]);
 	}
 
 	FREE_AND_NULL(s->slabs);
+	FREE_AND_NULL(*s_);
 }
 
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
diff --git a/alloc.h b/alloc.h
index 3f4a0ad310..87a47a9709 100644
--- a/alloc.h
+++ b/alloc.h
@@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
 
-struct alloc_state *allocate_alloc_state(void);
-void clear_alloc_state(struct alloc_state *s);
+struct alloc_state *alloc_state_alloc(void);
+void alloc_state_free_and_null(struct alloc_state **s_);
 
 #endif
diff --git a/object.c b/object.c
index c1553ee433..986114a6db 100644
--- a/object.c
+++ b/object.c
@@ -517,12 +517,11 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 	memset(o, 0, sizeof(*o));
 
 	o->repo = repo;
-	o->blob_state = allocate_alloc_state();
-	o->tree_state = allocate_alloc_state();
-	o->commit_state = allocate_alloc_state();
-	o->tag_state = allocate_alloc_state();
-	o->object_state = allocate_alloc_state();
-
+	o->blob_state = alloc_state_alloc();
+	o->tree_state = alloc_state_alloc();
+	o->commit_state = alloc_state_alloc();
+	o->tag_state = alloc_state_alloc();
+	o->object_state = alloc_state_alloc();
 	o->is_shallow = -1;
 	CALLOC_ARRAY(o->shallow_stat, 1);
 
@@ -573,16 +572,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	o->buffer_slab = NULL;
 
 	parsed_object_pool_reset_commit_grafts(o);
-	clear_alloc_state(o->blob_state);
-	clear_alloc_state(o->tree_state);
-	clear_alloc_state(o->commit_state);
-	clear_alloc_state(o->tag_state);
-	clear_alloc_state(o->object_state);
+	alloc_state_free_and_null(&o->blob_state);
+	alloc_state_free_and_null(&o->tree_state);
+	alloc_state_free_and_null(&o->commit_state);
+	alloc_state_free_and_null(&o->tag_state);
+	alloc_state_free_and_null(&o->object_state);
 	stat_validity_clear(o->shallow_stat);
-	FREE_AND_NULL(o->blob_state);
-	FREE_AND_NULL(o->tree_state);
-	FREE_AND_NULL(o->commit_state);
-	FREE_AND_NULL(o->tag_state);
-	FREE_AND_NULL(o->object_state);
 	FREE_AND_NULL(o->shallow_stat);
 }
-- 
2.51.0-314-g9a15cfd6dc


