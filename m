Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211997;
	b=WQv67ju+0+B0Pa9xpiypIJjTIuSjYMGmHN0uLZva5hjVFULp2IeX0y34aixQd+mYDRb4
	 Bi/dJWrOGw+QZf8zUb/HUs8rTJ+0vWY4cBWo9U8p34pDfAShO8UhisOEOxG9KfPWlRaI4
	 VZyL+a7Yh88Mg4wTLl/0ccF9A/CaaSqJsIwKDgbNbIr9s8QSuNJrRh9qqGJweb00kf7Ou
	 Zus3hWBwT7rciA+I30hc1iNB2nUCM9K6gsOyX4XWUY4nH8XN/OA1dKWcMLuYjhueTn0MI
	 6gLhZUjsEvjuz/0rHZ5l6LzuoRq8x4670v4PA3594K73aBNh+XjkaARFPlhucuC+aIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eZRefbLEKwWVgCOzhOrkKX5EHcluRJM+5Z1BmZjEZgA=;
	b=3O7mjp8DXt3sPgq1gDOYaUN7Wc1GqM8srkloq4F0F2WoJrWY8XGdp43BAE2Ourqk8JOb
	 AZe8vaBCzXysvCFt9to8gNlsIn7BFElqqpRmE+eqaLmC8v19wdnh5Gk+M47AB9RjEByAz
	 14tnYN0GXoI10nt1WQZePCQFCsXMU2YfyCXyRvPZXVWSAeH2cpPBCk4OF8cNtnkh+Jygk
	 spkVfMqopBjBGn++BH7kVsCZh+t/smCy1+geWWYWBrTwkKHrdgMb6N8K2SMdasXdnUiSB
	 wnClbES+MV7zvLPatMsnC3OLYqMP5zOC858XdkR2MynU8ZLPN5XG31z/3b55DlUlrrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7AqjbAM;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F06606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F06606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7AqjbAM
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so371718f8f.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 00:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211995; x=1794816795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZRefbLEKwWVgCOzhOrkKX5EHcluRJM+5Z1BmZjEZgA=;
        b=s7AqjbAMOQMD/b29+VxVInUEeXT1Ndlpad+3hZHDBB03DQ5B+VFNYTwwRqLI78Rw7K
         4MUanYVMsvQ55tF40d+xRBUFj26TwmW5uQgWuXaQWtRpFVCt1Z8V+QFDphoecjpLZpTK
         BaRfphnONVtc7XEZy/+a5FdCztBwtJzJnB31vadqK2WrJszH1KkgcsJbPik09DIwqwv6
         pGkHut9GYPxUBcV2ePNuLTfT1RmXEifQoqJp26PyCz6181b6EClnoyyWs4NBK6bLQ6N2
         ZnHpfyBZejcHP8crSaUr9pLSb5oUl+HakqGtBqkgamhZwFk4gSwXy8H5l+UmF/GT2JE4
         y9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211995; x=1794816795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZRefbLEKwWVgCOzhOrkKX5EHcluRJM+5Z1BmZjEZgA=;
        b=DWsKi/EcCeepxGw8/fcM35m6NBWYEgEjVt7yNYQYnbmWxeX9yK5zGo+oZC74EAW7Jj
         1bKtnsuaBC0Q0LCW2RkmgU8bd2yraYD35pBZYuAXZ1meibJnLBNQ7Wy1koyo4UuKMC7c
         y+QMVICiWx2V4Tajqcxm0Ro5oyWjPw1c7Qhy7a8RX/MV+3kAyqJdKtcNVbssvs9RNAY/
         05C7w0ULS5kZvWNTvrLxgDe9+mwwjQa2zezeBcBn8Q6cFJqaxA/FAfzujgMEL8RsGQg3
         2XymparKuwFpDL82X5a21TgvvMno+MwaZMnnYk2SgdJhP5kX61z04X2b1hnmPYg/VHXY
         2zSg==
X-Gm-Message-State: APuU4Z+lC4IpR8ON2dnE5vDZr2/ZTjIQiLVFRURZ6jcNp7Ll1OyEHCKL
	jonb7NAD52xW83KfzF72HRJ4JNncdDhuml+uwQLuSz+xsixqGkeoye78xgUCdG4=
