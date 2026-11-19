Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088885;
	b=t1VGbDjSYczDzx0ejOalhkhUVKqvD8la9Uem4uv2q6x7Xs89/AH8bjOZvTYvndTElVQJ
	 ENJ3h4/BnnysB6CXNK+FcKTsRqnPWqeUBXb6qfVT5KWUV8Dlds90uOxwFIqCzhIDv/FX4
	 71nnLVn3fjtiOkHp9okRiRa6cIX8XvRMwUUngonDHxSNww72g56usYNTdUQGx5921/UMf
	 7E57xHuLEt4nzGT0gXMJ7D0N/pQ2hWBr8XCQycw2gos93GWwkUr+evy5JO3Wz0B3Y+bjY
	 dk6nFd0KQR6WShTO6RZWUd9jUBfteaxFqOpfknQ2JIvh7W1QdQ3LrJKTEVfKxuYzArw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088885;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=1GLCrj22gvR6UJJ41aXpCwMw0/e248y8KfqBCny8xxE=;
	b=yTJpQ6dj+mmDx4ekZiCp26vuKOmJy9SkBNaMctLnZfqAzlgEnaC3XXYJAzo9NNRKEfXH
	 dJkk9CLidCQsDjhIYmfLQj7RnciDyseb03xuS3rZJIblswLuupOIZ/lUakQlmLdxL/9n2
	 MCEzqPQfY3B9yxXaj+hgeF7ooxXy+DjL2XfICDcIozikT7FD2+9aJSHZBgafvXskxgxi1
	 z9+M1zkFiD3H15PBLpIQKHX0LBcOnD3Z9QF79qF6SM0GXDwzsJriHL6MTQYodxSHCM7Gh
	 1HpepDf51jrUENq78AO7o7gK2AaROgU927fWHFV32cBMFeTzHOudTapr+NYGfOIVOPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=k+93LQK+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jrBBQdwa;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B405606A331
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B405606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=k+93LQK+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jrBBQdwa
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E00B014001C7
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:48:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 06:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088883;
	 x=1795175283; bh=1GLCrj22gvR6UJJ41aXpCwMw0/e248y8KfqBCny8xxE=; b=
	k+93LQK+A9ptEhVa8dt6iN9z2oVMqiy6klLIx/T0qo1i+cS7f3EXi2JmXLkV3wE2
	n4cCspJpwr4wd6fiQyRbHtJAjXJkrYXvB30Bdlhv/4vzhLnJ5QDnr1tanWAmdQxo
	1TAgVXwASt5B0M312kSW1hYSiAHL3k3TgjV6I8WSJqFpYctdjxQXKIIVOmg/sqIW
	EgZVtRRVCiW2x92w5qgDpPMDiiN38zDQFGwmatQ0RBWPnGm7pVwcw+Fzr1ukjQd+
	jvN8ycmx5XQMkOOAjLY2W0W6c1xDbvJw/+dV5+0QqVRZQlgjnxtrwJcRBePQlqf6
	AaApl/eouhTmJmc11oc5Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088883; x=
	1795175283; bh=1GLCrj22gvR6UJJ41aXpCwMw0/e248y8KfqBCny8xxE=; b=j
	rBBQdwa2jfYGk/XEOGssHAKA6DAgQREY5FBkPdplMFEyQCExV13W+A1lF+frHY3I
	0Ttg3qDhhfBvQd8M/jKxMlSPFxSlbusBd2WRaudF2n7XrKkQ08PAuFF/+SfYFnjA
	C7bL6ERcM8a+i/edhhBWcryI8g7nWXewrJz+JmCpEGOk0BS960vN6flUpp/sWn4O
	1yE+OsnlLy3KOj8EZjh2GAlb5TUg0Z2mUOneiMmYjpUneSv4IcbC1bhH7y9xZFg8
	wxThnfl8v+2EgoqfrZzo6KqCKHQ19B/lIaeSFRgQ8F3R2x0JQnQCl5dwSfqyIiuP
	5D1aHfwA4KEU1xPkHRftQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088883; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Wqm7Jvpdgg+3CdheTAlZmgSS3PC9XDMYjdNHNNZ9hTWE8tJ
	SXtl/bqgxCmY6Vd2XMzfBkC9uHkY9iQzpgz1BzO1LH6ZqarHe4kfWL/AyLbSoWjZ
	kblfFW45kGknOQkwswHBiaLLjp1cv/oDnabbkKEEqRIQgxwVj0Rj+XJYwjl+6YcP
	bdTKP7HtCdjd/QAwXLXMxO585FTk6SJeqtUd7sxs6IQrVOaHlhxyK6B4OjBW60dP
	9MJNt3QbmTyk9KqjemUHTLu30ARSlYRWozJQhB4NlSswzstoqKQhN/nVDV34CdS3
	AjCs4HExdlwdLaM+ctpK8q6/iwewGTOOsj9JlVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:V+WrMX62gG1PApJqlHM0/wDWb6h7yqJXn8cq3f558ig=:FUXxpzdLp8woqMe2F1LBHH5lDR4XlCgK89khRt4xOvM=;
