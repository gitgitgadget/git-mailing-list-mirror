Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6985626
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338488; cv=none; b=jROicFox8X165Mv6vCi6Ve3dj5PvbYHwUhUzQBQ8wfpDjjHU3yS6mA8fLBLAG+OnzvHiMHE3da72InHQOhiDedCPrKn9Mw1Z9dRbOstIaezo0QbU+rQjuLa1d0h3i7SEUihpBdFsej0Snw4Y2dA5EemyeAAvh3xAt1JJq4MCFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338488; c=relaxed/simple;
	bh=2QeekLC7SKnpbXQEyd/A0+oC8vTyZVndsP2KZz1NmVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SEje4sX/EQtIidql5AixlyST88TqWji0+StUQNnkIZcf4BFoGseDGRT0flWc9KZGou+NGdzXeIMec+wXAg4YcP3iuLf7SVIlymJV8JkJj4uAOzrwrS2Cf+eBq7oUshRdqCVvJQyEc2mtonb3P3Yc/urpPm98iS1EI5JzDOy7KXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uzOJx9qK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uzOJx9qK"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4769b16d4fbso33583861cf.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338486; x=1742943286; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tRcQrhXZiPwSKF9aEdI0BPDNw0MdIx1UpxoroG6iWY=;
        b=uzOJx9qK5K2FVHvnxqjPQp/4Ca6y2rSIWtxdsikIrp9bjUglSQ/z2O0uWadica64WY
         r5lfsS4gAG/jYILS7AbRxiGkF4pHfh9EMDnoE1QEJSO457om+KVmd4HKXdJMqutKDaW9
         bvRI7LVcrS1bjyUKfxLflyz2CvIyEmHFGVjzPw/ozNWL/+AiYTPA9humyuwETlNnlIO+
         HRmJ/8K0NhHSwy+OQ4Z8SwUqLncGj1IscwF1kkNxSi+/b3QnBP4NfTA+s9gMsMTjwWvu
         wYCcx1kynJqggQRYXBqDi5GI0obpdPo0dipdTPpAKSKCn8DyddxXpW3ZZ+2/tAOpVqVm
         rpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338486; x=1742943286;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tRcQrhXZiPwSKF9aEdI0BPDNw0MdIx1UpxoroG6iWY=;
        b=ivGN1LXacAsvw2nxeH8FFKctPgfWb6o3U6bpeTNz4ybpeSJe1x42JkJLuucCRZ7lA6
         R+CJ5OOLja5crTZeEOdrfH4OUfhndwzPpysEXslPba2+Y0tb4nJN0351rekqxTV4No+/
         vjHPS+Tmnhfz+ShzXJ1QJVhuLfz5aVWTnV3UKMFRiu2pdJwww8kSsob3xJgZjU+Rwwgi
         nS2KtdxtnENMoxdR9jFnp7ZezA/denPIJJ4tDXgia51jq/nC/w1VHP24XgcZmhN/ZgY6
         4C6ZqcSt199TUx2x1j3mvIgU/YPvJuMgJThM0vVfGzgu8WgY/G5rt09eXYwDx3IhOLhN
         lgzA==
X-Gm-Message-State: AOJu0YxZ1zeSkhXI/mHdGs11lpNdjCmkP95r5Bw3Qd2xXBYEJ0HSqgJZ
	+i4OctmB9eDnhP3f9/XTRXi/Cd92mIRWsJ8a9VnR5CfihyZxszPpYr3nebcRo5YyA4n27hUuaa4
	gEug=
X-Gm-Gg: ASbGncuj/DmyGaoIsm4abuIq7lTDI9T8WAR/VTNl2IwT8h+SM51XA2TDzz4ot3g4BZz
	+wWPKiFtO1gfiHgEtL3x0tX1SX+kiZOkMoSJ6ydSIXyx3qA7JcfgqI33/lu2Idfz6RMuzxEb8bT
	HfJASgeRuV1hY7s/r7PR8d7T5bQb/LVa7e4rOd5IgN4BNYOTfzhXURFd7/5Ezt9G961y1DWWOIV
	N1RDbNI4uQJdHyVBWmCo5rdTI6KQSkRvPXzP9ufboiLhdVaBMwjm0h+Upg0MYw1CQxsxdvdATxQ
	zjjxZ90zWPF/7qnmN2+6H7gUdlwCOePzdhTd5PhWHetvZZ0d0GQNnvfFvKifAEA3ouJOgT7+B8U
	Ex//86LKZ9ZCQ5Y2g
X-Google-Smtp-Source: AGHT+IFa/rWmnUyysSW8hdZzKu+whNb6oeIsOHJME7YLPpgYm9glQKIUDRbCyVUc1m9watSmiGUn6g==
X-Received: by 2002:a05:6214:2685:b0:6e8:fa72:be51 with SMTP id 6a1803df08f44-6eb2938a0b5mr10464716d6.19.1742338486032;
        Tue, 18 Mar 2025 15:54:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade331646sm72414216d6.85.2025.03.18.15.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:54:45 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:54:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pseudo-merge.h: fix a typo
Message-ID: <3b3cc5c0fa2d0696eb15c5d3c97a6c93a0d39252.1742338479.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The comment added in 7252d9a036 (pseudo-merge: implement support for
finding existing merges, 2024-05-23) misspells 'bitmap' as 'bitamp'.

Correct that so that we no longer have any stray "bitamps" lurking
throughout the tree:

    $ git grep -ci bitamp | wc -l
    0

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo-merge.h b/pseudo-merge.h
index c9fbe9d312..cf0e62ecd1 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -210,7 +210,7 @@ int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
 
 /*
  * Returns a pseudo-merge which contains the exact set of commits
- * listed in the "parents" bitamp, or NULL if none could be found.
+ * listed in the "parents" bitmap, or NULL if none could be found.
  */
 struct pseudo_merge *pseudo_merge_for_parents(const struct pseudo_merge_map *pm,
 					      struct bitmap *parents);

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0.1.g3b3cc5c0fa
