Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813224;
	b=CEyST8sWhzsR1gsmhROTyIqWEEUkwUs2+0ObX0MXch5fRzgBmCYZcqo2gpg6u5IRLtmQ
	 FComA784pCZVJgIBCq9lVa4yvdtp2kjtA/+PkfF+QHiFMuh3OTX3HeEzohLu/OXSGS5q+
	 m2xWLrkxWeofWFGYELP3uow07/tN/29rKfFs6ILwg/ucc4L2FMcxZnmAnDNCXuE7k29nz
	 AlCz+oRzj2XWbUL4sI5wIUcUvH/2wKjSqbW9x/eOWSP/v1bsVn/2AGQx2V8OrJWhfAb7l
	 Bq6yg3Igtefz3VMDmixXF/QxVSEA0nlBR8mX/t+qb3oY2hiv/CHB4eDRiXI7orAhBcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ON+UYePldhXle6and4qhp84bQ2ywWhbKt1uziTy+zFE=;
	b=ULczsOeZaQpULEEDlvUXMVR8W09iQw2kDLroZrB/G/n8GAiWcoJGERSsUxSWYuUkKPsZ
	 +bNv+/6tm5LQDlnnQgUZA3C1CBbUg8F0Uwj215jjVLYPVgJxiBCPh2HSQCxDS7uspORpw
	 GfrrCVaHNaokV+Kgj0QxYiLzM0gAEczRyochxlopUX65AfSBcmmjc7HOYXXj/yzcAYJZP
	 YBBlX/dWv4V6eF+SWLaOyAEn+rK9X405YU3xCZma2QI990pIotGv54uN0NjZ9ng8tmlBs
	 rqOWSTmvMCkRX7GjDI9CDUhWP71+C++ldNXYw42cIzdLtAqm5yYXbKI74OFdHTDbf/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMLyHzPx;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A7606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32A7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMLyHzPx
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so6372345e9.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813222; x=1794418022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ON+UYePldhXle6and4qhp84bQ2ywWhbKt1uziTy+zFE=;
        b=dMLyHzPx45gGIKyGLd72cRIv/CZcnDSFWqulZER84v85t/8uLYayc+JapMQIs4ay1R
         6JgQhhbCCF4SGmRTsodEDYTM0ulNkekP0PbStkz3cyInzyxiQZL2YINgqyVM6fce5prz
         qugLMpMCjBDJ+MTaBsnk8e/3I3kv876lxjub/iO/PEKoNF1VYbSwIeiMzxUQncj0mL4E
         fAnLVOpMqlpd2reWyxKctkBuOBERFBDNoMKvL0v+NSny8tayf+aK3I6qrI2j7K2+cFQ3
         gRRfey8bV1TKcCoiZJR7yFkXz09+hat57MrZyh8ZwsnlJVVbLgcuFUG+/hv4IKGXhHC1
         nRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813222; x=1794418022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ON+UYePldhXle6and4qhp84bQ2ywWhbKt1uziTy+zFE=;
        b=ZJZpNWvsGleryKIe4s7b+vfn1Fn9ZUHdIHMw+ZuDNf6nx3BPbq6P9tQK5pc1IMTqvg
         cxfG5TUInOdLWwS8P8RQbo0LGQ83RMRm7H2cKWR9fpt/R00LRJasyCVss8tfSaDCQHoq
         ptdKY41QH+zz9HK93RngYhrGlfdi3hXxtXluhkpkvRub3fmFD5oEnFARilm8ri2zwrRT
         Ho9JJO/unXlFoKii2hxfZshA4HuSK3MOHGCdOBHQQNMDYbcoTFEufyvI/073+eZl8f9K
         kjYTOwUScOTOz0+pnAZV3TdUKmcbi4IAEeHEHEd+jN9avNHTBIDrgd61abLO8feYkcAl
         r4GQ==
X-Gm-Message-State: APuU4Z+ihs1FD+FztNZAtlyvAGQ5fOUqlj3V0EgX3qLvyGiJwRD1Q2uj
	xtsNJeO2vAl9k9zC9qqSPuTGs7Uf3tAPRsp9Aspc1TLHOWTlv2HWiKiw//mSFA6g
