Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2028F954
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333683; cv=none; b=pHplUdWJKg7FaVQJibEXL/opItn+Vk+btL6VKomrxW2trq8R6FEHRhwYKHCEUkXWzLlfg4p6jhQsepx78jGi98VIEHaUHUyJDigktwsNqJ59df9X76MAM+6QS1rAe2Y8nCLtZTUqArH4TTPaCp2J3Hkm76Fo/K+9UzMAlQbkXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333683; c=relaxed/simple;
	bh=DrYptL6CyVZiX9s74tjAMhhNWiIUuxbaBMAq7nnDAHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqCvFWne1nfvm61qeb/+eQfovz0vZLgL/9vT01ug54EEgeiaSBqVlc3YoVrrW1ll87uK5rKsXoMNeUgP1A9mpG8/oO9TjubjmcIifhrNVlgNMGXf4nR5NtjkTP3zrfe0WkYqYfu6KGVDDsCGa3Cxebl1gmoavh9IlCAYSlYHojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3TJL2gE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3TJL2gE"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6919885b3a.2
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745333681; x=1745938481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yHooYMUZH6Bgm3Rl2yZEAFYfi2lRjk+p0zJk0suk24=;
        b=G3TJL2gEDS9I0vWlYZllhyu52U9Jp7TR7widNOpg+SLyWNcpO28LkC4a1ugHNz8qW7
         Sm6kDoHRoDqCL9+wEilkOzF9SNlNQsWPmw/sSwpX7q2osMVDmWxrdwiHeYs6X9xcn05z
         1iAe4Kd2C5kQxEw6kk8m5jTb2H+CqSj0rKP3GhqozN6Y5jdu95nCWMWZwcMnyUMqkJ5/
         EJ1fT0X9bUVUVhlrdElao5vxId2K1ssSb9U8jdwZ5umyjwzWFFlN2Z+v668QOks5asrw
         jpXf7DZ5n+HAr7t2Jg7GGqSf95lSSYb2EunNpxdSensV993dnnazhe1YrPKq+4MVbrq4
         GrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333681; x=1745938481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yHooYMUZH6Bgm3Rl2yZEAFYfi2lRjk+p0zJk0suk24=;
        b=DAr5EgFw2OALjesmZ16LvAxRExQmgYawlcUmD/sKCVQCRwOtCmIeLG5zwCW2P3cuoV
         gmgdVXBSIqub9RPKO4mjK4hb/0vj+hMU2qB7fJz10DhOJWwYCh50KELtTYKXhq3Yyv1q
         DE0V6cymNmzqOUMJpbHaL3HJDAet+akcbxDztM+34EmWqiRyiikrySF4NXjPHq8yyoq0
         nGinhPXSe479YrAXFCHTiTiB0utNuU/RuvvJ/KShdJgyu60dYJ5pFtDGQkPn68Aj5eIl
         O4qt7c5mGLOA/7ZP2FxNSgg7L8tiZLLvxXhdA1kTHh9JQojE0kd7IoffhPbp4Zt2Zaz4
         z1wg==
X-Gm-Message-State: AOJu0YxjksaZfTDSQrdX0IUc+K7NRgIs96SI2FRd6IFvAHxrRsFGczqb
	nZMtlVj97yJPGdIFL17O3tMAL1+EZBcFx+K/zaK2gzlqiasZTBmUUB+tYsVq
X-Gm-Gg: ASbGnctQkwp3AjiC/VmWZVHt6hFiXhM+tWSvJDR6/EkZHlCzR161ZJhNtEbPy0gD44x
	21CjfU91MgoW2PaoF/m+KITs4bdvZEpUACy/Ntuxajr2hrsSAuJbUy/HFyw/l1hU2x6jpw/TD8e
	0g7jgda3ylD/roKYqpNmfUVtI+IVXDBE0iHJlevxvklcRhVZU5iLrkk0SuywibG/a7VvAjy5TQC
	LWyuxr6IPT64YTPomXV2/ziLfpI6LAJkaKrFML441ou2mJ9f53VLphPe+M3wtBPaWX0NZQDRWe6
	lMBirYv+53q0nOq5NApi7FMs/kH79QOicvyI
