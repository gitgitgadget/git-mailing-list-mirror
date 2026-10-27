Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098053;
	b=B2NuFJGaQ+1U7xZO+hT14dulc8Bh95Z8bTJ96ZhumgjdbOks8Fg8TzvTetrzSPnzgMTY
	 +UeCsW/NPtUqALjpOKbWeYpgrE8yFO38Fen6BS4KauTTuBL+lMf71sjwCrF88bkKqbWvn
	 F0RwtWsj3JLtDTBB/scFUBsX23me1Zd+WS3Bn6oGZlA4kpJfER8Ix5hmdKtbNltCZ17wM
	 KEAU8mD/SoRxfIVvmatbSEqNqVILUMceBRmq313VRLgTE4u20DA7iXn15TK2lWmwPbtl9
	 Br/PxWTUuSscl9yey485YTT4e3qJawiwL+vYXVGs9QzZlPCzHtRO4PaUE/KmpZHMQJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098053;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=SiCyl+nPoTKYDrxpLV9YSZy/mzsPJq8EZTU5RsXrJSY=;
	b=cBNt13S5STK4PLT9OuFI98QThXJHDOqe+q4UrwmVSgjKYZZYp61E+ieRYDcVa1RqS03I
	 9znD8v3DD96BGXFl6tnl5IMjVQE8N1vPp+lF6XByqOzlJKONSnTiHtFnUYhEO+ROTqV63
	 9BQ6iEBhSC/gWsnhmRgRaaKRIHCEEvd7TXztKZIM+//Sw2VInGINKxiYtXHcumUAfjPzs
	 hk7W1I93e/XBGyjiTdETlE1sNr+0tJgh8kASF3giSNwJAG538dtxgajKYOCmJ0G6pL9RK
	 CanEr9oPml0OYsXekum9HMV7hvkkkiL9eIZVYZf78y/rqLjDDvIWow/omPbshBM3ChQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=p02c93Wd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QevBFDSV;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD91606A324
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD91606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=p02c93Wd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QevBFDSV
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 690B41D00119
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 27 Oct 2026 06:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098052;
	 x=1793184452; bh=SiCyl+nPoTKYDrxpLV9YSZy/mzsPJq8EZTU5RsXrJSY=; b=
	p02c93Wd00l+jvMSkM039+sslslB2YhV28pewGOwOxojawG1Bmi+vnCqf5HkHJaZ
	fiu1y1TgqgESJ5PCspgRKhgeU16cM96IIvep/t0f8IrOLb9QrC3DfUV4kHDVCFP5
	H2XCoOD0I7ZhcTC4GKerRIjqBaGKN0WjmLCcmQ4D6aZIVvcCdy9rbPt9reHPZKZJ
	GhtL4ERbfkMc3GJOB91Orez1XvWZLt5T+7yP/iWHj+pe8a0rS7sy2Y9uGx6OtY0i
	s+yBlkxtNxlz9zziamu+gwsMEaIVf/nrDBEHV+KOQ8fHcrTvqtIfyh4SPO57gYxI
	qVJFE2QcxAtODRqg8Znu8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098052; x=
	1793184452; bh=SiCyl+nPoTKYDrxpLV9YSZy/mzsPJq8EZTU5RsXrJSY=; b=Q
	evBFDSVjl6Wy1EUCKeXFd0zOM0O0SAj9bbFMxxsSpK3F4rBOjmTs11ESVBJqo5hM
	V4YSvgPhbdOjCP+IGDFh0XQrWHXgUJguMimAGDTbgAujwH32QDyAcCJWRxzcWdAQ
	T05qxZ1D035s9SrrKWaog8P3YV3XBMMCgnIJ3H3c0PkoL7KtiSGebZZ87tN1IVXr
	tkMklInKXzt+wfIFuNo9ivegNZXWGOdickOB6Uca/v7KCD525XxONnOxZbpYF54m
	4o9wLPLk8DeKwq8taGK6JcT0P6P6rpjpOUPE3DnLxeo2vzm93ikd20sFYbvwMVVW
	cVoYaO7zfPU/mPIlcjFfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098052; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jd444xZDmoV3/AsOta791sGxOvCkJgmwOJ6msN1o3Icuq9/
	F6/xVzxjr2OQ/n/l7MPALjwYhZkMjfnOOsppX/HEc3IPv+6HKVTeNt4s3c/G8VTP
	EQRSRSmvt8UvXNQ/fmGR3FVsyn6ZuGaol2bWfXKFpxpuM0p02P5fQCuzQDtRic9e
	ZJw8gkmZlmaaX64ZkbKXKtWOATFrL/qukzm4Qj4nGM3ZqdqRXv95QTt+OijUKLBV
	FZQIkaLMSdv0KuJ35Zxc64W0E1jk/RWHI5ZWJ+HFgJ8tLWCCw7m3YVzEKTwAkn/r
	P83htHc2ykqQjwiOrGmAy5zFQANctUqYKJ5mlFQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BTJGUtDC9P7kOE4SbTM4bgs9CsIRpmYS9wSIfgkRyzg=:sMUUzKm0q8bmBb8WLLL4NyzGXwLxkb6pxzco6icdAeU=;
