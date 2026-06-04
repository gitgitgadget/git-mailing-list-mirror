Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094BD404894
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570279; cv=none; b=cR1hLwZArfH4M4eb4GCUPQTaQi1oshWXsVYzwe801o3X4NDt6hgzvUYTumdELNiUQGnGpIVlFynCA5bf85FkMySs3SlBPuA+uf0WoxdK/QKbMPbQxPntFdjfZaAZZQ6ukK/EeO6oUcclu0XoSaAJC3kF7G35eM/lQED4D9NlN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570279; c=relaxed/simple;
	bh=WnEoVhKdHQ/cE6WTUBWLfIbkKPKNNLfYd2kXKsbH+Os=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LR5w45tm+wZWT+6qou8QyLBaFlR2tDLQdWNFyKeOYMrKSNJybptFTmd1PVZhkjxR8lmC+6Im1MesdRxiNSNbtcv4tlb33+GxmZfD/SGqh9asuY2odomoV5W4Xar6uHSgdnWVM4EMe77YcV5IXa+pijC6JCbQfVvTs56WIRV7pxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCOW7XQj; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCOW7XQj"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137dd4cc208so293154c88.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570277; x=1781175077; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5tb55NGXEaGd7UOI8fS5Axn6KcOse7pomwuDp6jXLk=;
        b=dCOW7XQj9yPUoqTwC5cz9EKJfcKsDp7/jyvgqBGS6rf5RiuQ1UEcEMsnW9+Z2TzN0U
         pF4SLiNoJfv8iuiwu+9QM1DQcJgjWLXIwV1NonvN7BxUJgGiR9JkZAOb2ycExPP4UhOA
         DZW0ZSplFzUOKjp4b8OH0AhUmu0At7Hjjqmj4UQn9YG4BnurBn80M+Pm/lK73c4XIwNy
         4x8rMn58OouFGlrYIu3MTiNpVZ8omwz4jHPr4DKRX9YKcCfNLhyJr8/kwSpzvzkdudsQ
         D9k+7GVSGRSoj/kKOvvvMAl9KOpVsgmLybLm7fKUiferx6/D8qgUKqKazHFFVIImPEPq
         w5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570277; x=1781175077;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5tb55NGXEaGd7UOI8fS5Axn6KcOse7pomwuDp6jXLk=;
        b=O1j31NnROIa4t6L40lGZ2zeBasjSdn6Eng6BNojN7Z3mMQ7s/SF1tXmBLNlDW0oRdd
         2lN2knDgoOvN8FfNY0PYbEhG0JPpYtqna+1d3BL5iJrmzylp/oRKKT2M3MBV1mrCsDNO
         73RrQLYeoz6Ts55qmW3eHxpcyN1oR2oXsol1dsKWH1T7VVUuiDAA21D4ZO6GdSMJo7cV
         2HutqPrSi6EEHlN6k5bSrwaYu4kXpZcRkTt4tkJaePIxptqCbm8xmVXzcHYhQTUhLBmW
         NQEWRVcl+t9HkKbureu/aNHc4NyCmj0R2euA6bzd7fBWkfksdzHM6hegvKLPRDmKE/XD
         3tiQ==
X-Gm-Message-State: AOJu0YwEgsMNLLlDbNtDPnTAEN8GCdIA6XXAc482N2G3Po6xCV+Yr+0f
	rJ61SGf7VWEdBH/J2CJLML31UCbrn+owu8tTE4+u8eJJGLVa7uQOwLNBtqqwxA==
X-Gm-Gg: Acq92OG3nw7VvQLZFfgFbZt6LniyqT8Yygg3xO6xj2kLfzPZvajVk82F5geVNbEZ5yw
	vCXJwN+i6b+Rqn+cmTn6rrvgwOKo9E8KoXelD77pQRqjqS8SqBneOsDRfPGwwo8kBRvc05/GQXS
	s1/xUmrgjlgs65bW9G0IR7N8TqMqHAtuFMGDsk9+mrmJw+FiCO78VdHUMutdg0CCuLl4r7qsytR
	9tjZwni7Gnw+v81PG+tVsSbVQRSOnoWkN6gj1U7EZDJuVV4BA7f8xvjmnGVKvhaDwfRAdDpIpRP
	vPSQPTFRjYY529MG04Y2nNw66tw3BVpORR/WUxhknWexaVYvPcCqh9VsLJcmp/pUbuEOST+7qkS
	aGc7fQzmRPqlG3XItEFWLIlFkcJmSqozDw+oZDrnhQ2vL9bC8uLmSY/g0cz4vKrqqzdE1sXywwJ
	3YxIPCEX39qSI9304IECbEoElwbFHBbuMwRRYZZt82MJIcWT0s
