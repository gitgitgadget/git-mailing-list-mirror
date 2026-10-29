Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267867;
	b=Iw8fyEPEGNWjrOMbJKEGyTS4ZAWBAsxyy+gnL5NlkiNhkWXngBmVhsUdN7gDsjcg0EPJ
	 tFetyRItvnW48yjIv/Km0xPFq89NZ/J5mU0IDr5xhzgKScM4u+u0mCyoz/BLguqFZHzgY
	 P7FI2oQhBlFVaxpWk3J34894DyKBTwzi5nIeK5KYq7EPYrAFUYAXN5Vi908Gkv4BtzRMQ
	 hQCak7UUJFIcV6WCGijiSkJUQ/LunxjtPI7BGIfMy5h4UIbt1kM/uXJYT1P4viV1bvg0v
	 vnma/ISOxPbSh4Hra2B9CiwoVdR18DoVObmuQtCpXUt98FnHiZ51xDEkFWaCfPjagJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267867;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yUhTtN+SIPqLurpWSRD39UAnE4FhnrwXMVBM+BDl1oU=;
	b=DlPGl74P5lFpduKfJrT5ypyKfRCpfh7nwdgK7gHnrRetDM5I3utbamsqCOAK5gkZ6kvb
	 5yML2IIkmiqzm8OzLKvo6t2xWd3Daw5PDKzUcViPp48I7DrcN6wfqg7phO5836lAvXI9L
	 LvdDqotCUXIUb83/kCHgzOooeDofVspeo+f7Hz7sDNnFElDr1kfJB9DLsQNBQDczoxqTd
	 12cxf79nDHujwm02AHLw/9ZoAllegndb6F802s+OiYwxqUrWNifhTfRTDTKtyt8eZsYZx
	 lxzWIQH8PX8EZd8lWBQPGo4knpA3GP3zQgL/XXVO1pfjm0cRHTn86vkiasPl9gxjwZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uIZEVjDq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OgO2rFVL;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D3606A543
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D3D3606A543
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uIZEVjDq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OgO2rFVL
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D2E681D000EE
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 29 Oct 2026 05:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267866;
	 x=1793354266; bh=yUhTtN+SIPqLurpWSRD39UAnE4FhnrwXMVBM+BDl1oU=; b=
	uIZEVjDqdNaDA4i8+ixuK7HCyjNB0syoxrQjA00hrMPuL8VkYR4kZNcc3vct1WnQ
	BnwenPgbpd3ZsaQKX35s9ihKhVI6JLSvboxU9vO/W7Np0/dh4+rwNp/OTTHgDqEe
	a3TzeOc5FrNhmC92Qb7Znfs7Es+xVycNZkClz9oCWYnYTetfFAvjpiiRyRquOXYh
	tYiexfMCSw3RO/Zda8SvQ6bRrJd/isBsF0pqZ7eTHWoMkBj70shd76wWQBCmqDwj
	o+KKdmlJj50oSigpFOZbaHIgIeGk9aVr7Ehvdhdv2NKI05je1gJvr3nD604wD/1T
	sEwFmXr9BX2h6PEI4WcoKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267866; x=
	1793354266; bh=yUhTtN+SIPqLurpWSRD39UAnE4FhnrwXMVBM+BDl1oU=; b=O
	gO2rFVLeumrAZG+/CQzwyuK1qcrmqOL0qKoBcbmy26nUwvaQs03FUzeO1jjXtWVa
	5gvUKZ8zxPcLI7d+7PImU05mRCjTmUdmmHL+isqzzyeF/q9p+YggeTotmell+8Rm
	IajKUeH4sQEvNBgbZ3ySP3JTZjv1x8rRei0F4vF+powu9yJT5zIOO2eoKhZL3/7X
	cb+daR/0YgWyQplbEgRyn3yi/Gyp6ad3Pboh1HE5Haa1hxA4pVNUSgIg4d5aT/O8
	/e95RMkvgFz63W4xDx7B631AjfeUN/ErGHxLOBX3cbg2adWQl8t81A/veUZNbSo3
	urfFNtWH14JOjxEIYyulA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267866; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VI0ElQEIOTiNFJ7u7XxC2WBCT65mxZT6TjjEsssnn+c2dT8
	TYC10/jh/USbqSYTpXQ7KTT9wlHR24V0BVI74dVYjUYyU3wnfdLrCNMeue65PwNC
	FXqqdg4GlVnX+ZsKBfK5q56+oRNkYualdMJBJ7tDiLZ+1AC5UE1FGGRX1f65mlcw
	mz/LUu+4F1RSlLTWKrmbp1yQxvVOAuBA4DW0Fo4pD2cfrBpzrnSFw/TkXg7WNJak
	iMDeJ40AnZsJPq1eaFZEOhNyCo/En2E3hEmb6ps717ZKtjagGA+VVC846FOvHesD
	Wa96zoXZ10tgB5SX9gNswZGhMAN9t4wuARz/p9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Tcg1+aK/0ljUeVwdBqsoXS9viZheIIOouZIViQFI5iM=:rNMtZZW41z4BXhW4KcF5pkAsWICZ6SwKX11E61KF8Es=;
