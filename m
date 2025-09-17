Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFF299AA3
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100677; cv=none; b=QHAs8zWwVGHXkum/T5Vy4wHRdmsokXr8Ai3uorzoAEp7e79vT5g8A+v07afsAsc+99u3BMSIRUj7fuA29lq5mhjvFqgNg/VrEsqdNXDs3T1wiHGE3816dytVKJUj7pMCOQhq3my8s7lcnIbU4bRdziz0CN7TGKTcEf5E0mcU230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100677; c=relaxed/simple;
	bh=/agjl/BF3yxsdBdbMEbaUK1EfQLVW3Rr8ymQ4af3PKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q29kTC3tEjHBXDUeevQU4SqsJnSD+GFjclX2P8Hgd2YtJ8GoSpqsCkK8aAfFYnWMuj7tdGuf3dyQYBgZIQfBDKt5KZ1Zxjzoq/dCVxl6VMK/BRohInxTauCJG09Qyqz4EQy1L+Ndk+OkxgBPnNSI+xvNyXAZofWuVbQhzeeWDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMR+TChF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMR+TChF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244580523a0so64844625ad.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100673; x=1758705473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18yr7KIsZVJc2hkAsN34gby4VovjjaStGxSTZoUPPDg=;
        b=MMR+TChFhiXJWWisMwlkhCdWI7zU/3k0QWlNufk8hfmSzwNofEC4Rf0ZXTSo4cq5mq
         cyBcEt0XrfACxq7BZtwAc83CNpIp6pTV+lBlsOaN5DJHXPDY7k4ZT0thn5OMZjvIrG3w
         Yt2lD2Lt7R1nzNX95MO4lahA8hfNz6/ypqmn6lHZKmLZDSVoqH+JuMshAnvZdvhQcVSq
         rHpm/j21q2QBHIaT0ZXAwkbaBZDjQcXXcE1KKXiwKulw5ut4MxrQHN/Ga1B1AI/bX75B
         5WDnED0Ldubsk9VWSQibg5qZOtuZUdyzf6F1PSr/unYkpAKfOvAJtZiBCeYlnKOPfgw/
         9w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100673; x=1758705473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18yr7KIsZVJc2hkAsN34gby4VovjjaStGxSTZoUPPDg=;
        b=aDqiLwGRPi3MrsHRysNjuII6EvGEGqiTZFeHMKPf5YFA4g6/8g4NvNGLYxZGaYV59U
         cGQzkXzIXJYYt7O2bIE+iIrNF9caL2rxC6QkOk42T9pULYXAirWxFLXhpZkeq8vBi6oG
         eddeP26Rjx9ypZJ1DDuH74DGg4P99RRARDOgV0Lct6c8HQ/eTiao9paWshRptPxFlBV6
         fR5Cpf9M+W5ljfOJySaGKG2mtRlK9kbhjFoTZ3UWSZh+UE5f4IRQ3bb1qC3z+c4AOm5X
         q7LVe1yOIoQ38Nu7t5td07QHwR79+syex1xkxXthVe0fpupGdwt/q04iuArFPealPeNq
         pREw==
X-Gm-Message-State: AOJu0YzVT5OZOyktyo2kVhja7VDMajSDyZmfNXEEcPTlZ0B+979xMWX/
	R7z0LC4kVLYZqpF/bX5jVIB93ryFRu67vbjpjS/iJiYqdFe8FG/JLi0SYsZInQ==
X-Gm-Gg: ASbGncvO4qW1jtj0q/j+GL/LmDy66O3fV1D45K7LSnrL+O+44ICa7vXGXqdnDVJ0ud6
	L0at6nrsoQDHYtHyBp1MbOEY0YnEcte68uAb02XT4ic3XayToJqUzKCRC4xk6DkIo2USwm9Ch65
	u9tNp7RRuLda3q7+8iqpvGStW1Bx4IxdGmShXQOcg155NWeGzThMkOOSGBzzhXpUF6WRIQEOH0N
	gNSMkHNAlLl0xpchVPxl5L3oGDlmdCBcrdzLS5nj28CfdLAJG89aZSzwWM7aV3hwEN8PCPHTrYM
	fFtQICYGEbW1ixyJTJNA+GdSh94F6IcGnU4IyhvecLfvpbQMh0BTc3JXr4HsQuNDE/eyLPm589B
	8GIabw4fzBI+FtmgftA==
