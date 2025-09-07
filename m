Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AC147C9B
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263245; cv=none; b=Icr4XQgE7qbH/8fzaYsIai3DXk/FKRmizFFXsSoZTUP2NPJq1X/7XbmsIfr/1xqnj0urtVMyBFZ1s5ke6NWYCXIg3QQqRYKSWzyVaCj4LWmhB/mXeA4kv2TMP/bobXNCP0KKO/1g5HSFQxatJXLAiXFv+sgkZ6YSE5SGAQcLnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263245; c=relaxed/simple;
	bh=cPrAuPfV5k5OJI2m35+ZMnbQl+l33u6QGBNg5GWqPxc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UQAfa/Vru8oh8/1ukKCETMweCoYsnK1W2sOYAhpTCy1zLllSFNjXSEG0COoODr/+kmoORtCxHKLTEZ/e3EfvDBkn2jNk3IbOX8noJwT/7gsL9bfBcrh4N4FYzNNOYGd1LyQQ7NR5WsHQAmTAS75bLO5oPDd4R2TJXtcwekE0bUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdj8V2pJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdj8V2pJ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b164146baso23198615ad.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263243; x=1757868043; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVhJiGokpFB9wLcvOuvW6oaEB4+iKla7lX6XplvHjoM=;
        b=Wdj8V2pJIQNLX0qfMnVkloMCzfXiEUvhjEBiBWCkUli5oDSTGzoxCrmbcto0kBr3J2
         McPUnKAw5gPQA4Fq6AK8dlHqDgb4tgzet9rsGa/0u24W7lAQ/ITIb0pYwbHoOBVkVYJw
         YZbuHgMSZnif4IsGUTQcDDV95BpbJp8cTxgC5EUrvv0oAB01/xGG2JxlcdUwWDwbph+E
         B2CpLVaT8l/fQx6EKuBeqY4TKIpgAiL2IcvcQVN/xshRyoPoGlkDIpMZHttaiwijZbaH
         /CqNk5h74JiPXBMi3YG1U4Ea26Ruv+OKFvttHg/h1XCjt0ZIN5Bbo26GdIn71zIrW69m
         Ydsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263243; x=1757868043;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVhJiGokpFB9wLcvOuvW6oaEB4+iKla7lX6XplvHjoM=;
        b=WRGqPTLgSx/PK5YdrXiWJ4YCdohJWWphB6J21Dfk/vrnEodxy9PE5QEoQPc67pW6gH
         TTPz+dKN8RnSkepl4HpFi9E48k64MY9ytZcxRoyEuAbDt3S9GcSw+E49hgPqeQ4XOG2R
         pToTDSKzAW+4lUF48xr1lBRPQI9hgudXVT9H3wWcKKok2aRzNNQAxjZ9sWNNPLhxE8VF
         BTn+rLKL9jGskSm2jDxDAGYlpqeB5EZ6JWwX9QqlzuqrzwO7X9HeUHjDf3uyWAMLSLr+
         GraIMtbEreVsEf4BdhcTs2MqIACeIxDAZoBYT1W5ehf2QmEAQl7WCeF5finN678pFJPK
         2rsw==
X-Gm-Message-State: AOJu0YxfEojoFuA/lBEtl6DcgEUSK47wh+dzu7aweIAUAMwQ1P3Fvlzi
	9m20J2Y/ailAT0mdWGlIBCu0EuS3ZwBiqNDGaQUZilxaXVIM+utToDkeB1PN0vrw
X-Gm-Gg: ASbGncvbF3NnGHYmmInFg9Qq1aKh3z12+7jUywdnvEyOIgnb+wymL0ahY3SYoevsDmq
	v+t8HJz9cx828Bjxs7AdX11I6kNR+aK1VJoPMFo6AtTSJRcv3j2tdrgc4uvr1CD0S6ItYetcErR
	mCesf5p+zrTATIFpYuUy1MZrClX78dqd6CAsuC+3ynQPKP4N2+/1LjmO0XvFAH1Le+UfdB4+bOO
	2cJB1h71rft8aVMhcEujwR+KE9WG4P1T+imFY6g9wocyxfE3xMpJSC2DAplzGhCk6jucYSsG7gh
	3gHUYLjRBI23RqVXQ5q5+07GN1psQBVWjv806i6ug+T/XJWEnn0g+iDDLMs1CrP/NUwryiD5Fzd
	YPR+scE2r74xw6Z1fI2hAcibnVoIF
