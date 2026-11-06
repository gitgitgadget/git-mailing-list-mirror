Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978078;
	b=wqHIIkNs0Q7eYOMdVWFvi4k5QWpQkcmtwhsmB9iM2s2lDuAyupXIxt36CJtjVZRhRzvP
	 ZyX1WBFmTeJMW79asPMdiaJsOn6EBtvogLz8pOrEw9Fwtjq/dEOw3+3wkkOeAC3Rd2Nyr
	 ZhOWwhJ93ak+msFn8jLFWv5hYru8QNRE8IMM3ttSYov4LB6l9qO6IVZUaTiDmJY2bGtWS
	 s/rXjGjg72niwqsC09vLKUJJkESHBxjwrVrfRDQnR1mtIxH5lbjXPPVu2i+XhXGnqGlfi
	 AbcvThzWJ7D1WdPRD8ANb0A6EhQozTTNW1QyFOBqs+xua49k3qLk30B8KCLp7JKU//A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978078;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=42PqyCr0c7woQlETdNzs8PEMX76A5XlgW6kV+1vpCxI=;
	b=jkGP/mquAZ2lOJuxwRc4mudyXv5x3/DXoQUcficJNve9N/E/+ULLODxH5MtBF5MFLfur
	 Qv/NmtHrxZV8U2IwQNPxgJWXRrbMjh/sIVZre17aibFro/U17MF9dBwVcdRW/XExcKRpn
	 h3wzdIRFSm/zRVBIG010Hr70XCyjHzBcXscXbIrxV7IPiBAZENX78cWOIUuXkHiI66c1Y
	 WS/SLGtCCx2mnGjiOHxatknAr8YkQa39djR2pE4F17Bdl5Hrd1h+GMMe6iLWn/WZPc3ph
	 XkvMPv2ErOQ1niAeZnFJiS030pNKHmBnLNT/q8/Nz19v8wm6VNClLbQW98jmYENRzBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=iQPDEwwe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Z9EaTdSz;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07A606A32E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F07A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=iQPDEwwe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Z9EaTdSz
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F29D17A0129
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 10:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978077;
	 x=1794064477; bh=42PqyCr0c7woQlETdNzs8PEMX76A5XlgW6kV+1vpCxI=; b=
	iQPDEwwe1vpzS09reOZPRZYEhZZLMatbRkdYAQKXF+ZcGdoPgX5di7/SiRVxdMES
	b7B2eWgZe8IlPGd8+ht9xs1cJ8Q7AYJmxc1eYtUxKedtZR+L9/nizWa94Y7YWYje
	vje64YLNv9LNn9nc5Pel8KZ7mzAV98lr8yLs2DmCTOYzHQH0gALMEGd85nUI3po7
	HRJx1w94MFkNM7fDukglD0piHxSqzpNvBtvQgNCIugD17FgRTa+o8JvcfFNKyDgA
	wOaJHn5KXtX3OLTgZbMyvjjX+NGONg42Z7GB3Mc6a0ercXvxOAgUP6FbdOQYaHw5
	2ILzuZG+CLfojk3PmXunIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978077; x=
	1794064477; bh=42PqyCr0c7woQlETdNzs8PEMX76A5XlgW6kV+1vpCxI=; b=Z
	9EaTdSzHzq78XaD4H/jSjAjLGma7hn6d0CstLCbOh9YLiTy4RqGQmnbhbxCkeZcr
	KtuJJuW+z23xRRdBaE/lk2DrQiwoL+V7hjr9+EkKvikPLNzyVI68PaaqZc5ThJxz
	GMrZGBAgekdO9IdIF1+ypTlqoHfixW+tC+TJj5G25wSfe3cCBG8ecQAD5qG3bqyR
	T4DpveFP766FiPpLrvvw8HpJGLbTmewfrok5bEpam7Oey1HW+8sba3DLqkLPe5ov
	XxO7jPAFgdLcKyUeRgfpW2CGCz/xcr+QcvEAzVcxuSGoT7nhFM/Cub6ESEXBhnNV
	KWT2vVeCNMcea6zIK13lw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978077; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:nCO7zs2uS33e0z3jE+sYUpKwjRx+WR2peHzB/x8oemxW+KC
	HRoMNzB4F21wOSJ0rrBtBK2SdyVV0wqgkbHK1kLlTxNTZZ/xyxYA51OsomZnmP/9
	5zHNesEm0xysZC3TjMBJ1CfOfYr2ns79HuNke1vK3+qcXcF3oBitaP+2Yuqm1Y4f
	fGE3qNqmPwVGb6xzbzpSFVsPpw848wv36xnz/qMZ/2cyTQMRn8uapwbdCDBiTqUs
	rCwfU1zd/TOhOPnidsMl1Lx7W8j1aoy44bEFbB+ZmuhtmXqnOP82H9o31FtiOAVE
	Ssl2BIdZXL/6YlewChcqY05GvjMogjdlild47uA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FxVdnTwXcM5FcgSAYHbk09CcjabmrB9qo0r8weeljSs=:gJKyBtW0uLCHBhDrKnySOfRpIK18ZLuyY2qGK6sPJjQ=;
