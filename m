Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399563;
	b=zo/FP8/Mg1vC/hSgm2V2GZHLBh+nic8Snd1BvgR2TBfOby4IK7/Foz4ZaHdY9+xUuOER
	 B4Edfju6dy59yGcYZZ4gS4eK4/Xf64m/ERj8WXQQfHgNIyVzKQeGd+Z7S+1b35h5e7nOj
	 1RsQlWZFdUuCsm29OKoqUf56V4C08dWBEfPAx98hpWDnVlhFOTWuBpwFGbfxuHmDjOqM2
	 FmM+CEjA0LedVMvXOMXOjUDdDbxm3pkZ909/lnhWo0hktAdsO0Ku/3IQE20WMHmV3tz/c
	 HAHgH/ARXURIbYWvAupbXnUO7k/cYwHTOi8FfDQlCd+ZGA5BcAx4LD0uEjHP8ofT6qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399563;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=v1AikZBlTSvQJrjSoKCL1QizOR/1Pl8NMC299qFXaOw=;
	b=iFxPUDlj7wVcfnlEyTLPvnwl+dvinlcKQsi+fvg/GeTN3xi66lfmg8302yjIrnJFZsNC
	 t3OoYMBVz162nz1Ywk+YFTZ0Y9LmwcAIxkRiEs9AwDt4jr32zkDbAmXaMinUNWf1AOH+E
	 C6K7ZYhW1muk0Cy5Wx0Gbjb2PN0A3aqB+4PyHQL0lJmxl8t22GrSD0X+8MqKA7dZ5a71t
	 9ih9INavCSBLtNan975ZAchh5XlFseZ20plNPcuSibXlKALiNGPrsOgwtIGn0e19mxJVu
	 r+k4naGNfoNZxGFahbEBTLDM0LoAuRaZdtSFrKH5cuL4Kmbpnies/33ZgK5XVBSd1vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=dDlQSnzt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Kl99UzHx;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5E606A88D
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE5E606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=dDlQSnzt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Kl99UzHx
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 985327A0259
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 07:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399562;
	 x=1794485962; bh=v1AikZBlTSvQJrjSoKCL1QizOR/1Pl8NMC299qFXaOw=; b=
	dDlQSnzt8gekaGPCLHNxRCVHMQ2gm3hbeMqGz9hPLI4CT0L+/BHQaMtWvFfgIYTb
	QG1loqE81tIluSHfUxO8t7u2uAKqWVX9uSU//dGFnELEvCFR5ErrWEgmZSVgjFQh
	KlhCZcWod+StUsoNVReQD+Z77r7iZMTxR/mhQWQ/7HCEet2ozg1ygmE50sTCQMnx
	HoY/tiJAzRisPulS/nM/kQIjaHdBCwuKHJW4YkMSlssh26w6KCRYoc7AxYIJx2mV
	a0hf41pUmNQW4+TFY26Cqxs/n0gwxQwYvvvXpWDSyJ48Q4cAfXdSwW26z7PySU9X
	7B/AdoWWFdRPyXMxLrHhcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399562; x=
	1794485962; bh=v1AikZBlTSvQJrjSoKCL1QizOR/1Pl8NMC299qFXaOw=; b=K
	l99UzHxIQDDLqOKG7cp8PZVmisxL1MCvkn1IgSBSm86J6EWVJ7iVg0li89r9fuVf
	Holxxn72S3xQtZxu/tAOkB0hZUxbISvlVvqZgzFFwZvevCtYWVvW27n6CiAuRvyu
	U7E0Yz084LkQxx2mDp34NnhNtPC30Mxnwzbntyf23bJpnTQLg1/5pI9Z58pZ3+nv
	XtMiXMO8JNKC6mJj0Hu2ODdTasVO9ZxTH/gOCs262E0ZY0ePpqPz7hqiCwje4BEG
	E3ZS3B6gctSOBSDyNY2byExo/DC4O0+8Pb010tb83h4P1mL39hlKHtS7PoAtiwr7
	opWPbIl0BZCardTc5W10g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399562; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mbFzY8wE21ZyPE1WajMwQjZevj+1rGGw4sOzWeMut+Kx96W
	iS7zjqtUGJGv1Ev741QIXiyxDorCoDaMt4RzeIubKH0+L4z8KdUer2Qdf1OvGusR
	BLXiCv0nG3fnEtoyIm4LB3LlmNvTI4gE1zUIshpkraVoeJ0W/zJ+5NDybMleDwdM
	BBEFI+E1Dvt5SwL6JeQVqoFfvfu+gRvB+py+qWoz1Up/VgiBU4rjttgArxKQsVBO
	gFp8/zJWaQQncw7dtrzxBMljE2wuMJlxY/5XBRn/bDeGc7GsFM6b8+5uUzxjrVu7
	MioaeDoyvZIYz/sAdT+oeCZdlDmYirOb7pm5AGA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cqU3Fzlbe9gYkk50wh4TgrjzlT4UEpi70Cw2nH4bFgQ=:2HF9TP5Djd2YwXYmMAFqJc8NeOsmkir3R7uGB60nktY=;
