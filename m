Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FE226D15
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493404; cv=none; b=iyzzku/dhm83eH8viwubGm0LyircWsi6hK1wwnOPkVVcjxAYcRA7U7/J0ZL1fRWWjc6CY5BrnZvM/GsU2B8GyOU/ucM2OJCgE2Jay8Kib+8RJk3qkpRokKpoLdMlmcobOUxTv1C95FXgVfpu0kmcjw5zR/O3XzgeQB/+lnFkB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493404; c=relaxed/simple;
	bh=vF4WlOV9bawcZjc0vNeIB+6OF3dMVBLiaRXb514GCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEwqA2O3I8bL+MgTQwyfDfxvA+du7CcYAqA7z4KUCNvw2efwf6UvZHX0OOZghpF7Hc+OGFuvm/ZtpRF+ggaq+V+UJKP0oz/bVwkIJ82kI8kjcA+v4X5PIPaEhK77bNgibOcRYBG63GBtJos7AXHqaWHtPc9nfGiBovnsNCEi8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=adUQA28Y; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="adUQA28Y"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6eafac1f047so18338606d6.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493402; x=1743098202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtPKtDait40Au1zUqhsov8C0sfX8Zx4r0DqaogDLTBQ=;
        b=adUQA28Y6FDmIor8bIperg/adm++B4jH3URBcxiYClaVtgcmqV9QjhpUNCt2jCnNgc
         o5xftQPiRg3ZQ+6qpGRbm2xuCyUFy3ae40N0McxBgLt5PsHxpX+fQVjbb1QYy4+Q15lY
         J/Si1xU1sUyu0WVuPdBnlNQhWbCvgF9BPKrjVVO21RCUS6lvO5oubjPEBsmVGxOGzbyF
         G5hUlZl6dXrhZCU5UsRg1qTw+uJZkAfvwN8oQTMgKljLPRclf1ItHbtxzuh0g/V3r73W
         R2umETxSvEJtDzINI+A7VAHztPq+kPzAELqQ6c1SqKkki/PxJJLsaV4WYMsomkbwbqRc
         YG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493402; x=1743098202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtPKtDait40Au1zUqhsov8C0sfX8Zx4r0DqaogDLTBQ=;
        b=jcIk7RPlmDm4DWYQoKnMoFEhKhNJ1GJWy7b6RmapfiYz2M831L39zzZ8s/+EamJsqT
         6//9w7qiSr63C6zOIbJrdUgUMT5SLXPikXylN8pmfQh//bt5dANdaLDxEzK33l4X409k
         +gTpMyyzSH81IQh6MMCIhdN8+MwIv1ouW/Hk+RXVIIVuYkJXsZ5pGIgcE+fa6NSGdUSs
         it0Q8M3K2xWnSuXd2bbywkDskAzfqKlPUHv2aYwaEaCQPy6K7PoZphQUF5cC7/Bez9lY
         nZ4udBes1wI1wsAc3/6ap+g+03C4BWbIjnCEQu3oujRqbuJgNPZHqi75aij23vxfT5bh
         sZeA==
X-Gm-Message-State: AOJu0Yw1m4PfWcipMmgisQCLfbrUK+qtzLKMPFHvkSeTTnvaLdaBCGTa
	KybqwNscsd5BjlyVCoiMah7ws604KC4rQGvRTWxGxOtDgld4uERj/+oQht4De3TmCYnvBlJiC9i
	sF2Y=
X-Gm-Gg: ASbGncsNBtbccOiDOXHyS3oPUMtj0HoOgOi6K3l4YasGwZvJTCj93x9wFsN2/YcO2wJ
	cKZFNQi/lwlZeDT1OVczCqiUzVY/Qkmmvpr6+Kgsv3yJvWOnCL/9Xy1EjiJrpIgBaBHZKRXgA3o
	9t/GycBplGIWvFAtE55ZdgiYWmVwk3ya0WEjHA5z4gs8qZ68bn2y6V2hhEjtJfvPMnVCvwEjgG+
	Y9d2JWOd27QjTAa31vQQnihkzPSMqj5ZcMaFpiJJl01vSz65fc9aO3oi4mFr06DLSlV5iAFOzxV
	ERDZfSpI58qSClpn0tde4dWnd5POoYyWPn1P/ZMxLZuP8KLkXY9H31U8DkHJj1+FCCbxfduoBLL
	A+BYNJ8FtTG1xw/SG
X-Google-Smtp-Source: AGHT+IF4Z5t8VgXEv5gwyO1d/SBbgci5YUQkGTpMVE2heJE0oRJohjHHVBBSjGRO3P3RI29UpSq+UQ==
X-Received: by 2002:a05:6214:2a83:b0:6e8:fbe2:2db0 with SMTP id 6a1803df08f44-6eb3f36c234mr3962456d6.30.1742493401953;
        Thu, 20 Mar 2025 10:56:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef344eesm1122456d6.59.2025.03.20.10.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:41 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 06/14] pack-bitmap.c: teach `show_objects_for_type()`
 about incremental MIDXs
Message-ID: <dccc1b2d2ecf99abc88fa454ed55b36025500c60.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

Since we may ask for a pack_id that is in an earlier MIDX layer relative
to the one corresponding to our bitmap, use nth_midxed_pack() instead of
accessing the ->packs array directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 17f1087fba..f3ef9e43ef 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1636,7 +1636,7 @@ static void show_objects_for_type(
 				nth_midxed_object_oid(&oid, m, index_pos);
 
 				pack_id = nth_midxed_pack_int_id(m, index_pos);
-				pack = bitmap_git->midx->packs[pack_id];
+				pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			} else {
 				index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
 				ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
-- 
2.49.0.14.g88b49c1b34

