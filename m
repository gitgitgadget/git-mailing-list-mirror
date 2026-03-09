Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19403BE167
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063538; cv=pass; b=qzyxAevinZvN0B3TSin2tjYkt2AkTF3/56jBKU6xq7c2vqdvf4upzvJ4014/eQDwfd9Pkd57M0Iz1y+66bnm8arfu17Rv5PFPK1ZwOTANzvOFdmhcMmwYCJJQXYaovT3tfAWiEazcqFrfn3COhEs0ENzV/j8Wjixgndf7E5Vl98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063538; c=relaxed/simple;
	bh=EwDIvHTrsFySVhJS1T4wzP6ONWOFR/wZe5PKJHtmW+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwJDde2gVnjGFmsM+odumF4NisxigZZjnqDtawmpU9EiXfRUdGt6ORkWCXuGKzGPZwrUxZSdMKTLTzxXnVeDq+rPhFknAuf5nx+D1YfvaqrX6Zf/toAB0prSyDHUML4nKItmBJ6OCnRxZzOGP3lmRjP9uDFa+8m4OeU+GyAwbFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=MjuQpI6I; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="MjuQpI6I"
ARC-Seal: i=1; a=rsa-sha256; t=1773063517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oEvk3NafKuBDnGvh4oSbMKI/qg8L8hq3BuV0Q7fbYkEiF+3irH6dz1IQhxsVcU5kLffK4rUVjBnD9OxYRrml2Be1uXxbYQ4s0/gxYE7eT91hcXTdNQynVwx5Fku+vBpAUr5Ngl2JRQa4TzB/uoDS5RGf6GFf0eob7PQOQaQGqao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773063517; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+BhmmmbkEMFr8LLgZOm9uQkYeJohN8eQ9Kde0nYLZwQ=; 
	b=UzSsqj1G+02XTpy9r6Tz1rpZ5YnaC9NkucJxQslJGxEddjo0FwWljLnBaoUfWMruZ/1vuQIPjx2/wyPA0bEaxhHNIAnN2tJ6d2WUDR8hUkSXKcNwYWVmZle8Yt1ZLi+TvaQ8dfuRw8Eb0MbTtcY4nPNlIdbULCXINTPEJAdb/9Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773063517;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+BhmmmbkEMFr8LLgZOm9uQkYeJohN8eQ9Kde0nYLZwQ=;
	b=MjuQpI6Iarxd0rgdcl4dkFqHqFwRLe7HVzNGce9fDiIyJMmLsRZHa6PywfHWV1wx
	/qJQrIX/b8c0t/M1z1Pmo3q0kDGRUT7cRG6fHO/UetWw5xyn3Z84EsfxYFVTr9Is33i
	dtyJWcMKWSPSGnOxsxa5opfaIUENTCEGNOTu0w9U=
Received: by mx.zohomail.com with SMTPS id 1773063515561931.8091167929707;
	Mon, 9 Mar 2026 06:38:35 -0700 (PDT)
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
Subject: [PATCH v3 3/9] hook: parse the hook.jobs config
Date: Mon,  9 Mar 2026 15:37:33 +0200
Message-ID: <20260309133739.294555-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309133739.294555-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The hook.jobs config is a global way to set hook parallelization for
all hooks, in the sense that it is not per-event nor per-hook.

Finer-grained configs will be added in later commits which can override
it, for e.g. via a per-event type job options. Next commits will also
add to this item's documentation.

Parse hook.jobs config key in hook_config_lookup_all() and store its
value in hook_all_config_cb.jobs, then transfer it into
hook_config_cache.jobs after the config pass completes.

This is mostly plumbing and the cached value is not yet used.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  4 ++++
 hook.c                         | 22 ++++++++++++++++++++--
 hook.h                         |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 9e78f26439..b7847f9338 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -22,3 +22,7 @@ hook.<friendly-name>.enabled::
 	configuration. This is particularly useful when a hook is defined
 	in a system or global config file and needs to be disabled for a
 	specific repository. See linkgit:git-hook[1].
+
+hook.jobs::
+	Specifies how many hooks can be run simultaneously during parallelized
+	hook execution. If unspecified, defaults to 1 (serial execution).
diff --git a/hook.c b/hook.c
index 4f4f060156..e6e44a5fcb 100644
--- a/hook.c
+++ b/hook.c
@@ -127,11 +127,13 @@ struct hook_config_cache_entry {
  * commands: friendly-name to command map.
  * event_hooks: event-name to list of friendly-names map.
  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
+ * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
  */
 struct hook_all_config_cb {
 	struct strmap commands;
 	struct strmap event_hooks;
 	struct string_list disabled_hooks;
+	unsigned int jobs;
 };
 
 /* repo_config() callback that collects all hook.* configuration in one pass. */
@@ -147,6 +149,20 @@ static int hook_config_lookup_all(const char *key, const char *value,
 	if (parse_config_key(key, "hook", &name, &name_len, &subkey))
 		return 0;
 
+	/* Handle plain hook.<key> entries that have no hook name component. */
+	if (!name) {
+		if (!strcmp(subkey, "jobs") && value) {
+			unsigned int v;
+			if (!git_parse_uint(value, &v))
+				warning(_("hook.jobs must be a positive integer, ignoring: '%s'"), value);
+			else if (!v)
+				warning(_("hook.jobs must be positive, ignoring: 0"));
+			else
+				data->jobs = v;
+		}
+		return 0;
+	}
+
 	if (!value)
 		return config_error_nonbool(key);
 
@@ -245,7 +261,7 @@ void hook_cache_clear(struct hook_config_cache *cache)
 static void build_hook_config_map(struct repository *r,
 				  struct hook_config_cache *cache)
 {
-	struct hook_all_config_cb cb_data;
+	struct hook_all_config_cb cb_data = { 0 };
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 
@@ -253,7 +269,7 @@ static void build_hook_config_map(struct repository *r,
 	strmap_init(&cb_data.event_hooks);
 	string_list_init_dup(&cb_data.disabled_hooks);
 
-	/* Parse all configs in one run. */
+	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
 
 	/* Construct the cache from parsed configs. */
@@ -297,6 +313,8 @@ static void build_hook_config_map(struct repository *r,
 		strmap_put(&cache->hooks, e->key, hooks);
 	}
 
+	cache->jobs = cb_data.jobs;
+
 	strmap_clear(&cb_data.commands, 1);
 	string_list_clear(&cb_data.disabled_hooks, 0);
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
diff --git a/hook.h b/hook.h
index 0432df963f..a7eab00480 100644
--- a/hook.h
+++ b/hook.h
@@ -208,6 +208,7 @@ void hook_free(void *p, const char *str UNUSED);
  */
 struct hook_config_cache {
 	struct strmap hooks; /* maps event name -> string_list of hooks */
+	unsigned int jobs; /* hook.jobs config value; 0 if unset (defaults to serial) */
 };
 
 /**
-- 
2.52.0.732.gb351b5166d.dirty

