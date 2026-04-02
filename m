Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5E388E68
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115097; cv=none; b=G2IwCLMXYdA+PvgrphC7bv0hs0pbznwIV994riu3C/79TBp76QVBhfxdWtseuTIv+Qbzkw9eZYC2kLLUHJf8X5kNu0iUAFBt1iihrUCtCqIK1tZaAtQKjHk3fRTQ9w5xXl6cYD+bFS888RCEPfKoDlIaPITBGm5HZXwIu75u1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115097; c=relaxed/simple;
	bh=IC4r+GR4zzTzmFDVvBF6DqV9GCwXya+IX3F7t7UKQ20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJQ+6xxmL+6A+4cPNeeliXHAJ69h1HgkBK1Sp6WlGV+fK9o7fWLdzgVnG2dnbI+Jp6MSTT4Vmx9ynQsJEEYhp5UyjNtdaGQJ80wpDX6L6vKMtxQNCiRQTsB4AXvoSiFLoEg6byA4ubcMq2tS7MsLCl3mvBDwiZ996gxZfUmjvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ag4M9F7S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qSNlrE/D; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ag4M9F7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSNlrE/D"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 943507A0361;
	Thu,  2 Apr 2026 03:31:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 03:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775115095;
	 x=1775201495; bh=ByTLsAgMulty6pQWUePwwu17C7gRdmHYj9/9rJv2rAw=; b=
	ag4M9F7StzUoijpGhTaNaCBI6/aw7o/f0chz0b+X1vJ7ZkdPhBr6EFYEFeg26Txm
	VMxYaH2Vnb0CuQ5Yu9d9cTfYd8dJhIl8R3xGLKi/TB/3QIn+f1uCmd0IGGCWtNto
	/n04qnaPJ0M9JTTPimjGVV6qbmLeEMaY7WS02bAbd4sFwzaWpYVfVV1BpCdWZWPk
	jKgMQpwk3ekYhS9UTdBfDwNLqEc2Um2gFS9mkKgkKborR7oqGVvgyB7ZozzMkaae
	99YiQxCIGFFwfq/fRw9nc7aOGlLKaDhFIZwkn4TTTld0y2411Qvzbt8L0F8Ln+As
	cjfTgHOVujfShGrKUMgNQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775115095; x=
	1775201495; bh=ByTLsAgMulty6pQWUePwwu17C7gRdmHYj9/9rJv2rAw=; b=q
	SNlrE/DucFpFUc5Q2b/h9njign99BiP9ONLPL7Pv91R9wx/eW30XLAID9xJtS3FJ
	4Rx1qp4Xr1jIpGZ0QsUbfnyCgEXGpO2YQ16AI/8jIyRDoLbW+8bBcsIl1bIYLBs6
	XyKBAYuhGYU3VSA0qqAl9ny4CjymcTEIvJR/C7VW4epAKHsHOGhB/7maCeu/RyjG
	LJe7K4a8HpF7eJNbStgrsePj4ChPtdYl8f7ml4QFng0ot5G68ydEXJ1NzN8FUEqY
	b/VBA44+8dFGxi1+JGzyd+AJg9ZacwUpm3D9qaQfv4IiI5T9+/CYggu6N7jE5FB0
	lJC1EAGYohLw6N/W4MBfw==
X-ME-Sender: <xms:VxvOaRuq2NET31bo0jAa83eRKAfWpvHOSRQ2BUUF0bhCtXVUAEc-cA>
    <xme:VxvOaRdwJ6B2ClXlFfGy8QcUZxTe-0NZHVcd60KDIa5hXhOvp-E4tcxxOXU2UftEj
    ROvPtOp6RuAbyEdFO9WVk_H0ihCdSunGiBesyNWQY5Fmgvhk4Tw>
X-ME-Received: <xmr:VxvOaZxxnVQoQs_d7TMiqAeWiVNNTSvO61EcdvJUhMj9ipzlnohtqkBS4jONkgdMcPiZj8Joy8hvNGfFaqsJVoGjJzkeE9lYyUtrVlTK3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VxvOaXGVC1iaHHXG_RWTloogeUADZ0Ev_0jw3g5wzS3afihp4F0ijA>
    <xmx:VxvOadxcn1S1AgjEOKfQHX8CE5wNu2M5U2Tuj9sywIHzY6db8MPLPQ>
    <xmx:VxvOaYt_ruZBF05b3cc-LeUE4zzGalf7o9F5qsLjkhKioyBL97RSUA>
    <xmx:VxvOaa1D8qSD3lYM7OINKIstkgX1baK2Az9uVELIJf0ij-wHKbvA3Q>
    <xmx:VxvOaaCr91l4xRmmRkATneKsOmG4YCwckOBGQJ6P8UUkJ_Iirl7_LHpJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:31:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06d390b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:31:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Apr 2026 09:31:16 +0200
Subject: [PATCH v2 3/5] reftable/fsck: use REFTABLE_UNUSED instead of
 UNUSED
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-pks-reftable-portability-fixes-v2-3-bc110cee0ae0@pks.im>
References: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
In-Reply-To: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.15.1

While we have the reftable-specific `REFTABLE_UNUSED` header, we
accidentally introduced a new usage of the Git-specific `UNUSED` header
into the reftable library in 9051638519 (reftable: add code to
facilitate consistency checks, 2025-10-07).

Convert the site to use `REFTABLE_UNUSED`.

Ideally, we'd move the definition of `UNUSED` into "git-compat-util.h"
so that it becomes in accessible to the reftable library. But this is
unfortunately not easily possible as "compat/mingw-posix.h" requires
this macro, and this header is included by "compat/posix.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/fsck.c b/reftable/fsck.c
index 26b9115b14..8e73fc83f2 100644
--- a/reftable/fsck.c
+++ b/reftable/fsck.c
@@ -63,7 +63,7 @@ static int table_check_name(struct reftable_table *table,
 
 static int table_checks(struct reftable_table *table,
 			reftable_fsck_report_fn report_fn,
-			reftable_fsck_verbose_fn verbose_fn UNUSED,
+			reftable_fsck_verbose_fn verbose_fn REFTABLE_UNUSED,
 			void *cb_data)
 {
 	table_check_fn table_check_fns[] = {

-- 
2.53.0.1323.g189a785ab5.dirty

