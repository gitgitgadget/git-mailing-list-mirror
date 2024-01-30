Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758956479
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650625; cv=none; b=uYz6UytiIRWldSpv0Cy4s+b5x5KJ4Dc9wUpGk2YnX4tqv1aa7sx3/fw5MzhgsnlUSoe3ieK6OajBACE237pwV1EefFJabcakiBPahVVhw/jRs34ba3lYk3WbMfpBGQjPiH2GqjdT+6tQ4KMaIN5u9Cv5x3MEKso8f1Woaq5w4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650625; c=relaxed/simple;
	bh=+EusjhJuuB52CpiW6FISiQRxTe8uaNsZB8zgO/ACWZA=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SAYvD5BTwwySekYa7mJur9SJ0jtAE00SZ30QxGsVA6isOyPPWAinMwLOb3hyA4Bcp+jD0Qf04LUmg3KMNsxPO8lATTt6x2k5XWG/jS23sOHRKUP/trG82NK5Uc0t+hkNyaS2GHphezUAMPKsu7WWkmITxUyO+8pdm1MT8CWxhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfZxEA7C; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfZxEA7C"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so9373775e9.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 13:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706650621; x=1707255421; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bTBEGy0zwma2XzbYUh45aDpDjOp6aAXckwVBl7Q5ubo=;
        b=bfZxEA7CWWCj2Ugn49Qj9i8iZIB7PMUSsIt/4uSImwUFYCzVsNSUhl3pU3SALnlPeN
         IEIFPldwEoP8J94zrMl3dhbFh/ihGOjNGExdSHTFqiG2Z1t+ZIFqvZu1Ua0PaYHKLLC6
         8HVgemYjuHvNBT4XIooQCB5DJQZB8igwAR2UqfavwlD5QbinFHBvtNVW27pVHmpewUOe
         vVxo266TavufQZAmKbwZhDbBGIc16A10D3WBvDpriLWX9TIPT3b5ycS0WR7MDFFcbPBJ
         9fAysZhw2MLCDAE8TmmFAr25y4fvuXegfAI0obl9bB1weTnlladuTYakkkHmL98YzUGt
         ewFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706650621; x=1707255421;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTBEGy0zwma2XzbYUh45aDpDjOp6aAXckwVBl7Q5ubo=;
        b=DhBJeFOAov2m8cXg4Uppf8919D0SYpmfsPsF4s+WMEtnqfyOjLDPFHnEuRXeUNxAKX
         Yozz09YymNaHxSnYvntIa+Ehek8iIsnl8Vc4knwtnAR8SCV+xbh6uSywyFpkqxlHVdVh
         sQWd3JUWWPduCnNBljx0rellUhuIOQhldUSc7wRdfOnZs/H6NQjiX4mM+oFIsIG24Jys
         TZBwTHTiWd9JQNvrWNup5eY/O3KC9uIN/Izqg9GlyMl0csmuUVXVYSzkX355oVYFvnXq
         7pgXacpoIYKVMdczNf1/eKNw7skqOymEBZwbaqs5H1ZvSNqx2aHghwj6PsOa5u/6n7NS
         HJ9w==
X-Gm-Message-State: AOJu0YxIVJPp88TLZte++EYb9/xrSalXWQocA+88uXNgeG9wYdqMarfx
	U9UgjxWnALcinFF1H+AwTZZwk09Dwa22n0HpKjL5b9szMB0yS1WS1OOiem4p
X-Google-Smtp-Source: AGHT+IHqhfT2M5BkDz394YXs9ex4I1GJDnp6qqCAD6fV90q0+Md5ozip5SlJPpBae2FsBDQKXi5jhg==
X-Received: by 2002:a05:600c:1907:b0:40f:afd2:61c9 with SMTP id j7-20020a05600c190700b0040fafd261c9mr1306451wmq.0.1706650620757;
        Tue, 30 Jan 2024 13:37:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b0040fb30f17e8sm326305wmb.38.2024.01.30.13.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:37:00 -0800 (PST)
