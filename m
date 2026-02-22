Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07563EBF33
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720187; cv=pass; b=bWrTEEZS3KZMynRGJngmI0aW4DUqKIfRQ/bCYNHkeG/y4QlGEcYG+fu/2+cnAzQbEfGqzzDXKK2OavIz6qxOXkDefw35HCUAdIbgxE/ezeX2TjfvD9UVuroJAKEXrpSfovR4nPvDjf+Wp3+cb18shrW3MaC0je4kSrZ157961CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720187; c=relaxed/simple;
	bh=EtfMR/c2lGc38ypnTMDm5Ha249/eADePs6uJtDr6W+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppeq4wjL3EfekiUhrFRb2pjgUVR/mvEQY5EdKn84Puz4cH8i/d784jLJ9qUwXU3S7Ra3KU+iUhmFAhuZ81TBp+PqQ/tTKsm6bT/0AuxsSGWVlRVrPtIKU7hEPlwOkvpYYh0HgRMXVyP4KgEeWnAHiS7yIFtGWc8yvBAWpnmQOlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=OhR0kKNV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="OhR0kKNV"
ARC-Seal: i=1; a=rsa-sha256; t=1771720166; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=el/iRSvDtJjd8BXly/WBKaYYoXwEQJRFh47tesNotOURqOSf7/Vd5iddkUNsOPgUDi3Otsz3Cci8RX36yCwLq8507YPzT0eAFEdCgoHbIjijIGO/OpPrxdCIu02kVoSf1bxjuAncvgBPk16ih2NrN56yZNjHBH4EoXE12hcw16w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720166; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sFDxkO5EWa+kY+3uezwBbIkZ0loenroas54jDt7Dwoo=; 
	b=W2WXyqH6V+ow4BZvwSaOfcYRTRj52lqCrBCVomkbZUQvBa+UoP/FRyMZ4lXNRf9MU3xj1Fbz7bpRQZOZoZx7oorJnMs6E+8RAA+Lpi1Qzwwt7JUFBqeXRmFecwHfPf6pGe0vMDnV+nc4N6lzGRAbASPdY3WBqG409YMywZLd7QI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720166;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sFDxkO5EWa+kY+3uezwBbIkZ0loenroas54jDt7Dwoo=;
	b=OhR0kKNVrdAmyp4IHFn2zjJYrz5u4yV1j5pCsGX+k54qRPTgFEJO5P3rjiH5LeTU
	DEne3RWRla9vvXTsltfKtwZ0H/+MAoYxJxQe1MQekKrHMXczEF55J2EcPDVDdMgtaBo
	CsOUaF2Ftn9XlF10r/6ekeySwkpV5a5fzazKUqto=
Received: by mx.zohomail.com with SMTPS id 1771720163930321.27437706826345;
	Sat, 21 Feb 2026 16:29:23 -0800 (PST)
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
Subject: [PATCH v2 03/10] hook: refactor hook_config_cache from strmap to named struct
Date: Sun, 22 Feb 2026 02:28:57 +0200
Message-ID: <20260222002904.1879356-4-adrian.ratiu@collabora.com>
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

Replace the raw `struct strmap *hook_config_cache` in `struct repository`
with a `struct hook_config_cache` which wraps the strmap in a named field.

Replace the bare `char *command` util pointer stored in each string_list
item with a heap-allocated `struct hook_config_cache_entry` that carries
that command string.

This is just a refactoring with no behavior changes, to give the cache
struct room to grow so it can carry the additional hook metadata we'll
be adding in the following commits.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c       | 65 +++++++++++++++++++++++++++++++++-------------------
 hook.h       | 10 +++++++-
 repository.h |  3 ++-
 3 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/hook.c b/hook.c
index 2c8252b2c4..89b9948512 100644
--- a/hook.c
+++ b/hook.c
@@ -118,6 +118,15 @@ static void unsorted_string_list_remove(struct string_list *list,
 		unsorted_string_list_delete_item(list, item - list->items, 0);
 }
 
+/*
+ * Cache entry stored as the .util pointer of string_list items inside the
+ * hook config cache. For now carries only the command for the hook. Next
+ * commits will add more data.
+ */
+struct hook_config_cache_entry {
+	char *command;
+};
+
 /*
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
@@ -205,21 +214,27 @@ static int hook_config_lookup_all(const char *key, const char *value,
  * Disabled hooks and hooks missing a command are already filtered out at
  * parse time, so callers can iterate the list directly.
  */
-void hook_cache_clear(struct strmap *cache)
+void hook_cache_clear(struct hook_config_cache *cache)
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 
-	strmap_for_each_entry(cache, &iter, e) {
+	strmap_for_each_entry(&cache->hooks, &iter, e) {
 		struct string_list *hooks = e->value;
-		string_list_clear(hooks, 1); /* free util (command) pointers */
+		for (size_t i = 0; i < hooks->nr; i++) {
+			struct hook_config_cache_entry *entry = hooks->items[i].util;
+			free(entry->command);
+			free(entry);
+		}
+		string_list_clear(hooks, 0);
 		free(hooks);
 	}
-	strmap_clear(cache, 0);
+	strmap_clear(&cache->hooks, 0);
 }
 
 /* Populate `cache` with the complete hook configuration */
