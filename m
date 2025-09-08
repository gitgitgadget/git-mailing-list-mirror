Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AA30C632
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340173; cv=pass; b=OEJhW9EGZU/EamAeW5dDg4QM71yaoGS4MMcS4xW1o0BdMUnGtSDtleRDylEoq3ZDAo0FolZnP/abtadz4O3NsTSvdEdlWz/SDRUzlFS0R9bRqhZk4x5iZoTISVAkNeXu1YHGPA9Y3wiXNF/pllDYSAlBfyuFQTKVDQkO6rT44xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340173; c=relaxed/simple;
	bh=IBVouNftop4IwdKy5X4V9/ddwb5cSvYn93M5O/SrJNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQSrd6cjslzDp7Pc1srYyoPSv89k8LPrV0/ofYATg2CJ2Lo9cfchJjtYYqZVH4gkUHNOaIXiy8om3pd/O4tPQYuZKwWhL+FNM+QPIFPtEzzz5jM+8yWkNlyabYJYl5rI+/1InbmgbrLOOesay+aV2OnZkNXJsoneCCCcEMhTdZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=P7VLHzkD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="P7VLHzkD"
ARC-Seal: i=1; a=rsa-sha256; t=1757340147; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gf9rH3mKOMWH5BUVoJBN4XIEQ0NH5X81Dok0+Qc/WhLZEmI643boa3eJTZLNxShM3mlD5NF51AYSWb1EzagAKPw6rRQcNY40hP5OZRAEJd0XpPWqYT3Aj4UFkOiA/kF0TvhLIj0IKxv7u9+qLafrexYCT+UYr8lIMdLDoMuSa64=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340147; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=89I61hbathWPuXzLWIqxe78wL3Cp1nE9zXdVKVbl06s=; 
	b=IJzxcKXBqfmar57DNveiAnjDjU+94and6wSkCttuOjAYQgH8d8G43XM7H9m+nBTJz0AtMI1EQmXLIcvWbvqraTtuWwKM6e5b9F0+sU1yyYAIkXLTKpKPYnEoroCmYuTcAffnbngCITYfp27oxZYL5bzoUQPIGo+rCgN6SBwJI8s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340147;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=89I61hbathWPuXzLWIqxe78wL3Cp1nE9zXdVKVbl06s=;
	b=P7VLHzkD1iKZdqeqQHsRMhwg/Vz/RRrAnGhCx1HdVEBKKUtrD1O4B1so+Z2Mzg3B
	12OkjAUzCsXmwBxmwN8BvAWaXHtieZgVmD1sdYmeB9mYI3FEbKeJuend2/qph4wEYaK
	E2nXWarJujBm39n4odSGM+489k0yKqOhQMiDgDE8=
Received: by mx.zohomail.com with SMTPS id 1757340143490740.6059786250702;
	Mon, 8 Sep 2025 07:02:23 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 07/10] submodule: error out if gitdir name is too long
Date: Mon,  8 Sep 2025 17:01:14 +0300
Message-ID: <20250908140117.262205-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Encoding submodule names increases their name size, so there is an
increased risk to hit the max filename length in the gitdir path.
(the likelihood is still rather small, so it's an acceptable risk)

This gitdir file-name-too-long corner case can be be addressed in
multiple ways, including sharding or trimming, however for now, just
add the portable logic (suggested by Peff) to detect the corner case
then error out to avoid comitting to a specific policy (or policies).

In the future, instead of throwing an error (which we do now anyway
without submodule encoding), we could maybe let the user specify via
configs how to address this case, eg pick trimming or sharding.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Makefile          |  5 +++++
 compat/pathconf.c | 10 ++++++++++
 compat/posix.h    |  8 ++++++++
 config.mak.uname  |  2 ++
 meson.build       |  1 +
 submodule.c       | 14 ++++++++++++++
 6 files changed, 40 insertions(+)
 create mode 100644 compat/pathconf.c

diff --git a/Makefile b/Makefile
index 555b7f4dc3..1a98eac8a5 100644
--- a/Makefile
+++ b/Makefile
@@ -2212,6 +2212,11 @@ ifndef HAVE_PLATFORM_PROCINFO
 	COMPAT_OBJS += compat/stub/procinfo.o
 endif
 
+ifdef NO_PATHCONF
+	COMPAT_CFLAGS += -DNO_PATHCONF
+	COMPAT_OBJS += compat/pathconf.o
+endif
+
 ifdef RUNTIME_PREFIX
 
         ifdef HAVE_BSD_KERN_PROC_SYSCTL
diff --git a/compat/pathconf.c b/compat/pathconf.c
new file mode 100644
index 0000000000..37500cfa0d
--- /dev/null
+++ b/compat/pathconf.c
@@ -0,0 +1,10 @@
+#include "git-compat-util.h"
+
+/*
+ * Minimal stub for platforms without pathconf() (e.g. Windows),
+ * to fall back to NAME_MAX from limits.h or compat/posix.h.
+ */
+long git_pathconf(const char *path UNUSED, int name UNUSED)
+{
+	return -1;
+}
diff --git a/compat/posix.h b/compat/posix.h
index 067a00f33b..aa050fd58c 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -250,6 +250,14 @@ char *gitdirname(char *);
 #define NAME_MAX 255
 #endif
 
+#ifdef NO_PATHCONF
+#ifndef _PC_NAME_MAX
+#define _PC_NAME_MAX 1 /* dummy value, only used for git_pathconf */
+#endif
+#define pathconf(a,b) git_pathconf(a,b)
+long git_pathconf(const char *path, int name);
+#endif
+
 typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..49ba3de39d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -473,6 +473,7 @@ ifeq ($(uname_S),Windows)
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
+	NO_PATHCONF = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
 	NO_SETENV = YesPlease
@@ -688,6 +689,7 @@ ifeq ($(uname_S),MINGW)
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
+	NO_PATHCONF = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_SETENV = YesPlease
 	NO_STRCASESTR = YesPlease
diff --git a/meson.build b/meson.build
index e8ec0eca16..1fb9300ab1 100644
--- a/meson.build
+++ b/meson.build
@@ -1393,6 +1393,7 @@ checkfuncs = {
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
+  'pathconf' : ['pathconf.c'],
 }
 
 if host_machine.system() == 'windows'
diff --git a/submodule.c b/submodule.c
index 8e0fd077db..016509806e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2641,5 +2641,19 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	strbuf_release(&tmp);
 	strbuf_addbuf(buf, &encoded_sub_name);
 
+	/* Ensure final path length is below NAME_MAX after encoding */
+	name_max = pathconf(buf->buf, _PC_NAME_MAX);
+	if (name_max == -1)
+		name_max = NAME_MAX;
+
+	encoded_len = buf->len - base_len;
+	if (encoded_len > name_max)
+		/*
+		 * TODO: make this smarter; instead of erroring out, maybe we could trim or
+		 * shard the gitdir names to make them fit under NAME_MAX.
+		 */
+		die(_("encoded submodule name '%s' is too long (%"PRIuMAX" bytes, limit %"PRIuMAX")"),
+		    encoded_sub_name.buf, (uintmax_t)encoded_len, (uintmax_t)name_max);
+
 	strbuf_release(&encoded_sub_name);
 }
-- 
2.51.GIT

