Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267872;
	b=IPt1r6f4nPSbrE2PgKQi+Hu4SAUly5iBl1p1yasJ7EvloOlgOHiEKRJivGd3ycoloxNh
	 uD8fK3BFYay1W4fzGahOutL3mAYQ+bGRWKFLtglOWNOcNmbl1QBJD3vusYHqWmpZ5o+Sw
	 KxPUXWCQ+Kqw+N1G2hAkPeusZ71Uv4rbeqRCZhNfTqODODw4j+nCizdTESJeBKVHWlTAz
	 ykYnl+jGAhk1oySU1+gaaMpVIPXhr/UzUVMKWJyjqrGkpgg53usnvIcjyvF11/zkQ9/fd
	 Hvk2SBjRTI5fikej6EadGsE7Dayc26uF/k4JuoRLSbqGbt+mI8mTCWRNxC7Pl7BwuPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267872;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=cOBvx1LQqCurkezWDZMwWALP0rJJ245ETNb7H5O0hyY=;
	b=Awn8er3Z7DnJItdAFNDOl6bxG1XJWNKsZduH4MAc+kfA+KOyHU5M89Uc0pdqDUIh3EQT
	 CYJ3kl2B/uiaBn/2FSLJJdmIq9lSImONfIIFitZik6+HpveZmwNNIYphK0A7DEOTrjeV4
	 fhFPaXH/vErDEWG5rGqWu7CrpsZ2N691ACsABGNKJrVLDtpwOcnOdtSAlvZlHatXwi5p8
	 IAuC1fXp1YWmTVaXT608KuyGLEu67IznbHLwdobAkApnqsFVaigiCej7XoWJMV6O2l9fa
	 h9EEZHZS+25/eTsndRwRPsqwVhzlnc8JtsNwuSRmpMvKFI4/HEKBqmIomV1hWuji9eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uRnzomn2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="GMUj5T/G";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A323606A32A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A323606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uRnzomn2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GMUj5T/G
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A0E021D00087
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 05:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267871;
	 x=1793354271; bh=cOBvx1LQqCurkezWDZMwWALP0rJJ245ETNb7H5O0hyY=; b=
	uRnzomn2hfP7SZ482EtTIXgatr9LbhByjznlLyJOoYnnSM0YzBxTnNbKErBS9+qU
	douTwL+0f52FklbwM3EYuHDwsYq851kcVqU90LkrcFLn9qTX59Ltj0gqw7MXxaew
	i5+lx34fHh91ZelbVONNfQYZm0jg1fyRmauWhFWzjYNucmPmeBakuSkBV22GFKMS
	6Ql7FYuhYEiyr1ahpsvxBI5ybQz0KnkFhKCXL34bkNEBPJ/Zz0mF93FAK2/bQMjM
	LZ/sLDnD3Adn24AITN73DY9ijnemdbO+5rH1cMI8BcFumVe8W7Mu0fSRkhtlmJAl
	dzSR+2NNzsmqp5C7f06RVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267871; x=
	1793354271; bh=cOBvx1LQqCurkezWDZMwWALP0rJJ245ETNb7H5O0hyY=; b=G
	MUj5T/GVz6RGD/T95/vxQ5JrpK6ayAggXZXXOVhCfqaRn9sYilCNwIQGsSNBaelC
	gEePx4nvo8/ANkn1wup+YkjTqF92aEqZg4EeeCXUV1jw86uD8IFCRC1qwdCufHk0
	0xkI4LWgz6fHjGsZuXe+ea8UryQxZpjmPkaDQDmBVIJueiBgQ6DDOq2lrALF1Lz4
	fFt5wxhvhkMZmS9CeZUH9+nCGcC/N9zbQHsj5fIWkiuwcuDifKjOHxjILWaA+u3M
	NRzEKgvOOx5SF2BCUVjnYIQculSHtzqTYV3SL3JbVXOLf0+DnHVc69mNUPg6yznv
	1tHL84olnICCVmCaFldqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267871; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AEgYis+DdXKEKKnLn/cR/6FGZKXt3UPjbfTESHksPsa4fLR
	HB31ZiPbNWBAoL2rJ2R9Yn2g9lp0spTAcqVuH8f8ARqfQw7tSaVzJ8Nj015Wciv/
	VUpR/UxzZGKbnen/LDS/KETf0rRm7ADQ+nYzINu2+apeLf8fsQlRn6agKSK8uk2p
	z6JyU1k8sAFj1knIU7UI+4DwNUtwCQlrDM3wHXFZWuwO3rbHScRsov8sOF3J+qbk
	sjcvdwMq/TCsGdX4vk5GfawFC1jlGFPjPNXsFQ+br7NsTwPBfSPgI9E0HWposaAN
	tVEoKb7GCsZfmj5DMcFPzxseRNiNqAgtNOMIL+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Hu6VzgId744QAbOIF6TN9h+naVCHEz96pLxbraW66eM=:ic1qs03GWcbaAAJLRcZt65ysXKzh2RbNub6FZSM0Gyc=;