X-ME-Sender: <xms:RIHgasNeBmSQKKNXuuyDliprwt0GixnMYn7jk1JKbaJmWK9vne__FQ>
    <xme:RIHgap6fPWy9GRHaJ1sujP3A19kvO-SaZUNNTfemOFTklfC_CAjVz33JtuX8rgGh5
    QhtdRLcCVP32GXULhGoM3MLvZXSVy4AJV6A_V1NTopV3USHHEKAsZA>
X-ME-Received: <xmr:RIHgao5VbxngQWaQpdL2CIGX_Y-P4iVIagmTiAd0IJukqZbVTJczug>
X-ME-Proxy-Cause: dmFkZTGKSOc/wTTP6D8MlB4DlAAl3mwGQ3MedBExhMrHHiNRqDl2HTGylO4Nvjoj9ogmBu
    +xC8y71+V8w2dgeBezAtz7QynelTqzOcampIgZwX8bC6U6HHHCL85Ds+zUHe2qEidAOQVB
    5qfuxPSNQdyvdxvYbUeXGaqbcQNenJ7ziL0s0/nm7Z0iZfiRMMG43Z1tV/6MtdhhA9NdcH
    kAZSn3LjoMLLaixvl3L7TvDKTAoN+kFy2CL0w8U/NgPZ23Y6RECVpHzeGZGW6RmrZWzW3k
    wAjifpxRmtmebfdRy/YMgwIuTvJvC/FBLN4SVe405NtxCaGrV4mg8id/rprQwdvNTNLYEo
    vi1x6g12gU+UtoKv5FL4ID/DwRrpNHdIEgi6plKCf8EIFxOnG2qCU34KwFGwmM0PgKkRbY
    2s6gz/nq+wnQHnY4OeOKEpsGkz6taudNQrsVrlTg5Sc/PmyuizrK//vDgnbJKgbZYObmDL
    D/FpKSF3QvnJvC0EYURjlT8eBktSpi6i0mM3TCBbcjbnlCmAQCpsejyYsv0IXcpUgNT4mi
    N04SXtiOv2gVaWJlQq0u9YnI2qpOT2uus2dD7LiQStO6yqwcq/8Pl2pJ8epAavG9RQk1Tq
    te5j2w+O5HzdBOh78rmT4MOhHDoA9UoPZM0T/KvwpP/1A1iTSiq7FNrRkhAg
X-ME-Proxy: <xmx:RIHgap2CokZo7CNPnPWEcBwXHscLWHzMSSc8SVeT2LMfzxaB_0DohQ>
    <xmx:RIHgakWga0QBteIxSGRfwX67rWAeU2qKpLXyPknvXRAusf8BsfKDfQ>
    <xmx:RIHgak4oGCsrytICyMgD3EORuAj4vdVJKSCXHfD97kpW5oZeGElvuA>
    <xmx:RIHgarJGZuiT0cFPOIMsI1tKBEjU3vdapOA5dH-qtsNdiy4-qeNIig>
    <xmx:RIHgak-zYKXecXFvJVbg_gMs3JFS_HOTAN-8wT7j9bxGbpr-mFqQLqco>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72b643b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:54 +0100
