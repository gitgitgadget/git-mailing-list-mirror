Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186F30DD22
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390787; cv=pass; b=YRc3I788CBnqPt9I1ySKTpvXk8XIkcfUAqWzxSmL8mJcpzeAJcIbNewQ20TKoOZrdQOYksbwF4cbN/ACVK5/A1Oo43zAGMVEHLHWaEbv/9zReOISFgQXwlXpMQjhpt2e2xapJmIigAT1siQ0rugO+WRH5/qlDjtR8NHeaR8+n4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390787; c=relaxed/simple;
	bh=CEFdE96raV0m3iEt1BmJ2fI7M92BPVdaamxBiXKtlpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnXXoLksyXxGHwca30UvanhHPuA+Als1hOwXPAD4dCWG3xShU2LPNjpRQz3und+08Mv0A3Ej5Tq20HiIZ5uV55REGUKla8mkJnWgsaWDMKrGvR9i/qUZ2aHM0wBrDrGvUBKGXq5YlftqCdxgxh5T3mzxbUXek5zaCxVsQ39gkrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=RGQjLwER; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="RGQjLwER"
ARC-Seal: i=1; a=rsa-sha256; t=1772390771; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CV8QQUAU6MzwRDusN91x4OB6AY9Y8RYBUtBDJuE0PZ6i1//McF5qKkQR33UbcuaJV82qPvR5kQxZ5ddlbxzIcr8Y+80VjhZcN9P/4akD38tFBsDg1A+l0e22AVJpc10XYg0aYKQfJDMB/7s9rY+AA2tvNzHdDSYVuW8iNYbOE4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390771; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0e94mgH4BlcxJz7omAd0oBOCR/Ji88FsKl5oCqiXm9A=; 
	b=j77KaR4iQ/P5/L1ZmvdiwSvg6Ndtlj5ItXF+dGPOOSXRLw8SeliTbIYMZFQrn9Gte93rHEUf4uSCkvbzzS7GPAIaJD7aTNLN8kzrK0Shp/GkIRBC/nzRKJm9nXVdWgADJiJ9y5OMxiEGIs3SDXuksybDXVi8IpSyIPuhH7McX84=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390771;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0e94mgH4BlcxJz7omAd0oBOCR/Ji88FsKl5oCqiXm9A=;
	b=RGQjLwERr6BCBYaZqmeGKJWJZ+kGEkoFJ1ygojWlOqFLaSwpin2279/ZzHNlKkWF
	mbjf8vXaVlujqQ42CYZgTG9aFUEvbPOJUgQlpxZQYKS73u4Z4BHgTo2dSnMcddu1cT6
	V6y13RD1UK/LB709Ij4pxk5Ya9si2SFYmXpJFgtA=
Received: by mx.zohomail.com with SMTPS id 177239077051691.7430440815699;
	Sun, 1 Mar 2026 10:46:10 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 06/12] hook: allow disabling config hooks
Date: Sun,  1 Mar 2026 20:44:54 +0200
Message-ID: <20260301184500.1488433-7-adrian.ratiu@collabora.com>
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

Hooks specified via configs are always enabled, however users
might want to disable them without removing from the config,
like locally disabling a global hook.

Add a hook.<friendly-name>.enabled config which defaults to true and
can be optionally set for each configured hook.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  7 +++++++
 hook.c                         | 24 ++++++++++++++++++++++++
 t/t1800-hook.sh                | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 7ac1b079cc..4bbda5636d 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -13,3 +13,10 @@ hook.<friendly-name>.event::
 	specified event, the associated `hook.<friendly-name>.command` is executed.
 	This is a multi-valued key. To run `hook.<friendly-name>` on multiple
 	events, specify the key more than once. See linkgit:git-hook[1].
