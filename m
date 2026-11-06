Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978065;
	b=M0VNkQIuDHd/MnUEyCDgK+svXZOOHJjGJXhquvEGz/TE0QxG5VeJ8nJt9OnRH/E/iUMT
	 kx8sYFYyGN3Ga/6MXdgZX6DxcrJftNzL3TmYPTI0uBEIav83msqTz/FaSWK3QahNFbLzl
	 m33o73U0wDSV8hx28ztlotowXJudlM3qpnaPcQ1EhoBVErHXTljlFJlN6AmKChA4qaauQ
	 C/7HZv9LNVwTzpmGL+0+mHE4oEpmPTS09WNxFnE9x67xkdFmfdk1oDST65WMBVUW137QC
	 PrMW78jcAXo3+B83ZmLRdFHWtusOeW97mgaWidmAGxPY/k7Et47t97shDHppkX/bLgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978065;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=q3JgkuPa9AmPqY8Ht2nYBxBBs862hRh4b71odtbyuC0=;
	b=CsPXBN9+Gdmrh2vAmX0F/ZwW0uyLklE9i39BtMa4Oug+vicKChwYbdCtIi1ZOdhvXbHL
	 0TzIcAmafjVii+osbLIKDLh/vb1TaIfJueQTWaXi3dapnVlB5DzNyBAlzoqLYgqlw6iOc
	 QX0KxnnJ7ap9w81Z7GCbPyMl6ZUK8Y3bYgX+4umNHKyyEOx/AUc26OmFqnteNr3xrxBR0
	 qD3OgLcZG5DCcsnox83gZ0a3DKjuHSH2EcCVdPpeo3iwb1vYbrhjgKv2HIh6beHbCZMU9
	 6thrGxfY7mFgmQZKO+WLcuhNXd4w8nAVcSHJ3ery+v4yxiHvl30d9t7ldIAWC/38Q6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="prpoOE/L";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PXMQYbUL;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C39606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C39606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=prpoOE/L;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PXMQYbUL
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BC0101D000AE
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 10:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978064;
	 x=1794064464; bh=q3JgkuPa9AmPqY8Ht2nYBxBBs862hRh4b71odtbyuC0=; b=
	prpoOE/L7yFmdZckHOZ/LwTKBskaVs+immjDDk3ywW+uPwhYYzJy7bAZWgX4yvG9
	5SPvVwH5nZ4Aq0m9x/MqbyrCH57+6lcIPv6WB45v7YDOSO6URBtJHsqOi7ueh5vI
	pNch5fza96vp/aUZ4d18wuNNpvUdzRnJJ+TsLkKcu78+KzIT4ZLR0/pMfYAcB+ix
	8LxIxycMKLdBMl89CzAsuWKd57vEv5L7teZpSzAULknv2V1baOT8hLXC1MOyvcDc
	86HS5Xz4ZLgNmXx94k9CnfKvU67aU6Hb3RezLN7UMrFM9KbTRGsLKBGo5HN7/+ak
	b4FP2UBQrLdmBVf3HJB1xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978064; x=
	1794064464; bh=q3JgkuPa9AmPqY8Ht2nYBxBBs862hRh4b71odtbyuC0=; b=P
	XMQYbULUIT2fWxDYPjxRvJAhW+KbG7i/qM/CXS2pU0uK6OELntdVS2/KVtU/9aUc
	hjxqq3Wdp3bDPSiGvIDKgfGM6zkrufPRP/T09EeJgEB0Dx8KIr3zLh1NUz5evtx7
	wPkK77Hf4HxOLFcvkfWPCWOQGHrjI1sBxLBBgk7Atj5eXijzjQ64KGEahekHagjT
	NzDdMEwK7k+/pULk0nncISyeH0Lhmnqm50CN7e4c9S322Aazlej33AWJvbRAd3Xj
	rSMfyjvr9xgW+QhkB3bfxFl8oF1W6FsiTJN11zsG+4x/jx3/ZhyFbSGWh/iWKtMn
	4+v0VkYa/48GJcmX1N/8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978064; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:hz9yyOdQOVW11HTqkd1z0O2ewCr91Z19qYB8FAf0DB9TCzQ
	V0cZtQbu0WZj8q7iqfz0SGA8AJxHSdsSxvOI1KNvturYZGjYgDYRuunKLrutHASf
	k7UUQmCnuaL7NY8T60PFrNWJTp9+RirqkNIsj0A0vgxJ4KrrLpuDIi2IhFJlBrUJ
	LBe5ZBbTYnbyINX5WS2vdDDeefC7WNloF99kMpeZSFDtazrVFzqfamE32A88N2FJ
	W0P9sYEorqsgyRXfBtN7UhLbftfv9WMMcWo05yGhpOmFJ3jF2hK+5AmpqxZTRHia
	xrs1TJDf1fiS90Jo0OVpEGhXH+WkKT46RiVYb7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+TJK8quR1bHrclAt1jWlHtu6MCtJp1UpSbFzbGbSGPk=:zs9tXrawOJALx9J+vFIjMxRhPyKLK6Hq8dhEXO4AMe8=;
