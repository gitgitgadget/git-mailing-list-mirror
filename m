Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088866;
	b=nzeO08iAmPjtMyxFwniKzAnULxBZ5OTBHpJA5zjZPHkfITnNFuWLvOxRoA/ShexQDSOI
	 XO0w7TvZdOG8IDbwPx1ONNDu61uhVszgRvGljw8Q6YwnmnhXPLAwreTHF9O7eG4N8bhUJ
	 /37rsOHK6B+m4yI1crmIcffeAb/OPS/hZV9jjleEN4JVwa6i+GfvqkCP1gcD2Gxf5FOHB
	 DYBQI3kKCTp6xnYTo5QYnYxyUJIlACsXQ5FST206uMtTuL4k+EK3bTXhu0JzgpGUZCkz5
	 QSYhObO2CoBKoDOn8tZrrbSccO2WdDUSGDxCsBsXLDdi3NMX4UvbdHtyMuIg6cgfn2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088866;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=LS9mBcyd8Ww8zlehdyaoaBMx34s4yAXOgpa79euwBc4=;
	b=2E4g2vrfAxVtmoH+Tfr/6kQ8zSPrWl6uwmDf4O9WwgAe4exvd8S3V26+Q0oDUmPgoJNa
	 m3Kyi5g+QiSvnJHYpByuUEnRRZZ0moDlbUconKKbrhDBJrEd6mFqqy40J65WB688Yjubq
	 2qRpqD+MYPN0dHKVlPi8wu4kidfwNAdTnBxUuteRpOJ8+YVisvDjFDCRC4U5ei33yAc47
	 WaEGyUJ7XXCosqYQO6xCI0wqrt8OcnW/tOG1LjYLgmvs7NMNZwY6LQPcq0qm/+/8Yrph7
	 Y/A+sIrPdlBfKGoNaVpJd0PXhEsCucXSDCzjvTj8idBpiJsWosgwk0R2MDcaL3zQJ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=G4DO1Zgk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kW6z5cC+;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015E606A326
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2015E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=G4DO1Zgk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kW6z5cC+
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4427214001CC
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 06:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088865;
	 x=1795175265; bh=LS9mBcyd8Ww8zlehdyaoaBMx34s4yAXOgpa79euwBc4=; b=
	G4DO1ZgkxmzvV6SPGefHIKUva+OiJDmYANh2WWteZN5n7GtvrRIZPBMAbQdgYDTr
	Wb7VnLvSMy6mkPfrI6REMymt409EXKdAv9xtaL0jrQju9WaFzerKjSSGs+X1KraX
	iB6gljxx9d5yYnIPEuSd92I7lYx5iqzIOZmI6VbPHcswBaJgd/kiDd0VplURsonK
	TpSCxHz3UrrFtHfzTdrUlbFCOxneuhSZ1VyzmdwYTYCVZgm6QZ7czK57IjpUGqGH
	ootFAppDmkT0nQgUfAt8xuDRwO/h2vw89Ey+Fc9MK5MRGK7NRAiSSnrLyh+bt/10
	ep9G1fIB0nWZ4wdT0ulaxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088865; x=
	1795175265; bh=LS9mBcyd8Ww8zlehdyaoaBMx34s4yAXOgpa79euwBc4=; b=k
	W6z5cC+NBvpeLAhIKvN/gJsSAuhoFDnnxTGXE9NWz7OYRC6MaEZBDeM/jXTbrbuG
	2UJvXwZk6n3zrsoxEuqxZW/TZbSXFAJN+9HdswrYglLLx5diZA3JSe/ZdRGe2pg/
	JFssFE2kzmemow4kU9mi7qcOHvYNhFTi0QkJVZD6UVuL1g9rEf3SeR557ULfGHfe
	uey3H114GPnmpXoROHol3VwDeMXMbdbdleWvB5F+5MerZY6TK1XYAd3shiuSBcX5
	xhI9TDBhJp/bhIVg8v7D/LNIoJm7q4z65HxAg0tJdRLZ71p3dnIVkN8V6x2slv7L
	W6ZKNKIT3SQYHBPsxTNAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088865; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:V0GR5EsAYy9t4CNx6EkO4y1jjj06qoR8jR/Qmdu+aP0CSd1
	nn9oPkgq3Rroj8B7ncYEdfJrgEJoc2MmCyGtg4iW78LA0Gx6wAGJkTQPSkefyzWm
	aDvRAMmKdqZAN9jRTkR58SgnX1EurfNl2Jv1nVwiRwipgGB0myx1J6w1lwJEFx3H
	Adv7/yJztxRbHY4h6BlV159U2GyGXiors98rpxwukZl9fFttKaK6Msn4c2XcHyYN
	WitRammIz/h+jXgJFTMf08t2R220b9EIg7/8FoSpAh1oUoDCcH7pcYn0jUv4eWGc
	pT6Qf9fk6BGG84tBs507syma06xobZcFPJsiPtQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cutoe9oVWZS/2c15/VgGBl8ixmhtltYxHD/ZEqrwvDk=:/7Tz0qZxl19dT4JxOHA9Pq4vetqBadfOvN0kwI4odxs=;
