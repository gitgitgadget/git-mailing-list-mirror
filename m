Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255239FDD
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1ey1n7i"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336c9acec03so2961452f8f.2
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 07:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704814200; x=1705419000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXa0jTBQcwka8heBNRg43HNBcslFt5tnihJBq9C9ZA4=;
        b=D1ey1n7iHqqxbBCHKtFpploxENJmD3Zna4/McjE/HEDVTbzrOydQ91RhzgKfvI/xPy
         Zw5aKrj+3koCb0nlXii0mYJxUEj+u2wUz82eBMko93TB/QSAf4rBlkHD9aXofTW2LSEb
         ptfcP+uxp0hW5ggNs7s+nysq24qWL+SD2oZs/Mp7Wo2x4zDF+8PYRCg6GNjAtHqvU+2z
         F3Feu+AuHcQrqkIJzIIji5mNBYV2jwZzibh7/wA1SYGj0rZEKW0zPpFfA2+TQYI9/OeA
         H7oh9la5xLB9cG7SHg0O9DnEe1off8TA1HyApuV81oebHh4o6cQJnqgnmDDV19reGr2x
         uybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814200; x=1705419000;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXa0jTBQcwka8heBNRg43HNBcslFt5tnihJBq9C9ZA4=;
        b=fIIctHgon9YBJ9FRk8lGtS/043Km6jKGVbZgXJ0xgEFE+m2JOHcc64r6tkBR6IeQCJ
         ib7tMQS0gtgZmHwUUGOh5rdNN8FoqADe8TJmxj9pC38Kl6uAK9LDTuudMVBwZGG6cEJ1
         CJyBpuM3llPyOIrTCuwt8tZK0UVeBKSaXFPvEny8yK7ZfNKFP4aTTyAE0X8Sg9nyoZJ0
         hAs8bLub2JqSkDP1ebBsB1Qh0Hnw7O67/fWR+FId2eQ/mYbeRwP78OvdNVq16FZfKtAP
         SvWxEw72OnAYnStW1RuWMzAT1DJn6X+E2/38GKIyWXQYPU7LOvqcv47Ryaj5TrduecsH
         h0Rg==
X-Gm-Message-State: AOJu0Yye4JS9GWWYj57srQXnQ8G13h6n7jFXkAFaHo7v4y9Mr6cwRsug
	wUJ+VJtVFCJ4fLzcNAvbkuBONuvK1zU=
X-Google-Smtp-Source: AGHT+IEdoNOaihmal60AhFQntHSMUr4vKyBx0tpMyKvvLwRbbqEn0AtayT7iGWOlGF5cxJjJ87Y/Jw==
X-Received: by 2002:a05:600c:2116:b0:40e:4864:d97 with SMTP id u22-20020a05600c211600b0040e48640d97mr1388424wml.64.1704814200026;
        Tue, 09 Jan 2024 07:30:00 -0800 (PST)
Received: from gmail.com (228.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.228])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b0040e47dc2e8fsm4025906wmq.6.2024.01.09.07.29.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 07:29:59 -0800 (PST)
Message-ID: <6a4d6a56-ab6f-4557-a5a3-1713f57cbfc9@gmail.com>
Date: Tue, 9 Jan 2024 16:29:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] t/test-tool: handle -c <name>=<value> arguments
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
In-Reply-To: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Soon we're going to need to pass configuration values to a command in
test-tool.

Let's teach test-tool to take config values via command line arguments.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/helper/test-tool.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index d9f57c20db..7eba4ec9ab 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -3,9 +3,10 @@
 #include "test-tool-utils.h"
 #include "trace2.h"
 #include "parse-options.h"
+#include "config.h"
 
 static const char * const test_tool_usage[] = {
-	"test-tool [-C <directory>] <command> [<arguments>...]]",
+	"test-tool [-C <directory>] [-c <name>=<value>] <command> [<arguments>...]",
 	NULL
 };
 
@@ -106,6 +107,13 @@ static NORETURN void die_usage(void)
 	exit(128);
 }
 
+static int parse_config_option(const struct option *opt, const char *arg,
+			       int unset)
+{
+	git_config_push_parameter(arg);
+	return 0;
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	int i;
@@ -113,6 +121,9 @@ int cmd_main(int argc, const char **argv)
 	struct option options[] = {
 		OPT_STRING('C', NULL, &working_directory, "directory",
 			   "change the working directory"),
+		OPT_CALLBACK('c', NULL, NULL, "<name>=<value>",
+			   "pass a configuration parameter to the command",
+			   parse_config_option),
 		OPT_END()
 	};
 
-- 
2.42.0

