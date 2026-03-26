Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAD3BF66D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520465; cv=pass; b=rhT+X2z1ySVz4wOYsUi/W5DBzNhBHQOYVW8K2HknpvO0pGG8qNCrctvFYXHf+IgyhPHujEAPXngQGwaDaO+pNh86fV7r6hHkr3TstCFD7nfHhL2QL+C3EhLbuI2a8ngiaXGvvUk9ybhUWGTN3dLGtc9i5JZc5uMgj1rXbNR4UfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520465; c=relaxed/simple;
	bh=9m8t+nXWcnKnMOZLrBwYa8FLW9tbFK/8KzwE1pWSrc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfJrIf7chI+xMzJtEfC0Slgw7XVPa8PP68EiAlArJ2kBCNp7Y35aD6nYsot/NfeDM6BRjrA41kM82BNLNRC4gING0UYhmI4QbOY0qmV2YiekrhtW+b0MFrIpCxVOYHk9BJdcwGe//4eKu5HbYGyJo5Me5IN/cHjIfGbptspWukg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=dUgXef0x; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="dUgXef0x"
ARC-Seal: i=1; a=rsa-sha256; t=1774520437; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iBgPFJ1E+dcTE9D0owksePTC6sVGwRisE1UtJDGD5m6l1SYwseDpZkEAkioRG29N1Czd4Xm65yGDIfg2VzABRj/8sdoTYqWpRei0H4bzpehYN/asUoG3ERCKGTQp9QvbLp3SLKo+BCa+X9ssruHnxfsMBeCyu479BsSJ8CIbZ8U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774520437; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h18XJzvnWo+vWRrmZHtYiQIJ3cw1t60rzWF2Nj/nwiw=; 
	b=JhYDK9L0tL/20Yl4pxy6phfximRE9zBy5yokzLNP+yumgaPKR6IF1aEQXextJZb0LLItSPkola8aXYWQq1GCfqfKxaAG0JQ8bCyx3nlv7HK6neqYxuCvCeh9B0d1oNL7BQ/l177iV5wyHzXpKOJyQxJgvHRe0Md7i9xG784xl7s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774520437;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h18XJzvnWo+vWRrmZHtYiQIJ3cw1t60rzWF2Nj/nwiw=;
	b=dUgXef0xBdYuOpQqzghqANOchadeSAnHBR4qXAnb7CZxy82I7R6stkZKhSsq2aAJ
	dnweBV+dJHQvdZ9kIvXeL9Aj2yr+JWoh/9krSEDW9Y8/W/lVW14S/LP/elEVpOVIIJk
	43KUeprdFF9Vfrws/v+j7Nre5LYZjT6G2UoW8JO4=
Received: by mx.zohomail.com with SMTPS id 1774520436756197.3918768406985;
	Thu, 26 Mar 2026 03:20:36 -0700 (PDT)
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
Subject: [PATCH v5 10/12] hook: move is_known_hook() to hook.c for wider use
Date: Thu, 26 Mar 2026 12:18:17 +0200
Message-ID: <20260326101819.1307742-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260326101819.1307742-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-1-adrian.ratiu@collabora.com>
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

The next commit will use this to reject hook friendly-names that
collide with known event names.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Makefile       |  2 +-
 builtin/hook.c | 10 ----------
 hook.c         | 10 ++++++++++
 hook.h         |  6 ++++++
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 6d64431219..4b3a7bdce5 100644
--- a/Makefile
+++ b/Makefile
@@ -2673,7 +2673,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
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
-- 
2.52.0.732.gb351b5166d.dirty

