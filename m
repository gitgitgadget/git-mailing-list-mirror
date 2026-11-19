Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088857;
	b=0xxKPzp6JlBU6vK4r5ts1ABEIS/SveX12piEx+gT7A99l7V2T7o3jHzw5sLSThJprhsB
	 DJQDMRt5UCqnQGphRi9IktNm/tIZ96M4JlQmnOF5FhMkxfX6WAnVOW+LwUiWV//MLohQs
	 TCzoayL8icNgr8TjjBE2V8SLI6oDlrQStcaVFAlhHwDkOE0oEqbpqlCDZbEvGh/5TguJD
	 TWzCIhebf2UfUpMz7o60zSt+pQeUW0fLN/3rNh+/+wC/7ZSttatY40tAllzuytHS9M4Qj
	 77yAHrHko9fjaR8737PEbyDUNcSK3RvJ+7kvZAPK7sQaDqGinKNxbwUBYGMydw6+EEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088857;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=JDqvOS2OepgtiLtf3D3jiRTSn6EwXavV78BrFmGlZj4=;
	b=3u+cTnsPz8FNfrLNs4L989o1Opyr8LE+INwto7ZOQU5siuslTkU7Zzyih5PB+ipYII96
	 qnUyIjedV6TpU8eHQQK8A6KKeI5QkcjmSrubnaPeKJJ1rOJ+ID1XwRkt3g1QQYfiFd0tk
	 YQ9m2cvHCeDPquszvLhXpo3WyT+MhMWt09TvOnk2G7KrFYnC5AsFAPmUdiO3SOpRWInfl
	 BqhNh5/QjGgj2X+O4J+nQgyedpCkndtz5tleQ/lcLtua0+MBauw51jr6mKKXmfyD+LEVX
	 rB1LtWrGRj5xTAe5CQKC34+xBFWUWEuHbaluoQejKhVUkKi048A8IDrWaqHqAFP095g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=kBKJ8GhV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="DF6/1j6T";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6BD60A260B
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F6BD60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=kBKJ8GhV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DF6/1j6T
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C517E14001C8
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 06:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088856;
	 x=1795175256; bh=JDqvOS2OepgtiLtf3D3jiRTSn6EwXavV78BrFmGlZj4=; b=
	kBKJ8GhVkvb59vqI4Jt/vG4tUxRZwhQhLR9DrUEzP97MUsJXlLUPIrith3scM6pX
	HsnmJtqeGg2sBbnPGHFA4l4k30XYPnAfPTP7i/NiqGPRTMyscEGnXFAGOirUett8
	mOajha0cmzlKnaiHb3zrvDy1PsgZzsx1KeIFlXlxXdMOSMKxgVZYhhjKP1rQSfx9
	+XM4jzb3BMF/oYKvpV/UD92pSpcnABHl5EWpBps7MS9p2D6yq8ELjrPpn0G8RGVf
	b2gOxsV69QOyCaLMaYnUnIlwqKx/aeM7ntZlTU+fKlZCpU0lbPZ8kkRk6PuP0+GB
	+wawq0KJWBB9GGRJVMNFIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088856; x=
	1795175256; bh=JDqvOS2OepgtiLtf3D3jiRTSn6EwXavV78BrFmGlZj4=; b=D
	F6/1j6TVUTFzfEDPKfN4nA4YdRvcpVEb+oqlNpPppcuICS1uqZuojJA7/D6l9SyP
	HUq96zkTt3h+wn833W+Mbp2aPDj7+w+dlGpj2DFiz0PzgGpRHFjbckaxn/KttPxs
	hn1I3OYH0rcc0RLnBojbvLhatprETNhLDSCVVlEQUZYrj0IeEWNi5ly6Nufg4aG1
	txzwCZwpxgFpXU/cb4OjV/tGbbtOGLdHtyD/MsOFybXk0sn19cxBuXec1GNJEVFk
	Sq9d0rFEdl6O0354BazFCwYTLsZXVL7Re1f6eHAxSbACh1njJ6wxef9veQCWu2Jl
	VO6RzYocW2sg76MWiE8TA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088856; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qePfBD+Yr80Zh+YqCQ/lDGISyP3zym2zljHBRZ476QptYkI
	fB8zakSdIiHMdSnUrWrt6z1LwjHgv4xb9bdALJ6rpSEfUMYLs8jFxMh4kazUk2lO
	UmZfrJl2dAf/jTmEn0sVcQHj54MzBfGl7XZUUUw3csPv8WguIWyvgmWUMzbtRwwB
	O2PTh7Tj00iMbpNRnPqNuJlYwCSTuLXHc0/axnPQNPrBvxnAB4E52WehcW9mNozP
	SklcU8CJ1LuvtOiP98JMjkqF2OYt6l4SFhxKvn6bhL4aLOCKUdF/LO76d/HH36zD
	Y2+ifPALVmP5ln8dzF3Li1B1Tk13ZpUlKtCmmsw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7rRCqjBczAG19a0D8l2NFSgDTE/VR/SDkYzujw3WIs8=:7jOBFzshyiiacp8kCemMpf1eqbn05crcxgKOW1lGfsM=;
