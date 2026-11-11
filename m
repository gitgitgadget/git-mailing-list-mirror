Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399545;
	b=srjm4g8L5lf+eWTZ2Q8g145iRthvNXr4+dWQ2gyJ/GxCcN+neqMmlNUYLM5cZ0Pu1GXS
	 k3DPjkRI3hHEuYQgHUGOFCfAFw0XQyXWT/I9Zk1JrquGCID9rK2rfrGogHEa4kHZ+01mr
	 dCBpHLpuvBLAzpGo/36QFk7A3SCbh8vKNWLdP6YDhe2LfxQ9J73YdDyfMDFfJFnvxuQHu
	 aCOKt6YsF5kFmXYg4YwjKcjSbpLfR5xS7nu1htu78ttKX/dc5Nbn6lA44UqQUojk+MfMe
	 7lZY4m/VvJzp0ruRx00Pbe8w06gwdXx5r0VW8l+++mzscul6LkNCcPACLU/TYASB6Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399545;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Q1IaEJLTy9pUh/rPjP4WTOnpNcsfhQzUiC/AA7Od5vk=;
	b=tVwBBX4+59jez4uR7bV9d9KvMraRXQN13ZumhZlZ28Egod4irGMkSCkw9epYsECDUhJz
	 woGkNrCThJ79enKAnGjc704rk16LI2ko5jyntJwZalThv9dBb2Qww89nDiBVDMz4dZ3TE
	 rKPndO+rXVhWqLcqUPRMnpZTWCI/qIVQ2SieFqanbxUJYozdCDvvuzJRuxvJML73Z7bpl
	 jXxwWsdr0lAdCg8ulkTdd782j4V2kEjTILNoryEbvSCCNNZ05J9xXBXPq/TeHKwp87mCN
	 Km4t1OEYnPEke2FOvnzvTxjI5Xvs7JXOIQ4JNrpwV1OsBjVQDGw5PUnjNFlotolByIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=jLKCyDjF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=L+PjMWZz;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134C606A32A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4134C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=jLKCyDjF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=L+PjMWZz
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D6A27A02D1
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 07:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399544;
	 x=1794485944; bh=Q1IaEJLTy9pUh/rPjP4WTOnpNcsfhQzUiC/AA7Od5vk=; b=
	jLKCyDjF3uy5bq5M/J4Vln+0CgH51XRjj6lkO5YLH++OF190qcFOfYbvyRR8bZBT
	yRkZkhwiQH898F3q6WqLrpaN++7RksBBi4Za2BU2dByYxUH4IbL3Vz7xh89hlEfA
	ZxWooOfNtit8eXqWYCVUr6GnXBppJfearN6WsPlPg7lIN73fAeTM+Tw0UJcVzX5m
	MXvgFQo/RfqXrwLk5JjJ78PdOdhk7TZjGxBOUxGJttI4c0spQ4WVTaGHltg2pEH+
	kHeyHhMxFXWWNhbd+6aE1s1q//SV6rUcI4crCHsajTl/l5hIogc+E+DkP0g9T7y2
	u0x5awsOLccKHXUR5Ff0iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399544; x=
	1794485944; bh=Q1IaEJLTy9pUh/rPjP4WTOnpNcsfhQzUiC/AA7Od5vk=; b=L
	+PjMWZzUHNwgMkZLZcRc1V0wDOASbS1lmVkxWO8Cu/7G/j2XuvnjrPpalZYcaVjx
	i1x66eim+qOTSSuyg8ASaVF2oHbgRfybORgLClG2ddWfXqg0PksY2Ix9/0dnsmqE
	vhZzugDmJc7lCFhTob/l9JlaD1gic6+L9jxtpfQuzCXI4NxtA6+Ug7gxwc144DMF
	Zeyx+UTrKgLWE1BNOLTqTD457w6RS74d4I+O9aEV7NSsadPMX2lKmeuvrw6pditM
	VEutxtyMx9Q12cTuXu/izNS4vDD6qYhnbqcuTivXtCXvvxI5A3Z6qD+ppGwP6seF
	/spqYqdpO995tE9EynBoQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399544; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:UltlJVpzetirQa1z5Qun6EGX9G2W6IhKXXzmU3EeTPFDQBa
	GwlmYWcTV587cFRTvkOY+FUbHB9heMKp1/uvJ8B86BSVm+/WJd22lEXukg9hc6d5
	Z+GaCFAmES36PTsPL9fGtuFlmFOh7Tvw9j3GBryLrQZnozoX+/f/XL+v/RJ8YGA7
	YpC2dg8MJbC3x5v5lJAegYlPHu6YhhAaI7lVQk3o0KMcW8FmkG+KZVbiTPukV6da
	xF+Niz2mG0ngZAVcWfFSVdb2ywQaWyPxjNxs+tQLkvHf9dLYmBKQ3GanB0Szaz6I
	LtonQ/AlrKaRVx7aQwqlHpdYqwPlI5YDGHagGgA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DKBoqig7lL+yaBnODI5w9xwRnF/Qdn4TeTs7lThW2mQ=:CotsEMvwfRbq1bo0FMglgoTKfmFRZt6hmW9/80C3k9g=;