X-Gm-Gg: AYBFou2Mp2i56AqF/4TQ5ridFRUVphZ5bdJcYCv5PJjhABZk+aXVp8eQthqPWxD+cIF
	3mVxIa1IpRmJhbzD5jd3zc3zuBw88W2DbGTZIy1pEy7uA3rTWlXoI9u9512AFe1ynng11/+f9WR
	XCWfZsApmXeBI6+45dy9YU1KDgaP+nb2QGwCP6ZPuBVpx916BCsb9d+IIxOgHVLAAONyooof29n
	r8Nrth6pYANJWDefjNihi+OaxQKB6FulLwS9RgUv+BXktdOQR/0rxa05+RFDG0W+ycsYNikPsG1
	ZdyRWPPZpfriI9GHjpdhJK7YY75rwC8AawrwN4yDNFKzcM5/lbijzslugx765ikOKwZ7fA7PKJw
	x6zKRfelu1BKQGb70BO3ui73Ma6gjDfZgueVbA8/XBMl4qFGPRfHmDLtyoU8LY9Q7nBN/bCngh4
	RpWnZlaYtfRjpO1Ict9rS11dM9Idx02L5xp2BOY37RfA8v/cpC/BYYuycR1TkMmrQbK01CBSU7u
	71G02lgKeTOI4FW5p7WwsLb9O6YrQLfVF7HGNMw/yHRMgAHedQ7XqOSbq5LbGgl21g/KwHyiCVD
	lilNKxKl3xDZu5TEBX0HiOaF6aOWZqVh923Cvsdh+Q6jI9lTZVolLPlwmIoIbUhpo+7IVUrq7KX
	glzRUFb0WdLgy2Vx+G8wjEPKgOvN/3gK4K3fRf1dbqIp9l+Os/MrSB7jwulo73TCceoPmymvI
X-Received: by 2002:a05:6000:22c7:b0:492:905a:8b22 with SMTP id ffacd0b85a97d-4957f4070camr6917865f8f.2.1794211995096;
        Mon, 09 Nov 2026 00:13:15 -0800 (PST)
Received: from DESKTOP-453HKQ1.localdomain ([102.22.168.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597d09e20sm8475821f8f.54.2026.11.09.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:13:14 -0800 (PST)
From: bonheurngezayo4@gmail.com
To: git@vger.kernel.org
Cc: Ngezayo Bonheur <bonheurngezayo4@gmail.com>
Subject: [PATCH] parse-options: convert check-ref-format
Date: Mon,  9 Nov 2026 10:12:44 +0200
Message-ID: <20261109081244.16734-1-bonheurngezayo4@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Ngezayo Bonheur <bonheurngezayo4@gmail.com>

Signed-off-by: Ngezayo Bonheur <bonheurngezayo4@gmail.com>
---
 builtin/check-ref-format.c | 45 ++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd1c9c0e0c..a7ad3c8257 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -8,11 +8,18 @@
 #include "refs.h"
 #include "setup.h"
 #include "strbuf.h"
+#include "parse-options.h"
 
 static const char builtin_check_ref_format_usage[] =
 "git check-ref-format [--normalize] [<options>] <refname>\n"
 "   or: git check-ref-format --branch <branchname-shorthand>";
 
+static const char * const builtin_check_ref_format_usage_options[] = {
+	"git check-ref-format [--normalize] [<options>] <refname>",
+	"git check-ref-format --branch <branchname-shorthand>",
+	NULL
+};
+
 /*
  * Return a copy of refname but with leading slashes removed and runs
  * of adjacent slashes replaced with single slashes.
@@ -58,12 +65,24 @@ int cmd_check_ref_format(int argc,
 			 const char *prefix,
 			 struct repository *repo UNUSED)
 {
-	int i;
 	int normalize = 0;
 	int flags = 0;
 	const char *refname;
 	char *to_free = NULL;
 	int ret = 1;
+	struct option options[] = {
+		OPT_BOOL_F(0, "normalize", &normalize,
+			   N_("normalize refname"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "print", &normalize,
+			   N_("synonym for --normalize"), PARSE_OPT_NONEG),
+		OPT_BIT(0, "allow-onelevel", &flags,
+			N_("allow a one-level refname"),
+			REFNAME_ALLOW_ONELEVEL),
+		OPT_BIT_F(0, "refspec-pattern", &flags,
+			  N_("allow a refspec pattern"),
+			  REFNAME_REFSPEC_PATTERN, PARSE_OPT_NONEG),
+		OPT_END()
+	};
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
@@ -73,22 +92,16 @@ int cmd_check_ref_format(int argc,
 	if (argc == 3 && !strcmp(argv[1], "--branch"))
 		return check_ref_format_branch(argv[2]);
 
-	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
-		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
-			normalize = 1;
-		else if (!strcmp(argv[i], "--allow-onelevel"))
-			flags |= REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--no-allow-onelevel"))
-			flags &= ~REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--refspec-pattern"))
-			flags |= REFNAME_REFSPEC_PATTERN;
-		else
-			usage(builtin_check_ref_format_usage);
-	}
-	if (! (i == argc - 1))
-		usage(builtin_check_ref_format_usage);
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_check_ref_format_usage_options,
+			     PARSE_OPT_STOP_AT_NON_OPTION |
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc != 1)
+		usage_with_options(builtin_check_ref_format_usage_options,
+				   options);
 
-	refname = argv[i];
+	refname = argv[0];
 	if (normalize)
 		refname = to_free = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))
-- 
2.43.0

