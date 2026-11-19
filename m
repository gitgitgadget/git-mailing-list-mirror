Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088872;
	b=Sp02sCGrtaj2pduTUKV9kkQaFIHq0cW5J0uhgE4LpJ9qS6OIoYcUL8Boirp0FduHcW+H
	 ooyCxw9BA2Kvfg/Pfs+fWg557vWzRXO0Mb/YOjQ/JqNqM1zONP+MmzvsdAufAvWayUEl8
	 lY9BQUaSTS3ZyBH3mF1Lyk1xae/j/aheGLj3pyTbMx9JEEoVDRadQnOHhVrD6C2WBd11s
	 Q/KgzHaCo/L7UJm0aqVXnRQXR4LuNgfPpT1kgM1KhM/4sYpCt9et6LN8CcHEYTjhsTSk8
	 YPqTyHgc30sKqYyBLsWcBVoEtI4Qny0PjjrurzqwZdVxcEbKyuwRxaNp0bDqbtEx6Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088872;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=wQ+knAv8CoEJU7aZsO7ySTpDxRBqtyGLHifcvFMdlgg=;
	b=HT6e4XecEhSW9oCXCuDFhCPKJaIMGrwZy0OqHamrziJXfpsOhBHS65JdIOvP75RzP+ad
	 8tImDWpuSprxR4rxkAE2Eg5Pvr8Mhtc0y7U4Zlf+EnQHf6rMgHTFnQ6QIKK4AUUqwlq3Y
	 pysP+xbPM5dyFMHc8jK96iaqEDJMinqNg+pUw1bfhfQ9sFGv/Sp+pLmzngnZ80ELCIRzI
	 jXPNoxcBxZ2OjFxYe9tIhi5y2FVQcabYRsXBu1wSoN9aPfELxwZOj6gtxIYegsc6uOhkg
	 iX6CDwOMUSYBp6ahQUfolDC+xarTj01qNbju0u+DAAEcsXKueVHoUXB4wcxq/6Lnjcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=FpQVbRDO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=H9nyIhf4;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E576606A326
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E576606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=FpQVbRDO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=H9nyIhf4
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6463814001CE
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 06:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088871;
	 x=1795175271; bh=wQ+knAv8CoEJU7aZsO7ySTpDxRBqtyGLHifcvFMdlgg=; b=
	FpQVbRDOaubBII+ve+QKUVzm+KOD42cgUZAfpd7Bq4M2joBlvaczXyoa1S9gz62N
	anuAHEQ759G78SzcthESVi63qFT3m2vxCBa38ma0CrpMovz7tZs7XZzMyHk63vDj
	MDgXA1e4O7h+Q5Xy5POLhqP7gxV7qmMJgRFcNGKhkh+epsjVbQaCKQ0ecDzTTOZx
	hVnZbhZcCBBLjRvHqw0RLsXiWmkb5Dno5xMncRHtLfqT8D5CDQ98F0w0RDVqXRko
	J3vo7xvyQNFS2xNSVuWay7SplMtcbPV6opYptmTDurx7FpJDzPG4jnFPRATM2mp1
	suD8VBo2OhofR91nyfddLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088871; x=
	1795175271; bh=wQ+knAv8CoEJU7aZsO7ySTpDxRBqtyGLHifcvFMdlgg=; b=H
	9nyIhf4KTyl8bHXm6W73GfTRkQejEmyuCYrJJ0vkqAZox+AfXc4NPiXr6s8ZWwsf
	+3XEoLMKq0SAS2oAuQw1ejYF1AUxEE83CWspibKQVTjc4cLWKRiANIbiix7OEGx7
	ppq2e4Xi3trOttri049Y9DVHfsGC8S3xQ9lUq3fWbGjyCeP3GbrWi8fF2Iz1zqeI
	i9lU5Mnr3omycAZ9KVBmGc8C4Y0RyiqhN7JqwcBmsGojSAAXBAp+e683m+qqRQ3y
	Wabfo/7Lr3s8dyDQTLK9q0Q5agzhJKKQUV+SSBqnTIejxoU53dHTeB4O5N4dzic4
	cQENGMK2fUCMjTULmFgZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088871; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:sZNbOTboGhIIj03qusx6vvtGH1gH11gMGD2oyP4e5V1ENW+
	4p2fFpJe3xKU4rSd2Ij9En8oP/S+/Qqojc7KqxZMoeNDiyr88oIiwfn44FA94Of0
	K5+pKPpi0+YHIcmSfSMWpl6me3KbDYxLva90vhJRvR7m1dKBtIrSgvxJkQslOcnx
	qPjJ1C4LMmFOBJDCUx/gejBKkyM5Rxaxss9ceGZF0NIm4UdnIKI3/bCcBUaK5YT5
	KAwM2n+4WLCBw0/S94hkrbDIc5/GPzN5m+LvaejP/fx18L+eaGJrW9I8W7Te5Tyw
	4vOhw15Dr9h56+oEe9Q3gjwHYAtyiUMqsogdp/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:C5Wo/UVy07NzZerbj+3t1lbzeJfaaQl33RsfOhndGOA=:wrgRfBA4Fv+s9SNo12La06pYMTRUArHTsW7i5ElmUD0=;
X-ME-Sender: <xms:5-H-ajUB5vNZIyaxDOmAyVPZTAu-wN1SCZHUtJS_uUMr2_ZL0YlLLA>
    <xme:5-H-ainiDvROEwjHyYmRUSoaOeFOjT4vdjrd3g4L2urT6gFRCXFnCbuoAqc1X6GCO
    X5YvwV2_JUCin_wCyE8PmedMchU5ShGwF2bDpGfgsWERg7iTLTESN0>
