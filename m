Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03A35959
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171268; cv=none; b=E1GT1B9tgmRZiBt8XKpo/JgTj18JrBJKM3bdyExD8MjQgl6PBR+6z88NvRcqaJc6SL1eQLAV3IfyaAA0ygqFgYSTlibCKzhHU5XtzvKUBcdKGyq5pA1lZzV9I4Ac/3nEipORhqvPc5arZYyI5Vw4Y4JUiuSwjiBWzVBK+iwarU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171268; c=relaxed/simple;
	bh=AtvZ6LkrvGa1pYqb+fke1RV/KzvoPk1GmGIk5x9woAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq04Pt+wmlmptu8cL0nm6gth+AdnA8jobS22PXi8ok22vumfJ5AdhSjOnlUJR8aCnskwb2XfqV9vKuJdpwA9EgOXHdyx2cI29If57TP69Unk/omlrU4El2fSgag6o3gCx1RAaD9eggiCmaK03JjnRroULv/gnCgEsKTY07JgQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjFtNyJP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjFtNyJP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235a3dd4f0dso20399745ad.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171266; x=1751776066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2a+rd8hSs6qopD02RMDdbJedoL648o17dp9dzmZBn8=;
        b=PjFtNyJPPWemSUJ6LmrHUD9KSsfG4m/2wp+wpuYYr++JUEXhDxeX5od4x2c8jvk7lc
         I781xV7WM10bgRm4DBYfECJy/sIXPQPzzJc7VHXSFN/V3+19ovwOffLY7sVwO6u1p4ku
         Yy0pIUI7Ii4ALnHFphMbZ/jPd+ahKuFoHCJyI1OkV+gua/bTWpB5YUDOK61MuJfFldqh
         uGWb9HOaOOFiQ6xhSMqzewqubkF8ozOCxeUEbA+rSHaDJGG35poKvTey2MwsbSVr4Mjq
         3JIsa7mobEF0rbiTD6Rjfln6ZI71Mm44xLtMlf0eVJIND4LYWodHU/5a0J1AMCJO52mA
         bVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171266; x=1751776066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2a+rd8hSs6qopD02RMDdbJedoL648o17dp9dzmZBn8=;
        b=I0oW8Hp2MP6ce9L1DJYuyNBB9jkW7w0hUopZuqWMfSn2EIbOiRfMAeaxrJWF6XqqNb
         qMwXc/Llj3G2zurLonFRLThq8xbPkWQ+7P/NYZf59EvyILDj/Evl8hBFY66mQxbp1Wkk
         U9YfuU0DKBb0sNxJuFiejkAihaOywzhrFiyNGCvETz9yiGd4c8JGrlL4EWYdahGjaOJb
         u5HbI17zOICt/IX75sPJDJYRGLiyb5O4ClSxfhDk3qGqz1gQ3pWPvN3qTp3T9QtK3Li2
         XXtz27wCv+ci7ZHb4hrVrbpTgUD0947mRDhl9n/iD7gkfdFgcXAXocEPrhhbP7GIXq2X
         +cCw==
X-Gm-Message-State: AOJu0YyneMZ5Ulv8qipToOVwXntkGvbxTt3ja5whZghb2Wel3Wazrakd
	yGQJ7GKz1AMyhiYFwsAYAKNtqoaw0yBOGsjYMpRbTEOiFy8+Pkt0Z32vYRxZfg==
X-Gm-Gg: ASbGncvrDruTSJvlgGblR3dOZ5Q3JH937CIhRDuKXulv/osPSSd1ZnX+bXfn75QYdkw
	839RgqfCE7ka31Lb/1zz2/TxWQFY5XQJO46FTY8YMg7iBw+LtU4haMCGoGNxV8gcUdmY3WoBA2z
	T/oXOTuCNSyTcfPXf/hIPPt9GEBnxY8yOuA3aXdIqXnNoBQUZIayXoC30Tk++7IQuJIolSffiqT
	QYzIcaBqUIRWdauUur8bcz5K8cUNca0rdtHG9Ptx6RCTGv1UwNIAD5vX7T7VlepXfSTWIFMZcr/
	PYQ7aK+T/42yVcGr2ODT/mSFLRp+TLExWkACM1kuNw7g6arSkIMFWDEI+g==
X-Google-Smtp-Source: AGHT+IFuTxvcUYIvUDEI3Vh+7ZHz1vAwX2uUllyLXP9V0VlJOZaARbS5Od7+4VI4dOqHV0bsML3/2w==
X-Received: by 2002:a17:903:3a88:b0:234:ed31:fc94 with SMTP id d9443c01a7336-23ac4633e37mr140866515ad.26.1751171266253;
        Sat, 28 Jun 2025 21:27:46 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f542708esm10488887a91.30.2025.06.28.21.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:27:45 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:27:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 3/8] string-list: return index directly when inserting an
 existing element
Message-ID: <aGDAzeRqrBEUG7lX@ArchLinux>
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

When inserting an existing element, "add_entry" would convert "index"
value to "-1-index" to indicate the caller that this element is in the
list already. However, in "string_list_insert", we would simply convert
this to the original positive index without any further action.

In 8fd2cb4069 (Extract helper bits from c-merge-recursive work,
2006-07-25), we create "path-list.c" and then introduce above code path.

Let's directly return the index as we don't care about whether the
element is in the list by using "add_entry". In the future, if we want
to let "add_entry" tell the caller, we may add "int *exact_match"
parameter to "add_entry" instead of converting the index to negative to
indicate.

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
2.50.0

