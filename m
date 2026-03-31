Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2E3E0C70
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001492; cv=none; b=keXhDfHnB6wCBwesKzzZaUf5xcalNBlsb4jGo2PftFmRjBgeW3yq9IpVGzC+Cv6NqVthdN4AwnPBzF5QDTiEuGyGDFWvliIkNTekEJngBofXoHoFlRF3WgWnLBOeBBCBEGfUVzmhOxdWpuWPTHg3JZOubG+ocZ/HWY3c26Mzl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001492; c=relaxed/simple;
	bh=fa6A8Z4oDuv2BHI2jVrT4ENpIYL8d01Yv0YxNhN2OT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5sAS0t4oiTTFfdsOMPmwzy5WUdAGGgfKWhIk4fPESjgefHWl4v9Cb0JLNyzvW/BNtVKAXH8w9QLMuJFYywC5TtWh3ug+8CEncohzRMfPmfuc+V34T/EE4EP71noHibwtK8hxnAXnXrCifN0gdaLaSbwPqMJyxTw7EgQrY2Ibzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f+t+zfCg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rwhj/tNo; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f+t+zfCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rwhj/tNo"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A87814001EC
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 19:58:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 31 Mar 2026 19:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775001490;
	 x=1775087890; bh=9vAo3KaEdLQgcaBJk0t1bpTbwAo05ZBEB9Lg4hsTFkI=; b=
	f+t+zfCgO+Lm7pC3u6/WeeHW1GUJ2mQtY4jOWVF0ZkC6PZCgJQIzc7XSNDvSUbS4
	sQCa2Js60MWa73rOsUSJxlHjpBCJapbRir7WwMzmvpZPolbSiP8JN0S8KcHIYIOI
	d/mPSaYin9ULXUp+5O1Z4nBRTlYcBO+EAiUcU2kJ1OUslDBdnpPs9cW+bX3gBhfi
	fIi9iPVBNSkjH4aDIXABXdPXrJgVkm0wUs3oRMBRGPJY7beITXs1pewWeLrNxLwc
	8Nc1TmZX+SGfpgu6eo6SBxdeFg1bn7hcmVk5OAvi5q+sdKCMqN5wImXWM6wRHQHN
	0RV2dJh+5MxCHKEbeLc+iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775001490; x=
	1775087890; bh=9vAo3KaEdLQgcaBJk0t1bpTbwAo05ZBEB9Lg4hsTFkI=; b=R
	whj/tNol0I0uXqRGA/Ku/e3oMJ2G6e+qwoSnwaaNA6/oJ6HbFkzXE7/2EhWBc0Wl
	tlifqN9HzY69FB0JZEyZxjM0BNPOGfunDqkxwm1jjvi5ptzdczs6SPeSCoEmFyYn
	iIuO0V/sum3rEgvhxVUMnmNfFNDUrnghvmj6q10aaqY5aKHbgY6UhdUvOIvb/OVj
	37Wz4QqZza7BM2c5egMcv2qncMOMT8op/KfGWOQsBTBmR5tPkVHHNQuhgXuZOy5B
	aSwk+/Oi6Ki5xnalTxaJByN6SoGElkxQThMuQa6e8W4djTKUxm9apJgPGJSmhmgf
	r8AbFuwrJ3K6vshFnIkMQ==
X-ME-Sender: <xms:kl_MaaJZ36SRg8fD03dNsHJ3zDBRtUar-7_pBHPP85FeC3lpWJczeg>
    <xme:kl_MaZHKmKHxR5GiClp-HnDdQTCmkxnLuakMjOVVBzewWcYW7quIczglOq-hSYIQz
    0bPCHg1D-KjMPeb4lf0mqyxjQo3Az-c9w-szAJDSpP5aWj_SbqduA>
X-ME-Received: <xmr:kl_MaQXx2gvBJ5tS6G3YfB3YrKHmsqn-6mHTrREIXLfCX1FbeYW4aN1E9mIU6jDEYjN52bXMUA_oNgBV7m-0LGEsu1WkD7ho_I-E59VbMnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:kl_MaUie1K-51qtpGbBEuLsUXHiX8ZDZ_Xid5y4yQZ6v6d7-otyluA>
    <xmx:kl_MaRQKQd8fXXwhMH_4H38LZGz3He6YC8b2q9Bnt6XCukk0bimrhw>
    <xmx:kl_MaXEv2uFQwHVrCBEorwZ7c-aqitHB1qIAaR58SYMyhvXI0zSAhg>
    <xmx:kl_MaZnCsPnNyN9dwYTYw6SVBp6zPRZLOEMaKtHn30_-jOpsv8x_QA>
    <xmx:kl_MaboPzWiUf1hzo1xoHEKt1nPIE3JXwaBY7WPJH2lPsqGr_aZ0ldPQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 19:58:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id adc3284b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 23:58:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 01:57:51 +0200
Subject: [PATCH 6/6] odb: drop unneeded headers and forward decls
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-pks-odb-cleanups-v1-6-89adba9ada68@pks.im>
References: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
In-Reply-To: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

There's a couple of unneeded forward declarations and headers in
"odb.h". Drop these.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/odb.h b/odb.h
index 8d739e118b..3a711f6547 100644
--- a/odb.h
+++ b/odb.h
@@ -1,19 +1,17 @@
 #ifndef ODB_H
 #define ODB_H
 
-#include "hashmap.h"
 #include "object.h"
 #include "oidset.h"
 #include "oidmap.h"
 #include "string-list.h"
 #include "thread-utils.h"
 
-struct oidmap;
-struct oidtree;
+struct cached_object_entry;
+struct packed_git;
+struct repository;
 struct strbuf;
 struct strvec;
-struct repository;
-struct multi_pack_index;
 
 /*
  * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
@@ -31,10 +29,6 @@ extern int fetch_if_missing;
  */
 char *compute_alternate_path(const char *path, struct strbuf *err);
 
-struct packed_git;
-struct packfile_store;
-struct cached_object_entry;
-
 /*
  * A transaction may be started for an object database prior to writing new
  * objects via odb_transaction_begin(). These objects are not committed until

-- 
2.53.0.1185.g05d4b7b318.dirty

