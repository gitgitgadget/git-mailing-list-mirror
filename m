Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E03B9D9A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812048; cv=pass; b=ShV6W8McYDR+1LP2DjwZMx+UK5P04yDiotJ6s/u7Gl3NM1bGb3bX4r2lNCdhFIipcyaYtHDmw7DnCat62tqqEytEJkxgeGHjNGTikY0IJ5v6zygt+YmoiJqLFFEMH3IuKn/OfNZrrc+uMSdJ+LrDZrWv2rpDiZLyJBJfOzTE/MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812048; c=relaxed/simple;
	bh=QABYY0ha+Vdg2eQJ2joKp6R6LIhgnzt5kajDHS5pb0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNExUUrXdnLts+jk+cRUb+F2TINSldYyN3KSxAa/OGfG0RBZeYKgQmBajOMFkABZ3suszliISRmqjg5B8O6PIt36XjDKIR6WCG7DfknZzOw8IThskWVhH3zbIOObwF3FPQsHotIjHDZZHQU+7MByEwcrGi5j85aUHyFR2e56Dlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=SkHyzTUr; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="SkHyzTUr"
ARC-Seal: i=1; a=rsa-sha256; t=1775812031; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=enfI1Kv+5GgBqgoa4iIwFnoAYmJ/AjGoqI/5NJSzjCeEBUL8iIa8Yw9Jviektoel8VBCfyiLYTh7E2SneWkL1t5A6+VA4iXsgjVDU3RWRO3CX9iSpg/mu4N/vAXz3ssoCIOuw7BGh6SK0b4Vt1rO59lIIgovUuzPWVatn3tLha8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775812031; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hprDJDJVD3Quso/zGc8MJcw5C4qN57SNjwqspEfufUk=; 
	b=WkPUAAdg6qOllx/wHGXpAfypZADj7GBcWOxwRLxayjCboFGK3R6dPlTRWLcMToVjQpkyJsCxOCqBI9eYVGeIu1CxJ3leBvLWz9nxkWu/MBv085ZV7GIrNa+MMaQLQyFKJS7EzxrMphz8m8/YglhzqBJkHyebEJVKGlyEzEjDrYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775812031;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hprDJDJVD3Quso/zGc8MJcw5C4qN57SNjwqspEfufUk=;
	b=SkHyzTUrP5lHgRKyqNBvR/vOrZE4IWCW9vOS9q2S9ttCPic3AxPBHs18g4uXTB4r
	kgZAwlfNfiCX0WcH0xRiMSAv+sEt/ViL1eCynupDbNgfI2JdhOxDnV11LGQbTVOJgtE
	3OkhXanLZ9me+P5aTnRGDe/ZqozwPJnPoHTWGeEc=
Received: by mx.zohomail.com with SMTPS id 1775812028918566.0775693778116;
	Fri, 10 Apr 2026 02:07:08 -0700 (PDT)
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
Subject: [PATCH v7 09/13] hook: warn when hook.<friendly-name>.jobs is set
Date: Fri, 10 Apr 2026 12:06:04 +0300
Message-ID: <20260410090608.75283-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410090608.75283-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260410090608.75283-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Issue a warning when the user confuses the hook process and event
namespaces by setting hook.<friendly-name>.jobs.

Detect this by checking whether the name carrying .jobs also has
.command, .event, or .parallel configured.  Extract is_friendly_name()
as a helper for this check, to be reused by future per-event config
handling.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c          | 40 ++++++++++++++++++++++++++++++++++++++++
 t/t1800-hook.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/hook.c b/hook.c
index d98b011563..0493993bbe 100644
--- a/hook.c
+++ b/hook.c
@@ -279,6 +279,44 @@ void hook_cache_clear(struct strmap *cache)
 	strmap_clear(cache, 0);
 }
 
+/*
+ * Return true if `name` is a hook friendly-name, i.e. it has at least one of
+ * .command, .event, or .parallel configured. These are the reliable clues
+ * that distinguish a friendly-name from an event name. Note: .enabled is
+ * deliberately excluded because it can appear under both namespaces.
+ */
+static int is_friendly_name(struct hook_all_config_cb *cb, const char *name)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	if (strmap_get(&cb->commands, name) || strmap_get(&cb->parallel_hooks, name))
+		return 1;
+
+	strmap_for_each_entry(&cb->event_hooks, &iter, e) {
+		if (unsorted_string_list_lookup(e->value, name))
+			return 1;
+	}
+
+	return 0;
+}
+
+/* Warn if any name in event_jobs is also a hook friendly-name. */
+static void warn_jobs_on_friendly_names(struct hook_all_config_cb *cb_data)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	strmap_for_each_entry(&cb_data->event_jobs, &iter, e) {
+		if (is_friendly_name(cb_data, e->key))
+			warning(_("hook.%s.jobs is set but '%s' looks like a "
+				  "hook friendly-name, not an event name; "
+				  "hook.<event>.jobs uses the event name "
+				  "(e.g. hook.post-receive.jobs), so this "
+				  "setting will be ignored"), e->key, e->key);
+	}
+}
+
 /* Populate `cache` with the complete hook configuration */
 static void build_hook_config_map(struct repository *r, struct strmap *cache)
 {
@@ -295,6 +333,8 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
 
+	warn_jobs_on_friendly_names(&cb_data);
+
 	/* Construct the cache from parsed configs. */
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
 		struct string_list *hook_names = e->value;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 24a3c92b6d..89fedc48ff 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1028,4 +1028,34 @@ test_expect_success 'hook.<event>.jobs still requires hook.<name>.parallel=true'
 	test_cmp expect hook.order
 '
 
+test_expect_success 'hook.<friendly-name>.jobs warns when name has .command' '
+	test_config hook.my-hook.command "true" &&
+	test_config hook.my-hook.jobs 2 &&
+	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
+	test_grep "hook.my-hook.jobs.*friendly-name" err
+'
+
+test_expect_success 'hook.<friendly-name>.jobs warns when name has .event' '
+	test_config hook.my-hook.event test-hook &&
+	test_config hook.my-hook.command "true" &&
+	test_config hook.my-hook.jobs 2 &&
+	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
+	test_grep "hook.my-hook.jobs.*friendly-name" err
+'
+
+test_expect_success 'hook.<friendly-name>.jobs warns when name has .parallel' '
+	test_config hook.my-hook.event test-hook &&
+	test_config hook.my-hook.command "true" &&
+	test_config hook.my-hook.parallel true &&
+	test_config hook.my-hook.jobs 2 &&
+	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
+	test_grep "hook.my-hook.jobs.*friendly-name" err
+'
+
+test_expect_success 'hook.<event>.jobs does not warn for a real event name' '
+	test_config hook.test-hook.jobs 2 &&
+	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
+	test_grep ! "friendly-name" err
+'
+
 test_done
-- 
2.52.0

