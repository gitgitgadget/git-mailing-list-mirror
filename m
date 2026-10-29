Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277958;
	b=PjlI1uDNY0ZOnE1EOsK8a83SEX/rXFegI4tLQXIr1/vrIgfqTnn0FigkKvJiS/Fp4Q7+
	 gJbeKoYJkDP1qlTVlUn6o4PSCCf+R9ViHBKBnOvfGXItIupTGs81lTO/6ojpKGFnQgXzK
	 C+fPAO1KTkd19x/pDyRhKVyTd0FQ0+ZDwgnQrehetFdLLpxSmrdv6YbgclZyfF+HyuMac
	 l9wZgjR5OA8RrJeqP3SYpRz9QDpKKkiMgkoE+CKpNqHYDAP6T3Mri0tveRHlxPFiJGzSV
	 LYe/QmJyfpwP+hL4OjhpCDv7JE3ulmO5Owtmi7lJJurJaiy/3XEdBMsY/vYUWBTepPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=xBVcwLo9Kiea6Wzx1N+t48QCnHPSNAPw007VnlqmoAI=;
	b=YT18tfCycysmY2ayBu+BpzMaA03v7JvkNtPvGiH229B8jYh/7mng/X1K4mv379nLh3VL
	 CfJsyVgv2du4b2c9HrEUbcX0bV8JM3WbChoh4i5eBQnE/nNmLTHQjJKZhBdgvsYH+D5Ig
	 qtGG43rjwYR38f3CGH19YbCgW2yryPf4rxCi4FMJhSV+dDbN9rY9eHwcGBTbSCyNBweiR
	 iY6GyjHc7Fn4+NFNKLvb0w5dSWX7PpFYAcb7Mrkfrlt99PZL9nIHjm5g8g556OZbkmurv
	 Sv+fOdSQ5HyJLsT7HFe2C/FcojdHi8zru3YDvNvpRhhSDZepQfbAsu81L5MkPmxC2Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=StiWPz2d;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195F606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6195F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=StiWPz2d
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so22833635e9.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793277957; x=1793882757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xBVcwLo9Kiea6Wzx1N+t48QCnHPSNAPw007VnlqmoAI=;
        b=StiWPz2dO14TB4ENVfHYu/Tbbk2y8jDOv0detVFEXfIGsdvPWw+KtGlltCgHL2sZ+a
         6QNmoBG8qPd8IniR0XpPbDWMuqUSDny1Zg4Rfc9VN/wuJdh1c+i2bdVnJFS4z1X0uDsK
         1Ua5jiktjv6RJLAfjvSdwLAmPMwIqfPdGDlRS2T4jXv47Z/Aj7X86KaDhFk72C0FoXXQ
         3yEWjmkfunBs+gLRt8Sp5KFxdTr5GAZro6UyT5/4aDRY/uEmfXm1/x29k6ZFkutuTM8d
         RYfZou8ixfvzgJ9xTz7jvOdZX8h/uLUBKsjdED2uIIlghweNpyzCpFxhpm0ECNwTBzZI
         Bo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793277957; x=1793882757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBVcwLo9Kiea6Wzx1N+t48QCnHPSNAPw007VnlqmoAI=;
        b=fGZbiw9OiDOW4GEjNbqM2gBFd1AktYtdMoJ8+2yQG/rWq5nEP4NQ/bfdFh0+sgOQ/+
         8SHmxGYLJnHoAAK9qbZhEhMHj09PhPqOxaBJJ8Rz5A4cjKKWmwViK+w5Q082WOaS+euk
         4l0dlyxfhWwhLFx7CvsRkBi5UeyPAjBCAhRFGkSPpVexmCRTer8LlKlNoNjfVNsYGv1d
         YqATNxbzGYSK5K17S6vLyWbaeMSQSsviQuRJGaDBlpseVXhq+GbjMTlsm8sU649e/CRs
         4LK0ZuArNw/WeLMo+p4aDi9v5GvmXqBLRLpZVR6ZzETYPP2WdCO82Z6umhvDCtnPczTe
         DhUQ==
X-Gm-Message-State: AFq9FYKKr4YV6P/SjEb7+zCgbeknefPn/+QN5CqDxTBCJlvqafoKpSQS
	kYCtQCOVGKefizL7fzoZjq8aJ4gmKXm++VIK/5Wv6H2U1S1meHUajWwb
