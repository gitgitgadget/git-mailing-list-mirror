Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8228DAE
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXCrC8V3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33697e6fc4aso556266f8f.1
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 09:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703264470; x=1703869270; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl2RmefWonEGBbYckuG+Blpm7J+8dI2FdAmj0t9ZA7s=;
        b=LXCrC8V3kpeiqQToOjBPWv3dtMlL7pypxrSiRC21lyNtfeiRVZO3fifRS7shpdChwp
         EFX5vC+xlVYxW7dsjOPaV2Xr4VT6IqwfFiG6jzDOM0VwD4T0WTg029UO+Vgi8g3Nv+Zy
         NotopbL+K70AokxE70bHHmxtRSkr/hBmDOuwb5EVPPUrE9kvji1Vu8r316TNQYFLzMxB
         hm0WcLp+LtsHk/kT/4xkA2nkYoCoeFFBKMpLXHjgl7cW4X2wkHHAopymuewlmr2bVFl/
         ZoHKBPNFFH0Fmly31wORup4ueuXmk7KHTMbiXPHI5UJW+5LpkAX76QEh3VYBsMVRia0B
         GR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264470; x=1703869270;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl2RmefWonEGBbYckuG+Blpm7J+8dI2FdAmj0t9ZA7s=;
        b=K1YWgt4Tx/z7pMX7CCMFpMeCFTMlV7wchOxVgf6FDwXtS0/45/2+n/KncATmt0PmAZ
         k6VamQM+MVf66nCkAWIrG2QfZuK+DzrJ0inyqbcffPAiYNd+brJ6/unDcjSwwyL+auii
         bwiQwEbEQeoXEbiVXDqFIs5+WsxLLmuWIykiMP7liYEcI4jxVtzFjTkmLE/WdoWwcwf+
         mZAOm9ieZpwNCT0jkIIcLG82frggvViNNuJ5onF/RJAEL3ZeqyLwfceJ4LvkwVK6nej0
         qDqCErmNbYH9xyp0Ab6d6q1oN/pYXhUkGBA0HfwMTnbwGwdt2k5glfebvBzHeKWUL1A7
         QS8w==
X-Gm-Message-State: AOJu0YzmPhrHlwyAQ8zbbIZg9p58Bk9/QALjm84cSgc352G8RIb3M2V8
	imHZ7IvjFPobVKkyOZS8oETii6H7WRk=
X-Google-Smtp-Source: AGHT+IGczLrXbeec7b3PMIvXzwYQDAtD7oIykQccGsPFEHlJ8aPfYev1i9L2XWuDKs8Acp4ytX0MUQ==
X-Received: by 2002:adf:e790:0:b0:336:7050:a4d1 with SMTP id n16-20020adfe790000000b003367050a4d1mr683148wrm.194.1703264470041;
        Fri, 22 Dec 2023 09:01:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b0033674e10462sm4740474wrp.113.2023.12.22.09.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:01:09 -0800 (PST)
Message-ID: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 Dec 2023 17:01:09 +0000
Subject: [PATCH] sideband.c: replace int with size_t for clarity
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
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

Replace int with size_t for clarity and remove the
'NEEDSWORK' tag associated with it.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    sideband.c: replace int with size_t for clarity

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1625%2FChand-ra%2Fdusra-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1625/Chand-ra/dusra-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1625

 sideband.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 6cbfd391c47..1599e408d1b 100644
--- a/sideband.c
+++ b/sideband.c
@@ -69,9 +69,8 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
  * of the line. This should be called for a single line only, which is
  * passed as the first N characters of the SRC array.
  *
- * NEEDSWORK: use "size_t n" instead for clarity.
  */
-static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+static void maybe_colorize_sideband(struct strbuf *dest, const char *src, size_t n)
 {
 	int i;
 

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