X-ME-Sender: <xms:3e7taui5KLlmCY35xn6jYmTg00JzIJVDzeml2mEvczvXtHPvnylaFQ>
    <xme:3e7tamBYbGIlbMQSAz0ifAH2Sn31YgKen33i7CAQXLt1LfWA1dLlPBZfo6enEKcZ-
    MwzF6jTIfOG2Kbr63Q0Y_fuvumAHu7hbKAyv--9mqRHq837NQBJmQ>
X-ME-Received: <xmr:3e7tarHu8WUpa_NXyqJa1MuH9bRkaIkJd7OO8dJStW8GoZ3RlGF7k86clQPL_sw_K4wdNw>
X-ME-Proxy-Cause: dmFkZTFrh/TYsN9X3M6/W7LWYSld34ixz2P3sqbeW+RU0KnNh51jSjcUBLq6dVFakTvypR
    +oIFJUCi4sLSMniPkDCbUBH6DgK1mr75Mei90UNXnvWRJcIuVgYOgSrpTX6Qz2kmn75w2Z
    cXDwyWateJlawhK9qjx/6+DBJuqi5LPMBMFoqc7HN9exSAKrkmhEF3I+jewFotFELHc1/I
    Iljar1cOWObQ2Daa4BTbrAWG+IKiDeUq6R7SZuUzLsXkMC47PgjgFtiixuv20h78Tcu9NI
    +NC/T0/0Om9Dvp98r5R6xJvGHhz+LJxyC8KOyMgW4jxmcJzPAfBmsreYJaNtFyrIELweGD
    nPY0ineTQMkIIz3lWzYFugvTkRGgVDmikaoeSE1H/RViKzSSvj2ioxqUXpYwyzw4pZZGkH
    r4oWZi2JA0VnMZK92ftmkkaSHkAXZTOBqoZDt63FE5g36m04Tv2ia0xfAGIXhap1j1uuDS
    qTJnxTICUlnnp3TkUD1luVEhOZ+RFXBcfQF7CgLETArfBqLq/zGMne/OpzWmtxg85wweXz
    RlaEMX02iJDf2hcE/OPncFpeQm9VJwOeNTbjUQHsKzpiUSCCmPD+jxq/3ZfsV1CQdttawI
    7VSH5nll8o9AhS/Jy5lRBep+GnxdqnklIJkrIdqK2CbDcV32oLAhVF6caWKw
