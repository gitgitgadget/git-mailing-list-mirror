Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214853;
	b=bH3NENpy+pXkY6e+iZ9IDUcuBHpprbADVl8wcEY3Xz5eZ3JRJdMxr2oLWpFgazzMCDXe
	 vtMPeqKE/eOB+olmYiCPiVhJFKK2hBG0Vy1PdOIAYxJe102GbAgV0JtOh2qzuMHRPSvBC
	 VfZn2f3xMsW9NJJfSTPr4qqArD3SNqijpjjtiz6U6HFp4xss5zlS87nM0miFns7lNSnlf
	 sAEjusxhQMfYZZMJ+loXhsOIr+uHJYjsmZ8IJ6aBOMwokth3S5JymhxfvJpdoU/SkZVr0
	 JligOwd+03T/NaSd4c5MPKdKHhPiqXoNcI3j3uwbZBgo8reKMuhU+a2T/NPG8A7C4pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BxaB5SrUGGUfCCThpsYEnR+6yBDhE9oOcn+KIGn++80=;
	b=SqT5PXUuIOhgHBaDb8sbpC4J0vS1T9/z+h2sOgm+0XdaEVctsEP1WmTfduZB4jawfyeQ
	 aHseha/O13Icg2MLGupUQyL0l49tDMIWhCuB+P5GzojOVbevBkJCaPu5PM0NsiMoQbh0V
	 FryDTTksxd+TgJkJrZMi+ebPaNsYAP9q4/WjgCeeaZSdroRMGY1qkU5hS3rYoTKNqAoft
	 FSur4Gk+bAJoz4ahUf1GYPMQOTXRi7728d7QUjDL/lMQDKBSh3mZ8lsFoFooLq3lEbkK/
	 lqwRNfhBAUq7t+MUfg/L/TQ6oJm3/avb6N8tx/N3IeRaOL4p2A8kuh5nBwa/tUnC2LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/Z32JhE";
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AD606AB1E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 19:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 617AD606AB1E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/Z32JhE
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b4883643ccso1826454a12.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214852; x=1793819652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BxaB5SrUGGUfCCThpsYEnR+6yBDhE9oOcn+KIGn++80=;
        b=l/Z32JhEZZbayTnlIfiIgl+gulf5Xsdb/KVlmM3rv8aUuGsQe2CeEvpILpn0PKWHpB
         S1xq9TGqsHfhryhlC3sAs7OUCSY9h/LTwYV6ed8KedKuImXcyVpSPihzYBR7yJhqaCuL
         Gcvmc3K8BS7FdnuAtsgc5auFbwjXtcAywU3rebx5891Dr23wEMCEMprPRfWXnvgGVjsX
         qn8vFq+1ZIVje+5FDK1/e/jPq4iKtWw9yKWFa3vabLGtEA8UaUYqrPjrYkBUqMXIEFog
         dPsj82cYCTGkmGNHLjUVZlo8zO8zaIygLvJSFb5uRnps0k5ik/1aKoWBnzcz4F22Aous
         ef4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214852; x=1793819652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BxaB5SrUGGUfCCThpsYEnR+6yBDhE9oOcn+KIGn++80=;
        b=jSC7TKTLbnqbsb5f8NKRVQnfSv0bzkv3KaQkWuEQo/QpiE3ZqypXFqkHe3mNk3+I3p
         yW9uT345cG0K7DYA5Sn18WeA/EZ/Xj2BUCiFLi5e/kTFbUDwXyyEQjSoiO0MPJuH9rUK
         moyAzErBGtcuHm4NkCpSHTUXSke9w5TIbeEt0p78VqLSUlhujUGt/bkHCTsgbA2lgmDM
         APNNzPM7U0//QvFdowEQxzlpmZmfWyKSfPb1GxZ3lha+dCYVOgYIr9S/nZrJy0sXFndf
         iIUOJJhQN6iZfCyqgzWC9io/JYgQaQnYy3a/UqwMiHu1LM6vBoMSjDwEJkTlZ2Rr3cEc
         kLVA==
X-Gm-Message-State: AFq9FYJ2VjqJc1/sqc/yFBmqJ41umKZXYkXTVrPiTCmmmTOKBvbJw4NH
	nPJpkcFtsHTP7Jg7zPkpA9vqA48VwOCJwU+8IWEnCRXpnbHjbkUaWdIe1XZxZOQuhASTm/Wz
X-Gm-Gg: AYBFou2OIV3z42TJkg04aoKrVSpqdnS/HAaIiEUuWZ04qKSf6kKGHqiiBdnCMpL+gRJ
	fBDAeocydlNPcXs7k1ieEht71w/XMC8xw4+J4t4sNOZLIhT4HYY10fTe+WAV0c0gwa78XGwA8B8
	6i0e8V6NN5dA6kcQqZIKzbx0t0+DUkX7AwNtYGAJnAoRm6hM3tNeWmeWeudCD5kYi9nGG6PFY5n
	rQMNZurt91RxtuHx2976Q8EoYvGmnPin/bdWk9gIwaMDl9rR/ZuX6UNBX0AeHDkbTd3tPeiO35b
	oX0QE9wC2BGPxYczssVJCxTTxjCmfcNB+WlCSjYPaN4RMaCEvFmXusx7yDDoc3lEzdC52Ni/9xW
	9P33vGzbroXrXunj40mUHmyh+fJez64+94sHwfMrIvh0SBxSd9u2AXzxkkC8y81P2ebiDn02K9E
	gh5rBnxHu70ldgxYtrL65RCwknSTPGrqZOYUlU/zixjovIc8j6xe4uIi8F8LmcgZb+jDUINtWPw
	SC9IffGEBt0kuZLSxG9UmY8ZV5UrXL4fxbtn2J1PFhLlH1ht2UeB/3SnFc9M7gn1+XUgKFLaJ49
	R0RY0F2X3+K4PPz3wFaY8TPEoVUE700ao/lhZh3z1LBoBk6eB2nugj+eBfvNXZXNCHAAGL/gLfl
	ZP7Z96DchGz+BffPdbYvEjfX9RoqGHfOxOlvw2Ls5kG04DJuPdnno7X1bc/jupjQrIZeifecH1Q
	YT+oFvuTo51bURCQbCrpQ7kcUOb7/eSZNN4xIrOJUI4Igv
X-Received: by 2002:a05:6402:13d6:b0:6b4:1629:b1aa with SMTP id 4fb4d7f45d1cf-6b49cb4f157mr2351721a12.2.1793214851503;
        Wed, 28 Oct 2026 12:14:11 -0700 (PDT)
Received: from localhost.localdomain (190-2-149-64.hosted-by-worldstream.net. [190.2.149.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4952e380csm1888222a12.0.2026.10.28.12.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:14:10 -0700 (PDT)
From: Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: edsonwasswa54@gmail.com
Subject: [PATCH v2] builtin/diff-files: convert ad hoc option parsing to parse-options API
Date: Wed, 28 Oct 2026 22:14:00 +0300
Message-ID: <20261028191400.799-1-edsonwasswa54@gmail.com>
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

Changes since v1:
- Fixed author name to "Wasswa Edson" for DCO compliance
- Removed vague "error-prone" claim, replaced with specific justification
- Removed unnecessary block scope around option array
- Changed from function-scope static to regular local variable

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

