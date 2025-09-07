Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2858147C9B
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263238; cv=none; b=pfIZv2H111n6MHm5EKyx5t6wYXVVsCTPHhEEZrE3k8moIC6IH+3/DIv7hfYTm/Z7YO10d9LySKM9WGwa09UZEz02jhcZOvBxkieNQO3aCIOsjO5OOA87j5+V5if/Mdr3bZeCJ/8p7ZOiW1bJH91Xw1AeERjoL9trateJkg4UKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263238; c=relaxed/simple;
	bh=fuRSt8eU1j9x5qauZQemWZsxZPiXw3VX+SklV+6x9tw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AzWtDA+KRillvIFKzHdkm4Rnqwgj0LBH+aWv+C+anK0kqMSozKxnz4I11+WNs4u4csJuui7foINVNGDrNwVNye3feoMXOIH03iQAOv0efEiDRb9fgzwLzSBsgjGzNuIbfxb9iUHGRakqPh6pq6o2i9ibI3HPrij0SQIVzRHdxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc9hGPAo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc9hGPAo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25634c5ebdeso1755105ad.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263236; x=1757868036; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=623Aw1xNa1r81cbIejQMkHoHd1G9iCVGfEk8dMie+K0=;
        b=jc9hGPAoCu/VhJJrXLFQRYcpMorcINGFmAdmG1sX8TtQ1ewP11OyYoGiqwlyHyKzV3
         pvgH8UgmCkT4sdBriYjID46eWwQGG/AXNb2KSte68wAouMQrMPg3YfAw2CAFTAJLjm4T
         chBX+hK+VGaxRIpQ6gZmjBtBWh6UAg4Y5HjyShgJiKNBrTcRBldlVEPrCQ1hS0/Hy/SM
         7VB0DC+pj/I75tnXPwWCfU6AL/EMEd1BA0unxIxvnn0TEP3AqqCONv9MknQNx83OpFGa
         k6U0ev6i11O6ElM0r76XGH/drsU42Jpp57J3loJFuyxZ9x8kBQFZ1a1BENAEIEA80owY
         idjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263236; x=1757868036;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=623Aw1xNa1r81cbIejQMkHoHd1G9iCVGfEk8dMie+K0=;
        b=YxXaQ5mQM6p632NQdfw6Jznh96PvgTXhSWztxWb7RZZUPXmctcTPPsSIH7VjKTovaC
         RXw1JTXaUqsvN2hQ1muzcoa9owHwSozsSP0ovbmHOJlLmaaW7mG6YgVNiHpLglVYu36G
         tDLrPId0lY+cpSqOHqMbUbAl0JS8j+xMW1J+NpqNzBY5Wx8m2tfbXziJsUX4NxNuyZQ8
         nTsPA4dqof8hu9Z5yr5YjtPnfOAcSZ5fMApC66F587E7GegVklHo6tfJe/WPOhtA/jrM
         E/Dfpzl5GVEBhRQ8uWZHZaoipH4VnO0zCkDIPk5eonGA0V6kDTueZmNXpJDAo7w4/fDZ
         ymLw==
X-Gm-Message-State: AOJu0YygQrnzRwa43hBf92dJrvy/FbyA/nbywcxGyb3llv/wW6rKnm13
	jk6GeVY1utH4AMWbTk6l26DYeivGnGonCideAokXtPQlh6iZkB+J09arz5j17ljN
X-Gm-Gg: ASbGncvvBOUbF+d0G8o5gGlxfL1ryBet2Gpl3dfVePa2uEN9pAVc1J092t/m+UU6o37
	6Qpf2xZSHEXLnTVSTBq1EBEWyfA1qs/MF+37mv05K3JQKcBbFLEY8kMOqrP3Fv1PoEJRbBzTxEg
	JyjFzKR+FCkmdAV4LCp5eYcBxie6EriufJkVG237UgAG1NevcuXvybv9NjT1TPHKwyVPcOYLh9A
	K2bNwAoF9mg0Gp44K7QTDmTxgBm83MjysF1X+8vvjrdeMoIP4xNoUed9lx9dMWf9JHpU7H/ek0M
	S3SQ4CTlSnRl0kRaqWeS/rEorGQSYKKrINbSiVRTrfd6k8tgyFi4VRZ00BE5Sf42Gl2cmkH0kwg
	zkHTmY0nHmGUNzC0uebYeSLcbR+B0lBT3bYmhYuc=
