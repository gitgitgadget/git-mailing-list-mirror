Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBE1494BF
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318140; cv=none; b=jQ5g2j/sEU1VmbS0fswHLjb+P1Esj7qc2gkRIfdRTVNCFfT5pIhZRJVE8TTtPxnFx2YuMNUisgfWdPmePzKBTQqu5K9Qo/1iNiIK4PoxTnDpAsiEiIjnfUCjTLGtalcKY2n6u2OOehOHZ7GunTk4zC6jwYvDGlyGbltq71OADic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318140; c=relaxed/simple;
	bh=BCMcsubjBIWMCjUTktMGRZVIQ7fvrJgSm4iASH1Hr48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1CneUPYpJNIwS5bhkQAK94nJMFmnhb552lowy1uEjoHPrF5qY+elThfgVMEq6emg6OG6UhYYzciIjgQJc5uYIfeeBLXhJPWBGUz0LbRrGsgQ1eSzebN4BP037OhQ+UH2fcbfnrSfWX9ScEFeC9UCW3aBofkIisVSFnKS+mjFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Mzek5EEr; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Mzek5EEr"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792b8ebc4eeso327773785a.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318138; x=1716922938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nWHd39/HOj6RcEYnoxjlP67QsM8zN8cBzzsRiJrKQI=;
        b=Mzek5EErxDrDF0lUVNEaPJ9kT6rlk3CpdeEbf1DECajvUc+J4KRa4QIvlz3CZgi5qA
         i39K2CFEQs6vsBwxE7GCcopfJaX7oiip+GF2NncL6R3caI40LnrXWI6uk8AfWVVD3kWs
         vojhPrQBOX3iXTltce5TB7OWorMlcWlPwg3e9GRwAB66lIMTvVlpqxC7gTEo9LBIcMDd
         QEEzPEvI/DSfcv0ixNtA45gholTETlYPMua0mOOlT0U1z2zEhLzZW0TxNI4N3tUdrCjo
         uN/+kFJLlAZJ4Sxzf58sW6lns/Kl7wN01xd+3/V5hN3ONdkLz5mzDbCG+sRiERw0fgyN
         0brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318138; x=1716922938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nWHd39/HOj6RcEYnoxjlP67QsM8zN8cBzzsRiJrKQI=;
        b=cMJaiz11z5MHvIGfK3WRTJSIGAMeKdd6o5QBzU8Kb0nrPAGLaFmswLs6MDJ4bi/+b0
         h/YzeFZSHnSijIouWR6oMfptS3gfMPdc6O58i6zX7LdHgAjrQAMUTHGKkIh2MWRpvwK7
         OduZmEouvJFy6OgUCtaNqKHOiLSk5NpyOBFIATgWb3QjjC3+8mO138UqfG61uQ0PtShx
         na5vpaEkTAPE89Ji/1YcsSIJ+DZLdV5p4FU2Jycj1SE3d+fVE1ixRgf1JEUWJs8Su6kO
         IShw82h5u9GY8krPw8Kc00UYjq98bOeKZzced0FAmPr12GF3Q75Fe3qi4PvwpGqVeYhj
         Pu+Q==
X-Gm-Message-State: AOJu0YxCu+KN2PRU0IM5lAWAfPL1bCCmiN+TKYXyRn29wz/2agsD2XS1
	KjyrHbtiYfnM9D+4Nkz2Gkqa8beqVXuTwOoddWUSBMTbeoMdZ1xFeaOxYvsmBc2yjUf3sXR5fyd
	S
X-Google-Smtp-Source: AGHT+IFQ6cS1l8z0hwUvVqpSxNMdHOcfuYSJxbmy0fk4dESEWKdNsHCBcDV6IVl329mFS60MqHm7Kw==
X-Received: by 2002:a05:620a:472b:b0:792:c3a3:ba29 with SMTP id af79cd13be357-792c75ac217mr4328738685a.42.1716318137853;
        Tue, 21 May 2024 12:02:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a14ccsm1303126685a.56.2024.05.21.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:17 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/30] pseudo-merge.ch: initial commit
Message-ID: <827732acf99406fe30e87efd679fb6631de9c130.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Add a new (empty) header file to contain the implementation for
selecting, reading, and applying pseudo-merge bitmaps.

For now this header and its corresponding implementation are left
empty, but they will evolve over the course of subsequent commit(s).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile       | 1 +
 pseudo-merge.c | 2 ++
 pseudo-merge.h | 6 ++++++
 3 files changed, 9 insertions(+)
 create mode 100644 pseudo-merge.c
 create mode 100644 pseudo-merge.h

diff --git a/Makefile b/Makefile
index 0285db56306..4705a69f57f 100644
--- a/Makefile
+++ b/Makefile
@@ -1105,6 +1105,7 @@ LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
 LIB_OBJS += protocol-caps.o
 LIB_OBJS += prune-packed.o
+LIB_OBJS += pseudo-merge.o
 LIB_OBJS += quote.o
 LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
diff --git a/pseudo-merge.c b/pseudo-merge.c
new file mode 100644
index 00000000000..37e037ba272
--- /dev/null
+++ b/pseudo-merge.c
@@ -0,0 +1,2 @@
+#include "git-compat-util.h"
+#include "pseudo-merge.h"
diff --git a/pseudo-merge.h b/pseudo-merge.h
new file mode 100644
index 00000000000..cab8ff6960a
--- /dev/null
+++ b/pseudo-merge.h
@@ -0,0 +1,6 @@
+#ifndef PSEUDO_MERGE_H
+#define PSEUDO_MERGE_H
+
+#include "git-compat-util.h"
+
+#endif
-- 
2.45.1.175.gbea44add9db

