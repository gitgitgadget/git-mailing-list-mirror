Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6AC2F5328
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810135; cv=none; b=jf1mM4Pti7EX/W5qSth4wkEb/lTNGN6oZZgEh5N/ZzYvONwmuJWVqgjM3sSBMenXZ1zrHl6rhCr4Y+1oRRxAnqRnEPz/ALAJBOeOmPki9DCIrovLpIs5zMPS/VTbGJyEQ0MERXH1PtFuekrTtgYDIj8zGdbLe1Zx6u4N+AGExOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810135; c=relaxed/simple;
	bh=FBXH88jGFkvV0aQtf4FQcq/u+b63WpHteoAeclgSjWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDprtUr7QdGGdygOZfmGhHw9F99Uh6SkDlcAYyMDWJ3WppRyFnAo5LCsJAYLlnGEqFyJ3WSm9CuGjXVk6brydzcpMLiOwWUvo9a7UIXF6xurLVOJqeoQj81cw25jt85lIyFLFak5Ib6UuFxQsUlYgvrmnlc+0b0DNkRqr8S0Z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F++YQAnl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDt6reBo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F++YQAnl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDt6reBo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13B76140024B;
	Tue,  2 Sep 2025 06:48:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 06:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810133;
	 x=1756896533; bh=h0a84fifTfI1lXG/th9gri8CqF8cDWssi02djJQb5I4=; b=
	F++YQAnlY3hEBX4mxVkvPg3Zwcqn6fDy+TJzfuuN/2oHguMJZGzVa9/M4Z552XHb
	VyA5DHuTTWs3X/3RuC6Gp0rEfIVctJZmekRSgAjfAFj0FlcQpYcHL+ioBbfV8w4Z
	n6Twbos+Y/5hyxfww+hVt28tnwTn+/YwetrwwIqkxA3ixL5DNLQ++49hm7pSHbiU
	bP0U2MKn7W7ktj4+4E06x3prpODEpn91V0LY3xNiuFenigaDOIlwbJmFmZqdpz3d
	g7j89EeOLE3ZS8rVDKqvFNMAbKBMmB8L5KlWG93WOwe8qkBQ4MadTqDS8ygxgOuf
	KVqjPsVNVpTA1GI9+NGmVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810133; x=
	1756896533; bh=h0a84fifTfI1lXG/th9gri8CqF8cDWssi02djJQb5I4=; b=T
	Dt6reBoMejctK5HMJWtthx8BNOaGMUKeG3QCs3PEX+yVrtrokWsA+w9NMjf3inMu
	7Nxi6p/K3lxnHkyywrYn/Cp5jFPF8LiOqvzgBkbvabxc/IL8STgNvw5fHLhwDXep
	ahrOomt6kFuDftU9UdeITdRLXb+Wr8hdgXSxLQhiaaZt9QeRZzPSfz3q04t+jYR3
	LpbFvVicLLTQzCBmdBbxee/+ulVOpz03ceuQ3bTuPw0v2IfJAG29BBooh6fD7t4/
	HGYTYQCLVAa1Sui2Td0bEi4VZf5LnaSyVPH2N6exNdTHAmtDGPSnABAo4Scon96N
	+v6ehpcOAJJWW4Hu1JpHg==
X-ME-Sender: <xms:lMu2aNya6C7GYYoag_lkLjkmMmPpjb5nbKc-RMzMpPo16-2dQ91vHQ>
    <xme:lMu2aIwqDiJ4WvUeuinqHxyDeGyH0G_U0kMRmLHgXyPFaEYMn9lDCbYJGjHdmy4bO
    0ui2K-IaXCw3b6xyA>
X-ME-Received: <xmr:lMu2aNwP82CF_CeoFYMZrMNJ1Pvl_q1DB8SXoweFYEeLE0v_QqzqTTgbiWnJV2uI5OCXhPyEzPw56c0LtQ44vpe0UkgZ9Vcdkqt6qJ1uImIB9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lMu2aKYlo0OLPSplxd71sYSo5jUSaulm-2SXzZXuEubZ7tIqSpCK2A>
    <xmx:lMu2aGWFTg1LxlPcOEr--7mEs1uWOQelLXCH2O0Lc9C2mG-yGBbozg>
    <xmx:lMu2aAjSnBv4DHUHBoX5tmTexs1zibcBdN2HPm-3esdqiuJTL77wyA>
    <xmx:lMu2aMveSS0jAtPulTR1XrqhZMcZnwDSi2CJhhmcdIyViQza2cM1Xw>
    <xmx:lcu2aIvoGKXcxaiagIz_nL6SX5ixmkCUJYiU8U3BF7OZuyAIgUUoVeIU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:48:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99dc6acd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:48:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:28 +0200
Subject: [PATCH v3 03/15] odb: move initialization bit into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-3-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The object database knows to skip re-initializing the list of packfiles
in case it's already been initialized. Whether or not that is the case
is tracked via a separate `initialized` bit that is stored in the object
database. With the introduction of the `struct packfile_store` we have a
better place to host this bit though.

Move it accordingly. While at it, convert the field into a boolean now
that we're allowed to use them in our code base.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 6 ------
 packfile.c | 6 +++---
 packfile.h | 6 ++++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/odb.h b/odb.h
index 22a170b434..bf1b4d4677 100644
--- a/odb.h
+++ b/odb.h
@@ -169,12 +169,6 @@ struct object_database {
 	unsigned long approximate_object_count;
 	unsigned approximate_object_count_valid : 1;
 
-	/*
-	 * Whether packed_git has already been populated with this repository's
-	 * packs.
-	 */
-	unsigned packed_git_initialized : 1;
-
 	/*
 	 * Submodule source paths that will be added as additional sources to
 	 * allow lookup of submodule objects via the main object database.
diff --git a/packfile.c b/packfile.c
index 43e9a7cb45..0cfeb68b6b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,7 +1027,7 @@ static void prepare_packed_git(struct repository *r)
 {
 	struct odb_source *source;
 
-	if (r->objects->packed_git_initialized)
+	if (r->objects->packfiles->initialized)
 		return;
 
 	odb_prepare_alternates(r->objects);
@@ -1038,7 +1038,7 @@ static void prepare_packed_git(struct repository *r)
 	rearrange_packed_git(r);
 
 	prepare_packed_git_mru(r);
-	r->objects->packed_git_initialized = 1;
+	r->objects->packfiles->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1060,7 +1060,7 @@ void reprepare_packed_git(struct repository *r)
 		odb_clear_loose_cache(source);
 
 	r->objects->approximate_object_count_valid = 0;
-	r->objects->packed_git_initialized = 0;
+	r->objects->packfiles->initialized = false;
 	prepare_packed_git(r);
 	obj_read_unlock();
 }
diff --git a/packfile.h b/packfile.h
index d7ac8d24b4..cf81091175 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,12 @@ struct packfile_store {
 	 * the store.
 	 */
 	struct packed_git *packs;
+
+	/*
+	 * Whether packfiles have already been populated with this store's
+	 * packs.
+	 */
+	bool initialized;
 };
 
 /*

-- 
2.51.0.384.g4c02a37b29.dirty