-static void build_hook_config_map(struct repository *r, struct strmap *cache)
+static void build_hook_config_map(struct repository *r,
+				  struct hook_config_cache *cache)
 {
 	struct hook_all_config_cb cb_data;
 	struct hashmap_iter iter;
@@ -241,6 +256,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 
 		for (size_t i = 0; i < hook_names->nr; i++) {
 			const char *hname = hook_names->items[i].string;
+			struct hook_config_cache_entry *entry;
 			char *command;
 
 			/* filter out disabled hooks */
@@ -254,12 +270,13 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 				      "'hook.%s.event' must be removed;"
 				      " aborting."), hname, hname);
 
-			/* util stores the command; owned by the cache. */
-			string_list_append(hooks, hname)->util =
-				xstrdup(command);
+			/* util stores a cache entry; owned by the cache. */
+			CALLOC_ARRAY(entry, 1);
+			entry->command = xstrdup(command);
+			string_list_append(hooks, hname)->util = entry;
 		}
 
-		strmap_put(cache, e->key, hooks);
+		strmap_put(&cache->hooks, e->key, hooks);
 	}
 
 	strmap_clear(&cb_data.commands, 1);
@@ -272,35 +289,35 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 }
 
 /*
- * Return the hook config map for `r`, populating it first if needed.
+ * Return the hook config cache for `r`, populating it first if needed.
  *
  * Out-of-repo calls (r->gitdir == NULL) allocate and return a temporary
- * cache map; the caller is responsible for freeing it with
+ * cache; the caller is responsible for freeing it with
  * hook_cache_clear() + free().
  */
-static struct strmap *get_hook_config_cache(struct repository *r)
+static struct hook_config_cache *get_hook_config_cache(struct repository *r)
 {
-	struct strmap *cache = NULL;
+	struct hook_config_cache *cache = NULL;
 
 	if (r && r->gitdir) {
 		/*
-		 * For in-repo calls, the map is stored in r->hook_config_cache,
-		 * so repeated invocations don't parse the configs, so allocate
+		 * For in-repo calls, the cache is stored in r->hook_config_cache,
+		 * so repeated invocations don't parse the configs; allocate
 		 * it just once on the first call.
 		 */
 		if (!r->hook_config_cache) {
-			r->hook_config_cache = xcalloc(1, sizeof(*cache));
-			strmap_init(r->hook_config_cache);
+			CALLOC_ARRAY(r->hook_config_cache, 1);
+			strmap_init(&r->hook_config_cache->hooks);
 			build_hook_config_map(r, r->hook_config_cache);
 		}
 		cache = r->hook_config_cache;
 	} else {
 		/*
 		 * Out-of-repo calls (no gitdir) allocate and return a temporary
-		 * map cache which gets free'd immediately by the caller.
+		 * cache which gets freed immediately by the caller.
 		 */
-		cache = xcalloc(1, sizeof(*cache));
-		strmap_init(cache);
+		CALLOC_ARRAY(cache, 1);
+		strmap_init(&cache->hooks);
 		build_hook_config_map(r, cache);
 	}
 
@@ -312,13 +329,13 @@ static void list_hooks_add_configured(struct repository *r,
 				      struct string_list *list,
 				      struct run_hooks_opt *options)
 {
-	struct strmap *cache = get_hook_config_cache(r);
-	struct string_list *configured_hooks = strmap_get(cache, hookname);
+	struct hook_config_cache *cache = get_hook_config_cache(r);
+	struct string_list *configured_hooks = strmap_get(&cache->hooks, hookname);
 
 	/* Iterate through configured hooks and initialize internal states */
 	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
 		const char *friendly_name = configured_hooks->items[i].string;
-		const char *command = configured_hooks->items[i].util;
+		struct hook_config_cache_entry *entry = configured_hooks->items[i].util;
 		struct hook *hook = xcalloc(1, sizeof(struct hook));
 
 		if (options && options->feed_pipe_cb_data_alloc)
@@ -328,7 +345,7 @@ static void list_hooks_add_configured(struct repository *r,
 
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
-		hook->u.configured.command = xstrdup(command);
+		hook->u.configured.command = xstrdup(entry->command);
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
diff --git a/hook.h b/hook.h
index e949f5d488..994f15522d 100644
--- a/hook.h
+++ b/hook.h
@@ -191,11 +191,19 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
  */
 void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
 
+/**
+ * Persistent cache for hook configuration, stored on `struct repository`.
+ * Populated lazily on first hook use and freed by repo_clear().
+ */
+struct hook_config_cache {
+	struct strmap hooks; /* maps event name -> string_list of hooks */
+};
+
 /**
  * Frees the hook configuration cache stored in `struct repository`.
  * Called by repo_clear().
  */
-void hook_cache_clear(struct strmap *cache);
+void hook_cache_clear(struct hook_config_cache *cache);
 
 /**
  * Returns the path to the hook file, or NULL if the hook is missing
diff --git a/repository.h b/repository.h
index 25b2801228..2105768b8c 100644
--- a/repository.h
+++ b/repository.h
@@ -11,6 +11,7 @@ struct lock_file;
 struct pathspec;
 struct object_database;
 struct submodule_cache;
+struct hook_config_cache;
 struct promisor_remote_config;
 struct remote_state;
 
@@ -161,7 +162,7 @@ struct repository {
 	 * Lazily-populated cache mapping hook event names to configured hooks.
 	 * NULL until first hook use.
 	 */
-	struct strmap *hook_config_cache;
+	struct hook_config_cache *hook_config_cache;
 
 	/* Configurations related to promisor remotes. */
 	char *repository_format_partial_clone;
-- 
2.52.0.732.gb351b5166d.dirty