X-ME-Sender: <xms:4eH-apOFogrzFQgShg9rAdDLeea_nLPXOYTbwJ69Jo_CyRuovX6PVw>
    <xme:4eH-ai-y54t-pNSUj0nREOKN6ateREbwCMYQa-UlpoqnmtmIA90lUcKiu77plx0_a
    mtvkNJJhaD6H_YcD7jbSryMpE2oefA94KRC1V6QVPU7oXJeho24EQ>
X-ME-Received: <xmr:4eH-atQl-y5LZN4grkOqNw2oMx_sx_4HLbCjV0cnfElERkcp_31n6ikAmtDlanpvW-566xg>
X-ME-Proxy-Cause: dmFkZTELVsZREdTnER2gLE18bSaIFN5VysZKL3WgZ7vClMVQyCFzeUJhOqrwdeY6KmZNWZ
    In54E3iSZkQu/6o2OJCZ/5ja1RZEOu+aKKWVExL2yHwlAbFRDWsL5jrfTDW0xp6uF18x0v
    7J6tdaKDyizlg/I+bgqcWw7CNTc9x8NvnW+yolcDQY45t1AdVjg2a/HRNdv7E1U6DPr3cL
    PzUIsIk2dvaz+8eBiZm5s2S/a2YVw97J9J/BQFzRAj3Aq16nljaK5a9OVk1NfShyGW2dLN
    Hy3XSiBifYywVMJ0bxILOpBXyT7kRFKy6PQ4DXvczGtCX6uHinbfjxy3+JB5PiiAivdVRI
    VVRipP80nl8MOg82SzkN5Qwzhhzq6fD5Ky9qX0xovmhJ1EzSGSlewdi3IXI/oPe3wV7pMb
    vsMCTcJ/0cBgVE4O372RjFTCaRe8G1BYaENruqle2e3SEEoKA4VRntOVMe4mXJ8A2QOyOW
    Dj9RdbkAHV3A4YG7BEox56mdZ0meRUAuIqkAEqhgNllVor8t8Rs4fhkI+vhAd7g4Yj1DZK
    8VI4x97WnLarjaR4v6LxTXQ2mPUqfV6vIHRqp5M3XCtkLLlQ1yWKCie8Z6++zCuhoXTtsV
    WOP8YtKPwbbEB2DKphmOvWZ6aFy0vvykrq/qvCffDlfO2gG27zf+zrlx6rKQ
X-ME-Proxy: <xmx:4eH-akmhezWGKNxAjcz4rELGj2My-wi-BQEqtz71QJK9Yt2-9XVPaA>
    <xmx:4eH-atR3GIMDH07itA0e_Q-PSzyMLDBpx-AMeAPif45kM-lLVWmrNQ>
    <xmx:4eH-aiPLGWtUZ_k1yMTdcuoUjXLI3876zyusp7DWSxXBnn_B2FM38g>
    <xmx:4eH-amUDrOwZ3Iv9GTK6-9c3TCZgluwoqxRIeFPdSSmPmaFt09LFFw>
    <xmx:4eH-agxdhPI4P-RXil2XBvBYntlVqO0RYumGwq__-cegiyWZM6WlFJ4s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 248f6524 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:09 +0100
Subject: [PATCH v5 08/13] builtin/rerere: turn "remaining" into a proper
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
Message-Id: <20261119-pks-rerere-subcommands-v5-8-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "remaining" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 2bcd270a1f1..3f82bcbeb10 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -94,6 +94,34 @@ static int cmd_rerere_forget(int argc,
 	return ret;
 }
 
+static int cmd_rerere_remaining(int argc,
+				const char **argv,
+				const char *prefix,
+				struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_remaining(repo, &merge_rr);
+	for (size_t i = 0; i < merge_rr.nr; i++) {
+		if (merge_rr.items[i].util != RERERE_RESOLVED)
+			printf("%s\n", merge_rr.items[i].string);
+		else
+			/* prepare for later call to
+			 * string_list_clear() */
+			merge_rr.items[i].util = NULL;
+	}
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_status(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -160,17 +188,9 @@ int cmd_rerere(int argc,
 			  skip_locked ? RERERE_NOWAIT : 0);
 	else if (!strcmp(argv[0], "status"))
 		return cmd_rerere_status(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "remaining")) {
-		rerere_remaining(repo, &merge_rr);
-		for (size_t i = 0; i < merge_rr.nr; i++) {
-			if (merge_rr.items[i].util != RERERE_RESOLVED)
-				printf("%s\n", merge_rr.items[i].string);
-			else
-				/* prepare for later call to
-				 * string_list_clear() */
-				merge_rr.items[i].util = NULL;
-		}
-	} else if (!strcmp(argv[0], "diff")) {
+	else if (!strcmp(argv[0], "remaining"))
+		return cmd_rerere_remaining(argc, argv, prefix, repo);
+	else if (!strcmp(argv[0], "diff")) {
 		struct strbuf buf = STRBUF_INIT;
 		struct rerere_cache cache;
 

-- 
2.56.1.831.g720f3f5937.dirty

