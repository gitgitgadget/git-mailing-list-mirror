Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6F181318
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716614; cv=none; b=AsBLVRri2MxAOquY7Q58AAxA1g+AhsWNoVTQakYxoqftLAI0MXTKgEZefd/cn0frPVQafdGIJ4U4+5QPHCY2CzV5ODTl2zIlgFEXqxX/Eqgor42wNJBQyi4+UwLmk2cja/R/FoY5bGUgOTHXrfxRtHlJpKEImKVzWCKuuj9CVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716614; c=relaxed/simple;
	bh=DYG1kSZpoP8dujbKTgaMzbrHG4xxn51AurGQIm2FDbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws71tsNtbLgOENhpEeKjpO4OeoWLYMsLkPDUYp9LN03/XcFM/5yw56gnLAvclg3kWWLzpz2VU4GG/jnwFiScyJ4IaW8F2YgW9J0YMqc698EyUBIcldOD33jJb/zIA+B2S8zH7OaUrZUrtd5JjOOflHbHU95LZ4212OHHhaBJHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KBCa3D5Q; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KBCa3D5Q"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792bae4137bso585695785a.3
        for <git@vger.kernel.org>; Tue, 14 May 2024 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715716612; x=1716321412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPWI2ewRqgvvqwLoJKcz2JhceFqF8ks+9PQeNLr/UvM=;
        b=KBCa3D5Qe/1RMjvearQt4bGFxg7oouJeZss++ckrfOEBe1osxZ6t1GfiHcH7Uks3jb
         kWvMozmXEeb0rrF0FKp5dSEb2E2U5zG5A8TYUdr1S7wPj1fIPYJGhbF7enfeW6M48SAn
         FoNQmNjt9l6a4PVj7/iIEdUoy1fw31ptA5rbm7xYfzTL8akluTs3fhkbniG1eM79aRW4
         /r4vEUIQ2fHLFc4Olds//gdlEa1LsVVE5j7FPJECT4DhfzURHtb6YJ6pc7OjS6hBewQz
         2ywKqMEY/JzvYZ5/wPJPh4FwyxMBGBI/XKRYWb+NwTO9el2gUqRYJlSziSuPRGIOKJvf
         1f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716612; x=1716321412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPWI2ewRqgvvqwLoJKcz2JhceFqF8ks+9PQeNLr/UvM=;
        b=XBKTZhdHaZfFXwoygb0s9++dCVLjwzrEh/NNzP/KbLYKM1Xf2/4ihpChQyXeRA0zgw
         lEa9ML4aPWf04HhYS6Mqulyx1BCBp93/XLMFktF+NDUqR7o7/CklMa+Xeuc2grq/5keR
         a+kJzJVP8Bm0RtWffuvUclup8Sf7wQQrXzIFt1EWTCK6psG6FazBPhy5TIuPGxuXm1rg
         QVZikvyHjeXXAwPMO9VtwyJ9K25UB978D/ELpV2H4EPSgpdBBMXVoysLbNuyg/TNG4Tq
         FJ2y7eC2Z6D/YG65xwrcwp5bILPS+k1p3mlOd7KuemgILqaCbBwTVmpSCOswOTepWbXh
         5OXQ==
X-Gm-Message-State: AOJu0YxbvuKBygKzLqcWre1EQLm6C+ACjz6aZxzxCWnjXMjU5mR7Owq1
	QSZdzU3DRw8FswSQuFZkCLA8jLKn3PhF9mPrPkVqOzqsOQAOvFih+LV4rKMbjQVBj95gSIm6Ear
	B
X-Google-Smtp-Source: AGHT+IE5lrQ0jkyyb1zAEYMK2aHxPOa9zRHGn58tV/rPTFFjs61LOEXlGtTx1zFgCYijkJHkd0i3pg==
X-Received: by 2002:a05:620a:9364:b0:792:bf92:b78a with SMTP id af79cd13be357-792c75773b4mr1445007585a.1.1715716611920;
        Tue, 14 May 2024 12:56:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf1cd143sm601181085a.0.2024.05.14.12.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:56:51 -0700 (PDT)
Date: Tue, 14 May 2024 15:56:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] object.h: add flags allocated by pack-bitmap.h
Message-ID: <38c96fc1909162a4d9c188f55b7c708cfc1b14b9.1715716605.git.me@ttaylorr.com>
References: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715716605.git.me@ttaylorr.com>

In commit 7cc8f971085 (pack-objects: implement bitmap writing,
2013-12-21) the NEEDS_BITMAP flag was introduced into pack-bitmap.h, but
no object flags allocation table existed at the time.

In 208acbfb82f (object.h: centralize object flag allocation, 2014-03-25)
when that table was first introduced, we never added the flags from
7cc8f971085, which has remained the case since.

Rectify this by including the flag bit used by pack-bitmap.h into the
centralized table in object.h.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/object.h b/object.h
index 9293e703cc..99b9c8f114 100644
--- a/object.h
+++ b/object.h
@@ -81,6 +81,7 @@ void object_array_init(struct object_array *array);
  * reflog.c:                           10--12
  * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
+ * pack-bitmap.h:                                                22
  */
 #define FLAG_BITS  28
 
-- 
2.45.1.151.g7cc3499008c

