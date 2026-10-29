Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267870;
	b=Q3FpSEy5T/fRQyQLXu+Z9SiyaTkMu0IXK9dg4egLhiyfzwWX5FIjA3CL76FMEXN9odEI
	 cvTDkDk2uPEDNNbFWg9D7gRBTOSzHoWsf57CLfR4NASBFVHk3xrlWv6Dfo7hQWdiMGbRw
	 Ioyihdj9wiJz8RXqvQ4g08eDVTkbnYxbqGGiu7ckCFAzQ6elkHm0LT4SaEmobg89ai2G9
	 b0bdMwGZBtrhI+bl7l92BV3GNbKjGQeEUYppw+okZMJyuJ7W9M1ZFuXmbv8i4qQkzxQ4F
	 q2t9ybbNkREJSuGzd7WtIJDb6fxD61Ca0iXUk33REWr4g4IycDCCdaRPrKAA1Z/fgVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267870;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Ck0jvOIYlooX72aGt+fU883coOT7BbqtKxU+pPT4crc=;
	b=tdylD26VIUOBQIXHiQZBB6Cub80eUHrIIielSSFEal6CD6IIF/pTgEjLQJPvh6BZ7CNR
	 LTrlC70ZY64G3fdGuq0Emh9sZEsgYXd9JMZUpnh7IDSBnL09ogWkZTotPcCKni/hetcq9
	 coDErK6Llh5K5Idfl7z4H6Jven/BDfISRNYst1BpWZvnsNJtl1YOBOHENzymoUQXKnCQ0
	 pxwnOPkuq9Mkm7vvARrUNWR1TB6z/vx2afEiE5OAtLmq1SW1Du+JFYs24sT5xS7CTiXVi
	 vf8miW3slUadTr53fPVuif7X2cSoXjgtr1WrijabDqNSQePLhCyfxxVN/FPG7VPW0Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ScH2d4h3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yxqlBHjf;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B09606A559
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96B09606A559
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ScH2d4h3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yxqlBHjf
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 05B021D00055
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 05:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267868;
	 x=1793354268; bh=Ck0jvOIYlooX72aGt+fU883coOT7BbqtKxU+pPT4crc=; b=
	ScH2d4h3Mq4ZV19w07Pby3ELQ8ot/RRqud8AwPJwX61XKCHGR4bonKorGiY01/r9
	UhtS4tDxF87D74W5XmQKNh5Zlwrdsh7evoMI7CG+jJETIjpcM8ljkqjGh8SIpiEm
	Qi6oCalveI+ejlJFyfmdQxbCqrZu8SzC1vzrskEdxraNWowlogdzz25wp2shauJh
	mT1TyI69tQ/JUTSmxpQ47rCEm/BpqR5+mhzXIt7bpjdPkEP9IrIhrvS5csrUu5NI
	yTbYdAktO9vcUUt3F1aAVbthDJ6PLIzqaULPdxpn72Zley9r/FScoNVr6ibtWfxs
	aeyWjAHD1hJHHe5tKS2nBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267868; x=
	1793354268; bh=Ck0jvOIYlooX72aGt+fU883coOT7BbqtKxU+pPT4crc=; b=y
	xqlBHjft1U679S5a+gyPx00vDBLcG3t4+zZiRoBBNosicqzUSQippPdrjdxtTcVg
	iTALdhAxV1TUSEgQ/fU5SFSRtQ9DVPH3j1PL05cEn6ly/GeOt3RTYHbFCwyQ9wR+
	xSlJbFkFhlqO10ZYpBjbKF87lH2SNalGUQIF6ALIhK4rdoIxz/t49NXjnibwNMpD
	3SR9eLOpV1h9cfkZTcQUVsYzv/MiUqlaCQfs+/FNHUr8+FFbCIP40iivzZfsnpND
	hW52ZSGaEg7lsWwV+NjU0rCMN0IARoMJrXJ6niY7ubhfYPnY41tUcEEr7tbWF7PT
	fkzCTnITNVAcHzBh5AuwQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267868; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Eoy25IyYSb2NXAjRwXeV+uOHfG1MU/JLdOZxUd/9MNpAC6f
	qpUt0vJbQ6CNI+mYAxeKIw8A6bqXla0wo5JCl0bQoLw3O7M9d7VqRL1yAVeIS6Bs
	8GKb13QDhnzGa2wtx/2hyZK/eWFeLYQb1KWZafU8peDL0ciYwE0W9MGX8O+iQOSb
	NcVgpnkxE3qxGFma8vD+0RBh153g+od+/yyKg45dF7JhJO/6v/cneUjAtmd+whPo
	xWRsJWQh2mNXncieeeNvZjyZ/u4k0mIZI6C5g3xLn046vP+eQjzK0uTqfC6KnbIt
	KwUM/nazO6/sGxmMdI4lmzJ+hdvUXSh/ByDOOpA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+NeZfKMhKnacnG0oh06fP2ZC2cc1spXUMX5pn4FEwUM=:CtMWaqsEhBb/3yxWEP0/QUr8lg44/9QncVhkaJXMNx8=;
