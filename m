Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0B131754
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983581; cv=none; b=WwJUFntXDS0AmPxXRR9W8Lgpi9UNiiAML07loxtfcWGqtG8AUfx+0hc38IOyepEe1hMvJJ/cK8/+VFOMplDm+nfxgiIFI5ZUL+C8j+fNeTPhQJZpNBIq44THvc5bOD8u3ItPhBUJoZnlAhjH4Flnw92Jl0F5idCRl8sXX4BLpFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983581; c=relaxed/simple;
	bh=5Lgbhcoa1/4GEjM3CIAFFdfrePzVAkkf5qUOn7ky13U=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rGCbuXeeoL/Bdqu5VIX2xlJKloRav7xUPi56kKW8NAAuI2HLOZWgYTq/1sD7yYH9KamJNE0aJhlyrdSIWuhMpoqz4A3+62yw39nkEVQl/5y40Q7tem1u7X4qKbbx+I7J3n2s57fwQI4qQwfMChKEu36RfTQ6PRn+ZVB8QfGRNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKxiTSY6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKxiTSY6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a9457b2eso4937515e9.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983577; x=1709588377; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J06St+xabqDt0N/pFzzEVUlB6jdopGfNE6G3xY7sB7U=;
        b=JKxiTSY60uezTeSA1B/lh8QmIn0cfYI02cBelJDO3KpEooDV33+PMT45kj8hHo9eTa
         nZ4LWa4tCR9QHwVB8T4uqh7xY+KWbsFT+9Kg7hJmItdCAmmTYOFl3lGnJd/kiYZEJm6Q
         OPtvHdy4/TdrysTaTDyE+49HjeQe4yuXLwc/GS3bJ/F+020KCjGtvI7Ru4Qousnl6zX6
         g1OnkWjm2zu43xQn2FRbAhz90bFS/pgUihbem3mX5STIzzYRD+xIaGYKZoszwGcYp/Jo
         2gkCbLfxb0uR2HwhnEg+tdOQVYmXxFTS3uJ1NftnMQ+eJwhrgX0FNXMvhcCvD9E/5c1T
         uk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983577; x=1709588377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J06St+xabqDt0N/pFzzEVUlB6jdopGfNE6G3xY7sB7U=;
        b=uRn+7CzZpraYKV6YWj1ZkqadPLAgo83515bHeJpEMxlsGJ3PORPOPDbUwUYTLtOHoC
         cBPttsZNjXgT6gAmem867VJ1AzdduXoEb8qSbg1JJYobwX/bXnN4SNuHTSVRVEyUItwT
         0+P+ag52ypSdCp8hRgKRRbWsv0DTYCGOVKS7aIYocEIvpZq6qmhhSiMLKjV18R4Dbc8y
         RFvdBr7so4UarelkkG8VndAENPdSCqbXoKyNuWhanP45+Ok/QIZ2kKzlq21nDe1EaBZm
         2xzB9ETK5tzbsrAB26xAf3lt3XSNF0ipU7k+b5r89Z/zjFJiwCvaJcNFsFWA2DDqQPrP
         YsOQ==
X-Gm-Message-State: AOJu0YxKOyg3EyGmrebKZK5HLf/5xjviX91Ig098YMtQaCV+XzBhr5oi
	pX44OibEtoQAYWTNdHd2DPxDFYNzDilS0jfm9/dEDNu3eo0wV1arxKNw7Q/C
X-Google-Smtp-Source: AGHT+IFxbJC2jR49/XGZFZJlLRDbaIi7urUPaO0hkcsoAbSvST3haqqpuupITOcqhwk1gQAC84wT4g==
X-Received: by 2002:a05:600c:1c94:b0:412:a7d2:de8c with SMTP id k20-20020a05600c1c9400b00412a7d2de8cmr2488679wms.4.1708983577293;
        Mon, 26 Feb 2024 13:39:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dq2-20020a0560000cc200b0033b483d1abcsm9310439wrb.53.2024.02.26.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:37 -0800 (PST)
Message-ID: <0148319aea5cf32c454be9d1a0efc7934580d7a7.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:23 +0000
Subject: [PATCH v3 12/14] fsmonitor: trace the new invalidated cache-entry
 count
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
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Consolidate the directory/non-directory calls to the refresh handler
code.  Log the resulting count of invalidated cache-entries.

The nr_in_cone value will be used in a later commit to decide if
we also need to try to do case-insensitive lookups.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index c16ed5d8758..739ddbf7aca 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -308,16 +308,21 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int len = strlen(name);
 	int pos = index_name_pos(istate, name, len);
+	size_t nr_in_cone;
 
 	trace_printf_key(&trace_fsmonitor,
 			 "fsmonitor_refresh_callback '%s' (pos %d)",
 			 name, pos);
 
-	if (name[len - 1] == '/') {
-		handle_path_with_trailing_slash(istate, name, pos);
-	} else {
-		handle_path_without_trailing_slash(istate, name, pos);
-	}
+	if (name[len - 1] == '/')
+		nr_in_cone = handle_path_with_trailing_slash(istate, name, pos);
+	else
+		nr_in_cone = handle_path_without_trailing_slash(istate, name, pos);
+
+	if (nr_in_cone)
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor_refresh_callback CNT: %d",
+				 (int)nr_in_cone);
 }
 
 /*
-- 
gitgitgadget