Message-ID: <pull.1648.git.1706650619950.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Jan 2024 21:36:59 +0000
Subject: [PATCH] win32: special-case `ENOSPC` when writing to a pipe
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since c6d3cce6f3c4 (pipe_command(): handle ENOSPC when writing to a
pipe, 2022-08-17), one `write()` call that results in an `errno` value
`ENOSPC` (which typically indicates out of disk space, which makes
little sense in the context of a pipe) is treated the same as `EAGAIN`.

However, contrary to expectations, as diagnosed in
https://github.com/python/cpython/issues/101881#issuecomment-1428667015,
when writing to a non-blocking pipe on Windows, an `errno` value of
`ENOSPC` means something else: the write _fails_. Completely. Because
more data was provided than the internal pipe buffer can handle.
Somewhat surprising, considering that `write()` is allowed to write less
than the specified amount, e.g. by writing only as much as fits in that
buffer. But it doesn't, it writes no byte at all in that instance.

Let's handle this by manually detecting when an `ENOSPC` indicates that
a pipe's buffer is smaller than what needs to be written, and re-try
using the pipe's buffer size as `size` parameter.

It would be plausible to try writing the entire buffer in a loop,
feeding pipe buffer-sized chunks, but experiments show that trying to
write more than one buffer-sized chunk right after that will immediately
fail because the buffer is unlikely to be drained as fast as `write()`
could write again. And the whole point of a non-blocking pipe is to be
non-blocking.

Which means that the logic that determines the pipe's buffer size
unfortunately has to be run potentially many times when writing large
amounts of data to a non-blocking pipe, as there is no elegant way to
cache that information between `write()` calls. It's the best we can do,
though, so it has to be good enough.

This fix is required to let t3701.60 (handle very large filtered diff)
pass with the MSYS2 runtime provided by the MSYS2 project: Without this
patch, the failed write would result in an infinite loop. This patch is
not required with Git for Windows' variant of the MSYS2 runtime only
because Git for Windows added an ugly work-around specifically to avoid
a hang in that test case.

The diff is slightly chatty because it extends an already-existing
conditional that special-cases a _different_ `errno` value for pipes,
and because this patch needs to account for the fact that
`_get_osfhandle()` potentially overwrites `errno`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    win32: special-case ENOSPC when writing to a pipe
    
    This is part of my (slow, after-hours) effort to chip away at the
    deviations between Git for Windows' variant of the MSYS2 runtime and
    MSYS2's variant.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1648%2Fdscho%2Fwin32-pipe-enospc-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1648/dscho/win32-pipe-enospc-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1648

 compat/mingw.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 238a84ddbaa..320fb99a90e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -707,13 +707,24 @@ ssize_t mingw_write(int fd, const void *buf, size_t len)
 {
 	ssize_t result = write(fd, buf, len);
 
-	if (result < 0 && errno == EINVAL && buf) {
+	if (result < 0 && (errno == EINVAL || errno == ENOSPC) && buf) {
+		int orig = errno;
+
 		/* check if fd is a pipe */
 		HANDLE h = (HANDLE) _get_osfhandle(fd);
-		if (GetFileType(h) == FILE_TYPE_PIPE)
+		if (GetFileType(h) != FILE_TYPE_PIPE)
+			errno = orig;
+		else if (orig == EINVAL)
 			errno = EPIPE;
-		else
-			errno = EINVAL;
+		else {
+			DWORD buf_size;
+
+			if (!GetNamedPipeInfo(h, NULL, NULL, &buf_size, NULL))
+				buf_size = 4096;
+			if (len > buf_size)
+				return write(fd, buf, buf_size);
+			errno = orig;
+		}
 	}
 
 	return result;

base-commit: c5b454771e6b086f60c7f1f139025f174bcedac9
-- 
gitgitgadget
