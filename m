Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F103D410E
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083546; cv=none; b=sfWzblqfHWrTtLactjp4zLkXg4UWUmF1cDZQNuOsrnyzl6D5XXxQHKmSAyNCO7bes3MhpBtefYTE8CAcnA8n7C4kOm2RxJ7KqRY9t+YBtiM3uujP1e3tQ1wbAsUXDcA1/2Rc3U91jPTBeQuz4HdstvNVX42dw3BeSDGVY4oNKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083546; c=relaxed/simple;
	bh=xXu+k714TBkfPzx8q3DLf0YIoYoWeO8kHq8E3Bx2LLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELfX3W3S6w6Vs3ebBC9t4HIXzHI6AtyjaD94bdz2/TnmRCd2+e5NbUleiK7+R0wMmbXKgx2JXFwLxSSWvUuL4Zm/q8vELQOG30MYLm5zMBC85897LoBqvSxT4M5klvop8aA4JG01Wkv+n8eNEtC7XnQk+0GJbpgR47bcxUIHkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jPMNbdcZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1SPCCko; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jPMNbdcZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1SPCCko"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C5B37A0116;
	Fri,  3 Jul 2026 08:59:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 03 Jul 2026 08:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083544;
	 x=1783169944; bh=4O4ZNAzBd/17sQc9weKt5yD9x+QaYdP0jOJZDNhmwq8=; b=
	jPMNbdcZD2s67g4xQ8p+Sf95Uq19MrEPOhyjht0tmAoLPaJCrlWlgsfS/Splykvk
	K4vx8+260kECK3DYXa0SSfp4zC8v539bGIkM5XAjEO1AiRHf1sUUmpQMoUaLFQ+U
	ycMr5MF4OHt0nq/NVSiQ8OBWf2nY+7NPCtmb/B1OYmmNH4OqBknwSNgpMgQq1MO1
	R8v1qwV7RD7uRDWqKbos97Zc05mcxb1erLTuWp5m4y51qvATQz1WSBxAtZF4nAwJ
	4J1CEBq47vBGZi63B+H7tA1IbdYfmrOIypaRRh50S4dmSrCxlaLIPTH9nAzk7mzZ
	ZCqXmvN3obiqTZJcf7FHyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083544; x=
	1783169944; bh=4O4ZNAzBd/17sQc9weKt5yD9x+QaYdP0jOJZDNhmwq8=; b=C
	1SPCCkoCRy3y3XI5lM24HeqRW8pdrIXMtwvRZKImzEVUcBmi5U42Vh1hOIWnSGqp
	hGT6ZhWb8Hf9D9rt+r9GTnHKF4n1Z9hqTLRDKWupAp0zj86Pq/NmbsKA4T8r8Vr+
	Ymkcb6hNA94+Jro1z22NFabfU3oX/G1sO82I+JZeDil7oK15tfbVlWG0Y7JZ+40k
	2OgdnVi5P5mInrx5PI0oHj34PZ2wQxPWgUa/e3qXPygNqQHx1/6FTaz1QAEemrIF
	UlgW3vsjyQXR5OJ6E/4Z+gaItvwfTQQtCSC9oRnoD2BbuCqP7gN5gG31MUZceNVp
	+1ppuzvexv3BDdsOA/Z8A==
X-ME-Sender: <xms:GLJHasgFqelwjB2OvjIcyobO6lfQ5F_PyaVCBQIguMnVlx0Ixif5xQ>
    <xme:GLJHasDmt381wEvrCbI93gRCPC9Up0rqkAV6pYB4ttjJegBsSP0jB5iMIbgvpSMP6
    25x2dv7uITj3euYy-k28NKdvidnMgbRwLgfpMTVOobeUSLlx85Izw>