X-ME-Sender: <xms:8-H-ahSmyhQz_ZYKoDAZZwIzkl03AZyME-XEdy7yJlxuCkcEIH4ZsQ>
    <xme:8-H-ahxvHcGPps_sjne_Rk-XNA4L-OXj3wACAEbXAVWNK_txVXTBso5S58ylzftjo
    sDQ_TptvLRf2MW8mPzZ3vTPNi-X261Fj4IuckPKoQlWw-bY8maMiM8>
X-ME-Received: <xmr:8-H-ar2EFc98CMFt5aZZZbPLcDyhQWuKQ9QPshLpRdkGH8IkWWdIaT4K9KWCF8atdG1wtmg>
X-ME-Proxy-Cause: dmFkZTGNM3N4+b/upjxvcnEBxFtN8qd+Q5zJywsHu5GcN7t7LcWCkkNgsqpHNkjN1G6bPs
    L4xJsMjCjyaRJbJ6LhGbWLvnf2GO3EmiJ/pWD6umLPGODQSUZMFTWyo0MGSuAXDkjljsJU
    i86CoSctK++sTHi72NTRnn2wirmwvNbhUJzvvdrIL+23Y+uCwBruq1iYyJtQLNCSdYk6HQ
    xFoOMNvUvtAkOueMz09bbmxHPiWI81ceuizlo+9UGiUphwtnAofkoKyHTFO79c4+pSLlco
    skIraQY/QtajYy0O3nuIU8witULu++HtpXTyiaElG2lOmDEVcHDMMzZFCukurTIyZ9nzgY
    vRPFaVMlqXWDkHpkmcc+6SQjBJ7rZZjZsMLqRU2t4RKnQqc8PDcqrJK7B+z5BrLV8jN/uc
    ekB/sCXeGvjj0aCJY8sZOlxA64KYqaoqcBWmuVmmP8CweNhJWONGwPgwsyUa0CsJiaxJSh
    aphhN1dgy4XGaQgv9BdvGxYvW6yTP0OvNSg6EkrqyuF2Q2THW+0nyr1vfWPpIfbBOAsjwW
    L+ijH/0mBjAnP1x12H4NtxC0tgvLijovj3g4D7DqrWspBOYxOUE+fs8Uw42MEioHO7eLly
    tx8eNr+Q4P6slcuXm6xTqRnQCh42M60dZ0cWY6lFolx9syYGT5vnsYz28SlA
X-ME-Proxy: <xmx:8-H-an5gx56VuwQo_XoKcKR5ODnBGQEJjjM2w_s0ByZvhed9SAsmXQ>
    <xmx:8-H-amV__qBc1oZuPECQorKfVU7j1V2f2pW58EFmW6cbLAu-77Dzbw>
    <xmx:8-H-auBJg4jAqouDXhOk39uyjLqxO0rBLh6O69q_30_jYFYh1MYZiA>
    <xmx:8-H-at7HsPbHOBkwlRNvjeO8HnYFUDckWKHIFgbRwqbBp8ZN1L9Luw>
    <xmx:8-H-ajUZKvUcXtZbU9Rio8SdE7LPnEDRrXIlfBiovu1sAZMAWn52wahj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:48:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40ae23c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:48:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:13 +0100
Subject: [PATCH v5 12/13] builtin/rerere: introduce proper usage strings
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
Message-Id: <20261119-pks-rerere-subcommands-v5-12-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
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
index 8707c65560d..5f1c0f31f6a 100644
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
2.56.1.831.g720f3f5937.dirty