Subject: [PATCH 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
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
Message-Id: <20261027-pks-rerere-subcommands-v1-11-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In git-rerere(1) we have our own custom logic to parse subcommands. In
preceding commits we have refactored all of those subcommands so that
they are ready to be used as `OPT_SUBCOMMAND()`s. Switch over to use
these so that we get rid of our custom subcommand parsing.

Unfortunately this means that we have a backwards-incompatible change
because we no longer accept the "--[no-]rerere-autoupdate" flag for all
subcommands. But this was arguably broken and misleading as we ignore
this flag for any other subcommand aynway. So we cheat a bit and simply
call it a bug that those flags were accepted in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 84 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 67626e13845..80ecca1fe0d 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -5,6 +5,7 @@
 #include "rerere.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "strvec.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "pathspec.h"
@@ -152,6 +153,31 @@ static int cmd_rerere_gc(int argc,
 	return 0;
 }
 
+static int cmd_rerere_record(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	int autoupdate = -1;
+	struct option options[] = {
+		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
+			N_("register clean resolutions in index"), 1),
+		OPT_END(),
+	};
+	enum rerere_flags flags = 0;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (autoupdate == 1)
+		flags = RERERE_AUTOUPDATE;
+	if (autoupdate == 0)
+		flags = RERERE_NOAUTOUPDATE;
+
+	return rerere_record(repo, flags);
+}
+
 static int cmd_rerere_remaining(int argc,
 				const char **argv,
 				const char *prefix,
@@ -211,41 +237,43 @@ int cmd_rerere(int argc,
 	       const char *prefix,
 	       struct repository *repo)
 {
-	int autoupdate = -1, flags = 0;
-
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
-			N_("register clean resolutions in index"), 1),
+		OPT_SUBCOMMAND("clear", &fn, cmd_rerere_clear),
+		OPT_SUBCOMMAND("diff", &fn, cmd_rerere_diff),
+		OPT_SUBCOMMAND("forget", &fn, cmd_rerere_forget),
+		OPT_SUBCOMMAND("gc", &fn, cmd_rerere_gc),
+		OPT_SUBCOMMAND("remaining", &fn, cmd_rerere_remaining),
+		OPT_SUBCOMMAND("status", &fn, cmd_rerere_status),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage,
-			     PARSE_OPT_KEEP_UNKNOWN_OPT);
-
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_SUBCOMMAND_OPTIONAL);
 	repo_config(repo, git_xmerge_config, NULL);
 
-	if (autoupdate == 1)
-		flags = RERERE_AUTOUPDATE;
-	if (autoupdate == 0)
-		flags = RERERE_NOAUTOUPDATE;
+	if (!fn) {
+		struct strvec args = STRVEC_INIT;
+		const char **args_copy;
+		int ret;
 
-	if (argc < 1)
-		return rerere_record(repo, flags);
-
-	if (!strcmp(argv[0], "forget"))
-		return cmd_rerere_forget(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "clear"))
-		return cmd_rerere_clear(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "gc"))
-		return cmd_rerere_gc(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "status"))
-		return cmd_rerere_status(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "remaining"))
-		return cmd_rerere_remaining(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "diff"))
-		return cmd_rerere_diff(argc, argv, prefix, repo);
-	else
-		usage_with_options(rerere_usage, options);
+		strvec_push(&args, "record");
+		strvec_pushv(&args, argv);
 
-	return 0;
+		/*
+		 * We need to copy the array as it will be modified by
+		 * `parse_options()`, and if so we leak the strings
+		 * referenced by `args`.
+		 */
+		CALLOC_ARRAY(args_copy, args.nr);
+		COPY_ARRAY(args_copy, args.v, args.nr);
+
+		ret = cmd_rerere_record(args.nr, args_copy, prefix, repo);
+
+		strvec_clear(&args);
+		free(args_copy);
+		return ret;
+	}
+
+	return fn(argc, argv, prefix, repo);
 }

-- 
2.56.0.341.g393f52fd96.dirty

