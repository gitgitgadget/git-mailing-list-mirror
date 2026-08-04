Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D084451996
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837868; cv=none; b=o8h5H91B5F7H25CkIh3CJFVD6DvmZ7cUIdYxi48SI0Y06RirF051frddsN2nxfr56PgEFdaKBA22Nwxn0aMS366J5N+J6VnzImZgKcXFKWIBwIUMu7YKhH3PcCmSvnOKLVd7wKw5JfgE2pnjueBnbOdVzCpPvLjKwR4HdOr6TSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837868; c=relaxed/simple;
	bh=ghTKPMKc05MSW+RtsDtLdmjFvrNxldB524j13DFwK6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxEdyREl32QilIVQF1HiyAGXxFopo96SGvpYa1Gte3wSGXacJkRicCfqEdGVhXj+iEqa2m29mpipV9GDoo5LpPmEKSLtGxEglQKk9fWLlRfILN5BsIRjdjvry9XffJmG+de4xMJO9c7wEIkzXE9lwj/5peHlP/S0EgzDNxJiYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXNuvcxm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXNuvcxm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so32120125e9.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837865; x=1786442665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1gm5VpfHIwph7tJzxHdxNHasaRE45Q5nYwaxNK2stQ=;
        b=SXNuvcxmDU9vWeD5ZH12i4RiFgFE7MD4BK0uQU5wl7mTUsWE7VKq7jO6lhLmKmG9BZ
         IE3+ATeT8zDWRmkjK+E6xpf3fpKXq5vXRPlEpSU8+rBkXj9wzaPrK0leV9DIZfvMnw5a
         duKQty1HRGq2GnH3Th4nOBQD5BWw4vfjKLdSR7nSaxHVB9NNiSzr6ok6TKg/KEht4Pvq
         1V03mp4OssWGNRe26nvak61PzUlkInMf20KIMYSeJo5SPfJuErF8Yt/D+GCsnAGubK/j
         WicXAU1oekktK69RYT2fsMaHtkA+PlGCwqGPCDzuwGDPHY1wxMtzDa9//S2jr5n6N1AF
         Jsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837865; x=1786442665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s1gm5VpfHIwph7tJzxHdxNHasaRE45Q5nYwaxNK2stQ=;
        b=icfthMAPLQ6tj0GN4dPXh0U7ojsC6Y1a5Paxr4aJunZCKI2pZ+/nsziwGszKU85Op4
         mFIY07VeX7HCMTh3lcHvFclOfvn1XoO/BOhGo5mahwwpTKHLiPrsWnKnEASHkXVj2owH
         B6wdPQMS8zAQ32Xy3stsNb08alFQ+FT3la/AWTZWI4emjzz0n5hqAe0ncVT71p7gAUBP
         ZwXsGFIt9Aq8Zbo1JV6OFcfcWev3VAh7QQi9OzBDFJaiSba0vLgtewwACdJSEhFliobE
         sjcbiMUIXo+oZhkARguDEWMnlRqaS8YcQzQkwWJViYS2QZHY97M7KnDhDIxlMw5doLKB
         KoCg==
X-Gm-Message-State: AOJu0YxwOH2Xcy+XRxiLBOkb/8N8Q8Nne9GfTKBdybhe5gM1bMf6TsQt
	/itTS0YFyihJApFxqEHa0+cMZO6n+PcLsd4Oi1lfIKIMCofd5dwPWifHWcVxrg==
X-Gm-Gg: AR+sD129B51mm/wHTwdambL7ZqVeyuzpnvAR6hvjc3LJzWRTZ2IXVeehpelijBZMpdv
	s2KyJyReKATPmEVcu4mDWMXYP8mWT/J2b9jI34qdNZbJCMBYF0tWlgGZtsmxjy9F5OaJyhEWjLL
	SVHXBGOs40548NGhwVth1aa9zp8i7nxD40la2C20j+zWVwyY6Ws7O8SYZeqlRpslLH5eoHzZokO
	gS+ZhdtS7LHWdI4sv2p0pKgSY6d13dzdU3iRzlj5rJyIJrtWB9r2qGC2JXgMN68JsJP38dRSFMo
	yKOQ85KMgxZQEhJJqmL/fJsIQAAL9Eagudh20qfVMObscjiezOmbRlmurGulHuv/n/uIuDoQ96q
	9cpITgSurfG6WQqGb1xkiytGQbKgZXe+usUikhVzzlX3H3RxrK/H0aqzZuYKjaaYp+7GajG9AW9
	pYn6t5dY9lfG1QPBdbpMo30e6hzyfrH0JCw3E5vPc9dpokTGmpxAvkGLb7OJOxgtu1aoeEB+ywE
	UBZKpQLZ9/+79WgS4lub49YWEpJVWLpmZcZQNeH3V1I6zBnOKZHOBEr9bhD3Jd6MBErae5WN2HU
X-Received: by 2002:a05:600c:1908:b0:495:7838:7e25 with SMTP id 5b1f17b1804b1-4980ee9f00fmr300115695e9.15.1785837863783;
        Tue, 04 Aug 2026 03:04:23 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:23 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 04/12] fast-import: localize 'i' into the 'for' loops using it
Date: Tue,  4 Aug 2026 12:03:47 +0200
Message-ID: <20260804100355.1299498-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cmd_fast_import(), a	local variable 'i' is defined as an
`unsigned int` and then used as a loop counter in four different
`for (i = ...; i < ...; i++) { ... }` loops.

But in three out of the four cases, `unsigned int` isn't the best type
to use.

To give each loop counter the type matching its bound
(int/unsigned/size_t), let's localize 'i' into each loop that uses it.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 6692f7cd81..9fc9ebe65a 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3937,8 +3937,6 @@ int cmd_fast_import(int argc,
 		    const char *prefix,
 		    struct repository *repo)
 {
-	unsigned int i;
-
 	show_usage_if_asked(argc, argv, fast_import_usage);
 
 	reset_pack_idx_option(&pack_idx_opts);
@@ -3959,7 +3957,7 @@ int cmd_fast_import(int argc,
 	 * line to override stream data). But we must do an early parse of any
 	 * command-line options that impact how we interpret the feature lines.
 	 */
-	for (i = 1; i < argc; i++) {
+	for (int i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg != '-' || !strcmp(arg, "--"))
 			break;
@@ -3972,7 +3970,7 @@ int cmd_fast_import(int argc,
 	global_prefix = prefix;
 
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
-	for (i = 0; i < (cmd_save - 1); i++)
+	for (unsigned int i = 0; i < (cmd_save - 1); i++)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
@@ -4035,9 +4033,9 @@ int cmd_fast_import(int argc,
 
 	if (show_stats) {
 		uintmax_t total_count = 0, duplicate_count = 0;
-		for (i = 0; i < ARRAY_SIZE(object_count_by_type); i++)
+		for (size_t i = 0; i < ARRAY_SIZE(object_count_by_type); i++)
 			total_count += object_count_by_type[i];
-		for (i = 0; i < ARRAY_SIZE(duplicate_count_by_type); i++)
+		for (size_t i = 0; i < ARRAY_SIZE(duplicate_count_by_type); i++)
 			duplicate_count += duplicate_count_by_type[i];
 
 		fprintf(stderr, "%s statistics:\n", argv[0]);
-- 
2.55.0.492.g44bba30fd7.dirty

