Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978076;
	b=iI6dYgdxKdYyC0g8H9kcHXsN7FNXDWtNwwA+48Oj/VOBwaXfE5ppCTkrlDiK+sqNd7MA
	 9YVWfvd0ZHucNGC1q9aRTTNTFaKnU332EsGiBptEvR0AjRDRafxpTr+GwU5g3IVILPdU2
	 o2jKv0/AeZy3ytOZ0Gr/246d0qrO6scUnz7u0l3WeVmrogelyNqCPJVFhNbiTgUaFjZFK
	 9ZFgEMBJNYaUWs1KQ8WuzAb8Y92dALFdfFC81Lr++4znLyLTwu6Y9S2HpQouEj+CSzphe
	 tTXFrREvOWmS5prFmVMWsrXYlDhzICvI1moe8b3toA17dzF91fzv0kT0r+sIOWeFW3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978076;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=PGj5884lZ0vyB3ox7oEIgjyl8cz1nLgNIK/DG/Jh8/0=;
	b=Vg66bjag172FWcMhbXdENWciPN522obcKGOC0EbeBzChJB8/Ir3xz6CQD8lJh8iwP+ts
	 k/pRyv3qwfvit/E2yUE49XjvcqwjwLzsz2qgmmJOcL5Tn3zDeKu+B1FMNf/gp/q7mYTy4
	 U+6g+SANj520LaN99EoVXLlq2cqc3gkIqrkxWivC2YNlffVleGBKrff2swX/PAqtIvwcw
	 H0ksxg3yBbvQAhryqM31slAtX2MQVCyNHtLgWb6ov91DoeMStZNWk3Psey2cM9tzA7JyZ
	 UrUopHqOzsBwWK9eOsKcLpUKBMMK5r68W4y1uLe8wrbd9gY6BmaunE9Gv7xWtvKLnmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=a2l4Ze9m;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WwgqbxoM;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD124606D812
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD124606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=a2l4Ze9m;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WwgqbxoM
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CC597A00D3
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 10:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978074;
	 x=1794064474; bh=PGj5884lZ0vyB3ox7oEIgjyl8cz1nLgNIK/DG/Jh8/0=; b=
	a2l4Ze9mvXDDxMKBc34D66JNYZ46XBFTvefJ2+YfvKYaLdbwIX4/MlZxlnqD/r2y
	9wlGg7PqqRbGi0JjPQM/S2cIcSNNf0JHxvr4pzS+X2e2O0dt9i+YRVICx7Smzz0I
	TgTAZF7yE0v1VWc3NqtCBbuyQcRC0WPZeBGoFOcSYDlJTq8S+MgU5uhtRjddV1rZ
	IXOeXoB6eb76AExwxgQQ8sXygY4zVAfSAlUudvlTFChZP9ihvu7FxUMdVezBhd84
	8Zy4AffvCakbgupQL4w0jWUgJ4/HMVdjgbPA2sSH9LObFBOVnmhv9cZzVSUtcOlw
	yiO+amftpCGOpTwjXeKM3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978074; x=
	1794064474; bh=PGj5884lZ0vyB3ox7oEIgjyl8cz1nLgNIK/DG/Jh8/0=; b=W
	wgqbxoM9Un0N/Hl4MWYnLoyacr9qItafT2WJG5Ma9x6/TTfJ8Ct2KNUQ+JIKRyvP
	K2rPkRL3tBzN2N6bHJ5biK0V/EF9R7OLkFZ9dJpgSA2gjqvoZAvrRiPKBrfytrrL
	EWFKyo482F9SqwA8/J0fodb9gWyxEosQRAIWLHJKp+4hJKvCDjlxMJGc9PaCakWu
	m3sqkgTgilq4/RYxOfN3XDkXU+IT8guqkK+h0wuz9D2oS1XltJSdZpH0jlJAwPjR
	LlhJSZTrtIozYm+56a4/9kyseI5AEqbojLvlr8bgrGC0Zyhc5HCDw3ip9FKipwUz
	vo0kmSv3psz3s8/o332fQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978074; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:sxAesUm8+b4vOv1POBdCkLeiVW99dFNKqcofW+8J9JiFvVf
	F6NMZ3RcD1KSyuWk4EZEi8vhUIbxgbMBSVmauxF6XRNnJf4zP8JU0rGbUrZprmAH
	lke0M67aGvv8IwrRArNjk2eYvnsjqeQt2j+AcolffDNiSG/S5gepqa8o8FFIVS3S
	wC8RvV1LRJg+BQ4+ZqTKkeGErZik8Tow6rgR1f/D1igFRfWsZE9DYcZ5gsqsgEuK
	NbhA7LoshWxINLQNXHQnHGmXAP5Xk8ELDiIGto/7s520dAkhxCbunXqI2Ou9HSKQ
	QZTE6el3sYxESCOUDKVHFcGT3k+Ed0c4kseNpIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/WUYJ8qIAqq5CyYK1qqyYskuHPvzeFOWYDDPrcrVUY8=:2SPYAO7aRmwEQkPIDu7QK9rk4Efi4Vd/jKFIXRaMuiw=;