X-Gm-Gg: AYBFou1sgZPksV9x1ZAsTfTUeEMmL3t0TH5QlHgWpTGh7iAxMFxgWQkvnAkg04IAMov
	JG1uIVgIig0/4gPEK+StqtGWNaEbji1Fp7uQwxoT+L+/RTGbxjL2zrYw2wLL+RDk+9JVYUuard5
	Jh1GjNv5ArW5B0qg+mVR3cDhu/VwpT1nlANgI5E4xREzQQ3AGHBMMUDr8FgzoudaHlcPOA0Ymxa
	W0jXbZN35/aUtx5Dg7PrAwsLOXQJZ+r/+YBcl/twOt3wVxwSW4wBe8je39CCkNkvUt7uFolLTdq
	IqGRq8NCjmMAKggn66qkdqx9yhMz99EBHEFAH10oHYotphgVZXcdvTdoEigBNohsy2sSn53kBF3
	LgXi6bTPIjtaQ/lRnyLs+q2U8Cp3vRgOq9GscxFkaIkA1j1MIo4p3/DVQoVqWKPYew2UO4AEHou
	0EggLYjb8obcQCdj7uecXVz6US1rmoJq6z5/HOGQuOLpTQipSI9UIF7jO5uN+Vmajc9/+uaio5w
	mA2xK1ZGLqJJ3mynznOM21V3OOSjI/zZVwJxwC9mArRh4MYfkAjbHmAWyf2tYFDYKXKFuUiWPZr
	/346/f3CjgoBdaEHWIR6rKgtvHjONlv7KxDovdGq7JgAIEbYl5B6ra9p6m91Ikf6hWQmtBvvzt5
	gpRTXkTLdg1a459bsvZl/FiBUBA16etpxaxAegBZfakoOEkpqDbMFZlpR
X-Received: by 2002:a05:600c:4e02:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4ac1228b10amr392584965e9.0.1793813222039;
        Wed, 04 Nov 2026 09:27:02 -0800 (PST)
