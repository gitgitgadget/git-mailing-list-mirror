Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306361;
	b=ouMgONAEbOGWW4kNLfvQ+zDHifOoBCUyB1JWqZA04hhznSZ0KZi47NlSEfoDNQGTR3wW
	 vRCUzA+Bt413g1cYhl6ECqUcbdO7bMjKB6yeU6ICU9fjyoLHr9/R4ZBBfaD98lsVmhZWI
	 heKC5PKGeyfsAPlu+/knTVU2hwlzQX7DTz+Ii/pmMVXDdRqOnJ1QTSjpXNT+UqVciNePC
	 kg/i/B3fioBSPHBMjP3fCI+7sD4tzTIWaX56c45Zc4NBf/4VPpBaYLZ3C7gePfWWi6ecG
	 yXSBE8/UkdbRZxaUhHHC2nYwI1HP+LhPSVaqZSHbT0+JpurLoQp1vbfzJFGQ78yv0pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
	b=YomU42UtuIoc1htNTGt+efliIo01Qb9KdUF/PVJwIA8v6Qb1nCJOBz3Sw8S1q2sTr7nx
	 Sds7yfVgHHn78govMLKL8QhUx5DJCS1Ux7ASqw0OD7je5LvRXDbxRDd71aNIgFgGanSvU
	 JPxRiYYbUcIudAawocRdSPR7GCQRYAEJASQd0DVakn6GYqBWE/FG7VjVJu8g3mjkOcUoq
	 OEkm6frOGBpGYCIlN2STh3fTyUFQNM60nthm3oQERW1tsou8sK86GFugL9yCOw67kifyq
	 CsC3awP+pDPXizK+m7JDnaUwMqxTLuxCugPxJeQH8+dMs33+FjN1+SD8Mn+J422zkyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hbnNKWso;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D9606A31E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17D9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hbnNKWso
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b060ec084so31056f8f.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793306359; x=1793911159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
        b=hbnNKWsodN/iGvvnHQKjOtCw5iNvh6UtmpUsEb44Lvt2ZLBDPfTDSu/joRYcZ1Ajz0
         Vw+lHBREX1s4OLsiSl8q/rJxIN7TR/trFhLwLnNIi0DK24pfJOrcMDgRfkLYtLwflY8z
         CHDp45qk8ZKajEV8uaMbarKohUWJp3vGJmwN2hSHiFa/LcFc8uxq3c88bQLJFhbm6dP2
         24afzigNaxY1MfAI2IGF87XtK4CaZ0hhuN3yL2PFqqMwaR2NIvB1R4dcOnCHoUKRYiAd
         GdA3ujmTN30X4lb1dysAWil0mJ8oZ+lArA/++7hW0v0iy3Q8DYiy+9rTlpPW4J47iJNW
         c2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306359; x=1793911159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
        b=BnnXOYVR6hU5FC+g6hZn0GTJJke+hbJ1upVeZ8g1tets8/En6OI3kvSVVsI5RmpNcu
         /RXCfWrtkSNHFDkPCaUrgR0Lr/TFogGwLEeWqYQ8Kw/aTnGe6LXygJRfJbsh37oZAoe8
         3bUTpWnfVPg10R4tx+ZSd9Z7Pq+gSaF91dGsQnQbfrYQRcXkb+E/HBexLrysY6LajNcQ
         LrW5K5qRevyyYf8OlFM7EqS9ssZ0nKqIrAhi5hlrHwMNg43tWZIEGaxJJ68OkiPKxKUk
         reRjkT0tEzkM2qodWgqAUEno5bSS9KvYOO4VUUMiV1gTwKKuyQPf3pWEmvI+NiOuIbNf
         gDLg==
X-Gm-Message-State: AFq9FYKBVR1l/0CXZUqmmnRCtwEx1PwP3pjRXKOwLUXJXOSlMZnlcuV0
	CAG4ox0+K7Qkm+g2PIWGmy4afmJQAnvNPOtF4vc51rdJ4wAVfTYWrlcqP/zzufRAtRpGNOVo
X-Gm-Gg: AYBFou0cmveZBt6fsmv3i3tv1E4i19tDie/AXhFOSwNHvp4iDQxaNwzMwjaewBXVl0W
	SYBvfZsEhNqEnxSYohbgCZVkeQsh9AUpLPViFsiBDiLWPQlxBRizpCTA58nEVTXQfo/ukLd9Vl0
	3O9ZHQPVDO4IkCnYqPjBzrYup45Nn8tbt9wRziilzGIqTbdIuvgmNG4zn34SO8EEzGS/YTT8fAn
	PsXu2Ana3HFV3R4wejE8Wrr4YXWzFzoiXdA8Zkpt95XlmAxaP1evGJZxU7GqttFPne5POkwdHIE
	lKqn9Sy7Dl5DfrOwhACkNQrKBvhWkCCyJQsEPk2na3ZcSk5I/NHwxW09ZUMvXdCL+HOr3W++9PA
	wUD3I4AXnbcwGr4TLD4Z0L24VLWjoZtfMZt0XwJyort/ZXCoagoYDpjgqQnboHKzE31DpexNWr+
	1nksq0MdcmcbB3SCLoMtEG3PijMpLsHXVgX0D41YCDrwnFl6Izg6/GbGhA91GLDLCi3lcyfP3NB
	Tq4vMcB0XESQ620URf6MND/RfjJNJWjnbr7NzJ1sRRVfLpWYiEcQZQgxIeNnQgzzvFcL7LXtowa
	KssKogq7bFqe8NNULQzqO+2uH0rTPlh5gEJOGxSE2ei0TmQLBPC/gzDbb2kMXCsJ+CEnpgWmplt
	K6UZpk9ktdEtQei+CwQlxKkODn3Ux/Y5PEuAGd45U3afWwyfIU/1MEcNEHP52
X-Received: by 2002:a05:6000:40c5:b0:48d:eeaf:d2ec with SMTP id ffacd0b85a97d-48e6e3097cdmr1015770f8f.49.1793306359118;
        Thu, 29 Oct 2026 13:39:19 -0700 (PDT)
Received: from localhost.localdomain ([146.70.246.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb8ed25sm568767f8f.40.2026.10.29.13.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:39:18 -0700 (PDT)
From: Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: edsonwasswa54@gmail.com
Subject: [PATCH v4] builtin/diff-files: convert ad hoc option parsing to parse-options API
Date: Thu, 29 Oct 2026 23:39:03 +0300
Message-ID: <20261029203904.432-1-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20261028170432.3524465-1-gitster@pobox.com>
References: <20261028170432.3524465-1-gitster@pobox.com>
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

