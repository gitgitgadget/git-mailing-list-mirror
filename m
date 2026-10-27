Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098056;
	b=dLaUJMLHe1cnuAXGtTyUTEbhMIRzc7bwidic4Eh8r/2m6jTAlu6NN4VusYsXLqgOPQkA
	 YoZTgzxSev7/t4HeK61p1Vs6zC325suzS1fFQEJvxZpk4vkizKferI4/c3eyDN2x6fUY2
	 vsZN/dSQIn7T7brSn8JQKtYRF8/kafSpr4tTvnwv0kn5CF3QOH/cFIRvF/kmWPc1tKFfP
	 +g34+kLvE1aZjrh74J6JTcJr8xSzuiWWM4gOqDUkemBdY63/M5T4ek5UfAQ1Zm+6NCBrc
	 LvbiDydCbaMP4IRWfMsPNgrgqphoHNXwI3itOnpueWN1PIsQJkf6Q1VYHxw37ISc4Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098056;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=QL8o+C1uGU+WovUjpkIv6nD7V6UAOpQC19fthsyyAew=;
	b=yJ53OBlVIvWXVODAwUj04hZJ8C0hZtfJBR3LP8c5GaT8zxq9M4m1MDVaiUpOD9DKoTNv
	 i9/AaCQJgyIKVlIT3byf+XjyBe0qlvaDZv/Xt9K9qCTR3FxBrGBAGmiEovaF6xXq766Ym
	 fCLvFR1G1nWFBxffKqykP5v0sT6pWQm498w549HCdnwSOzn9DWfpz9QED+kea6NftCbyd
	 1vfJEEZvtuvJG1/P/4bdeVcPPT8eBfrRJS1Br48CJn4ddRb1mnHTKUF0UO5N9tKW5sH+9
	 tryFFlx/JQ1Riv0r9Y5PJk/g10az57iFtfp8fAZR1NbhQii4Z3onIAElKHip0rmwSQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rg9ZS9C0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SgQDls3T;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4A606A328
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F4A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rg9ZS9C0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SgQDls3T
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 537401D00132
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 06:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098055;
	 x=1793184455; bh=QL8o+C1uGU+WovUjpkIv6nD7V6UAOpQC19fthsyyAew=; b=
	rg9ZS9C0QifdM4s5lndjt3VA70bkG8filPxPr2faI2AMjwNpKmKbUQ8APU8gDMlr
	q1QM8l/oUSur1vR0t9TaqkLCTWvVtz6eqHNFH4EvDopojY+LomnurLQTT+YG7VXk
	ch4564ORS2IOsgxaD4KejhDhk303gQ1ptGAdj34bLvf0d8dxVItdbglRaAQRBpC9
	8CuOeI5kGZm2OANL1N6Avwu1AjNtK92QdnZ81/OX4DU5vvz24DD+U1rrmLYZb9i4
	audipICr1kkjbX59yD3XzWjMM+QI9Bk2FxOqlsu8HnoKyrR4HLGk05OPA1KZdD+4
	lRGqaN/Go5bzWEJkiz7Ofw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098055; x=
	1793184455; bh=QL8o+C1uGU+WovUjpkIv6nD7V6UAOpQC19fthsyyAew=; b=S
	gQDls3TyTjxF50vZY6k/y/Usu45fmwv6kihPps20KQXth6YcC3lWvnD2Jb8iTnnu
	I0N8m9sgUks6g2WldOzu3hZAmrmCaN+zFvOFNeJ4R6Tn89XsykIiKdRIBHeXWEV0
	Xz2O6bEaM3IGcfYGFQwY6ZmER+S3woqDedR3ZZuyb3Sz74RlsVyWgknzI5Q8U3kA
	s8UDT6FCu1gkGsML8sbUdzGcSDv+p6oEry0YBE/NdRPCQQ2BU+QaIpqEmQQxPf7p
	l4pszSzFq4llFmdtxcfXbzNFhjCiybm2UMypT1e1gMhhev2dkc2gr57Tqq4q4SLc
	lVT5HAoTwQQP9dNfNwGzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098055; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:uv6hcODtOtswEjZLwlSBoFBnUdOPAGQUTZZ1c/ImgJ0Nv1a
	9oqnvD2XB2CCFq0Z7ZtSPQM+VKy9tpDDG83/BaKOyyGQUljXj5boUkt5FD8IgkU+
	WG24df+ojqj/8X1c9YFyyO8kwVq0JyVOlaNTviMFlvc+RdM9ciRnJan9TA70tpvf
	o53M8lc0pmTPGv3omMv25d8P7XfmhEJQIs8apPbaNHEGKhFc+L8XXDgUCeZUIs/E
	uxuE2I9rkyuHViUO40RjbrssGQQk9J1K7LwcSApcSZXh7CDc3EjBAW+26/lIKEEe
	PzvD3fTlbSGC7PYSCW7h60PVo0QXkzdP86QUvCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZsHtKQAuiEz1rHwxN8nDB/IVn0BPyanJUtmX4rV3xwQ=:/zu6CqzoJx9U6s3avUhdfJYPFYcphQV69jRS/kBS+pc=;
