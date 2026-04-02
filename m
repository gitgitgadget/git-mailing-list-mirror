Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FF37F74A
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113601; cv=none; b=Iqr/BYqaEdSElrrzJKyssyAD3pYi02Fybq7wOFvmi6GJgJp0qQ9XpcgK4ZnGbOxVi4rnITL5XGH0Xu3xJLNlsViZM1HKF1WzHvDTQFgZjZBbONdp4qYD8laDcCBxt7+6cA7UZQOoid2VMD3YoGFoh6c5SCV6OeI5I/US7BgYOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113601; c=relaxed/simple;
	bh=rk0/BEXlLPTBDczw8eroXiLEJDD6nQolEu5cYsh0wJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbY1w7MCSAhAmuXHCJTxOyiHBm+VlWiPHHcc1HJApfNrQuIMFxi2cyEE0VloWmMpzGwMTGPFDKHNPorvEc0QlJuEYnBQTwn7noh6OjDaVGPtX82WnZ7FdExImBADA4tfoA2gSEN0VcNyDQX+HFwmuPtJMVziL19J/Ldid8zQLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk6v6VTX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk6v6VTX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so3467455e9.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113598; x=1775718398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzzTgdS5xkJyyjz/oeG5O7a/F10WgijVSo8BwjTxCcw=;
        b=Nk6v6VTXNcNmjhZ3uI+Za1VtcT1sMyyV/lmD2pwxLOERaUQmWEQKKBOxTJLTnG1g8D
         rAXpuGJHIueY+yMlVW1Z5T0MWYjcIZTa/e+bPdIquFLzRGSSmOwLvAfDK9JK9G9Hj3Lu
         rH4Sd4P0YnTKySHr65H6fs4TYYKIAdfviEmQUQT6itNF2wd9dvHzZGWiTCNvZ4ySwFF/
         K63XOyixv8Jcd2DSoHVn8T3i9eXmm9+6z5G7xmXysGqHOEILi6X5A+9mnXzbg5Catbuu
         Yv+vw5JdTyFnL0VFIS29XVxqplDeXCutByUpvSxkGkZm+4GXCxp9XBZe+bKxE0QdTkOk
         K14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113598; x=1775718398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzzTgdS5xkJyyjz/oeG5O7a/F10WgijVSo8BwjTxCcw=;
        b=J7cBy+QChbv3MfwJ1ScEVvNkfzsB1nGnL2GM9g9rzCDDNnrseuu8WvpvkPohDyNRUJ
         Am3iGA+ZKlRg6eIxbAAQ8NhToInBLUQV4IjvmZOi9xScwwiG8p+u6nakWETHNzh8+qvn
         WOP8zXYbidIaQXDg2wbNgoBSgCghrc+NtLL/JHKwYfaLXOFNvNxth9J4nnQ+C1UR81OS
         aNVtsIlhihC0pwWsHBe0uGtIpCFzFAtyJTpf9kr5wEq+CBC4fMIeI0KBZCpGItRHwUbo
         B67G7E/+hguYlff4t4RvL1T0U5swMP1BCm4zk9s6IPEMBIp4Itz2fig1y7vxQXhDYf5w
         A27g==
X-Gm-Message-State: AOJu0YwHXIA28wCIrFa/urA6OupflYFKhwIyS+bNh9M/PTrt6AZumnyA
	KmJvKN8nH7rI5eENZsHVHm7YiX9jfnHK17JJk1rd7l5JMCyApgIcDpc6nfKjdQ==
X-Gm-Gg: ATEYQzxQWWmnoDnMQCfzGPHzHeXF2G/u3LBtUwrxmyMCF/AmVXgdb1fBL6ZCO2Iu2KU
	DcVrchY3ywGeNQIKZq8Qo+hudmCMKCKVCpP1lNe+4irbVGsyXel7LMFhSCYz64jUkL5H33SO4Cj
	dy1fhkvEQdA4B4UWo97GpHDKwPvfNXS1CpuSmnrwxfDqqx0i3gaTcgDheP64oxk11/04ctopv3s
	AB6+qgJbkDabMyyXucxRRwwlgVkmgJaSbgyvIsVHi6DpTDE451HmlHwgT6+L0YIxrygEZzTyvql
	RB7w3Nq6JNcf0xWDkzSTmCoG6Y675RHH3kHMcrlOgHB/YwJf3McPYT0EdB7gHn7Vl82D8jtD09e
	6C7yitfXq9dCSBHu0MctHc5vmycRLGxizpVBZ3Vj6LhbDyGdtSuZZoYqPmlL6oaoOn+kwGco6Xm
	aol71MzRNYiZI3EWgM87FIZrC3uuTJBzSK/3Ki+h5UYL7XNAVseBudWsGqjlAvEFViJIT7eQxST
	IQMG7UVeEi4UJzE8YKLhvwbYahuY732jAmsOtI=
