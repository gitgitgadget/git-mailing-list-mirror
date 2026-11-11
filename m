Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399555;
	b=4Ae5Yz0MjcUePB7KqUhx90CLruiY8q63D4YZgLji37zV86XBn3TjpS33IBkcbFWOdxP4
	 DVLUmRYgJUVqjYQ2Ls2XUVG/L5xjkU0jSxPmh56ncMLVOSSksg3A9DpVHaIE92+S3v2SS
	 0IrD8GZ3cSKFyN2MoRWiwK6f7KDLqWI2zciDmGYC9zoTzMCKmYTaUr976fHzcAT3LLm5+
	 2C2a2mM78b9MmpSoq6nx7nJXdyF2xp4Sa3dbmC9zxHVD9lP0AucwAklIf2jfbaUNS8ZCa
	 1an/QHAiFiDpICU0RaKkrMqlXld4/at97o5GqNm0ejXAq5NUQ1epwGJtBsGQPZ4pdDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399555;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=noCUwrepe3OTnjZtSjV7XzVq1yTaXw2/mQjIBD87xOo=;
	b=GzTBtLcMQpYz1nr31SBgrCb9LnwuVgxWbbBs65W1fuyWkjB3roMqZktdOnMB+rwapXpA
	 XP1g7VMgAbGyy/l3UiKATCqXsnXgMZhEzrNefwVqZ6Res2WFdBRD+FtX5G4HD5pIrobn2
	 /EIM9dg5hqtk6WINQgZzAu9pt++aooh5W4UdzTnWQzXpmhYzi32jEOOjUt4wXq9aX2TtQ
	 mXpodhMqct8o8Hya42FNJE/j2+wIqH+Q6WwlG7OiFsR2pBTPl5OA5cl3wuOyQVqunda++
	 HwMG7hH8/MzCvhlxpigUxCaNz4UT/9EsEhm3WjM5cecj1gXUZH4PkuFwZ+nF98vYZTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NJHscttP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="U/UfzMCF";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D6606A89C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4D6606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NJHscttP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=U/UfzMCF
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B80021D0015F
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 07:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399554;
	 x=1794485954; bh=noCUwrepe3OTnjZtSjV7XzVq1yTaXw2/mQjIBD87xOo=; b=
	NJHscttP3ZpZn5Q//ZY7rLpqh/ztuBqa37NWXF1yuzoIyr58OskH5SMn6gT6Lat4
	v8sWEkqHybLJqPJpilQKTaJFpSGk5q5qPfouxrnVloyKMT3YHdyw2oYuR8kryG5B
	Al+tX4NNl85Y4w4PocRDqOKim1fch1zMTzbFxomw0a8yLKWZTXIvkUvkG6CbSwY8
	XZkIzQh3r86CskGGTWyoiSUIZNzo1xJqeuPHJJyK8bBPHOl0flqqTFmwVqAYJPlQ
	mBTxk8eLjmu1lfoAIZGNAPwSbn32SL+mK7Y9ChDfD1CntOZYkW1zLp+QEnf+/YL0
	u+RxUvzpXW3h4DVgzP5cyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399554; x=
	1794485954; bh=noCUwrepe3OTnjZtSjV7XzVq1yTaXw2/mQjIBD87xOo=; b=U
	/UfzMCFMKjRwJ5Z7Xqf1qzZL2K4hBZBHweM0yr9JWAORQYi7JgTio1dlYJgptlNA
	JjxGmfgnLhtofJquAArJLeVG9Em+JMamXwkBvVuJfs5ATwZnqUCkXQW72yGeO1A/
	wFCGyggjaPBTMMD5sxoWxoIAzBGYBzxTtXxbDfvXnXFOtkwBwiaAcSZ/Pn6YamGq
	Z8zbmepAxmUMN0E4yFwv6cRJKbUkFY9Ccrt/TpvgADiAjiSoU8LVkj2jPavGEnpF
	zvdC3kB8xwdU1ZpF9kIiZELWOW/ksBN/MZaSiAElpffdGCkTgZBGCybLe2rv5A0s
	7+xWTQ/xRJJcOTu8eJrVg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399554; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:JOp7M9bm94gMjOH8KndlIgT3zz5Bp/YA+XxNXvlWYHVsJ1S
	+FOUOFpuk1N5LDuJHCNk7WisF71r+M6sLIYjFYtogubedwWeccfNfC5O9IQc1/X0
	Q2b5KWgW/1T61UwhsX2g96Jtwa/GiOxRn+yOxRzcJm7RRf+iC73j9ts+54P406/L
	VieCa47IsRqVpG0i3MYM5timJZfRi0B2KGdUGIyPHVNZ46XoNIAiQi57hhPjVPQA
	MyUYhMH9sJco4MhduEXCzNwNLo1w9Os3jLV870k3glvtVwslALcSmG2b4PrFQCV6
	RNgISv+a5yxl3mZLCL80vmDptlmpjVI1udfSZPw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+Hz/vbPicvNGu3CB6LuDyIJK9XYVLbyHMDyBTlz7lh0=:dRsqXpKSPZ8ceUpgWVR1QUvbUhsK6w1wjRiGvFs8meE=;
