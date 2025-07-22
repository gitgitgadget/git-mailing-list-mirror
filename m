Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A32E3AF4
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183275; cv=none; b=ZNNKWqFs1mB0LWvqRwYDqnpdA4Hi4LrCUxvbnPFMKrtBZimLq1yG6vilhGX4ZTW67xsRwO7xhF8OGTpKKqscvhov4H60kd+7pkFUjV+n0EaNbAuV6OpLfVJO1tj63UpqLq/TydOXhp0ud1kyAsl7As0WbiD+NeDcQHBbOAIbgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183275; c=relaxed/simple;
	bh=ep2l216m0PRP28ArIN556oxD+Dn+LQf2r+rbSiswieE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lxa914w/kaSyHI/4FD7Qi3WcPSSZc/rh0Vn8PP0oWHJO5MiIKDiirMRf6CSk8pxVU8in1AHrZxrrxYcp4u9pGn9WDexO3Cw5rLwtge/6gr/urHLNrXaxoNhMlmee0jwQc7OjiuJwFfRRhAoiRBJyXGpdV7NzB2/EPBthrygEqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hKVjLaev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYBDQPAi; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hKVjLaev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYBDQPAi"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 376D61D0025A;
	Tue, 22 Jul 2025 07:21:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 07:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753183273;
	 x=1753269673; bh=MUtpdsp/B4bjLp2ozPh9xVSC9gE1Yf24J73SyBQckY0=; b=
	hKVjLaev8hVSPWkcca5WoXvi4rGwzsukjz7DitkcC4twUnOut76XYkfx94dvoSWs
	cLLpNZB3jpPOWbMYEkaNfp6zPYOHodMDwHg5/11byWMONbRFPjHlLnH1Ay1fXEpw
	SODEFeGnskSbCXRTokrYa4obffW2SGANwTwS+MgPPgjp/lMLRCQrXCEZCxpYXcu2
	FIHeJwEjZzG/OFpD/a/KrgxiXaa01Z2DmVkI/7rS1t4saZt9E01ta0dqaT18kXnr
	oEGEvTICfOq31Y8XB85NNM6cQp4w//oLRYD5Bx5ollcJW4ls6Koo0yfJgQzddhoD
	+YX20jQChoO3kPmWzwsGSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753183273; x=
	1753269673; bh=MUtpdsp/B4bjLp2ozPh9xVSC9gE1Yf24J73SyBQckY0=; b=V
	YBDQPAivwTkG/FOOjM1c4bJ0yGLlTwUa+ryvQu51ulzSMN4qA2YxNa2U+6og+G55
	T7y45jrX124YKSf6tI8yPirxK1J968SumxSP+MXP2onIGjbrLDkGcTRB52Zo7Rcb
	MthqzlBNE9dCTJI/6vrepwub5IDL1PB8g6xDJzrLvl3qUBTH+G42L3H78po1puYl
	InpDskKok9pVaDf36TkiyaflkkQGeGqySdwLrastjJbApMcr9iTXYayUnkk4hRKz
	8SaQcCS64DGKXzdcpC16L4pNd5cOTL1mHvngYeuIibUh/DEWp+Qzi63RkvG3STXF
	yWP3KBG6nlmXVpqS5QeHA==
X-ME-Sender: <xms:KHR_aHaUzK7XJIPOr3ur0_uUIA5k2Lwjro0tWAmzZy3OJ6laZuCe9Q>
    <xme:KHR_aGkwjp8yf_TuUrQtfVO9yIDbx7ZAVh9TCeed0kekZpNxlUJb41YZeLWwbQUlu
    hRDJAmPsy59bcWPPQ>
X-ME-Received: <xmr:KHR_aLw7r4U7Jb5GZGGClYIwbqa_Fm3uiiZQsgbWPJlWQXnf4f7yO3IO3HM_IboYQGLsyJiynQ6aeQKUMvuyqvx2q76gs2a6FmmRgHQFgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KHR_aMPUXV44yuMyId01t9GCm0TVtfWohieXGuac_7xbMs8e-pQuKw>
    <xmx:KHR_aHS0dlYWD2b_oGiVpROYTi3X5JKLozeBei_9HeRRWFz0BMQBQQ>
    <xmx:KHR_aCbAL0UdNttpPkE_xHEaZf_ChMrKLHccRe1q3sc1zGdQbcbWQA>
    <xmx:KHR_aM3r0CTJ7eqqumgy0Ul88IQb_JXdvRH7C95SzKBa9xtHPpjxzg>
    <xmx:KXR_aKr4bhjVzTjTMaABo6l2XZpcLt2iUTRktggYTLspmfiquEWPFLQH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b7e2edc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Jul 2025 13:20:52 +0200
Subject: [PATCH 3/8] refs: export `ref_transaction_update_reflog()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-pks-reflog-append-v1-3-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

In a subsequent commit we'll add another user that wants to write reflog
entries. This requires them to call `ref_transaction_update_reflog()`,
but that functino is local to "refs.c".

Export the function to prepare for the change. While at it, drop the
`flags` field, as all callers are for now expected to use the same flags
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 29 +++++++++++------------------
 refs.h | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 73913b6627b..188989e4113 100644
--- a/refs.c
+++ b/refs.c
@@ -1362,27 +1362,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-/*
- * Similar to`ref_transaction_update`, but this function is only for adding
- * a reflog update. Supports providing custom committer information. The index
- * field can be utiltized to order updates as desired. When not used, the
- * updates default to being ordered by refname.
- */
-static int ref_transaction_update_reflog(struct ref_transaction *transaction,
-					 const char *refname,
-					 const struct object_id *new_oid,
-					 const struct object_id *old_oid,
-					 const char *committer_info,
-					 unsigned int flags,
-					 const char *msg,
-					 uint64_t index,
-					 struct strbuf *err)
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info,
+				  const char *msg,
+				  uint64_t index,
+				  struct strbuf *err)
 {
 	struct ref_update *update;
+	unsigned int flags;
 
 	assert(err);
 
-	flags |= REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
+	flags = REF_HAVE_OLD | REF_HAVE_NEW | REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return -1;
@@ -3010,8 +3004,7 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
 
 	ret = ref_transaction_update_reflog(data->transaction, data->refname,
 					    new_oid, old_oid, data->sb->buf,
-					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
-					    data->index++, data->errbuf);
+					    msg, data->index++, data->errbuf);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index efa182c6a14..0faf3bc0422 100644
--- a/refs.h
+++ b/refs.h
@@ -794,6 +794,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
+/*
+ * Similar to`ref_transaction_update`, but this function is only for adding
+ * a reflog update. Supports providing custom committer information. The index
+ * field can be utiltized to order updates as desired. When not used, the
+ * updates default to being ordered by refname.
+ */
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info,
+				  const char *msg,
+				  uint64_t index,
+				  struct strbuf *err);
+
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be

-- 
2.50.1.465.gcb3da1c9e6.dirty