X-Google-Smtp-Source: AGHT+IHmU44zxs8KVxZNrbKez2bTyfIx3xZb7MgSh/RO29am9GDVKFSb0L99667HVpcW9fqF7cE9Wg==
X-Received: by 2002:a17:902:e742:b0:24c:ea1c:1176 with SMTP id d9443c01a7336-25172291d04mr76189945ad.38.1757263243198;
        Sun, 07 Sep 2025 09:40:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24caffd7beesm106001605ad.121.2025.09.07.09.40.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:40:42 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:40:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 3/4] string-list: change "string_list_find_insert_index"
 return type to "size_t"
Message-ID: <aL21iR390y0kwRWV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As "string_list_find_insert_index" is a simple wrapper of
"get_entry_index", we could simply change its return type to "size_t".

Update all callers to use size_t variables for storing the return value.
The tricky fix is the loop condition in "mailmap.c" to properly handle
"size_t" underflow by changing from `0 <= --i` to `i-- > 0`.

Remove "DISABLE_SIGN_COMPARE_WARNINGS" from "mailmap.c" as it's no
longer needed with the proper unsigned types.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 add-interactive.c | 2 +-
 mailmap.c         | 5 ++---
 refs.c            | 4 +---
 string-list.c     | 4 ++--
 string-list.h     | 4 ++--
 5 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 9a42b3b38b..2005f56b69 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -222,7 +222,7 @@ static void find_unique_prefixes(struct prefix_item_list *list)
 static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 {
 	int exact_match;
-	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
+	size_t index = string_list_find_insert_index(&list->sorted, string, &exact_match);
 	struct string_list_item *item;
 
 	if (list->items.nr != list->sorted.nr)
diff --git a/mailmap.c b/mailmap.c
index 253517cdf6..0168342650 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -244,7 +243,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 					      const char *string, size_t len)
 {
 	int exact_match;
-	int i = string_list_find_insert_index(map, string, &exact_match);
+	size_t i = string_list_find_insert_index(map, string, &exact_match);
 	if (exact_match) {
 		if (!string[len])
 			return &map->items[i];
@@ -266,7 +265,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 	 * overlong key would be inserted, which must come after the
 	 * real location of the key if one exists.
 	 */
-	while (0 <= --i && i < map->nr) {
+	while (i-- > 0 && i < map->nr) {
 		int cmp = strncasecmp(map->items[i].string, string, len);
 		if (cmp < 0)
 			/*
diff --git a/refs.c b/refs.c
index f1ff5bf846..a8f06b9a0a 100644
--- a/refs.c
+++ b/refs.c
@@ -1688,8 +1688,6 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
 {
-	int pos;
-
 	if (!extras)
 		return NULL;
 
@@ -1699,7 +1697,7 @@ const char *find_descendant_ref(const char *dirname,
 	 * with dirname (remember, dirname includes the trailing
 	 * slash) and is not in skip, then we have a conflict.
 	 */
-	for (pos = string_list_find_insert_index(extras, dirname, NULL);
+	for (size_t pos = string_list_find_insert_index(extras, dirname, NULL);
 	     pos < extras->nr; pos++) {
 		const char *extra_refname = extras->items[pos].string;
 
diff --git a/string-list.c b/string-list.c
index 224bc182ff..e69923cd88 100644
--- a/string-list.c
+++ b/string-list.c
@@ -91,8 +91,8 @@ int string_list_has_string(const struct string_list *list, const char *string)
 	return exact_match;
 }
 
-int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  int *exact_match)
+size_t string_list_find_insert_index(const struct string_list *list, const char *string,
+				     int *exact_match)
 {
 	return get_entry_index(list, string, exact_match);
 }
diff --git a/string-list.h b/string-list.h
index 03c7009472..f6be2bd5c7 100644
--- a/string-list.h
+++ b/string-list.h
@@ -173,8 +173,8 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
 
 /** Determine if the string_list has a given string or not. */
 int string_list_has_string(const struct string_list *list, const char *string);
-int string_list_find_insert_index(const struct string_list *list, const char *string,
-				  int *exact_match);
+size_t string_list_find_insert_index(const struct string_list *list, const char *string,
+				     int *exact_match);
 
 /**
  * Insert a new element to the string_list. The returned pointer can
-- 
2.51.0

