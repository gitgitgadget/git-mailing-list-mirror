Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645F32E15A
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488309; cv=none; b=qwO/jtctMWCG8KMzGAMkTOISq5iQo6FIZYhBWHwT4/kkTXcGK+llw8PioXE/OQbPkYDOqyZdsslsxaCOZ2dOmvGLhUurw768ru/jcgUkD87+KbL2qPmp+2NcO4fyXNK6X1JLcVvlf67Sub+4CrW4mCmheLKZLiwpUPifZqQJSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488309; c=relaxed/simple;
	bh=/lhTIUdBFQBgRkTMLvF26x2BMrA2b1nS8fjyhnwuCyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW4EfIlpmjSwiIBPglgMqRkVt6yFsK5sQodMP+p8YNuH13iGkN1LvfN1FUBFaK+tOoS3XbbUTblhekBblvfUFwhuaMd1Rweu64RrKCSoqH492fGZ0nvfRms+aW06Pe3hy9UlPVs0uDNljgyxytJqlq4O0wEAAvdA5d/tqJGqcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG46GtjB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG46GtjB"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2494207f8f.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488304; x=1767093104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhU6F1ziOh0XyzbJnoPhnC1bgq6AxAkSo4q3Dp1hsl4=;
        b=TG46GtjBJKNkpFwBUbEwnb3GQfSzF7G8AJ6lIhw//8KutExI5d+4zpbT464wsdxIgJ
         0uNlm6NLcwHRl6Oh6ZDPa2XxiZLScZ24BRL9P2Xly0+46hUDMFPxeSaZS+bFOmwJTsFj
         k7cSQ5IUEH6TGx4S+fxANi/D6viIPBfup7EpPkwcVXK+AhfiZkBWumYW0YvgGyPp3Ils
         2xyHaHlSoc6Sm+7dIMjajDBb8bnw0ro4/0O40CQtw4emtuqxPmaxNMwK5NFY9vs8r/0v
         bvX8dKEII527MNi0j9OrE4vk/AL6V7Prva1Vv44tVzfVEpFNlXti5p/Mk7J2Wa7okMzp
         iruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488304; x=1767093104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dhU6F1ziOh0XyzbJnoPhnC1bgq6AxAkSo4q3Dp1hsl4=;
        b=AKGfzMPHf/LDavlfGiW+vovNnY+zTYROMJvw3ygtiENcQBvecXMk33OPA5DZtn0iEH
         vC1a33enOVTuLcAQM50owU9/BMk/TUrr9zy2bzYXUSpyFJfpY7Gp1cWHQU/0ktXI0UYp
         7Pc4jviIOnv+/flnYyKDiprCC+pIMnGwywEW1y6J3qvZo9WBKLhYxaOWiiLR3wEKdzFD
         V1q4PTPsvCnX5AW7eLYsT2H7hH4x/h3woeOSrQD2Eb4VllPAcimgu5kc+wEFE1U1UCIs
         ijSGJn5AMV0/844xlAaRN3O8PkMEOJJlQM+kemUUuWDq0nzHC61KUcHncjV+QHwkFzhp
         Ui/g==
X-Gm-Message-State: AOJu0YwjmnCdklc+xIRhflKk4tnOutXd+XV2FJmtMOO9rHZhhFKwR8SO
	39JcP2XjS0m2o/jKlXdkj40eHGYhLgXPJp4omHy/e7TJbkbxzrQGaEUXJpTV4Q==
X-Gm-Gg: AY/fxX4MDnRI2khL9bpXfhOiwbPiBuCEMPFzzFf5KxDfewKZwB68gsRyoGgfQDV70ZV
	yWPpneFctH7pXshDFl7p6EUeGAU/wOH26akQ+tgqL0/K48qEO1redngxqm5JQdUMLVDxM+ISZSd
	SGZGHkTbF4h5lVN89tKJxsZ/1g1j3VAwrnvoAgTBcBHrpk91kFaQXECkBgVH2+RYomLZkDj7DWg
	iSyMOpimopJnYVLHYR/UpYD5m2o55KKwzmT+55YpWJB5qnz9PYzX3e4CnDncQZ2dsI5RMm8nSmA
	qdnnYYGexqSK/X967LUom1hYC1mmkOEvCgFFBR3JVVOPmaBoIdeju8/kQn+HX+c66Gn7ykTOGWi
	VIIWFRDino5QRkVBfCCOAS4VBW9orTlQA4ACeZYLtnEE6AqnQVCt9QUXNmZUwbr9prPa405+Mek
	X0D3whaZOMHqPPktIUJ1YR3SlTbLDdb9nhwgHw6JyqJS/Lx7mNrxT4UVYdMz7wFRQneynKru3VW
	L+m2K5oURt4DMmiJ0nNih3q2Ts3p+F0ODviiQ==
X-Google-Smtp-Source: AGHT+IGtWx/sLzdHt236uvsaYBYHdGvwgxL9vTuIKu2kOL5rWPjZY7kHo5IgW7YyEAgwF3c/XgUK9A==
X-Received: by 2002:a05:6000:220c:b0:430:fd60:940f with SMTP id ffacd0b85a97d-4324e4c9627mr16613969f8f.14.1766488303826;
        Tue, 23 Dec 2025 03:11:43 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:43 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 8/9] promisor-remote: keep advertised filter in memory
Date: Tue, 23 Dec 2025 12:11:12 +0100
Message-ID: <20251223111113.47473-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
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
let's add a `promisor_remote_construct_filter(repo)` function.

This function:

- iterates over all accepted promisor remotes in the repository,
- collects the filters advertised for them (using `advertised_filter`
  which a previous commit added to `struct promisor_remote`), and
- generates a single filter spec for them (using the
  `list_objects_filter_combine()` function added by a previous commit).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h |  6 ++++++
 2 files changed, 54 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 8d6d2d7b76..d5f3223cd0 100644
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
@@ -935,3 +963,23 @@ void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes
 
 	string_list_clear(&accepted_remotes, 0);
 }
+
+char *promisor_remote_construct_filter(struct repository *repo)
+{
+	struct string_list advertised_filters = STRING_LIST_INIT_NODUP;
+	struct promisor_remote *r;
+	char *result;
+
+	promisor_remote_init(repo);
+
+	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
+		if (r->accepted && r->advertised_filter)
+			string_list_append(&advertised_filters, r->advertised_filter);
+	}
+
+	result = list_objects_filter_combine(&advertised_filters);
+
+	string_list_clear(&advertised_filters, 0);
+
+	return result;
+}
diff --git a/promisor-remote.h b/promisor-remote.h
index 263d331a55..98a0f05e03 100644
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
@@ -67,4 +68,9 @@ void mark_promisor_remotes_as_accepted(struct repository *repo, const char *remo
  */
 int repo_has_accepted_promisor_remote(struct repository *r);
 
+/*
+ * Use the filters from the accepted remotes to create a filter.
+ */
+char *promisor_remote_construct_filter(struct repository *repo);
+
 #endif /* PROMISOR_REMOTE_H */
-- 
2.52.0.319.gfcaffa7898