X-Gm-Gg: AYBFou2Ig3cQes35F1JDfqPvzI1GaD3swztapoAcntrODbvtfp4DtaOH1iaB5OjJhTV
	cu3f4hcwLkI2St7LvY61EqcdyCsnYZy+sBE9CdhRQLdhxcvJbugiU54xNTBiSfcuQa4rSrdyBrA
	TxMAiCAqnoJjzU7JohS98VPsF/sfsX2CfBpww+KYfRcsK/6WaWihRfSXIPy8zVdQqx1dcgl01Ly
	eMVpakQHxhiXefTy+Q95doDWItfegFhZeCVPQ2xejFiUdP3xmwlGqDHVn8squn2hcPwdRY6bmPY
	eKeLXvMDOv+tmv51GKMsv1Ag5k6ZkyYdPQJHSyf+tBb1hd8fOrr7W8MK9zLbUrUu2PQpX/FNe5t
	ekW/McEo/VqrCbjy2uTQm/FOXw9ysUd41feWvaRYlp5h3XuMy0ORKokk6uC0+FIk8bR7P+/Qukv
	U4sOB0qo/aQa4KiQOjB2K/vsqcwd4o+VssiidhE8MOzlQcRA20cyDm5Zna8AazmnK1F5m00smHc
	PPGZ5FwTPQKvKNIge/0IYpBUeOWx+D1elIGE6SQ0ITZrBOpVZX9eGgxbFRFjSfMMZMXM5Ukqx7C
	gO9Txdl8jaCd2eOL+rjIQHeVMvf+/aaV0qnIFHpl5Ih5GBfRsUx+aAIailcyBAxlEvQkaQ==
X-Received: by 2002:a05:600c:83ca:b0:4a2:150f:1610 with SMTP id 5b1f17b1804b1-4a9672030admr134761415e9.23.1793277956467;
        Thu, 29 Oct 2026 05:45:56 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:7938:fafa:2306:bf7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a930a63eb3sm106593635e9.1.2026.10.29.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:45:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 29 Oct 2026 13:45:39 +0100
Subject: [PATCH v6 3/3] fetch: advertise fetched refs when backfilling tags
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-799-shallow-fetch-with-tags-v6-3-e6ddd5201def@gmail.com>
References: <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>
In-Reply-To: <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>, gitster@pobox.com, 
 =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5916; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=HuSZuE0vHXl7kE1nwZzLQmaPkiO1TSlsNS9Dndq9TZg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrjP/dmvLtCv1R3yU/YQ+LVVayEavbXgJ9L6
 Nab5j5W2715+IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq4z/3AAoJED7VnySO
 Rox/Jx4L+wbAvjv1jktJc9xx5vSQ9zSiQNTsQoti+Hb8L3eyUm0wB3LjMSubt5wZHqNOsth0t/I
 QRCJcn/Io7UBVwNMaysPZo1q+DYDXLDx8m3vMv1ueNHqmJd7IoH34KMO8LBeak7zwShOBdjaHF4
 LNeqVufO3qZvbdWYRi0wmt4SZvwK2osvQLL/muzGTOxBFiZmqe27Z+pNjyHTOFuSB46IHbsSLfS
 MhWqXClUwl5Q/p7/RSumUkDwax7mcJ3NczglLyMZ7KV2Ogve+pGLdNeDUt2kwHA5+0FONGyxCyN
 1n74Bhc1nw1BqXg44tjD5j7qbK9I6OYpWBaGtWXfP+bgwcuvKkSf80ClWwsPgK9eWezS1YABMYu
 SnZk7SDM7kJCZIWHqGYCxyvV8QEqCc9Z1zu7Kqodj+T0eDZhUeYHIDisa8qAEVjh9beH7GhZMvN
 4RdpEeGZCtCQDVvyBQ+2ashHchDjntjfw8asialqSwH0//GcC0Qxi2Wpyg0Y1KHoi8ul8NGVBW8
 0I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
fetch code was modified to use batched updates to provide a good
performance improvement. Batched updates are used both for the fetched
references and to backfill tags.

When using batched updates, the references aren't yet committed to disk
when we start backfilling tags. For shallow fetches, the negotiation
phase while backfilling tags does not advertise the newly fetched refs.
This can cause the server to send objects the client already has.

The issue always existed when the '--atomic' flag was used, as both the
regular ref updates and the tags need to be part of the same
transaction.

Fix this by advertising the already fetched refs as 'haves' during the
negotiation. Do this by simply adding the tips to the transport's
`negotiation_include_tips` field. This also fixes the issue for
`--atomic` fetches since it follows the same route.