X-ME-Sender: <xms:2u7tajxjIyXZ9WdTzDE_7tAqC36CGt3fItGLIQ27e97GHafYN842Zw>
    <xme:2u7taiTpt4ECBGURkaxt_lxGzrP2EZFRL5c1Jm9AULLSyIvXt7R4IYmKFCjbKBVoC
    2A149dKgY2JyOs-4Z3eT81gXWdBC3qJhAkvIVw4IUld2nKCbYTDdZk>
X-ME-Received: <xmr:2u7taiWq3glH9GFbbsOdrePxnYVgjeZheCQAZwc49SojKrFlSKjVkYEvdhEp_LMIIf_xzA>
X-ME-Proxy-Cause: dmFkZTFrh/TYsN9X3M6/W7LWYSld34ixz2P3sqbeW+RU0KnNh51jSjcUBLq6dVFakTvypR
    +oIFJUCi4sLSMniPkDCbUBH6DgK1mr75Mei90UNXnvWRJcIuVgYOgSrpTX6Qz2kmn75w2Z
    cXDwyWateJlawhK9qjx/6+DBJuqi5LPMBMFoqc7HN9exSAKrkmhEF3I+jewFotFELHc1/I
    Iljar1cOWObQ2Daa4BTbrAWG+IKiDeUq6R7SZuUzLsXkMC47PgjgFtiixuv20h78Tcu9NI
    +NC/T0/0Om9Dvp98r5R6xJvGHhz+LJxyC8KOyMgW4jxmcJzPAfBmsreYJaNtFyrIELweln
    +8hfpzYUJjy69adnuZoxrF9BUgyLk0LS49gYstQp18BqQwh7+C/Uis8S1ChYPo/Z6FSZG/
    aUgTlR+Kt/Y4GvBe2xzGydVcbJM6W0KpPsxkQVI8zW3F2odfUOYKSwuy5CqxrJfhH/npQD
    +0akJftLRu3eeD64NCbKNR3H/MezEi3F4XRWLe8POKkQd5HN9tyg1kWty23jk/wgZc6qve
    GtnE3RDTVK6BTFmxpCvoLWN0HftFvIQVZMdsGwTwaYcLK3rIheN/BDu8AX6ie7zm2lhjp0
    EXK2p7JDVHisaPDenEl1sO8I5P/comUcp82XtgipS4HIQxJ5gEg37Zn9aZdg
X-ME-Proxy: <xmx:2u7tasa95wlnJ4iHcbbUm7EKWeedVDtUnjgF3jbDuSprdMtYCcEesA>
    <xmx:2u7tag3n9L-Z6cpyGTRSKuM-eTRLMnETM-toe0hUH7c0ycAzucW2pg>
    <xmx:2u7tamhcblebDAFwlJCteDJSZAZVEXDmkkJ-WqORe7jGbd-mC2cQXA>
    <xmx:2u7tasbbzUgEcrR9_vtYgu2Vpw1i75EXMU1XMuNTu4cdHNGKwcu8OQ>
    <xmx:2u7tap0QacKGLJt9nVKq-ur_iF4WjTik66krKPQCl4ek1PKCT3d1JpJs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a3a04e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:14:03 +0100
Subject: [PATCH v3 09/12] builtin/rerere: turn "diff" into a proper
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
Message-Id: <20261106-pks-rerere-subcommands-v3-9-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
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
2.56.0.500.g5d06dc02cd.dirty

