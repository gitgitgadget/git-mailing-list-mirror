Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFA23D9
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542925; cv=none; b=ghDwX5fzYZi5Pv7HmO+MU9CCHjxbkpmJVTQXvD/ac6jPUxs+s/QmLf202FnPoXl8YMSMSetxmn4na+W5fZgZiO1ngY6XTZ6XMuVjsZLmMl3uLdhjILLmUdjhMO/qINJIDtuJvhCR75GHS+218m2Mf6eDBP0OFy0Sr+t6rh07vrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542925; c=relaxed/simple;
	bh=0zMrQDGmuy4bMai58DNJDUKmgYfn6EnW4nMWR+P3t0Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=Df8DJMWYK2V3q0mPnf6hfmDy2a85gveEiB7sYdJYhZcmLjuckLTikAaxVdBiOCUbn4tB43Xzt/xMIcbT5UiQW33cB+Kqk1BAdn83S09Avl5SAtm0Ob3VCny8j1rkrFipQbte9FDwvsr23YEX9zlJTBOCOxHLO3nAqFCPfeEseaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaqZA+zT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaqZA+zT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e8ff22382so1610725e9.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 17:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542922; x=1706147722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZkrPlXxi/jWsPrKBdM5fZ76oDS6iXeSRVY8TxOzMIY=;
        b=PaqZA+zT1rucLXldXLxuwRaA1/M/P8hUiXP+ZAigj7HG3SB/hzgWwdjcpqeHAMqo9G
         jjyoTZRSuaV/oH8FevE/M8JRk5WQATCJCU3UX8MuF3l5FbqF7jajm8OAMvjHw3206TS3
         8junfd4GA7ApbrsKdJbw+jp8gHyaNXPyl0bbEyklDSd6jam6ThqEuaZ9lt9GVo0LBomZ
         FNkVfxSaHK5PzTmfOUIToj5B1gqpllQhbkJ2EPFMWrWS4HG2JQ08yu7RvWdq3Cqzv9+n
         NZQ81at0AmsYAmQs3Dhk6YfN1jLlm3XU6/ECzjlTua5DtoZEjWJLzLGkS8/FJeLY1H6V
         AUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542922; x=1706147722;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZkrPlXxi/jWsPrKBdM5fZ76oDS6iXeSRVY8TxOzMIY=;
        b=wQ1sjjWY2Err+P6+Jzny4ZnnUlxM5NDrlF9QmU2d7+9zt+DgDaZT2sc1c4Ct16GhyX
         9sNSFA57jxIf6E0/dlpsImv/VGZzQxBOi6LKRDzNcHAULWahy1btbERkCgnmuC34Wa+Y
         mZk6I1VIzywrM26Tf88VxlTHZ8bge0T81HS4C+G8JsncHbaki4vVaR8dLdgNU8C89/22
         hzcK8nx3xtoYZ9Bz5kXZLsOnfY5aw3C8opML/Vt47lS16RKlm6wvdYhRXRYdarmxZGvR
         XDutD2hXBaRbT8PFmpiTROZkEASRQvzqP5KN7i/GXBMQX1Iz528wr62U555BFI9BGEOC
         bxhA==
X-Gm-Message-State: AOJu0YyXZw9JeRniNpT+GpxX3yNqK1bsCcJLxubQ0dqxvZp7v5g/BChH
	qssuhknPNflNDyCkbf/M7WZTRlFybtETTgT4T0rtWbRNwIRi81Bw+CTbvMlC
X-Google-Smtp-Source: AGHT+IHio9d7m2g0xAi1sWtgFKDzN5YvDP/ZDtzomPX+WyhrdAtQSVbJlIR5lhdNqCJPlDInY2RkRw==
X-Received: by 2002:a05:600c:2205:b0:40e:8613:848 with SMTP id z5-20020a05600c220500b0040e86130848mr49081wml.117.1705542921640;
        Wed, 17 Jan 2024 17:55:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hg14-20020a05600c538e00b0040e5cf9a6c7sm24416098wmb.13.2024.01.17.17.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:55:20 -0800 (PST)
Message-ID: <14e8834c38bcddc21856772b09f6fa77fa924b48.1705542918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 01:55:16 +0000
Subject: [PATCH v2 2/4] test-submodule: remove command line handling for
 check-name
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

The 'check-name' subcommand to 'test-tool submodule' is documented as being
able to take a command line argument '<name>'. However, this does not work -
and has never worked - because 'argc > 0' triggers the usage message in
'cmd__submodule_check_name()'. To simplify the helper and avoid future
confusion around proper use of the subcommand, remove any references to
command line arguments for 'check-name' in usage strings and handling in
'check_name()'.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/helper/test-submodule.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 50c154d0370..9adbc8d1568 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -9,7 +9,7 @@
 #include "submodule.h"
 
 #define TEST_TOOL_CHECK_NAME_USAGE \
-	"test-tool submodule check-name <name>"
+	"test-tool submodule check-name"
 static const char *submodule_check_name_usage[] = {
 	TEST_TOOL_CHECK_NAME_USAGE,
 	NULL
@@ -36,26 +36,15 @@ static const char *submodule_usage[] = {
 	NULL
 };
 
-/*
- * Exit non-zero if any of the submodule names given on the command line is
- * invalid. If no names are given, filter stdin to print only valid names
- * (which is primarily intended for testing).
- */
-static int check_name(int argc, const char **argv)
+/* Filter stdin to print only valid names. */
+static int check_name(void)
 {
-	if (argc > 1) {
-		while (*++argv) {
-			if (check_submodule_name(*argv) < 0)
-				return 1;
-		}
-	} else {
-		struct strbuf buf = STRBUF_INIT;
-		while (strbuf_getline(&buf, stdin) != EOF) {
-			if (!check_submodule_name(buf.buf))
-				printf("%s\n", buf.buf);
-		}
-		strbuf_release(&buf);
+	struct strbuf buf = STRBUF_INIT;
+	while (strbuf_getline(&buf, stdin) != EOF) {
+		if (!check_submodule_name(buf.buf))
+			printf("%s\n", buf.buf);
 	}
+	strbuf_release(&buf);
 	return 0;
 }
 
@@ -69,7 +58,7 @@ static int cmd__submodule_check_name(int argc, const char **argv)
 	if (argc)
 		usage_with_options(submodule_check_name_usage, options);
 
-	return check_name(argc, argv);
+	return check_name();
 }
 
 static int cmd__submodule_is_active(int argc, const char **argv)
-- 
gitgitgadget

