Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670615574A
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760945; cv=none; b=t+cOd03Z0F+UXm4g9kBYmScvjxQCZm4Eo28n+yaeeHce7BUG+DhahhtMHZxCrcPqiK9YZ/H8NdAInvBMDq0aj5VATfJVPOIZkgbxwnaxEfR5DYwKodHWqD9b9yyFxYLmZUniM8fgUZESTs86b8XEp7q1EKeTSwbbIApSbpYuhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760945; c=relaxed/simple;
	bh=xzI/Uud9Z0WlQdTf+8ebH6i9bjeXNBU0aFD7QhFZigQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuBvg5eE/AQT2nzr7z6Ez+LiETbRpsfPEdjKu3i+CW1Y0buvWE5IKSYV+z03XnJ3UsGYy0vpxyiUzn9sF9LdrmDSUdtWUkMiy7zUp3jVXrIC7ZIS6ii8kUxuqzxKqJW7CEofHYxGwQnLMnUoFQgypznUEYO8HcWQ9fgdXd77OpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AF8RVELH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AF8RVELH"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-691bb56eb65so14886257b3.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760943; x=1724365743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUlApPl07OkhfjwTTTVSsr4uQ1Aev+3QtfB5OTDai5E=;
        b=AF8RVELHqV5gSJxjXIWriuxLPpQsq80ET8TSM1s0kQA8CJcifAU9robUMoJZp4ruPX
         9MVzuCj3rhIqNZGTwH/ImQtpGQqgKW3BnZJqwLJdAo70vpmB17I+rf32IXtRAX44RfcE
         lIo+qhT858xDI67DE2X5YcQuJwtIMZ8uXSBxQW0iiSo2nbEF5ZHjJphyNaRApj7mYSwq
         XpN5T10JLvpQnoAudiwk55qgminstIBDivS4vu/7CzIITZBp5XX5SB47RkmE2kFvCqQn
         5X1gM8T6trwN/Upr1nBdykbXO+YujalDz9yX1URWo9vYp5QQhnDYhVEsAkQ4RzlSCZ8b
         4P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760943; x=1724365743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUlApPl07OkhfjwTTTVSsr4uQ1Aev+3QtfB5OTDai5E=;
        b=ZEDW69WjrGggQ7g136yJW39avj5TpyCP+cB3MdAy7X7hbLl/nfqPtZ+RXBI7THQxPd
         u3p6mNPIgeFl6CcJ5N1g/zS1KEin8FNwGZvDergQ5l1dMLxuwurxNok+3fW+xPBpcs3t
         t4yDq1RDEoakUoaIr0tIJA1WALgSA9nhG/ISuhvQCwVfXHj8w1XKiKHsxZHPl6ztBMU3
         O7B8pSry8oHjZ+QgQkNtqdEwGdxQ6cy1ROn2aP6EFu0YTvoxjOzb7K+GwtQGpC9IQ3FW
         IP6uhj39knSg1C1D/ThuKfrNF1L6LZ5hXnXG9Z1Rky8VTZD44Zc7qYiinIgCd17fR6f7
         Ic9Q==
X-Gm-Message-State: AOJu0YxM05igV0rDWGjFNo5SJIQO4Ib+FBHL1bm3+Tka3V5ICeFIgr43
	zeXLToGP6DnVemeNtNpjrqMFuVuuJfBmeRjpiM5h5r345eU5FEbpiwoEa/Jko+7GlKeYyjGuVxA
	G
X-Google-Smtp-Source: AGHT+IGttVIcHU1Bp3jOUoib0kfj7fMMjnz2JCURlB+d7qIUMyiYQS9OKGodOrbglM1BSBl8RjZIiQ==
X-Received: by 2002:a05:690c:6a08:b0:6ae:59e5:5f37 with SMTP id 00721157ae682-6b1b823f19amr14180597b3.13.1723760943005;
        Thu, 15 Aug 2024 15:29:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a4b7sm4114517b3.85.2024.08.15.15.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/13] pack-bitmap.c: teach `bitmap_for_commit()` about
 incremental MIDXs
Message-ID: <44871306487e5c4c93f619b3c81b651cab3099d6.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

The pack-bitmap machinery uses `bitmap_for_commit()` to locate the
EWAH-compressed bitmap corresponding to some given commit object.

Teach this function about incremental MIDX bitmaps by teaching it to
recur on earlier bitmap layers when it fails to find a given commit in
the current layer.

The changes to do so are as follows:

  - Avoid initializing hash_pos at its declaration, since
    bitmap_for_commit() is now a recursive function and may receive a
    NULL bitmap_index pointer as its first argument.

  - In cases where we would previously return NULL (to indicate that a
    lookup failed and the given bitmap_index does not contain an entry
    corresponding to the given commit), recursively call the function on
    the previous bitmap layer.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c27383c027..88623d9e06 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -946,18 +946,21 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit)
 {
-	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
-					   commit->object.oid);
+	khiter_t hash_pos;
+	if (!bitmap_git)
+		return NULL;
+
+	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, commit->object.oid);
 	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
 		struct stored_bitmap *bitmap = NULL;
 		if (!bitmap_git->table_lookup)
-			return NULL;
+			return bitmap_for_commit(bitmap_git->base, commit);
 
 		/* this is a fairly hot codepath - no trace2_region please */
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
 		if (!bitmap)
-			return NULL;
+			return bitmap_for_commit(bitmap_git->base, commit);
 		return lookup_stored_bitmap(bitmap);
 	}
 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
-- 
2.46.0.86.ge766d390f0.dirty

