Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C11CF94
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyX1Q2Xl"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A1D78
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so30081675e9.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871066; x=1700475866; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBAwLXzLynV8FWD86zN6hgjuOZ1WVpty4nnZ40f/Fts=;
        b=EyX1Q2XlgOCtrKEcnDM2aoUkeLCmDhwJrl5ZLKrO1+Erwi/JnSOzTPAiCYe8xm53Qg
         13wzd15m4z1igvpc+wgaN9etMGQa5TfGqvZ6A05pDSmjMlS+VmW6Si8M73CL3dm6u6FI
         xDNGUeNSxv+NM/O706uIUjslR4mHhEJHd1w+ccqj0CapGmXEesQCTB+zbiIoFPkYBFkn
         n1G3RvZ14yScck/uKdsEJR+Yz31xTRxscxHgwSeV7F1wweX5j7q1UHpd62/RH6T1i6fI
         NpST2IBggcnwolxJ40V7xn45Rsj9EjkUOJxWPk/nNMM+GzMywXlQhNKiQ8Hxquox+FoF
         7Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871066; x=1700475866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBAwLXzLynV8FWD86zN6hgjuOZ1WVpty4nnZ40f/Fts=;
        b=N2mVaFAQqvV3lkkvZfjvntRgnPSxOUqBPdhLAVK25P1iaNVLAqgGoHsEBl/5xSSKwH
         b0gW6e9zEeke8aTmruucq9Ee1kSAlaUrJmItM7UKXnaztuemS5BPSrHvfgxwd1ryxbSW
         TsfDvYs0YUIeyhQ2rA9k6H1/Mya10aaTxbeQd6cfXyyQvFcpAHOMl4G7OUgLgPI4z43j
         MuCI8pNPBb7wTyUe1fcjjdve22WzOMOndRKSfYPXtu0TGF5lMxmise+6WpSn64D7SWxy
         9YC1hkhvH10yyVYuFlwY7FUlXNian22A6UyzV77M3ePG0cJww4LeuBir+4eiek/OR1g/
         gNvQ==
X-Gm-Message-State: AOJu0YwTnBGrw1Zter+5RaioeYqd39TUpUIAl6nTpB6fjXdM+G5LRNWo
	CIZ47dgCK8cHU5MTpBAFDMXsE6Yzm8c=
X-Google-Smtp-Source: AGHT+IGOfQLVaQQfBRpwQn8FoywSUmVnLd39l8JsK/7IOiEu0h8S0YOXAmwHYM1zC4iYPZfM5dLRMw==
X-Received: by 2002:a05:600c:1d09:b0:400:5962:6aa9 with SMTP id l9-20020a05600c1d0900b0040059626aa9mr8960496wms.11.1699871065925;
        Mon, 13 Nov 2023 02:24:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi15-20020a05600c3d8f00b004095874f6d3sm7634582wmb.28.2023.11.13.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:25 -0800 (PST)
Message-ID: <63479fe36966bf3b1a8dbc3ae68f8558da4690bc.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:12 +0000
Subject: [PATCH 10/13] strncpy fix Handled git pipeline errors
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
 convert.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 78403de422d..ef44e6429da 100644
--- a/convert.c
+++ b/convert.c
@@ -1326,13 +1326,10 @@ static const char* get_platform(void) {
 	{
 		int index=0;
 		result = (char *)malloc(strlen(uname_info.sysname)+1);
-		while(index <= strlen(uname_info.sysname))
+		while(result[index] = uname_info.sysname[index])
 		{
-			*result = uname_info.sysname[index];
-			++result;
-			++index;
+			index++;
 		}
-		*result = '\0';
 	}
 #endif
 
@@ -1340,8 +1337,7 @@ static const char* get_platform(void) {
 	if (!strcmp(uname_info.sysname, "OS/390"))
 		result="zos";
 #endif
-
-	return result;
+	return (char*)result;
 }
 
 
-- 
gitgitgadget

