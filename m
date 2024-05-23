Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C581292FF
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499590; cv=none; b=GAMMLSwsyypjc/g4fzMuY/CZzgVXhPI6d3Jzs4+utppWYSzCWvyP6tI4xyhDoWmjUdYjhTA/yoEjoSNuA49DIQQkkxotbxgW87eSTkeblgphdymXOKwx5HtOEthjIBAaUw34NMFc+tghRRwdS/1wkuDDxONgTg84/QfLL7AiCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499590; c=relaxed/simple;
	bh=ReCt4ao4Tpb9IejqSMk0FxijtPz/MUKxy/EiAZXR6aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAahSLbvlE1UpfkcS8gmPuHFdUt66AD9/9f1l7uAE4bLxRi7laWABxs7B4JJSTkOE2AyKlwrTK91toUgJncXzUsTfI0nNYHJyycit37qcXz+u7amt06vpMicKO5zTdilxk7mGW2V5FPOuNlUVJS/sKCjouDTahrJ7aLfaJ6rpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mUSBVB3i; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mUSBVB3i"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ab9ce67eefso1493466d6.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499588; x=1717104388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oqyzmoQaf0/bNidQ/XZuR4Gez8S4fZELhMGUHYyfCX0=;
        b=mUSBVB3ivmOT4abqyEFrbRnIixeoLqJzO8X2knR75RTstLXfHNcb7Gc5HpxKrH2xWD
         uwtdfmDMXArcaWS7j5jvUkIZ4CId/3RW5NiYCjth0aX1aATvvsZ2jOjMkh/uJjL/RyHZ
         m8tS+Oa8GVFUBR/TmfccJ/BDXsfgjJwUzWKYQ47BQQ4NSa96R+/vVX0hADtUfaDsrO5N
         MQFsu/ReQmUonLVAR4La2yPMSFC0BKR0yo/rheR0qhes3FWrqXG4BgeBVqbo2Tz2C1Mk
         5qLZqzWNmDVbFCgng8ODxJX/MmETSst9gxLj2nLq4rw6U4zWcPkxVqkeZFWUHYicVfQx
         2I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499588; x=1717104388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqyzmoQaf0/bNidQ/XZuR4Gez8S4fZELhMGUHYyfCX0=;
        b=fX4jlN69dijlg03pIqSDYDFlmG+4iPCvNLyC5+3H423oJkRwMgAn/g+Xyx0QQiMK2C
         HmK9BevVQUKOpKKRwpwg73Ivs/G7MeOd1xyrb9BZRZHyx0ceIjwyrSMGH5NTmT23x0bC
         AQce+k/kpxJgp7pob5cQLXh9YVqoA+shnGIhMkGneUFVymN2dEENJVdYaepX0kZ81PY4
         UyxcG5Y251tSjmt4PtsNY+PBOihYA+wvuNgi2kQIEkA/K9YrcRVnYKXR2f/aUnWc3YH9
         W+kQxq5UrcTnRTwq8KDIAI2tWfq85FckZlJOYgwjmLLsuf+sHbhIYardbq5kfOU72PDV
         HQeQ==
X-Gm-Message-State: AOJu0Ywa2X6NUXw+d3TqnAzOpd4Z5DEgqcJOgL4ofr3/ijnrjYHQryJj
	pjIp2l5IXvK8cn3hteHinfyv+GxH652mnynpBstjhpdEP6vBf5tzxpJPK+N2hOa0WYUuk1Gqpt9
	W
X-Google-Smtp-Source: AGHT+IEcS9h2p5L5njzx/4Z0J2+CSEzMfDSQZmy3rersC4eOoonrFVKm3x41LGyuf1rx4fdR3ExhpQ==
X-Received: by 2002:a05:6214:2d44:b0:6ab:94ad:2921 with SMTP id 6a1803df08f44-6abcd0cc6f0mr2931526d6.24.1716499587956;
        Thu, 23 May 2024 14:26:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070edf4asm615246d6.53.2024.05.23.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:27 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 06/24] pseudo-merge.ch: initial commit
Message-ID: <6647d8832ce1b70c4b46bd1191086f7e4bc19a34.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

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
2.45.1.175.gcf0316ad0e9

