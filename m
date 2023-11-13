Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4F1CA9A
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjnWKUlM"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D74210DA
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so2911311f8f.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871064; x=1700475864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7Z2SUGa5/0f57Akh4kSw94/5o3v4clvIxdPXNrUx8o=;
        b=PjnWKUlMhrmUN7fss++PGbFNIGhA7iLmGA2NpIOswz0dE9arASA6ZnXOfuCyjfm3m4
         AULcoSoWtgY1tmhHfdfa24sva2sfYxYz+qW8jMbMchYbc7YyNxGYHFXqgdc/ELaUzS9T
         G5JSdalwmItFQKKNJa0NzCHqTie+o8/YPvR9/TaswAGnfzYAEQKM9tGBZgTmDH/o73zS
         I9pexsDcG8YRFySnAT5yy6MnHBghn6Wy3K2f0Oyttapys4WQBuJgzrsrejDn5wdmlyyK
         1S+y/ynW8RuaCVGETUnoEtmmXDGAZUAKDT7VK1FsIVGAeXkO9pTLzne+q66u73v8u3sZ
         DUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871064; x=1700475864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7Z2SUGa5/0f57Akh4kSw94/5o3v4clvIxdPXNrUx8o=;
        b=X9+lcNi5kElGRChysUtCBHx+7hb1xuDcSeO7+QeAwtiAlCmLmKwAz8gKZ7ZJ/cx7bh
         f5icuKzuoiZop50ZoBkhREOBZPWGo0fXO7bQIfRPwKP7u2XgEN/Uv/TabgXAORrPN+zh
         qEYDNNVmgDHvHzwqJgfg3pJXrN/mb5HkY9sOU7xy2Nz/MtX8qPHlWCBB3NlZIMR676ES
         nJlrpAvb+qithFZvGjnskisLfLckmlDwectAih7iI9LNatjWDudJ8GnMqbIbMdfXS8A7
         y59G7Hua2QYJg4GCku1ei2FV/SqvjzOMf0/A1VjkaaJwr651LUaRM1bekhBxOGBsFtME
         Q9Cw==
X-Gm-Message-State: AOJu0YwojP2qC1IW8EFDqGoEzzaeqCnZpad2gDrXshDLXY56qq0Z/wtw
	vqetBdGIXTcsz0pitADnsj+YmIan7v0=
X-Google-Smtp-Source: AGHT+IEV8LquFaL03N+njJqdGvuEkMgL5Ja74l3vmXxP8O6qHOjsdfAtPUhzeWmlERN3jMZU2Z+JRA==
X-Received: by 2002:a05:6000:178b:b0:32f:8a08:3617 with SMTP id e11-20020a056000178b00b0032f8a083617mr4449961wrg.5.1699871064204;
        Mon, 13 Nov 2023 02:24:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25-20020adfa199000000b0032fb46812c2sm5135018wru.12.2023.11.13.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:23 -0800 (PST)
Message-ID: <9fb74d92e3f5b7209478c8040312277cc27431c1.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:10 +0000
Subject: [PATCH 08/13] platform_name fix Handled git pipeline errors
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
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

This PR has fixes to enable build on z/OS

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
---
 convert.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index c8d30011458..9cd0c1382ac 100644
--- a/convert.c
+++ b/convert.c
@@ -1321,19 +1321,14 @@ static const char* get_platform(void) {
 		die(_("uname() failed with error '%s' (%d)\n"),
 			strerror(errno),
 			errno);
-
+#ifndef __MVS__
 	if(*uname_info.sysname != '\0')
 	{
 		int index=0;
 		result = (char *)malloc(strlen(uname_info.sysname)+1);
-		while(index <= strlen(uname_info.sysname))
-		{
-			*result = uname_info.sysname[index];
-			++result;
-			++index;
-		}
-		*result = '\0';
+		strncpy(result, uname_info.sysname, strlen(uname_info.sysname));
 	}
+#endif
 
 #ifdef __MVS__
 	if (!strcmp(uname_info.sysname, "OS/390"))
-- 
gitgitgadget

