Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273530F548
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390791; cv=pass; b=KbYDJsjO6A9XiCt3vkjfznSD7NBQdUfFHeULgQw/YKviEVpIO2rkJrHdcWP+IF8DypMtZNrF7XxBOAXfyh3qfFaYTOSEw43On78YwB0XnjbmikLZkZilYNY66hrn3EygGxGOHv9QEsIZE8qlkrujdmI7zBK6oGOMptxKKFTQ00k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390791; c=relaxed/simple;
	bh=1KvaYnwqUdscTRtssh7DjYM6368eOzkTIU2TO4K6g14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZdpUO2pMwbEh9NuKLu15cbj4WUIIYqSOnQqHLJ9vm2R/q3iUyRXULIJRgCk56lTBoEQSk8KPoXaOy/bH1wSC1q/kz5ch1rfj9wOJNl6+i9lRjmKpuX8SqKivDyb6GWJtZHgZzbzqSoRI4ZmPf4I1KM42JkwT6yQhpp97mzXznc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XMrfO01J; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XMrfO01J"
ARC-Seal: i=1; a=rsa-sha256; t=1772390777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bvh+IWU/rtfxq1cacr2WcYEZcQQPwlVv6BthtuVGNPRfF2+V7xFBgMqs6xqdjEinB4mzo27deBGoTQVgT3vC8+yJZW7broMzxPZbi6ThC3GET2Dwn4si2rAo8rUQ4jxBUSg0KP/rS4XvWzPacUX+jrD7fcpgAWQhql7nqzTT48o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390777; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bolzdb4SgA2zeToubhcAH+UyuWkl18gRTxkmkWDUgSY=; 
	b=UwkWF5WCTv1zwU5Uz7N5N1V28oWPXbSiUj/sUFQJlARm1vsrA8kMcsOyRX8cnourw91cQGrwD5jv2sVlpEryA/8mB04vJRGusF+hWzzXS4N39QK3v4qBYXphlSnMfIEsanvkj0jActDCcVqO0u63CNknxi0JpgkeBB1lGHQAa0g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390777;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bolzdb4SgA2zeToubhcAH+UyuWkl18gRTxkmkWDUgSY=;
	b=XMrfO01J7dTrRPnA4yMI5/S/vt4op0W4PuSDHWnbVV/oCqBlPFjbxsUMxSPcHMPl
	B4RrKTrpDt33zGwTC9KcTRIrkeK/IexMiGITC6ejZJ/DAHdlPBIZtOndvBjhz2ij3mW
	J6TKGjpXS2ww5GA0JCJBuGK8/IGPccca33NX/GJo=
Received: by mx.zohomail.com with SMTPS id 1772390774847898.1124100232546;
	Sun, 1 Mar 2026 10:46:14 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 08/12] hook: allow out-of-repo 'git hook' invocations
Date: Sun,  1 Mar 2026 20:44:56 +0200
Message-ID: <20260301184500.1488433-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260301184500.1488433-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Since hooks can now be supplied via the config, and a config can be
present without a gitdir via the global and system configs, we can start
to allow 'git hook run' to occur without a gitdir. This enables us to do
things like run sendemail-validate hooks when running 'git send-email'
from a nongit directory.

It still doesn't make sense to look for hooks in the hookdir in nongit
repos, though, as there is no hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 git.c           |  2 +-
 hook.c          | 30 ++++++++++++++++++++++++++++--
 t/t1800-hook.sh | 16 +++++++++++-----
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/git.c b/git.c
index 744cb6527e..6480ff8373 100644
--- a/git.c
+++ b/git.c
@@ -587,7 +587,7 @@ static struct cmd_struct commands[] = {
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "history", cmd_history, RUN_SETUP },
-	{ "hook", cmd_hook, RUN_SETUP },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index 696919e703..9b97fa641f 100644
--- a/hook.c
+++ b/hook.c
@@ -18,6 +18,9 @@ const char *find_hook(struct repository *r, const char *name)
 
 	int found_hook;
 
+	if (!r || !r->gitdir)
+		return NULL;
+
 	repo_git_path_replace(r, &path, "hooks/%s", name);
 	found_hook = access(path.buf, X_OK) >= 0;
 #ifdef STRIP_EXTENSION
@@ -255,12 +258,18 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	strmap_clear(&cb_data.event_hooks, 0);
 }
 
-/* Return the hook config map for `r`, populating it first if needed. */
+/*
+ * Return the hook config map for `r`, populating it first if needed.
+ *
+ * Out-of-repo calls (r->gitdir == NULL) allocate and return a temporary
+ * cache map; the caller is responsible for freeing it with
+ * hook_cache_clear() + free().
+ */
 static struct strmap *get_hook_config_cache(struct repository *r)
 {
 	struct strmap *cache = NULL;
 
-	if (r) {
+	if (r && r->gitdir) {
 		/*
 		 * For in-repo calls, the map is stored in r->hook_config_cache,
 		 * so repeated invocations don't parse the configs, so allocate
@@ -272,6 +281,14 @@ static struct strmap *get_hook_config_cache(struct repository *r)
 			build_hook_config_map(r, r->hook_config_cache);
 		}
 		cache = r->hook_config_cache;
+	} else {
+		/*
+		 * Out-of-repo calls (no gitdir) allocate and return a temporary
+		 * map cache which gets free'd immediately by the caller.
+		 */
+		CALLOC_ARRAY(cache, 1);
+		strmap_init(cache);
+		build_hook_config_map(r, cache);
 	}
 
 	return cache;
@@ -305,6 +322,15 @@ static void list_hooks_add_configured(struct repository *r,
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
+
+	/*
+	 * Cleanup temporary cache for out-of-repo calls since they can't be
+	 * stored persistently. Next out-of-repo calls will have to re-parse.
+	 */
+	if (!r || !r->gitdir) {
+		hook_cache_clear(cache);
+		free(cache);
+	}
 }
 
 struct string_list *list_hooks(struct repository *r, const char *hookname,
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index c14ec661b9..856555bce5 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -130,12 +130,18 @@ test_expect_success 'git hook run -- pass arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	test_hook test-hook <<-EOF &&
-	echo Test hook
-	EOF
+test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
+	test_config_global hook.global-hook.event test-hook --add &&
+	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
 
-	nongit test_must_fail git hook run test-hook
+	echo "global-hook" >expect &&
+	nongit git hook list test-hook >actual &&
+	test_cmp expect actual &&
+
+	echo "no repo no problems" >expect &&
+
+	nongit git hook run test-hook 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
-- 
2.52.0.732.gb351b5166d.dirty

