Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E191C3318
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381475; cv=none; b=VBKwCZkP/fc+xpl2G5WgeW+Pkh8VxBCUbb+1CTctZycmKhQRliK8EhQF223pXDAW1YQHKw9Bp0teMAIDPijf6GSc/mND/PBPgnK6OtREV3VZCt1AHrlo0v3FMH7oZT4GhYQGaAMpDEbc6vYY8yPId4xR4XdLv/tOsdAqcQbeTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381475; c=relaxed/simple;
	bh=ftb3RVJZuWpT/7eocSR9X2LQzO4E0g4SwouYHSqUbtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfW/Rz+EqwntqOZtmtdma4p63WVZGcqsNuAQ9WVeB6L1x1cELEb1CV2g3bYhHSbivbEo2M7kFVmpYc0FJiltbP4xSGE2fkD8lBrZ7mOkrXrd2B8ILRHhnw10jgJmDzaYuL9rzLPlYZSPBiNyE20UWV8EiJhDz25KAUsEmbAVuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uZW3Lo3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yl8Udpye; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uZW3Lo3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yl8Udpye"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B43B01D000B8;
	Thu, 25 Jun 2026 05:57:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 25 Jun 2026 05:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782381473;
	 x=1782467873; bh=j32WtcyoUFxeNuONrfG3+aL242+S9OlDfuEC26/qFGY=; b=
	uZW3Lo3ObSoY2d2j6i3ikfCm7WUJnWQy+Za4NzgB4MjLB7TwS4TDyZUcFR8yGE2Z
	gGWUgIL0Nj9Kl6Ahj69/u64OXAo1U//so6cU+NJxtONU8m4mnJGHliCwsq5J1HsS
	pXN0LdLKDZUgNe0302wXFxjQ0taAc6dIgaLd8CYHYdk2oacqBNO3ZX8zppZR7YN3
	9IgewTVjq2AJ6yig5tyELDHLkxgZkCknf+hIoerzcWZsetr+slwdwlXqk2WbGRWW
	GnSTaaeLArG2yHO4UWeBlibrHAE7b3mrPvkOHc7Bgrz18MQNNRsPEuFtZYuxaOv1
	7sP38Rq8PeqEhxI2LRL0tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782381473; x=
	1782467873; bh=j32WtcyoUFxeNuONrfG3+aL242+S9OlDfuEC26/qFGY=; b=Y
	l8UdpyeXLhzZ/+vjePfi56X/TCXlLYZzMatdoEDcYRWKcoJG21iMU7jfQsWuOYan
	9pb7aMVb036AYf6cG1rz7465nyQjbeQG06arDFdQftWuD1K8WYzcTeeWiT9L3wYW
	xJhhfZqC8fpf4X2ptTercM/KBE7FkqWF3UfNk5arvQtCc5K1vbxrcqJm7bRounQC
	ZdVQvPy55ZhPQViqNQgz3cXPSwKIi6ERJx8JgzIXLcLhbIP4Et72hoMK+OEWiOSM
	w00dKqWxACxMft1ZhiBSfiwvJZcCMkgmI+TY99l7k8i1EqfuXDKb+ZBoqO5t2jfd
	3sAd1XKlycRfQsLw+DkFw==
X-ME-Sender: <xms:ofs8aoCudIgJI-ODJzbktkNsZLCbZ3YXGyrqIov5PqIof4u9EoKHaw>
    <xme:ofs8ah9ER37WBt9GoL8NpqgrkKmx15Qa73YpbAOINtj7WnXGMtJOK7zprhBdMCmvO
    1YYw0Ew1Uq2_Y_F-VuHyxCK1ux9cG3g9M0YSJU8Yr7AD6fCGdEKKg>
