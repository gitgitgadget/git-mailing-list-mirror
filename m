Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870F1CF87
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhk+3Gg1"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284D10D1
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:26 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40853c639abso32941505e9.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871065; x=1700475865; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce1NKfuCYfRp0Jih5UaMPme/cdG124N0f9WMcvBTddA=;
        b=bhk+3Gg1VIIlFFUEBA9zB6VUVQe/pQBKZdg4HepHOvV93xfRLeADWnma2Jnu7LzTcE
         +9/8eoh535jN2bnd6eOXDKWNqxHuPlIcZawZJfophGuv2sQXrV+dAsHm8dk3S0+hOwOK
         TXSm/SNERbT2Bgykyc5iHa4Jh1orHjDeUXp+OwigcIlTzKVmwMAsSJDG7DNB7Zay/t14
         yZc8yjbe3v+qS0yiAsgPDe44jCIRfTb2lF/u9fqwsf5o3XDBIdwZ1qgWVeB09+y+ZDFT
         KeBx3iVfnpOdYtpTfsZvuX4Psb/exE2wE2nk5zmbHxB4eaMa0KyDEy/METHSUD0fJFv8
         gh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871065; x=1700475865;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce1NKfuCYfRp0Jih5UaMPme/cdG124N0f9WMcvBTddA=;
        b=h0ZhOYFsFxGwtU5vSplSU37EjKQlPZmDTYUct1oOIAaYzwxGJCRaZ8P0aL3ysMW7H/
         CGNq79me8rs0p09n5hiCVg9ZSftf2RAhPEfkYrbPUo7qxJbh/9q6W5zQ7UyvWwoR7+CI
         Vx4E+WpqHpscCXOGWeX+aR+er/qY3EzeaWuKJ04epuT0KAS83uO+kifs5srpcbnEQQkF
         8agBtTaLvmHRDMks9D3nsiqJyxEWqgIM55BWANgEGpK9m4zthPP/39c6Y3M9Y/EFUOdz
         UtRlWjCK3NAQVBM1uopSVk/sC7JNI27quaZJ3/oFdUVbVtnLVSFlFGQVu+wCvr2Ajss2
         ygow==
X-Gm-Message-State: AOJu0YxaieXm/n/WUrrvFYn7MTgxLM+WXM4Rt3V24Kv4TnEgYkjh4SNg
	67xzc9eCBsLHMcjDwEJStWVTMJkgh5Y=
X-Google-Smtp-Source: AGHT+IGenyzMOPQyVKwkci660ixXul6eHegAp0hdcuK2RO5xYXqoSS8XhnbxH9owi6gwWe9t67rciQ==
X-Received: by 2002:a05:6000:1865:b0:32f:a48f:3658 with SMTP id d5-20020a056000186500b0032fa48f3658mr6823864wri.69.1699871064788;
        Mon, 13 Nov 2023 02:24:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17-20020adfe391000000b0032fb7b4f191sm5056478wrm.91.2023.11.13.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:24 -0800 (PST)
Message-ID: <8fa15ac45f78fbf0fda321a073a1020a471ee479.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:11 +0000
Subject: [PATCH 09/13] strncpy fix Handled git pipeline errors
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
 convert.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 9cd0c1382ac..78403de422d 100644
--- a/convert.c
+++ b/convert.c
@@ -1326,7 +1326,13 @@ static const char* get_platform(void) {
 	{
 		int index=0;
 		result = (char *)malloc(strlen(uname_info.sysname)+1);
-		strncpy(result, uname_info.sysname, strlen(uname_info.sysname));
+		while(index <= strlen(uname_info.sysname))
+		{
+			*result = uname_info.sysname[index];
+			++result;
+			++index;
+		}
+		*result = '\0';
 	}
 #endif
 
-- 
gitgitgadget

