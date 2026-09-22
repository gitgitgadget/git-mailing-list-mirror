Received: from mail-ej2-f25.google.com (mail-ej2-f25.google.com [74.125.228.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CC53ECF5
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079976; cv=none; b=qqWHXrEXbamhfIeWF7iFYgHETat6EMZctbWooCynGs3tlP+QCJDQ2bl+WyvUdqy9R3hs3Wz5YcWvrep96m7RqvMkTVrErmdfnaJha/+MreVPX8gMmt6InU7IdgmWYKvqa0+SUH84YNjzOO4dfugcqSO+ei+obFfa/efyu1OySRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079976; c=relaxed/simple;
	bh=Z5QrrbFHUU8Pj3j0JMlCEw4cS+HHW+Tot2xOH6LQ4Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SuGzknOp30SZUyco0PuSuIR1N093rthtQt8ifU/DyBaK96nDJIeYGZqRKjZhGHkAp4xbl+oIn/4gtfCFeeRhAJKxyA8KM/PAKwv90gVakaSz9aUl+reM41RJzfiGO6j87ngLxhnXYTSeONUFkIIxc2/3evY0PLM9eXdXE2rC4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6QVwGk1; arc=none smtp.client-ip=74.125.228.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6QVwGk1"
Received: by mail-ej2-f25.google.com with SMTP id a640c23a62f3a-c254fa4c24cso648219966b.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079973; x=1790684773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YG/fg4ubMg/R+Zs2SIWH9a9K5FhKTG6SUNXso6BXPJw=;
        b=f6QVwGk1+f8/JjadHbz47u17/FU4S9B2DF4Mdczkql07giG2EfOeIhvJVY0ZaGTEuS
         Rlz+rugJZIOYjQX5BkhhCrC/dqcGHEXSZCSA1eBWHTrgqWxD0LOIasIb5ejjAtqSoAVJ
         QyQOYUQeBTyYEmW+PRRcScbNk8LXmuf0O3liPO2PPEToHmXYke3RsLAG+QD2HIEnvQeB
         R2yJ6LHsexi78iNB6yzryC0wuGJeXjT3FS+cFKk6a0+O78ksjZvcxjN5IZmfERgNNyNM
         dg8Pq0DfjmV0+TqpJMqGjQkGLv0qd0dkrrhHsXeKP75tlg2OaD/woDFGsaUaVq2RyAXe
         C62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079973; x=1790684773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YG/fg4ubMg/R+Zs2SIWH9a9K5FhKTG6SUNXso6BXPJw=;
        b=j7XKna7//qDpj1p9V1EAgnPEq4jUnaTKJIO02qPF55noudAw6oBFkt7fPrnyb/yoSU
         2JuDJTStm5htKFhvfwQHdY/UrAFhfPly/jyDeuA4q3oTyMyhCReKt/9x381BSlK8y/LV
         UQRudVnGzREaTmYkdMmzrm0ruX2mEkCdYK32QieWiO2ZwrR6YjhPEr9eemrVP2BWJQPb
         tJH3U8hmZD7mbIc0LE5CQGNkiNQhwLmFFrEMMyUwb8gGpVVmDoANrlfajbhHdQYaYj8h
         4RMNeotgLdvhJnURnh+BJy418lY9EEnoMs/dsT7xxbdvBGKQ0vJITaek36LUsmBR9jiU
         yTvQ==
X-Gm-Message-State: AFuF++nJ3rU8VVOOK4lVxiFipaCETUUtOuY7DMtL711qJl/lhOYGYUtQ
	MHSKt5oOsgiWKK75TbD75ulu3FRMJngNbhrbwb8qyc4TtMO94ce2gWkAenVHQQ6D
X-Gm-Gg: AYBFou22wD4m+9ND0sizcp5Wv4FK5/9sHCyvjiB5f5MmchYa8Pa4aL5AFGm6dnMH3VL
	wSxIcg0vIFQPXmXsbvNX7GGpul69Yedr5rODxDxkUN/GAkJZunetHI+Zb9c0H2s2Zq6Qj4qsr2H
	kVN8aeZ4Vou7EdI0bfXoMEdk7EU8urrK9f1xXMJfDayFb3Qqy+o6fOwdGz7/lq9g43eqWprdmy1
	RovsGQ1Mc6yZfoqp9duVkxN4n9KKIASAx+q4zc3jZyLpiSAKLm7YaDWfYsN33kO3uSt++1CVTsX
	KOiJm8kIAjNckDdCt/+IZqXJZu61UU9yXEnOTNKxzUrp2LsWjCv2cz1eJAwSBWvyCOTABrsk0Sg
	j6JgvYxhxqxCheLWQvFiH5fw9wGxDxD4ayS1x3eOVCPgC2PTb3xGFMJAkhbp7yz+Rnrj5fmKKG4
	5OX/8xbkvTKyXxQTJy14nrPMQ7Pbl5547iicH31hSnvJhIeRoX6yfjvrv98DoyZQnF0Wiy32SzN
	AAtgCDIIDA6oUjpTVOOJ+bNU6dHwXtld3TuQxM7ITNCM/KFzZncfa1f41GyvtEkQ8huwTHAIZAt
	HlEBRdKczywm4nFGFE4AEyl3nmDNm2PLf+eOPEvp7I9a/28K/cWK+dNtmFA=
X-Received: by 2002:a17:906:f584:b0:c29:555e:bf9 with SMTP id a640c23a62f3a-c2a15861967mr1316684566b.18.1790079972618;
        Tue, 22 Sep 2026 05:26:12 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c54f30dsm77322566b.17.2026.09.22.05.26.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 05:26:12 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH v3 1/3] refs: allow callers to supply old OIDs for batch deletion
Date: Tue, 22 Sep 2026 14:26:07 +0200
Message-Id: <3315d5f47ad7d8bcdbeda90b161606507c7040ea.1790079917.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790079917.git.maciej.ciemborowicz@gmail.com>
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com> <cover.1790079917.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refs_delete_refs() performs unconditional deletions, so callers cannot
preserve old values that they have already resolved. Consequently,
reference-transaction hooks see a null old OID.

Let callers provide an optional array of expected old OIDs in parallel with
the refname list. When the array is provided, delete the ref at position N
only if it still points at the OID at position N. A null OID requests an
unconditional deletion for refs whose old value cannot be resolved, such as
broken refs.

Use REF_TRANSACTION_ALLOW_FAILURE when old OIDs are supplied. This retains
the helper's best-effort behavior: an old-OID mismatch rejects that deletion
while independent deletions in the batch can still proceed.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 bisect.c                  |  2 +-
 builtin/branch.c          |  3 ++-
 builtin/fetch.c           |  2 +-
 builtin/remote.c          |  5 ++--
 builtin/tag.c             |  3 ++-
 refs.c                    | 54 +++++++++++++++++++++++++++++++--------
 refs.h                    | 13 ++++++++--
 t/helper/test-ref-store.c |  2 +-
 8 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9cbb3dc67..931a80098 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1206,7 +1206,7 @@ int bisect_clean_state(void)
 	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
 	result = refs_delete_refs(get_main_ref_store(the_repository),
 				  "bisect: remove", &refs_for_removal,
-				  REF_NO_DEREF);
+				  NULL, REF_NO_DEREF);
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_ancestors_ok());
 	unlink_or_warn(git_path_bisect_log());
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc..c9f259d04 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -351,7 +351,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	}
 
 	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