X-ME-Sender: <xms:nxjjaiiXlXvhNL5czlUn4ajnLM9YhnG-D7kpIXBAeQ7NWx5HB4gByQ>
    <xme:nxjjaqdDMb8_bp7DBzS5w53R5E8T2UHPZ4Cbw8WUyVXA3qc8pR1VA9FG-jEtOHSuT
    Jw8YBoKLth35NciJB2le9WgV1gKpXcizxQXgVTQT907uJ8Kv8K4AtM>
X-ME-Received: <xmr:nxjjanfgMw9uiDPlk8S5JpuBdRH2tsiVyMXYQ9FWrSrXvHOMjFfouw>
X-ME-Proxy-Cause: dmFkZTFuJOAbUzu7EqolGX4mnxJ5uaVCBZsKwAgx+zFu05c+EPsW+5N6DPGUvU5vEt8Fq8
    /yfXqQoyjlguRMf3IINfNHKllzqR3NPVl+PcCSOZBRPo3hYsU9o72avu+S+u+OWLIK/UuK
    fSTlQJ5iBF7m5ST3XNkdoLZc84/Gp9ABF6POCKOtHs4wyqyc4wehYJKzxSTgPypokt4X8N
    P//SCnNcG/PpHnqtT1TGVpKXR4h4nrwtrfdXYcpT4qF3GxKHy8HbwP20t5q61TKRmeufd3
    tN2MrHYNln2qb2vDurDTJ9k9e9m4ZiauCDxxKYIZkIdG2qGDp0MXYW+lLI5KNPP4fLAJYX
    9FV3h20cyL6k+Vj3GhcZwyPa3vaP0JNaXh/ZKHbI7tvKFLOj1d6x9L5V4I0HClsb9M/1UA
    Ksuz8Fjat5Rb5Dh55ET6o+NjqAq8V1WvIsVRume+au7jBrR3GgBpmZV3O20inPxpXzaTr3
    rmANF0uZcd/CCqE7YTKnCa7AO+Sr6wyHhiAXw4M6O9JtaOqHg6iOf5P06chj/y7yw+7j5W
    63GQHLZCAvaKaDNsH+Jcw0O3H0IVTi6PyO+o9kd9au3o3B7rm7aapVOr87N/rzSzdKposm
    68/Ew2LvefmvI+ztcgBixNHXf8DDklOJOIUyIp0bZZhJOgq/8in2eyhOQAdA
X-ME-Proxy: <xmx:nxjjak8AQB1Uobsni4YJPGutYDJAjfkGzvAkIEzY69-v3FNiGN8qyg>
    <xmx:nxjjajmXvCnMzC4NHwsXjomugVWVIVKpSL-bMVFwtmZCb25L_NlEXA>
    <xmx:nxjjam8aRxa87JWmxCgSHXJJ75vpY2jUfqdsndiWfi7C7CyTmHvIfg>
    <xmx:nxjjahkFLWx8adxsslGS6m1b-5eQAIix4UTEnjfNRtaytfbQ-TL90A>
    <xmx:nxjjaimR8jy3s9eWKe2Y-vTs-EkI4hAaJEXEj-c4PjReLMlaPYz9GF6N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3eb7e2c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:20 +0100
Subject: [PATCH v2 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
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
Message-Id: <20261029-pks-rerere-subcommands-v2-11-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
index 3162b074ec6..97c791e420b 100644
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
 
+static int cmd_rerere_perform(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
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
+	return rerere(repo, flags);
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
-		return rerere(repo, flags);
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
+		strvec_push(&args, "perform");
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
+		ret = cmd_rerere_perform(args.nr, args_copy, prefix, repo);
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

