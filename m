Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3E2D8DBE
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578916; cv=none; b=CzCT59HirRQVcFgpfCO8qQNCpdYdQPXBEB30B5VXx6n6SjdiWlUJE6aOSb6oWiqOZvmSXvHfTpz+WVcWFop+Wc+89I5rCrcxc+EXN8FUysBMOqxxjLAYDWoZBWwamY3w4vmyHeS9wvgJUhxgXqHx31Bsd/qnRnEGWCw6ah1fAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578916; c=relaxed/simple;
	bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFIo26HcGMyC+B1r+m5jALPwkfk0FJ04/mKs0s23u6kFbBvQc2HUMl2Jdj3B3cESC5NVXhuO5jNlGC0vdkEVG8N4AgLCVm054F6yAWSubehydGFLhwCa4ezmJ7bnUtpsftSPgXyZ9IgBhjchr0SziCopfCQPk06YLbptjURu5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnPqlTED; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnPqlTED"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so11074210a12.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578913; x=1753183713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=BnPqlTEDGy9+3iIH7me3d9/xLeMbNAXk4v1jF0rzZPDpFFWvDOUnpe06BaOlI/tdMH
         +EztjryEd8eWwFVxzAbbSvBHqtK6fUMRUnWcwsb7zzsdY8icMTS3YfszhzLIdPjCA/q5
         +jhkagUXC1EJyhc3w8TvyjudaqytMLOTiqHcbql/RcWqC+ixVneg7ooKlXZrVS9g3R3d
         xhN6o/gliV22wnGA9Vay/Wo8GMnpTgfpcOckCdsrvorcfQeQcgQeRWo7zY+x1sRA6cV6
         ICkCRrFU+5+lAr9xwr/MTGr5B7Hri+9oAhsqERIbkn68FzxOuM+G5LUnBemvfF5EsUgc
         KgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578913; x=1753183713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=FLvM4NxWUZlwJveeE0UCZgRX3f6qx+wPLhU0fr2O72G/rrKEkwHHDGyd7CMyjcDiYz
         yQ2Td85ZW3A9dDt0Hs73Kk3GHN6Af+UKOyBwMREns6ikR6JE7O844YFL7WAwhbiI2pVe
         1q3XxaNBYYvz8ekofXIGU+LMmE2JU6Ba5Sq5mLmxLn/u2KAQa0YDhKp2J32b0sN6IvrU
         L0Ok5ToQ73QyobhWGuk+ZKp807CMckcb9lLX0fJMAYqz8DpDsZg7PpuQa+RZsjR5iMCx
         4hFaDGvGCBFtW0ZY0LsqJANIoKHXqef5AfWkSf2dCalkrW2J35yXHWIac4jUoFROyF8O
         SfsQ==
X-Gm-Message-State: AOJu0Yx/4I6eGdBkRk7CBrN/fHvAaoIzyCXm4/3XXoy38qUkIkgkBZuH
	4p012xKENsaMZcPbYZ/1nAuAriE3ZtzwfctcaRmqnYe19sCOWY4xviDH
X-Gm-Gg: ASbGncsWoYC8ShISgna7LZpQUrF2E/7J+IcD023cV3V3LMhGbq5ydVd0WFF3tUpFPXj
	wG0pW104HJLPK4+/e3ECyy1B38F4PEJDd3SEAVrIqs2SxNPl39mlQEHNhzcShVkurn6ti1VP+sQ
	MGY9cL8ov5QQGrg0iFmKRNlFYX8ee3Kiqotsdq66enIRJ1+aK3Z1azXhZHsEUXoDwAAr5/q8ecp
	2JzLctaRTcbZVmNTacYMD6CToDHmoPdiYRCeqsET72qolh0ZPPaMBIylO2iPwsZ1QEWhmTsYi9x
	bDn75ogQV5nhB/OinwAOPLh7KTTD9v+8aNrkcRcliUgS6VVqz7ZCH8tBhFgF9CkXf+6cUq3mSf1
	vpAx6
X-Google-Smtp-Source: AGHT+IE59ot3xDXdFvUPT3vyz6t7NKDnhT9/sO35Yje6eX50bzMv/Gj5/vLqU9pxCTjRUAMIjdn8Vw==
X-Received: by 2002:a05:6402:27d2:b0:607:eb04:72f0 with SMTP id 4fb4d7f45d1cf-611e76189edmr14616180a12.4.1752578913078;
        Tue, 15 Jul 2025 04:28:33 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:624:7896:99ce:d9ca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976dc62sm7206596a12.59.2025.07.15.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:28:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 15 Jul 2025 13:28:27 +0200
Subject: [PATCH v5 2/5] ref-cache: remove unused function
 'find_ref_entry()'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-306-git-for-each-ref-pagination-v5-2-852d5a2f56e1@gmail.com>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGh2O1yqrzHxSAH05Xg4PTjGDmh06cJdrl+jK
 adaCdDg48qUi4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJodjtcAAoJED7VnySO
 Rox/WhEL/R/Yc5iQIwtMojQ83fpPrvRf7mk/PAACP7ueOGxZ4W7WCBiz3lBliAVBn1TtSb9rEvo
 5+QTm0k1fVQaSfBqMtNk70I3n0OVD3roj7zTSjUx7UNcf66v0MDZsUisZmBgy3gP4pTsQiBqIDu
 VoMX4HW7jxeWObo2KCaP+qTx0uKxz3DryMrhKU66lCKAb3tYkTKWMFKCArPcvsNasTr0P/PtP6N
 R8fQVJIi+YDYHpa2Dvyd6ijAG+PrxFJq2pd0aNUgpz3piB2Q58RsSy2U1KSf7YzMF+f8tYWOT67
 igviq+cYeCHEXKCtb+gbyFnP8qK5/9Vq3siMhDFN8RuL9lNMZC55hgbOSfl5l93zECPXp/9iHeD
 Xly310GjCzrK0koZy2Pib7u1kVxBpiSAQp9J3EWsHvF8huBC79orhOi5ELZJTmNmgvSI32tdSkp
 CwlVGp7JWbalSCYQWMfsD2F19zRBzs8UZuOmTrV9sbsNQAPaZcvqZicVXEONyMXvo+W50hd0585
 YI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'find_ref_entry' function is no longer used, so remove it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/ref-cache.c | 14 --------------
 refs/ref-cache.h |  7 -------
 2 files changed, 21 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index c1f1bab1d5..8aaffa8c6b 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -194,20 +194,6 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 	return dir;
 }
 
-struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
-{
-	int entry_index;
-	struct ref_entry *entry;
-	dir = find_containing_dir(dir, refname);
-	if (!dir)
-		return NULL;
-	entry_index = search_ref_dir(dir, refname, strlen(refname));
-	if (entry_index == -1)
-		return NULL;
-	entry = dir->entries[entry_index];
-	return (entry->flag & REF_DIR) ? NULL : entry;
-}
-
 /*
  * Emit a warning and return true iff ref1 and ref2 have the same name
  * and the same oid. Die if they have the same name but different
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 5f04e518c3..f635d2d824 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -201,13 +201,6 @@ void free_ref_cache(struct ref_cache *cache);
  */
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
 
-/*
- * Find the value entry with the given name in dir, sorting ref_dirs
- * and recursing into subdirectories as necessary.  If the name is not
- * found or it corresponds to a directory entry, return NULL.
- */
-struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname);
-
 /*
  * Start iterating over references in `cache`. If `prefix` is
  * specified, only include references whose names start with that

-- 
2.49.0