X-Google-Smtp-Source: AGHT+IH99wGGiHAGiPWZLlqvnWXezINBBCZ5FRZs6gUkh1SLk7qzxsIJCWY560bt+bKl6PzrWGJYbQ==
X-Received: by 2002:a17:902:e888:b0:25d:885:5b6b with SMTP id d9443c01a7336-26813efa202mr16467065ad.58.1758100673329;
        Wed, 17 Sep 2025 02:17:53 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32ed269e442sm1865647a91.12.2025.09.17.02.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:17:52 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:18:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] enhance string-list API to fix sign compare warnings
Message-ID: <aMp8yNFiXDyk2hP4@ArchLinux>
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

Hi All:

This is a small PATCH to enhance string-list API
"string_list_find_insert_index" which has introduced sign compare
warnings.

---

Changes since v1:

1. Create a new commit which aims at using `bool` for "exact_match"
   parameter.
2. Rebase the [PATCH 1/4] and [PATCH 2/4] into a single [PATCH v2 2/4]
   commit to avoid confusing the user with the motivation of the
   original commit [PATCH 1/4].
3. Enhance the comimt message of [PATCH 2/4] to improve the motivation.
4. Update "i-- > 0" to "i--" for [PATCH 3/4]

Thanks,
Jialuo

shejialuo (4):
  string-list: use bool instead of int for "exact_match"
  string-list: replace negative index encoding with "exact_match"
    parameter
  string-list: change "string_list_find_insert_index" return type to
    "size_t"
  refs: enable sign compare warnings check

 add-interactive.c |  7 ++++---
 mailmap.c         | 10 ++++------
 refs.c            | 13 ++++---------
 string-list.c     | 29 ++++++++++++++---------------
 string-list.h     |  6 +++---
 5 files changed, 29 insertions(+), 36 deletions(-)

