Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB271411EF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423396; cv=none; b=cIBikTYc4tWRaUX8FxLz3slHoTkyarcVw0aVfnODIkwI/QFKBTSZ4lmYjtIeGW7Wt69sqpkndJRHGrlY23h1Sv44srLJ0hjR/LKYoI/zrsySWqWk2PM+Bcq0YW5TLQK4+u6rZqC7T9gde0AYL9/aXcUozZoMzxPKMN6A3/uhU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423396; c=relaxed/simple;
	bh=cfOZevQxKQ7lU5FOH0CzJya2ZzWk0TwhcqA7oTLpGBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJtFYJyqy+oYStFS1y2oydDbNu0xZiWWW/g0OUFTiwMaccoz2ZvlE9qtyDFlFbtxqbukrN6Aj/nPVI1aPztvTzDQJgA0mTOkLUVNDsiXkmWz9chtf4Twmwjbtqi7KrfK7M/aly00rsYMytyf4hrGs2d1U0oiaMPM9rlyuaPkaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mXvbY0jc; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mXvbY0jc"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so14402086d6.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423393; x=1715028193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOfHl3IsgyD4kmOqu7gRQ/cA2C0zX3zS64mKluQK8po=;
        b=mXvbY0jcPH3l/bhkRLedFn63hk9L5ICoO6NwInM6oUisDfPHtJ4nQ74b/EWo4A9YL9
         MsmLcFw57Dc5EaovvN1NSlbzma798aANDM5y0wkjD7T4AmEdnADmL1jkcYgYaRpN1ouy
         pS4FVXfs6I2HppLg7HexmQ/YL3xzrr9UElrZLWRJ2XyBrpxjLpeDZ6MURmgyHaZ36Mrk
         E2Rf2yD7mSS9LMKcju3U+ozZnuYrqqYPBHtRQu+dO9nAJBcSFdsbn+thGCeGUgrlczrH
         5x9I5rhRgGSfNMeNs9IV4GO7kOx9em7CIwJbYV+aq+dWchzIkY5bEbwkvGazDtPyBVh4
         bjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423393; x=1715028193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOfHl3IsgyD4kmOqu7gRQ/cA2C0zX3zS64mKluQK8po=;
        b=MJVUxvtaDORmtII7tVS5MTIQhDlrwLZvmVAe5m2shxN41aIw3K/QDD1huQwJ/4MNbr
         xFSsWk0nHIO5fwLuMOf8n9lLgcRrqzrOgWE7mHcBVSy6XzN9k6twg6hwzhhWV00DltfW
         SCDdOEt5H2Rp8MGzeMQzqfRuq6kB8ICLjwWXzC/9ht9Acf7am8Lfz0nUarfADJp8+mWn
         cmlDws6RP838PELNlDhn49Evsgrr4rI4ObS2Dtwy9XemUqbqNd2zkw6kLKtXWEv8MJGz
         /Zg/VUFFUbQ6d5QCkOs5qSyqCWVzKsg7o+jvvNmD5YyNSTa+ugYjpAKExvqM6YLGOKQh
         GLCQ==
X-Gm-Message-State: AOJu0YxV5w92O7SMisPB5UrYOg2Fa+lsoW3Mg/m92MWkEoNF+GXfXt8r
	KT4kSWRdk2Fne16wAvLGIOTPK8kehyB2jYADaZrX9ZJOqk5cqslxRjYRo9Am+u6JbSo4qa0nTuM
	xIEE=
X-Google-Smtp-Source: AGHT+IFimIO3TRJUbxhsiZ8NEhRJvh828E+4SvPrfVMyDfy8RrkGige6n3NP5ZVNiKhhhHoJc6LKjQ==
X-Received: by 2002:a05:6214:5099:b0:696:4086:5e1 with SMTP id kk25-20020a056214509900b00696408605e1mr1580246qvb.2.1714423393517;
        Mon, 29 Apr 2024 13:43:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x8-20020ad44588000000b0069b432df140sm3847012qvu.121.2024.04.29.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:13 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/23] pseudo-merge.ch: initial commit
Message-ID: <e7a87cf7d4ea0249547cb170f2a4b14a80187ed7.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

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
index 1e31acc72ec..6a3d164fdf8 100644
--- a/Makefile
+++ b/Makefile
@@ -1119,6 +1119,7 @@ LIB_OBJS += prompt.o
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
2.45.0.23.gc6f94b99219

