Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBB35959
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171277; cv=none; b=UpARFyMJU2JfQX/5E9qfacgf8YaXDds0kzfn02umCn/JEit86n91hXJv4PEakW8+tntE3BMjDNRKvZpqvtbgxOWwjExLO0/d0agoFSgGLYkWWJMw6mt5ZmY7SWu40STUyg4CK3g4qwK3IMELF1qBIUnqGqLUjU3Fn5S8lRlx8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171277; c=relaxed/simple;
	bh=D+ReB0rVpgFjybaq/e9HrHH3ZaLZ74F/5iIw+HHlvEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcjHzqVjpegMUpXNh1X6IkyD/x4xMNnS+HsIKMcE60YDcBD8nOoGprVpWpLbpDBEHiO/XqE2AoMr2+HGTWLrKxl0JILxYNCBcE1532LWm8CyGgGksqyNMOS9rOjO3M6ZXnCVoRNM+2cTYE0Lmj4SYt+GCv5ecUrgxvjOFoHcJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEAULQPy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEAULQPy"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7426c44e014so3791324b3a.3
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171275; x=1751776075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+ti2UOGrIZ6MdrTwTda2JC6v1OqBFuibvZ6kIx0JbY=;
        b=XEAULQPy40Fvs0nDLcqKAfUe/isYDpjoeBso/b+NRPFL3FZrLQZ5DDoyPz7Bz9bKMl
         ShC93yiRlq8yFPMnGJIwMFoujzpF7rD4UIbqBT1fU3yQPJRXVtTCiOkKC63a9ANRrtoW
         gmmrl2qGuziGf9GFTNIc4VqX2hr2tKZ/gJYlfvvwO6kPO8y1v1MXjaGXsD4vgpABQT9D
         cmqGNgShwERZfqF63FR5iQINJclWAyw/JeGBZec6LcYYv1W5QZMK8mOdquf6VGMv8LL/
         Lyl9hBuk/WAPMrw+TQhLZVyUZIirHQOIc+h3o2LaJTTeA7O+5xOTYOgLgRh9OqrmKMtG
         apWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171275; x=1751776075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+ti2UOGrIZ6MdrTwTda2JC6v1OqBFuibvZ6kIx0JbY=;
        b=vfqF5wDf2v14t6EIZOLMLbgPepsFM1sQh5Pkx1+xInXB7e+dkc3Oo4WUtB/lDnsgMU
         8y96qRsG3+vhCxKM5YC//LbzbFWYQqlB1mNdKyuqYVpUYByTud8X6M2b1WUQnddQoWZo
         YSLcJ3LGvmfCPz9u90rdfEQlejViQAxrZEdXwoR+kP57xit0Bmpl36U9U+nSdtwE9v6f
         JvDzjfx4DMwIwEgU2oX6Vzw0MemyJ8YeVESVbJulX85GPBXOtjHWim3We6NP8lOLZ0EI
         DGdPPz0zMl0kCdCF1Rafz8gT4RBZHInjRUu84LSVPIzCFpgkCjblMbAipd3Eo5zo02r8
         RYoQ==
X-Gm-Message-State: AOJu0Yw1SkZKBCvDxdRiL+9IXgp0qJg+ozdN+ANYaeKe8eYDZiVLxeI4
	hnLduRcBfmtK8LGdp9/HkaRarmuE0Zrrx5juuXSdTE7FquIFMDVDPAJxpPCCeg==
X-Gm-Gg: ASbGnctpGhK5GKcRQxhWGHtfNgs2uRJZQforlJYZRgCCi6fFqp8mDAjvKEDOtZkd5MF
	AgdX12rGrt83ECD1hwuA6eCFkEQyQcM7OPb/FA1FPGlXZIWZESTvyqmr4k0K6i+ULdaxUO+7tR+
	vG7SDbtGUUfwrvuPWFTVB8Xq2r1jfGYDVJT++XyJWzHS9sbOu8PXzq346XL1uuTd3aUalWRDE1u
	4DTmuMzbofC+GUyP2jxQg9WSzVh3jLY1pKMEj9/uC4CmxEw42i/qOs0hZV6ZsbCgYDF2f5bgVLy
	yO5oinWwrsrOnx3EqMnTHSN0HChLvUmyPgwMtrOco5rbfu/lY5IR+Dxbug==
X-Google-Smtp-Source: AGHT+IFeOwjb29VOth12LjKk2I+Gu+nAGa7bzZ4Gc09zVbODBzf2TVy8cOKOj+W23kc/AlJp/sh/dw==
X-Received: by 2002:a05:6a20:e607:b0:21f:543f:f11c with SMTP id adf61e73a8af0-220a127e617mr15276366637.2.1751171274936;
        Sat, 28 Jun 2025 21:27:54 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af5409895sm5725408b3a.7.2025.06.28.21.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:27:54 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:28:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 4/8] string-list: enable sign compare warnings check
Message-ID: <aGDA1lr_-CXbq75G@ArchLinux>
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

In "add_entry", we call "get_entry_index" function to get the inserted
position. However, as the return type of "get_entry_index" function is
`int`, there is a sign compare warning when comparing the `index` with
the `list-nr` of unsigned type.

"get_entry_index" would always return unsigned index. However, the
current binary search algorithm initializes "left" to be "-1", which
necessitates the use of signed `int` return type.

The reason why we need to assign "left" to be "-1" is that in the
`while` loop, we increment "left" by 1 to determine whether the loop
should end. This design choice, while functional, forces us to use
signed arithmetic throughout the function.

To resolve this sign comparison issue, let's modify the binary search
algorithm with the following approach:

1. Initialize "left" to 0 instead of -1
2. Use `left < right` as the loop termination condition instead of
   `left + 1 < right`
3. When searching the right part, set `left = middle + 1` instead of
   `middle`

Then, we could delete "#define DISABLE_SIGN_COMPARE_WARNING" to enable
sign warnings check for "string-list".

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/string-list.c b/string-list.c
index 171cef5dbb..53faaa8420 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "string-list.h"
 
@@ -17,19 +15,19 @@ void string_list_init_dup(struct string_list *list)
 
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
-static int get_entry_index(const struct string_list *list, const char *string,
-		int *exact_match)
+static size_t get_entry_index(const struct string_list *list, const char *string,
+			      int *exact_match)
 {
-	int left = -1, right = list->nr;
+	size_t left = 0, right = list->nr;
 	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 
-	while (left + 1 < right) {
-		int middle = left + (right - left) / 2;
+	while (left < right) {
+		size_t middle = left + (right - left) / 2;
 		int compare = cmp(string, list->items[middle].string);
 		if (compare < 0)
 			right = middle;
 		else if (compare > 0)
-			left = middle;
+			left = middle + 1;
 		else {
 			*exact_match = 1;
 			return middle;
@@ -40,10 +38,10 @@ static int get_entry_index(const struct string_list *list, const char *string,
 	return right;
 }
 
-static int add_entry(struct string_list *list, const char *string)
+static size_t add_entry(struct string_list *list, const char *string)
 {
 	int exact_match = 0;
-	int index = get_entry_index(list, string, &exact_match);
+	size_t index = get_entry_index(list, string, &exact_match);
 
 	if (exact_match)
 		return index;
@@ -62,7 +60,7 @@ static int add_entry(struct string_list *list, const char *string)
 
 struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
-	int index = add_entry(list, string);
+	size_t index = add_entry(list, string);
 
 	return list->items + index;
 }
-- 
2.50.0