-	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
+			     &refs_to_delete, NULL, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d..b662216bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1486,7 +1486,7 @@ static int prune_refs(struct display_state *display_state,
 		} else {
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
-						  0);
+						  NULL, 0);
 		}
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3b..13d3cc52d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1073,7 +1073,7 @@ static int rm(int argc, const char **argv, const char *prefix,
 	if (!result)
 		result = refs_delete_refs(get_main_ref_store(the_repository),
 					  "remote: remove", &branches,
-					  REF_NO_DEREF);
+					  NULL, REF_NO_DEREF);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
@@ -1645,7 +1645,8 @@ static int prune_remote(const char *remote, int dry_run)
 
 	if (!dry_run)
 		result |= refs_delete_refs(get_main_ref_store(the_repository),
-					   "remote: prune", &refs_to_prune, 0);
+					   "remote: prune", &refs_to_prune,
+					   NULL, 0);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
diff --git a/builtin/tag.c b/builtin/tag.c
index 06c125b53..40874a292 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -122,7 +122,8 @@ static int delete_tags(const char **argv)
 	struct string_list_item *item;
 
 	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
+			     &refs_to_delete, NULL, REF_NO_DEREF))
 		result = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
diff --git a/refs.c b/refs.c
index 92d5df5b7..1e0f432ed 100644
--- a/refs.c
+++ b/refs.c
@@ -16,6 +16,7 @@
 #include "refs/refs-internal.h"
 #include "hook.h"
 #include "object-name.h"
