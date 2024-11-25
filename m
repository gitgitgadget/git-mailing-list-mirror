Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895B18A92C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520333; cv=none; b=IUSFyOPg28m2xUfab8jqHvUAsMUauE7cAKmL6ad0j/cCmLCcNBF+KiMgv2JgrsIqsca/Wr7ncHof4Kfa6JPPSbAEl7/n5Eponxh1gXvKCT1HOkaPl8DO+7noREk57tgNeZDhjtJKr5DopGP+3h9cYKzUpkBPFOZ9aHfE8BDPP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520333; c=relaxed/simple;
	bh=lIpTbedklKiZsItMocsK2jBEmsjBnr3cGbGor9gaw7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REpU2LjenocJLxDgO0+90IqIvnsve0cVQoe/vzOU8f3UCAtWfoS9MBoqzoQO+EYzdEMRo3/K3xCcS8cJ708cgTLJnkZNzr2Vwo5HIUkLGgcs9SJVhgh2fDpthTtDRGHzKGz38KF9dSOycBRjTbyCl3TGxrkq1Gaa+Chnr0JQ/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O6WraDgS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHHK+w3Z; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O6WraDgS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHHK+w3Z"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D78291140155;
	Mon, 25 Nov 2024 02:38:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 02:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520330;
	 x=1732606730; bh=AgrFld2v28c0QUbERNG4s1aCFV6WCm1uEcrRufjPsUM=; b=
	O6WraDgSRWoTguY8obdLE/s4HgeafDhGoYnbzfvsifJAhr9O0gK6gN8DNp+7GBj9
	2U7mBGgw9uV99tlu0Yts5I91+sh6OrwaRvsefSkry7NoszdsjRoFSksMdlE9HYYb
	ax8/I/vtvEYhRbJA2lqqEuqnxXJAYm0FLBh+p2Q9sy5jfa/I/QJ0hF/wueMNECxP
	jOte2+m3m8/b7/0sstQzVwWF0cbuPdEolEFE0yY9QSScKBEKm3OMxoXMBX4IOQBL
	3zSScMbb9h0ZC4Iul6TjRMnNVjd+x/x9JLmbvQGOAJb7CoMoRoV0/4/xFVQSos9b
	1zNsc2kxC9zjYTnD4/SMGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520330; x=
	1732606730; bh=AgrFld2v28c0QUbERNG4s1aCFV6WCm1uEcrRufjPsUM=; b=A
	HHK+w3ZvLUan232IQJEKi5c9ELBB6veSgOh8fTccLG+rXccPFzVsu51RHWI5SoOt
	T3d2eNp/o5OTvV2zayoMeeICigHX8sxGXIVciu7tjQasgz+0Sl6/r3dAMAeFj890
	fI2JbPR93BQUCUi/7RCwpb1pwP7U5gzykK2+5Ullfer5ENjBOvVYd1ujOicj8QAn
	aBb7+0rRG2pesEOGXSsnGeSfxY32dUfdeTiNdX+VTjIZopkR/BDBzgrOl/VlKr3H
	Ox3dE1buVOAZEJ/FB7JDYxBb2JqUc1l8LcX0nrRCuxTj9iGvG2UbfRId5Dqa+3ln
	NdF7PHV8WkpKXENdjiAxg==
X-ME-Sender: <xms:iilEZ4Sbi0EPKrc6QPhfSQGoF6rWsapiqSDFynNCxn0hY0kYVeNujw>
    <xme:iilEZ1zrz3Mt-4-6dnZrKZgrdnrxCn4u93NOkiugbuZ6fEBxPcLN1SQd8q7z1FbZs
    7uOq6Ehiih4sdhWVQ>
X-ME-Received: <xmr:iilEZ102LNXmKraIOqqFb4Yl_k4vvySViGFrCZ_odL7JadAxEeqkqnfF4umQuMUPmjNiJPXVupKZkv5nt7-jsuCaWhKeobAe5oDUR4KCAArchA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudff
    udevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:iilEZ8AfSoX4lXWmksB6zBciP_O16aL2lbk7roN85BzpXs05p9lI8A>
    <xmx:iilEZxjJWVruVvmUHWoI_COgKELC099oHqW0l5GpbEqw0V41nWbi5g>
    <xmx:iilEZ4rL7NXwrRF8RNIuMVV5xWqXv5v7KHNJT9uwMxjh64wN2xaozQ>
    <xmx:iilEZ0g3hpbf2xmCSz2oXRioWo7zCERJMoOO9AWU56qdbO1srrxq2w>
    <xmx:iilEZ2tYi6xrmLOoyQrC5IkG8yOd0M4H0GJVzT4Q9YcV36AJiV8LTvjw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af82c93e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:38:31 +0100