X-ME-Sender: <xms:0O7taj8MG3VVPhmZMAnen-Bztzcfg5TziNWRp2F1LNG5O_Zk706NuA>
    <xme:0O7tamuRx3ihW-vujeRn9jbFMqFyqWqZHf_QQZ-YcYkCR3G9ew1WvYGgbeGhn2IXH
    WX1OkvCm8bKbqemeWS-AOnzW5X_8Jpq19rimMKGQxOQ7nmTQJgGyM4>
X-ME-Received: <xmr:0O7tamAaLQB9iLO_KrQHWTXU-8wVmk8X9pVpxibdsN0z2DYi6D13oROjkpEdhge3dJ-0Qw>
X-ME-Proxy-Cause: dmFkZTFpG1n8BNjrOjL9sUhDw3ZiP4mtgTk1U3/fCZUgMmr4wlQPFq/1BnXTuXw+zlS6mE
    IootibMXKeybvuZS0F3Yl3ONkICg0FdWX43CJz0MizalQ8U974cAXPiWoPbZL736ZnzCO8
    EtZYWO3+BkHKQalNcN1fXtfVzPi/xvBnpUp03+88tRsq0flFwtX3krA66QaVLRCtO0jyzT
    QGpB1Esb6lCXsgSSEoGleb1C2sdrFLHGOqn+Comvczkv/UdY1E3MphcIfbyMG6XxkZYVIW
    /gH+dST+86WdOm7ctQVetJGB/OBHpugz5WE4LKZe182sP1CEPsX1V+0sw13sos7UzXA8KB
    pyotwTv2MxnGp5lA5IHzn0MpL9MWhli3Exj6dGKjyuHR0SibcaNCkWFAi1HTnBDhO/2TMQ
    ES9xQ0bxH1UCaH9aoOtpb7tSKzgzUAivO3hdXNlJSjpuQKDNTMwE0aCrYYgsoPdsONFQZv
    Kk79mMTAJJSz28IA7xs0P8Kigy7SQWvNXFDvvPYn4WR3CxSLoA4aaF/w0rV+jMBlollu79
    3k/wXGyRI9+f65K8rv0h71h8lzixY7Hi4HOEOhRM9qjlED6IasUtKLPFH14QpUSimvpMDX
    H/x92e5x5l25O7Jl3m+pLxR4LJIZ0OWRfj44NMRrJtKo6LFNnUFq/KtbZqag
X-ME-Proxy: <xmx:0O7tauWIhgKzrJE1c1QC0ztjYeAKnG25WouIFlFeThp5NWNx_qIEEA>
    <xmx:0O7takA9o2jgzmdjBhPLtDL55NF1OSFBWFdSb9MFaqSDxO7uzakWZQ>
    <xmx:0O7tah_iHnznJkBGbqdg-uPiN04m7DkcFuv8WBWGsXUbsBHoSHWLbA>
    <xmx:0O7tarE0zXYCs5GFfPAwfKaEPcWC_NLZst7Dv7_pnnVPXt3vk_HLsw>
    <xmx:0O7tapj49BUCioJOVkJ-g5m0-tyihoSOOVifF8Fvmq79ucJ9QRTSrf6E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c543b780 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:13:59 +0100
Subject: [PATCH v3 05/12] builtin/rerere: turn "forget" into a proper
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
Message-Id: <20261106-pks-rerere-subcommands-v3-5-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
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
2.56.0.500.g5d06dc02cd.dirty

