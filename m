Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088876;
	b=Em6SrMc9vERWkNVV0vnhV0Ww6+tku3jIuMGXmw8dq1Lh0VqcrcghjvGMKCwlPPPzqKTV
	 LAiC48hm5W5RAtWBIh2wMXEJHZA6cEhSspH3DwDb8fY1dS90r1bjDjzQRh0gmDJYQDW6R
	 uH4evbOUkRX6o3FOKVw9wG/4Yyk17as8Xkoy/uYfhOSR3rEraTFKuR3Y3nDmBHeNVqqju
	 FdY4FTqYpVEJlUmRYTwmiqPi6Yet3gn73cXDDGYXipLHARafmOLGROokgt+1JaZ9RmpEk
	 XfBhrlcDX7MUbQ5b/FlyGwJnGOszy51NWhMK6GXsONMT8/f+tRlOQumUq/Jpgaji2yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088876;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xekzWIaU7oF/xeLw5mMKXYqpq/08Q2oL7CoUyqXzr24=;
	b=CYbPDxMI4x0A7Khn5d76tg9kwo4Lb/WWjOKy21QNtr9kJqXcaewxUsUHQaVbndOYchDu
	 lB38yhaYuiqeyDMO2YqTVsScYBfhcM9cCXtdD67frhNElkIZ2flNrO1/z0MBfK2Ibd3Rc
	 kMVnLonntgkulAZ15vkInJvMV25jZL8ZIEWjT0Pbfm2guENhnya4h86bYIwwsy2eaFeJI
	 Y/BlYAJw9iPOKhGdLL0PViBhOJJ7UswkG2nowE3sTXlEfQHVKn298gfxU9DZdHZL0OLHN
	 VEEF5RNEU9fkj7uNxUnEucXqU+uzxz/uaR1Jud/tEe0C/Q8cAGVs7NYocT+56gcvZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=E83CmCXK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xOAy2L0J;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2B606A326
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA2B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=E83CmCXK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xOAy2L0J
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9346E14001D0
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 06:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088875;
	 x=1795175275; bh=xekzWIaU7oF/xeLw5mMKXYqpq/08Q2oL7CoUyqXzr24=; b=
	E83CmCXKMj7MHObW8fYgSP9wk8dP6kTNshKQ1m4RHKW/o7TDgK+XWKKuDTKjk77O
	/8c7Iz5zlbd7qT9RZJFTQZA60LHiKtmZKURSUDd2Vn7TU4TN+Xg0gnFCmU2uprUA
	rrtO9DZcyzoD51GD3HMYcXRC24rwm+zV7MSjAFyJsPbjDEz5sfTS/MWu0fPV6SA+
	45kCRqEhIEfRVEEk/uGAmqnO/oNDN7AvLkT/4FBZV/ymE/7mpmRP78faw938iCdF
	Wc19FZfiXn5Vj9tZXnd+FkVywVjOEEmlNH+v/hgWNJ+SA3+qDcUahXxnM14YVSl1
	NCRZGfSFzMSQOPxKZF277g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088875; x=
	1795175275; bh=xekzWIaU7oF/xeLw5mMKXYqpq/08Q2oL7CoUyqXzr24=; b=x
	OAy2L0JZnHR76J0ynMnmciGx8fzTirQGzuJRI93MkfpCHCUFkngl8htNkhGKNW6E
	6HeKwmgidqCjNhWGKHKiLS3niPbECIrxjA16GStTAzCNLGFSTO2bEVE+56zfOgh+
	3YjkjJBstJ1hGxtVtDzdhgTLfLUl7jJxPa7WpF/7GxQbgYXWqA49esQrIQ8vUanX
	1ndA7zBlkw5YXSK+eqzRSp/HHGD6yGtIAgGEm4FfgrnwCeN86QNcMlp0VZ0tAFW+
	8fL34i1gNCgtRn3XJXQScMPixyBmbsXves9ovcsm3MpIVxKPqh8wxotON1UPBC1b
	kfa9JA4fT6Y84RKZEeVHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088875; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZeQ50N+GVGgR/TdT8JK3GQEi3hc1J4QvIrC13eW2KK+H2Xr
	LoPLtjqm2CFTzo2w8ISdc4TQlgp/f0vnFYXH9Y46EqHgZLUUl2HbuorcH2dYgxBS
	LXM39dsXQz52aMIJt56GbiP5a0KtojF9dnbZOTMp3iBkHoyhlLhlIfXnS+IPulNj
	HTYfyOj7t2s5mhm22Gcj39oyp0Vyxp653ILuSxMKEy50xSI4D0ngsv0hiHgQ30N5
	Z6ldJ/hEB7UutVT8of1qPZWMeplJYMd44RztWLdZBUDRYWdYSsICT7xpqfYMur/P
	CPfEtB2WscHnwAvdQPDUFNifz4LwUSYr8iajS5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:oWPcRo8Av3T8dqcSjSfzgkAOrNLQ7bzOVqak1Fp3yMk=:f8K3kI0ZlDoSspzhmGEDpPAhWijDFgOD1zOy0xVzDhM=;