X-ME-Proxy: <xmx:3e7tamK1wSYLASXgSJSymC_hns4ejpGXNjvJn1KVDqGCBzbzPQM_Gg>
    <xmx:3e7tanl8CWmXDzM3jUWqtZnBHvuk8DD5pj4cCHfdN9MPtjzVsedtlg>
    <xmx:3e7tamQDATsq5LZXfV0b6qxHlvPetzIS5V-lrzuo9TeKCF-VdDvAnQ>
    <xmx:3e7tahJdlWiD5-NvP97sbn6QLgeWy-X6c2y63CTDBPMlssr5cyXIdg>
    <xmx:3e7taqyxomEi3IRIT1I2ROG8ouup-enL3728AuLxRQAiiAX6oHdmopEj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d84c17f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:14:04 +0100
Subject: [PATCH v3 10/12] builtin/rerere: turn "gc" into a proper
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
Message-Id: <20261106-pks-rerere-subcommands-v3-10-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "gc" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c  | 43 ++++++++++++++++++++++++++++++-------------
 t/t4200-rerere.sh |  5 -----
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 40bae5cb9cc..3162b074ec6 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -128,6 +128,30 @@ static int cmd_rerere_forget(int argc,
 	return ret;
 }
 
+static int cmd_rerere_gc(int argc,
+			 const char **argv,
+			 const char *prefix,
+			 struct repository *repo)
+{
+	int skip_locked = 0;
+	struct option options[] = {
+		OPT_HIDDEN_BOOL(0, "skip-locked", &skip_locked,
+				N_("skip gc while another process holds the lock")),
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_gc(repo, &merge_rr,
+		  skip_locked ? RERERE_NOWAIT : 0);
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_remaining(int argc,
 				const char **argv,
 				const char *prefix,
@@ -187,21 +211,16 @@ int cmd_rerere(int argc,
 	       const char *prefix,
 	       struct repository *repo)
 {
-	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int autoupdate = -1, skip_locked = 0, flags = 0;
+	int autoupdate = -1, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
 			N_("register clean resolutions in index"), 1),
-		OPT_HIDDEN_BOOL(0, "skip-locked", &skip_locked,
-			N_("skip gc while another process holds the lock")),
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
-
-	if (skip_locked && (argc < 1 || strcmp(argv[0], "gc")))
-		die(_("the option '%s' requires '%s'"), "--skip-locked", "gc");
+	argc = parse_options(argc, argv, prefix, options, rerere_usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	repo_config(repo, git_xmerge_config, NULL);
 
@@ -215,11 +234,10 @@ int cmd_rerere(int argc,
 
 	if (!strcmp(argv[0], "forget"))
 		return cmd_rerere_forget(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "clear")) {
+	else if (!strcmp(argv[0], "clear"))
 		return cmd_rerere_clear(argc, argv, prefix, repo);
-	} else if (!strcmp(argv[0], "gc"))
-		rerere_gc(repo, &merge_rr,
-			  skip_locked ? RERERE_NOWAIT : 0);
+	else if (!strcmp(argv[0], "gc"))
+		return cmd_rerere_gc(argc, argv, prefix, repo);
 	else if (!strcmp(argv[0], "status"))
 		return cmd_rerere_status(argc, argv, prefix, repo);
 	else if (!strcmp(argv[0], "remaining"))
@@ -229,6 +247,5 @@ int cmd_rerere(int argc,
 	else
 		usage_with_options(rerere_usage, options);
 
-	string_list_clear(&merge_rr, 1);
 	return 0;
 }
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index ab412ecc6e8..0d4cbf5114a 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -263,11 +263,6 @@ test_expect_success 'gc --skip-locked prunes while MERGE_RR is not locked' '
 	test_path_is_missing $rr2/preimage
 '
 
-test_expect_success '--skip-locked is only accepted by gc' '
-	test_must_fail git rerere --skip-locked clear 2>err &&
-	test_grep "option .--skip-locked. requires .gc." err
-'
-
 test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
 	git reset --hard &&
 	rm -rf $rr &&

-- 
2.56.0.500.g5d06dc02cd.dirty

