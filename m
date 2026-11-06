Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978081;
	b=v1NcC/DPzb6gR5nNis8uB1+RhSISfdVcnPnt8hiY9toywr5ssRnzdZCCc2PTGnBVEv00
	 kBV+c7mBGNzkyCC/juTdBT8vfO8PMVJq89lMLMekK/DtGUAPvrfjqjzdSJcRxdldClr05
	 XT+f7t83IQzkiUAHZxu3WPJUze5Hj9PeowSlx10RGU5l68nhFoYAuwhYQ23carp/cktij
	 XFfYtWD0z4JVK/q/qbawb+e1BOuNN+JcWrFRGX3PsJgqMoUP8IqmAwlpxATIFOPcRXQPq
	 UCqQYmYsojlLgYP4QsLKVnB0KsFAiPJMmUT357hxLIo6VDLlUn46nmjRe/nA2B+GTbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978081;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=EKk08N1jkGAyefDeCGHuUKsIu93fmCYmbVWy/Nc/WX0=;
	b=pzpdeVxdzbA4XT/lxGgsHtG/o/LZCeW2By4983iI7lFK/yqqqI2/lMRh7kfrIluxbLOn
	 OTAhpvRVpsIbuyKDip0Kw24Fr/liGKWzer8wikoh1uXnGwI2vhxDMnTV059/1Pb1ONT45
	 22YFkAbXDzwhVnJkpzl52jgJse5WZgCe1qjWT2RDokrjDx0GrjAfkmse7SiWTRLSAJS38
	 O0bl7Bs0/aAo4TxRJNrR/7uXLgBbdPuhJQeF9Tm77GGQAemsSORdsR7nv28NCfu7eP76R
	 MjlfEsjxpoAfLj8YD49fNwkZ40LpMq/dSh5KrJNmeQbX+Ns/EmmWUnsDXABqH39L4WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=lyUu9Uky;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5WLd33SI;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED2606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EED2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=lyUu9Uky;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5WLd33SI
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABC8A7A00CD
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Nov 2026 10:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978080;
	 x=1794064480; bh=EKk08N1jkGAyefDeCGHuUKsIu93fmCYmbVWy/Nc/WX0=; b=
	lyUu9UkyErzqyDKT6bUGK5shb4x0fpTHqMKK431o7Bl9fquxo5Zp+K1RZ0JRogiB
	XDGIrO0ANQpgMi3K7WhTId8+ivBey0/+pKvk0jdh0qWQpaiF3xryzc3VTWKiGRe7
	zIaP33ptpLyA/SHZ66gG5ldnV0IaVOJz3XgDTesViWlsos/MmuYnakRyCycI0a7X
	UVjGeVYA04/wN9VBakyXztLCXdj4NMwu8b7XbdLyleI341pizLRiD76PauYKl+yK
	hdOr0pQCBgEi4fB4ZzrYHtjCOijbStBzQTxcHPK+xzukDHq7uPhU1AVZtF7JGcaA
	Ro8zDiDwr3D9mcLoGHMhyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978080; x=
	1794064480; bh=EKk08N1jkGAyefDeCGHuUKsIu93fmCYmbVWy/Nc/WX0=; b=5
	WLd33SIEMrPQlLkn9VvrAH1mh9+9j/4FDAFz+YdLLTBb3IjQn693/IXUawSXQEX3
	3G3BadekKsjMwzVqB2xypJ4t32cMVpywdvshR7KYuI5VCFe7GCVLEt+bT7Tyw9+X
	w/i80l2LX+5AQBQlAcFf9QLByq2c0v+mLGN1vEZBFZJK92zwNA5pTLTsB7pXohVV
	Hij0c+UJpH1+Gt637C7gBrRf8PstTHnJvpDaEBwCuk4PXiC2cMppvtJwXKCsYdt/
	zOlSKOTOgUpOfT0VHHgK6bL+mmHBqlfLRyJI4dgRy93yURoG+WR3AZ0lyhS6KXb1
	vb0j7BakAwU1DdIGpz4oQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978080; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Sc1VOkoA9xE2nzVe9i/H/feQCn9OeJLU0GyHN7+qd/Cp6lV
	CYzCX9wyZtVdha92217oaEbYmPxeGIQ4IPQg8Je0DU0yr+Pgro4ZxHQNnqJO5HdQ
	2/bKBuQ8xnlWskx3FI/dj38pqul13r8Vj5GpaQRqKgwiXGvw31E7xnicrSyiQouu
	Bms03v3Ha7DcT8U9GIcR9H2VmXy3rG0CDsmon8K0B+RJDitrqMdDltpALDcEW9W7
	5XQ4FYV7AxlvpghKc++QDUYo9e1QRL2bu6t18skP+8ypiBZyLkpTsSUSkDsGc2qu
	pwS2st6Br+XMAfV+7kRQA1ofJ4w2g+Kdi8AWEmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UnsR3ECzcwONBDDQFqa0DT/VpE08gf3gyw5Trktu6aA=:0M/Ads3kOdNKVqJezEAuDX9nuLYRtrI7FPalh3Gjk3I=;
