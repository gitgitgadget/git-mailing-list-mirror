Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE422FF153
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820461; cv=none; b=bRoJOBRGF+8sO0Vugaon/NgtLVGMbyCTg2irNBb9KD8jydLEECeWtjvQG0d15wx/IAvOsEF8SRq39Smzu+kRlTdTgrxEUPI5HUNVNNSAFkk2RkBiMlJKzKmVtYcjznSEYmBdyYEmJuEJcEfZ0d1wo3xqk5nqQ9Xn5p+l4YaehGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820461; c=relaxed/simple;
	bh=yNFZZzd7zmiMRPuayt/ApJsQSg097ZIQnsXpbHhY65I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJH43X+W9popGb8yaCeXrJ5nqtXrcc4i9kYDcVHEaYi/V13hB7FQUEAG4wsUiMAS3DsSMJIIwNcCjrDTWKD0oE08Wnd9CI4vjzjmV2Tyox9hUMf+rM5a5LqOx50JyeJcKWbASVPpQ3wFrgY9/6M2F76odqzFMpQcXindkW3P+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=B9tP0Drp; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="B9tP0Drp"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501725d888so630263d50.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820459; x=1775425259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c25N4wMgyDIHJGXNmq6yNHkyBG0eyJtiJtb4F5lI7E4=;
        b=B9tP0Drp24JDtNq4VOsqM5b5/MjMUY8ASsyKbDvUIPfL9ZT+sfRFG6ECFd79L32acg
         5T2bj/59f1Ef5NSOpyrG+BY0B8N2ZMCl+nis+qQuX8eF9pqRCtFCtwCY62z0Kckmv4Ok
         987fORaTp8yKWVpaAdJ9qDx7KtTJvTOdCfnOqtMjlituY6IpWinuXE8XrAPJMPud8Rwn
         UlIafW4619ZoBegUN7qC98ghFdGw0cm5SJAzf4jp837DmlUc2LaUHEJpo27Dh2V1Cnhe
         Z7ix96EM881uENWMS7WA/ZrAwiODbHuByzy9jTBc/QArnEYXi8sGKbkcNb71ukXQF6k+
         1aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820459; x=1775425259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c25N4wMgyDIHJGXNmq6yNHkyBG0eyJtiJtb4F5lI7E4=;
        b=fXeyfGhVxAE4/U1jVHW/GpuPga+0mGMHs+/JkUq35nN2i1FbGbFCprGlXM7UJFXAgZ
         g2IrQBzvmoGu4VLmGpG3FdNKWJs/fhT8rSqFzIzFv3WYm8sr+cJf8GvtK9HRuswGHaAv
         8bKnPwiTOcmVpHlq1SOiVKUQlEkF+YgOehM0LZDBJ57azRNezXxpcGK2kdKMfoigpSPj
         uEt2M8JAaurkWIitxVbR4uaWckeVTimUnBTogswzbhAFIHSGVD5C8i9fC0u2waQmZZKH
         xGp/qIxh6fmEX4bMgytdlX12viQzk1p+mjhQ0TR4G3XaHc3V6WXm5FrcPtiaZJN+FKCH
         jyyg==
X-Gm-Message-State: AOJu0YwFqJmSwEUUhrTYOOEUZC6pF2Qo42E6s5V1cMHGc6TmBdnHdm8z
	LT0altHbYZ1J70cqNbSE2GehseBpfHlMBWYL95YHZg0+v8Qoetk5xcTDqDL2mbp8EwON+j/Fbfp
	hhY/p3X8n3A==
X-Gm-Gg: ATEYQzyyJlmsQnChOqhnwrcGaVk+gC1Op1E8788L5pzfuCh0O2z0PKNolHAmbnMqOt4
	phq0KbKNY8M9XuS1EeTs1+YHKkPLugdHWHoEjLugPAjeIM5JohECb6CLKAWzMMBzQAkB5+XCTTk
	pCYU+M6NPDsSJSjPvuVUcxxKE6EsboxVyDFlpzBXGmbkc8Qn9jdIgy8y3Zi5naloQ5KH5wuufXo
	1jQk5w1Eu+oHPILOGIxQoz3TPs99wYPyQrwCg2C4i9caLJG3U9gpSvqcZNXHbq+3IgwMdl9US1R
	afmvXFW0G/HC1N+HXetpWAxa+ewjdatJcyWhoUmCK5Hw1Xr79aPadYs312y/ZWBakGrO9hUHMoZ
	/LqQR6SQrpecbNH29w0FwEpINGP/AughKw5EnxxMRqGY+qF6GfaAM9EvkUShAL6CxyH1ykYOqoo
	HmZnOjTra1V5z55csFsEea9Dt7AjousCflM3H04SOgHTTX6gfdNqeAz3NEOzSF+9WwZ3BskhPnR
	0wX/+dlSyEI2Y8ZU9GurB9GaE8PTA==
X-Received: by 2002:a05:690c:112:b0:79a:b983:b44f with SMTP id 00721157ae682-79bddcb95c7mr92503087b3.5.1774820459230;
        Sun, 29 Mar 2026 14:40:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb71384dasm27179217b3.3.2026.03.29.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:40:59 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:40:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 03/16] strvec: introduce `strvec_init_alloc()`
Message-ID: <aea6aad695336a974df9c90ce7bd02ddcc33582f.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

When the caller knows upfront how many elements will be pushed onto a
`strvec`, it is useful to pre-allocate enough space in the array to fit
that many elements (and one additional slot to store NULL, indicating
the end of the list.)

Introduce `strvec_init_alloc()`, which allocates the backing array large
enough to hold `alloc` elements and the termination marker without
further reallocation. Reimplement `strvec_init()` as a special case of
`strvec_init_alloc()`, namely when `alloc` is zero.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 strvec.c | 15 +++++++++++++--
 strvec.h |  5 +++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/strvec.c b/strvec.c
index f8de79f5579..15371980b84 100644
--- a/strvec.c
+++ b/strvec.c
@@ -6,8 +6,19 @@ const char *empty_strvec[] = { NULL };
 
 void strvec_init(struct strvec *array)
 {
-	struct strvec blank = STRVEC_INIT;
-	memcpy(array, &blank, sizeof(*array));
+	strvec_init_alloc(array, 0);
+}
+
+void strvec_init_alloc(struct strvec *array, size_t alloc)
+{
+	if (!alloc) {
+		struct strvec blank = STRVEC_INIT;
+		memcpy(array, &blank, sizeof(*array));
+	} else {
+		CALLOC_ARRAY(array->v, st_add(alloc, 1));
+		array->nr = 0;
+		array->alloc = alloc + 1;
+	}
 }
 
 void strvec_push_nodup(struct strvec *array, char *value)
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
2.53.0.729.g817728289e1.dirty

