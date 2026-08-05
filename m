Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A2485CCD
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946509; cv=none; b=cqCPpQzmR9g3EMU9F38RBgkyOFwa8+aM19CbSkAXODEV6t6GlGRnMpwHqMW4amJs+TgmhxsaY4GtOFYvrXI1aeuXJIZT492LECaps2W865hSu7vlfHJzQ548soGIQIvtwna1XVMn1a+8LOZjxRqaASieJ4avceyAM7QwTgTx3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946509; c=relaxed/simple;
	bh=Us2cznKWTfG2jJFptMoS4fMFlf9ugXfM3DWKnR3iTtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kgqOz65xfkwWKJGYtLdNeeh+7CyVntr6wo+v8KecZILiCM/hLGJyOq9QRK0gWVN8XUEP+koV8WB1FfKj9eud6QBjfALD7Rst3QprxceFoVo00gZ6JltLTAQo4xndZ+C2AqZpUpE4slXpkGfNPTuHDh9vihJh10W/S+anl4ye6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/oSmEJw; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/oSmEJw"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6ae409c13d5so830525eaf.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946497; x=1786551297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=78y+UXU8Pjw551aJ7/d3G2Co+yhJcCuhcOkF2xIMHxM=;
        b=B/oSmEJwA98qaxlOjxxZwWTBIPBmgWaEiHdVKdw82jyONF8e2bwrjs2mixA66ByoaH
         QT5ZODn/bblniMMC2QFc9eC7MTUfxUV/2xNnx/Dc/c8OwtYnc7DEjpkQs7w/D2AxajIU
         hg9c66lQslTdiHi89FnzGYRNvACiwHIhcq5B0jUJqCs84MNmBWRmupyRPlnt7X+/YCQe
         yYxW1emib6QELwzB28aa54t5JvJ4UVz+I+eAHsdtwpMoMluSG3W0b/NiQNPZW6jyxcJ2
         VHdqmjKMgPbwzpsxoEENCiyGAHfkc8/GVqwlEA+dRt7BqMO7IZ0NmUkWJfP0ZHYXHWgn
         PFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946497; x=1786551297;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78y+UXU8Pjw551aJ7/d3G2Co+yhJcCuhcOkF2xIMHxM=;
        b=K/FzV3GCAkjMnC5OO8LTxI+sVPkyRJ9iv/+FnYZSvoWgcJLE1jwaFEu3Sxj/ygCB3h
         eb6OaXzQdZvkMXjg5XlkCu57r+uhWnZczw11vqTlm+URPMu8qdkCw4fN1aow/04CfU3h
         yEcv/Mbv5IaZz3XcT/VEiylBNiW6DBGsiu5g1hr4ZdcA0voMFv7WBV6x4/IXvDLeM84/
         FiG9B7qF/N924FS1IdbhvyMJmjqZiUrJ/6Q4QIOrXeP28u5N//rSCvBXzSUip0EInOsv
         gebzTCyr62o229l1893twkNqy6dtTn6xLXm2NgHq+OxVEw0L93YVtwmSdXv2N4w1tfLK
         ldeg==
X-Gm-Message-State: AOJu0Yx93mBk3C02xuHoHZXm3oEUvVslXIaZ4L3ZBV1Gww1++LAiGJRB
	rAkNuWh9XXKD7K/BrGx+1WUFtUzCkRPslbFDYLO541H2NQ/onwur5WbQSm/ax90U
X-Gm-Gg: AR+sD123nydJ6oOFFID/OUWSEgiUbWWZnnkRFZfYP41CDiWPXL44ROKE3WwpCcmBsL4
	a415umm9J9om3QzYPPiMq3z8qVMsh4fNCm3TbETw0lJ7pFeewZiWlXJObx/BpaQU6bLkoJZ3F9f
	kXXza/H0OEqOLLn+EHiRoqdBNalgvNB+XrfZDioKQCd5KmARdumz7PmFCGwxnBRFHrkx+aGv47l
	SJxokxq86ocv7dBzzCg2vGQ7YTa/VPLaN7MihM0eTU/AO1u3i+g6HVHS+LfuTYma27DRnZXzsqW
	3Mo+J/+Ag2dUfp+ezBE7KJ6e9ff/sXXKGUtrY37VoCdlM6CVGVOmLEFNUDTAevzIkqA0wdK1kiC
	tXRRm3AylnygI48XpoKvXNZlPFZM3a2k86tJNBjjaepgpEZvCxbIeu8LqwHuE3UM0nlCJ5Sjusv
	6+hhtI7GUm+JSh1nuGswj7rk+YLXIxqx79O7iOXPS9TbmMs/TQpsifM8fb/eNgkBlCtg==
X-Received: by 2002:a05:6820:4c10:b0:6a1:5d32:a2f9 with SMTP id 006d021491bc7-6ae96f1ac59mr4501882eaf.27.1785946497213;
        Wed, 05 Aug 2026 09:14:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d524d3sm3159554eaf.6.2026.08.05.09.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:56 -0700 (PDT)
Message-Id: <e6175d2d87e600959a3992aa88075d0dafce5a43.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:38 +0000
Subject: [PATCH v2 11/12] t/helper/test-pack-deltas: widen `do_compress()`'s
 maxsize local to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Prep for the upcoming `git_deflate_bound()` widening to `size_t`. The
local is only ever the return value of `git_deflate_bound()` and the
`xmalloc()`/`stream.avail_out` sizes derived from it; widening it has no
semantic effect today.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-pack-deltas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 5e0f726842..959705feca 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -22,7 +22,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 {
 	git_zstream stream;
 	void *in, *out;
-	unsigned long maxsize;
+	size_t maxsize;
 
 	git_deflate_init(&stream, 1);
 	maxsize = git_deflate_bound(&stream, size);
-- 
gitgitgadget

