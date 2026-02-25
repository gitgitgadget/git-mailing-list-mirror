Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799B1F5858
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978866; cv=none; b=jDlvZMYOTJAkxzoJl9DlUYufD+N45MZMDZ2kemWvd7UgBi7RuMS2LxC04lLAPE+c0+Z/eB9+dRB86veC5e2SPjC807k/0KZzpAZZ1KeI7EWtnvG2fCp+d3MVgrohTsFQ4L4EUfXsMATe7TRYMfm60jQguhtvn6SmHLU6vbiU7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978866; c=relaxed/simple;
	bh=xO+nB4e2kWHXyq4y+d+RQIYnts/BwxhyapO5Sq67ff0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZHDsn8WtBtsyzna8UN7YW+pAqizDXFh/okp+Bn7hbkVfmdHBLZ19yLfZfRefR/VKuclmQxtmkRfx86G4461v7UnNL1BPOpBFyFtfLNDroCUgWHg4rilzwQc41GNPB6l/axzp0mcm4gqSy39lHJkc+QszhKLe0PHZJBgdavBkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VSnqA4DU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VSnqA4DU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a67282a0so55688841cf.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978864; x=1772583664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdtUHkd1Cv8E8Y0+TYPZAkybFhnxwKoHL+lnl6s05lI=;
        b=VSnqA4DUMSNaH4OKd0uUjnUwW2BQrHktr9/0WM34G0LPfJBJD7bwKM/FuDbm7MbIjv
         vMoTWSfuOmYXbiZmBQpaqwg2+gHX63gDhKVBwU++LaRYM1w9SM89Ry4NtSUKNA+QYY1f
         kgEvg9A9tQ3lMDX0KRTSDwmEfqQVC8XgRX+/CKQQuNaafG/6jeD69fvHH2i5j/tYc//1
         2Fd9MLHgd03nAXI0Dhf67At2F1XBZ67I1uRAx3TU0txeixm6SnCCnARyr5IozGKXo1mx
         gGWQ4VmvypBBngCqD/k6tnUxUjhalQroqU5cKtMFBAUNyzcs4yA0mzHAVKaXi47cRbtF
         H3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978864; x=1772583664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdtUHkd1Cv8E8Y0+TYPZAkybFhnxwKoHL+lnl6s05lI=;
        b=dUJNANeMN8jNXDO6+6amYMGvKrzQ6nyQY5f9nTgfp40ZyFKez3Ns071hh3ffrAKpu8
         7GBVv++7rpa08KOo61Oy3NcOwBVwV4PkGPukbTCLPIQYL50+CIAE3gz44ShJfhj5dmId
         v813MrR3OHsaSvYRe5fsjAQMWzU8PUYXLkv9A8pWdwRbDiS2ACJrvSxhAIklS+IUWo4F
         Xz9jqRwekpPGVBIJIX3lyYHarrGQLmmVgCEqtwd77n6Jc4r6/dTmbva41dbNqeCuyFDL
         ZuWf5b0WYwc6Q4O3nA+yoyDng+h+Sxe4qBioYAG910KM2kruxaJQHkuDeGkYe3upg0RN
         c+8A==
X-Gm-Message-State: AOJu0YzxKY2VVdV4eO/EwzlKengcDI2+ogQKgeOqG0sb62Kkm/RWk0s3
	aLQS+XqUle9TyrVc9Ep6wIF68ip0WBYJP5ziNJUr0A7+Hzfasw4DjDhM0/8/imwRz+ImnivZf7r
	1/4LblxbQ9Q==
X-Gm-Gg: ATEYQzx6Lkr5rBgvIGcxmQsA7rvqeZeHxSF2n2Xp0w6H0LTC20HDV21Z/RClN0r3x8y
	6x92rJ8LHFt/VGlGiwwwgv67ewE2f2jAFLVwY268WqbuYIRu9Y9KCN/Na68ysy3Z194RMr1FTl8
	Uj91is1eerqs1QlioVLM6ydfGlMFUVol5YMfa6ZmYkSSft1r1aqHA/kumIbRHDM+a4YMoGkrYt8
	GgYatm7PquN91gNuBX5QSc9RxP+WX3dd5GDXPcwuc7qVaHbtDUpwm/KrgWpkJ98dUsd6SR+wUcJ
	KIeaAa4/XCWj1iLWwfqHhAADTgP37pjYbN3bsA3i4kikf+umzSuZjEeSTqR9MKxbdfflCrNOy6n
	ADnRKSN1mof/e1RpfzFl+2LZaorFPnf6UQ7/P77gNBrb0+je3P/R9Aj3SKVjH+jafilYqookOB5
	rm06SnH3ZOrvAIXJEdHB7Bzeuik5LiPzcDPxwzZZ/cIFkA1G5GhU19shfncZ2dvLWMt2/dbYRtg
	0AapqfZxya1kYcRNT6Gyn4YQ44IAw==
X-Received: by 2002:ac8:5d86:0:b0:506:8738:651d with SMTP id d75a77b69052e-5070bd02eecmr210989381cf.62.1771978863584;
        Tue, 24 Feb 2026 16:21:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d575a8bsm106641321cf.14.2026.02.24.16.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:03 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 02/14] strvec: introduce `strvec_init_alloc()`
Message-ID: <50efbbb0fe8d897d7c4cd51489af4cb4c4c49d02.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

When the caller knows upfront how many elements will be pushed onto a
`strvec`, it is useful to pre-allocate enough space in the array to fit
that many elements (and one additional slot to store NULL, indicating
the end of the list.)

Introduce `strvec_init_alloc()`, which allocates the backing array large
enough to hold `alloc` elements and the termination marker without
further reallocation.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 strvec.c | 7 +++++++
 strvec.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/strvec.c b/strvec.c
index f8de79f5579..f7f32a53b56 100644
--- a/strvec.c
+++ b/strvec.c
@@ -10,6 +10,13 @@ void strvec_init(struct strvec *array)
 	memcpy(array, &blank, sizeof(*array));
 }
 
+void strvec_init_alloc(struct strvec *array, size_t alloc)
+{
+	CALLOC_ARRAY(array->v, st_add(alloc, 1));
+	array->nr = 0;
+	array->alloc = alloc + 1;
+}
+
 void strvec_push_nodup(struct strvec *array, char *value)
 {
 	if (array->v == empty_strvec)
diff --git a/strvec.h b/strvec.h
index f74e061e141..34cb1f939f0 100644
--- a/strvec.h
+++ b/strvec.h
@@ -43,6 +43,11 @@ struct strvec {
  */
 void strvec_init(struct strvec *);
 
+/*
+ * Initializes an array large enough to store `alloc` elements.
+ */
+void strvec_init_alloc(struct strvec *, size_t alloc);
+
 /* Push a copy of a string onto the end of the array. */
 const char *strvec_push(struct strvec *, const char *);
 
-- 
2.53.0.185.g29bc4dff628

