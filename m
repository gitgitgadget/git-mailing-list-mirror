Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CF35959
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171252; cv=none; b=SRdEJSChSAWGJfWJfykrgK9j/gUCrI+vUgg52AOzrkavdWJ65NGrnmOhdzdBTIcIWi9O30ERFzT32od24lBgGfrE3qerye5k59lY2hut5ekolxeakwv2TCf+e2Pl0s66jC0Z+ofTmCX4SOvFz4xOyvnc508+DZNsqHmErkdPaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171252; c=relaxed/simple;
	bh=yRijPUOU8tEnntcHLyEtZWQTQh4aG5pnxYoTAAjRf8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNYwKhn7G5MG48qgdeQeLMoKYMBWAZ193OH+/3FVOLJ0ZLCcaHYoTNslFWKUoOiMzVhRHfLznZJUvIjrRRd4KMQHT9NlvogL/qoLW77jFIp467G9rBD06SNG8XtVVmnB/3Jmrtbtf7L6bHfFspKw5s1sir46ZBzDs/Ly0Ac/tDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/+y6pHb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/+y6pHb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23602481460so33110325ad.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171250; x=1751776050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UezNe3ng/Mx+BddptX/XcDXR8f5xaILpUtsIhWT4PMg=;
        b=a/+y6pHbOJvyOWp8a5UuQAtq/rwrldxebsQvK0JjhLPaDmx3KeJ1xKrvdx1KjKTWzK
         4CcfI613UCHvt5ctgSPtsTNKfznSPGkfQ2J56ofOuJZ9kxHTJ7DyYbG+yiCFZ3Q4pEiy
         PiSzMDo1jpjtZXsM+iCyeE0zVO/XCpZgJTj23dID2funoKEYL8UWTYhFaw6k5QOBIYN5
         a9p3z/gRuoSAKVLal3GWheMGyoWqVMwDnSmrOMIEd3AaIba67DyKxcsi1WRO2T8MCEEG
         XTIdnG1yxH6v06ig+N0wdTy+FYsgjMsYOvPLDYZeUpntrS4nQS2HhZNuJz8fMkjAjAaW
         gRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171250; x=1751776050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UezNe3ng/Mx+BddptX/XcDXR8f5xaILpUtsIhWT4PMg=;
        b=UOL6BQZLnVNgzJRRFgeScYqYgvQTG/fSUvFgm9KdIvkULjRIovIpXEMjQ/yf38d/o8
         Id+IXpYCjjEHGrXb46SOB8QdjGq/lPKW7KggqRSqkat7UjCe36PylVruME+i9xmEStGX
         SaNaih26fo206KvXhY74RsRlKyuV12GiJgpGMANMU1Wuw2ZhmBb2HJQ7JocGfnHmERhr
         xSoUvSoP7BiqxHAUtk009YwXfpxfK7gUPoEVhyeHKL3mFeiouffoT3/O8dfptjCU153U
         fvYOGduJ9JP4JtFZKSrcLUhl6P8dXtsLcz1xVhvz2TLf9WnVEFuKYhCQbBMercXnlBJh
         Wb7w==
X-Gm-Message-State: AOJu0YyRgtPBuLnpE6v2eN4l2hT7jNWF5JWQAGXcSMONlQDEKl5WtJ24
	z7SyoIGBIxv+j5CTQO39kBuFZiwfIXL9e+EfATVewHz2iLJ1/vex+WQjWDKuPA==
X-Gm-Gg: ASbGncsdSz9T2JohA3VqDjKHS6nuJafvgs/glfG+MN1/b3FRPwjhbg9sTJT9AaLqRHU
	8PwNjb50gsL6IEtSOVMfjj5hW15xMpxiRKVT1X+JI2tmfhugZcqc4/qAPD+8T2vx7YMelp1HL2G
	A2qghj3LmtiVQW6aGMnxaKq0f/pqpviOYFY5KcYEr8oM7gbrRSvlbHsUtp9KvoYQgJ4GSeehxBM
	44Dof0s4yKL9G0XTaX02pqYExADTxOysUAwW4sK/yPsCGogOJx9x39NeQJucarw2BPFn9X9peDj
	mqZiToBaTNJRcQZqO9PebRZuzlJ6h8MXLPKpQpdHwp3tsQ9wnnQU4v/d9Q==
