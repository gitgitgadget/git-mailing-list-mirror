Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDB27EFFE
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263354; cv=none; b=BNpQTm+hxWpB763yHEgFTtUrndrurfuKvsUL9TewJHuLWSWnpcWOmXz2/Gm2FBviS9ddSQfS0tln3+Hh/K81FPuI2Vs7qc9sVJThwU7sro2eDA8eYslsErO0lLUI95G2+8rQLscmVTy1ssOUtBdMxnP2QspccaF/nZfbxNkbemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263354; c=relaxed/simple;
	bh=fuRSt8eU1j9x5qauZQemWZsxZPiXw3VX+SklV+6x9tw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqBZNFNcihmBPQMHZL+xxgLJMX3MRWD0XzftlEMuNV9uH+JiDlbLcVJwMpl1Ejxzhkb5tZlSkkgwKEWC+Bqq585Um/ZZnlMDXPQe5zTXf4b378h6dB5GOsKhWUFvOhkF0IaeH72IgeyzxTw6Vp84dj4c3/bZtQt6M/kWvoooezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBeRFeTd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBeRFeTd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25221fa3c9bso6384225ad.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263352; x=1757868152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=623Aw1xNa1r81cbIejQMkHoHd1G9iCVGfEk8dMie+K0=;
        b=CBeRFeTdMzga/xG2RWEuySQYw+O0aE/kBXn35e3Pwupg/QihS2mk2B8XpKCXdbngae
         yAEdsEgkcUlnzgOLfAHPwlBdcb3YqXEC8acgQRIWR6OsYAi0dNaK/lHlfGQmK45aUxLW
         BRXiXKIDZzpiKdHfV1xx4TmfONGOCLU+G9OmXFL61zoApaMOxyLPlkqNpHwaazZ15A+Y
         NrE876FW8Pbfr80nphPMrWM9pvfoyhnHyI13mfIV0nZsvwMVQYMPlOGVgEEN3GDcDM5W
         /R4Rf6rE+vKqiWfDv5qWTABtE0HddTkwprZGymEAs3Tq5JR/WLz3SNiody4CVSL82c6k
         Nvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263352; x=1757868152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=623Aw1xNa1r81cbIejQMkHoHd1G9iCVGfEk8dMie+K0=;
        b=QKoaesqzg65Err5YFbkKETedryt9E1BAWraqvD8dOHwKkbfvtzSY639ega6qjdod4v
         FEReFp4Dp68zzkINwWgRNQTLdW/KjFEoP8M+msEk1zz1Bf64fh0vktvk4+W9z0sZl6zc
         1oESg3QGUKmkjDrJzUw5Uqhc8YNiJSK4suObnpQcr9HVgyzKdrvXjns8uE0odCS8qXo7
         tYvb1F4zocWNupJxREC7qopE3OvBPTPV2nXMbJbcbY7IPnYn74XT/CsyK+O4MFG6McWE
         UiMvopODDOBuk56iIpgLPFemqxrU9qNb43orZ03MKtCELi8vOofU1sxzbTugIt3k01sd
         /XwA==
X-Gm-Message-State: AOJu0YzaiLsZN0dT5vpLR5NwqFf3AMMbLXXySaB/PUMDPFBraNUvzc+b
	Xpzi1lTxee33ibW4AMVH2vvhpqMZjov4l7yqXUgsebmLROaTu46KKczXFE8w4gf1
X-Gm-Gg: ASbGncvZEBmqJxLNdxu4c4r7rYl9Mbn83p9vS974fOzr+eePALfDntnjUCGxt5cgJGm
	7ddQaEGsNxlrIUNQe8i2eDq3T7C2Y5w22tlBhL1kOLYiJZIyYyU7CcSGEOxrNon04TYT9b51hip
	euAoYyCxyS+OPpYtyovgqNxokfmtCKUNo6764HTShKWH7XovcAV7RcLu+Zr3y+94b0V6del/poK
	KX7b7s61mtkQfn7AAsE/D+8Ao5MOQvb+0Pmgc3MNzjsTEqUtVrvV5Mlb/WyN0+1WXJ8G7mQVDUn
	C9BH9xS8HfrTUeNT+ihlEEksVROLX3CvfC3D4xIDQNyn9QNnlpLNCscvNWLnXi2WLtCO3MkVt8r
	yFdHQXjvp6r+hmn6DrHzydnV6JzhP
X-Google-Smtp-Source: AGHT+IFO/YY8W0Iv9AvYbukzSR6+uQW/+YV33fTJiVOvUPrRUBPTyIBKfQ+SCkpAsUycqzQSOiPhbQ==
X-Received: by 2002:a17:902:f78f:b0:24c:e9de:ee11 with SMTP id d9443c01a7336-251788fcff7mr66997945ad.17.1757263351533;
        Sun, 07 Sep 2025 09:42:31 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24cbe170977sm97008635ad.42.2025.09.07.09.42.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:42:30 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:42:29 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aL219d7FYJQNKBEf@ArchLinux>
References: <aL21cEM0OcnrKtBW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL21cEM0OcnrKtBW@ArchLinux>

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