X-ME-Sender: <xms:Sl30auAwI0beCTpQ1FNQpRq4-zuLrsWXBEUogTgsHyZraDjzFVUqTQ>
    <xme:Sl30avjPkywRngqs8OptG-7NzD1xqA4BdcVuik6YqdzPPojcHkReeb1Xqmh6gOczd
    1hxhJEqPQdr1scWxTCimv9Xz5n44m2wdpCDvZ2v09IgVynwvmqR1w>
X-ME-Received: <xmr:Sl30amlqUv5C-qW4zQYvtcwWwfHLjdfFPQ92oQgGGmZwAgJFaMehkxYjuBgB3TF24xUoOw>
X-ME-Proxy-Cause: dmFkZTFX2c5zW7c3oLnSv0zcB+vdAUp3jsyHjOLJrg2xt/Ai/ZIo1TWOtwcJyo0qppmrMe
    thD7RnWdfdPsqo8u2WsKeMa7MRQYq2uWmgZAI382h9RDsZdYes2Id/eE1PyStFbEp3TrOe
    /ljcMS7fhS52JercJmsTuE3Me/s9aGfbTHkqRTwr8ymeNJbCtPDwfFFo3uBNrSaztlmsjS
    +Dagnpv1PuXT+4pDYznbLpmvTE0sFzbCSE5h2v95QYYoBsiyaOO1jcJxw/V7N2gIfS6TPa
    Zc93YTl6kHR25M13El3ysZfQKiG9LkJ78Myfzb7Znz1fg7m0Ik1v1E4JHHHCG3uMVf2JUD
    jHPfdPQ1DbKxCihwQedGWJe8Jwc3pmYnO3Aok/Yu8hTwQ3HlcMebeJNnHtKCxy11myQilk
    /KfFhP4WuX8Ot1Yo0Fef6Uit0a+LBdJ9YVCrPz/O5oWON/lcFmoeM/Dg84qUWprCPfHOcF
    SDsYXbnFyWe2SLP1rolsKg88WIYpdWvw8bIXms31rGSWvSl2So9hzZhqIrg5xMj1ug06D0
    FffyE7QnX0Pvj3zxiD9QDy8JjUdFVxgzFUP1Hx7mkSa2BlmJgbgsk0JQ6TsXeXmrVRsX0p
    +iG69oee+soEGgZHrPxoqaVjGuKwhivX1eRKj8vIMlyCZl3jEUfW+tjdeIYQ
X-ME-Proxy: <xmx:Sl30arqynVSd2C2zn5xFACVTmbJC-I1N8_jheKnZIYZay2N6iFz-EQ>
    <xmx:Sl30avFqcXLarviPktB-_TLRoX5SRrP-hdbd5B2m2d7VH3XAT9VF8g>
    <xmx:Sl30anxcIYMuUmHptxt6W2g5V-scyOvJ6kLVlwOnT7SqMq-N9Y6Ljg>
    <xmx:Sl30akrchiBmELBKhTSKDV3n_hbopQGI4nUr87-lLl9fvpw-6o4LUA>
    <xmx:Sl30auFNMnKptfkjTtSev-ub_XA9EC2nt726N29X8Ps0OblFjTIIhYpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 277aa716 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:48 +0100