X-Received: by 2002:a05:7022:b883:b0:138:e4:c4b5 with SMTP id a92af1059eb24-13800e4cd5cmr393184c88.17.1780570276921;
        Thu, 04 Jun 2026 03:51:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df349d8sm4761135eec.22.2026.06.04.03.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:51:16 -0700 (PDT)
Message-Id: <de9fc5c4556609ed1a8d61ce5207dc1ebcfbfecf.1780570273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 10:51:06 +0000
Subject: [PATCH 1/7] compat/msvc: use _chsize_s for ftruncate
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, `unsigned long` and `long` are 32 bits even on 64-bit
builds. The MSVC compatibility header has shimmed `ftruncate()` with

	#define ftruncate _chsize

ever since `compat/msvc-posix.h` was introduced. `_chsize()` takes a
32-bit `long` for the new length, which silently truncates files (and
the requested size) to 2 GiB. That is enough to make t7508 test 126
"git add fails gracefully with 4 GiB and 8 GiB files" fail under
MSVC: `test-tool truncate` creates a sparse 4 GiB or 8 GiB file via
the shimmed `ftruncate()`, and the test never gets off the ground.

`_chsize_s()` is the modern replacement, accepts a 64-bit `__int64`
length, and is the only sensible target on Windows. The catch is that
it does not follow the POSIX `-1` + `errno` convention: it returns
`0` on success and an errno value (a small positive integer) on
failure. A plain `#define ftruncate _chsize_s` would therefore
silently break callers that test the return value as `< 0` or against
`-1`, of which there are several: `http.c`, `parallel-checkout.c`,
and `t/helper/test-truncate.c` among them.

Introduce a `static inline` wrapper that calls `_chsize_s()`, copies
its errno return into `errno`, and translates the result to the
familiar `-1` / `0` convention, then point `ftruncate` at the
wrapper. Place the wrapper after `#include "mingw-posix.h"` so the
`off_t` parameter resolves to the already-widened `off64_t` rather
than the 32-bit `_off_t` from `compat/vcbuild/include/unistd.h`.

MinGW is unaffected: its `ftruncate()` already takes `off_t` and
routes through `ftruncate64()` when `_FILE_OFFSET_BITS=64`, which is
the default in our build.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc-posix.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/compat/msvc-posix.h b/compat/msvc-posix.h
index c500b8b4aa..7ce39b8d3f 100644
--- a/compat/msvc-posix.h
+++ b/compat/msvc-posix.h
@@ -16,7 +16,6 @@
 #define __attribute__(x)
 #define strcasecmp   _stricmp
 #define strncasecmp  _strnicmp
-#define ftruncate    _chsize
 #define strtoull     _strtoui64
 #define strtoll      _strtoi64
 
@@ -30,4 +29,27 @@ typedef int sigset_t;
 
 #include "mingw-posix.h"
 
+/*
+ * MSVC's `_chsize()` takes a 32-bit `long` and silently truncates files
+ * to 2 GiB. `_chsize_s()` accepts a 64-bit length but returns 0 on
+ * success or an errno value on failure, rather than the -1/errno
+ * convention POSIX `ftruncate()` callers expect. Wrap it so callers
+ * that test the return value as `< 0` or against `-1` keep working.
+ *
+ * Note: this declaration must follow `#include "mingw-posix.h"` so
+ * `off_t` resolves to `off64_t` and the parameter type matches the
+ * underlying `_chsize_s()` width.
+ */
+static inline int msvc_ftruncate(int fd, off_t length)
+{
+	int err = _chsize_s(fd, length);
+
+	if (err) {
+		errno = err;
+		return -1;
+	}
+	return 0;
+}
+#define ftruncate msvc_ftruncate
+
 #endif /* COMPAT_MSVC_POSIX_H */
-- 
gitgitgadget

