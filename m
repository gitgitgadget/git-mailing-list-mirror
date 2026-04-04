Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4366356A38
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775291424; cv=pass; b=S0RABULMjusjycoelEkGYJ6sa3DArH2+/e9rGsKql/0P+mebb5lYmR/HxjGstHXnEkw1yw1hxruhYzIFKPRx3K0C5DLu4CxuaGpMY2fOGlHpfTltGIRf7jlo98XL8p0/uWv+Rh/743KNKhBeNKSVRldd+4qpX9tq0lNYS0RMZws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775291424; c=relaxed/simple;
	bh=BKZqMV9oVW6vijgtmuy19R5i6M+ZhdMXzmK1n4idJvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huHkDGsclXPPBKwZMLGEej5WAHw9d1tGyOYys/EAmAVlRWwSr+Dlb+WNHxi/a0LNBFJW6GIh/PR+/I+mM+CbYh/DVspgG1Mf0G9IsE5tv4K4ejj0t5/UVlrP3c4HyI2+18YU/66w589lYYI/uxDVp4QyiQpoJVkJt+NfA/awGYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ME93dlA9; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ME93dlA9"
ARC-Seal: i=1; a=rsa-sha256; t=1775291404; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j5ehVBscxNUQYpRUQhsvJUVeGC5W5lV0z1HuGDkwF64mHna5AeVSgwaPyfTfnWTxjuh+mRO2n2/d+AnQCBtD4OYj11nxVjcuHXe1sUIs5cVnLrMOo8H6rMZQmzsAyEgqWsTwErmLyQIMhqMss0hyoDHKCa01BMFB0PLk1NmRzPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775291404; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hgJfqYbwUqXlm+Co0yrEAEewjsxPDQcbcHLGYB4nTTc=; 
	b=TyhWrk6wq1U52aW3caXOmdJlVoA5jZwCKAsVVAh6IVDYrhn+BjXBrTTmOH8B3odGr1yfnfS9TSax8wtRzAg0vLRnKs3mxOqNurZ+WW4x7IRirszH4G7UOtOMaqwk/FE5HDiWInL7GRZQetd+tJNvgew5zoWu7fwvQnOR8tqceDs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775291404;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hgJfqYbwUqXlm+Co0yrEAEewjsxPDQcbcHLGYB4nTTc=;
	b=ME93dlA9HcEZHjXqcKszBlLfteARvVcqmv+HtkJb97fHBFgVRc8VEuG/YWqpqwBp
	j/94VQBxQWWXH4wL9cDHRgQY4GMVw8mnEFmt15JR+g6E4RiNQT0FFX0Kxcw19LQg+N6
	R3ZLyyHNHQEUwmJbMjpg/G7Pt8ZjOMbuKkuAecTA=
Received: by mx.zohomail.com with SMTPS id 1775291401308487.10014540199086;
	Sat, 4 Apr 2026 01:30:01 -0700 (PDT)
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
Subject: [PATCH v6 03/12] hook: parse the hook.jobs config
Date: Sat,  4 Apr 2026 11:29:25 +0300
Message-ID: <20260404082934.173788-4-adrian.ratiu@collabora.com>
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

The hook.jobs config is a global way to set hook parallelization for
all hooks, in the sense that it is not per-event nor per-hook.

Finer-grained configs will be added in later commits which can override
it, for e.g. via a per-event type job options. Next commits will also
add to this item's documentation.

Parse hook.jobs config key in hook_config_lookup_all() and store its
value in hook_all_config_cb.jobs, then transfer it into r->jobs after
the config pass completes.

This is mostly plumbing and the cached value is not yet used.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  4 ++++
 hook.c                         | 23 +++++++++++++++++++++--
 repository.h                   |  3 +++
 3 files changed, 28 insertions(+), 2 deletions(-)

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
index cc23276d27..b8cce00e57 100644
--- a/hook.c
+++ b/hook.c
@@ -123,11 +123,13 @@ struct hook_config_cache_entry {
  * commands: friendly-name to command map.
  * event_hooks: event-name to list of friendly-names map.
  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
+ * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
  */
 struct hook_all_config_cb {
 	struct strmap commands;
 	struct strmap event_hooks;
 	struct string_list disabled_hooks;
+	unsigned int jobs;
 };
 
 /* repo_config() callback that collects all hook.* configuration in one pass. */
@@ -143,6 +145,20 @@ static int hook_config_lookup_all(const char *key, const char *value,
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
 
@@ -240,7 +256,7 @@ void hook_cache_clear(struct strmap *cache)
 /* Populate `cache` with the complete hook configuration */
 static void build_hook_config_map(struct repository *r, struct strmap *cache)
 {
-	struct hook_all_config_cb cb_data;
+	struct hook_all_config_cb cb_data = { 0 };
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 
@@ -248,7 +264,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	strmap_init(&cb_data.event_hooks);
 	string_list_init_dup(&cb_data.disabled_hooks);
 
-	/* Parse all configs in one run. */
+	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
 
 	/* Construct the cache from parsed configs. */
@@ -292,6 +308,9 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 		strmap_put(cache, e->key, hooks);
 	}
 
+	if (r)
+		r->hook_jobs = cb_data.jobs;
+
 	strmap_clear(&cb_data.commands, 1);
 	string_list_clear(&cb_data.disabled_hooks, 0);
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
diff --git a/repository.h b/repository.h
index 078059a6e0..58e46853d0 100644
--- a/repository.h
+++ b/repository.h
@@ -172,6 +172,9 @@ struct repository {
 	 */
 	struct strmap *hook_config_cache;
 
+	/* Cached value of hook.jobs config (0 if unset, defaults to serial). */
+	unsigned int hook_jobs;
+
 	/* Configurations related to promisor remotes. */
 	char *repository_format_partial_clone;
 	struct promisor_remote_config *promisor_remote_config;
-- 
2.52.0.732.gb351b5166d.dirty