Subject: [PATCH v4 12/12] builtin/rerere: introduce proper usage strings
 for subcommands
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
Message-Id: <20261111-pks-rerere-subcommands-v4-12-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Adapt git-rerere(1) to have proper usage strings for each of the
subcommands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rerere.adoc |  8 +++++-
 builtin/rerere.c              | 61 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
index 4e6ab9a27c9..e04e9ef3ef8 100644
--- a/Documentation/git-rerere.adoc
+++ b/Documentation/git-rerere.adoc
@@ -8,7 +8,13 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
+'git rerere' [--[no-]rerere-autoupdate]
+'git rerere' clear
+'git rerere' diff
+'git rerere' forget <pathspec>...
+'git rerere' gc
+'git rerere' remaining
+'git rerere' status
 
 DESCRIPTION
 -----------
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 97c791e420b..051e50838ce 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -10,10 +10,13 @@
 #include "xdiff-interface.h"
 #include "pathspec.h"
 
-static const char * const rerere_usage[] = {
-	N_("git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]"),
-	NULL,
-};
+#define RERERE_USAGE N_("git rerere [--[no-]rerere-autoupdate]")
+#define RERERE_CLEAR_USAGE N_("git rerere clear")
+#define RERERE_DIFF_USAGE N_("git rerere diff")
+#define RERERE_FORGET_USAGE N_("git rerere forget <pathspec>...")
+#define RERERE_GC_USAGE N_("git rerere gc")
+#define RERERE_REMAINING_USAGE N_("git rerere remaining")
+#define RERERE_STATUS_USAGE N_("git rerere status")
 
 static int outf(void *dummy UNUSED, mmfile_t *ptr, int nbuf)
 {
@@ -61,9 +64,13 @@ static int cmd_rerere_clear(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_clear_usage[] = {
+		RERERE_CLEAR_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_clear_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -81,11 +88,15 @@ static int cmd_rerere_diff(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_diff_usage[] = {
+		RERERE_DIFF_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct rerere_cache cache;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_diff_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -115,10 +126,14 @@ static int cmd_rerere_forget(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_forget_usage[] = {
+		RERERE_FORGET_USAGE,
+		NULL,
+	};
 	struct pathspec pathspec;
 	int ret;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_forget_usage, 0);
 	if (!argc)
 		warning(_("'git rerere forget' without paths is deprecated"));
 	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
@@ -140,9 +155,13 @@ static int cmd_rerere_gc(int argc,
 				N_("skip gc while another process holds the lock")),
 		OPT_END(),
 	};
+	const char * const rerere_gc_usage[] = {
+		RERERE_GC_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_gc_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -164,6 +183,10 @@ static int cmd_rerere_perform(int argc,
 			N_("register clean resolutions in index"), 1),
 		OPT_END(),
 	};
+	const char * const rerere_usage[] = {
+		RERERE_USAGE,
+		NULL,
+	};
 	enum rerere_flags flags = 0;
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
@@ -186,9 +209,13 @@ static int cmd_rerere_remaining(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_remaining_usage[] = {
+		RERERE_REMAINING_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_remaining_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -214,10 +241,14 @@ static int cmd_rerere_status(int argc,
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char * const rerere_status_usage[] = {
+		RERERE_STATUS_USAGE,
+		NULL,
+	};
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, rerere_status_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
@@ -247,6 +278,16 @@ int cmd_rerere(int argc,
 		OPT_SUBCOMMAND("status", &fn, cmd_rerere_status),
 		OPT_END(),
 	};
+	const char * const rerere_usage[] = {
+		RERERE_USAGE,
+		RERERE_CLEAR_USAGE,
+		RERERE_DIFF_USAGE,
+		RERERE_FORGET_USAGE,
+		RERERE_GC_USAGE,
+		RERERE_REMAINING_USAGE,
+		RERERE_STATUS_USAGE,
+		NULL,
+	};
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_SUBCOMMAND_OPTIONAL);

-- 
2.56.0.611.g1030f0b940.dirty

