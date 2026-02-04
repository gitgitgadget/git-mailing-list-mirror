Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686133E8C7C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203325; cv=none; b=f2nNYFyxnGbQLWZwzJNFMBZQ1oX80YbaoNe2vpIq3S4FqphXkixyGFCFJO4YlJGf0WE6b3+RAZ4xTmzGmbo3Hkk+19iD8QKtNNO5vKX2MzAoydM7aJ75YUG0hTqyuqI/V2SG/4TWRKHyRCC8AUxTvp/RRUlmZpS4iKaJQfj752k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203325; c=relaxed/simple;
	bh=Tm0dhdHNCL4tti66HOKOMlwI3Lz9Diufe5TGodWuXLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F05VhH1cLwTIZTymz7fBxeqLwuGPfRpZhsM9qZISCL4doyzuOIdPDe3C3hYpBrBqoT1g/o8Fq2DPGcXkj/Ze3jVvMFSn2/5oUVIGai7rSPhoCIp7jWrHg3sr2In7XjI5vLfRwXPxj+rMKi9rorwn9R4RyHUsjjnu+Dt+MVcyYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lumzOnIJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lumzOnIJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb2314f52so4012138f8f.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203323; x=1770808123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RADJq8xFn7pbwRx2j+X0wbr56ZI+9j1agtYQ4dqBGLo=;
        b=lumzOnIJSzLnAa9g/yusDDIiVhrGSFi5QFS9N45GKrqSniaXJ0AvQk0VKHO3dM9ryR
         awLIZCjAlT1SpNeRquaCEg4Higjxf6MdH4berPZiMq63oHrCs5LCMxZM+G0SR9+ClN+t
         FvP0k8N7gnel94Ng6cN2hpaH8ycUzDHuuGCfEdTCr3Q+n91P0styGpGzuZVeIMHkHDzv
         gnucoVpECCmwm8/T8wlWkNp6cbH0Rvs3QzNtBubLkpmllqxkL87cXDjH5A1QaBHW5ZSm
         znKQioU7MQEiNj0tT2DLd2WWmZjutvVrksrG/CfDOvtpD/ILA2vzUMFf9iw29l6pxyFg
         YNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203323; x=1770808123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RADJq8xFn7pbwRx2j+X0wbr56ZI+9j1agtYQ4dqBGLo=;
        b=KmjUcVEYleHNXmKeS9cJi6+JROQUrTlznzQAabEJZ3Hk9dDEqAGN1UNaNsyaV6+zzd
         Pi+8MY3PA8FY7d4a+uo+t5j8+9/+7UR1ZXJOGcAma+KQFXTtSLATZEJFrQ6nvJZN/g0w
         QXq/hU0veTinP+LOXXDwQhGVPX8K62dapFNASs7jUfWKffcW9EoCC5iQ8Xa7P+OeFMXc
         xe0lZKWQ2I32uYDjOtie/IXv4u8Dq2XBJVt+RTbSRQuhj2kBCwNj7uFrTahEGjWg9QDK
         9WzJpMNFcjgvUPohX7WUdBb86ZINrQBSq49ZMXqx6/nEMaDIK1yZrGrEjkJ/So8AQK//
         yUbg==
X-Gm-Message-State: AOJu0YyzJwtpV6vskttAOI5ys41jAyERGMGUwjt/TqMCSSPU5G2tDdoI
	oNU30Ec94drTUNaRvhh1mY4bnU4g/CkGqThAqDHcJ1M3t7P97k8644ZlfvKSvw==
X-Gm-Gg: AZuq6aJkdwv2AKwLkrXhO6NuO1cx7HIjJRQmwRZq6fAOYUGl3GK3PcyPotPcY1Sr/CC
	vvUX8W0WGbohIqtTXdvc8fwjDdwuFkqla9gbJEmBNFJxiXekv49vv5oUENHIdszi4du/fzQEt0Q
	8IpIw4l0a75IR85ESCaOBKOYc5hiaw2pAmwsIpi9amzmx8Pc42C3wkdNDc8i2S6tsjeC08J2nHl
	TTXJS388QGzhLuhYbWf54Oa4rX0HBFEHhcpwARNmf1Ydfk6nJNWmXw6kgkgapuikjVCAv5PyS9G
	Vfamt8qITeX7JZLeV+ZcQZFuHlPNwoCeaUel9ZOR8yU30xt8q9yrFlneFbAwIBFDcwedtAfQqp+
	KUmNHvQ57ua1qmCnJ59lvrgbOyoSPlbITZvtwlMms7LouFoPgl+qQcciAsQyD8eF16kG6+O6dEK
	jQ8hf74mA7DY4AveM1m5q2neUqGiRO5Y6D1m75BfNA01TNP6su/VQu/vRhL6F93imUuRLsxvoSb
	304C3OPNk6WM3NUkGcuHOg+ZAo=
X-Received: by 2002:a05:6000:c02:b0:436:1a2e:6dc with SMTP id ffacd0b85a97d-4361a2e079fmr1700338f8f.10.1770203323327;
        Wed, 04 Feb 2026 03:08:43 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm5340096f8f.39.2026.02.04.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:08:42 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 7/8] promisor-remote: keep advertised filters in memory