X-ME-Received: <xmr:GLJHapHNh0E6DJUgTCRA8-gVAUYNSWR9DTYaSJUSAzYjKTuIkwN8p0nCWN_sjv49Z2MYidVKgbPHl6OgWHgAwgT1JENunBcw0dBl1VW2bA>
X-ME-Proxy-Cause: dmFkZTGJI/EebsDcqW25gpqCiHNFZhW60LUUu2c/3Mnt74NYW5TdsiSqfElB4Mts5c1h6P
    gTI7vBNc+u52TMoK3eb3s4a3zvjFtAjKsV3R0nsaj4W/OV79cKKb/gbZvo12NEhkh2TsYU
    j3RnmZu/15u1d75yjOsDtfeElJiELvlT4KJ1N/breo6jLKR7GdrE2qSFMCdhqvmIryWkPV
    ny8lqIoirfD5Qwl4P0CSMd4tPPpoP4k8xDC1pzy13+utmqgQhjvsWj6TAAOY3cDxccSO3D
    AzmjN5XOnCtC4qhECgLCs2jShR+B38h2TMcW+O9TQ+BJKQa1prrn4y9nbjvom8t6cLrxKh
    3foBNavPIcDSHBie9wvhel2YpGlDTOJfs8L21Bv0IKB4BUtU+jp85aakwqAVVDqWoDhkW6
    //5VCk6kzz7GX6ugoyOU+ZkJ7Ga3fK6kkxj00kjvxgHgWjZE1fOeKnhdOXArnFN1q6SrPJ
    yQYVrr9yRV0HSKAXXGNwt5rNPbd276zYptPjAQKCRcQVg1X5jfUx3Oo7+T9XYVollmv/m1
    os/iEU7EO3MRi/3FhdOgGm4p/VxND5DmXj7f26nLB3M5voqkOqbijfjdFY+qp6tjAANZMa
    RtG5xxBSPLF/ZSeTpbNe3nl6t+48yOw7UAP7koCqoL3F2hRJnn/SVYIGPxtw
X-ME-Proxy: <xmx:GLJHasLaTgJuiRccgN4tbJ2d7BjRWFrgfONlM4qH9jXqNf00hEkE3A>
    <xmx:GLJHalmmNmj8u9x0XCPbv3KZdgHOZsrsMn1xLZSDhDtBqM6mYze8Xg>
    <xmx:GLJHasQXW08WRQKeF_mtsuc2gu4m3Z_okUswYyzLzND39Sy8GRIn4A>
    <xmx:GLJHavJJvgkyyz8fXnoPUZfJxpZRWsoe3r9Ri2zJNx5Kxfs3vNdEUg>
    <xmx:GLJHahZ5anrMMX6q_lq4hh4Df3En1c8MfoBu1i5nGoBYKCaZnJnxy5fh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a9b09668 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:47 +0200
Subject: [PATCH v3 04/12] reftable/record: don't abort when decoding
 invalid ref value type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-4-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When decoding a ref record we read its value type from the block. In
case the type itself is invalid we call `abort()`. This is rather
heavy-handed though: the data we're reading is untrusted, so we should
treat the issue as a normal and not as a programming error.

Fix this by handling the error gracefully. Note that this also requires
us to set the value type later, as otherwise we might store an invalid
type in the record.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c                |  6 +++---
 t/unit-tests/u-reftable-record.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index fcd387ba5d..1fce441930 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -388,7 +388,6 @@ static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 	r->refname[key.len] = 0;
 
 	r->update_index = update_index;
-	r->value_type = val_type;
 	switch (val_type) {
 	case REFTABLE_REF_VAL1:
 		if (in.len < hash_size) {
@@ -426,9 +425,10 @@ static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 	case REFTABLE_REF_DELETION:
 		break;
 	default:
-		abort();
-		break;
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
 	}
+	r->value_type = val_type;
 
 	return start.len - in.len;
 
diff --git a/t/unit-tests/u-reftable-record.c b/t/unit-tests/u-reftable-record.c
index 1bf2e170dc..9c95083ef4 100644
--- a/t/unit-tests/u-reftable-record.c
+++ b/t/unit-tests/u-reftable-record.c
@@ -11,6 +11,7 @@
 #include "reftable/basics.h"
 #include "reftable/constants.h"
 #include "reftable/record.h"
+#include "reftable/reftable-error.h"
 
 static void t_copy(struct reftable_record *rec)
 {
@@ -202,6 +203,29 @@ void test_reftable_record__ref_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
+void test_reftable_record__ref_record_decode_invalid_value_type(void)
+{
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
+	struct reftable_record out = {
+		.type = REFTABLE_BLOCK_TYPE_REF,
+	};
+	struct reftable_buf key = REFTABLE_BUF_INIT;
+	uint8_t buffer[1024] = { 0 };
+	struct string_view dest = {
+		.buf = buffer,
+		.len = sizeof(buffer),
+	};
+
+	cl_must_pass(reftable_buf_addstr(&key, "refs/heads/master"));
+	cl_assert_equal_i(reftable_record_decode(&out, key, REFTABLE_NR_REF_VALUETYPES,
+						 dest, REFTABLE_HASH_SIZE_SHA1, &scratch),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_record_release(&out);
+	reftable_buf_release(&key);
+	reftable_buf_release(&scratch);
+}
+
 void test_reftable_record__log_record_comparison(void)
 {
 	struct reftable_record in[3] = {

-- 
2.55.0.795.g602f6c329a.dirty