X-Google-Smtp-Source: AGHT+IECi5mceV94A9iVTlcjLvHj8mnaEveu5cBV2OP5LraIh9nELTMZgcKVLSyx0lWQDVqrcCbArg==
X-Received: by 2002:a05:6a00:2182:b0:736:53f2:87bc with SMTP id d2e1a72fcca58-73dc14cd36cmr17945150b3a.13.1745333680875;
        Tue, 22 Apr 2025 07:54:40 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfa58360sm8705452b3a.111.2025.04.22.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:54:40 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:54:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/5] string-list: fix sign compare warnings
Message-ID: <aAett8cJuDJ_FSdw@ArchLinux>
References: <aAetW0dan8S3Fljq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAetW0dan8S3Fljq@ArchLinux>

In "string-list.c", there are six warnings which are emitted by
"Wsign-compare". And five warnings are caused by the loop iterator type
mismatch, which could be simply fixed by changing the `int` type to
`size_t` type.

However, for "string-list.c::add_entry" function, we compare the `index`
of the `int` type with the `list->nr` of unsigned type. It seems that
we could just simply convert the type of `index` from `int` to
`size_t`. But actually this is a correct behavior.

We would set the `index` value by checking whether `insert_at` is -1.
If not, we would set `index` to be `insert_at`, otherwise we would use
"get_entry_index` to find the inserted position.

What if the caller passes a negative value except "-1", the compiler
would convert the `index` to be a positive value which would make the
`if` statement be false to avoid moving array. However, we would
definitely encounter trouble when setting the inserted item.

And we only call "add_entry" in "string_list_insert" function, and we
simply pass "-1" for "insert_at" parameter. So, we never use this
parameter to insert element in a user specified position. Let's delete
this parameter. If there is any requirement later, we may use a better
way to do this. And then we could safely convert the index to be
`size_t` when comparing.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/string-list.c b/string-list.c
index bf061fec56..a967421b60 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "string-list.h"
 
@@ -41,16 +39,16 @@ static int get_entry_index(const struct string_list *list, const char *string,
 }
 
 /* returns -1-index if already exists */
-static int add_entry(int insert_at, struct string_list *list, const char *string)
+static int add_entry(struct string_list *list, const char *string)
 {
 	int exact_match = 0;
-	int index = insert_at != -1 ? insert_at : get_entry_index(list, string, &exact_match);
+	int index = get_entry_index(list, string, &exact_match);
 
 	if (exact_match)
 		return -1 - index;
 
 	ALLOC_GROW(list->items, list->nr+1, list->alloc);
-	if (index < list->nr)
+	if ((size_t)index < list->nr)
 		MOVE_ARRAY(list->items + index + 1, list->items + index,
 			   list->nr - index);
 	list->items[index].string = list->strdup_strings ?
@@ -63,7 +61,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
-	int index = add_entry(-1, list, string);
+	int index = add_entry(list, string);
 
 	if (index < 0)
 		index = -1 - index;
@@ -116,7 +114,7 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
 void string_list_remove_duplicates(struct string_list *list, int free_util)
 {
 	if (list->nr > 1) {
-		int src, dst;
+		size_t src, dst;
 		compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 		for (src = dst = 1; src < list->nr; src++) {
 			if (!cmp(list->items[dst - 1].string, list->items[src].string)) {
@@ -134,8 +132,8 @@ void string_list_remove_duplicates(struct string_list *list, int free_util)
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
@@ -144,8 +142,8 @@ int for_each_string_list(struct string_list *list,
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
@@ -171,13 +169,12 @@ void string_list_remove_empty_items(struct string_list *list, int free_util)
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
@@ -189,13 +186,12 @@ void string_list_clear(struct string_list *list, int free_util)
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
2.49.0