X-ME-Sender: <xms:2OH-ai7CxWLZ_xTkgzcrlyWsYILSA8webIIQ3QhRXXALEwAf5S68Mw>
    <xme:2OH-ai7CPwRuB4TvIUY7WljoIV7h8UkgraAdv3l8iJ8bTxIN-jJNncx9ii9wDVmqb
    aY1h84UrhhDdQyirNDZ1UAiHQ7q_FBUMLXAbVrW5mGz3oTxzPm80k4>
X-ME-Received: <xmr:2OH-amcP7Wv8qkagtYqPf3T4wb0vB7azU0QRz8ICfraPWOK2MxafUlFQGv5Mhpuic4MHrww>
X-ME-Proxy-Cause: dmFkZTGI8Ax+S5Me/90verxaIn26rbOdrgBU+Z55rUVHa2b94Uw9RFz5Wwhmi7v5FyLB5w
    6CHi7eXpcybp/lMu+8oIvVaGsAG8FArC//0h3DUnt51RCcTAyw6geuQb2O0CLwNQiDqTkN
    4XNJOBsfHpNr3iXTWWDaOnMpPdw+FjaMvgx20Vw07k2LpW1RKCl7llTSsg2R6N56E6dioE
    nCUNXLemFL7+F+fQt0wGtivP4IOCMI+AhDKX/Ku8nuNpH08fcCqlj3oDJUcg4Uk+6ly+Hg
    V51mzZENE93LXXI6tKTalM7QAOYM9/CpD34P77bNggn03kN97mLPQYLRXFC/FwL0RV4zoX
    o+/3I39RZphu20788923vTRf0ufF5yQr8fUtVnAKqg4jaDJG4WrsKFCGTn5wyos9vfj/Gx
    /9rQ0vBoNfY7u4xvpdCAa90M07dstKbW4VgwtmzhJQfNZDaxginN4b/NXrTgjOpOqJtzG4
    uAdhYRFO1j3vzzyjTZmoj8zZYBbwXhFIMVuGdfMU08Z2NeimBLVnO8vBkC21QnVK/lqh22
    /4fxpb1phtuu3eG79qUBOxuHT5Y6spzrZs71xkqQcefkpqX4YcclvvugkGRh+LYlL58jC9
    9Asn//89WhDekAzhRHy+uIF3dGhsPeRJfXSHoqLU78PDgc6Sn7K5HjX20ejQ
X-ME-Proxy: <xmx:2OH-auAm2k1426TaxF-lKvxCE5zRVVm_WCD2NksrD4BIJ9tOrUzuMQ>
    <xmx:2OH-ah8DkejD0GOgjd1Gky1id8ZEx879XIx9jdPRO72RYD2hNilHeg>
    <xmx:2OH-ahJ8tl_ITOYanZgcPfWSy57TwphOSTHr2PLlHyaTub4jJpDNIg>
    <xmx:2OH-aigTrjgTn4Vyj-uFJnAeMMBy7xpRmn-d_-nWPM1Gs0xq20yBaQ>
    <xmx:2OH-al_c7-0To2-l3PWyTdEvJps5Lgjwsc4K6YcLqB1L7unnPp8kkL_5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6f3323a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:07 +0100
Subject: [PATCH v5 06/13] builtin/rerere: turn "clear" into a proper
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
Message-Id: <20261119-pks-rerere-subcommands-v5-6-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "clear" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 5d2ae154ff8..62f69b488b0 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -52,6 +52,26 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
+static int cmd_rerere_clear(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
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
+	rerere_clear(repo, &merge_rr);
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_forget(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -107,9 +127,8 @@ int cmd_rerere(int argc,
 
 	if (!strcmp(argv[0], "forget"))
 		return cmd_rerere_forget(argc, argv, prefix, repo);
-
-	if (!strcmp(argv[0], "clear")) {
-		rerere_clear(repo, &merge_rr);
+	else if (!strcmp(argv[0], "clear")) {
+		return cmd_rerere_clear(argc, argv, prefix, repo);
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(repo, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);

-- 
2.56.1.831.g720f3f5937.dirty

