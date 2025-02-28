Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5F25D20C
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734816; cv=none; b=q/2GgKNx3F94WeGxPy8TwWmQwjLSvIyqCSnCAoS4cRlHHhUNIrHzI+I8azyBVf6xl7Kh9DEDOh5Co/0KZK6Yxz/STAfACHVl2Uh2mQASwNG1RCrK6+fATaKe8I3DAfu8JlJbHtn9r6IcyN7NuZUERh4pkU9CuH1CvtuV52QioOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734816; c=relaxed/simple;
	bh=2dhHnD2CiyuKtXbcYOhT7ZozF1KC/MTFTpd914fD68w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKildY9YTjJhcDlDKLTfNU1G0EhCkhRtLTINGoi1gf4wTTGzjOs4lsPylxBocK8i7olRl1IrWvj3c7u0SSaikE/QPkjO26sWPWqviZP4m3m6xO3i8QEVRd0AOtgMMz9mpv+ZwgzPzl0XX8s+gOVXZG1uzCFueMfjisnyWyqnR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mz1NvTEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vejo2W+U; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mz1NvTEP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vejo2W+U"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A16AB11403F3;
	Fri, 28 Feb 2025 04:26:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 28 Feb 2025 04:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734812;
	 x=1740821212; bh=o2H0612Qz7lMouMlqMsK6ZB1j9fiqQtA6I0sxXqw6lQ=; b=
	Mz1NvTEP8iY3pXoSit37am6/BdKfzEMjAdEpfiQrU/4Gix7h66GwbloM48blgbSs
	vJ2ccfKc2ug2Fhj2OHzsFS5j5iLW9urKbUfCTxfCmYekFiZBW6i8uR8gCgjspRtW
	CnexrcU9+/kZV5UO9ic08oa72+qj+2YIERxvObXTq7uJh2kw4/ZJBvaiM05rzuWz
	z8EH04Fcknk4DFdO7tFWtR3CpDn17fJr5mbbTgkHxrQ4A0eAI7eFPXqFt7cb1VuA
	p0kZuIug+aCFDAYQw9ND9Pql7RKZPekJWPtodcBYH2gGxjHpwGuFNKXIqFU3LXA4
	cI47yP0RnJSbf93iI7gULw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734812; x=
	1740821212; bh=o2H0612Qz7lMouMlqMsK6ZB1j9fiqQtA6I0sxXqw6lQ=; b=V
	ejo2W+U4m5n5rlC9YSJERCxVYNuNm0p78cBoZwanUz0Y6dDigNDA5TvHI2hyPdSU
	G/1n77c8pz2ZeZxh4hP7ysXawhiotAkSp22hlwraILtZFFgy4EkHmfZxhp0QaMuv
	qsV2xu2a4QrIbUEmXUuUIOQLx2ZQvsHK3LxD+Dsfo+VP85UV7nEwSHjXsHrKCE/p
	E/beoGLSttf34FAk6XXlvQMEHNhqSABPHbGtyPF1DypRQpmiZfrJopQmd9gPpidc
	VnqPEX7f7OXOYRGC9+q9W+DXYVv4KJe9mHLIelN88859TY8ulpWpoCq0TfvSjawM
	vPD18aT6BjQ9k5mqdopjQ==
X-ME-Sender: <xms:XIHBZ-GCPC8LlF0JcyK6G36oAugJJ2ZItyHhdh_X6v0XHJU2q2392Q>
    <xme:XIHBZ_X7u4cnfevGMOj4-zwkcdpnJ6fXOJk7wBvATMp1wBvQXvXeHZ2GtfgUGnjW1
    RqTqKgls2hCF-nxsA>
X-ME-Received: <xmr:XIHBZ4K9pGI8sPUJ7MWft45CpZDX1GOUQvAmOfkkux51epiNb_Rz3s2HSkFX6o1dCzbgD4PIoUYcR69FFPTPnR1e6_4QF56_9rnKkkaCuIGVPqKK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XIHBZ4HoIrejALoHh4oarPrxUVaY1kHmBc0L9zl--CcpVz2r-nLgDg>
    <xmx:XIHBZ0Wp8MeNxg3gXHeGGRJ_rYaWGyoTYg3_g4cXbfglV1Ba0b-teQ>
    <xmx:XIHBZ7OsDrwwnxHg7MMMYALMM6S5XSCUDY8Slgl0VpXejXJ9eNKdGw>
    <xmx:XIHBZ73rCSNA84B568w1hmQxZrheRtFWI2us2guPCanKDBRVkaHb9g>
    <xmx:XIHBZ3FtIOya57XTcNXcagSwt4IW4JTwHLxNpB__JjM7-UI3Y4cadsNc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0aa354bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:44 +0100
Subject: [PATCH v4 07/16] refs/files: batch refname availability checks for
 initial transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-7-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The "files" backend explicitly carves out special logic for its initial
transaction so that it can avoid writing out every single reference as
a loose reference. While the assumption is that there shouldn't be any
preexisting references, we still have to verify that none of the newly
written references will conflict with any other new reference in the
same transaction.

Refactor the initial transaction to use batched refname availability
checks. This does not yet have an effect on performance as we still call
`refs_verify_refname_available()` in a loop. But this will change in
subsequent commits and then impact performance when cloning a repository
with many references or when migrating references to the "files" format.

This doesn't yet have an effect on performance as the underlying
logic simply calls This will improve performance when cloning a repository with
many references or when migrating references from any format to the
"files" format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6ce79cf0791..11a620ea11a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3056,6 +3056,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	struct ref_transaction *packed_transaction = NULL;
 	struct ref_transaction *loose_transaction = NULL;
 
@@ -3105,11 +3106,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		    !is_null_oid(&update->old_oid))
 			BUG("initial ref transaction with old_sha1 set");
 
-		if (refs_verify_refname_available(&refs->base, update->refname,
-						  &affected_refnames, NULL, 1, err)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			goto cleanup;
-		}
+		string_list_append(&refnames_to_check, update->refname);
 
 		/*
 		 * packed-refs don't support symbolic refs, root refs and reflogs,
@@ -3145,8 +3142,19 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		}
 	}
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, err) ||
-	    ref_transaction_commit(packed_transaction, err)) {
+	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
+	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
+					   &affected_refnames, NULL, 1, err)) {
+		packed_refs_unlock(refs->packed_ref_store);
+		ret = TRANSACTION_NAME_CONFLICT;
+		goto cleanup;
+	}
+
+	if (ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
@@ -3167,6 +3175,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		ref_transaction_free(packed_transaction);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	string_list_clear(&affected_refnames, 0);
+	string_list_clear(&refnames_to_check, 0);
 	return ret;
 }
 

-- 
2.49.0.rc0.375.gae4b89d849.dirty