Subject: [PATCH v3 9/9] refs/reftable: reuse iterators when reading refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-9-1d7b658e3e9e@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When reading references the reftable backend has to:

  1. Create a new ref iterator.

  2. Seek the iterator to the record we're searching for.

  3. Read the record.

We cannot really avoid the last two steps, but re-creating the iterator
every single time we want to read a reference is kind of expensive and a
waste of resources. We couldn't help it in the past though because it
was not possible to reuse iterators. But starting with 5bf96e0c39
(reftable/generic: move seeking of records into the iterator,
2024-05-13) we have split up the iterator lifecycle such that creating
the iterator and seeking are two different concerns.

Refactor the code such that we cache iterators in the reftable backend.
This cache is invalidated whenever the respective stack is reloaded such
that we know to recreate the iterator in that case. This leads to a
sizeable speedup when creating many refs, which requires a lot of random
reference reads:

    Benchmark 1: update-ref: create many refs (refcount = 100000, revision = master)
      Time (mean ± σ):      1.793 s ±  0.010 s    [User: 0.954 s, System: 0.835 s]
      Range (min … max):    1.781 s …  1.811 s    10 runs

    Benchmark 2: update-ref: create many refs (refcount = 100000, revision = HEAD)
      Time (mean ± σ):      1.680 s ±  0.013 s    [User: 0.846 s, System: 0.831 s]
      Range (min … max):    1.664 s …  1.702 s    10 runs

    Summary
      update-ref: create many refs (refcount = 100000, revision = HEAD) ran
        1.07 ± 0.01 times faster than update-ref: create many refs (refcount = 100000, revision = master)

While 7% is not a huge win, you have to consider that the benchmark is
_writing_ data, so _reading_ references is only one part of what we do.
Flame graphs show that we spend around 40% of our time reading refs, so
the speedup when reading refs is approximately ~2.5x that. I could not
find better benchmarks where we perform a lot of random ref reads.

You can also see a sizeable impact on memory usage when creating 100k
references. Before this change:

    HEAP SUMMARY:
        in use at exit: 19,112,538 bytes in 200,170 blocks
      total heap usage: 8,400,426 allocs, 8,200,256 frees, 454,367,048 bytes allocated

After this change:

    HEAP SUMMARY:
        in use at exit: 674,416 bytes in 169 blocks
      total heap usage: 7,929,872 allocs, 7,929,703 frees, 281,509,985 bytes allocated

As an additional factor, this refactoring opens up the possibility for
more performance optimizations in how we re-seek iterators. Any change
that allows us to optimize re-seeking by e.g. reusing data structures
would thus also directly speed up random reads.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index ff49c27a6a0f4cb1e5b3bfaa3d34d3302c1bdb2e..417c6c4955672ef69fe956e2e6dd8dbd1dd15a3c 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -36,19 +36,30 @@
 
 struct reftable_backend {
 	struct reftable_stack *stack;
+	struct reftable_iterator it;
 };
 
+static void reftable_backend_on_reload(void *payload)
+{
+	struct reftable_backend *be = payload;
+	reftable_iterator_destroy(&be->it);
+}
+
 static int reftable_backend_init(struct reftable_backend *be,
 				 const char *path,
-				 const struct reftable_write_options *opts)
+				 const struct reftable_write_options *_opts)
 {
-	return reftable_new_stack(&be->stack, path, opts);
+	struct reftable_write_options opts = *_opts;
+	opts.on_reload = reftable_backend_on_reload;
+	opts.on_reload_payload = be;
+	return reftable_new_stack(&be->stack, path, &opts);
 }
 
 static void reftable_backend_release(struct reftable_backend *be)
 {
 	reftable_stack_destroy(be->stack);
 	be->stack = NULL;
+	reftable_iterator_destroy(&be->it);
 }
 
 static int reftable_backend_read_ref(struct reftable_backend *be,
@@ -60,10 +71,25 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 	struct reftable_ref_record ref = {0};
 	int ret;
 
-	ret = reftable_stack_read_ref(be->stack, refname, &ref);
+	if (!be->it.ops) {
+		ret = reftable_stack_init_ref_iterator(be->stack, &be->it);
+		if (ret)
+			goto done;
+	}
+
+	ret = reftable_iterator_seek_ref(&be->it, refname);
 	if (ret)
 		goto done;
 
+	ret = reftable_iterator_next_ref(&be->it, &ref);
+	if (ret)
+		goto done;
+
+	if (strcmp(ref.refname, refname)) {
+		ret = 1;
+		goto done;
+	}
+
 	if (ref.value_type == REFTABLE_REF_SYMREF) {
 		strbuf_reset(referent);
 		strbuf_addstr(referent, ref.value.symref);

-- 
2.47.0.274.g962d0b743d.dirty