+
+hook.<friendly-name>.enabled::
+	Whether the hook `hook.<friendly-name>` is enabled. Defaults to `true`.
+	Set to `false` to disable the hook without removing its
+	configuration. This is particularly useful when a hook is defined
+	in a system or global config file and needs to be disabled for a
+	specific repository. See linkgit:git-hook[1].
diff --git a/hook.c b/hook.c
index b67ec4ff22..24eb330cac 100644
--- a/hook.c
+++ b/hook.c
@@ -105,10 +105,12 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
  * event_hooks: event-name to list of friendly-names map.
+ * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
  */
 struct hook_all_config_cb {
 	struct strmap commands;
 	struct strmap event_hooks;
+	struct string_list disabled_hooks;
 };
 
 /* repo_config() callback that collects all hook.* configuration in one pass. */
@@ -148,6 +150,21 @@ static int hook_config_lookup_all(const char *key, const char *value,
 		char *old = strmap_put(&data->commands, hook_name,
 				       xstrdup(value));
 		free(old);
+	} else if (!strcmp(subkey, "enabled")) {
+		switch (git_parse_maybe_bool(value)) {
+		case 0: /* disabled */
+			if (!unsorted_string_list_lookup(&data->disabled_hooks,
+							 hook_name))
+				string_list_append(&data->disabled_hooks,
+						   hook_name);
+			break;
+		case 1: /* enabled: undo a prior disabled entry */
+			unsorted_string_list_remove(&data->disabled_hooks,
+						    hook_name);
+			break;
+		default:
+			break; /* ignore unrecognised values */
+		}
 	}
 
 	free(hook_name);
@@ -184,6 +201,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 
 	strmap_init(&cb_data.commands);
 	strmap_init(&cb_data.event_hooks);
+	string_list_init_dup(&cb_data.disabled_hooks);
 
 	/* Parse all configs in one run. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
@@ -200,6 +218,11 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 			const char *hname = hook_names->items[i].string;
 			char *command;
 
+			/* filter out disabled hooks */
+			if (unsorted_string_list_lookup(&cb_data.disabled_hooks,
+							hname))
+				continue;
+
 			command = strmap_get(&cb_data.commands, hname);
 			if (!command)
 				die(_("'hook.%s.command' must be configured or "
@@ -215,6 +238,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	}
 
 	strmap_clear(&cb_data.commands, 1);
+	string_list_clear(&cb_data.disabled_hooks, 0);
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
 		string_list_clear(e->value, 0);
 		free(e->value);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 3a95cfe16d..fb8cfc8137 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -343,6 +343,38 @@ test_expect_success 'rejects hooks with no commands configured' '
 	test_grep "hook.broken.command" actual
 '
 
+test_expect_success 'disabled hook is not run' '
+	test_config hook.skipped.event "test-hook" &&
+	test_config hook.skipped.command "echo \"Should not run\"" &&
+	test_config hook.skipped.enabled false &&
+
+	git hook run --ignore-missing test-hook 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'disabled hook does not appear in git hook list' '
+	test_config hook.active.event "pre-commit" &&
+	test_config hook.active.command "echo active" &&
+	test_config hook.inactive.event "pre-commit" &&
+	test_config hook.inactive.command "echo inactive" &&
+	test_config hook.inactive.enabled false &&
+
+	git hook list pre-commit >actual &&
+	test_grep "active" actual &&
+	test_grep ! "inactive" actual
+'
+
+test_expect_success 'globally disabled hook can be re-enabled locally' '
+	test_config_global hook.global-hook.event "test-hook" &&
+	test_config_global hook.global-hook.command "echo \"global-hook ran\"" &&
+	test_config_global hook.global-hook.enabled false &&
+	test_config hook.global-hook.enabled true &&
+
+	echo "global-hook ran" >expected &&
+	git hook run test-hook 2>actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'git hook run a hook with a bad shebang' '
 	test_when_finished "rm -rf bad-hooks" &&
 	mkdir bad-hooks &&
-- 
2.52.0.732.gb351b5166d.dirty

