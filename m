Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8792989B3
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363802; cv=none; b=XXRIzP8XKoMvZqHWu7EjNHtIepCeaAEWrKkIlobUfMUUxQxt1j95NQNl7660DGlh89AOy2aTEP4IPwHnRxK82RkNlShzr1MONUcsKIrYvMng/VW7zFycSmv0RFBU2VDSEyNKL6aJqFU8Gx1KpBg6GnjdwcTeLAoh5OPP2rB6yvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363802; c=relaxed/simple;
	bh=UxE8qaTOLSa4tKf2nQL+129sw1Tp0uzIXgHyI+/jY+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IEv53/MXGCuhgMSd5JZuQOQPX+QdJk4XPjJy0jVrWcS5myGJviar1DV9X1JY00KKEWwabhnvlCW4Yzzak3UPiWfnwbAv3+LrmCPTENKVICEPYi1HZhF8dMaWJKyyZrpGJeqXGsux/Fs3jQ5chTT//3PnNHZksYFAB9wRXMXvoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oe6rP57p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iR1Xu2+R; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oe6rP57p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iR1Xu2+R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6916F1140292;
	Fri, 11 Apr 2025 05:29:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Apr 2025 05:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363799;
	 x=1744450199; bh=mbK+E4y+E1Lu30glC3aXJ3TxCcrfk84u/FYA4U7f2K8=; b=
	oe6rP57p0JzZlhgXX0JSJm7TzS9xl6HSJSVddvNXWq2WJ15ql6pfLhQk/ghNmyWL
	3E6pgClXpmT8H7fnaUOUte1XCN0mVtwStf8EBsODpihVXATiq7s7YURVcnuQfUbA
	N+VI7apUE2ReWYZScB1b7m7oBZyuAn7gWxChecfZuO7ds6nAbjhspAP8J29xNki5
	0/NliNhmI33pNBfQC+JjLshb1wV8m80/yrmvbnIzLb/Wrn4ObvJlxT+OHLxVd4xv
	j4UYurnYaMRYOrrONFyqlPCtBlMgnIYWgYkXoSQL5ViglU6v9CfpfDIWiyZjBYJF
	U9WwpHkfTyJKkg0uo8xxjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363799; x=
	1744450199; bh=mbK+E4y+E1Lu30glC3aXJ3TxCcrfk84u/FYA4U7f2K8=; b=i
	R1Xu2+R23JLKzU6mAPNolgv79T0+FpGwnrAAWuXTF3Tj5eEgh33F1RxeV1smZ/s2
	AlSTfA/u8MXbH1sg970Lwdf9C8FZN9GICCzzp22fAqxZ9JaXS7exaVscpCKdom/G
	e/ysb2H0uRpHVO5Tu5uPyZEq45CSyfnvvYM1H7T5fhiU+WMJ3MNH+ZG8q8CDxVf+
	+mAGuifzmraG75Wnhw3Wdby5QOFRGHRBrrduN8caa8SWZyGL7N6oRMIm2I5MoTn5
	uNCN5mLNaKpYTq92KdSZotc1t4scoy02UjUHois01/YgQ4M12U68RcTDshwccZK0
	Xqa4iVaS8M25mtm+qqQQg==
X-ME-Sender: <xms:F-H4Z7XI5dzclajk3osqY9_wIZmzSvFiD7Nrf9Uneq3vRxOJMJrgSg>
    <xme:F-H4Zzkv-8TwVfpGiNBIelRl0rcfA8wQIIuT1MApdlrfz7ff7n-sHvl7fsNyb9Vyq
    VL7czrJweGbXxXGPA>
X-ME-Received: <xmr:F-H4Z3apTHngNWma1m-81AZGlZ6z6xkp6r9_2KBJ7-j9mEqnkdkN-U1mWGI57hM4OFP5HbiBMM958Oa4hRR0SwReRtsPgRviQUThA1K9f8wyubQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:F-H4Z2WXj1dO6G34VA6bSLwiY4EgCQvcoclNtw-ZG9s5b7NZLTz8hw>
    <xmx:F-H4Z1n4h60txW1Iguaj_ylt0mA6g4ZgDNhH2WcbUg2wevEVgZI0_Q>
    <xmx:F-H4ZzdQ96xflkz6VthYUMeO5moEyYxHVfUjX1EA8rMCgCWB318O5Q>
    <xmx:F-H4Z_EisO5qn_x-Cx8chWdp5NZqadHlwzzOlInuLkoOgxyP2JypLA>
    <xmx:F-H4ZzR8C5ZhlfDJNM8-rT0bgQfSi2nJe-FmI2CbqiyL5zMn63W0hQ43>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:29:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60c01abb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:29:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Apr 2025 11:29:51 +0200
Subject: [PATCH v2 2/9] object-file: move `git_open_cloexec()` to
 "compat/open.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-pks-split-object-file-v2-2-2bea0c9033ae@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
In-Reply-To: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `git_open_cloexec()` wrapper function provides the ability to open a
file with `O_CLOEXEC` in a platform-agnostic way. This function is
provided by "object-file.c" even though it is not specific to the object
subsystem at all.

Move the file into "compat/open.c". This file already exists before this
commit, but has only been compiled conditionally depending on whether or
not open(3p) may return EINTR. With this change we now unconditionally
compile the object, but wrap `git_open_with_retry()` in an ifdef.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile          |  2 +-
 commit-graph.c    |  1 -
 compat/open.c     | 29 +++++++++++++++++++++++++++++
 git-compat-util.h |  3 +++
 meson.build       |  1 +
 midx.c            |  1 -
 object-file.c     | 27 ---------------------------
 object-file.h     |  3 ---
 pack-bitmap.c     |  1 -
 pack-mtimes.c     |  1 -
 pack-revindex.c   |  1 -
 11 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/Makefile b/Makefile
