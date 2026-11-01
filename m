Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561133;
	b=MGlhei+X20AgCkcpAliAU9dvrqUf3wjc3pfpulRv0nyvYdsrjNicwzlVCYMaGsYqKH59
	 lNqbwL17vRuQeW7T1ffPJEDpBLA3vUvZy6yncTbudKvP4XPKMBps8FIXZhQL6N9mu49VE
	 mxE0HWGobC4VLaXHQ7w31XTn2cu1p1zYwwZX3nAAO7TLQjSon2wFSI4AepZanNrGX72dM
	 19d3Oslih9Fjr0hxR9b0twTbItiK22lG/lpW1x0PzJTjVbkByQKDg3Nso2gpCJ7LsoWTY
	 RIZ1asmp/rrd8U+ITK1mLFpdccb/cmZQq2F6fvoyHGu0p93LMscS2FjkeVL+4zosg+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
	b=not3A4rCAx/bm7kDdoLcnYyuyYB4hn47i8OLdbIYGq7msrFIcbjdHfty7rmBokDu5Aek
	 Db0HNBYdTzgK1ipKDn9tKQcsI7CdZBbXJXVb+FSaxE6l7oUW02Mu6+rLCO/Uid7QxqX8N
	 pyajxuppelYRIlEc+LL81j4Hn1f3iGPY5BbgTiZ/mboIUsWVgEhj7vzE6jvDnb6nk5OXR
	 g1A6MUx+nvv4LHYUgyBEu+Zjv6IKXC57m2/7R9x7o0F6f02PqWKIX+7AvO8rRPLCUzqxL
	 Cy1iX1+vVhBAzX8oQPc/kr9W0j3UfBw0X25TqXOK8AZ9Zf8LeV8XAre31cpXoK5FhyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UfOCp3eU;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF2606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 19:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFAF2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UfOCp3eU
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1283508f8f.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 11:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793561131; x=1794165931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
        b=UfOCp3eUtgRK/BoiC0W8DOp+YcAgt3DZpJHYvSKdeFXv1ea08PY2Dz1KpuUKxN6E9D
         BbaLeaduJURh9FQl93Ix7H+LKN/BSbkOth+oJtHXM7Xw8eTyTTQ4uOukPjUvHUHlOIls
         twKum9joS3X5xXodXBI4GwjU0udMPDaR4M0XWpEBBK4YDvFKA7fLv6g8OM6xCoh1pjXX
         Wc7qqnG4LDIRX8Nh1UnALgmcjAvRaa9tTpsHDuxdfYam7IXy75Mx/LNF65Zuv60q10sz
         PZnoIDebX3FZJyxvIbJ/vjC5LByVFlObB4uzP2FhoZuxKXai+SfQkZY/iCVVlbJK30Pu
         I9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561131; x=1794165931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
        b=GuDSuSln3AU70WIyALauPV9yvsy7HdUgn4+wIg6ZDZsmXb7DwxJ63ZWJKlyXBh/G5D
         vOx+6N2ekCrBrkZMNo3+kYohvXUxYdbWInqf9mDhjVlpsXQPY36Gp20rEi9wow/of5UB
         vfzIrjNJQ9qImlF7a9DsRJ1vUbC33pTqOlu/AGyETL1RGYD0pJPda4umrtKYWj8/7zwc
         U0z5Wgfh3XA6RHp3jXFTT0rYB0WSBVFdHUtjQzb8Qef4a0r2UXrPSvZiDx3MY66xciqS
         RrL0Rr+dr/F3ZGCf6jxDd2XJzeu5SzdYV2Mb+8LgC++W6DYfkjW6Md0b/Zo1oZYMkdGs
         oG4Q==
X-Gm-Message-State: APuU4Z+KQzGAnH54l3yRAuRTESD9qVbcuEaIXeeFFMAJIjjZD19Br3/e
	rZoKhob8nmigg1iRL5ChatGF6+ccR4HtBzGZnjj4UVvIJtQNX5BmmlHkrnfbZZ8k5pLm3Lnq
X-Gm-Gg: AYBFou3jukPtvM+HKrechwmj0PxGEgg6h3m2j1OGhKABoOmNor4HnwwE7xyPu7Lxzq+
	GsqQ72dMGe8ztT9MVotlSzDV4suxjDM/uPEqVMbV/K3e5goEDwDpetEh1f49OrZ6jT44OpxFyJB
	DaxohrdqTW8CFVb+Mi5I/IsndyGkE7R2wpyytTK93RbgMRWxk59qFO96YPFNwducTEPf/YrRkpU
	faRTUGoAJSJNDcgdOqCbWv0TQ9E6gr0xnFJoKk2wjArlVwTnyqm+iR+f/QWZQ53QpDlaIoB1pSp
	GMOci+lmYwzJG1GmiLhEamtImBBlOYhOnSVjiopQSid06uA2Ecj4mvwfQ0vFJGuV4rZrSXZlClX
	5rPf9X5MJh3IZc2scyCY0VnC934rPvH09Xs/rPH6UJzwGaK++e34xIB41J9d9gvHFumkgN6HlRd
	pPn9I2/hoaDFJ/9WKix38ODlZJqKQhydwUqe24c1g9xz1ckN1clhdUzXVPKggqQc7g7c0O/e4Ul
	XZlXPNQgPRl/Nu8aRNyoAFvJWVZyUN81h4OOJQ3cd+njgJyCwmEezwtbV1MVhjIMFzd6XZeM9nR
	4CSIA3scShTNPnQVWi5b2QSuZRXo0OY/QgWiHtqzuCdhZy3OgLgyDHphBRtVR9X0xA+gPSXbMS7
	8uagt6DdkDXiO2BwJiT5WHpjwUKK4c+10FkgfWCjZwdJyY3+Hxx0IHuxA