X-ME-Sender: <xms:R4HgauhLdX_Bo0MToUoVMuz82x063Rt-R3sd7l-lDtPx2a3fKIJHjw>
    <xme:R4Hgal_Wo3ezx1CGGMVpUQjC6nqWdbkMmwnrIu2cubk-3BGPpnfxeRrjUcwUU3i4R
    qpV0TpLO5AuJIMNfRNVUcnwcxmHQkSvY8wK2DyOT93ywoxEFmS4wyE>
X-ME-Received: <xmr:R4HgarsLEqG_cPca1agKSK06KE0kGVJyntee6wTutOBotJzDQrSEJg>
X-ME-Proxy-Cause: dmFkZTF1EhTm3x5TA3Twx2kWNjiEmAjLUOz8eHVq2ssQOGZrqeMWjH31a6EI4P/IB2JZ5d
    H4V/3nLvtBP+facsfxhk/exUdovOu+eaeumNXS0298sxUGOLBsIWr3wLxLyeSKH4eCfmVP
    gz4upb0+OVqGFcHzKVSwEzla4WCz0v4E5G7TJkbOJ2+mDHmHXVd3969MaCUONgnvq3rGrH
    4h4RcwAKuHkiMF3lqk4eigLN9cC3NUN9nyRlxrxcPxTwYdUWx+hAIdLwPFD7yhrj6KG1Uu
    9FP7skw0T2pm771hfjhMAQC/c5jWUc9+mVsfxDhk/Np9TrQ2jaQNm9lJTLQtEYwXe9I0sZ
    DIrKK9B0BgObVSnRINCe3W+vlZBXr+56DZbvtvP1bHBDK6DVvoFvs7MmrheN23URXkZRAE
    937I5tJ9Hq45OMbxe5h7ltBv9VFjqJHHZgLJrBWSZhooohjNGWrZ72i60ti7wqTgANf756
    MsI0sHn8VAh1/k4+XMZaN8E2+poh2G2vJxsDzkSKr4MJQWRynPCZQpjm0sYHhL+SWVh6QC
    iC7sRJdGoscg4Sl01SBt/tsbhKaf1Pkq/Ic6CuuCAWA6ykaDCCla3n46eJm/Nzlk7lrAI5
    JAShBFseAvxsaV0FsnjtxI012qH1tr7YXz8NVDO2uBPsfBjlavdZaGpXG0uw
X-ME-Proxy: <xmx:R4HgasaBEi5RWMG5Hji-pR8NHn0ANpdh0I49Bto8wyx67YRGnQH_mg>
    <xmx:R4HgaroaJjbTqitXEyuqtt7sdC5DjcIReQ_y-HFlzs7b9uGT6Ok-Aw>
    <xmx:R4Hgah9qX_tQ37nWTm_R0Zj3XLhAKSYLTOmJBdmJJWd8gyKVSeYD0Q>
    <xmx:R4Hgaq8Si4YQD9hlrNDR8ndeZqpCO-ufOFSgRQSoIXaDC24_K13YSA>
    <xmx:R4HgarjOYkepxIgSVBJmyIPQ3wBqzsd5YjuObLHqdhIE6PSMPTXdjPU2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab74f588 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:55 +0100
Subject: [PATCH 12/12] builtin/rerere: introduce proper usage strings for
 subcommands
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
Message-Id: <20261027-pks-rerere-subcommands-v1-12-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 80ecca1fe0d..97a08ecd6e7 100644
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
 
@@ -164,6 +183,10 @@ static int cmd_rerere_record(int argc,
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
2.56.0.341.g393f52fd96.dirty

