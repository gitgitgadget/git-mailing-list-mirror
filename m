Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088881;
	b=amVNoTM1tBk5mgYDPN14iHJAH8hRc0b5tLtxaZ58n01ptn5l2bmzeO4ErMOQGF6ufWV1
	 rGP95wczLq5ox5KDov3KHIi72FCBzuXpc7Bd/11xTdNcO5APoTtHZYZFVdK1KxKxT9/r8
	 oJNys5PuTfk0sN4v3uCc3Jx1XPAJmAon1J6jbz/xRZO0jhY5E7RqIhWw0bxlbDoRe7lQ9
	 ZqHwIQAC/OBlhwDjaAF7rhrULl9YtNUACoj4lkilfeHzG9v9WpT6RlDzee0/f0PemRNo9
	 HpQOdRQOpbWz+FmEnaQ2prbTbAAyzDWdLgmwzC7/QA7M8ytypb0uX0+GA5aKGI2eu2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088881;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=aFEbOMUfKWv43hCPpsdRJ7AEimVwSJwSuax8drZVfHY=;
	b=ucxrM2h0Nv8zzZFXz8r4oKntMGawckOU4io95EOpaWYnes8efu888PWZGoJR4yCzdko+
	 hadpnmCNUvmZh4dYVCsDZ0vHazmxuI+zwthzgTAC9/KhHNypeJc4Dl49pCkzUr9Pt1G52
	 tELJ2c+ZW1fqZ2SpOTPxgoxvFnuct2nTURykKJAwm9r+qOQJBf4lwBZqLIBPHuZ9czcfm
	 Fo+GMWDYno7syin8JNNEkg6ZvstQPA+KGuzL7W10Xz6u4gPX1mQ5YuFFcHk78GvbMIXpR
	 n16d6N/p2PAZRzUA/ll5HF67gNAMQYFkTI6K8MdhwDnRqax+5zKcf5K6g52EyO6g1Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=zruFPnF+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=6AmrqqWf;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97E606A326
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E97E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=zruFPnF+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=6AmrqqWf
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B77A2EC090C
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 06:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088879;
	 x=1795175279; bh=aFEbOMUfKWv43hCPpsdRJ7AEimVwSJwSuax8drZVfHY=; b=
	zruFPnF+tpbIPMtoARt1E9pfqEq4Umj2EPAiExajhRmH2lBCLC3FWAWNHlrwFepS
	cgOsqTAnI54tLbQcdvBxg3c4Ct3DE5fEQxvWqgzOa2wC6qkxzumf8iC/2i2i2GVe
	8jqiH1Dqq507FYRkbmSug+O7FogBe3Ws4/fpcowsKJHkiGreJxJgnoqreD0VsI+U
	AT9hJgAK33v1RV/b1oxhxixy9XkOtWQMyx8K0GD60R0Ya7lQ2er4DXsB1uZFAMG0
	mPb9070NgnFlzdAwNxPl6XCyeZfhqtgzf6Jbl3rAOHxYihUmYqiVeSxIIJY8TtgH
	lbwPQuLEJbQ6Y/PC5GYh+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088879; x=
	1795175279; bh=aFEbOMUfKWv43hCPpsdRJ7AEimVwSJwSuax8drZVfHY=; b=6
	AmrqqWfitowri+SOXUZzq/nurScpD8sDYmn/oV/OqEdxUtFz775bK8bhhnIyoOJN
	gkvk5fDZRYJbu30BFY6k2wDJhJk4OjcOoDBg7Zp3Q9+yvePVPTvC9xkbVFAZmH7r
	mHLy4EPw0ecgBBQGKafkq3p40QWv8CiNKUbkud/tya2TTqjVJDdW41JbHjnrkvla
	HDMMKPdGFoHf9LIK6VL66bH9DhiKTIZIJD7wKadOx53diowQf4mW2GA81tbG7POv
	ELwTaSCwcsquYndDGXk8Xrb7HK3rKFc9n2mKRR5eMV/jZISbI5qCKR+qKi4DiOKN
	Y+I7JENxdr8eQWUIgVujQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088879; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:K9txKsSqoiI6dHYt9F5jgJhtvEDt9XFG1bsgpqc+Alr3p9S
	V/iRQWhkiq7mYjZ6By3bwmMduc6kNhk1xQ+SUt7x5+PdzAymgJrWpQXuSXpz6UyG
	0zsDIdfZ4yrVCMOa3iSwdjY7MIyFLkYuVPyk5S1qMT1+8pYTq8/fszZidoPFup9a
	yCjP6LHvSJWTDbzaiQlUZXhQk8SLvz68NfFq8+ObqxQhPxLxQoEqjD4m9Pkt06GL
	oZ0KSYQmhvvKR/rUNgaPQ5HU6le8St8IVZQ9VHrUwMtpuawb7Zadn14fCDFFUc8w
	uZRFfgFvEbF+fnLNmrl7AGnY5yvlk81/JDsEvVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qlQ7E/oxMcuVHRZqh2gNyPQ3+Jxq83PKrPpZV6KzAgA=:hjyCBVpxGULhaOJRmFpwB1ypojhVOzM/bs0p6F2ukH0=;
