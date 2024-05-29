Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1C1CB329
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023350; cv=none; b=mIm92Cov+0hQbTh4eeTzUHTKWe3L1+y/KmXoIUOJSQ3MGAnlniBrAFoZIxwKAsz3CfVpqVmVDoSRSa2oo3GaZfKcG5MmsNnyy6T7OxzenQoQlmxvCofhkQJw7kD8nr3OKVbxHU19i8c5xbwCLEyD+DsxFEIqmDmiiiWQVtyHUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023350; c=relaxed/simple;
	bh=BKHq+n632laculPR0CzkRvZOupS2+Ww6p3KuxVcr6Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHVbOPJ0XqQDtLtWyfWthM5tMlgNoM86AHdzfSHT5MxuoZkh6ajeYqqY+Y/g+HePNnQJwsr4e4KI7oVB6MwDhZMfK1FPvQphwHUSOA1NJnEJZkL4nCeALfKW6v1ENqfZbWik3CotcOKEkGDu8Gx3Nij6h4eMbPTLKypBv7psAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EQGJh3AL; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EQGJh3AL"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d1dbd01529so117673b6e.2
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023347; x=1717628147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWawbqlIMKiW+bBSk3AyAis5ic0hwBHJQ6eheqV/IQI=;
        b=EQGJh3AL4p9sv87o+Pf1+h8GYqRGrRsV3776rHhif7ueDSnfGoE8vQVD6jh5yAPAUT
         UAPD6KXdOXX6DEs4dnwcR8b4yX81r/zth+8wP2sTitDMtq70wM9QiUSLKgC5BJLeBNYX
         oCbSB+v4408AoqG//T6g5u73TdJCKcaJwak7nkvb3+o7HXEhv+oAJD5PWdFcQADt45Al
         oRvO5dk2JH05/wQhMMK9CfZfd2pgrXmnQiTYoZx/WicO/NcArBs+utFiUOPFLmllQnMU
         P8GU7bsib95Ve5pRp0X/1G4krzoiqwEQy7vc7XHaZPwQSSkDW90P9Fyjg7yrgdXN9sZs
         h/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023347; x=1717628147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWawbqlIMKiW+bBSk3AyAis5ic0hwBHJQ6eheqV/IQI=;
        b=idFQK9InsWth7RzCuT/HV3In5u3fEY43esSf7OeLT5wjB4XYdcKucCXUPtefvD/2fE
         KMvJ8EFUjTvbKI6Hlkrdj/cFjDUOR4rTf2kPxm86yjS4iuMKLstzmaKfQmpML+sSKXNW
         0gFNsLty8ZiOO6liQzpgbXHD8No0Q1s9gZk//9th9RDJQEKwu0rx+rEFPI0rjD8kmZ4W
         6be+cDfY/qczWXFE1OGiXkiC5ACmk9BV8nJcLZNHoXV+w+kv2S/59bP5KUWHd2OuBfJl
         VSn4/ZbCC9q1cNGDHGNp+m0ZP0ojHod3ugF1VTi9Lt7KuAfCd/kDwx2dIHHiGnpqYwix
         8O8Q==
X-Gm-Message-State: AOJu0Yw8EYA9cJkgSf/hsdVjbvveVS9AWAtoR1Febas4ndmFa8ZQwtqc
	myjNhdTQe6NyMztpsqqeMZhy+0yTid2JglwfSGdS3vNhpiR7xlpKd5phpMs3FQInD6iNGXe5SLh
	CxnI=
X-Google-Smtp-Source: AGHT+IERdcaL53bcJMZ/+u7l/av+YcZOEFbxiZ1Irp88su4Ty3uCdfTJZEtQ/49NBkvTJXj8ALPYWg==
X-Received: by 2002:a05:6808:1483:b0:3c8:3c10:adff with SMTP id 5614622812f47-3d1dcc91a0cmr515105b6e.9.1717023347506;
        Wed, 29 May 2024 15:55:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad92f558adsm20172346d6.21.2024.05.29.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:47 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/8] pack-bitmap.c: reimplement `midx_bitmap_filename()`
 with helper
Message-ID: <bcadaf92783f2e6182e6b6f34dd2c90965bf8752.1717023301.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717023301.git.me@ttaylorr.com>

Now that we have the `get_midx_filename_ext()` helper, we can
reimplement the `midx_bitmap_filename()` function in terms of it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 35c5ef9d3c..fe8e8a51d3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -309,9 +309,8 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
-
-	get_midx_filename(&buf, midx->object_dir);
-	strbuf_addf(&buf, "-%s.bitmap", hash_to_hex(get_midx_checksum(midx)));
+	get_midx_filename_ext(&buf, midx->object_dir, get_midx_checksum(midx),
+			      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
 }
-- 
2.45.1.321.gbcadaf92783
