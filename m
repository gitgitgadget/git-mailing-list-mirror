Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196855;
	b=GUJbrPANcxgeWzAC3oJWCr0STe7PgBwduaPunIBjpbQQWbQEd7il5Svkg6EfgSZZ4pGp
	 BzvBEBZhh/sbZzGr730tZ4IanjJeZ6jzx10jKmgHstsDlQ4liF4YwNaYGHAK6rUELc/OP
	 Q9MlDxOpjPoiERuTOLgb5xcGVaGuOw9b44St3qCW4dje7Zt7HBegEsx/j1H1YNbFRjL2r
	 pmH+gmj7NT7KKgH5m5SrkfzvtoEKFtFugfWFPuwwkJjQxWwSD+4aloVel7G3p9VqLxv5r
	 D3N4g8H+oYLhh4feVmX0cpoLTMME17CKqU/ovLbDCgVFSoCc+YYYu3V/KQWpPJ/rSqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OoqIUC1OG3tutNK0P1CXoDbsUafMYqA+MRR7t4I4M6Q=;
	b=2awLJZz97YtXzREEgCptggFypFQOAAIn8SDocwsyMxkD8EJRe51l7T0Y+h4ZHjb1R/sr
	 6WA5qQKdOatG697pIfIeCCocjNNBVP4v8UqblsAoYSVQq45aarSvKchj2WJV5gt0XCDwe
	 e9Ul1Q6nJ9AAX6kLjNcGotRX0YwTiZcR6cn5lQ0dyCS0aLt46dz6rgbqc7JNt9rB8gLOC
	 f7IZ7IqYn225wOUPxjeRO3LIZcO93wP30dYUFfOgYdNoVOi3vlkNUfcmKL0edoo6s5DB5
	 Vah/GwhiNTRUSSqFhktRNyM1M+6hHsq0lEif4YbN+KnJPYiuQCrM8FQWGzK8PDOEhaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dS0McqVi;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6896606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6896606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dS0McqVi
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so9178985e9.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793196853; x=1793801653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OoqIUC1OG3tutNK0P1CXoDbsUafMYqA+MRR7t4I4M6Q=;
        b=dS0McqViFWGRcMYFD//rqOa2rpTbvfunLsFJMdYovhsy2BNaXm78Flsgui2FuGv252
         UD+O+yZcqQ58gzTLEyN1I5fHCGCld0kWZqSuVPv1BS9sp0Glo8y1HI3i0DA4Tk2uGgHj
         PtazyM8o0+x20pDiEnpQKL+LCUNxH2/8Bg7lZOTtGdT/jv+MMxz6EdFkQzukknNBRvLw
         5m5tqx1kuif5Wbs07ZQsKQYWhRAYFc+3UbRT/bRVhJtpk6z1WOjvbAnYeQoUqZLcSzuH
         STTB8P4sQUdSXK+wvVpKxNID2iogb/ZBFis9/1ZrxiwyyCFVwJuC8iwwsBek+k98/m5G
         1B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196853; x=1793801653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OoqIUC1OG3tutNK0P1CXoDbsUafMYqA+MRR7t4I4M6Q=;
        b=d9vZRT5/wq3cL3I3z8cuXJTHdDyrkKPF8NP3HJ5uNgCt+Fy3nb5FRmZRURPO5qYckz
         uRCLzhMOVkZraUvvHNftX5n+Zbpcpx7oowzNgueN77ueTXu+mjRt4EDOkdvIckbwUxlu
         e26Uu4vc6O1EAWkY8/oHO+b5/ivs9vTy5Ch+5lQJ7n3AoIzg79JQJCFxHLAe/Fu2toNT
         Dmh6MkFzZPjQMQauwInzW5dMcOj+TQ8TNq/YpKhWAuuR//8q2DJDEc9VrzqfH+6HM37A
         bsNPFRkEhwwLIfZNDBHvwprM+Pru54EQ0pwHG2BzkNop8kjjfiAy0NSuPKSp8z3yv1PV
         K09Q==
X-Gm-Message-State: AFq9FYLP9TlbFuOhwwOzmySBR+7vrP3zbjR/cx7klaNCMkc15VMyPjxU
	oA5WR9X9YLxPthwk41Is4dcAP4anuQQXJ4nFS526aNaj6TP/WrWKViTFabmdRsIStVtYFtOQ
