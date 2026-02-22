Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031AC84039
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720188; cv=pass; b=FDR95YPus8bna8Y5wBkEQdcpSCqG5MPu2bVGtTLyLFA0MsfstWjqtyL8Oe1n4W5IX+dbTzKkIfIiWRHeRC/d1inlMqWpqaERgRov0vTxNiYRxbE61sgRDsGGXUIIYi7UF1elkZ6HGaHhhPc1M8fWovRVx7geOeRBNOZA/JKmBjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720188; c=relaxed/simple;
	bh=Lh1zlGp3wJbW4HGmfoUWLUAaZ+KgLR+IUVGH3trsf88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajDfqaCWfdDcSscgTgmF+PLRkM+FjptWcDsGN+3cOgDEButrOUcuEQPxGs0RqRoBr00JN7g2LBF3VFdL39nYLVmK04ZYWKIZOsDo9aP/slfffg6S7Fh9mbX9Hw6P8oNV2xXxfByXnY7OoG8eGDmI+BxlEhXBVT0qVEdlfNh41EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=h4Hagvaf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="h4Hagvaf"
ARC-Seal: i=1; a=rsa-sha256; t=1771720168; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MkTY47FDcMUII/0bMOFz4tkV8ENB0t+2vbQoGkNo4jAPDmHmrqliv5R19Ktc6d0inkx2raSQwDolfowrj3LeYwGyRdklqYEgHLqv41waYPFJeKiaK1GvooiHGMVWxnOCrGz3AAIY+DEHRwVxqdjyRBHycp0qmhT4HXyAvwAZJJs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720168; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y2G1HEaH1rKPj8wwPteVcb4Q7wQBVnyvHXiPeu3LTGI=; 
	b=nHoyHU4SV1HdoVmnAF+svuWmW5LvAiDux5TrYZx0svESUHMh3iPz+9o4mSo9qlLTSnY9g7IQc7RdySbpo/tqS4dokp7Mm3eAV79GW7T/ZvErXkq+xhXjjLy0qDNvOcja6rbFLCe9sPUo4F3ctsSFeybvXVs+Zx65Yk2vRE0/910=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720168;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=y2G1HEaH1rKPj8wwPteVcb4Q7wQBVnyvHXiPeu3LTGI=;
	b=h4Hagvaf/UgRxM7v7xtJv1NxSYqMUO3TyNMZNbKS5fuFP4BrNsAR9OVu2vEtaEz8
	M+0WvJNXOydKBpl7VE1WQZxrZtnuPd1wj0pIcSZsuxmXpUnxSDhyc1h5jCKcEqyrezj
	ub7//T2G3g/CSDgQUDhhjFbTIDf8xbEddjFtl1UY=
Received: by mx.zohomail.com with SMTPS id 1771720165973396.00935086646905;
	Sat, 21 Feb 2026 16:29:25 -0800 (PST)
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
Subject: [PATCH v2 04/10] hook: parse the hook.jobs config
Date: Sun, 22 Feb 2026 02:28:58 +0200
Message-ID: <20260222002904.1879356-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260222002904.1879356-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260222002904.1879356-1-adrian.ratiu@collabora.com>
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
index 64e845a260..c617261c57 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -22,3 +22,7 @@ hook.<name>.enabled::
 	configuration. This is particularly useful when a hook is defined
 	in a system or global config file and needs to be disabled for a
 	specific repository. See linkgit:git-hook[1].
+
+hook.jobs::
+	Specifies how many hooks can be run simultaneously during parallelized
+	hook execution. If unspecified, defaults to 1 (serial execution).
diff --git a/hook.c b/hook.c
index 89b9948512..f4213f5878 100644
--- a/hook.c
+++ b/hook.c
@@ -132,11 +132,13 @@ struct hook_config_cache_entry {
  * commands: friendly-name to command map.
  * event_hooks: event-name to list of friendly-names map.
  * disabled_hooks: set of friendly-names with hook.name.enabled = false.
+ * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
  */
 struct hook_all_config_cb {
 	struct strmap commands;
 	struct strmap event_hooks;
 	struct string_list disabled_hooks;
+	unsigned int jobs;
 };
 
 /* repo_config() callback that collects all hook.* configuration in one pass. */
@@ -152,6 +154,20 @@ static int hook_config_lookup_all(const char *key, const char *value,
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
 
@@ -236,7 +252,7 @@ void hook_cache_clear(struct hook_config_cache *cache)
 static void build_hook_config_map(struct repository *r,
 				  struct hook_config_cache *cache)
 {
-	struct hook_all_config_cb cb_data;
+	struct hook_all_config_cb cb_data = { 0 };
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 
@@ -244,7 +260,7 @@ static void build_hook_config_map(struct repository *r,
 	strmap_init(&cb_data.event_hooks);
 	string_list_init_dup(&cb_data.disabled_hooks);
 
-	/* Parse all configs in one run. */
+	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
 
 	/* Construct the cache from parsed configs. */
@@ -279,6 +295,8 @@ static void build_hook_config_map(struct repository *r,
 		strmap_put(&cache->hooks, e->key, hooks);
 	}
 
+	cache->jobs = cb_data.jobs;
+
 	strmap_clear(&cb_data.commands, 1);
 	string_list_clear(&cb_data.disabled_hooks, 0);
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
diff --git a/hook.h b/hook.h
index 994f15522d..7e83a3474f 100644
--- a/hook.h
+++ b/hook.h
@@ -197,6 +197,7 @@ void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
  */
 struct hook_config_cache {
 	struct strmap hooks; /* maps event name -> string_list of hooks */
+	unsigned int jobs; /* hook.jobs config value; 0 if unset (defaults to serial) */
 };
 
 /**
-- 
2.52.0.732.gb351b5166d.dirty