X-ME-Received: <xmr:5-H-akYvPcOxQYwQ1qBCBotwcD17tywgQE7Dt48r-6M0S1BWQFK5gYLo5boqXI_imLaubu0>
X-ME-Proxy-Cause: dmFkZTF/32wl6FlpKXUHfxDcn1hTaBTCGMOZYqjGsfBaiGnyK0sV8kUgsMh9oawPIaQSfm
    S00uQyU1+y5i9Vy3XCfnf6ZL5fdWJUQvNGpMCsKbdbM+G9Z5rOMQsdrAiDBKdZCovULz6e
    QmbdjYc1AUBpn1E9S8uUEmtWDiXcB3pkSu5D8Msg0jZcvKbsNOjPHAWxKL45DVeAJBORet
    DuhXt7C8VNmlTOezmFd0hW6n4cs2G44dcT2yuGoTpYkkoj9i8fC26H/od72nespxayRNQg
    OruLeNIwqQHuqGbckDcC+lVIz3EtwZi90PhgyNB9/hGvmBNdckDRxX5Bl6stfzCMtrnJiD
    0fOECb+KZ46ou15Ryhx/VpNDTIfp6+zmK8Ljsha8VF5CoDOZOKhYAgmAl5b7Nl+1Ppby8C
    AOxZctxoPhXP1OzRWPQXGwzAYAELee+SXSkWvg0oFcQrceqmF41Lr2PTk1wp1Ig0ERWHkH
    fveRh50eVDHFgqO8T1l+4IftkNY6fZLS1oCk/eN5KrQllSyK0YyuKy4o4PbxQEiYik6n4h
    L5GPo0+TB6MnPL/hyf9zjj0A8oaEiD0d2z9v+k92nxnf6YEU1NtNfbHSBESEfIDx+NrUkM
    tmq4e8HKZHDIzqQI83/RuWpIO1xWJxcBgXEFLwdAjT0RLbBzUohJPH9ZwcFg
X-ME-Proxy: <xmx:5-H-atMSLjuLLJI79Q-Qd5ofGk3jk30d0ik79a7oaI5PGs1AbYTzNw>
    <xmx:5-H-apbLTJl6nxd46U7yf0-qgNJ0OUPO-jNwPdk3PgHcN0rIXluXSw>
    <xmx:5-H-ar3AeVXB88SVJrY2YliGJ4mOxxv9dYpdJ_CIfbi6Q4RV6MUqnA>
    <xmx:5-H-avfxJ-Rot7CEEE4ie1PmMAqCOQooF5a2Mvyo-UX077sZHx00aA>
    <xmx:5-H-av7ocxXC9nMtIj24-jwqEioU-R7r85v7KVv-8RTSi94RDDUEPRqS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2203417 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:10 +0100
Subject: [PATCH v5 09/13] builtin/rerere: turn "diff" into a proper
 subcommand
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-pks-rerere-subcommands-v5-9-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "diff" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 56 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 3f82bcbeb10..40bae5cb9cc 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -72,6 +72,40 @@ static int cmd_rerere_clear(int argc,
 	return 0;
 }
 
+static int cmd_rerere_diff(int argc,
+			   const char **argv,
+			   const char *prefix,
+			   struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	struct strbuf buf = STRBUF_INIT;
+	struct rerere_cache cache;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (rerere_cache_setup(&cache, repo, &merge_rr,
+			       RERERE_READONLY) < 0)
+		return 0;
+
+	for (size_t i = 0; i < merge_rr.nr; i++) {
+		const char *path = merge_rr.items[i].string;
+		const struct rerere_id *id = merge_rr.items[i].util;
+		if (diff_two(rerere_path(repo, &buf, id, "preimage"), path, path, path))
+			die(_("unable to generate diff for '%s'"),
+			    rerere_path(repo, &buf, id, NULL));
+	}
+
+	string_list_clear(&merge_rr, 1);
+	rerere_cache_release(&cache);
+	strbuf_release(&buf);
+	return 0;
+}
+
 static int cmd_rerere_forget(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -190,25 +224,9 @@ int cmd_rerere(int argc,
 		return cmd_rerere_status(argc, argv, prefix, repo);
 	else if (!strcmp(argv[0], "remaining"))
 		return cmd_rerere_remaining(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "diff")) {
-		struct strbuf buf = STRBUF_INIT;
-		struct rerere_cache cache;
-
-		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				       RERERE_READONLY) < 0)
-			return 0;
-		for (size_t i = 0; i < merge_rr.nr; i++) {
-			const char *path = merge_rr.items[i].string;
-			const struct rerere_id *id = merge_rr.items[i].util;
-			if (diff_two(rerere_path(repo, &buf, id, "preimage"),
-				     path, path, path))
-				die(_("unable to generate diff for '%s'"),
-				    rerere_path(repo, &buf, id, NULL));
-		}
-
-		rerere_cache_release(&cache);
-		strbuf_release(&buf);
-	} else
+	else if (!strcmp(argv[0], "diff"))
+		return cmd_rerere_diff(argc, argv, prefix, repo);
+	else
 		usage_with_options(rerere_usage, options);
 
 	string_list_clear(&merge_rr, 1);

-- 
2.56.1.831.g720f3f5937.dirty

