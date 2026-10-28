Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215619;
	b=2ree3442g3JHO91Hjo6bJJxJIVmP6YDYDOiHypfkV6sPaRTO5Z9me9q0+ye8vdqhgSz8
	 TY6D54y6FBzOJK1YTu42mKQ/JH57mF6TJoCUPYnNTeGiiWSVxJvINTx7yQ8Ty20vWHkzX
	 /25uhQozP+qObJbhOdskFaRuAY5UIkgXakUg5A3IU92HVa6IRRB6A9N20r9QKptmWxmGU
	 qhG9qZEeTuovim1gJMiBRTZtpLBHzA4swyVQGn88Vd7jh42oY9bFvLGSHIHDjbFwoozZ8
	 ffaRLySBThpEhmvxehk759dmGwZwAKH07o6yQ5ZuQkllKjhLqU0Vyk6lAE8SU/22jEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XTdz+N1utYOwDFuKeBUHafG89ZGTvqNEAsodOG+INdk=;
	b=3HXO2CHFVDRPWMRZOA79D5Y26D63BjvPjEk3osFiFfIRc9/Nv4VAT+ZBp0loFQ/PeX4U
	 I79hA1nU54t/kpbOkIFqJOuyy93gmQMiUps+x50QFXxknVvQ1xvbeWQq9fLC92ovUwIBt
	 SdUvvVTyOw6o8AAB554kDYTbrILxC4F7TgcoV3ju+Y+G4TwjPBU4tzsHny8tKB0oaw5G1
	 VFk5ZbxvwcPLyhEWZvKCuK017iSGBYM21IvqG1AB90PFVrmvw3oV6ywR/VXHMKZkeX78F
	 +VKcfNqIljdLc6ky57t0T1T0kFnATrm1gWxIwp6M/wDmbjXWDi26xoNFafoTJmwKu+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zujYJRO+;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35036606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 19:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35036606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zujYJRO+
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c45551fa84eso140255366b.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793215617; x=1793820417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTdz+N1utYOwDFuKeBUHafG89ZGTvqNEAsodOG+INdk=;
        b=zujYJRO+Pz4UgjtOGbLAAOHSUBPAvQ8f2AkEd8c4zEfX2rxwgDQ3Ow8i9metK4XaXE
         EloyDq+MJUVP/Jwwnp+eDI2dJ3VSDPm+3l+hGCJYuEavoQiXh6U4vqB1YADKGYeq64Pd
         zIT0w56znoKzJ2nhROeeIYUNdVNgcbYJY+HAiP0p5345t3MvpVSUNBdRofmRoOb/8UgC
         HRDWeBtmXxr7k+uOe1nxop+sK8Wp/Ixaq3q8ODdEKaVGBtVaifU6r5Wp9/EzXIAm/cgt
         0YC+1K05ms5n7Fmt5rxf89tOBBQer9jhjZZA7DUjW5Qb4RReAquHUx9pEh3I4j80aALT
         l3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793215617; x=1793820417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTdz+N1utYOwDFuKeBUHafG89ZGTvqNEAsodOG+INdk=;
        b=L7vX3kxnEsVF05tiCO2X9/65DQ8LpjY1zFNu3d2Gfi48/APjeJ7U1pG1mkFbCrgxj2
         jJGJTNcEyMaxfDfOZHJFyUS47Ekb5GTlvKITDHj+oX9AlnFoII6ff/rcMg/Z8zQB++7S
         n2tngYdW5q0tux2YHXmd1vU5HeuJPBkdvGKxi0gmCz4XtXHPYtZ2gX+Fa+MsKc4nMpBK
         mPPTvrw3s40j3DJCO9ymSOaNXfZ7mFS4SJ7lHpQEoVrCNReArgbdps90ASpT9qWGvM5l
         E7BfS4XCqz46y7cI49t69NcjUwZQB2WMwG3ZlwpCUDZs5CXXTgyyueAjmSxXfXUcDTdq
         uC+w==
X-Gm-Message-State: AFq9FYKeklBicos3RHpDtxaheLOg77LtxZENmMkiJof/3M7p6/tYxti2
	cb69xFFMJ/looLhkG4Gq9cI+Pu6W+JNgxgsO7PahG1Zj7wnO5o2rk9+/QB/yfrlWr5qQqY8l
X-Gm-Gg: AYBFou3fJKQogjNbOnAgbnDuYSTer7AHtapfpweVxn/MSDpwcHbRi12se4h/slIxdQO
	hfzWTbTkwhxSRog4Iq7YeQOErQc7re0lWc9TAc4mtTpgRx7aI7eTsqNwPznqH9xrFBK81T60p/i
	wnIpNTLHGEh0IMlgsj6SbbWp+uzEs5/j6VFth75P7pLjTytPeRX5sFXuF6CkitTrBE0IpIy/eeh
	hnTjDUdm5832IyGMgMwXKmmP3XONGeKfhH9BRszEvQK/7WTVXyTnqaPPst3p1YQb4JPnYotwer/
	42IvPseUoge9AVY7DhLUgISz7GXM/YgicLpp4Rx81I/esop1Kqpy079+3AHvHxqia33af6Z+3FP
	iJs0ryZa1LMzCPFsfr6018HgB/714mAtoJT3op5TXzmILjPknF5xtUUFhiN1PYnocJcuoCP3Kiu
	j4Zld5gT+CMOMloDUpwgMUq48QMRWFYLZXX9eJW4V5qZWuftnSlz7sV+2W8cDkQn9MflLrziZh+
	/bQw3qzJiKVs/kgJJH8UP9OwzYk0xfRH6UbLfji5WlEBce6jE1X0eH85f9+M5I3Fd/YPUfLgZZa
	QepevVzoZxKMOJko6qbRWj91IvFusz5p5APBqIydqS4MqdmCBTgLyQpfXXpFh3ZMSgxTaBJIV+A
	7a3/I+FDRGgNdnnKkIAGa1H+vHAY9bSo8WowAntDsqmo766l2Ml8VK1JPJ0a1hEuPHT454V5TLD
	f43h5c0CQYnZFKhr+d9fkf7G8=
X-Received: by 2002:a17:907:9606:b0:c3f:dce3:20d5 with SMTP id a640c23a62f3a-c49bdf14449mr289806266b.22.1793215617307;
        Wed, 28 Oct 2026 12:26:57 -0700 (PDT)
Received: from localhost.localdomain (190-2-149-64.hosted-by-worldstream.net. [190.2.149.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd77e1e9sm648493366b.67.2026.10.28.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:26:56 -0700 (PDT)
From: Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: edsonwasswa54@gmail.com
Subject: [PATCH v3] builtin/diff-files: convert ad hoc option parsing to parse-options API
Date: Wed, 28 Oct 2026 22:26:47 +0300
Message-ID: <20261028192647.976-1-edsonwasswa54@gmail.com>
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
 builtin/diff-files.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index ea91347ce2..bd761443b9 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -14,6 +14,7 @@
 #include "commit.h"
 #include "preload-index.h"
 #include "revision.h"
+#include "parse-options.h"
 
 static const char diff_files_usage[] =
 "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
@@ -48,19 +49,20 @@ int cmd_diff_files(int argc,
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
+
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
+	argc = parse_options(argc, argv, prefix, diff_files_options,
+			     diff_files_usage, 0);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	rev.diffopt.rotate_to_strict = 1;
-- 
2.46.0.windows.1