X-ME-Sender: <xms:7-H-alUy1ByVD124Ec3czLY3RFICGZ6iC5MUeYd4Py5Z1VW_nM7uzQ>
    <xme:7-H-asmMHGvTkFOGE2csIJx4ialqsw02-ObyU6zYASJMLeHo4Aa401-RLPi0dNgU4
    oVMlEW6l6FLTj_tBxBOtXtR3-blC_qbGC8P_bXeMFvvMp8sDZo9q50>
X-ME-Received: <xmr:7-H-amaV2sZhDCUN3v23VD2gKeakD6GnHLC8VHRoqahe3Uao0CRhLWpZgdS68LPrvE1i0C4>
X-ME-Proxy-Cause: dmFkZTF/32wl6FlpKXUHfxDcn1hTaBTCGMOZYqjGsfBaiGnyK0sV8kUgsMh9oawPIaQSfm
    S00uQyU1+y5i9Vy3XCfnf6ZL5fdWJUQvNGpMCsKbdbM+G9Z5rOMQsdrAiDBKdZCovULz6e
    QmbdjYc1AUBpn1E9S8uUEmtWDiXcB3pkSu5D8Msg0jZcvKbsNOjPHAWxKL45DVeAJBORet
    DuhXt7C8VNmlTOezmFd0hW6n4cs2G44dcT2yuGoTpYkkoj9i8fC26H/od72nespxayRNQg
    OruLeNIwqQHuqGbckDcC+lVIz3EtwZi90PhgyNB9/hGvmBNdckDRxX5Bl6stfzCMtrnJo5
    CVz/xScjt5rC1igvRJYKTGhLGwSIP1e3oHvOkFIRizoMUcjIZN5Jb86jvdK7BjnTfH9X+Q
    QWT+XNcVWE4zLNbnH6S6SjFhIaZY+/ompIA5BqhrE30BnEOP2xgxkBx0l9pIQPOjYQ5Ism
    nATAGm/O/CFm4jWzTgNt8GxipUp0Ak/OGnzd+UcwK+5BkMGHPoUIIJV8vBivQGYE3xjY2Q
    nCMSm3F2FYeLVJ+kQcPrFKP9MZmVHgRB9ea4y8IrkmTpFL1UbIq69rRje9sZAAc+DhHSB8
    8ndSz0P1odjEc5h0KeDx9fnX///Ax6uVkdCF7neILynyua+bsuZtXyuOrY9g
X-ME-Proxy: <xmx:7-H-anNOcxRaNudCxeinF44y42KRLXOBrT3KZm2I9z9r4lyFQAwFlg>
    <xmx:7-H-arbu2AYA3qqcOvM6zNurBTMTo6aErMPkUvO0V77rwA4DYe24Lw>
    <xmx:7-H-al11MwPsYMVJ_hg5g3rmW1TJRTCWsgA2qnuigXJAHKr7sgFIUw>
    <xmx:7-H-aheaAfjd3aZhi5Xk4cK6lSj40XqRFy4rU2961QQ3tHYxFB9grQ>
    <xmx:7-H-ah43YkMBXhoa_U7tLg1BES0o43qPU3TpB3UxCrNPKdwB1MZZXH6B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b55c9b2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:12 +0100
Subject: [PATCH v5 11/13] builtin/rerere: use `OPT_SUBCOMMAND()`
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
Message-Id: <20261119-pks-rerere-subcommands-v5-11-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
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
 builtin/rerere.c | 95 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 29 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 3162b074ec6..8707c65560d 100644
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
@@ -211,41 +237,52 @@ int cmd_rerere(int argc,
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
-
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
+	if (!fn) {
+		struct strvec args = STRVEC_INIT;
+		const char **args_copy;
+		int ret;
+
+		/*
+		 * The user may have either passed options for `git rerere`
+		 * itself or they may have mistyped the subcommand name. We try
+		 * to distinguish these two cases by checking whether argv[0]
+		 * is a flag or not.
+		 */
+		if (argc && !starts_with(argv[0], "-"))
+			usage_with_options(rerere_usage, options);
+
+		strvec_push(&args, "perform");
+		strvec_pushv(&args, argv);
+
+		/*
+		 * We need to copy the array as it will be modified by
+		 * `parse_options()`, and if so we leak the strings
+		 * referenced by `args`.
+		 */
+		CALLOC_ARRAY(args_copy, args.nr + 1);
+		COPY_ARRAY(args_copy, args.v, args.nr);
+
+		ret = cmd_rerere_perform(args.nr, args_copy, prefix, repo);
+
+		strvec_clear(&args);
+		free(args_copy);
+		return ret;
+	}
 
-	return 0;
+	return fn(argc, argv, prefix, repo);
 }

-- 
2.56.1.831.g720f3f5937.dirty