X-Received: by 2002:a05:600c:8483:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-4888e0cf3a0mr18945905e9.14.1775113597413;
        Thu, 02 Apr 2026 00:06:37 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:36 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/10] promisor-remote: pass config entry to all_fields_match() directly
Date: Thu,  2 Apr 2026 09:06:05 +0200
Message-ID: <20260402070613.85934-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `in_list == 0` path of all_fields_match() looks up the remote in
`config_info` by `advertised->name` repeatedly, even though every
caller in should_accept_remote() has already performed this
lookup and holds the result in `p`.

To avoid this useless work, let's replace the `int in_list`
parameter with a `struct promisor_info *config_entry` pointer:

 - When NULL (ACCEPT_ALL mode): scan the whole `config_info` list, as
   the old `in_list == 1` path did.

 - When non-NULL: match against that single config entry directly,
   avoiding the redundant string_list_lookup() call.

This removes the hidden dependency on `advertised->name` inside
all_fields_match(), which would be wrong if in the future
auto-configured remotes are implemented, as the local config name may
differ from the server's advertised name.

While at it, let's also add a comment before all_fields_match() and
match_field_against_config() to help understand how things work and
help avoid similar issues.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 7ce7d22f95..6c935f855a 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -575,6 +575,12 @@ enum accept_promisor {
 	ACCEPT_ALL
 };
 
+/*
+ * Check if a specific field and its advertised value match the local
+ * configuration of a given promisor remote.
+ *
+ * Returns 1 if they match, 0 otherwise.
+ */
 static int match_field_against_config(const char *field, const char *value,
 				      struct promisor_info *config_info)
 {
@@ -586,9 +592,18 @@ static int match_field_against_config(const char *field, const char *value,
 	return 0;
 }
 
+/*
+ * Check that the advertised fields match the local configuration.
+ *
+ * When 'config_entry' is NULL (ACCEPT_ALL mode), every checked field
+ * must match at least one remote in 'config_info'.
+ *
+ * When 'config_entry' points to a specific remote's config, the
+ * checked fields are compared against that single remote only.
+ */
 static int all_fields_match(struct promisor_info *advertised,
 			    struct string_list *config_info,
-			    int in_list)
+			    struct promisor_info *config_entry)
 {
 	struct string_list *fields = fields_checked();
 	struct string_list_item *item_checked;
@@ -597,7 +612,6 @@ static int all_fields_match(struct promisor_info *advertised,
 		int match = 0;
 		const char *field = item_checked->string;
 		const char *value = NULL;
-		struct string_list_item *item;
 
 		if (!strcasecmp(field, promisor_field_filter))
 			value = advertised->filter;
@@ -607,7 +621,11 @@ static int all_fields_match(struct promisor_info *advertised,
 		if (!value)
 			return 0;
 
-		if (in_list) {
+		if (config_entry) {
+			match = match_field_against_config(field, value,
+							   config_entry);
+		} else {
+			struct string_list_item *item;
 			for_each_string_list_item(item, config_info) {
 				struct promisor_info *p = item->util;
 				if (match_field_against_config(field, value, p)) {
@@ -615,12 +633,6 @@ static int all_fields_match(struct promisor_info *advertised,
 					break;
 				}
 			}
-		} else {
-			item = string_list_lookup(config_info, advertised->name);
-			if (item) {
-				struct promisor_info *p = item->util;
-				match = match_field_against_config(field, value, p);
-			}
 		}
 
 		if (!match)
@@ -640,7 +652,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
-		return all_fields_match(advertised, config_info, 1);
+		return all_fields_match(advertised, config_info, NULL);
 
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
@@ -652,7 +664,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	p = item->util;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return all_fields_match(advertised, config_info, 0);
+		return all_fields_match(advertised, config_info, p);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -663,7 +675,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	}
 
 	if (!strcmp(p->url, remote_url))
-		return all_fields_match(advertised, config_info, 0);
+		return all_fields_match(advertised, config_info, p);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, p->url, remote_url);
-- 
2.53.0.765.g57b94de1f0.dirty

