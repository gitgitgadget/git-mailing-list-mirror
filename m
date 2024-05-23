Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044F18C31
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482310; cv=none; b=jccJamSaB3EZiXvrOBCQxWr00Bi4TAg2eNjADhJe/AoKkv0P8rQUSjVuWkH28dUjAiTJnzcPDCXVEh88bcWPJRVIcWmwJX8KQNxU0iTKr9rjIBiCsHniF73jDFH7V+kCoXy6PC8I048F1t0M/Y8tnHC1EKwHq8NlLO749blBsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482310; c=relaxed/simple;
	bh=fRjknsG7JbWps1QQZ8hk1CSPuww6hk0RptZN2NrZqKs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcWpMlMBVp+dh8wLV1CAjaXeE+GGYhVhocXsae3VdSnxvF3rZc0DRGPH214LGWIDiT8kpaEaoLTyZoF/wIFIpPcryRW01YyEE4dHJMqB4bzEFQJhlpC2nILP9gR6rWW52WJCoeO1R/yMGWybHyKXKvcVV6n6iiDX3zNDI6DpPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=a7ffCnrU; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="a7ffCnrU"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6a04bae513cso18198536d6.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482307; x=1717087107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9H17QM3gRZ3brFw2+qTqduwXQbs1ZUdChn/r+Loe8c=;
        b=a7ffCnrUccPfbOyeLqW1CKNZKB2XM523kouGMb6MLBeLP8Jw2RFXyOMhfpho9WKoeW
         MWIgv0janAWEoFH7MMmw25LyvoP9bIZ6IJwZ/58rr1H+7bye8HQJZ5KUViT6Si9EHJRW
         NRS5TcG5uS/3uZSDhRmBJZ25dBYNIa0fe/99A60BI3kpDZdYxS0m1bus0sOtzFhVvZWl
         8cXx16G0rrxhh3Zgi6CKFfjDNqOeHExJfjhbvlrfC18NHzF0B2TDFdovYhZTlCKEJ25Q
         etfoVYK1qz4wuCQCutGB6uDaDI+EHZ1wFcTcoEQ5RDEsxG6atI/vBsd3uFCqiP+vhqY1
         Rbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482307; x=1717087107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9H17QM3gRZ3brFw2+qTqduwXQbs1ZUdChn/r+Loe8c=;
        b=M4h6OGOUXlhxkYqUllaDe4nvpXYNvY5g3M4C1C1dQ9evsIaJkfP8q+hqoW6Ys7FVne
         QmnwlPKZZkmBiSDMhaKzSTRgT0x1nTEjOKDHT2zq+qs18uKzLhXPZAiuf8maQH1gmsRN
         KjnT5MPr2xxNCdEJvChaNzr2pWVKguFtoPKz+KgeuaQYBFnlg6hKwqYrRjZ2s9lCvayv
         lPIrHh2fSGuBtyUv/uKYoCdBAOcwY9+CPFszCamOfx9v9N8R+o2BioImN49O/OLKosht
         w6HCoLCKM5ecPzr6iUaXWji9MqxXQntBBltds1XlpStkSr2tT9Ub9XgLN8B7ZPZgVyum
         Q8LQ==
X-Gm-Message-State: AOJu0YyknAzYrF+z5nKbKuTm5KkJfHxf1ni561fajnx1ou3n1tTsAtaw
	sP0yI7OWyXRHJ03MJPyTebZVFO4znkyGnDBNv1tDpvNHOc2Z3lIoCIsxgqV32rXhzNOGHXKJF2D
	X
X-Google-Smtp-Source: AGHT+IHKm78l3r2CgFYckcKKmYlfkdKx2DNgmFerjXHeP/DWSCDvo3RXp3bypWX93xdI/kVd/hV7hg==
X-Received: by 2002:a05:6214:2c02:b0:6a0:cc6b:14da with SMTP id 6a1803df08f44-6ab80900dd3mr61347316d6.47.1716482307420;
        Thu, 23 May 2024 09:38:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab9b4f82d3sm648776d6.48.2024.05.23.09.38.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:27 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 8/8] pack-bitmap.c: reimplement `midx_bitmap_filename()` with
 helper
Message-ID: <79e3f7f83f4085eab03de6d0809e8b5d1bae4411.1716482279.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716482279.git.me@ttaylorr.com>

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
2.45.1.217.g9bb58e2bf5a.dirty
