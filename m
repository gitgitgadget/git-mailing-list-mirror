Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7E3A5444
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775291436; cv=pass; b=WyzhNvbPd/X2GeQZFABT5dt900UVkn5l99l6kOx++aRDNvfrukP0YE7W5dTlCCGzcRoEHakV5hqFHqEMnkQl3eQy6c3PP+UPICGfNhIv/x4ynjtMH7D6Xs77VoxEI5EtHYXA3ygwKXzDLQ9zlOQ4kCxY2WfHf1p47h8uiuVuH3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775291436; c=relaxed/simple;
	bh=TigxRCY2mlD1CVCh5YqQ8KUY1kcPHHDnh595KnZU2rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggRx2QHSbwVIwxOJ0n5+OgJELynczRUVRLAs5BAYNuUNLa6Bd8UUkiPUxRXezQM/jK2QASPa6B6DptK0FtacL42ihTfYu5K/CTrjQU1DGh+yijGBtbzvit2aZkOlfm3I5Da8YTdsNSX6yAcW2hBHclbvzgZciPost9ul8eZP8Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Bl/KS+74; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Bl/KS+74"
ARC-Seal: i=1; a=rsa-sha256; t=1775291418; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OPl3IC6yfciEbYbgTsG1oPi9j9pL7NUFgSbL7gjIZhpcrNqdp0uKNzMOviKZSH1Pd7/TdSAPmRrUVTEbpjn4c3vIKixJDfziWFVFk9oDk7QeUpEWbj+4V650iaz3/m9ZuZDT0x7pzkrYtfr3YUl5dGDTmwEaTIVNtZJcAoDxkY4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775291418; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bOhCJAaeh6hY1mmNKGbsrE/7uLzC4rG5EW+WVoOZXQM=; 
	b=hzMC6c8Z8MAGMR+xaX6hHZ/4dga4IjJyqIX5EgrB2VUX8HYCLqngxizU2yOpxiIk3n96l9A8pUwLLLeomkofR5qZUmbyLW0J00lCuP85YAPHdzkGgIH4khlT/n5V34fmCZClGbGRiHwSKU2225X9v6PL+Omo4YWMyXVZhLLanTM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775291418;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bOhCJAaeh6hY1mmNKGbsrE/7uLzC4rG5EW+WVoOZXQM=;
	b=Bl/KS+74o/wvqyQ4KjzyX01nap9LaiDzv2ItmjK9lcsYiPhDZQnwU+v6yRvS7FpW
	SLDz5WmkGURws8PK4uoX8gedMiMWInMceswfDUniW/1vQmUZJfldsR6ec/Mj+CM7WyQ
	hPzaihiOgqrWpU8DA2oumHsQDU7XGi0js2nxacp4=
Received: by mx.zohomail.com with SMTPS id 17752914166531001.5533459534298;
	Sat, 4 Apr 2026 01:30:16 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v6 10/12] hook: move is_known_hook() to hook.c for wider use
Date: Sat,  4 Apr 2026 11:29:32 +0300
Message-ID: <20260404082934.173788-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260404082934.173788-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260404082934.173788-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Move is_known_hook() from builtin/hook.c (static) into hook.c and
export it via hook.h so it can be reused.

Make it return bool and the iterator `h` for clarity (iterate hooks).

Both meson.build and the Makefile are updated to reflect that the
header is now used by libgit, not the builtin sources.

The next commit will use this to reject hook friendly-names that
collide with known event names.

Co-authored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Makefile       |  2 +-
 builtin/hook.c | 10 ----------
 hook.c         | 10 ++++++++++
 hook.h         |  6 ++++++
 meson.build    | 24 ++++++++++++------------
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index 5d22394c2e..c4e83823e4 100644
--- a/Makefile
+++ b/Makefile
@@ -2675,7 +2675,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
-builtin/hook.sp builtin/hook.s builtin/hook.o: hook-list.h
+hook.sp hook.s hook.o: hook-list.h
 
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
diff --git a/builtin/hook.c b/builtin/hook.c
index bea0668b47..1839412dca 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -4,7 +4,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hook.h"
-#include "hook-list.h"
 #include "parse-options.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
@@ -13,15 +12,6 @@
 #define BUILTIN_HOOK_LIST_USAGE \
 	N_("git hook list [--allow-unknown-hook-name] [-z] [--show-scope] <hook-name>")
 
-static int is_known_hook(const char *name)
-{
-	const char **p;
-	for (p = hook_name_list; *p; p++)
-		if (!strcmp(*p, name))
-			return 1;
-	return 0;
-}
-
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
 	BUILTIN_HOOK_LIST_USAGE,
diff --git a/hook.c b/hook.c
index 0493993bbe..19076f8f2b 100644
--- a/hook.c
+++ b/hook.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hook.h"
+#include "hook-list.h"
 #include "parse.h"
 #include "path.h"
 #include "run-command.h"
@@ -12,6 +13,15 @@
 #include "strbuf.h"
 #include "strmap.h"
 
+bool is_known_hook(const char *name)
+{
+	const char **h;
+	for (h = hook_name_list; *h; h++)
+		if (!strcmp(*h, name))
+			return true;
+	return false;
+}
+
 const char *find_hook(struct repository *r, const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
diff --git a/hook.h b/hook.h
index 01db4226a6..5a93f56618 100644
--- a/hook.h
+++ b/hook.h
@@ -234,6 +234,12 @@ void hook_free(void *p, const char *str);
  */
 void hook_cache_clear(struct strmap *cache);
 
+/**
+ * Returns true if `name` is a recognized hook event name
+ * (e.g. "pre-commit", "post-receive").
+ */
+bool is_known_hook(const char *name);
+
 /**
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
diff --git a/meson.build b/meson.build
index 8309942d18..f438d5545d 100644
--- a/meson.build
+++ b/meson.build
@@ -563,6 +563,18 @@ libgit_sources += custom_target(
   env: script_environment,
 )
 
+libgit_sources += custom_target(
+  input: 'Documentation/githooks.adoc',
+  output: 'hook-list.h',
+  command: [
+    shell,
+    meson.current_source_dir() + '/tools/generate-hooklist.sh',
+    meson.current_source_dir(),
+    '@OUTPUT@',
+  ],
+  env: script_environment,
+)
+
 builtin_sources = [
   'builtin/add.c',
   'builtin/am.c',
@@ -739,18 +751,6 @@ builtin_sources += custom_target(
   env: script_environment,
 )
 
-builtin_sources += custom_target(
-  input: 'Documentation/githooks.adoc',
-  output: 'hook-list.h',
-  command: [
-    shell,
-    meson.current_source_dir() + '/tools/generate-hooklist.sh',
-    meson.current_source_dir(),
-    '@OUTPUT@',
-  ],
-  env: script_environment,
-)
-
 # This contains the variables for GIT-BUILD-OPTIONS, which we use to propagate
 # build options to our tests.
 build_options_config = configuration_data()
-- 
2.52.0.732.gb351b5166d.dirty

