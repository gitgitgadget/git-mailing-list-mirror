Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAD26C3A2
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749980; cv=pass; b=AfV9TUIAKk9THmr7IXmRIh7CHSnMUvP6mOJkmmWxtGX4Q53c2rzfuLKKWaE23732zFko0iWK2Hz+YH2nth8gf/FI8wQiqgZwq+HvM2I6YigsFpjfx/0lPguIwVjuo1fmOnS+P1PwPNfMwi7d9vEOW7oeAvo8Cwpoe6eDAPg/vjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749980; c=relaxed/simple;
	bh=+/VdRlG0u8micAcjfMpksJ5GCMW1a6NHsus39dSytrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GedTrSvSYjy+Vl+SfI+vlyWfM+YtTw6zcaTRS67FSBCsEWe0oiS58M+tlC4I2WVLiUnvKrEEG4BP23S6xLS3IhHRqgHM6Hmr63mtSj5SVTkSUH7SeCoFaD8buRvYTanH5cz01v4FViXusJnOxgMVuran44UjMrg/69C6WyrsdPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=A15jhU6R; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="A15jhU6R"
ARC-Seal: i=1; a=rsa-sha256; t=1759749962; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AObG7Oj9E0mOVb42/XsM77bTh0wrordF2NdB9EJJgBADBrGjM4egL9yyrdlfvM7n3/xxokGYrYOjwY2QxDu9Vvqi8ChZJW8Ce5IvJ3KJXwxXETvr3Lv2oem7yy91cjz4h3DtRHBTa1WJPhuR+if+yRKBRrNi4TPrddfHNhL72uA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759749962; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fzWzAaO/7DK0VUs1ilAzp2rNNNMVXhNYDPMGckB2DDs=; 
	b=CY+HAUn3UUqvy91BEOI6Q7PesNAPGdgA8m4TgoqsrXOT92qrNIa3SwH4G7ZoR0EfhMfM/O+jFSj0dfLkRYsi56pn5h2CU94mxJfKOi2zalaqubzw57ru+DR+e/Jg5ugOZd9dUv7WQanBX1uA1BYFahbN/GjD3dVZ2xel7ZCHU6k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759749962;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fzWzAaO/7DK0VUs1ilAzp2rNNNMVXhNYDPMGckB2DDs=;
	b=A15jhU6Rt7oL08mTdhxiMIpG4wjMh2Qb+bAU0jHKSvjz6D0T0YRX6zJkOTYmWe95
	Hk2yEDofh+2MLVRCIjrALSUenw9ygJQmzMcWHAWaRxnoJnZG2dgzj3sjIe4kW2NcieT
	IgM8uRNQ68qvLL/GK53rpiBDnIUGHHorSRTWp7ng=
Received: by mx.zohomail.com with SMTPS id 17597499591251007.7335597721541;
	Mon, 6 Oct 2025 04:25:59 -0700 (PDT)
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
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 5/5] submodule: error out if gitdir name is too long
Date: Mon,  6 Oct 2025 14:25:18 +0300
Message-ID: <20251006112518.3764240-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251006112518.3764240-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
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
then error out to avoid committing to a specific policy (or policies).

In the future, instead of throwing an error (which we do now anyway
without submodule encoding), we could maybe let the user specify via
configs how to address this case, e.g. pick trimming or sharding.

At least now we print a nice error instead of the OS defaults which
can be rather cryptic for users.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Makefile                      |  5 +++++
 compat/pathconf.c             | 10 ++++++++++
 compat/posix.h                |  8 ++++++++
 config.mak.uname              |  2 ++
 meson.build                   |  1 +
 submodule.c                   | 16 ++++++++++++++++
 t/t7425-submodule-encoding.sh | 16 ++++++++++++++++
 7 files changed, 58 insertions(+)
 create mode 100644 compat/pathconf.c

diff --git a/Makefile b/Makefile
index 92fd8d86d8..9f76a67d4b 100644
--- a/Makefile
+++ b/Makefile
@@ -2215,6 +2215,11 @@ ifndef HAVE_PLATFORM_PROCINFO
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
index db1710e229..b65b5e0911 100644
--- a/meson.build
+++ b/meson.build
@@ -1394,6 +1394,7 @@ checkfuncs = {
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
+  'pathconf' : ['pathconf.c'],
 }
 
 if host_machine.system() == 'windows'
diff --git a/submodule.c b/submodule.c
index 23b79c9192..201e8a8fe5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2625,13 +2625,29 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 
 	if (the_repository->repository_format_submodule_encoding) {
 		struct strbuf tmp = STRBUF_INIT;
+		size_t base_len;
+		long name_max;
 
 		strbuf_reset(buf);
 		repo_git_path_append(r, buf, "modules/");
+		base_len = buf->len;
 
 		strbuf_addstr_urlencode(&tmp, submodule_name, is_rfc3986_unreserved);
 		strbuf_addstr_case_encode(buf, tmp.buf);
 
+		/* Ensure final path length is below NAME_MAX after encoding */
+		name_max = pathconf(buf->buf, _PC_NAME_MAX);
+		if (name_max == -1)
+			name_max = NAME_MAX;
+
+		if (buf->len - base_len > name_max)
+			/*
+			 * TODO: make this smarter; instead of erroring out, maybe we could trim or
+			 * shard the gitdir names to make them fit under NAME_MAX.
+			 */
+			die(_("submodule name %s is too long (%"PRIuMAX" bytes, limit %"PRIuMAX")"),
+			    buf->buf, (uintmax_t)buf->len - base_len, (uintmax_t)name_max);
+
 		strbuf_release(&tmp);
 	}
 }
diff --git a/t/t7425-submodule-encoding.sh b/t/t7425-submodule-encoding.sh
index 4ea385d882..8041781491 100755
--- a/t/t7425-submodule-encoding.sh
+++ b/t/t7425-submodule-encoding.sh
@@ -143,4 +143,20 @@ test_expect_success 'submodule git dir nesting detection must work with parallel
 	verify_submodule_gitdir_path clone_parallel hippo/hooks modules/hippo%2fhooks
 '
 
+test_expect_success 'submodule encoded name exceeds max name limit' '
+	(
+		cd main &&
+
+		# find the system NAME_MAX (fall back to 255 if unknown)
+		name_max=$(getconf NAME_MAX . 2>/dev/null || echo 255) &&
+
+		# each "%" char encodes to "%25" (3 chars), ensure we exceed NAME_MAX
+		count=$((name_max + 10)) &&
+		longname=$(test_seq -f "%%%0.s" 1 $count | tr -d "\n") &&
+
+		test_must_fail git submodule add ../new-sub "$longname" 2>err &&
+		test_grep "fatal: submodule name .* is too long" err
+	)
+'
+
 test_done
-- 
2.49.1