X-Google-Smtp-Source: AGHT+IGXTVTxL4wZ3r+pcGnQsAqdPwXjGCh3mqDAqCUWx2Wh4oTJSwWr8RfN9LDrjuirE84ybYYZOA==
X-Received: by 2002:a17:902:c94c:b0:225:abd2:5e4b with SMTP id d9443c01a7336-23ac3afd0d2mr148938705ad.16.1751171249818;
        Sat, 28 Jun 2025 21:27:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2f346dsm49978825ad.86.2025.06.28.21.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:27:28 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:27:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 1/8] string-list: fix sign compare warnings for loop
 iterator
Message-ID: <aGDAvebseECTvGEP@ArchLinux>
References: <aGDAZ6a0-PyXXGmK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGDAZ6a0-PyXXGmK@ArchLinux>

There are a couple of "-Wsign-compare" warnings in "string-list.c". Fix
trivial ones that result from a mismatched loop iterator type.

There is a single warning left after these fixes. This warning needs
a bit more care and is thus handled in subsequent commits.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/string-list.c b/string-list.c
index bf061fec56..801ece0cba 100644
--- a/string-list.c
+++ b/string-list.c
@@ -116,9 +116,9 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
 void string_list_remove_duplicates(struct string_list *list, int free_util)
 {
 	if (list->nr > 1) {
-		int src, dst;
+		size_t dst = 1;
 		compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
-		for (src = dst = 1; src < list->nr; src++) {
+		for (size_t src = 1; src < list->nr; src++) {
 			if (!cmp(list->items[dst - 1].string, list->items[src].string)) {
 				if (list->strdup_strings)
 					free(list->items[src].string);
@@ -134,8 +134,8 @@ void string_list_remove_duplicates(struct string_list *list, int free_util)
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t fn, void *cb_data)
 {
-	int i, ret = 0;
-	for (i = 0; i < list->nr; i++)
+	int ret = 0;
+	for (size_t i = 0; i < list->nr; i++)
 		if ((ret = fn(&list->items[i], cb_data)))
 			break;
 	return ret;
@@ -144,8 +144,8 @@ int for_each_string_list(struct string_list *list,
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data)
 {
-	int src, dst = 0;
-	for (src = 0; src < list->nr; src++) {
+	size_t dst = 0;
+	for (size_t src = 0; src < list->nr; src++) {
 		if (want(&list->items[src], cb_data)) {
 			list->items[dst++] = list->items[src];
 		} else {
@@ -171,13 +171,12 @@ void string_list_remove_empty_items(struct string_list *list, int free_util)
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
-		int i;
 		if (list->strdup_strings) {
-			for (i = 0; i < list->nr; i++)
+			for (size_t i = 0; i < list->nr; i++)
 				free(list->items[i].string);
 		}
 		if (free_util) {
-			for (i = 0; i < list->nr; i++)
+			for (size_t i = 0; i < list->nr; i++)
 				free(list->items[i].util);
 		}
 		free(list->items);
@@ -189,13 +188,12 @@ void string_list_clear(struct string_list *list, int free_util)
 void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc)
 {
 	if (list->items) {
-		int i;
 		if (clearfunc) {
-			for (i = 0; i < list->nr; i++)
+			for (size_t i = 0; i < list->nr; i++)
 				clearfunc(list->items[i].util, list->items[i].string);
 		}
 		if (list->strdup_strings) {
-			for (i = 0; i < list->nr; i++)
+			for (size_t i = 0; i < list->nr; i++)
 				free(list->items[i].string);
 		}
 		free(list->items);
-- 
2.50.0

