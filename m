Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819931CAB9
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVoLJ5FC"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52011135
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083f613272so36825975e9.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871063; x=1700475863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1SqGzecIQuCC0UhVUCjftVl3lukEA9o5AFyqr5KdQY=;
        b=TVoLJ5FCLGg4XR7wVeRhEJsKlHM+G3tyasoqbPCdWErAwyEvxtjYqdSxMrQlcUVzZu
         I/lvLUzCyNwRBi7miqWAPKgPumCS6zXZcwzrBivRa+T7Czzy1t4EWxpC7uOjvZvx9Nun
         tJAcM663S6YJcPysodq1VwPyX0G+wBlQE+pXzZY76bizB7jCkHrq8hOYmuMvKWNdP/+S
         4RDWDWU12tPnAAB4zCszQmCfE6SGojQVnqx28oCRtxk2Kv2Kp0nnL2aK7v+Y28xjnyp7
         UsmIWI5ey8rUh9mcsYPhXYXyb4YOVO2qI3FqjsybPGh+WYesAh3NexKbYX7Kb439b8Xb
         xmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871063; x=1700475863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1SqGzecIQuCC0UhVUCjftVl3lukEA9o5AFyqr5KdQY=;
        b=BQQ8a8+akjg3rwiFHS2wwIkA8TuuQhmtG3HSEciJJlnrfXyQLeGoftj7BTkXg2+zwQ
         p6W2pbgY1oKACP8LwjSupnFbo68W329eqw4kkUjJhSCc+SXc71ZyWwWdjgpfvUj/32Vm
         lRUb71BqxJfL2vIeCHIH/UPfIuWsZEH5FHgW3es3asjftEgmbDpAS2qGPFt5bdgLjspv
         8Cp/WwEC6c8GDCsDbhG5khFiGkgNCvV61H+i6dceACkzcAc2JuZhoqZsGP3wt4mafI7B
         hfX66uGKXEnHvtS71kYe67r8FBWtISWrPXMIdFAdTBUsbwaKKm7luK2Axqsv1S+BVj8k
         M7iQ==
X-Gm-Message-State: AOJu0YwMGM8bUUBt9QEsFGoDIaReFhadMOILlTIw1K/8IsaBc1wR6kkx
	HAzaA8k0cCbUkUimOxEPSSaZQC/K9iU=
X-Google-Smtp-Source: AGHT+IFpCZbmqipbO/0rRw1JIEFtoanJSsp2df7KKS8iGnjjnI8eqqA5q0qbP5hQGrLV2bCihM0MpA==
X-Received: by 2002:a5d:4807:0:b0:32f:88d1:218c with SMTP id l7-20020a5d4807000000b0032f88d1218cmr3736183wrq.35.1699871063588;
        Mon, 13 Nov 2023 02:24:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d4b4a000000b003313426f136sm5031984wrs.39.2023.11.13.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:23 -0800 (PST)
Message-ID: <8165196f869267ff35d2b252c20a622013b0fb04.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:09 +0000
Subject: [PATCH 07/13] spaces and errors fix Handled git pipeline errors
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
 convert.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 7fe107710ec..c8d30011458 100644
--- a/convert.c
+++ b/convert.c
@@ -1314,9 +1314,15 @@ static int git_path_check_ident(struct attr_check_item *check)
 static struct attr_check *check;
 
 static const char* get_platform(void) {
-	struct utsname uname_info = {0};
+	struct utsname uname_info;
 	char *result = NULL;
-	if(!uname_info.sysname[0])
+
+	if (uname(&uname_info) < 0)
+		die(_("uname() failed with error '%s' (%d)\n"),
+			strerror(errno),
+			errno);
+
+	if(*uname_info.sysname != '\0')
 	{
 		int index=0;
 		result = (char *)malloc(strlen(uname_info.sysname)+1);
@@ -1326,15 +1332,13 @@ static const char* get_platform(void) {
 			++result;
 			++index;
 		}
+		*result = '\0';
 	}
 
-	if (uname(&uname_info))
-		die(_("uname() failed with error '%s' (%d)\n"),
-			    strerror(errno),
-			    errno);
-
+#ifdef __MVS__
 	if (!strcmp(uname_info.sysname, "OS/390"))
 		result="zos";
+#endif
 
 	return result;
 }
-- 
gitgitgadget