X-ME-Sender: <xms:4O7tagqNPYZb03kewlwhLlQjP4R6yllxIYO4yfl7oVMnYUrIrM4xtw>
    <xme:4O7tatrJUoncvX_aix4uEv3NFLNyWWZcrGQEDnbIye5gAkNZ5zbMdKgkMeNckRw2E
    8Mt1K8rl2CW7k2MqU8eBxojpdfjLejrXXSHknVlNmL2UCNFjFo2uERM>
X-ME-Received: <xmr:4O7taqPbe2jw12NM2YKllqS7iF6vfWyUqSl4hz4Kdm7KslOw_PDVKo1Q-8aYOB8ft559xg>
X-ME-Proxy-Cause: dmFkZTE6ZXomNTUEL+e+IBM9J3WFYmVrzETiuBmHrXWYYpnYb3z2xrI2H2p3wZwHzIHUdn
    Ht6i4N2vYg8lTKGUn7nfYJhDCfOsiAX5Rb32S+0JuZSade3ipv3pJfoUQConGSwrl5ivhb
    yh7wnfzdvyUNkPwO+43Ods+U2NhkEWiUxzAUTahw5lEchXM3ZWgoo8/VsGgojq0Va2Rgff
    TNYXJkX4YMP88ocNKjUcT1QEWVLVfhEf3nFm6jSS51Gjfvq4foEmVCwV29RQ1ChVaZY/82
    sJU8gmt+TRcSCUZI3nbYq1W2NWgvfELKb+I6+WztnwLUYQ4iJzwfzWCg1LcHNCrORVWIfp
    1eBaBxnS9mwC+yG3vIJt4T3VPo2o9WrACjo/BbUwOYjEFTWVwkR+wVvNppDR0A2Vd8gXfM
    1YFh9vSEeEnIlXZq2g121FBGo/195NhuX33prPl2LAd3Lhno62jjXVqdhWDp0A0PY+PTel
    tWnD21Zj/3htYib6lagW+fSOGMJ0nUmzKsG8lAHcjdcei/bqJlxccSaSKkfa+QMSmEW0Qb
    kNwJnHq9W0mc1KPH7QNdrjH412WWyBAHIN4oQZAsI7CtzjXcGX8dmeot9cWS4iK2qpO4zY
    kpWJQQtrU6yrm41YftMMO//eekg3iz3KKtgnBTwdYpIcwCftzLhhPp6ruGIg
X-ME-Proxy: <xmx:4O7tamwEdXEF6uFX5XrmPjx3sycfgAdmU6UlwkS4JMnqnLPJfD6m4A>
    <xmx:4O7tarsfndkfBopy-WVdrvtqUNSamvJ9ASV4GfMXBcWdXJnYichp5g>
    <xmx:4O7tan7SYov5alD_yEyvPqBDM1rl4mTvslp4Hv7xbBfLP_ZJiIdG5g>
    <xmx:4O7taiTnQ_o40_rMt75xoNmUC43NumPyzfcsu7OOtYzrs9gCw3LOCg>
    <xmx:4O7tapvLpTokq7mRWXbMMt3LhhJKKYcQthdGxHU8iII-LgfdshPFZc_H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c2a9662 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:14:05 +0100
Subject: [PATCH v3 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
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
Message-Id: <20261106-pks-rerere-subcommands-v3-11-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.56.0.500.g5d06dc02cd.dirty

