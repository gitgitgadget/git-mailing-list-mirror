Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972A484238
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946501; cv=none; b=N9gEcTi0SCVJ3RCQW8ZcyFDM8weomGyyfHYUiRww3ytK7lSWpVSScM65WPs2BFNBT36OP/tArWxmWNdNMQ9+w9mqOIvDSakyar70D3H4C+/qK7Bi3C8cbsOVvTB0hTthOVB3x4PP6QxKJ+d8szQQP/Rbeuzkw2WtnISXM1R+pEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946501; c=relaxed/simple;
	bh=tJSCgB6x0jbgExgdCRZ3qo+Hfof6AX9abMAJyj1FDgc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oqtdHppSDaF5WrgaGMv05EeDanhJw9CJO+yH799Ckhn6JhYW7VKlWwgqNVuJEAxa+MqM9s9WVOshC0RSovejqTYexA+slglEM7x4CaxdfAWrX3W1lJ+OQEKSi11NPrF5mQZz0F4cKnwuASWzvPwSqeoEuNliL1snXe7u79nwoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzeInbrU; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzeInbrU"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb64085c45so1000283a34.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946493; x=1786551293; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dCHkQjg/qVtExucbStgAUbSk9OouMFE3EvSXlZAN90=;
        b=SzeInbrUXZZR9XGMDuRuKwaE7DnVyJOhAo1/XyMnK/hnA1P9E+Gny56kvlrM2q9A2Q
         7IyeIR3wVDLen4YEpg/Ijid8e0ntXSxp094vrS3vUTp+NDZV4KrX65AhREaLO8Z68RV4
         xm5MCSkhke6julcpkSEp1ZNcZUyb95aAizG7ud7Z7dxQdSMtL7xwjMaPejO87/oFGv6r
         vqNK2uWZNjCSXssqAgZK/VoV71n1oBjlCHZFopxlgseL59dBzKarT7Yt0OyPP9bml6Kr
         69cInGJ2ji2BSamyLjm6Y8BHytWkX2fRCh3NBQ0H3BhowObfUnfdnkgDU8jXgI8mJQ6a
         7bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946493; x=1786551293;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dCHkQjg/qVtExucbStgAUbSk9OouMFE3EvSXlZAN90=;
        b=JUcTurNKvX1xtwnwglv8gM/NeyCiMOK9DlPjU1ReC1xFEfWpNaKElgeXRaeFKrChYy
         dY0xV/89RgBn81CyVLCqf4ZbhXuiajGJg00/De98P/gTTA5o9OPrwrt2JY5lmQZKrO8p
         uCMuoUTeyVRaCDOVaNtLvIHrtuycOLjyuVXnOZI92afXAt89rF7ezRsufu9zY0sS6TI4
         TFKo6wKDaPo/bda311t0o63FnRvA2uIXRiI3u39dVBY1YUrxkpAvFgj3B9MPcc/VLQpi
         DZil3uPDCwfV8o0Xx2rMIJdQdfKuP4O+CVFA+UD/4ntMKinoC9bNdGG72gwSbR6pQmJM
         WBDw==
X-Gm-Message-State: AOJu0Yybq0sE98VVJxg7pHG5LGSWrxTNbjLmWV0HbiAkNABDwilZ0psG
	Omp5XXl5kxtwTfLHnJ7GwMW113AFD6A3F2lrE3/3/iwYzLqWKpq8ENH4W5y/oNQ4
X-Gm-Gg: AR+sD117vFqZ5tzbDr+inDFSWLRkUQJ4i1kuFVs3iYM6/5fkoO9UqKRugJ9+sLnPAxQ
	SIhrI60m1WBU9iHEG22uK/C+2bCzkVQJlPtcv6UkmAdeoQyOm5eSuVXG915vg/BjEVkn/T/1d+k
	rimvnasyoXInUDi0vJKwVCXUKd1BpHJRHFAoZuYqZ2kcNfJsFk62LBwpfNi77IW31J4xknh6bs5
	MhvU3OVr0KJ0SDfXiVSQc/yq71XcjUtd7w2gVqB/4DfA8Zk2t4oUunZecpoO07Dr7caFEewRAjb
	rEohQ6AOUIMatdl7lU8sd53DV8HHabIroMnYStslphl+lTGcj6wIuay3i3FB9iPOgVDmFSZEC+g
	em6Zc16lllk9M37ufJ5YZoizCpxS5jHVAv1KVE7sBo8HMV60fd84jM926MHB4eFvObX1cy8irrL
	THbLOaWVbeZz3gVlOmQHIgb5bH5KlvE74AJ8zF4GehU3pp/6XnRdXq+YdMPHNx1ZdOwQ==
X-Received: by 2002:a05:6820:4b14:b0:6a3:7ad3:e728 with SMTP id 006d021491bc7-6ae96f3a250mr3573204eaf.28.1785946493393;
        Wed, 05 Aug 2026 09:14:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d9aec6sm3147961eaf.8.2026.08.05.09.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:52 -0700 (PDT)
Message-Id: <9f379ee7aa715356ea3377d3e2096df219ea8c76.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:35 +0000
Subject: [PATCH v2 08/12] archive-zip: widen `zlib_deflate_raw()`'s maxsize
 local to `size_t`
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

Prep for the upcoming `git_deflate_bound()` widening to `size_t`: the
local that catches its return needs to be `size_t` too, otherwise the
widening would introduce a silent Windows narrowing here. No semantic
effect with the current unsigned-long-returning `git_deflate_bound()`
(`size_t == unsigned long` on this caller's platforms today).

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 archive-zip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index 97ea8d60d6..a487d4c041 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -206,7 +206,7 @@ static void *zlib_deflate_raw(void *data, unsigned long size,
 			      unsigned long *compressed_size)
 {
 	git_zstream stream;
-	unsigned long maxsize;
+	size_t maxsize;
 	void *buffer;
 	int result;
 
-- 
gitgitgadget

