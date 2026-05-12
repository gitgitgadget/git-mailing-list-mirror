Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65C221FCD
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546821; cv=none; b=lGk1F4eOkDZ/G4k8oGzw9WV/nHhpDVU5Iw1vF7kawjjOYO3M56naVi6g+y0afezj9t9kAJZbgWNz9eTht6WEaLjta0byIOraLmEesbPmkWR2/9YOfhA04QRZoPFqOanGFKFwM7PcOwYHEO0utiyFf6xqESd9SAg7GEZAx31JACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546821; c=relaxed/simple;
	bh=cQzp8Ynioip+NhfrrRN/NwLJ8+9mzVs9tSIOKLtiWD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1iK2dFCdxvAHcLN5M47NYtMdzxRVIapYqhY/4f0uPBIstAvO1tEm9R+H4SeC+NMvVRIsVUVH1W3e+CXN51wni3/54SIOdD/NtAU8Y4Zq78d/1pykvRRum3bL3m/BiBGe9E23Gsefz59ywxzUJh3yrbh9P9TbZ0FOZRhehAzbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OGlbVpZC; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OGlbVpZC"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bd810cdc5dso53242327b3.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546819; x=1779151619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfm+bRz0krBQv9xUSRiiK9fIkq27eKD8wUSAuUygpE4=;
        b=OGlbVpZCPFOvJqOP8p8Z1AfLNK2v0lAbS6TzhfZdYIUjDU0ITX/NA3DrfnjtN0vGrm
         C811yM93GwKGcDNqChyXiiz7yzjN6NDq//ICU5ya0TXmE7j3zmE6MCYgKIMhHVnrDQz2
         LT8bmiDCGsfCw5iBLEhIUvooPlJ6R9RRil+Py0BwHu3sQmlfqix7xa9OnG5Z9/DkgBJ4
         r6EVRiGc5Xw0M3MaHmZvHBFlSPSS/PJWTuVuKooq55X8bLO/Wd6FD2dDXK5PMf/JpITQ
         oZLprXEMPo5lppf4jJAxP/qNp+GhFV4wVavkAPQ03ncAYY60Bae6qs6HH5v0kwg6baPR
         TGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546819; x=1779151619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfm+bRz0krBQv9xUSRiiK9fIkq27eKD8wUSAuUygpE4=;
        b=MawZyhqpwqds6R+KoNt4Qjpy1ghLKmOSJ4bOM5sJG+Ap34bEb9tw60erAb2wmHigMC
         v2+Afg30ib+QDA5QHendoYzoNb12/W8aRy1JoNpJlPrndc13zy6FTmNkPhnudTmeKeg0
         DraHxWGgRziR8t8QVQs+33dOxMD0F2RyrxcsQC/3YbwMUon5p19L/t1sWaNdzxF8tzHw
         ywMESI5OYsl/HQRqiIE/0QB9r+WoSAGKOG/Fp9Y2O/yTAy9rsI0l0yewPtv1zIWtTi7d
         WwiYUPFCVK2lvIX6AwKieKXifhKYsS23s/QHbc5ArCWzzVCx1O0djisFQ9ACKv6bUV0F
         mXeQ==
X-Gm-Message-State: AOJu0Yx6jBMJ9KiCcc/BswxoQcQg9XwNgZk07BgcjobeoWBeOKq63DzD
	popNwsqG3zTugosMHmAZvZzBwT8+r84MnacVelSduIU/fhw+6lNHisWf3BE7A8h9kEszG72akO7
	JaFdj9uvfvQ==
X-Gm-Gg: Acq92OG7ZPKZSbr0DNi36WCaILdFRvZZvuYdHID51dOT2ia02tKRgvFqwK11t+e8HbC
	0ZRVBsj0bOsWZlAIMcCqH4l4EmMGZ/jkzSsgil2eS1viUn2y6segloRIz4zA7Es+E9Dwoi1DrgN
	bfChIVT/3KxaELzC1LQVFOs6xw/HW+MV6O2NGYmW8LDm4F1KXSzjcQNsP2wi2r8gC8jPZM6PwPA
	9vHE7uhYWWR8hd0OOcIfI2AchA2D/mLL9Nov/DnrbSQiBtH/lspq6sHdM4iKwlLpZWL6As4cOFn
	9K3imZhg5HW4KA3JE0SHjm5jVh2amN+mpCtXUI4AwgT+4RqEmKYcFEH6r13rZN4OPGJs3u4MvTn
	K5/gmiboaRCB4bHk25eOssec65amOH0kc3pE8mTYaSil6aJJBlBL4YJJ2WJZLYB4GKwVcLKn6Kq
	T7jEKRMLCMuqeXCH7NOBPjGHCs6n6hCLdZsTJWgyceUM9iWtXuF2YWqoahjf+pJRIlrIlGuTpfN
	KHaapiz5zVEaCrqMoVGaPPlgL7q5PWdZn+EJn4tKppI6HPHYAYU7tTFwUDY+DlYOsmO3xpfpAPd
	AFo9czlAqY7b3VNlDylsyfph+Vs=
X-Received: by 2002:a05:690c:91:b0:7b3:f33:35e2 with SMTP id 00721157ae682-7c560a33cb7mr6658317b3.10.1778546818864;
        Mon, 11 May 2026 17:46:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d37fsm157825807b3.36.2026.05.11.17.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:46:58 -0700 (PDT)
Date: Mon, 11 May 2026 20:46:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 4/9] pack-bitmap: fix inverted binary search in
 `pseudo_merge_at()`
Message-ID: <a1d341c92eb6aa7defe87b6daf556c1643083ec3.1778546804.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1778546804.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1778546804.git.me@ttaylorr.com>

The binary search in `pseudo_merge_at()` has its "lo" and "hi" updates
swapped: when the midpoint's offset is less than the target, it sets `hi
= mi` (searching left) instead of `lo = mi + 1` (searching right), and
vice versa.

This means that lookups for pseudo-merges whose offset is not near the
midpoint of the pseudo-merge table are likely to fail.

In practice, with a single pseudo-merge group this is masked because the
lone entry is always at the midpoint. With multiple groups, the inverted
comparisons cause lookups to search in the wrong direction, potentially
missing entries.

Swap the "lo" and "hi" assignments to search in the correct direction,
making it possible to apply pseudo-merges during fill-in when more than
one pseudo-merge exists in a group.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  | 4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index ff18b6c3642..fb71c761792 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -559,9 +559,9 @@ static struct pseudo_merge *pseudo_merge_at(const struct pseudo_merge_map *pm,
 		if (got == want)
 			return use_pseudo_merge(pm, &pm->v[mi]);
 		else if (got < want)
-			hi = mi;
-		else
 			lo = mi + 1;
+		else
+			hi = mi;
 	}
 
 	warning(_("could not find pseudo-merge for commit %s at offset %"PRIuMAX),
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 3d7a7668121..5411fbf1e04 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -496,7 +496,7 @@ test_expect_success 'apply pseudo-merges during fill-in traversal' '
 	)
 '
 
-test_expect_failure 'apply pseudo-merges from multiple groups during fill-in' '
+test_expect_success 'apply pseudo-merges from multiple groups during fill-in' '
 	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
 	git init pseudo-merge-fill-in-multi &&
 	(
-- 
2.54.0.76.g9b17dab2cf7

