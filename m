Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F50155732
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760960; cv=none; b=WIskv6iaUGRKf5wN0gHZ5mSmzWRGnLs8zwNewoLQA2olhQ+y6CwnAYlNQw9C8/PWLu38HnC6YcxFDNsNGVOy/rCkp88JPpyrhYIghtlo8FdUb9XRQ12Szzq6yvx2xyCsraB9uOlvfKA9VUVljPQgfOQH2z+dtX+30B4mQc5XK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760960; c=relaxed/simple;
	bh=xbAiuQVR2y0u+YecTIG0A9Ny9UIZNKKG2WfRFXFmB4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qITV34YAGD9Ej8OpwoyPuQi8nCL4xBVj/Djmpfrr5+/esS0urpFNXFscd79MgfxbZUexJwq4iCxVTuZPJX7LRFfcRRG44OJAqiWgStNIgrS7znIZUYW/fpUCbFttD5xx0mYcC64KMogpHDqCW6Fx00aHKDliLoRJuyQET1ShdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=T+s/HJl3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="T+s/HJl3"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690af536546so14416387b3.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760957; x=1724365757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDRQ3hj8CqCqfbToN7r6VpfC6iQIyqXSQfZOlsjQc/M=;
        b=T+s/HJl3ArfnJU09GtfJLmzs/iiQdcvePZ1h4fKlvMtsqT2GN0VxqLWRaLLxxFuc5M
         DCzbjXYzW9NLYPBZvFdPbeMY/Dp3NhrVfz0nh0VARZXcL/hc/IPtiZ6Olb6HSCYK4lD0
         hZiUOqtT1Ts+0M8ofgEnxai2vLEksnfCRfmu7kfBG2j0JMrj11O6q2Tjg7H/B8/pOvs1
         /r78lvrTVufmYnzHPiuknTd0fzDwy1d7zi+5SnauTKHXR3UZsimeQ28HSw9IcvMpQcix
         KJwEW/wvD3v4dTT5wj4sJJFpHUjBJK3WfiTAuRHHFbAS6foPopwNIRoGuehfr7jBOWfT
         6EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760957; x=1724365757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDRQ3hj8CqCqfbToN7r6VpfC6iQIyqXSQfZOlsjQc/M=;
        b=DMHHoU/W6i0Q7gnHfDZnzuhEH+sja9Hw2SWyhDUrIvKY26PenRT2mx9Hh1ag4iDbhT
         wMDgilx4KEYumgN13kc+zhKF+3kTU6zW52sWa/pz5Bipn/MZ1BHB/oAUNdul6PoPMUQ5
         +vV4TP3P3yZV8FONc9LQEPy+wYsySq2okZ/D66vM9wN440UDoEkSlyVw01xot8f5ZOhv
         LBW7ZecwwsS2YlggWOdDp2hcOyD7Rq2slopBfb2JCECSxnWl67iMpBO9yMwpFFj/uozH
         2n1czFWw8E5i5u7U3DXmHFnC4JkUW/ja2c3+KOwT2iWVSYdimGSCoQmKGcLhDqF6EmvJ
         3C7w==
X-Gm-Message-State: AOJu0YxT8d1xMzrlPPPT3bTpUVKF8wtCyUefBr/EpO3BqC3MpQByPLMr
	BzcoDtMz+HydqCewVvIX22RGjINru8L+s9gEALIs3Pkm3TVZQrtCOnH1GVJerYUsW4M4D2oz0gd
	K
X-Google-Smtp-Source: AGHT+IG0aLy9pgm50kQWPMf/8/G5S6ZtszAjsTBqrzUmhCzx6+myfTXvXR4tyUGhio8qSggihSAm8g==
X-Received: by 2002:a05:690c:f94:b0:63b:f919:2e89 with SMTP id 00721157ae682-6b1b7a6ac54mr12630457b3.2.1723760957576;
        Thu, 15 Aug 2024 15:29:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9e0e0e1fsm4192877b3.133.2024.08.15.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:17 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/13] pack-bitmap.c: apply pseudo-merge commits with
 incremental MIDXs
Message-ID: <f9ae10fce907a751ac14add65942f51f24f9f7bb.1723760847.git.me@ttaylorr.com>
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

Prepare for using pseudo-merges with incremental MIDX bitmaps by
attempting to apply pseudo-merges from each layer when encountering a
given commit during a walk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d3bb78237e..1fa101bb33 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1087,10 +1087,15 @@ static unsigned apply_pseudo_merges_for_commit_1(struct bitmap_index *bitmap_git
 						 struct commit *commit,
 						 uint32_t commit_pos)
 {
-	int ret;
+	struct bitmap_index *curr = bitmap_git;
+	int ret = 0;
 
-	ret = apply_pseudo_merges_for_commit(&bitmap_git->pseudo_merges,
-					     result, commit, commit_pos);
+	while (curr) {
+		ret += apply_pseudo_merges_for_commit(&curr->pseudo_merges,
+						      result, commit,
+						      commit_pos);
+		curr = curr->base;
+	}
 
 	if (ret)
 		pseudo_merges_satisfied_nr += ret;
-- 
2.46.0.86.ge766d390f0.dirty

