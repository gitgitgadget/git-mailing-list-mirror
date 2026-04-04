Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC01371072
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775291433; cv=pass; b=OcGSsTf1FI5j4z4BFBSKvvPve+JF3cU/D/RbrIKo9rf58VyW/epXkeJrxk+WlFNhUqMNwjPxT9TwjUt+GHEU1G5V9nKVcI7Z0SwGFcE873qWR2OluxRBh3yMcj3E9MBgMsZc3IAt9bdFsIZG21Jke1e8oTUVenlpn0pqZ63OF7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775291433; c=relaxed/simple;
	bh=R3XxNvvQDdujBCQxWJraDPKvwHAtP/yhj5x9qGK9cbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdD+u2CYSLcSlC/0u2rUYBwP0/IayQsen5ollEvroUeK58XsNYwvsqTZ0zndoLYRi+TZinf0TswENlFmSL11ZTiWjIBAXFtgpTxKpmc5e++BP5pDT4AvYWJUmooeGSpYrGJ0zopsNelKcTy+Do6hBoWUJVkNiCnXpwhqD1Owl8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cGFITabK; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cGFITabK"
ARC-Seal: i=1; a=rsa-sha256; t=1775291416; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B/ODKzegy+5ey7hekkPrSSLLzVcfkVLQQFWT4aeKunx3DAlHBUG/bv3gelh0e24fBvqk9z9EnM/nSJo/SRAavai4WcEtmZ6o/Qv6nM6Ci+hAca0SoQDwtYSZJgne8OTI2DpuVRwThkYN1SIlfbGa6B1jAP/nfmCdM8baskVUnbU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775291416; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uwsF1QNPRNcP2Se+FdeDcKJDFbpBtDbdBvIAIPEVW2U=; 
	b=OE+t6pwFmu8XfZS+o1jFYOvovC/UewQUxTZnPeWA9N9WcxM6VWUc0zbXixfI97cb+PGx1mrgBt1n3Dk3YVR9eXasIExSPun9jPoqbcO2wkWlpOIO1rU1ebdGPrpHtkOxGqdXoX03MdGKGWHDLmBj49rZchEETs4B9802oux4Ez8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775291416;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uwsF1QNPRNcP2Se+FdeDcKJDFbpBtDbdBvIAIPEVW2U=;
	b=cGFITabKHs1UdVXsOaRr5jfSgR7r+7HdYw9xEYYZKfxWiYeP/8yxia6iTyd9sd3f
	SNOu+vdcN2b/GrvlB7pRTCwFNBVpaqnz3j90kmzeXmAhmobvoUckj+g1Q/WfV1cECC0
	3uR8YVMnNP6oNRj/Xb3EqobaLmi0FdhlRSir32Bo=
Received: by mx.zohomail.com with SMTPS id 1775291414629830.1041859468497;
	Sat, 4 Apr 2026 01:30:14 -0700 (PDT)
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
Subject: [PATCH v6 09/12] hook: warn when hook.<friendly-name>.jobs is set
Date: Sat,  4 Apr 2026 11:29:31 +0300
Message-ID: <20260404082934.173788-10-adrian.ratiu@collabora.com>
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
index ab2b52bec6..85b055a897 100755
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
2.52.0.732.gb351b5166d.dirty