Received: from ngadou-Latitude-5580.. ([129.0.60.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b432a883ffsm29771105e9.3.2026.11.04.09.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:27:00 -0800 (PST)
From: Yopa Nelly <yopatatchou@gmail.com>
To: git@vger.kernel.org
Cc: Nelly Yopa <yopatatchou@gmail.com>
Subject: [Outreachy][PATCH] promisor-remote: honor promisor.fetchOrder when trying remotes
Date: Wed,  4 Nov 2026 18:24:34 +0100
Message-ID: <20261104172434.691381-1-yopatatchou@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nelly Yopa <yopatatchou@gmail.com>

When a repo has multiple promisor remotes, Git just tries them in
the order they happen to be in the config. If you want to try one
remote before another, the only way is to move lines around in the
config file, which is awkward, especially once you have per-worktree
or system/global configs in play.

This adds a promisor.fetchOrder config variable that takes a
comma-separated list of remote names. Remotes listed there are tried
first, in the order they're listed. Remotes that aren't listed are
tried afterwards, in their original config order. The
extensions.partialClone remote still ends up last (that's done by
promisor_remote_move_to_tail() in promisor_remote_init()), unless
someone names it in fetchOrder, in which case its listed position
wins.

The sort happens inside each pass in try_promisor_remotes(), so the
existing "accepted remotes before the rest" behavior is unchanged.
Within each pass, the order from fetchOrder wins.

I put the parser in promisor_remote_config() next to the other
promisor keys. It stores the parsed list in a file-static
string_list. The per-remote order field is set in
promisor_remote_apply_fetch_order(), which runs at the end of
promisor_remote_init() after the partialClone remote has been moved
to the tail. The actual sort is a small stable insertion sort in
promisor_remote_sort(); order == 0 means "not listed" so unnamed
remotes still sort after named ones without losing their relative
order. It's called once at the start of try_promisor_remotes() and
is effectively a no-op on the second pass if the first one already
succeeded.

I didn't validate the names in fetchOrder against the set of
configured promisor remotes. A typo just means that remote doesn't
appear in the list and keeps its default position. That's how other
list-valued config variables in Git behave, and it keeps the parser
small.

No test, and I want to be upfront about why. The t5710 fixture
always has the server satisfy a filtered clone from its own
promisor remote, so the client never actually triggers a lazy fetch
inside that test, which means the ordering change can't be observed
there. I'd need a different fixture, one that gives the client two
promisor remotes and keeps the server out of the picture. I'm happy
to write that as a follow-up if that's the right direction.

Signed-off-by: Yopa Nelly <yopatatchou@gmail.com>
---
 promisor-remote.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++-
 promisor-remote.h |  1 +
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 316d9950aa..56e9eeabe3 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -21,6 +21,9 @@ struct promisor_remote_config {
 	struct promisor_remote **promisors_tail;
 };
 
+static struct string_list fetch_order = STRING_LIST_INIT_DUP;
+static int fetch_order_initialized;
+
 static int fetch_objects(struct repository *repo,
 			 const char *remote_name,
 			 const struct object_id *oids,
@@ -120,6 +123,20 @@ static int promisor_remote_config(const char *var, const char *value,
 	size_t namelen;
 	const char *subkey;
 
+    if (!strcmp(var, "promisor.fetchorder")) {
+		char *value_copy;
+
+		if (!value)
+			return config_error_nonbool(var);
+		value_copy = xstrdup(value);
+		string_list_split_in_place_f(&fetch_order, value_copy, ",", -1,
+					     STRING_LIST_SPLIT_TRIM |
+					     STRING_LIST_SPLIT_NONEMPTY);
+		free(value_copy);
+		fetch_order_initialized = 1;
+		return 0;
+	}
+
 	if (parse_config_key(var, "remote", &name, &namelen, &subkey) < 0)
 		return 0;
 
@@ -157,6 +174,24 @@ static int promisor_remote_config(const char *var, const char *value,
 	return 0;
 }
 
+static void promisor_remote_apply_fetch_order(struct promisor_remote_config *config)
+{
+	struct promisor_remote *r;
+	size_t i;
+
+	if (!fetch_order_initialized)
+		return;
+
+	for (i = 0; i < fetch_order.nr; i++) {
+		for (r = config->promisors; r; r = r->next) {
+			if (!strcmp(r->name, fetch_order.items[i].string)) {
+				r->order = i + 1;
+				break;
+			}
+		}
+	}
+}
+
 static void promisor_remote_init(struct repository *r)
 {
 	struct promisor_remote_config *config;
@@ -180,6 +215,8 @@ static void promisor_remote_init(struct repository *r)
 		else
 			promisor_remote_new(config, r->repository_format_partial_clone);
 	}
+
+	promisor_remote_apply_fetch_order(config);
 }
 
 void promisor_remote_clear(struct promisor_remote_config *config)
@@ -262,6 +299,34 @@ static int remove_fetched_oids(struct repository *repo,
 	return remaining_nr;
 }
 
+static void promisor_remote_sort(struct promisor_remote_config *config)
+{
+	struct promisor_remote *sorted = NULL;
+	struct promisor_remote *r = config->promisors;
+
+	if (!fetch_order_initialized)
+		return;
+
+	while (r) {
+		struct promisor_remote *next = r->next;
+		struct promisor_remote **pp = &sorted;
+
+		while (*pp && ((*pp)->order == 0
+			       ? r->order != 0
+			       : r->order == 0 || (*pp)->order <= r->order))
+			pp = &(*pp)->next;
+
+		r->next = *pp;
+		*pp = r;
+		r = next;
+	}
+
+	config->promisors = sorted;
+	config->promisors_tail = &config->promisors;
+	while (*config->promisors_tail)
+		config->promisors_tail = &(*config->promisors_tail)->next;
+}
+
 /*
  * Fetch the remaining objects (given in '*remaining_oids', which
  * contains '*remaining_nr' object ids) from the known promisor
@@ -286,7 +351,10 @@ static int try_promisor_remotes(struct repository *repo,
 				int depth,
 				bool accepted_only)
 {
-	struct promisor_remote *r = repo->promisor_remote_config->promisors;
+	struct promisor_remote *r;
+
+	promisor_remote_sort(repo->promisor_remote_config);
+	r = repo->promisor_remote_config->promisors;
 
 	for (; r; r = r->next) {
 		if (accepted_only != r->accepted)
diff --git a/promisor-remote.h b/promisor-remote.h
index 301f5ac5cb..679a138bb1 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -17,6 +17,7 @@ struct promisor_remote {
 	char *partial_clone_filter;
 	char *advertised_filter;
 	unsigned int accepted : 1;
+	int order;
 	const char name[FLEX_ARRAY];
 };
 
-- 
2.43.0