X-ME-Sender: <xms:mhjjarZ9LYGhlqqOpzu3LsSQC92vIzeCM5y_hrdoYbMXzBazrUz4Ag>
    <xme:mhjjah0C6khl6i1fGfPVZiwlcbSlkMyLaYCT2rJMaeNkx9b9A4hQAyM1QE5dRukL1
    R1Boqtr5UF_cN_jpsKEIofd3ekq8lWm66q0HPISKh26XubAOmWmONQ>
X-ME-Received: <xmr:mhjjarX8wpag6kCLtCfN66XYQZl_qAwu3o3Ty1y3f0-LkagNQempUA>
X-ME-Proxy-Cause: dmFkZTGN6oeJR7otfSSVvdw42gSnuM/vOiOuTFBIRXaaTX+WyfNptir2dKNLWXae0Ccg/H
    Dw0kdIlCEIriHaB/16Z4yhETxZy9WpWVbCV5No/000ftN4GNucPScoQ5KkAWUzjoZWT0y/
    4K+z8cN8RbbwmEbCVA2o3dxUR234Pvg7fa8zCjVDYwZ4a88+TvOSFTJqaXKepL5aLugymQ
    94eqDXIHH+KgCM/ysQAVHXtzWZ+jp+UH8ANfqy8XQANds0O69Nn3IcrRQjn65hWQ4o24gk
    +sSNI7PSlqQEftXcXQKG4q+6scpPc+oCvIFhg4XMKrhkbLuMtLc2NHSNJl7zBq44s+shie
    1eWfnDV8p7oYz4BiHW1QkPZxJl9QoxWxuePPBaCdLoYNmRMUhfP7H5iQh4jzMnoZ6U8uPi
    +DXwAmA9NQVCRitFLp76jrdrVVhveKHHUTE0wxEkKjZ+9+5/nH8IF+etGuqXwCIf8smbhs
    +x0BkH2UMOW9KYctqFyd3SuNFzyb7dOOmRmqrc05v2cGsoMT8T6ZNAJH+khTaAi/leGtEl
    gnh8Wij1QzQ1wApKuDsZl8+Bb43Uy4ItPrLsE3xJ8oEKfvzZ5mEG9rEcJG1/MRBRf4IZm1
    4v/fgM5+V9+6p9afYZqu9mFZDPs7rk0TrTrYXp98zFHribbDNeWZzIlpeslA
X-ME-Proxy: <xmx:mhjjarW6tjUPt--ECUQ9dZlyn1fPbYzGDMBxuj-koJ9G13lPVUeu0A>
    <xmx:mhjjaqeYyYlGow_ap4zWb3aVzJ15Zsty9Ko9NUQZRfjVUOyuv1aR4Q>
    <xmx:mhjjakWKgWAb4PnGhTKQoeB_u4OxOTeKlSNKgOXqlUEYYR6Dm8Ag5g>
    <xmx:mhjjajfn0DR28NJ7LUVMNXmngYApGymJDgsh5irowoyigGL5rOEQCg>
    <xmx:mhjjap_CKYHIaIjc7ubhCcA2cD5FLFZ5dwPgNxofu72vc28b1kjMeeWs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d392e83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:18 +0100
Subject: [PATCH v2 09/12] builtin/rerere: turn "diff" into a proper
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
Message-Id: <20261029-pks-rerere-subcommands-v2-9-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.56.0.341.g393f52fd96.dirty

