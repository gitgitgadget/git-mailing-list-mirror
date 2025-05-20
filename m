Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BD26280C
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732997; cv=none; b=L3kBVIVlXPMGivw52PTC0kreONu7IFyI21QgdJ4o3fh+H5OFjtIgm3iS9KPaJUuTgD7N8IosGaiBdlyUoNByR+dbHICo0LK2TeqZ6AGL2O84maUpNLVSa4mGYeBoL5AmXyNkyFSKK8GxK+ZCGbRNdrKNn3efOl9WuP2sb5RgIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732997; c=relaxed/simple;
	bh=PlY+AKsSUCWgBNZyuYVk+M7FNolx6yM6+QSmcFijsIc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=keBrRYFsAooSGJyORcdu6QEnTgGSYDrWOqKuexurdsMXo8pl+7ZyDnCQ5gSSbbUjDFoU+38ES5XaMDdwIh885/ckDrGLO3Nup4YryXTuR+7qUWlCO3NpjMMt8oIlCWQ4Hzt9SGeiXg+sh2o+kl4+zokMdbXXV1JMI8Z/coa0wEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8mk424F; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8mk424F"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso54040975e9.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747732994; x=1748337794; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlzEpD5OwihySSST25m6ZqbzK9bWZK267oX/Ko4tAhU=;
        b=D8mk424FGYIvDg8+fy6VW25UgoXm/jYYbyilPY5TS4YuURJQJZn6XXtQIlfovpmfG1
         xTaccGZXPnjOEgUzosa4kcHJ8pVLGRndQgfWep7Oxt5Iav+ekHerooRZ1imoUAqKG2w9
         cEsdK2I0MDn34XRIp3v9Mn5uaDSpb2YEgka9XNgBxRWHU/qMQcPbi48/QCQo5ho8EIyx
         QNz39CSGB7AAGMNCVF97GPB3LmCc93lCqhtg7Cjlci1dyuxCxNi3NgU4jFkcqsqKK93c
         c0A60G+CgSnNUARIfn0cpCWi7j1M8oy7PX2NT5PcBhGJpbOiyoiw9uo9XpFvZ17RvVHB
         VZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732994; x=1748337794;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlzEpD5OwihySSST25m6ZqbzK9bWZK267oX/Ko4tAhU=;
        b=TKh/blWXyxezocMymKCCyFdy9h2XSuUu9ZLWw7m0bs8lyKLWXh1eN+WZOUh7B6FBSu
         pcWqy6GPzO+BrlW0fx0Kd3mmK2Z7ExmciDF0YWhw1wKl87tO8P5Car3nuujhdAQM342M
         7x2NtlG42DSwc3Y4M1kayuD9Xj77Bunoo+Bwe0meHDm5DGBY7y6eXlL26k3zsaRz6TYz
         EWadZjLJBEQ/A0ujeZieyWPxcmLOjmLT1WqbUN4zBdKFuxYZHTZJkLFp4M/Xj4YMdrag
         hpE0ablwBhpaSO1IpwAUVqy8EwUIao4+0qaDVnXijTSZix8NUioRx8r77pqhGWhRHUEl
         dtvw==
X-Gm-Message-State: AOJu0Yyn22bRjBJxqVPM769RM/3BmOPmUs0eMFwlx7ziWgol8tzbGPM0
	DeQUpRc9gbv09RMgdASM+n5NrBx6rI0SSl2hg1gJmjV0VvU2w9XTwAFmRP9n7A==
X-Gm-Gg: ASbGncv9F42QvC4FHpvk6rkoXRuDgzGHimGcpnGt7xj6CeXTZVMP9L3n2vtrbaJScGb
	uOzoUnJd5+LVhWpo0QbLI61b6fC0rhhnTjfLZswzl86TQTYcKSNMa+rv4CcwP6hYTGMEStlvbOk
	HLr967ucyk3Fz/hCF1qWlLwz7KVzMW+mFQiu0UAlHyqdoLhI3FotLorGfyQtFy8l1kgEcg+EztX
	R6ByWY4UDj80i4wlLRldGCt8wEWKtxTcG2sF8P50bydDaQ83f3vTKaBf2SXUCE7YkLcW+E0hFSo
	bZViZErZH86KagZbZB7AUMYRh+DDyv53+SmkCj6naDzxnznrpAW5
X-Google-Smtp-Source: AGHT+IHFXMUF6LYPxVE0uLxZ6Uz4R/LksUFmlhQmqVi/3hcZKNdpE9R38PJq5s8SxblOuJQH7FSFnw==
X-Received: by 2002:a05:600c:64cf:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-442fd5a1054mr177058445e9.0.1747732993603;
        Tue, 20 May 2025 02:23:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca889a7sm15811170f8f.72.2025.05.20.02.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:23:13 -0700 (PDT)
Message-Id: <130c3dc5dcddf9a0b124a7d6f6d50b9787f389fb.1747732991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
	<pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 May 2025 09:23:08 +0000
Subject: [PATCH v2 1/3] pack-bitmap: fix memory leak if
 `load_bitmap_entries_v1` failed
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:load_bitmap_entries_v1, the function `read_bitmap_1`
allocates a bitmap and reads index data into it. However, if any of
the validation checks following the allocation fail, the allocated bitmap
is not freed, resulting in a memory leak. To avoid this, the validation
checks should be performed before the bitmap is allocated.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 pack-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b9f1d866046b..ac6d62b980c5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -388,10 +388,6 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 			return error(_("corrupt ewah bitmap: commit index %u out of range"),
 				     (unsigned)commit_idx_pos);
 
-		bitmap = read_bitmap_1(index);
-		if (!bitmap)
-			return -1;
-
 		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
 			return error(_("corrupted bitmap pack index"));
 
@@ -402,6 +398,10 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 				return error(_("invalid XOR offset in bitmap pack index"));
 		}
 
+		bitmap = read_bitmap_1(index);
+		if (!bitmap)
+			return -1;
+
 		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
 			index, bitmap, &oid, xor_bitmap, flags);
 	}
-- 
gitgitgadget