X-Received: by 2002:a5d:5d09:0:b0:48e:4835:de5f with SMTP id ffacd0b85a97d-48e6e4fcf2amr16650613f8f.47.1793561130649;
        Sun, 01 Nov 2026 11:25:30 -0800 (PST)
Received: from localhost.localdomain ([31.14.252.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm15376699f8f.43.2026.11.01.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:25:29 -0800 (PST)
From: Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: edsonwasswa54@gmail.com
Subject: [PATCH v6] builtin/diff-files: convert ad hoc option parsing to parse-options API
Date: Sun,  1 Nov 2026 22:25:01 +0300
Message-ID: <20261101192502.1920-1-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20261029203904.432-1-edsonwasswa54@gmail.com>
References: <20261029203904.432-1-edsonwasswa54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wasswa Edson <edsonwasswa54@gmail.com>

The cmd_diff_files() function manually parses --base, --ours, --theirs,
and -q options using a hand-rolled loop with strcmp() calls. This is
inconsistent with the rest of Git's codebase and lacks features provided
by the parse-options API such as auto-generated help text, git completion
support, and option abbreviation.

Convert this to use the parse-options API by:
- Adding option definitions using OPT_* macros
- Removing the manual parsing loop
- Using parse_options() for consistent argument handling

The --base, --ours, and --theirs options use PARSE_OPT_NONEG to prevent
negated forms (--no-base, etc.) which are not meaningful for merge stage
selection. This follows the pattern used in builtin/checkout.c for similar
stage selection options.

This makes the code more maintainable and brings it in line with Git's
coding standards.

Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>
---
 builtin/diff-files.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index ea91347ce2..e9e4907311 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -14,11 +14,12 @@
 #include "commit.h"
 #include "preload-index.h"
 #include "revision.h"
+#include "parse-options.h"
 
-static const char diff_files_usage[] =
-"git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
-"\n"
-COMMON_DIFF_OPTIONS_HELP;
+static const char * const diff_files_usage[] = {
+	"git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]",
+	NULL
+};
 
 int cmd_diff_files(int argc,
 		   const char **argv,
@@ -28,8 +29,19 @@ int cmd_diff_files(int argc,
 	struct rev_info rev;
 	int result;
 	unsigned options = 0;
+	struct option diff_files_options[] = {
+		OPT_SET_INT_F(0, "base", &rev.max_count,
+			      N_("show base version"), 1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "ours", &rev.max_count,
+			      N_("show our version"), 2, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "theirs", &rev.max_count,
+			      N_("show their version"), 3, PARSE_OPT_NONEG),
+		OPT_BIT('q', NULL, &options,
+		       N_("be quiet"), DIFF_SILENT_ON_REMOVED),
+		OPT_END()
+	};
 
-	show_usage_if_asked(argc, argv, diff_files_usage);
+	show_usage_with_options_if_asked(argc, argv, diff_files_usage, diff_files_options);
 
 	repo_config(the_repository, git_diff_basic_config, NULL); /* no "diff" UI options */
 
@@ -48,19 +60,8 @@ int cmd_diff_files(int argc,
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
-	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "--base"))
-			rev.max_count = 1;
-		else if (!strcmp(argv[1], "--ours"))
-			rev.max_count = 2;
-		else if (!strcmp(argv[1], "--theirs"))
-			rev.max_count = 3;
-		else if (!strcmp(argv[1], "-q"))
-			options |= DIFF_SILENT_ON_REMOVED;
-		else
-			usage(diff_files_usage);
-		argv++; argc--;
-	}
+	argc = parse_options(argc, argv, prefix, diff_files_options,
+			     diff_files_usage, 0);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	rev.diffopt.rotate_to_strict = 1;
@@ -73,7 +74,7 @@ int cmd_diff_files(int argc,
 	if (rev.pending.nr ||
 	    rev.min_age != -1 || rev.max_age != -1 ||
 	    3 < rev.max_count)
-		usage(diff_files_usage);
+		usage_with_options(diff_files_usage, diff_files_options);
 
 	/*
 	 * "diff-files --base -p" should not combine merges because it
-- 
2.46.0.windows.1