X-Gm-Gg: AYBFou16KlRLDXpFMWq1ge3QGzPGmFigU7/3jQ10OcZdraTTLpdirIhpXXkUx56vKng
	yt5k6NPrA8ZJh4xfzK+D/mA/F15V64LM3qJ9OrDI88eopXgm4q1h5VKpxUMPeeWP9gFGAuJRm1P
	c5jb4kF+T20dneVIUyyIRtNOU6nVdAH0p4OKSiDvxJeLGFwyOpWZbd5c2+W8NymSRhu35ceI8mT
	NXTTR6DPr3dpJh6rpn+vjES8ulBGhqB4pS3tiU0SeENZsBvc18n3YVp8GofZnF7yJ5y/+fPT44c
	WV4FPGh/1HCFk201h0/jkEVgg0Q14ZIVrC3r2p4y7SDp+bF+6wOdfKE3pmj+WCWtnHpSh/PVwER
	Xf56Q/pqIX7Q/LZuKnBlvMvETB8zVE/cjFOkqp+woFY7Eshlie9VqDeZJ4C+ycSL2xEbx1SJLjX
	o2MxE0LpY2etwWUK1XxDkRTYn0b53A1HoYUql0XWIXVViY94gTeHrFzwFr552Wt2MPZFUCnUhja
	anxq5orEXfyyGJLWBog/7uiLxFDSNbJGd2pTaW0PAtfTjVDYfDQPwmhSpV/VG3Xm8LU/55wQdKL
	Ltp/L2W7GZ7xBk7Rh0F2iqDb2/tRafqWUy0rNCW1Mua0rafSavTU7JG0a+a3TcUhCMUzpNBZoct
	i+oCN19ZKpp35NYF4UXWAlSb+vk8LRS3Q2XPCl4/Whk3ZyeSFfEW9x/Reag==
X-Received: by 2002:a05:600c:3c98:b0:4a1:f9e6:f418 with SMTP id 5b1f17b1804b1-4a967ba6b5amr51302775e9.34.1793196852981;
        Wed, 28 Oct 2026 07:14:12 -0700 (PDT)
Received: from localhost.localdomain ([169.150.218.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97cebf858sm54910505e9.12.2026.10.28.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:14:12 -0700 (PDT)
From: Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: Edson <edsonwasswa54@gmail.com>
Subject: [PATCH] builtin/diff-files: convert ad hoc option parsing to parse-options API
Date: Wed, 28 Oct 2026 17:13:54 +0300
Message-ID: <20261028141354.1155-1-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
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

The cmd_diff_files() function manually parses --base, --ours, --theirs,
and -q options using a hand-rolled loop with strcmp() calls. This is
error-prone and inconsistent with the rest of Git's codebase.

Convert this to use the parse-options API by:
- Adding option definitions using OPT_* macros
- Removing the manual parsing loop
- Using parse_options() for consistent argument handling

The --base, --ours, and --theirs options use PARSE_OPT_NONEG to prevent
negated forms (--no-base, etc.) which are not meaningful for merge stage
selection. This follows the pattern used in builtin/checkout.c for similar
stage selection options.

This makes the code more maintainable and brings it in line with Git's coding standards. It also enables auto-generated help text, git completion support, and option abbreviation.

Signed-off-by: Edson <edsonwasswa54@gmail.com>
---
 builtin/diff-files.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index ea91347ce2..a0c3981407 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -14,6 +14,7 @@
 #include "commit.h"
 #include "preload-index.h"
 #include "revision.h"
+#include "parse-options.h"
 
 static const char diff_files_usage[] =
 "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
@@ -48,18 +49,21 @@ int cmd_diff_files(int argc,
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
+
+	{
+		static struct option diff_files_options[] = {
+			OPT_SET_INT_F(0, "base", &rev.max_count,
+				      N_("show base version"), 1, PARSE_OPT_NONEG),
+			OPT_SET_INT_F(0, "ours", &rev.max_count,
+				      N_("show our version"), 2, PARSE_OPT_NONEG),
+			OPT_SET_INT_F(0, "theirs", &rev.max_count,
+				      N_("show their version"), 3, PARSE_OPT_NONEG),
+			OPT_BIT('q', NULL, &options,
+			       N_("be quiet"), DIFF_SILENT_ON_REMOVED),
+			OPT_END()
+		};
+		argc = parse_options(argc, argv, prefix, diff_files_options,
+				     diff_files_usage, 0);
 	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-- 
2.46.0.windows.1