Range-diff against v1:
1:  d3333b4ff6 ! 1:  c3786fa386 string-list: allow passing NULL for `get_entry_index`
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    string-list: allow passing NULL for `get_entry_index`
    +    string-list: use bool instead of int for "exact_match"
     
    -    Callers of `get_entry_index()` are required to pass a non-NULL
    -    `exact_match` parameter to receive information about whether an exact
    -    match is found. However, in some cases, callers only need the index
    -    position.
    -
    -    Let's allow callers to pass NULL for the `exact_match` parameter
    -    when they don't need this information, reducing unnecessary variable
    -    declarations in calling code.
    +    The "exact_match" parameter in "get_entry_index" is used to indicate
    +    whether a string is found or not, which is fundamentally a true/false
    +    value. As we allow the use of bool, let's use bool instead of int to
    +    make the function more semantically clear.
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
      ## string-list.c ##
    +@@ string-list.c: void string_list_init_dup(struct string_list *list)
    + /* if there is no exact match, point to the index where the entry could be
    +  * inserted */
    + static size_t get_entry_index(const struct string_list *list, const char *string,
    +-			      int *exact_match)
    ++			      bool *exact_match)
    + {
    + 	size_t left = 0, right = list->nr;
    + 	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
     @@ string-list.c: static size_t get_entry_index(const struct string_list *list, const char *string
      		else if (compare > 0)
      			left = middle + 1;
      		else {
     -			*exact_match = 1;
    -+			if (exact_match)
    -+				*exact_match = 1;
    ++			*exact_match = true;
      			return middle;
      		}
      	}
      
     -	*exact_match = 0;
    -+	if (exact_match)
    -+		*exact_match = 0;
    ++	*exact_match = false;
      	return right;
      }
      
    + static size_t add_entry(struct string_list *list, const char *string)
    + {
    +-	int exact_match = 0;
    ++	bool exact_match;
    + 	size_t index = get_entry_index(list, string, &exact_match);
    + 
    + 	if (exact_match)
    +@@ string-list.c: struct string_list_item *string_list_insert(struct string_list *list, const char
    + void string_list_remove(struct string_list *list, const char *string,
    + 			int free_util)
    + {
    +-	int exact_match;
    ++	bool exact_match;
    + 	int i = get_entry_index(list, string, &exact_match);
    + 
    + 	if (exact_match) {
    +@@ string-list.c: void string_list_remove(struct string_list *list, const char *string,
    + 	}
    + }
    + 
    +-int string_list_has_string(const struct string_list *list, const char *string)
    ++bool string_list_has_string(const struct string_list *list, const char *string)
    + {
    +-	int exact_match;
    ++	bool exact_match;
    + 	get_entry_index(list, string, &exact_match);
    + 	return exact_match;
    + }
    +@@ string-list.c: int string_list_has_string(const struct string_list *list, const char *string)
    + int string_list_find_insert_index(const struct string_list *list, const char *string,
    + 				  int negative_existing_index)
    + {
    +-	int exact_match;
    ++	bool exact_match;
    + 	int index = get_entry_index(list, string, &exact_match);
    + 	if (exact_match)
    + 		index = -1 - (negative_existing_index ? index : 0);
    +@@ string-list.c: int string_list_find_insert_index(const struct string_list *list, const char *st
    + 
    + struct string_list_item *string_list_lookup(struct string_list *list, const char *string)
    + {
    +-	int exact_match, i = get_entry_index(list, string, &exact_match);
    ++	bool exact_match;
    ++	size_t i = get_entry_index(list, string, &exact_match);
    + 	if (!exact_match)
    + 		return NULL;
    + 	return list->items + i;
    +
    + ## string-list.h ##
    +@@ string-list.h: void string_list_remove_empty_items(struct string_list *list, int free_util);
    + /* Use these functions only on sorted lists: */
    + 
    + /** Determine if the string_list has a given string or not. */
    +-int string_list_has_string(const struct string_list *list, const char *string);
    ++bool string_list_has_string(const struct string_list *list, const char *string);
    + int string_list_find_insert_index(const struct string_list *list, const char *string,
    + 				  int negative_existing_index);
    + 
2:  104c090d8d ! 2:  7ac8fd69c0 string-list: replace negative index encoding with "exact_match" parameter
    @@ Commit message
         We would return negative index to indicate exact match by converting the
         original positive index to be "-1 - index" in
         "string_list_find_insert_index", which requires callers to decode this
    -    information.
    +    information. This approach has several limitations:
     
    -    This is bad due to the following reasons:
    +    1. It prevents us from using the full range of size_t, which is
    +       necessary for large string list.
    +    2. Using int for indices while other parts of the codebase use size_t
    +       creates signed comparison warnings when these values are compared.
     
    -    1. The callers need to convert the negative index back to the original
    -       positive value, which requires the callers to understand the detail
    -       of the function.
    -    2. As we have to return negative index, we need to specify the return
    -       type to be `int` instead of `size_t`, which would cause sign compare
    -       warnings.
    +    To address these limitations, change the function to return size_t for
    +    the index value and use a separate bool parameter to indicate whether
    +    the index refers to an existing entry or an insertion point.
     
    -    Refactor "string_list_find_insert_index" to use an output parameter
    -    "exact_match" for indicating the exact match rather than encoding
    -    through negative return values.
    +    In some cases, the callers of "string_list_find_insert_index" only need
    +    the index position and don't care whether an exact match is found.
    +    However, "get_entry_index" currently requires a non-NULL "exact_match"
    +    parameter, forcing these callers to declare unnecessary variables.
    +    Let's allow callers to pass NULL for the "exact_match" parameter when
    +    they don't need this information, reducing unnecessary variable
    +    declarations in calling code.
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    @@ add-interactive.c: static void find_unique_prefixes(struct prefix_item_list *lis
      static ssize_t find_unique(const char *string, struct prefix_item_list *list)
      {
     -	int index = string_list_find_insert_index(&list->sorted, string, 1);
    -+	int exact_match;
    ++	bool exact_match;
     +	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
      	struct string_list_item *item;
      
    @@ mailmap.c: void clear_mailmap(struct string_list *map)
     -	if (i < 0) {
     -		/* exact match */
     -		i = -1 - i;
    -+	int exact_match;
    ++	bool exact_match;
     +	int i = string_list_find_insert_index(map, string, &exact_match);
     +	if (exact_match) {
      		if (!string[len])
    @@ refs.c: const char *find_descendant_ref(const char *dirname,
      
     
      ## string-list.c ##
    -@@ string-list.c: int string_list_has_string(const struct string_list *list, const char *string)
    +@@ string-list.c: static size_t get_entry_index(const struct string_list *list, const char *string
    + 		else if (compare > 0)
    + 			left = middle + 1;
    + 		else {
    +-			*exact_match = true;
    ++			if (exact_match)
    ++				*exact_match = true;
    + 			return middle;
    + 		}
    + 	}
    + 
    +-	*exact_match = false;
    ++	if (exact_match)
    ++		*exact_match = false;
    + 	return right;
    + }
    + 
    +@@ string-list.c: bool string_list_has_string(const struct string_list *list, const char *string)
      }
      
      int string_list_find_insert_index(const struct string_list *list, const char *string,
     -				  int negative_existing_index)
    -+				  int *exact_match)
    ++				  bool *exact_match)
      {
    --	int exact_match;
    +-	bool exact_match;
     -	int index = get_entry_index(list, string, &exact_match);
     -	if (exact_match)
     -		index = -1 - (negative_existing_index ? index : 0);
    @@ string-list.c: int string_list_has_string(const struct string_list *list, const
      ## string-list.h ##
     @@ string-list.h: void string_list_remove_empty_items(struct string_list *list, int free_util);
      /** Determine if the string_list has a given string or not. */
    - int string_list_has_string(const struct string_list *list, const char *string);
    + bool string_list_has_string(const struct string_list *list, const char *string);
      int string_list_find_insert_index(const struct string_list *list, const char *string,
     -				  int negative_existing_index);
    -+				  int *exact_match);
    ++				  bool *exact_match);
      
      /**
       * Insert a new element to the string_list. The returned pointer can
3:  4d4bdf7cda ! 3:  1cf914fab5 string-list: change "string_list_find_insert_index" return type to "size_t"
    @@ Commit message
         string-list: change "string_list_find_insert_index" return type to "size_t"
     
         As "string_list_find_insert_index" is a simple wrapper of
    -    "get_entry_index", we could simply change its return type to "size_t".
    +    "get_entry_index" and the return type of "get_entry_index" is already
    +    "size_t", we could simply change its return type to "size_t".
     
         Update all callers to use size_t variables for storing the return value.
         The tricky fix is the loop condition in "mailmap.c" to properly handle
    -    "size_t" underflow by changing from `0 <= --i` to `i-- > 0`.
    +    "size_t" underflow by changing from `0 <= --i` to `i--`.
     
         Remove "DISABLE_SIGN_COMPARE_WARNINGS" from "mailmap.c" as it's no
         longer needed with the proper unsigned types.
    @@ add-interactive.c
     @@ add-interactive.c: static void find_unique_prefixes(struct prefix_item_list *list)
      static ssize_t find_unique(const char *string, struct prefix_item_list *list)
      {
    - 	int exact_match;
    + 	bool exact_match;
     -	int index = string_list_find_insert_index(&list->sorted, string, &exact_match);
     +	size_t index = string_list_find_insert_index(&list->sorted, string, &exact_match);
      	struct string_list_item *item;
    @@ mailmap.c
     @@ mailmap.c: static struct string_list_item *lookup_prefix(struct string_list *map,
      					      const char *string, size_t len)
      {
    - 	int exact_match;
    + 	bool exact_match;
     -	int i = string_list_find_insert_index(map, string, &exact_match);
     +	size_t i = string_list_find_insert_index(map, string, &exact_match);
      	if (exact_match) {
    @@ mailmap.c: static struct string_list_item *lookup_prefix(struct string_list *map
      	 * real location of the key if one exists.
      	 */
     -	while (0 <= --i && i < map->nr) {
    -+	while (i-- > 0 && i < map->nr) {
    ++	while (i-- && i < map->nr) {
      		int cmp = strncasecmp(map->items[i].string, string, len);
      		if (cmp < 0)
      			/*
    @@ refs.c: const char *find_descendant_ref(const char *dirname,
      
     
      ## string-list.c ##
    -@@ string-list.c: int string_list_has_string(const struct string_list *list, const char *string)
    +@@ string-list.c: bool string_list_has_string(const struct string_list *list, const char *string)
      	return exact_match;
      }
      
     -int string_list_find_insert_index(const struct string_list *list, const char *string,
    --				  int *exact_match)
    +-				  bool *exact_match)
     +size_t string_list_find_insert_index(const struct string_list *list, const char *string,
    -+				     int *exact_match)
    ++				     bool *exact_match)
      {
      	return get_entry_index(list, string, exact_match);
      }
    @@ string-list.h
     @@ string-list.h: void string_list_remove_empty_items(struct string_list *list, int free_util);
      
      /** Determine if the string_list has a given string or not. */
    - int string_list_has_string(const struct string_list *list, const char *string);
    + bool string_list_has_string(const struct string_list *list, const char *string);
     -int string_list_find_insert_index(const struct string_list *list, const char *string,
    --				  int *exact_match);
    +-				  bool *exact_match);
     +size_t string_list_find_insert_index(const struct string_list *list, const char *string,
    -+				     int *exact_match);
    ++				     bool *exact_match);
      
      /**
       * Insert a new element to the string_list. The returned pointer can
4:  9f2b55fb41 = 4:  8a445549dd refs: enable sign compare warnings check
-- 
2.51.0

