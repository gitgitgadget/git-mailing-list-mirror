Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899E1094E
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrlR53YU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c31f18274so35009245e9.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351018; x=1703955818; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aenj6Q+yh4JGD3v87H8kiSzEDGTw45aiLtiu0FyJzyk=;
        b=UrlR53YU7RAlECRPgNtTzDWQ/RiRKDUMSLabAqIYcFtejtQfHytdXNzveEu81CjVdr
         50vlgwF30KNg9lstwqobdV3gMZjaYIlr4hgdM0xnRgBNW0yQxZCyWQbqSDVjJ9rvYnDT
         Qckrn0n0WaHjsJ6faGGgjpXTRZJqMRSsLRmc2DArRxCCLyFB8ongNU29JqEmwugA2DlL
         wSc3l35OlChII/GcgKTsjj72Ay5+TfoZt3qlFh7E3TfY9AI52EovmLTXLx/2ThbeN3tC
         jafqTqRTpOZgq5bC6rKkDrv1CTLqGGei+ksYacVkUXyHaW1ma4/PIjRo4B6pvT2BinRY
         x/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351018; x=1703955818;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aenj6Q+yh4JGD3v87H8kiSzEDGTw45aiLtiu0FyJzyk=;
        b=SbwkESbXH7/qVWXXlkrNxr2qb96pZDZrkulYaCsfkGQNayNCVb7o+EOCbHOY8uCreO
         ue5nKAMwvdxlfNZWZjBVFBXuRBMm2Ik9WL+gZVFH6eaWtCfFpCTz6nuuuXKrIducK2hn
         CVO5rslueo2lK/bRh4ipvz3Wy5A1IcDvz4fLUb2n3hs1+r2pS1RE4X0huC9bzdamnlZ3
         BOX3iVjKAVDNkmgftnrTqt9SxsWpqfHDqiVhqQQTfyUbQUUj/mjGgZ9OWRgksHkbw063
         r3fet9Lii8PcnEOcUjnPLtLkXnVHz0pxRvYVz8nMwBoW3EWb/r4PnDKl+6QLxjlH5jt5
         43xw==
X-Gm-Message-State: AOJu0YyCqQM4AOpuRuqnBRUbY+9ITTD+T8gDRGFHZPjVPuoYbumwpgyN
	faHwAdiyw2ZGMteN4H6tm/5CSYCE3ss=
X-Google-Smtp-Source: AGHT+IGdzWPdqsght1SqQ/AdnoFEJGA3EfYjw+f8kDFCmlyi5vmnal8bjYBkbXkH7NIQucDNtnOxAw==
X-Received: by 2002:a05:600c:46c7:b0:40d:2cdb:595d with SMTP id q7-20020a05600c46c700b0040d2cdb595dmr1717326wmo.8.1703351017637;
        Sat, 23 Dec 2023 09:03:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c4f1400b003feae747ff2sm4257631wmq.35.2023.12.23.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:03:37 -0800 (PST)
Message-ID: <pull.1625.v2.git.1703351016486.gitgitgadget@gmail.com>
In-Reply-To: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
References: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:03:36 +0000
Subject: [PATCH v2] sideband.c: replace int with size_t for clarity
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

Replace int with size_t for non-negative values to improve
clarity and remove the 'NEEDSWORK' tag associated with it.wq

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    sideband.c: replace int with size_t for clarity

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1625%2FChand-ra%2Fdusra-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1625/Chand-ra/dusra-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1625

Range-diff vs v1:

 1:  be67e1bca38 ! 1:  fdacc69ae3b sideband.c: replace int with size_t for clarity
     @@ Metadata
       ## Commit message ##
          sideband.c: replace int with size_t for clarity
      
     -    Replace int with size_t for clarity and remove the
     -    'NEEDSWORK' tag associated with it.
     +    Replace int with size_t for non-negative values to improve
     +    clarity and remove the 'NEEDSWORK' tag associated with it.wq
      
          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
      
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
       {
       	int i;
       
     +@@ sideband.c: static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
     + 
     + 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
     + 		struct keyword_entry *p = keywords + i;
     +-		int len = strlen(p->keyword);
     ++		size_t len = strlen(p->keyword);
     + 
     + 		if (n < len)
     + 			continue;


 sideband.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index 6cbfd391c47..7c3ec0ece29 100644
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
 
@@ -88,7 +87,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 
 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
 		struct keyword_entry *p = keywords + i;
-		int len = strlen(p->keyword);
+		size_t len = strlen(p->keyword);
 
 		if (n < len)
 			continue;

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
