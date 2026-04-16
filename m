Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E37818050
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338402; cv=none; b=EOjkyGKybVCPQ3eWRZR2MVM/OCjZWcpThbOq026f6fQOmGmi/q5CMGlyPSNWMQo8dhn+6x7GSaPu18KigRPdwUPmvLhu2niWrCd81dTYTYG5ft3rsK29bdUnhcJnsuu4DPMTJm/EGRqiI5Q+4WFFfd5msHiMx17JW1//X51zi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338402; c=relaxed/simple;
	bh=btpJKUiFNlUXA1LKD9q90pol3SWi1ccsm86g6cgPVbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbwRKfF5p+oOi4fhvR/MhIh2Y3mALOnFUDma0iGNNgPJQsRSXdul8I07UoF7FviWlMDMRPEAaXcyNaJ8kkJafSK/V/eS1vm90oGOEUMAWBBiakXc0inY7b30L2XYSox8VdbABccMSnX0JBSGly7DF5W9z/ghxmGpCsz2czOMDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EonmW0Mx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzccn7+l; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EonmW0Mx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzccn7+l"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BF7C7A01F7;
	Thu, 16 Apr 2026 07:20:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 16 Apr 2026 07:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338400;
	 x=1776424800; bh=Qec/Dl8HiNegnp6O5X03Pa/AAEyuglTunFMmWaoK2V4=; b=
	EonmW0MxrieaPGnaHOTtHTvWPEL8FVDZuVg1iTdWKwQ/KeOWbv0W2CQlGmcbCmvp
	bAR4fVJGweUFUeQTazyOomKW0Pc7o9j89hTJ1FDkvO8OG987KmXoEldoDBIM9+Us
	V4KyxUoDGABomf8FuvFttI6RBI5KVUTw+sA448M6xsgS+pr8JIOlRQxqf8x1IFo3
	C8rH8lUJzXfop9+YZpviAPe8iXBtMJuRAVtngTaqZlWwa9LOXvemynlhziKEUfdL
	cUJBZUkoJQhiHv/2GBbpTVxH8I0gXDZ3tS8zrPCBFo7kRQtpQ4oMq+8qWuUbD/qr
	hevE/dt/sY9J9prMiJBOgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338400; x=
	1776424800; bh=Qec/Dl8HiNegnp6O5X03Pa/AAEyuglTunFMmWaoK2V4=; b=j
	zccn7+lVRHA7CV9bWHAHEOXJiVysb4L7ytADpoi2kPnJti5p+8kEIAoVTV08TSVN
	G54Oxpf1lA5x/69m3Y7d7cinXQtGxy+MckzH+ZqL+WpJYw8nemFYU+/PpQyl5XDZ
	Prztn7sIFBsTmFboDsrUG23E69UNTvFtlSjZVqHAkrUNErb4BIftcCCDUKVQEk3q
	oSolS2/UYSOAbty+V7HD+vhQZKxtlCnTokpoyspnnJWtJorMp04Em/tQu8LSc+ha
	GE0lLqf+HcZlVxsu81a6O9am3XPU3kKt28mziI3JOauFC/tYCvbrOA2+91MP+jsV
	DkmFWp78ezzue7sXfX47A==
X-ME-Sender: <xms:4MXgaUHN0TgQplBgtZ0kzqM5L8D4r4nv16pLAOS6B2IdZo6rnp4Bzw>
    <xme:4MXgaUzCevfijg_BSksiknOGSzzIGWO1HO608DRQtqCF7TgXHtCTGSaobxx4GKt7R
    qG-vyAmCEyr7VFU5EGUTdBL_E_VHpW9-0k6FpDY0rNqW0JVtTD63Q>
X-ME-Received: <xmr:4MXgabgKY-Shs-bKQ4_VryrMWmObQlLciLYzI8essNcMQBFB9_HbQHs-dpagOQ3fGhmqWyYAVikOlAdNGeUU_zeubNfajVem4nk2Qk9hlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4MXgafxjN5Rw-1kKa_Jx1ZShLVV6s7MwSo59Xp1EEjy3ljR6qXT9qg>
    <xmx:4MXgaeJ1G_5LTVC0iywKwxDu4ZVuXytWG2kmdvhAtmAj5NhssfUq4A>
    <xmx:4MXgaWS-g5Bhlx9s5s2FJE8YbNM8MXiTb82CJ1LoRQLmhxfOFdLHXQ>
    <xmx:4MXgaWryKI_9cx0-9CqbcYlOoJrp7NNlmX3nCcfyNDrQjvF0CKeSUg>
    <xmx:4MXgaRjWaskw_idjziwIF_Ac20oI_e-SwBjtPUvDYs_64SPWU4fr-EX_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8cdd12aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:26 +0200
Subject: [PATCH v3 09/12] t1301: don't fail in case setfacl(1) doesn't
 exist or fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-9-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

In t1301 we're trying to remove any potentially-existing default ACLs
that might exist on the transh directory by executing setfacl(1).
According to 8ed0a740dd (t1301-shared-repo.sh: don't let a default ACL
interfere with the test, 2008-10-16), this is done because we play
around with permissions and umasks in this test suite.

The setfacl(1) binary may not exist on some systems though, even though
tests ultimately still pass. This doesn't matter currently, but will
cause the test to fail once we start running with `set -e`. Silence such
failures by ignoring failures here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 630a47af21..0e0d07a1a1 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -12,7 +12,7 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
-setfacl -k . 2>/dev/null
+setfacl -k . 2>/dev/null || :
 
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '

-- 
2.54.0.rc2.529.gd9106f7525.dirty

