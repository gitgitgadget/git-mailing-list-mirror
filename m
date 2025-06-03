Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08410239E6F
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959291; cv=none; b=cAhQZrgqGF5GVr/a1lGx4jYljyF3ZIE84LAM2fD/Pg42m8BEH0lShyk7Tkfbv5yVdRQus/zpQJdfo6YlrEY4lazpxFj7gHSYlQhT3oLOxbjR/9HIXglKCsMPYKGY+L3XpS8k2cWnihEwN2tUZsu99n6HmWsKbZnNknqvBLvlGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959291; c=relaxed/simple;
	bh=YUUi7DX8Zsh0kKx8+xs2wXyCXj41VYsXaMFxTSplgRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G17hmI8aSkA2PpxYWvaY1VYzPWONZrw2idnRjdYefQCv0nIpSXDfm15YT9eXNOrTCwUubDewYt5JiBiHARQ42jsiJjIoUzEHnLbMIQiNcYueYNWC1hUwfE/eIyKg6EwrkIBHiFA50sNTcCkzZNRkm7F3rL+7QRDw3CJGX8DrVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ref2JD2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6OYIru5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ref2JD2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6OYIru5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA9DA2540113;
	Tue,  3 Jun 2025 10:01:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 03 Jun 2025 10:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959288;
	 x=1749045688; bh=R9YbUwPpcic0gi6751sQK332IKPS9vuRV4FJjh7Efts=; b=
	ref2JD2sG1mt5yPsxCjbhVOdCil4YFvidFZUpPSk69Oxc3i2J+D3RhA/Xp5L+RJK
	RcPk2vDPQEkMmIOgh7d3UILqeYgRkqET99hz2ehwcGeqOUjJD+6m8IcukghXnt0A
	z4iyg9aytVbeNmgzmp7FcJ3MqdBwGnC16yeutsn7ynms/TligoOanYd1pBY+VgdH
	cvaElpWnnz+ovuygAcP3+S6h5O5cCL4aOaJOubxHXxHsB34t42S5xwUFwOgXtGL3
	ZpGRErxQH+SScen5DDcsCgYTT0cH2T337/hoiMv7QD0D1Vly79iU1yOFf2FZChxv
	UU7PAMMsD81V54eJln4rlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959288; x=
	1749045688; bh=R9YbUwPpcic0gi6751sQK332IKPS9vuRV4FJjh7Efts=; b=Y
	6OYIru504yzRkkLqR0i3+QNqqkgkCOlYhxnorNCKYcKRSJUegwNnXvT0lmend3xE
	EXhBnyow8Y8aiuRydOWhZIqZA+TUkcLi4mnEKogbAfpV0Nh0b5+1t/q3PNN93xTO
	dEmm7q/EKWfrIV7F26CU+II4uSX9yz8bAMXRzK6cPitO6swUQJ+kSuRAtny7IEI1
	D2NGdQYkZxcnGuX/Z/nvG+FqZuxppOoEzkxBR/N4nLIN5/wb+04xy99CCyUV3EL6
	HOYyIAfHfAYHTGFT/f1O0jhEd2KYaJF/TbM747A3zLgARIv9WOtziJ/ix85Z4QnB
	WUDBWRyAU+xgYQi6zWR0Q==
X-ME-Sender: <xms:OAA_aLA-HgMbqOR16Rm-KHm0YRvWDOx7pr5Dp7MWdOyei7OnTLwv_g>
    <xme:OAA_aBjtaDKt1uBTurQTv2FU18OIxckDR0szumY8PXvpFeyl5pp3pl3inujcDwDFk
    ocbvZUkgTqCt4wTAw>
X-ME-Received: <xmr:OAA_aGnbMBUeuXWg-JINqqSgBGVYD1VzT7YevjY0_Np5RM0_8uPz0di2AeP8iXd6Qlsw2go-NAyBz61TJzh-JfYjbzXD2EtP88BYURvPLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomhdprhgtph
    htthhopeihrhhothhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrshgrmh
    hufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:OAA_aNwtnYKXaxUZbxRSS2zQ5oylNAqBOjWYRxXzZArj0E5dpAPvQw>
    <xmx:OAA_aATzMx_wJGdMMVOhPm-WArTUCdFkIHgX1YGT6GzombKy7cs_pw>
    <xmx:OAA_aAatCvZIQClFInGv4NuHdnOgjK9vSJUr3kBJSKzVK2Lg0-jQ-Q>
    <xmx:OAA_aBShJIL-vv-qSIAHCy-oFO3U4jL4GWoSGjyDVZVuzMTEH2GzXw>
    <xmx:OAA_aHRkmUDGQroKhu8xNjHysEl2uy1Z6QPaiIhKnxRE4OJqaV6vIeNM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40bec37b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:19 +0200
Subject: [PATCH v4 11/12] builtin/gc: avoid global state in
 `gc_before_repack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-11-52f5cf7b7e99@pks.im>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `gc_before_repack()` should only ever run once in git-gc(1), but we
may end up calling it twice when the "--detach" flag is passed. The
duplicated call is avoided though via a static flag in this function.

This pattern is somewhat unintuitive though. Refactor it to drop the
static flag and instead guard the second call of `gc_before_repack()`
via `opts.detach`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index fdd0dd09be7..4a5c4b20442 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -816,22 +816,14 @@ static int report_last_gc_error(void)
 	return ret;
 }
 
-static void gc_before_repack(struct maintenance_run_opts *opts,
-			     struct gc_config *cfg)
+static int gc_before_repack(struct maintenance_run_opts *opts,
+			    struct gc_config *cfg)
 {
-	/*
-	 * We may be called twice, as both the pre- and
-	 * post-daemonized phases will call us, but running these
-	 * commands more than once is pointless and wasteful.
-	 */
-	static int done = 0;
-	if (done++)
-		return;
-
 	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
-		die(FAILED_RUN, "pack-refs");
+		return error(FAILED_RUN, "pack-refs");
 	if (cfg->prune_reflogs && maintenance_task_reflog_expire(opts, cfg))
-		die(FAILED_RUN, "reflog");
+		return error(FAILED_RUN, "reflog");
+	return 0;
 }
 
 int cmd_gc(int argc,
@@ -965,7 +957,8 @@ int cmd_gc(int argc,
 			goto out;
 		}
 
-		gc_before_repack(&opts, &cfg); /* dies on failure */
+		if (gc_before_repack(&opts, &cfg) < 0)
+			die(NULL);
 		delete_tempfile(&pidfile);
 
 		/*
@@ -995,7 +988,8 @@ int cmd_gc(int argc,
 		free(path);
 	}
 
-	gc_before_repack(&opts, &cfg);
+	if (opts.detach <= 0)
+		gc_before_repack(&opts, &cfg);
 
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