X-ME-Sender: <xms:nBjjahDQI2hEbtONYjO2o6kp5blfx93tRGyhpziZFb_a0D-50EANFQ>
    <xme:nBjjam_uv-S0sBnS_JuASaiMPCmFu4LBEac28ph4Ap0YbUC_84EEyEKjMCDkK63Kd
    8n4zA--siLyEU3GAEt_bQU2Q6r1qP8xcrQ9UV4LfZK4zD9opEyEhs0>
X-ME-Received: <xmr:nBjjap9Hwho4kojjmdMm19Dkpjvp0RGgohzyug9j5RKixPC2C-WglQ>
X-ME-Proxy-Cause: dmFkZTEPExXbIzUnCrIwxlPgNPEpficadNMywMDzTLTluQC83MdbPs38fvNUp31UVm5NpE
    EJVU9iuQ4kouOHZOpbze+UcOrkC8p0W28fCiqZqj0ZYHvE0c6h/XpnfoRReEPgoc4dEExh
    Jbhf2EKz72ypYj3tvlGC7tWyrBaTSRtBR34u1MqjevnCTWfJQblD2l8vS+r9JzgldulEaw
    xtMPc4sYVFZQ58cqVEZqex5lnN2YCBdEuxMeFfpHxOhrQwk0XDXVJloPEjbu9G8K8L+API
    2dEKhVx+9uOIuYWocEFzkmiOwQZvFbKhZvksPi96huszGIDXeswgTc3IMJCpzFCQg86RYk
    ae38mjn7o/dUW726cmufWM3G77Ao4AIQZDGzJSA3/IwfGbj4zLDx1ANAMIKPrMwgTVZbBW
    d+4AxTPludWR2SyHCKlcDTg3t8MTxCRpHpzgDX2/5v1+LhUDLm8glv2Vvbi4a+OF+ZVfZA
    jgxI5Zfef95Xdq7m5gAeIGuzPIa1aI/7nX8/4MhwYBSbUq0FuePbrunyeAsLxLpuOaKQ10
    yb2pIXr++bCmmRJ2NJT0TcY7pdoGGWzLvpLXLnXp66IYRD8WxDevnLxQHPgOOLOwU91fn7
    fHCJXvzUp3T9gt//m5Z900/Lp1ao8jYNxgACHKzC0N/PviomawCOLaE70ZcQ
X-ME-Proxy: <xmx:nBjjalfcb8I73Qcs2MujX6xU0RQfx6osD0RPhyK0EZu1Jhu5cATbIA>
    <xmx:nBjjaqF2LEbGn_wlKtRSqWpWL9AACX8yByZvY09FshuEXUfoSXr38g>
    <xmx:nBjjarepgNhW1ECAPdn0rmc3R7oVzK7fJHqVQTr3RsKIEL0Y7IcobQ>
    <xmx:nBjjasG2yVsgO_45KYe9Pd4zdxZFyn2AMdpdc4b5HSsJkyStnMgk1A>
    <xmx:nBjjavE_VjpEwnEJw2Qcl5mpbLoaHQw_sd1odjDcU4eutJ-FVSp_tV9u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4172314b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:19 +0100
Subject: [PATCH v2 10/12] builtin/rerere: turn "gc" into a proper
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
Message-Id: <20261029-pks-rerere-subcommands-v2-10-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.56.0.341.g393f52fd96.dirty

