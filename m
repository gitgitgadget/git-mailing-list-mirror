Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7253BB9E1
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014845; cv=pass; b=t4eB68R60Cp5O0n0Kt2ellNFGew5l6TOc5oMuES+b5WZiF7Vf4iG86H4ziIH+CgGlZjWXJVSIHYJwxLwqhAisMnn8k3WCIFV9txgiv0MYQiiaCFAoWmXwuUt75Z5mnUzg0WTqNC/kGpMRBFigFKvYkR/ailA4wAupipsTzwh2j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014845; c=relaxed/simple;
	bh=6cV4Aus7NOiXK1HFbdMLkwL3xHe6vAnTyrZS6kLBHbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqO8P19h23fXiRVLR2deBPSWCWW0Z/jlAONWUYZ9QzO64sPjDZZNUIKTJ9vShhhVuwaptqHgBYDlbGGIK8oUqnoSNg9g01NIjPn2CAjdqEEkqRcTzAM4axDSGcGoYLq6M8P1IZ+DqLISTUZtPxhU4rHBd2ppcY98Gj9pNCj6acg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=I5UBKn3O; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="I5UBKn3O"
ARC-Seal: i=1; a=rsa-sha256; t=1774014824; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MyTNfHWA4966ZLO8c9dxvULee1hASpFhXgZPwBwJFHFtwWC1HpGE60oBX0ZUELhs1YPwMcYZ4CU1qs3dHGby1bC0u/jwZcCi7i9qff5zpN9mQCCKswMGAoeaEwQqbTKcqP6Z+KGSTLhFKPzaOpZG0lRC4f/5uUtvJA26iMVza3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774014824; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tvf38U35G4U7L8J9QCcpRtFBpwQG+eHWx+CCQ0fGiOg=; 
	b=hi8FIEs9YNy2E9NEr2wKlcCq73QVYQ8c882eQBFbNIC2MSl+92F2aUhzX/2oKHjgBexytyf1FmyDEl6FNN+UCuHvc0LDuyrcPM7PX28037DyIjszVRBmrDZdawxD5OMSvId0adCT0rRTkxvd9U5MGCI15tPW5Jzn7eZ/+YceEHc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774014824;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Tvf38U35G4U7L8J9QCcpRtFBpwQG+eHWx+CCQ0fGiOg=;
	b=I5UBKn3Ovz2jtT89sYKZvF1Dgnf+L7BSPXsO9qxse5RN6GPJ5xMR3qJ1FJHH7B2y
	htr6qbRBJa7DSjsicbnv76R+S6zrb7zK2YKNZHcWuunihc3h5knNQD8JoLvJmfhya4u
	3VWWq5SlDAqWSLmC4j2f5T1Vcsjk/eFvnxLjNJO0=
Received: by mx.zohomail.com with SMTPS id 1774014821313621.7726431624249;
	Fri, 20 Mar 2026 06:53:41 -0700 (PDT)
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
Subject: [PATCH v4 2/9] hook: parse the hook.jobs config
Date: Fri, 20 Mar 2026 15:53:04 +0200
Message-ID: <20260320135311.331463-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260320135311.331463-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
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
index 0e09b9a2bb..c4872d8707 100644
--- a/hook.c
+++ b/hook.c
@@ -127,11 +127,13 @@ struct hook_config_cache_entry {
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
 
@@ -244,7 +260,7 @@ void hook_cache_clear(struct strmap *cache)
 /* Populate `cache` with the complete hook configuration */
 static void build_hook_config_map(struct repository *r, struct strmap *cache)
 {
-	struct hook_all_config_cb cb_data;
+	struct hook_all_config_cb cb_data = { 0 };
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 
@@ -252,7 +268,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	strmap_init(&cb_data.event_hooks);
 	string_list_init_dup(&cb_data.disabled_hooks);
 
-	/* Parse all configs in one run. */
+	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
 
 	/* Construct the cache from parsed configs. */
@@ -296,6 +312,9 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
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