index c41fc41ef0e..bb5407b4703 100644
--- a/Makefile
+++ b/Makefile
@@ -994,6 +994,7 @@ LIB_OBJS += common-exit.o
 LIB_OBJS += common-init.o
 LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
+LIB_OBJS += compat/open.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += compiler-tricks/not-constant.o
 LIB_OBJS += config.o
@@ -1812,7 +1813,6 @@ ifdef FREAD_READS_DIRECTORIES
 endif
 ifdef OPEN_RETURNS_EINTR
 	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
-	COMPAT_OBJS += compat/open.o
 endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
diff --git a/commit-graph.c b/commit-graph.c
index 3fae20dc21b..8060c358b84 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -14,7 +14,6 @@
 #include "refs.h"
 #include "hash-lookup.h"
 #include "commit-graph.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "oid-array.h"
 #include "path.h"
diff --git a/compat/open.c b/compat/open.c
index eb3754a23b8..37ae2b1aeb9 100644
--- a/compat/open.c
+++ b/compat/open.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 
+#ifdef OPEN_RETURNS_EINTR
 #undef open
 int git_open_with_retry(const char *path, int flags, ...)
 {
@@ -23,3 +24,31 @@ int git_open_with_retry(const char *path, int flags, ...)
 
 	return ret;
 }
+#endif
+
+int git_open_cloexec(const char *name, int flags)
+{
+	int fd;
+	static int o_cloexec = O_CLOEXEC;
+
+	fd = open(name, flags | o_cloexec);
+	if ((o_cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		o_cloexec &= ~O_CLOEXEC;
+		fd = open(name, flags | o_cloexec);
+	}
+
+#if defined(F_GETFD) && defined(F_SETFD) && defined(FD_CLOEXEC)
+	{
+		static int fd_cloexec = FD_CLOEXEC;
+
+		if (!o_cloexec && 0 <= fd && fd_cloexec) {
+			/* Opened w/o O_CLOEXEC?  try with fcntl(2) to add it */
+			int flags = fcntl(fd, F_GETFD);
+			if (fcntl(fd, F_SETFD, flags | fd_cloexec))
+				fd_cloexec = 0;
+		}
+	}
+#endif
+	return fd;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index cf733b38acd..9273a8ee087 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1000,6 +1000,9 @@ int git_vsnprintf(char *str, size_t maxsize,
 int git_open_with_retry(const char *path, int flag, ...);
 #endif
 
+int git_open_cloexec(const char *name, int flags);
+#define git_open(name) git_open_cloexec(name, O_RDONLY)
+
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
diff --git a/meson.build b/meson.build
index 145d2f7ff9e..a55e800b85b 100644
--- a/meson.build
+++ b/meson.build
@@ -263,6 +263,7 @@ libgit_sources = [
   'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
+  'compat/open.c',
   'compat/terminal.c',
   'compiler-tricks/not-constant.c',
   'config.c',
diff --git a/midx.c b/midx.c
index 807fdf72f7b..3d0015f7828 100644
--- a/midx.c
+++ b/midx.c
@@ -5,7 +5,6 @@
 #include "dir.h"
 #include "hex.h"
 #include "packfile.h"
-#include "object-file.h"
 #include "hash-lookup.h"
 #include "midx.h"
 #include "progress.h"
diff --git a/object-file.c b/object-file.c
index 23b2c8560be..1a20c7fa072 100644
--- a/object-file.c
+++ b/object-file.c
@@ -834,33 +834,6 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
-int git_open_cloexec(const char *name, int flags)
-{
-	int fd;
-	static int o_cloexec = O_CLOEXEC;
-
-	fd = open(name, flags | o_cloexec);
-	if ((o_cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
-		/* Try again w/o O_CLOEXEC: the kernel might not support it */
-		o_cloexec &= ~O_CLOEXEC;
-		fd = open(name, flags | o_cloexec);
-	}
-
-#if defined(F_GETFD) && defined(F_SETFD) && defined(FD_CLOEXEC)
-	{
-		static int fd_cloexec = FD_CLOEXEC;
-
-		if (!o_cloexec && 0 <= fd && fd_cloexec) {
-			/* Opened w/o O_CLOEXEC?  try with fcntl(2) to add it */
-			int flags = fcntl(fd, F_GETFD);
-			if (fcntl(fd, F_SETFD, flags | fd_cloexec))
-				fd_cloexec = 0;
-		}
-	}
-#endif
-	return fd;
-}
-
 /*
  * Find "oid" as a loose object in the local repository or in an alternate.
  * Returns 0 on success, negative on failure.
diff --git a/object-file.h b/object-file.h
index 922f2bba8c9..353d8a85c33 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,9 +21,6 @@ extern int fetch_if_missing;
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-int git_open_cloexec(const char *name, int flags);
-#define git_open(name) git_open_cloexec(name, O_RDONLY)
-
 /**
  * unpack_loose_header() initializes the data stream needed to unpack
  * a loose object header.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7fd78c634ef..0dbd7c4ffe1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -17,7 +17,6 @@
 #include "packfile.h"
 #include "repository.h"
 #include "trace2.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "list-objects-filter-options.h"
 #include "midx.h"
diff --git a/pack-mtimes.c b/pack-mtimes.c
index cdf30b8d2b0..bcea28e521d 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-mtimes.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "packfile.h"
 #include "strbuf.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index 038e0c96b1c..1ee7b49e206 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "packfile.h"
 #include "strbuf.h"

-- 
2.49.0.777.g153de2bbd5.dirty

