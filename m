Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1113ACA4B
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365090; cv=none; b=fnUC9SalRP6keVcX8PUP2jdZ22EzRK/PjMiF42RyP/KVd0754Q3XF7pFPPD6ErcningqXZbUfU1UobBTFRu5H1hsWwL4YrVX7QLn88A48HC12rFXXmcJSZ6PjZlnuNRkWDvf23OY+FvFNQpRuQPYbyVX9rsBoM5OZ+Z/bOSGULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365090; c=relaxed/simple;
	bh=d8dBrGV+f6rAlHW3D9RWwQEOINT++i+UT/3Wy8OBwt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeSVVVjnhp30yF13hxMCpB8+D5dQ1Ww56zFz9IPH7Fc05H1sxmYhPyxJ2TBQVYcLj3KHW8mH1uJNdciFL6/hLF3B5OYTbUYHo72FZ6I9hmPas/Su1W+vene2n/65Z4ARKwJmZqhWZeqaXbFgjFUtcfsYx1+mFqnbMhUUl9/a2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiyQd29e; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiyQd29e"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-381191ea2adso703302a91.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 12:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783365089; x=1783969889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ha2c6PPObBerdIX+Ejgq43jn9gDWJWp1vJdhLxxfxM=;
        b=LiyQd29eAVjBV8n+/GbooQKXFz9Wn6OY19SqrAyorj4xf4+CWTrp8dT82yEjPZTpnD
         WZ4p7i46pQl/W0jS8j3mJmmQdSi43LIHN49mxu4KKftnCUemCuPQFY/nqoo9pRlVQWH0
         9nT+r58akE24H4ZgS/6oPAVCwbaIVciqvsaj/fpFNqrr7oWA62NAzQxFZ+o7zvv6OE0w
         EV/1oPhn/PmEjTzUkHD8MrfiEuHZca+gc1XFSLKBmYai7H/U7GaUkd20mJzaymQrUFbk
         APq82q049qn81biTuZsmRG4Rbe83IiYGP5H49Vos0tRdS7ZYf2ifHmZO8StKa34Df5Lf
         318Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365089; x=1783969889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ha2c6PPObBerdIX+Ejgq43jn9gDWJWp1vJdhLxxfxM=;
        b=jaU7AMRPgnsRuBXQll3Kce6KevvMsTNogWhelSr4cHGIh/QLswvEu+GtzLQet6A+mn
         tFSdSivvsPNboMC/MAruxQFXPSjg20rliPak+KNQhW3Th3YJujILm8/F2aihXIrO8sQ+
         wM2lHoqea9KtQkL55+7acuofEosAzHGFh4DripctDS7i5MqIkxliqv5l51BURv49K5wr
         8FKVGL619btQctONCb4WnfVgJz1Gabytf4JdhubJfjZCquae9jsD41MnYEDAk8nRAMuo
         l4OybVbNQmI41XM2NvYlv6gCCHphV+kz0QNqnOP8YQcGE+KbXVht4eXYTEbP9/Jvt0V0
         A4sQ==
X-Gm-Message-State: AOJu0YwB5CFxD0fj3p2vVz2cr4aQW1DmpRDlmPxEYPBOT8Z4qEd1hZSU
	dNzzLAQXoKlR6fvglZO/ccn47Zg5/6GfDzi6nceL7e0cMm0aITg8xTPvOfpg6MzBTwY=
X-Gm-Gg: AfdE7cklNmrqKeDXnKuxnYTWBGTkdKl9AP0nXLCn7xhOVK+HaicUAIAdVn5RqygOk2Z
	abgy1fypFah0+CaaXQA/TwTXu3wsM7L3srfsUUTzTFKTXbib+cHu2SGTdlRvk/m8XV5iH3iJn/4
	s/N3YTpQRsiRerMo7w/YguLjX4jN4fMU+Ut0r7hCVfXPR74A1ULdw/UQIfP2hp4QQtVYIlHQq7M
	+/8q/DrB2Bo/8KnCSknk4UWHShKOOksRJoZtrBk0bxwsKn+3xHjyBvivNCqGqocBg6VKEWXRRK6
	ac9cAMH7jnttnWGVDpvdNsBNlRkuZRJWfSavNi0DH8QMf+uWKMGDnQJ8vtpZDSSHLNvkk0F4eB1
	ZqnckRQkrcYT/h/neoQ1v1HUNKSVK7eqqM15NNFWrRrG0DBviq+bMz2+m+rLmhc5Q7XwvpgQtC2
	XhfogkfW4gn8JmaLIUR5aGbGjpe/fR9epHP3BBV01ljmyv/5FYTRCymutUVw==
X-Received: by 2002:a17:90b:1d01:b0:381:bf9f:be37 with SMTP id 98e67ed59e1d1-38755768660mr2139879a91.5.1783365088873;
        Mon, 06 Jul 2026 12:11:28 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ffdd292b0sm24453562eec.2.2026.07.06.12.11.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 12:11:28 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v2] builtin/rm.c: use die_errno() when system call fails
Date: Tue,  7 Jul 2026 00:40:24 +0530
Message-ID: <20260706191024.93788-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When remove_file_from_index() fails, the errno value contains the
reason for the failure. Using die() instead of die_errno() loses
this information, making it harder to diagnose failures. Switch to
die_errno() to include the system error message in the output.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---
 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 081d0bc375..3f5e6e232d 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -396,7 +396,7 @@ int cmd_rm(int argc,
 			printf("rm '%s'\n", path);
 
 		if (remove_file_from_index(the_repository->index, path))
-			die(_("git rm: unable to remove %s"), path);
+			die_errno(_("git rm: unable to remove %s"), path);
 	}
 
 	if (show_only)
-- 
2.54.0

