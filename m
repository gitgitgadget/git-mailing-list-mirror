Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399550;
	b=tdUBUhl4Yi9wQ+ZLXClrWbql6s3zxJYxIVDcLdCnUcGArArbltCmSqvqlr0tStrkrpZu
	 Pwm7QlHNsvuvkUVVcXpOR9tuAFduizYUWHPcIrqDOb5rO0cPt6b6kNpWt1tc71LS1qI4q
	 fCR/4qOB2nC9zi2J4nMZHEzBjAtV9y4uA1BIjIWGDpOYrdAeMkmW70osb09BHFic4JP19
	 Z5yyoiHfjD3LhC0bLkNvJ6Wy88MpjUR1p3GD+oQRdm7ppl50mIvsCisxfFSjWi2ywhIxj
	 XFrdFFWWJhYaW6fTtKJi9FYpPKbL04qzEu/Z+/mDHlth/tzxVQzeiLj23OprVQk4a4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399550;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ueUGw4xiRCsGP4mNRn4+jL7xwolnwZ81/vNmhBU1/GY=;
	b=3BRjkv3ikFoB76eqZG7NoXCrGKV+IQzdrA/aE1rGENRHaw+vr86zJBP2lJkVcVpvOSW2
	 Ynqc+2Ht5GSacUzy0ai947N3QzFA7b6H2hnWdmO7neRBeOWtTSJMSaQrIxTb9hLOasAo6
	 VI1HnTTlAtWrQatays1lFvFSrX3c457bpoeD3ptJFyruVHpMKbbjallzic+w9PJQY3OnF
	 2EFOc7dPc3xUVE/XuUwQwiF+jDkDgmA+eiCyJEJgJOHZr6NvKTtj8ucVtQcPfr96kYAdF
	 15RXKsuEnPxVzZZ608iq99DFXRc4Sr6A7qwc2P/K87xMJQ74cW0fhIXnkbSu0ceygCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=tumN4iJ0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yGmH4Fp4;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C8606A885
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4C8606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=tumN4iJ0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yGmH4Fp4
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C2891D001F1
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 07:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399548;
	 x=1794485948; bh=ueUGw4xiRCsGP4mNRn4+jL7xwolnwZ81/vNmhBU1/GY=; b=
	tumN4iJ0DXHo2klrQxqb8/z1cn4QFzO6ynPqD3/q3FJrANFsTDYXMhGdW0lsrH1u
	ekzn1+azE1SmpOLl/Df5w1GbLL0sQv/Pi/p8uZoMq4Oflp6jkIsuySW5gapgV+8k
	peXlW6ToqWSb2tFBXNDubuEOick/xMUDSlgODRrIV4MmRySTWAaEIMTSyjZmp/37
	y2oGaBcDiFkfAPBovb0e/vPuiniJtU88qNkSuGXgmccc/BzTntf4F4tjuhdz41V9
	bQdzmSTh6mM0r2PvLKPPyjW4q0smY9cwuNd2TE1vZ9OBOC/KMPCqmEoVT+BV2MLi
	OKDKBWFp4u5emSN7OnZ5GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399548; x=
	1794485948; bh=ueUGw4xiRCsGP4mNRn4+jL7xwolnwZ81/vNmhBU1/GY=; b=y
	GmH4Fp4JHfXyVHeo2isxVfqm/c9cM2UYs/eritPYZYwIgGZxP45On6nYJIrN1XZk
	OyL+P03rSfMiBWtJPv/LKdoJdQR3QmysGpdGuERC6kOnyMmO2b6Sy4rnXsWWjBWh
	d4RXrugyjJl6wuzGSk2Z7ge5jk9lScSMHpqmbPGvlkEhvjZbOSGUtvIg/P27nWib
	l5NCAtUlvUwVa7q2JDYzbpwPCm5yFhdFzDhEN9RcF4lAdTNrevkhj9lJ4XZJt2yg
	oS3nmyvoMRLNXlN5hazsZpBD7Em8RGe9YVRHFgm/RXBneRHnJMV0Lh71qSzMZZR7
	e1p+ZU7jS0quAFmqidzuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399548; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:UpaRuL5iWCAiJUnOs83y7aIN2dFajyAhDtv5RtQGBzRHA6M
	M2FCXHFbOjJ+V6Pf2se+AkDD9dr152OjnZVc68qchUxsusbveFsPgxUldxJluoQH
	6hZk8pSw6GHH4UIMC3Gf/2+K8oG2OB9+Ig260Cmq+mlwEkduqa1NxYiJikbQ8+NH
	GC5lpbEit6qPFju698EWr4qM0RmDq20O9h5CQUJ4woGY/ulB/ZXydbE2kUCAKYUs
	dRrH10kQFJF5S1QHM/gVV0e2VC57n0hgBdSR0vsA9GoS/3z/chgD2topIdItoZE+
	TRHVdrn4bApdx41i/hQB25HAk0Ee22zFIzSVtZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lyYVn6UEUzn8eNmUCkGOQMn/47wPlrhMiE98u3g8mr8=:bfyVReRJ0iilJ112diol5We4gRHjKpAsvz9YDaBcBXs=;
