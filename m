Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18892F7F0F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524355; cv=none; b=DgWPGWF05JbeLjI7BAd6SteV6icZEkBTRWlVvLdVN0EvJza0V9oBF1OMSBkFyVP08SJVB2yjKlyn3RHe9fb11aDrSljyiyGwPhUY8w9fnJYyEr2MESOSXGmR27/o9ujvc8tRkMNQi7hFyW6k7Mzdg0LDrgBB0209iJ5AshDX7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524355; c=relaxed/simple;
	bh=WnEoVhKdHQ/cE6WTUBWLfIbkKPKNNLfYd2kXKsbH+Os=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gw6fmY+C8GftFvBh5gy3dSPnOKos4lP/VNGX07WmvabRHvQHfSwlWmHUMVT7h8iATLOhBeDMszdId2zXM1og2yuIQKmZ+YaeQDai2lQqSeTO9hJ4fdhPLo+se2DZOTwlM8ofc+HIKQ0Sp9wv2SmhTs0a2dWdc8lCOwFaneM0kiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BConYEVl; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BConYEVl"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51788280e71so37567981cf.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524353; x=1782129153; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5tb55NGXEaGd7UOI8fS5Axn6KcOse7pomwuDp6jXLk=;
        b=BConYEVlptWyirEvtFdZQdieifdj39bnIqyUttZWTnWdYN5Z+27ECxHc/BRkO8W82U
         m71M7bhhAtvQE20gejRB5oBHub3NBBYTpzWDvbi4igx0qusZDKU9Qe7/akahpo7yBZp7
         Bv6YIXTfFDFEZwfgU2+IinmttKwUQWMF3qRuk/A54NiqN3tCOELY46DGkahx5Y1zw6rK
         7BX5Q5wQWGoCYvzcj24+rv4w1eha3pIoiGiNQJXJg+mnJo40dbSJLi3Ka6ADypp7RndI
         1JWVTFuZ1IEkjWJo5ZDc2gC4jmJoQFBoSQAfDUb4AAi8Uf9m0nsF6pRMrS29m8jInEkW
         2CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524353; x=1782129153;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5tb55NGXEaGd7UOI8fS5Axn6KcOse7pomwuDp6jXLk=;
        b=J5A5dGL75qKXXOi+dF0R8XPZ+rpPgQ/4E1OejdQWN6c/7CAV8AosbqvURbd6+nsSmV
         +BLeBWufrtddikAdCexPpw89f4F244/BbGtc5Nj1u6g8XdjxzYRfRl9UYP+7wKVzSeXR
         Gms1+pmPVQDWQ4shGuWKb3912OgFlXkaygNwSnHR43PA/NM2pS+znUTpcxGZXF05+Cmt
         CDYBaaSsc0ERDUXgOtKCks/lWybdkWoDc56Sda8D4AJYPUPXu/IDlhv32UUTj04JXP5C
         ZmWDOoi1oqV1Tuh6HFobg5Pd1GdTNBCBtpjZIPS4NL3wCOT4a4oxZo8t63mfkQy0PrRk
         Pwnw==
X-Gm-Message-State: AOJu0YyZlsYmvH+e6cSsVPR6L2i4r4SKj4jY/IM0tw6c/oqZQdKmFv93
	giRkESo8wXxVtdF5YsCwwnoE/2xdZZ0+OexMiqldpxQwWHAzEbEyCZIA2VmQpQ==
X-Gm-Gg: Acq92OGT6V/OBtR2Fgfhu4nBnkSirzF5HhkRS6IdS8LTk2l0mjUkURGsNIAejkKJ9Qv
	5Be6xOBXvtVv4/pvkhijPPDzd9CEI3xnMzG+gFnRKhpujSjSOXeVJX39vOUI8xf1iN0U/4HB2ta
	T1Pm/fxepDjeepf/HamrYjfMqgsB8eaoAX+mCD7NZYN+eG6piYLuj9eFhMQ7Oiz2KwqFztJbCUU
	e3za6zAXWliAEch0p/6GclrlUqSQT7obsDAgD+psitzcwQ2NmZfRN/FMY0HoGAzJZ2C5cmu6ofb
	6wB5jlmMKg9N/sbdGAt5wnDBAI8Yr4yO9vgdjL5UCL33gnQeJoO5mhVdITZygR4Lmw4eT+DjSfZ
	UYuoFfjzCzrda8BoD1rs+U0vg1zM8FzOEJuWcClAwvhR551TfEYZSodCUwZyw5cnuaOVaZuHhlx
	ZDuqjKopP3ospoMecW/4OtjTpnu8w=
X-Received: by 2002:a05:622a:17c3:b0:517:884d:3801 with SMTP id d75a77b69052e-517fe44f7d1mr203603311cf.25.1781524352921;
        Mon, 15 Jun 2026 04:52:32 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb84188asm113099761cf.29.2026.06.15.04.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:52:32 -0700 (PDT)
Message-Id: <531bca775cf395dfc7547483722156e16a6ed987.1781524349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 11:52:23 +0000
Subject: [PATCH v2 1/7] compat/msvc: use _chsize_s for ftruncate
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
    Patrick Steinhardt <ps@pks.im>,
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

