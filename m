Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB21D520
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkTaavoK"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1340910DB
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-408425c7c10so34617995e9.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871067; x=1700475867; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6zxYu78Dvi4CJ0XqMTsYTMxgCmJo23KM7DAqdnAnGw=;
        b=GkTaavoKm1AmfTxxWfCmpqP1OJxeayE0ZXrB1xG1l4deBjyDP+9rFoc3Max6iNTB5l
         Fe9LIThG8nYMhM292lyYsSokSsAoxPOLEp1QLmLz8Rpea7LFcWBFfSWYaLRrBio7zTIe
         eEGiUK5ysPDxauu8UqIy0gPRwGCDPiA4klmLVfIiLjnRdirZ4CMXXzSK7Up18ZqO2Kby
         VkxSWV6nHXSi5OYYRIULwDbdK5hnXXchoXmCXNE2mcFLKZDa8BTXDcMaqj5Ldt91Pxj1
         54E+XqCaSljrPSi+JrWUxlT49fBapMLuyiVD7n3oMXo7J8XYTRH0cUjv+ltnUrv0OZwx
         wVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871067; x=1700475867;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6zxYu78Dvi4CJ0XqMTsYTMxgCmJo23KM7DAqdnAnGw=;
        b=tj3Tv/njlRZljouPZk4Gl8UGmsUcLPyNahb+3aqkPBmDU8s2HJo8VeXySQnzoWTdt/
         yTx4O6TdQo6R9qsvITNBpBqzmvwDOyzPCa+fY7FR1a2qhXHBR9Vxc/1+coKlSeSgAAFb
         H25egjoD9puA8Be5CqsScw99izm28APnNxH60IsNnwyofm3re251De6fVh+yT+pRqGBE
         Ehg6H3y7RWf9C5XR7gQGqgaOxDq4McjdPDr9KNW1L8qubQT/CmecAV/JvIYQKmrIcslY
         Qy2L66AC/+fDOUvho5FSXhlOeOlLdEvN45scO5K/KzIdoxOQ07LjY5ylQ791KGazC+Hs
         a8Zg==
X-Gm-Message-State: AOJu0YzQs95rWDOJY/1qtmEy6cqVIl04CWjW/TI7reG7ZVR9gI9fvhTj
	V2/j+ooGPYjfEXGlgQ/4c9iML5pcmDw=
X-Google-Smtp-Source: AGHT+IGFLizMPdux8IPv0KQc63wyVBNBFAwSmmZM4gzmXYaKyjhAoZk1xDFe2wkVtBHp2r4o/rA7tg==
X-Received: by 2002:adf:ee51:0:b0:32d:a717:717a with SMTP id w17-20020adfee51000000b0032da717717amr4762810wro.40.1699871066997;
        Mon, 13 Nov 2023 02:24:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020a056000136200b003313a1e0ba1sm5075240wrz.89.2023.11.13.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:26 -0800 (PST)
Message-ID: <25271363e573f05e390ec09bfd3906730cae30e6.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:13 +0000
Subject: [PATCH 11/13] strncpy fix Handled git pipeline errors
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
 convert.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index ef44e6429da..16173a1caf6 100644
--- a/convert.c
+++ b/convert.c
@@ -1326,8 +1326,9 @@ static const char* get_platform(void) {
 	{
 		int index=0;
 		result = (char *)malloc(strlen(uname_info.sysname)+1);
-		while(result[index] = uname_info.sysname[index])
+		while(index <= strlen(uname_info.sysname))
 		{
+			result[index] = uname_info.sysname[index];
 			index++;
 		}
 	}
-- 
gitgitgadget

