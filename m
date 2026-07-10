Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1B421EF4
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683600; cv=none; b=pkuH02cZuemD637U+zjMskyimfcpMGMWzcZDyJhH3XNo+tUwemzONdmngdZY5JEz1Ki5Lha5ytziy5uAp0q+sKpgB3uDSWVS4nKbL24sOzIp+wk/Yult54QHxxJSy7ZxQkuJVa5b22TzMN/ucftHWtSzNsPey41dDGY9qk/cnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683600; c=relaxed/simple;
	bh=WAxShR0w8gKQfjJ91ZwViTAI2DoYiX/ro1ouNW0ecmE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AO1jz0urUiqPnZzhsdrQtg0Z+CnFE6b4Rzl3YrZ8xrC6uzO+jjGlTZqXVagQhBd7An8FZLtCPJ0vOKNn2ptj6H3ldFVZJn/QsnhyMxRsNCBQyY6rWKE4MSxVH/+2X0EhhjKZB0e2hNdWxgrjuUOR3HYyR8vdTubyRkbFY1XDLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/v0MSQk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/v0MSQk"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so13285185ad.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683594; x=1784288394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ogkcqj0nUCKjt4z7HnkC+YFq1ZmeUss5+VCkLH7JXvM=;
        b=U/v0MSQk2EJ5xH2LToeX5m9MTROaWw6H14crcpsKZf6eh2AnNZ8Bd0JjP8qbBXDNBl
         O9gniwtl7Rr30K/1EavefHDyUH2kk9AOsEKI7cAbyyHKvzzUXAN8XBZpakaqf9t9pQWJ
         sqP08A2Fze++hv8aFIvFaWz8d0LnbsJ0g53In2eN67YTXDaTT4lTYOcf1+kRcZLX8ziH
         25EuGgzg152L8oqFVKPaXIiTyMrDFGGPXdBFhmUBTABmzyybGvOGi2tMbuBzFC+RNTyz
         pjopckzRPTtiupmPRiAm7J5K88UYQrTbsUB2DdVbD9SFG8kd1v3qrDL5H36K/HbqRHOJ
         4qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683594; x=1784288394;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ogkcqj0nUCKjt4z7HnkC+YFq1ZmeUss5+VCkLH7JXvM=;
        b=pthq27nquc5nsIQayffildjateV1mYzNneIjQJc/20QRAWsetBpJ9OrE3ry+eNuPzL
         QRap0Xwr7mn1mWNjiwfNo6UMJkGzQYOLc5l4jlzv3uzhDgQsfLy2K2QuxPcBv3Phh7jR
         Bn4ER9XOT3fhZsnAkyLW/4UJKqkY0wR6cK/tUDI4ilY8YEYxwqSKOjTYY8ZTB+aMIBrk
         9IL+R2S2hSFGa0W+znmWMKwQsD4jmfrHEGdQRYkpC5W36yVYzSdjisF87CNT9//zr+ew
         WsAsp2xxsL6RzjzXkxa22kEpD5UFjXqIiQZ/ri2B5zGr4lHIvTB8aXPF8IdjZK64Ki56
         OXxA==
X-Gm-Message-State: AOJu0YwbPBK3ikDLE2m4ERTFgE5o4pk5elqcPZdwwJ6lXOMS4QPAP3c0
	u4BUQQHNrfzUwNwA7DiZ+yPt0CBmTmxbE99bEZaBcIvOQ0iU/n6isvIMIwevHoAw
X-Gm-Gg: AfdE7cmh0jf/vBzOs0mu+RnfiU9Obzr0rSLJ0thmlN7/6baRyjvoWHs5MZCXO7zqrcK
	ePwDFqyoqyjMFT/xedpj2CduQb9Tp55z5zB8Dl8cB/uKa5oJacZxwpr7YGjItpl5/wsy92SXxRe
	ng13W1yjtraELvF4f20DzCRsx9NPyIAt08M+rxaqPPir9uo6sCKGOWo94V7ePIr3OwmNSbBIYUX
	4hh5tDWVc7f9d4b/mO5ThnJpwrKdZCHfG+0H2NxCSvbG4shRvf/25PCan1WPgHPjd+BB7Mf+BN7
	uubnnzfxKLnyYJRH2WGWxqGZgCsywib/hy54+b3fd9BHIX8EjFBl1xfwWWQhBV3e+sb9dqt/zmf
	r0kTxf0omIsAbbePViHD/DZCHAGLqk+UXLT1TVn9+N9k2jkmFm9q7dOHas/2towWsv032HHoHRf
	PD8WbAY9R+mgKAWkQgeeMP9niAi5k=
X-Received: by 2002:a17:902:dad0:b0:2cc:5fae:cc5a with SMTP id d9443c01a7336-2ccea59d55bmr112242485ad.46.1783683593600;
        Fri, 10 Jul 2026 04:39:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb9bbsm59680485ad.4.2026.07.10.04.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:52 -0700 (PDT)
Message-Id: <cccd36137f49e7523f8ee15405574943536cb505.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:33 +0000
Subject: [PATCH v2 09/12] pack-bitmap: handle missing bitmap for base MIDX
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `prepare_midx_bitmap_git()` is called to load the bitmap for a
chained MIDX's base layer, if the base MIDX does not have an associated
bitmap file (e.g., it was not generated, or was deleted by gc), the
return value is NULL. It is then stored in `bitmap_git->base` and
immediately dereferenced on the next line.

This can happen in practice with incremental MIDX chains: the base MIDX
may have been written without `--write-bitmap-index`, or the bitmap may
have been pruned while the incremental layer's bitmap still references
it.

Check the return value and go to the cleanup label (which unmaps the
current bitmap and returns -1) so the caller falls back to non-bitmap
object enumeration, matching the handling of other bitmap loading
failures in the same function.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pack-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e8a82945cc..ca7998c10b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -523,6 +523,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (midx->base_midx) {
 		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
+		if (!bitmap_git->base) {
+			warning(_("could not open bitmap for base MIDX"));
+			goto cleanup;
+		}
 		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
 	} else {
 		bitmap_git->base_nr = 0;
-- 
gitgitgadget