X-ME-Received: <xmr:ofs8ao_jna6OJ4LXcG-0ifufDDB5oJZn2TRsr66DjBokbvspwsBt8qQn-t8UA-52GcpUHp9vgTLM7XK7_HfFpfv4H4pivHDVkgwzN_cSBw>
X-ME-Proxy-Cause: dmFkZTFd9OKwzScaIel6hyHQ7PTwuQAy2Y3XUhlp/jcWq3FdoRFLkibveFDERml7rQtzDU
    Eu8te+PJMbQJ99Kq2CDG/Aqz4rJ2HPe2h4ZIBkvKqrLSAWhHcrBHeW0SXEMJ8uK1Z5oqxT
    3oBH1HXTfE2rL4tejKsUVMXAZFLDaQ+w/Yu2B4yoybwOISfcetAHEB4dFDJHsE/XU6Nzv3
    +orCI+5BPg6YuDgMNcsiVTLf4AGmRGCZ0rmFjjPeEZkJF8BxdpvpN+hvQk4vYN7KcXQpHw
    M+6vjeaIXmA1bO28vEBcTKZvdg4OjRIrh9nUkmmOHgzOluOH6hQ7OsQdrjf78GFU5HX6PX
    8b/96/5cVrAOqg+TY4TghdeeSTtZTSGPfZUGxUbFmolVI7fBEr5RAQ6CVqxucAYcffmwHU
    V0Cbcok0qS1iXSvp2q61P1xBkKayXi8cM4H5nONMENDGcrdzh/hhL4ggzQH7hCSgNhxbNW
    NcYSTKyM5AFab++rH25oUBqiAG5cmJVOIHJQ+aTRhyfKlNW/QCo5sKbUBD519vooXMxcrL
    ewX81UvWt9IH38p1gK0s1qmqkqJT/odIXbvuA8rKBxjYrV4lEWdIQGyYubfqBRz5b0QfHO
    o83VGYl2gVd18+MKunKitVx1RJ4r938W/xiDcTggC6XjqLIZh4UZJKjB94rg
X-ME-Proxy: <xmx:ofs8aofhSubX4YPT6344xW0Cc5dZdp_c7_2tZ_pWHOp53rONLo5ghQ>
    <xmx:ofs8ahHMVrnhGCfFFWiQTHJZpd5A9nKtLrICEzy8zEYMxTNUzHDvLg>
    <xmx:ofs8ameqic3ZFUhaC88juFTjjugdEi7LRyFbl4ug8ecwnS7Up5s-gw>
    <xmx:ofs8arEhfQnd50C0crsf24s8oh_uJgYBSkaKonBbnKGiJ3p20JcKow>
    <xmx:ofs8aklDOSJ02rbYcqvYJihiVaTgMAi1-SjMfDB9Rf9meiMKp3rC023t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:57:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 050d5e22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:57:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:57:40 +0200
Subject: [PATCH v3 2/4] odb/source-packed: support flags when iterating an
 object prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-pks-connected-generic-promisor-checks-v3-2-7308f3b9dc44@pks.im>
References: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
In-Reply-To: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Callers of `odb_for_each_object()` can specify an optional object name
prefix so that we only yield objects that match it. This is incompatible
though with passing flags at the same time, as we don't yet know to
handle them.

Loosen this restriction by calling `should_exclude_pack()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 3afc4bf01f..96fc436770 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -148,6 +148,7 @@ static int for_each_prefixed_object_in_midx(
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
+	bool pack_errors = false;
 	int ret;
 
 	for (; m; m = m->base_midx) {
@@ -176,6 +177,20 @@ static int for_each_prefixed_object_in_midx(
 			if (!match_hash(len, opts->prefix->hash, current->hash))
 				break;
 
+			if (opts->flags) {
+				uint32_t pack_id = nth_midxed_pack_int_id(m, i);
+				struct packed_git *pack;
+
+				if (prepare_midx_pack(m, pack_id)) {
+					pack_errors = true;
+					continue;
+				}
+
+				pack = nth_midxed_pack(m, pack_id);
+				if (should_exclude_pack(pack, opts->flags))
+					continue;
+			}
+
 			if (data->request) {
 				struct object_info oi = *data->request;
 
@@ -198,6 +213,8 @@ static int for_each_prefixed_object_in_midx(
 	ret = 0;
 
 out:
+	if (!ret && pack_errors)
+		ret = -1;
 	return ret;
 }
 
@@ -260,9 +277,6 @@ static int odb_source_packed_for_each_prefixed_object(
 	bool pack_errors = false;
 	int ret;
 
-	if (opts->flags)
-		BUG("flags unsupported");
-
 	store->skip_mru_updates = true;
 
 	m = get_multi_pack_index(store);
@@ -275,6 +289,8 @@ static int odb_source_packed_for_each_prefixed_object(
 	for (e = packfile_store_get_packs(store); e; e = e->next) {
 		if (e->pack->multi_pack_index)
 			continue;
+		if (should_exclude_pack(e->pack, opts->flags))
+			continue;
 
 		if (open_pack_index(e->pack)) {
 			pack_errors = true;

-- 
2.55.0.rc1.745.g43192e7977.dirty

