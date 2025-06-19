Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15928C865
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373893; cv=none; b=HzgVKPmXe0UG143m8r3oaTfEEvDyWyRyZKuw80dmFOnuXzK7oNHySZM6Yj02LchcnZn8BV4VBkkxEcLVKMVcaIy4yFAvD3IR5kdyHywQvJJXyP/+uhu5lDpXEb3uecnlr+U2mziNA6ahV7DviBAI3vxYrFgoWQKBER/QQXTCFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373893; c=relaxed/simple;
	bh=t5ug/aQ64242Sa+wExWjfNG0l9G66Lre61HoAJuu1j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j12o5kvKRngqCNxrIci579nfa0eLOPo9X5fJNbr6MIgUcJ+Ihlipg8QQSZmCKftIufn0e1QlDuq+MB8t+g1gBsV1g2MU/RHND6rxUy+DlWUZdRxwOAADtZPnrofCI21sUUdCn+nMtl/rGC0KFpZxr9v2kQwzVvxSD13imIYrWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIBNvPDX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIBNvPDX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237311f5a54so11926955ad.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373890; x=1750978690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcVUnmb6908pM7X4MTb4FCtxj0Jx7SGthQzcf0ccNKc=;
        b=bIBNvPDXnyYvB11m+DyPzTfwwlg9Hee++TeQKTPurwTcUWGyeFuwgyX++DqKPZSF63
         iLL4kxvxsP288Vm7EJLOx8MwQgeHVXfadBRH3F8EKwmxq11oymbibDXJvC9qmbIRSxyk
         XORnQWd+1qnjZ9pmG08OXHSJa0sDfZxOGOoVtPXZrOsfgT+I4OU0f6rymtkIpEVp/uk1
         qu+bEucXbTAgsDNFOZPYT1WozIGLMbQhLUXU6159J8ucewIrTK8ywv6v3Ey0c0JIiIPW
         TguW5qwB0zDyS0Coj8jjQBuxqVYzYKJhn64H0GcTQ8wS7NSpvUO/3hN8rsz2d4AaUTVu
         z+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373890; x=1750978690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcVUnmb6908pM7X4MTb4FCtxj0Jx7SGthQzcf0ccNKc=;
        b=dvQ7JW78W0ctaTT/YbJ8pSqophh5o4zGuR7SjyEvoqIq/I5WHw8EQ+0Tt/JM+Lsu7u
         LKHGcCMS8h7sgXsptiXStFMjoiVrQk76AoGlkhx9URN9P5KmO5d/UuINu7hA7TV0mUCz
         ocidcSbTekYud8SPSO9jkVo1BDTpL6Cr806/zY4L+ecfqSo7Yu8zDcosF4Z75vMV3l2s
         9nfXOEdBrBP4rramk7Z7fiUlcB3E6jy3V3P3iAEDoMFkXamNXU0Ubwv3xuebS5ozN27q
         /SrHxpKYUIKSENzTJEzSXkXQS6o5BONJ8SJalaTGWT/usc0sqkR3MW985+gCwB+VJlPi
         UfFA==
X-Gm-Message-State: AOJu0YzCGMNNAY7SvhaWyPVEsBZSCfqIL6ADeT8G/yfPspFOH+Iomq8x
	FCvJxRCJ6dyKJmBimrV2cuNFhzgtvC08qQHjPyonTXuJ0JcOc/eh4tLnESXjDQ==
X-Gm-Gg: ASbGncsMf+awRTdZggw5VfVFd07MI1U1xEEwxA3ERNwetw42anUMjmg3iBhIBXOTu85
	UqHRvLzvzPqaFm0WVY7z6k9P6aQKoHNqUw+N9Swv2syvwabJm5LV8ysY6FS0XiiLxC3S9lTGWBE
	icmBNC5ku9nYD1xwi/RvD3VzYh5Xl7rU5DPSzJ7qDvlnleA80qk7SrTDK7yM9LbqI9h8g7ixsfR
	m1cKgurxK6M3SVVRYQwzhqDb+w03kjnsHVf0qzYMqCh6Xosqj+IAVKkGP9cJ6zpkqWMS4MHbhkO
	FTS9YxPFj4eIxA3ZomxbbS+Pu21i2iPHyHoM0UUfH/f8ix2yr9nIixuUuFsO56S+aKRKywgjQV9
	klpG+IEuklswAGINs+w==
X-Google-Smtp-Source: AGHT+IFuoJB+Sxm12BvyA4WDtMNmYNo2QiGB4ZCnXdd+bhGZSGEML9z8/AXvNG80Sudz/HMqeHPWuA==
X-Received: by 2002:a17:902:db02:b0:236:94ac:cc11 with SMTP id d9443c01a7336-237d987d810mr7978505ad.7.1750373889899;
        Thu, 19 Jun 2025 15:58:09 -0700 (PDT)
Received: from localhost.localdomain ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm3470515ad.185.2025.06.19.15.58.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:58:09 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v2 3/7] repo-info: add plaintext as an output format
Date: Thu, 19 Jun 2025 19:57:47 -0300
Message-Id: <20250619225751.99699-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250619225751.99699-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'plaintext' as an output format of repo-info. This output format is
composed zero or more key=value pairs, one per line.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 12 +++++++++++-
 t/t1900-repo-info.sh |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index cbe1475e30..cd7c110f47 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -3,7 +3,8 @@
 #include "parse-options.h"
 
 enum output_format {
-	FORMAT_JSON
+	FORMAT_JSON,
+	FORMAT_PLAINTEXT
 };
 
 struct repo_info {
@@ -19,10 +20,16 @@ static void repo_info_init(struct repo_info *repo_info,
 
 	if (format == NULL || !strcmp(format, "json"))
 		repo_info->format = FORMAT_JSON;
+	else if (!strcmp(format, "plaintext"))
+		repo_info->format = FORMAT_PLAINTEXT;
 	else
 		die("invalid format %s", format);
 }
 
+static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED)
+{
+}
+
 static void repo_info_print_json(struct repo_info *repo_info UNUSED)
 {
 	struct json_writer jw;
@@ -44,6 +51,9 @@ static void repo_info_print(struct repo_info *repo_info)
 	case FORMAT_JSON:
 		repo_info_print_json(repo_info);
 		break;
+	case FORMAT_PLAINTEXT:
+		repo_info_print_plaintext(repo_info);
+		break;
 	}
 }
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index f634e1a285..998c835795 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -18,5 +18,9 @@ test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
 	git repo-info --format=json >output &&
 	test_line_count = 2 output
 '
+test_expect_success 'plaintext: returns empty output with allow-empty' '
+	git repo-info --format=plaintext >output &&
+	test_line_count = 0 output
+'
 
 test_done
-- 
2.39.5 (Apple Git-154)

