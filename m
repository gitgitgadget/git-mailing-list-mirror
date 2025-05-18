Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34113262A6
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583848; cv=none; b=H7bvp3qBNqf04pvNIDqUyMXJnc6CBSxCu2PEnW4iY/7c1mERY3LolL/NrijBQ8zDIdV1lnHJxJmp+SyxHq3gc9+N+FmERb8nHSQcMFQhHULZJnKTUAQrOyXc/hQQYjDzYyASg8hrbvAmA+/LYYBoir4tuJMEpgc0JZViyugHnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583848; c=relaxed/simple;
	bh=5NxNJH/gCAp++wdjRBqcHdT3I3+BzWnmSMYM0RCBt7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkMzi71qYRUDK718PPFOlQ2GQAFF9AqSOArMjEy4S+lC6h+heltNG5vVRp2zvgymRZmxAAIY95TOSqwXQICuTs9K3W4paLOthHKETptfubmO+rrMUSyaue3yZaw5KOXfBXfGimXLtAOSrXfkdpq2GxSHdiw1klIENWqwho2z9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsLthtme; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsLthtme"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-231e331baceso20033555ad.0
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583846; x=1748188646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbm83IzdeMb7pvwXKY2qO0ULGQpZDCJ4xvzNQK3Or34=;
        b=IsLthtmeUyJpUgyOPVhzeSD7AqYC8/4+UPLqUM/Bi6yCwkXVNDdVNyuscdQmLiEc4O
         BBTKHYrODcxo7SMvZw12m1Q60vGUyJt/HrofgVR/y1LYtEUytcIaUg3roFQrDrfTPf+2
         UbEQ6ierdfrFHQzcwgPS5CsgSkihkEzFjnOovr7oQGYAUnpY6zJnfm/1O1zd6nleHhSL
         ZTuh6OcQhsVZ6rZ0HgqIMHU8Ch/o542ULu3RGv/LSAVDImY9sGUH58z8WZbdd87cv7R2
         HF8cVx4EbKPu/Iv99anTc/DXZPDYDa+E8O1xQeuKHjg/wvFzvb4db8LsC/DuOY5WbPBP
         3aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583846; x=1748188646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbm83IzdeMb7pvwXKY2qO0ULGQpZDCJ4xvzNQK3Or34=;
        b=koLLu6TFEv2V2CwUdhxgfh3+YjGSwWNPpR/maDP3ntW89aYOIYDi4ufg/POsmRA0Iz
         2R9WZgSQ3uuwwl8rmOZuHxKHJ1Bw02yDAbvDgEH07tAlthYFoDj0A70Vr1vqtoJu170z
         KhDNcv3SEx6hbfDqGSRXivZ/fR/m5cyM03fZHEZJu6cAwGtYjnQ87Gyoc85y3jPJnicG
         QajU4lD4YJxPyQ1pPbMfPT2UeCnS09tQ2ifFZaPWJUVPeGUMK9XV8uT6WziQmTRSiE43
         dQIO89AglMg2TcKryyzvnjxqopPRJ02nC63rgUWA+TUSUuLJkvakdDI41jJA4BwqqewM
         amVg==
X-Gm-Message-State: AOJu0YzYShQVyHHEGkG/Wj0OT2FSkPNn9SKyD5MkehzV1kLDk5As0uis
	Xj6CKoTMzZK6NA2EhPsFvzB0Cu8BOxxjlMJyL0q8pqcsqXNGmNjza0IBmb/Xtev2Vi0=
X-Gm-Gg: ASbGncv1lAh8FtdpQTjCAfkm3IqY55PIC+zWhHaFz4YDVxkHIah6B2hWyk394zGa6sU
	hXL6l2edOPmGVGNRrSmL5847j93SvFt/2Y4Jf5VKwHDhZTDNIakXda3r+gPYV8FJ6rU1WS17Yny
	W2PU1Z6rt7F/K6Lp5FuH8ykQNzNQbsCxO5hF7d7hR5EVU5i6JwEu+AAbdQhrTYrxE4wShrBCq4+
	lPO+RqOFBBvtSg+ke7Py8S3t3T1N2eDPisD8dZS28BNl88Ww+SIYIM30Pz0BknrICIwzqNmIfE9
	rpzv1qmgjSXUPbGpnIyrC1Wj2ZznVsbNvKisjIuhR+u4hEs=
X-Google-Smtp-Source: AGHT+IHh2AlQZYw08npuOPKNohCYgErbq4GXSZom9xaBIMqyGS59Ec8zxOMe/TxWC+eQDBh/8sJxSQ==
X-Received: by 2002:a17:902:f68f:b0:232:4417:537e with SMTP id d9443c01a7336-2324426997cmr11895015ad.21.1747583846147;
        Sun, 18 May 2025 08:57:26 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ac9474sm44902305ad.34.2025.05.18.08.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:57:25 -0700 (PDT)
Date: Sun, 18 May 2025 23:57:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/8] string-list: enable sign compare warnings check
Message-ID: <aCoDY4A62uWb-_MV@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDB9P5XV1lHMil@ArchLinux>

The only sign compare warning in "string-list" is that we compare the
`index` of the `int` type with the `list->nr` of unsigned type. We get
index by calling "get_entry_index", which would always return unsigned
index.

Let's change the return type of "get_entry_index" to be "size_t" by
slightly modifying the binary search algorithm. Instead of letting
"left" to be "-1" initially, assign 0 to it.

Then, we could delete "#define DISABLE_SIGN_COMPARE_WARNING" to enable
sign warnings check for "string-list"

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
2.49.0