X-ME-Sender: <xms:Ql30aiP86cFOPzeNzygdaBfhExWdz4cy8g9FREL0D3nFkDKgwGOBEw>
    <xme:Ql30an-NmvZV56bYpThwJK4eRdiBMn7Gmb2Y8zCgMeRYkn--MR8txAMmtxmivsxD6
    MWSRd5IOQ1nKqz1aYy_M2bfTfRYo5lXs3ffGmO9gi-3rWc9L8vteLE>
X-ME-Received: <xmr:Ql30auRm7NvLJnrczgKmITO_ga05CVrJ4_Y8LiXAdETvs4KbBT7qDighDnshR_P9CHetBQ>
X-ME-Proxy-Cause: dmFkZTFuhAB5PdyJNuBE63/SoisnlKMhtgtIHRFR1CCfMdGUdfBlPK8bGmPaGwRFnP+n1y
    UUkz2cGZc5iNli5VsfLoQNuWC6g5KKtP4Wz6cv8/p8Cv+ApjJt0mfuLW5OT+nv92V3Ohf6
    Kd4qE5DZFnn3YPYV80AocAEW4/+9MoqmlJCjFkaU8Msgi6/FIx6/1lWqUw4QUxZ6vN/Kic
    y5F5ts4A7RD/FO/hCgE9o/YkPGQx7mHWrfDnVH21l1FRqn711ITvWcqR1m/Vdvix6wnE+y
    SARMYLBHC4hSahezc2fnJAlADCXHu9KhODTX8YRAN5grgoBj+nbp5tPG8y7FW3PgaBdOnR
    /9fpMPXGm7bOTovMkG920ybUIEvVeO+t7mNRGsG1yl96BJhtAwE9NYTdnM+NhCN+uYIjI5
    1oqlfur+kBxtfm+mg+xNclPPO3Z4hFp9xGPw5b/dtP0h7GDAxZmQqlJN7Os7Guc3fyl0CY
    7mCLhPTtpGsTx6IopN1chIMyKWcDMPtyGmg8twKEfIxvEd0CPZnQZpr3S+cNjv7MYtdcn6
    trWE27uDCchNuk+UqFDGytBfWwbsJOkicVkCZb9avKZ/gkxvqJjoP4nfTwPXr1a4HOptb0
    JLXv3SYO/xR+MqGpriJB6UtyKeTmWDlObV5hQZdGx66PXVBtw+gVAERBSiGA
X-ME-Proxy: <xmx:Ql30ahm1aHNOvLnOuJH-N7qlVIjtN6AGPeD-4I3ejs5VOlh2NA0h7A>
    <xmx:Ql30amTHloTDb3_1KQf7tmZ7z53FTLilIjMkvGJ8uTr3cRRikQSQ7A>
    <xmx:Ql30anMLHcLlX5xRB7W2t-Z3DxY_FrdI0enTTpDeGad_8dO1OToEVg>
    <xmx:Ql30anVFlo4iwc3fx5_dCWqu_tCFuYFqaY6k-mJqjGJNDqoNYbxlvw>
    <xmx:Ql30ahySG7bnLjkmnMeM2xNmkjbcni9BHLoizfvHNO5nsFvf5fLp-Gvo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd2a5b23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:45 +0100
Subject: [PATCH v4 09/12] builtin/rerere: turn "diff" into a proper
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
Message-Id: <20261111-pks-rerere-subcommands-v4-9-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
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
2.56.0.611.g1030f0b940.dirty