X-ME-Sender: <xms:6-H-ahTwzu_1vhS_yUz0DCS0ZhpzrCnlx-WiPj4NzhlR3l7xH0Fl3Q>
    <xme:6-H-ahzxbBR-5u_IVYTbvVObPbWEqpPmYDOJB6CP-0-9Zg72v6ivpezqkoVdHjr8z
    ASsDLeLcMA_rxylc9853R8VGalKg4B5pxK49V9PeugN1UsKiqi8JfUm>
X-ME-Received: <xmr:6-H-ar3eu44ycOwWL9cIrMUbMXyC1Wz9pi26gmoaPhGCgaTI90Lxo8ocQKZzJKHOokU_CVU>
X-ME-Proxy-Cause: dmFkZTGNM3N4+b/upjxvcnEBxFtN8qd+Q5zJywsHu5GcN7t7LcWCkkNgsqpHNkjN1G6bPs
    L4xJsMjCjyaRJbJ6LhGbWLvnf2GO3EmiJ/pWD6umLPGODQSUZMFTWyo0MGSuAXDkjljsJU
    i86CoSctK++sTHi72NTRnn2wirmwvNbhUJzvvdrIL+23Y+uCwBruq1iYyJtQLNCSdYk6HQ
    xFoOMNvUvtAkOueMz09bbmxHPiWI81ceuizlo+9UGiUphwtnAofkoKyHTFO79c4+pSLlco
    skIraQY/QtajYy0O3nuIU8witULu++HtpXTyiaElG2lOmDEVcHDMMzZFCukurTIyZ9nzgC
    kPZKyoSejpwZlYx3mK4KDWQ/hYxZIu2J5poa+3UHojD8b3zKE3Ug0Cf+vaPYHCXUBRk4uS
    fPniy2GZE4KitzwalQc8K9ANJp6JF5Lxn4FC68oJwmvveQEVEVtUUl+3iWj1zTOVPWtv6f
    C0nflKIjYpXHqd2FHOFzHBVVzf8/rTWEsmcK6bSQQZkth+PNEvQe927ekoNLZRyHjhq/hz
    JCq5m/ApIejdvER1Cd44Ero5qI7vGLi/KLVO2dnRTRa4YfnssTHDfiyzxyOFQelDoNfYLu
    K+ATKRAIMmnzpfFNkYlOcfkO5ZECzDIbEyZfKyWYaEduYECw/IVBp5gNAGNg
X-ME-Proxy: <xmx:6-H-an6yd6WMT3Lf-qm9_IMl8tlMIvux5mAUy4BDW9fK1j7IC9yjrg>
    <xmx:6-H-amVpvXuV8QV3QXtF4bOLLw4Y-n4oKQ8Cj7uIXceQ_oc5wysXqw>
    <xmx:6-H-auDrCOp1eGulFsr-2eH5HlFfga3M5mP0Ur-nebtNpDO7e9kZRA>
    <xmx:6-H-at7BIuTDF80XIxsu4vz_G0VTx2tSabcbP0X6gr0bA3LrWmEUSw>
    <xmx:6-H-ajXzhMjNwKdfH4Qt27t0DVLtN2EQHdOdTYBCGI0ZChy94IYxhQty>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 649095ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:11 +0100
Subject: [PATCH v5 10/13] builtin/rerere: turn "gc" into a proper
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
Message-Id: <20261119-pks-rerere-subcommands-v5-10-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "gc" subcommand to use parse-options as a preparatory step.

Note that this results in an intentional change in behaviour, as we
previously accepted the "--skip-lock" flag both before the subcommand
and after the subcommand name, whereas after this change we only allow
it after the subcommand name. But that flag has only recently been
introduced via 5f6b6aa3ab4 (rerere: add "gc --skip-locked" for auto
maintenance, 2026-10-13), which is not yet part of any release, so it's
unlikely that anybody will complain about this change.

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
2.56.1.831.g720f3f5937.dirty

