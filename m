Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825114B065
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075204; cv=none; b=h7bFYzS/7BrFwS7oXn98owWxIeUJkZ6M23B1xrrSESmBArPeGd3dftCW9/gs6ynXtzhB0mYUa/d470McNqjso/lQ/PszTohcf6ZD9hYMkvwwSZfcASDzDAKVm3w7rNf62kwotJYOvb3BvcKhgsmTXRxaC3cWt+3CXfy2IVajJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075204; c=relaxed/simple;
	bh=02ngZJ+jOKJQJnOyXerxczmrFfrMhBBG7B8eXlI64No=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qwOoQO8FGhyV7CE4TCKz9Un8jRrxRSgX/NbhSR2GVZI8hQ0TkXFvdW+pQ9SskX2HEUN14Fp7IKFIKpG6sjYtsq4pYXy2aXIYADVsce6Kx6xhFBMHeHAZlo4IR+4GAh/HF+qbbkOudNprcJywVZAn9nXKdPEZD6wHus4PTOxfb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xLqLv5f4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xLqLv5f4"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a5580333bso380276885a.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712075201; x=1712680001; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0FJwZtvvJ4dsBw/HWIVWrfmMGrstd2+LncpnJqteuc=;
        b=xLqLv5f45K27cn3192dxFu/7hiAZ5zURwieD3uA7l72LnpEW+z4aatv0rzTNrxCAY7
         oYZBs4waV9HGhGirJh+GF6R7AOQuTDztXOB7PUr1C0dBMYbrk5fc/0bdyYMM0Z600tyX
         8rLi4Ss22xu7jBb3GylRZGv8PYJ9/wEC/ulTiAgUWftbzLw+FnBEnAFU5F+jC6xXxabj
         zXcnPo3y/zGg5ZNTebBEs4bG4zn+1WpZGUxa/hY7OWYTEu/kikgNRoF5YBys9495jURj
         NQO6/DwiaD+RJAUKTUYIdzFDaCQ1JT56v9azPumsk2GyctDi96BKTptI3Lwet43+eSM1
         eYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075201; x=1712680001;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0FJwZtvvJ4dsBw/HWIVWrfmMGrstd2+LncpnJqteuc=;
        b=ReE9JVFxT1F8emJEkJWuZ8qVDPymnZaSu74VcEIwNN1e4aSOYmy6jgFejf5i8kOIXV
         ePKv7tS5CWVVvuk3Q1PIv2qvHjmEBUh/Y1oHkw0FBoN4Sv1T92st1yh/vpHPEHUsFEBZ
         CRzK4hv//ZNENeReBG7WU+RLCGclpIDEOapT9x9GP/f0mGM8Noe2OmAVrdfpa5MA48bE
         bYmCOun4kCSgw1C1MVHbaVw686QWdMr1bywQ+QxelMQsCxIE3/As+CV63rYV4F/Gr+sw
         Bn+V9mYETTUexFkghAJXmdqQ5R4soBaaahDre+pmteXI+JV0ANQJiUyfgFOakBC8zepP
         ONmw==
X-Gm-Message-State: AOJu0YwU9dvy0vNuDCpKQLTwy01IVp7zS/x0woY1lWUbw9A5piRmUEXj
	wwdDnekvJcutLWaN+jhfK+W+bO+MfFN84eDVRtmjQr/cPFyBnsOsvVBzLU0yU26P8g2nhaLSvSI
	ai0M=
X-Google-Smtp-Source: AGHT+IHM4nDC8pAoP60mUENxj5VYO1X9D2hnY1bDM3pG2AeJDRWRKcZ7iSY1C0UUKT5Cf66hdze2/w==
X-Received: by 2002:a05:620a:45a9:b0:78b:ba82:d131 with SMTP id bp41-20020a05620a45a900b0078bba82d131mr16665441qkb.36.1712075200837;
        Tue, 02 Apr 2024 09:26:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a022900b0078be2f2ab7asm1823995qkm.70.2024.04.02.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:26:40 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:26:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/t7700-repack.sh: fix test breakages with
 `GIT_TEST_MULTI_PACK_INDEX=1`
Message-ID: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

There are a handful of related test breakages which are found when
running t/t7700-repack.sh with GIT_TEST_MULTI_PACK_INDEX set to "1" in
your environment.

Both test failures are the result of something like:

    git repack --write-midx --write-bitmap-index [...] &&

    test_path_is_file $midx &&
    test_path_is_file $midx-$(midx_checksum $objdir).bitmap

, where we repack instructing Git to write a new MIDX and corresponding
MIDX bitamp.

The error occurs when GIT_TEST_MULTI_PACK_INDEX=1 is found in the
enviornment. This causes Git to write out a second MIDX (after
processing the builtin's `--write-midx` argument) which is identical to
the first, but does not request a bitmap (since we did not set the
GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP variable in the environment).

Since c528e179662 (pack-bitmap: write multi-pack bitmaps, 2021-08-31),
the MIDX machinery will drop an existing MIDX bitmap when rewriting an
identical MIDX which does not itself request a corresponding bitmap,
which is similar to the way repack itself behaves in the pack-bitmap
case.

Correct these issues (which date back to [1] and [2], respectively) by
explicitly setting GIT_TEST_MULTI_PACK_INDEX to zero before running each
command.

In the future, we should consider removing GIT_TEST_MULTI_PACK_INDEX,
and in general clean up unused GIT_TEST_-variables. But that is a larger
effort, and this ensures that we can cleanly run:

    $ GIT_TEST_MULTI_PACK_INDEX=1 make test

in the meantime.

[1]: 324efc90d1b (builtin/repack.c: pass `--refs-snapshot` when writing
  bitmaps, 2021-10-01)

[2]: 197443e80ab (repack: don't remove .keep packs with
  `--pack-kept-objects`, 2022-10-17).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7700-repack.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 94f9f4a1da..127efe99f8 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -629,6 +629,7 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 		git log --format="create refs/tags/%s/%s %H" HEAD >refs &&
 		git update-ref --stdin <refs &&
 
+		GIT_TEST_MULTI_PACK_INDEX=0 \
 		git repack --write-midx --write-bitmap-index &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
@@ -749,6 +750,7 @@ test_expect_success '--write-midx with --pack-kept-objects' '
 		keep="$objdir/pack/pack-$one.keep" &&
 		touch "$keep" &&
 
+		GIT_TEST_MULTI_PACK_INDEX=0 \
 		git repack --write-midx --write-bitmap-index --geometric=2 -d \
 			--pack-kept-objects &&
 
-- 
2.44.0.414.g7e8d435d58e