X-Google-Smtp-Source: AGHT+IHeax5Fy/R1vf0IHzVreJzIyhpmvwjrMT9zbMH/JpH77aHsVJuQIXGCQM2B8OMOmGwiJ6W8oQ==
X-Received: by 2002:a17:903:228e:b0:24c:b2a4:7089 with SMTP id d9443c01a7336-25170f37bc9mr91321705ad.31.1757263235611;
        Sun, 07 Sep 2025 09:40:35 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24c8e94b34esm122005965ad.94.2025.09.07.09.40.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:40:34 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:40:33 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aL21gazVeyHMeG-s@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We would return negative index to indicate exact match by converting the
original positive index to be "-1 - index" in
"string_list_find_insert_index", which requires callers to decode this
information.

This is bad due to the following reasons:

1. The callers need to convert the negative index back to the original
   positive value, which requires the callers to understand the detail
   of the function.
2. As we have to return negative index, we need to specify the return
   type to be `int` instead of `size_t`, which would cause sign compare
   warnings.

Refactor "string_list_find_insert_index" to use an output parameter
"exact_match" for indicating the exact match rather than encoding
through negative return values.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 add-interactive.c | 7 ++++---
 mailmap.c         | 7 +++----
 refs.c            | 2 +-
 string-list.c     | 8 ++------
 string-list.h     | 2 +-
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 3e692b47ec..9a42b3b38b 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -221,7 +221,8 @@ static void find_unique_prefixes(struct prefix_item_list *list)
 
 static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 {
-	int index = string_list_find_insert_index(&list->sorted, string, 1);
+	int exact_match;
+	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
 	struct string_list_item *item;
 
 	if (list->items.nr != list->sorted.nr)
@@ -229,8 +230,8 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 		    " vs %"PRIuMAX")",
 		    (uintmax_t)list->items.nr, (uintmax_t)list->sorted.nr);
 
-	if (index < 0)
-		item = list->sorted.items[-1 - index].util;
+	if (exact_match)
+		item = list->sorted.items[index].util;
 	else if (index > 0 &&
 		 starts_with(list->sorted.items[index - 1].string, string))
 		return -1;
diff --git a/mailmap.c b/mailmap.c
index 56c72102d9..253517cdf6 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -243,10 +243,9 @@ void clear_mailmap(struct string_list *map)
 static struct string_list_item *lookup_prefix(struct string_list *map,
 					      const char *string, size_t len)
 {
-	int i = string_list_find_insert_index(map, string, 1);
-	if (i < 0) {
-		/* exact match */
-		i = -1 - i;
+	int exact_match;
+	int i = string_list_find_insert_index(map, string, &exact_match);
+	if (exact_match) {
 		if (!string[len])
 			return &map->items[i];
 		/*
diff --git a/refs.c b/refs.c
index 4ff55cf24f..f1ff5bf846 100644
--- a/refs.c
+++ b/refs.c
@@ -1699,7 +1699,7 @@ const char *find_descendant_ref(const char *dirname,
 	 * with dirname (remember, dirname includes the trailing
 	 * slash) and is not in skip, then we have a conflict.
 	 */
-	for (pos = string_list_find_insert_index(extras, dirname, 0);
+	for (pos = string_list_find_insert_index(extras, dirname, NULL);
 	     pos < extras->nr; pos++) {
 		const char *extra_refname = extras->items[pos].string;
 
diff --git a/string-list.c b/string-list.c
index bf358d1a5c..224bc182ff 100644
--- a/string-list.c
+++ b/string-list.c
@@ -92,13 +92,9 @@ int string_list_has_string(const struct string_list *list, const char *string)
 }
 
 int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  int negative_existing_index)
+				  int *exact_match)
 {
-	int exact_match;
-	int index = get_entry_index(list, string, &exact_match);
-	if (exact_match)
-		index = -1 - (negative_existing_index ? index : 0);
-	return index;
+	return get_entry_index(list, string, exact_match);
 }
 
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string)
diff --git a/string-list.h b/string-list.h
index 2b438c7733..03c7009472 100644
--- a/string-list.h
+++ b/string-list.h
@@ -174,7 +174,7 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
 /** Determine if the string_list has a given string or not. */
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  int negative_existing_index);
+				  int *exact_match);
 
 /**
  * Insert a new element to the string_list. The returned pointer can
-- 
2.51.0