This does mean that all references fetched before the backfill will be
used for the negotiation. While duplicate OIDs are trimmed before
negotiation, we could still end up with a lot of distinct OIDs used in
the 'haves' section. However, this is still better than the server
transferring already existing objects to the client, which can take a
lot more time.

Add two tests, which validate that the 'haves' are filled when
backfilling tags for atomic and non-atomic flows.

Reported-by: Mitja Bezenšek <mitja.bezensek@login5.org>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  | 33 +++++++++++++++++++++++++++++++--
 t/t5510-fetch.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..d3974faf6b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1676,7 +1676,8 @@ static int backfill_tags(struct display_state *display_state,
 			 struct fetch_head *fetch_head,
 			 const struct fetch_config *config,
 			 struct ref_update_display_info_array *display_array,
-			 struct list_objects_filter_options *filter_options)
+			 struct list_objects_filter_options *filter_options,
+			 const struct oid_array *fetched_tips)
 {
 	int retcode, cannot_reuse;
 
@@ -1697,6 +1698,21 @@ static int backfill_tags(struct display_state *display_state,
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
+
+	/*
+	 * References fetched before the tag backfill aren't yet committed
+	 * to disk, so negotiation cannot discover them. Advertise them to
+	 * the server, so that it does not re-send objects we already have.
+	 */
+	if (fetched_tips && fetched_tips->nr && transport->smart_options) {
+		struct oid_array **include_tips =
+			&transport->smart_options->negotiation_include_tips;
+		if (!*include_tips)
+			*include_tips = xcalloc(1, sizeof(**include_tips));
+		for (size_t i = 0; i < fetched_tips->nr; i++)
+			oid_array_append(*include_tips, &fetched_tips->oid[i]);
+	}
+
 	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
 					 fetch_head, config, display_array);
 
@@ -2077,6 +2093,16 @@ static int do_fetch(struct transport *transport,
 
 		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
 		if (tags_ref_map) {
+			struct oid_array fetched_tips = OID_ARRAY_INIT;
+
+			/*
+			 * Collect the tips we just fetched so the tag backfill
+			 * can advertise them to the server as 'haves'.
+			 */
+			for (struct ref *rm = ref_map; rm; rm = rm->next)
+				if (!is_null_oid(&rm->old_oid))
+					oid_array_append(&fetched_tips, &rm->old_oid);
+
 			/*
 			 * If backfilling of tags fails then we want to tell
 			 * the user so, but we have to continue regardless to
@@ -2086,8 +2112,11 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config, &display_array, filter_options))
+					  &fetch_head, config, &display_array, filter_options,
+					  &fetched_tips))
 				retcode = 1;
+
+			oid_array_clear(&fetched_tips);
 		}
 
 		free_refs(tags_ref_map);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 30871617f9..ca5f9642fc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1942,6 +1942,40 @@ test_expect_success "backfill tags when providing a refspec" '
 	test_cmp expect actual
 '
 
+test_expect_success 'backfilling tags advertises fetched refs as haves' '
+	test_when_finished rm -rf source target trace &&
+
+	git init source &&
+	test_commit_bulk -C source 10 &&
+	git -C source tag -a tag -m tag HEAD~2 &&
+	HEAD_OID=$(git -C source rev-parse HEAD) &&
+
+	git init target &&
+	git -C target remote add origin ../source &&
+	GIT_TEST_PROTOCOL_VERSION=2 GIT_TRACE_PACKET=$(pwd)/trace \
+		git -C target fetch --depth 5 origin &&
+
+	test_grep "fetch> have $HEAD_OID" trace &&
+	git -C target rev-parse --verify refs/tags/tag
+'
+
+test_expect_success 'backfilling tags advertises fetched refs as haves even with atomic' '
+	test_when_finished rm -rf source target trace &&
+
+	git init source &&
+	test_commit_bulk -C source 10 &&
+	git -C source tag -a tag -m tag HEAD~2 &&
+	HEAD_OID=$(git -C source rev-parse HEAD) &&
+
+	git init target &&
+	git -C target remote add origin ../source &&
+	GIT_TEST_PROTOCOL_VERSION=2 GIT_TRACE_PACKET=$(pwd)/trace \
+		git -C target fetch --atomic --depth 5 origin &&
+
+	test_grep "fetch> have $HEAD_OID" trace &&
+	git -C target rev-parse --verify refs/tags/tag
+'
+
 test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 	test_when_finished rm -rf base repo &&
 

-- 
2.56.GIT