X-ME-Sender: <xms:OF30agElaA4Gcao37Ow8MpGBeCrF7XsaTxCvhclXbEky4Vi57_lH9A>
    <xme:OF30agVosRFGMf7_v6-QnYHITBC0SSxnXcr1TSZTv5ChHOqeIDJtbzF1sIA76RW89
    n7Boz2Ai01nXjrbBzLgEu1PCISCaYmbeU6N-9DOoL_Miew_mg7ubun9>
X-ME-Received: <xmr:OF30avLVg5RNM3RKOg-Ex5lBFbRCHRXmgPLkHkGCjnwFg7GUIZ0BDgsTWBNXZg753K-YRw>
X-ME-Proxy-Cause: dmFkZTEs55qCzWsYoLPbwZcukLNmniUbeLDTcdDKMeykKEfUVEL1m88jrC01ekZ+bSWJoa
    E+sFoYwZ2KKV5gxeH/ExdGc5CSVyfPST0RqGE6Bbggl/uEHeCPByTgFXNeBnwva+Z0XW2r
    UZoU7LISJdZGQMCtFN0csNcTpVz6UT/yk7B1tHyfQIJhGE6JSSH3Khft8I3OScvVt+9r2J
    JCr7yS7gYfv0KH/6Eoau/bELm1wIa+G66GK1YjevJqlqSZiPrxhXg0OCkDVjeE10B5i3Eq
    5W9VBCcRDFn/N/p0TXUPA3RQGg1OrrhL1N5yTTXXzoA84sYsO7dJi+MFVMyScSRkiTpvPX
    rXTH2UYJu4tXMzhzo30BgA6md79Qz0xqwj9wwGezNk0UPBW9bEYjF8ZhGmttcCTxdXaoQX
    Flkt+prTsaWEuLwRfUWDu8t256Dzf7Gk5M+1kRzbWB+NCszwNryVCZ/Oyk/RjjAZmdXcGP
    BI6ofYpOrFPFeCqs+dhwU8SSby/QHHQhi8MFr4ksxAh8ftwiP98QeHE41YcmEQ/rsf/Dxe
    iftHT+zr0XyjhOgGd4bUYKTQ6aT9MkH43JuTc/SRnpKAYCAlTuEgeeo3WnbNHwgDQKMY8b
    kazKZwDjwNMXY46mzMPuNR90K7APC6V/UCAI4pHEHGB4eaLRXwAbJCznx3lA
X-ME-Proxy: <xmx:OF30ag-SkZ5qLbLYklrAA4S54Nm2hK0WTtb0h6xTkkhvpdlEhmxEyA>
    <xmx:OF30aiLgSaKjbv4Pmwc-_Ihp5ngB7KtKB-b3ZMPcWwfackaoZ6ljyg>
    <xmx:OF30allIweKuqCHrmZKhMvHftvqHkcyBBplZDlA6hMyMsVy489KurA>
    <xmx:OF30amPXQpsAEVFlv5jJIJBTnDbS8QJKx7-ts7QqYvx0FOTrfbRVhA>
    <xmx:OF30aqoe4RhAjGyx2MmwRU99cbD8AoKb8tkgU0HSEc0o6xAWStmqOyvt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6c0eedd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:41 +0100
Subject: [PATCH v4 05/12] builtin/rerere: turn "forget" into a proper
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
Message-Id: <20261111-pks-rerere-subcommands-v4-5-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The git-rerere(1) command has its own, home-grown implementation of
subcommands. Of course this implementation is inconsistent with how
subcommands typically work:

  - Options from other subcommands apply to each other.

  - We don't have proper usage strings.

  - Running `git rerere <subcmd> -h` doesn't print the options that are
    supported by that subcommand, but instead it just prints the help of
    git-rerere(1) itself.

A subsequent commit will thus introduce proper subcommands as supported
by our parse-options subsystem. Refactor the "forget" subcommand to use
parse-options as a preparatory step. The other commands will follow in
subsequent commits until all of them have been converted, and then we
switch over to `OPT_SUBCOMMAND()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 405276cc94b..5d2ae154ff8 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -52,6 +52,28 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
+static int cmd_rerere_forget(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct pathspec pathspec;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (!argc)
+		warning(_("'git rerere forget' without paths is deprecated"));
+	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
+
+	ret = rerere_forget(repo, &pathspec);
+
+	clear_pathspec(&pathspec);
+	return ret;
+}
+
 int cmd_rerere(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -83,20 +105,8 @@ int cmd_rerere(int argc,
 	if (argc < 1)
 		return rerere(repo, flags);
 
-	if (!strcmp(argv[0], "forget")) {
-		struct pathspec pathspec;
-		int ret;
-
-		if (argc < 2)
-			warning(_("'git rerere forget' without paths is deprecated"));
-		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
-			       prefix, argv + 1);
-
-		ret = rerere_forget(repo, &pathspec);
-
-		clear_pathspec(&pathspec);
-		return ret;
-	}
+	if (!strcmp(argv[0], "forget"))
+		return cmd_rerere_forget(argc, argv, prefix, repo);
 
 	if (!strcmp(argv[0], "clear")) {
 		rerere_clear(repo, &merge_rr);

-- 
2.56.0.611.g1030f0b940.dirty