+#include "oid-array.h"
 #include "odb.h"
 #include "object.h"
 #include "path.h"
@@ -3069,34 +3070,60 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 	}
 }
 
+struct delete_refs_rejection_data {
+	int failures;
+};
+
+static void delete_refs_rejection_handler(const char *refname,
+					  const struct object_id *old_oid UNUSED,
+					  const struct object_id *new_oid UNUSED,
+					  const char *old_target UNUSED,
+					  const char *new_target UNUSED,
+					  enum ref_transaction_error err,
+					  const char *details,
+					  void *cb_data)
+{
+	struct delete_refs_rejection_data *data = cb_data;
+
+	warning(_("could not delete reference %s: %s"), refname,
+		details ? details : ref_transaction_error_msg(err));
+	data->failures = 1;
+}
+
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
-		     struct string_list *refnames, unsigned int flags)
+		     struct string_list *refnames,
+		     const struct oid_array *old_oids,
+		     unsigned int flags)
 {
+	struct delete_refs_rejection_data rejection_data = { 0 };
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	struct string_list_item *item;
+	size_t i;
 	int ret = 0, failures = 0;
 	char *msg;
 
 	if (!refnames->nr)
 		return 0;
+	if (old_oids && old_oids->nr != refnames->nr)
+		BUG("refname and old OID counts do not match");
 
 	msg = normalize_reflog_message(logmsg);
 
-	/*
-	 * Since we don't check the references' old_oids, the
-	 * individual updates can't fail, so we can pack all of the
-	 * updates into a single transaction.
-	 */
-	transaction = ref_store_transaction_begin(refs, 0, &err);
+	transaction = ref_store_transaction_begin(refs,
+			old_oids ? REF_TRANSACTION_ALLOW_FAILURE : 0, &err);
 	if (!transaction) {
 		ret = error("%s", err.buf);
 		goto out;
 	}
 
-	for_each_string_list_item(item, refnames) {
+	for (i = 0; i < refnames->nr; i++) {
+		struct string_list_item *item = &refnames->items[i];
+		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
+
+		if (old_oid && is_null_oid(old_oid))
+			old_oid = NULL;
 		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, NULL, flags, msg, &err);
+					     old_oid, NULL, flags, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);
@@ -3112,9 +3139,14 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 			      refnames->items[0].string, err.buf);
 		else
 			error(_("could not delete references: %s"), err.buf);
-	}
+	} else if (old_oids)
+		ref_transaction_for_each_rejected_update(transaction,
+						 delete_refs_rejection_handler,
+						 &rejection_data);
 
 out:
+	if (rejection_data.failures)
+		failures = 1;
 	if (!ret && failures)
 		ret = -1;
 	ref_transaction_free(transaction);
diff --git a/refs.h b/refs.h
index 9979446d1..3a7aacefe 100644
--- a/refs.h
+++ b/refs.h
@@ -9,6 +9,7 @@
 struct fsck_options;
 struct object_id;
 struct ref_store;
+struct oid_array;
 struct strbuf;
 struct string_list;
 struct string_list_item;
@@ -623,13 +624,21 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    unsigned int flags);
 
 /*
- * Delete the specified references. If there are any problems, emit
+ * Delete the specified references. If old_oids is non-NULL, it must contain
+ * an entry for each refname, in the same order. Each non-null OID is used to
+ * verify the current value of the corresponding reference before deleting
+ * it. A null OID requests an unconditional deletion, which allows callers to
+ * include broken refs whose old value cannot be resolved.
+ *
+ * If there are any problems, emit
  * errors but attempt to keep going (i.e., the deletes are not done in
  * an all-or-nothing transaction). msg and flags are passed through to
  * ref_transaction_delete().
  */
 int refs_delete_refs(struct ref_store *refs, const char *msg,
-		     struct string_list *refnames, unsigned int flags);
+		     struct string_list *refnames,
+		     const struct oid_array *old_oids,
+		     unsigned int flags);
 
 /** Delete a reflog */
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index db58f0058..6d6857cbd 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -132,7 +132,7 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 	while (*argv)
 		string_list_append(&refnames, *argv++);
 
-	result = refs_delete_refs(refs, msg, &refnames, flags);
+	result = refs_delete_refs(refs, msg, &refnames, NULL, flags);
 	string_list_clear(&refnames, 0);
 	return result;
 }
-- 
2.39.3 (Apple Git-146)

