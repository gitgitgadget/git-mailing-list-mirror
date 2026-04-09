Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB4346E7E
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767909; cv=none; b=fDHnUkC3XxdnrdY89tfaHA+I9c3fXwXdRALthBDWbVL8CTV8Qy/K1TpBphKJQkwDwV/K/z+0PizyWKZPhP4mwemV+oiDcxkNUC04svd7SRcWo2WUy3CVjPbkehAnlyECupk01+DJmx2bjmxrLFiaONtGEhZ5NTlndbmTwJghK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767909; c=relaxed/simple;
	bh=1MkMnsxAAZ4/gEeIA3m0tIPkbBGh0kXe8mIoLZED15Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiGUb4Yv7mQwxj/JYUh+2MiYseuRQxxZex+XJcRthkTodEuri6xZ+QCAAnhygrL9xiIYT95tGImquZ2I24AxBD4KQML4NOnBgdzyXkaqXvuwXW4GRhqmHc0qpWxeJ9GfIIDLLyZaATq7B/RTT2XvYBhaGQa1Cv5BIc7ADwjeSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dekR/ulZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dekR/ulZ"
Received: (qmail 295013 invoked by uid 106); 9 Apr 2026 20:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1MkMnsxAAZ4/gEeIA3m0tIPkbBGh0kXe8mIoLZED15Y=; b=dekR/ulZ6e41S85uVqcZblBdeITFe5C3kRzskQfuIv1dNdO4UHZ2pK/W6AhkoqMwS0V9pLdjk4QjGRROYlT31HVvS1DRAvfMWMrJOLM1kw1XT7/iXsKLIX8ZRKKr9VpMtHjy6ff648s/3Ot4m9nfrn/0d4iVoVgB8f0NRERQIMbXIGDZ7a0W1CbbEjnbUhTO6d09g7u5km1tFNfAqyYK5SES0lFqc7lQ3AwXdEEcS0tLTHVo/2lt+XYMICTOHFd8OZpkSXni/MRAByfnZshVq9rvmVgAD/gaLS9b2dp4LMw/TP9es8dP28NjIFhfsUgQXnWrlU8Nq51xrAnROn7OfQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Apr 2026 20:51:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 487650 invoked by uid 111); 9 Apr 2026 20:51:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2026 16:51:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Apr 2026 16:51:45 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <20260409205145.GC3076846@coredump.intra.peff.net>
References: <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
 <20260408173949.GB2850002@coredump.intra.peff.net>
 <xmqq4illz5g9.fsf@gitster.g>
 <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g>
 <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
 <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net>
 <addgkjiB80pgKw69@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <addgkjiB80pgKw69@pks.im>

On Thu, Apr 09, 2026 at 10:17:22AM +0200, Patrick Steinhardt wrote:

> > that people should be able to send.  I'd personally expect to be able to
> > send values much larger, at least 512 KiB, and I have code that expects
> > even larger (16 MiB).
> > 
> > So I'd simply say that for systems that have a constraint on the size
> > that is "too small", they should just use NO_WRITEV.
> 
> I would be happy with this as an intermediate step, as Randall has
> confirmed it would fix the issue. It is the least intrusive step and has
> the lowest risk.

The only downside is that if there are other systems with a small
SSIZE_MAX, they'll need similar treatment.

I took a look at auto-detecting this at the preprocessor stage. The
conditional itself is not too bad, but we have to compile writev.o
unconditionally, as well as re-order some definitions:

diff --git a/Makefile b/Makefile
index 5d22394c2e..f9b4dd8ae3 100644
--- a/Makefile
+++ b/Makefile
@@ -1125,6 +1125,7 @@ LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/open.o
 LIB_OBJS += compat/terminal.o
+LIB_OBJS += compat/writev.o
 LIB_OBJS += compiler-tricks/not-constant.o
 LIB_OBJS += config.o
 LIB_OBJS += connect.o
@@ -2031,7 +2032,6 @@ ifdef NO_PREAD
 endif
 ifdef NO_WRITEV
 	COMPAT_CFLAGS += -DNO_WRITEV
-	COMPAT_OBJS += compat/writev.o
 endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
diff --git a/compat/posix.h b/compat/posix.h
index 94699a03fa..57c11938c7 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -326,6 +326,39 @@ int git_lstat(const char *, struct stat *);
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
 
+/*
+ * Limit size of IO chunks, because huge chunks only cause pain.  OS X
+ * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
+ * the absence of bugs, large chunks can result in bad latencies when
+ * you decide to kill the process.
+ *
+ * We pick 8 MiB as our default, but if the platform defines SSIZE_MAX
+ * that is smaller than that, clip it to SSIZE_MAX, as a call to
+ * read(2) or write(2) larger than that is allowed to fail.  As the last
+ * resort, we allow a port to pass via CFLAGS e.g. "-DMAX_IO_SIZE=value"
+ * to override this, if the definition of SSIZE_MAX given by the platform
+ * is broken.
+ */
+#ifndef MAX_IO_SIZE
+# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
+# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
+#  define MAX_IO_SIZE SSIZE_MAX
+# else
+#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
+# endif
+#endif
+
+/*
+ * Temporary hack: our use of writev() does not respect MAX_IO_SIZE, but we
+ * never feed more than a single pkt-line packet to it. Disable writev()
+ * and use our fallback wrapper if the system can't support that size.
+ *
+ * This should be removed once writev() supports MAX_IO_SIZE.
+ */
+#if !defined(NO_WRITEV) && (MAX_IO_SIZE < 65536)
+#define NO_WRITEV
+#endif
+
 #ifdef NO_WRITEV
 #define writev git_writev
 #define iovec git_iovec
diff --git a/git-compat-util.h b/git-compat-util.h
index 4b4ea2498f..60108459f3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -677,28 +677,6 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
 	return a + b;
 }
 
-/*
- * Limit size of IO chunks, because huge chunks only cause pain.  OS X
- * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
- * the absence of bugs, large chunks can result in bad latencies when
- * you decide to kill the process.
- *
- * We pick 8 MiB as our default, but if the platform defines SSIZE_MAX
- * that is smaller than that, clip it to SSIZE_MAX, as a call to
- * read(2) or write(2) larger than that is allowed to fail.  As the last
- * resort, we allow a port to pass via CFLAGS e.g. "-DMAX_IO_SIZE=value"
- * to override this, if the definition of SSIZE_MAX given by the platform
- * is broken.
- */
-#ifndef MAX_IO_SIZE
-# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
-# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
-#  define MAX_IO_SIZE SSIZE_MAX
-# else
-#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
-# endif
-#endif
-
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))


It's not _too_ complicated, but it's a little more than I'd like for an
-rc2. Yet another option is to swap out NO_WRITEV for USE_WRITEV,
effectively reverting the feature temporarily until it supports
MAX_IO_SIZE. But that's also slightly non-trivial.

So I dunno. Do we want just:

diff --git a/config.mak.uname b/config.mak.uname
index ccb3f71881..b672b1d077 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -654,6 +654,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	CSPRNG_METHOD = openssl
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
+	NO_WRITEV = NotUntilItSupportsMaxIOSize
 endif
 ifeq ($(uname_S),OS/390)
 	NO_SYS_POLL_H = YesPlease

and hope it's the only one?

-Peff
