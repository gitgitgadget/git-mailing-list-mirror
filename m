Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B133A711
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390789; cv=pass; b=XfIE1Zt73KsfVm6hXYTZ8BIKL83TmGoulttydn1qLATFyaatYM0F+IJAH6AVuwvJavu7zsxthClf3dnbubq2f0IkCiXW1nswquif0fal9/EGlQ0mBEkkdA8HktNkn3nYN+s43cEZTvReAjBP58wqI3DcqRcWfDnwRTIFqyaoeMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390789; c=relaxed/simple;
	bh=uY/Wt4rW6T0RdeiHF7xCdyyliyNIfrYTFLmcAjhN4K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkK1h0xJn3GzY/o3A0zoWzq9CV7Cp/WKK/+ksuBskz4tR+fTRDGdWP8ETRUNqlvdXV5maFPVqPNnFv3cBm/qIrHXXyOOWiriso/R84LRNc/poGauHXT6nbh/+Ou5cqLBHj5YBAiBgPCr0WEXYY6nw7bMLJFRqUMq1kXtpUSDboQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Q+Ag6mHx; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Q+Ag6mHx"
ARC-Seal: i=1; a=rsa-sha256; t=1772390775; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EwN3bmIFCCZPtdYqTtCRIIzFqdX7s/xu/iIFp7NutgvSzNj6nAU9i1m96wT7/XbEjXXouW0WMYbUJKloR7m+qSgbb73gQgXYLMVn+VXS5fDKLN4463UZxefdqFfPe8U+qGOaNfP+psznSQ9Xd/fl0Q6LYC2GFOZLsCDWvxTPZWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390775; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h2aWsUmLcozDgWzhgXFEe3/4yAIr/LLHqTnebz4auug=; 
	b=QDIpj1jeocuZbP/lCHmir4hGZeAT/QniDy6hqINa9YmsLH54ZHdHwCIHUcIiZXardnS3P2dRNNpYt6Hm00xTRFQH7Yn3JbtU7YS0dLERN28ZwS/YfOn8eZa24racvETdnyLjUJImj74e7z9TcReF8Oi/CdEBSMFzzRREMSFjbss=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390775;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h2aWsUmLcozDgWzhgXFEe3/4yAIr/LLHqTnebz4auug=;
	b=Q+Ag6mHxER1MGqKDHIV94bYwUb9BhWW4ahNUvQurjTfTmGfk+QZPRs7pnFFzkMg0
	ijmo5ZQOpAjsZhv/kC2Lpi6YlVgBWDQEwjJ7w8q0DafNXLVilAuC3L9QY6d4PFmv+jj
	RxoFbzduqelFst1nUdn3Q+JyCE0P/80kZ5YySnqw=
Received: by mx.zohomail.com with SMTPS id 1772390772701957.8767409629355;
	Sun, 1 Mar 2026 10:46:12 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 07/12] hook: allow event = "" to overwrite previous values
Date: Sun,  1 Mar 2026 20:44:55 +0200
Message-ID: <20260301184500.1488433-8-adrian.ratiu@collabora.com>
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

Add the ability for empty events to clear previously set multivalue
variables, so the newly added "hook.*.event" behave like the other
multivalued keys.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  4 +++-
 hook.c                         | 31 ++++++++++++++++++++-----------
 t/t1800-hook.sh                | 12 ++++++++++++
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 4bbda5636d..d0023b2deb 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -12,7 +12,9 @@ hook.<friendly-name>.event::
 	linkgit:githooks[5] for a complete list of hook events.) On the
 	specified event, the associated `hook.<friendly-name>.command` is executed.
 	This is a multi-valued key. To run `hook.<friendly-name>` on multiple
-	events, specify the key more than once. See linkgit:git-hook[1].
+	events, specify the key more than once. An empty value resets
+	the list of events, clearing any previously defined events for
+	`hook.<friendly-name>`. See linkgit:git-hook[1].
 
 hook.<friendly-name>.enabled::
 	Whether the hook `hook.<friendly-name>` is enabled. Defaults to `true`.
diff --git a/hook.c b/hook.c
index 24eb330cac..696919e703 100644
--- a/hook.c
+++ b/hook.c
@@ -133,18 +133,27 @@ static int hook_config_lookup_all(const char *key, const char *value,
 	hook_name = xmemdupz(name, name_len);
 
 	if (!strcmp(subkey, "event")) {
-		struct string_list *hooks =
-			strmap_get(&data->event_hooks, value);
+		if (!*value) {
+			/* Empty values reset previous events for this hook. */
+			struct hashmap_iter iter;
+			struct strmap_entry *e;
+
+			strmap_for_each_entry(&data->event_hooks, &iter, e)
+				unsorted_string_list_remove(e->value, hook_name, 0);
+		} else {
+			struct string_list *hooks =
+				strmap_get(&data->event_hooks, value);
+
+			if (!hooks) {
+				CALLOC_ARRAY(hooks, 1);
+				string_list_init_dup(hooks);
+				strmap_put(&data->event_hooks, value, hooks);
+			}
 
-		if (!hooks) {
-			hooks = xcalloc(1, sizeof(*hooks));
-			string_list_init_dup(hooks);
-			strmap_put(&data->event_hooks, value, hooks);
+			/* Re-insert if necessary to preserve last-seen order. */
+			unsorted_string_list_remove(hooks, hook_name, 0);
+			string_list_append(hooks, hook_name);
 		}
-
-		/* Re-insert if necessary to preserve last-seen order. */
-		unsorted_string_list_remove(hooks, hook_name, 0);
-		string_list_append(hooks, hook_name);
 	} else if (!strcmp(subkey, "command")) {
 		/* Store command overwriting the old value */
 		char *old = strmap_put(&data->commands, hook_name,
@@ -160,7 +169,7 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			break;
 		case 1: /* enabled: undo a prior disabled entry */
 			unsorted_string_list_remove(&data->disabled_hooks,
-						    hook_name);
+						    hook_name, 0);
 			break;
 		default:
 			break; /* ignore unrecognised values */
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index fb8cfc8137..c14ec661b9 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -225,6 +225,18 @@ test_expect_success 'git hook list reorders on duplicate event declarations' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list: empty event value resets events' '
+	setup_hooks &&
+
+	# ghi is configured for pre-commit; reset it with an empty value
+	test_config hook.ghi.event "" --add &&
+
+	# only def should remain for pre-commit
+	echo "def" >expected &&
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'hook can be configured for multiple events' '
 	setup_hooks &&
 
-- 
2.52.0.732.gb351b5166d.dirty