X-ME-Sender: <xms:PF30aqYzBGq4Dc_aaJ2UZU9wFi5pkzPxJZ5Zz1yC3erS3i9tN6jyyw>
    <xme:PF30akbiZ94dxafJuGV5aYh6MR3KaPx7i2OmexbHinRePXzIzSxgPPTafb7BF_myp
    aLDYWby8SbKkTWPZo99CB1STQKAG-5ELCQNvvSKnpik6da8TCNKNuZz>
X-ME-Received: <xmr:PF30ap9J-ME_AWUm-qgwFtd9UA2HQLiIDdgA0kQCJzFvvGr_SJq0ulKWhqFo1rirgpUMaQ>
X-ME-Proxy-Cause: dmFkZTEs55qCzWsYoLPbwZcukLNmniUbeLDTcdDKMeykKEfUVEL1m88jrC01ekZ+bSWJoa
    E+sFoYwZ2KKV5gxeH/ExdGc5CSVyfPST0RqGE6Bbggl/uEHeCPByTgFXNeBnwva+Z0XW2r
    UZoU7LISJdZGQMCtFN0csNcTpVz6UT/yk7B1tHyfQIJhGE6JSSH3Khft8I3OScvVt+9r2J
    JCr7yS7gYfv0KH/6Eoau/bELm1wIa+G66GK1YjevJqlqSZiPrxhXg0OCkDVjeE10B5i3Eq
    5W9VBCcRDFn/N/p0TXUPA3RQGg1OrrhL1N5yTTXXzoA84sYsO7dJi+MFVMyScSRkiTpvF0
    kKm7mn2owJANRVAGPOKPseqdwEe1e3t1GpEtU+7fPO6HUBsq+8AwZtmt3JkT+iISMI9lbD
    NTdBReH3baJRQJK4G/LlByaGp3KIltr6Zz9x8pl2wjNRMwoiOgsMt8b5/Ebh49M2VpxrPm
    UoRyRjruvXIdnFzTV6e8kCN2lvw4w6tgg4gUVGM/sNciJiaSxptFckotRm7qEd/Nliu/uc
    hZKbCWWmOtbV4QJs8hKLSEUCFgZwbAzfxf1aUUr14MY5jXlkP/q6WT9rtZgWk4vPR7rvHw
    65LgvVb39bZjBCTUOXUuwKyiKk/ygrPrm5kfZMJCG4ApvgeL8SdjU1RyWkxw
X-ME-Proxy: <xmx:PF30arhAkEIZVBvIlru1lwc_5ZUu7brTXug8EAxDtdwCVcSy_hFZLA>
    <xmx:PF30ahcUctic3YAaCqxizPfwPnIamGTKPEPLQrnZnp7boS2K92HYog>
    <xmx:PF30aqqFaWyJnEGfsp2AyCQyFzVOAj0EaFSuoPcZLtzHbDH2WshSoA>
    <xmx:PF30auC4pyNrdRoX2FHVgbE5zrIuzOJSGH6yDW4FiFfLSD1_a5zosA>
    <xmx:PF30apcMPf9xVmjdRIpgJfMUBUh50bgwiuRFx0R18oKRsVvgDW520D-o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8860bf6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:43 +0100
Subject: [PATCH v4 07/12] builtin/rerere: turn "status" into a proper
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
Message-Id: <20261111-pks-rerere-subcommands-v4-7-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "status" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 62f69b488b0..2bcd270a1f1 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -94,6 +94,32 @@ static int cmd_rerere_forget(int argc,
 	return ret;
 }
 
+static int cmd_rerere_status(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	struct rerere_cache cache;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (rerere_cache_setup(&cache, repo, &merge_rr,
+			       RERERE_READONLY) < 0)
+		return 0;
+	for (size_t i = 0; i < merge_rr.nr; i++)
+		printf("%s\n", merge_rr.items[i].string);
+
+	string_list_clear(&merge_rr, 1);
+	rerere_cache_release(&cache);
+	return 0;
+}
+
 int cmd_rerere(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -132,17 +158,9 @@ int cmd_rerere(int argc,
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(repo, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);
-	else if (!strcmp(argv[0], "status")) {
-		struct rerere_cache cache;
-
-		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				       RERERE_READONLY) < 0)
-			return 0;
-		for (size_t i = 0; i < merge_rr.nr; i++)
-			printf("%s\n", merge_rr.items[i].string);
-
-		rerere_cache_release(&cache);
-	} else if (!strcmp(argv[0], "remaining")) {
+	else if (!strcmp(argv[0], "status"))
+		return cmd_rerere_status(argc, argv, prefix, repo);
+	else if (!strcmp(argv[0], "remaining")) {
 		rerere_remaining(repo, &merge_rr);
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			if (merge_rr.items[i].util != RERERE_RESOLVED)

-- 
2.56.0.611.g1030f0b940.dirty