Date: Wed,  4 Feb 2026 12:08:12 +0100
Message-ID: <20260204110818.2919273-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <20260204110818.2919273-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, advertised filters are only kept in memory temporarily
during parsing, or persisted to disk if `promisor.storeFields`
contains 'partialCloneFilter'.

In a following commit though, we will add a `--filter=auto` option.
This option will enable the client to use the filters that the server
is suggesting for the promisor remotes the client accepts.

To use them even if `promisor.storeFields` is not configured, these
filters should be stored somewhere for the current session.

Let's add an `advertised_filter` field to `struct promisor_remote`
for that purpose.

To ensure that the filters are available in all cases,
filter_promisor_remote() captures them into a temporary list and
applies them to the `promisor_remote` structs after the potential
configuration reload.

Then the accepted remotes are marked as `accepted` in the repository
state. This ensures that subsequent calls to look up accepted remotes
(like in the filter construction below) actually find them.

In a following commit, we will add a `--filter=auto` option that will
enable a client to use the filters suggested by the server for the
promisor remotes the client accepted.

To enable the client to construct a filter spec based on these filters,
let's also add a `promisor_remote_construct_filter(repo)` function.

This function:

- iterates over all accepted promisor remotes in the repository,
- collects the filters advertised for them (using `advertised_filter`
  added in this commit, and
- generates a single filter spec for them.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h |  7 ++++++
 2 files changed, 65 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 59997dd4c7..d0bfb209dc 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -193,6 +193,7 @@ void promisor_remote_clear(struct promisor_remote_config *config)
 	while (config->promisors) {
 		struct promisor_remote *r = config->promisors;
 		free(r->partial_clone_filter);
+		free(r->advertised_filter);
 		config->promisors = config->promisors->next;
 		free(r);
 	}
@@ -837,6 +838,7 @@ static void filter_promisor_remote(struct repository *repo,
 	struct store_info *store_info = NULL;
 	struct string_list_item *item;
 	bool reload_config = false;
+	struct string_list captured_filters = STRING_LIST_INIT_DUP;
 
 	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -879,6 +881,13 @@ static void filter_promisor_remote(struct repository *repo,
 				reload_config = true;
 
 			strvec_push(accepted, advertised->name);
+
+			/* Capture advertised filters for accepted remotes */
+			if (advertised->filter) {
+				struct string_list_item *i;
+				i = string_list_append(&captured_filters, advertised->name);
+				i->util = xstrdup(advertised->filter);
+			}
 		}
 
 		promisor_info_free(advertised);
@@ -890,6 +899,25 @@ static void filter_promisor_remote(struct repository *repo,
 
 	if (reload_config)
 		repo_promisor_remote_reinit(repo);
+
+	/* Apply captured filters to the stable repo state */
+	for_each_string_list_item(item, &captured_filters) {
+		struct promisor_remote *r = repo_promisor_remote_find(repo, item->string);
+		if (r) {
+			free(r->advertised_filter);
+			r->advertised_filter = item->util;
+			item->util = NULL;
+		}
+	}
+
+	string_list_clear(&captured_filters, 1);
+
+	/* Mark the remotes as accepted in the repository state */
+	for (size_t i = 0; i < accepted->nr; i++) {
+		struct promisor_remote *r = repo_promisor_remote_find(repo, accepted->v[i]);
+		if (r)
+			r->accepted = 1;
+	}
 }
 
 char *promisor_remote_reply(const char *info)
@@ -935,3 +963,33 @@ void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes
 
 	string_list_clear(&accepted_remotes, 0);
 }
+
+char *promisor_remote_construct_filter(struct repository *repo)
+{
+	struct promisor_remote *r;
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
+	struct strbuf err = STRBUF_INIT;
+	char *result = NULL;
+
+	promisor_remote_init(repo);
+
+	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
+		if (r->accepted && r->advertised_filter)
+			if (gently_parse_list_objects_filter(&filter_options,
+							     r->advertised_filter,
+							     &err)) {
+				warning(_("promisor remote '%s' advertised invalid filter '%s': %s"),
+					r->name, r->advertised_filter, err.buf);
+				strbuf_reset(&err);
+				continue;
+			}
+	}
+
+	if (filter_options.choice)
+		result = xstrdup(expand_list_objects_filter_spec(&filter_options));
+
+	list_objects_filter_release(&filter_options);
+	strbuf_release(&err);
+
+	return result;
+}
diff --git a/promisor-remote.h b/promisor-remote.h
index 263d331a55..d227299fd0 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -15,6 +15,7 @@ struct object_id;
 struct promisor_remote {
 	struct promisor_remote *next;
 	char *partial_clone_filter;
+	char *advertised_filter;
 	unsigned int accepted : 1;
 	const char name[FLEX_ARRAY];
 };
@@ -67,4 +68,10 @@ void mark_promisor_remotes_as_accepted(struct repository *repo, const char *remo
  */
 int repo_has_accepted_promisor_remote(struct repository *r);
 
+/*
+ * Use the filters from the accepted remotes to create a combined
+ * filter (useful in `--filter=auto` mode).
+ */
+char *promisor_remote_construct_filter(struct repository *repo);
+
 #endif /* PROMISOR_REMOTE_H */
-- 
2.53.0.rc2.10.g12663a1c75.dirty

