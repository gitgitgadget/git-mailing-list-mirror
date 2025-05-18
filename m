Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AA262A6
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583841; cv=none; b=nB655l2CZnOMehK7BDLi+JKUoEA71fPE+WtNy+qYE38Mdp29vhBz+Q0viM3DdOofX46zorDURZO3c/U9Qumk3qOmmBcRbMCAg8oihlKL3/fECmupEUuYlRB4bUHadGG3x5Jxf+fAbBsH6C15joYL3qToPIhm9h4cfCaIxx+Wv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583841; c=relaxed/simple;
	bh=FDG2VGSqrrnlEin8j3N4X/4hsihDgiVYMFr3nvfvCXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3H7RSKcVzGIXrC2yWQ5F1iFei0Bce1sIc/ZllXcPFwrVoOo2U6vk/JhLFYSclgKEKLZcAv5AuLxD64G6b5v5EHTyRCeQ6KmzMyyMdlB4jMz25Eb/P563uFsuAX8mYv/4EUeXuPygqG51IaIG3db8KcDJ1BirLtieiqEgGqUvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjhfp6Be; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjhfp6Be"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22fac0694aaso25125295ad.1
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583838; x=1748188638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ0ERFPt1U8OvyKDCqRRg9AlecSwpzMdQeG8duhK+WY=;
        b=Mjhfp6BeO926yhlm35wGfOCNIxgdToH2eZV23fe1vh4C/5/JMnGo5vJ2A28T20qLnb
         soo4W9YPeKxC+myot8VJlN4lpiy0fiIuEwZjsszBMObtSwMfj89cr7+gKWzCqO7vnQa+
         f1z17OC4GYuQ6/74Q7ASsBqIgrOQFedmhClPuJPtzdpAvEHH5GYdILOmDNaB7f3mBj8O
         jin9z40tsuuQEY7rHZPw+wsgQR2BbekOJQ42dNK2U6+SDRRf5KWShi7qBJsI4IUGjAUQ
         MUDF8PQbyDUUIQJkoPgNGSv767oip6UVzO50BQlaIjDGCJKwmQ6cG8VgUxLsaDolIR6a
         cTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583838; x=1748188638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ0ERFPt1U8OvyKDCqRRg9AlecSwpzMdQeG8duhK+WY=;
        b=kVzPnAPI2YQJvQVfL8NQqPj+6T6+qV3r8E5LXudI0PuuIdyOy7IjQZ/Fz/gP94+dPe
         TfiNlFG3HVoOVRiEwx/dgdBYKxg3pC3Tjd2U8nnxTUE/irxfxQq6YNor8N6JJTNo8IzR
         0GFJaCP1bnkEHG6jOsqCgsZGVmqx/ssRS2O56px5CQyrG1uWk0GnULZDFQpGRcILAEbu
         Dv711MLLy2wm5slKubJqmDUiCQCDs/1ESew4r+8UddIS1jYMOwwDB0qcxdHSqIN+QP+U
         XJ0tEN9q8QdcjJLyv78AGFxRMvhTS6wQswn0WPgTQOpqTk7BSOkQNfbgP8Q7sdD7WDKB
         BgjA==
X-Gm-Message-State: AOJu0YzIbZ+PjqfVd7No6sFfqQ78IIlarDnh7FPv3RK4csiXiY2qPP7o
	is3j9xX/RhwuX+cYJ5JfErCVDC+okmmaxPSx5ErLaj5pVtritXyh3CPDCCL0UlqdkN4=
X-Gm-Gg: ASbGncspkuxEGE2T6M/EHoz7dANANa7SKaMnO+NVPFL7pCtHvGL3xO+9KZ3PKMJsGdG
	zihxWksTsJG7ymANReKEfG3GWUL2lutfMRix/78eOqUk2gTPZ34WzsAVsekdgXgyxdiy01VUD8x
	38BHVvYuBNo2B2TUbr54iYAT4Isd1Jd7P5h6nLvYCMt+3RdeNhZw05+2P4+Os6tZ/KsqwovUVDg
	u8QTUznFhwJzOMdTn+Jv+Zy2TVf0pvpAWDzVp+VktdikMXGxXTaoPIu/3N19iApFAaB+LThKp4J
	N38cVtAn4uEDDCII8SwbTyKDUG3toZBUkiSdMsRwrK0g+KOXwJbyfLLNUA==
X-Google-Smtp-Source: AGHT+IGygV9B6RaUVVDRemYeqqD7g5M56EeGjWhKCRnoTcBBDiILE+AfCHAvrHkp/zO3LtO7nawhKQ==
X-Received: by 2002:a17:903:32c4:b0:231:ba39:d927 with SMTP id d9443c01a7336-231de3ada60mr145032615ad.38.1747583838575;
        Sun, 18 May 2025 08:57:18 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e980c0sm44915455ad.126.2025.05.18.08.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:57:17 -0700 (PDT)
Date: Sun, 18 May 2025 23:57:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/8] string-list: return index directly when inserting an
 existing element
Message-ID: <aCoDW8CcWeq8T9hp@ArchLinux>
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

When inserting an existing element, "add_entry" would convert "index"
value to "-1-index" to indicate the caller that this element is in the
list already.

However, in "string_list_insert", we would simply convert this to the
original positive index without any further action. Let's directly
return the index as we don't care about whether the element is in the
list by using "add_entry".

In the future, if we want to let "add_entry" tell the caller, we may add
"int *exact_match" parameter to "add_entry" instead of converting the
index to negative to indicate.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/string-list.c b/string-list.c
index 8540c29bc9..171cef5dbb 100644
--- a/string-list.c
+++ b/string-list.c
@@ -40,14 +40,13 @@ static int get_entry_index(const struct string_list *list, const char *string,
 	return right;
 }
 
-/* returns -1-index if already exists */
 static int add_entry(struct string_list *list, const char *string)
 {
 	int exact_match = 0;
 	int index = get_entry_index(list, string, &exact_match);
 
 	if (exact_match)
-		return -1 - index;
+		return index;
 
 	ALLOC_GROW(list->items, list->nr+1, list->alloc);
 	if (index < list->nr)
@@ -65,9 +64,6 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
 {
 	int index = add_entry(list, string);
 
-	if (index < 0)
-		index = -1 - index;
-
 	return list->items + index;
 }
 
-- 
2.49.0

