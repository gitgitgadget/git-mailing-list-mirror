Received: from mail-ej2-f32.google.com (mail-ej2-f32.google.com [74.125.228.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37383F660E
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901671; cv=none; b=eyPU+3/bXdAHP3t3b8HyoIkDICCVWFhZtlL1TUEkXc/KqEDAwbdALzopo8EBbGNouKTXQGHiSBkhTlCMRxSgvEzNS+Wpb5twMllWieLcyC5jYk7gKVZpFghLym2McX4P7c09G2obFK2FvxGq0sRowUS1xCCxBHC2tICGwXgBka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901671; c=relaxed/simple;
	bh=VOKhMK8Ti2TH63ckfSUphL+vEi2wv9/url/eGECB0EA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JuhOtFVMmMNPzoNql2oHdx+r6twbJVTdAHQE67fxaPvIIk1EBfdEN/b2Kzh8jLwOA3ouX2npW0tQVwDuq7XVKOMcU9MvqOgXXuuf69vKj0bUChKFLMRhSFHltDGUznFFuT6TBB03dtimOI+Pbo528lWn8oCn7Wq7eppZ7ZHtUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf4/33mz; arc=none smtp.client-ip=74.125.228.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf4/33mz"
Received: by mail-ej2-f32.google.com with SMTP id a640c23a62f3a-c254f55efebso318948866b.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789901668; x=1790506468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PH69XKuVtzTXcKFFLoNn0LnizaWcNN3IDhY6J3bN268=;
        b=nf4/33mz4QcTR3SNdPVv8GU5uvCOFWxfIS16EwpC6z3L+xbH0RnzxrZxQlStkKgWD7
         x2bxBy//kK0/WpsiCrCq+8En9V8DYV7yXIX5P+VEysvO6xPFfm3/kfo0TY7qwW+HkbYT
         wvIy4Px0ndo+uG+BjvHZXJ7IxWtu87RsIx4609EaSJruPlXY+7j/bKyYGcW3spC09k3g
         +tIOG8Zw1UgwEzZx0QWmB/K9jsv8yiS9X8dhavEXveL3ADBdUR5AYxmVm5SbmQHewiuT
         4p1LwLq1jhW5i5S01Rkpxa6ZTg0KwM3A/C6u+qm3gTypbbHhtMmBqzOVlrpqnxLG3jFA
         dOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789901668; x=1790506468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PH69XKuVtzTXcKFFLoNn0LnizaWcNN3IDhY6J3bN268=;
        b=r9f7GLnn6z0fWkvTbKBY5PLgdvbyH9kiVUQtxmS/AwMgEmcjOTfrf7k6ImKLBktCU0
         U6IUoqfdDAPAgTOxhJlO9Gm8Nc+SeDR4qrLLD07z2+cc1wNfjafatAwfPrWy+6sBwcVD
         +Vi31+SE8FuJ5zsN5+n0hUWnIoIhfxzAiNBBB2JfD2MQ9e3NWrlM7B+c12eRqbxWmGAB
         4fQES6a5Y7uXJdyDi+w8Fh/ajJC602efjuP7/fjXcNH3OHRLhSjbX5nIUyy2d1jddvyG
         x6loiw4lS5vOsrgNQFhfO/d49/IagvJrA3yGA4CO4gaDdllBAZJ0rjim5OfZNOjTy5gR
         JlBg==
X-Gm-Message-State: AFuF++lG6HRfWCtpMaoA2uW2ER72GZu/Sf/UAmd2zeOxQNh3D+6kfxtC
	dz1z26CYAU1bhuHRE6+TsbH+9LYawaK1EtcM43mjfUE0Z7DCTbWj5/g+g18zY/4P
X-Gm-Gg: AYBFou29pRMMyPu8uzfSL3n9AUMjKCat3AZQoymY0jsG/LsP+ivMW42vXT2xXyXgyvL
	YZQ/ugC5CJSBDEcmoy9OsSZAb2z7yeM4hsH67m3QyHekTWQ5oRQ49ZKcbM8zD/11gbDdCf6bIGB
	zUqK/D4s4kHQaXI4uNC0I43KVGV7xLIlCIfBYRPyaNjmAI3F8oixd4sYtxBCZbsVdQnpgosvxnb
	/Icluozx5+Xd3xILbpMxi1iCDlTrzhrAfwBCkBkRzPmuOIRYjt5ikWNBm29KlNDEl+JQotn+CSa
	dvlMBJzfuflXMsqcRXN6n97NH5fM0lZAk5xeovP/SrGgD+G2m+lRocJnEvvWymmW3LqvfSfWYPh
	+IcbADS6XkKh62G4K8NGkCob824zpXx++mGyhfdGipBDVUfVN3nzdwrh5SKL7GsxKTlfuMdFu3A
	la8ZLBJpZWnYtiWcAraacOVUqueKPtDop634sqntZo//HmO1nJcSX8wvffdCfG0iHhc7AtfCyGc
	HVNEnt7qVyK/BDHDLNeg8eVXONsO81qW2bK/WtJDoADUf1h06tiDkGQIW0NMkq/YkzKQFk0Il72
	P9736lmM7zVoxbcbeIsSDfFn0kOUeHwAxF9vCxsljDCYPK3ou4E1nap94Aj3FpgIZYQp
X-Received: by 2002:a17:906:794f:b0:c24:87e3:b8b8 with SMTP id a640c23a62f3a-c2a1569a558mr670939466b.17.1789901667940;
        Sun, 20 Sep 2026 03:54:27 -0700 (PDT)
Received: from localhost.localdomain (138.54.classcom.pl. [195.150.54.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35239469sm170989666b.6.2026.09.20.03.54.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 03:54:27 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 3/3] fetch, remote: retain old OIDs when pruning refs
Date: Sun, 20 Sep 2026 12:54:22 +0200
Message-Id: <461c36ccdae09fb827a3c0efc7eed5aef072e09b.1789901584.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_stale_heads() records the current value of each stale local ref in its
new_oid member. The pruning paths discard that value and request unconditional
deletion, so reference-transaction hooks receive a null old OID.

Carry the recorded values into the deletion transactions. Besides giving the
hooks useful values, this stops a stale scan from deleting a ref that another
process updated before the transaction acquired its locks. A concurrent
change now makes the prune fail and preserves the new value.

This reuses data collected while finding stale refs and therefore requires no
additional ref reads. Do not print deletion status when a non-atomic prune
fails its old-OID check.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 builtin/fetch.c                  | 13 +++++--
 builtin/remote.c                 | 36 ++++++++++++++---
 t/t1416-ref-transaction-hooks.sh | 66 ++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d202147b2..da413ace0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1452,14 +1452,18 @@ static int prune_refs(struct display_state *display_state,
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	struct strbuf err = STRBUF_INIT;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 
-	for (ref = stale_refs; ref; ref = ref->next)
+	for (ref = stale_refs; ref; ref = ref->next) {
 		string_list_append(&refnames, ref->name);
+		oid_array_append(&old_oids, &ref->new_oid);
+	}
 
 	if (!dry_run) {
 		if (transaction) {
 			for (ref = stale_refs; ref; ref = ref->next) {
-				result = ref_transaction_delete(transaction, ref->name, NULL,
+				result = ref_transaction_delete(transaction, ref->name,
+							&ref->new_oid,
 								NULL, 0, "fetch: prune", &err);
 				if (result)
 					goto cleanup;
@@ -1467,8 +1471,10 @@ static int prune_refs(struct display_state *display_state,
 		} else {
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
-						  NULL, 0);
+						  &old_oids, 0);
 		}
+		if (result)
+			goto cleanup;
 	}
 
 	if (verbosity >= 0) {
@@ -1487,6 +1493,7 @@ static int prune_refs(struct display_state *display_state,
 
 cleanup:
 	string_list_clear(&refnames, 0);
+	oid_array_clear(&old_oids);
 	strbuf_release(&err);
 	free_refs(stale_refs);
 	return result;
diff --git a/builtin/remote.c b/builtin/remote.c
index 13d3cc52d..b899bec55 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -17,6 +17,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "odb.h"
+#include "oid-array.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
@@ -380,6 +381,11 @@ struct ref_states {
 	int queried;
 };
 
+struct stale_ref {
+	struct object_id oid;
+	char name[FLEX_ARRAY];
+};
+
 #define REF_STATES_INIT { \
 	.new_refs = STRING_LIST_INIT_DUP, \
 	.skipped = STRING_LIST_INIT_DUP, \
@@ -410,9 +416,13 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	}
 	stale_refs = get_stale_heads(&states->remote->fetch, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
+		struct stale_ref *stale_ref;
 		struct string_list_item *item =
 			string_list_append(&states->stale, abbrev_branch(ref->name));
-		item->util = xstrdup(ref->name);
+
+		FLEX_ALLOC_STR(stale_ref, name, ref->name);
+		oidcpy(&stale_ref->oid, &ref->new_oid);
+		item->util = stale_ref;
 	}
 	free_refs(stale_refs);
 	free_refs(fetch_map);
@@ -1627,6 +1637,7 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0;
 	struct ref_states states = REF_STATES_INIT;
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 	struct string_list_item *item;
 
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
@@ -1639,17 +1650,28 @@ static int prune_remote(const char *remote, int dry_run)
 	printf_ln(_("Pruning %s"), remote);
 	printf_ln(_("URL: %s"), states.remote->url.v[0]);
 
-	for_each_string_list_item(item, &states.stale)
-		string_list_append(&refs_to_prune, item->util);
+	for_each_string_list_item(item, &states.stale) {
+		struct stale_ref *stale_ref = item->util;
+		struct string_list_item *to_prune;
+
+		to_prune = string_list_append(&refs_to_prune, stale_ref->name);
+		to_prune->util = &stale_ref->oid;
+	}
 	string_list_sort(&refs_to_prune);
+	for_each_string_list_item(item, &refs_to_prune)
+		oid_array_append(&old_oids, item->util);
 
-	if (!dry_run)
+	if (!dry_run) {
 		result |= refs_delete_refs(get_main_ref_store(the_repository),
 					   "remote: prune", &refs_to_prune,
-					   NULL, 0);
+					   &old_oids, 0);
+		if (result)
+			goto cleanup;
+	}
 
 	for_each_string_list_item(item, &states.stale) {
-		const char *refname = item->util;
+		struct stale_ref *stale_ref = item->util;
+		const char *refname = stale_ref->name;
 
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
@@ -1662,7 +1684,9 @@ static int prune_remote(const char *remote, int dry_run)
 	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
 				   stdout, " ", dry_run, &refs_to_prune);
 
+cleanup:
 	string_list_clear(&refs_to_prune, 0);
+	oid_array_clear(&old_oids);
 	free_remote_ref_states(&states);
 	return result;
 }
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 01b5ba8c4..2b51b216b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -58,6 +58,72 @@ test_expect_success 'branch deletion rejects a concurrent update' '
 	test_cmp_rev POST refs/heads/delete-race
 '
 
+test_expect_success 'hook gets old values when pruning remote refs' '
+	test_create_repo empty.git --bare &&
+	test_create_repo prune &&
+	git -C prune remote add origin ../empty.git &&
+	test_commit -C prune one &&
+	one=$(git -C prune rev-parse HEAD) &&
+	test_commit -C prune two &&
+	two=$(git -C prune rev-parse HEAD) &&
+	git -C prune update-ref refs/remotes/origin/remote-prune-z "$one" &&
+	git -C prune update-ref refs/remotes/origin/remote-prune-a "$two" &&
+	git -C prune pack-refs --all &&
+	test_hook -C prune reference-transaction <<-\EOF &&
+		if test "$1" = committed
+		then
+			# Ignore backend-internal zero-to-zero records.
+			while read -r old new ref
+			do
+				case "$old" in
+				*[!0]*)
+					echo "$old $new $ref"
+					;;
+				esac
+			done >>actual
+		fi
+	EOF
+	(
+		cd prune &&
+		git remote prune origin &&
+		git update-ref refs/remotes/origin/fetch-prune "$one" &&
+		git fetch --prune origin &&
+		git update-ref refs/remotes/origin/atomic-prune "$one" &&
+		git fetch --atomic --prune origin &&
+		cat >expect <<-EOF &&
+			$two $ZERO_OID refs/remotes/origin/remote-prune-a
+			$one $ZERO_OID refs/remotes/origin/remote-prune-z
+			$one $ZERO_OID refs/remotes/origin/fetch-prune
+			$one $ZERO_OID refs/remotes/origin/atomic-prune
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote prune rejects a concurrent update' '
+	test_when_finished "rm -rf race-empty.git race-prune" &&
+	test_create_repo race-empty.git --bare &&
+	test_create_repo race-prune &&
+	test_commit -C race-prune one &&
+	one=$(git -C race-prune rev-parse HEAD) &&
+	test_commit -C race-prune two &&
+	two=$(git -C race-prune rev-parse HEAD) &&
+	git -C race-prune remote add origin ../race-empty.git &&
+	git -C race-prune update-ref refs/remotes/origin/race "$one" &&
+	test_hook -C race-prune reference-transaction <<-\EOF &&
+		marker=$(git rev-parse --git-path prune-race-once)
+		if test "$1" = preparing && test ! -e "$marker"
+		then
+			>"$marker"
+			git update-ref refs/remotes/origin/race HEAD
+		fi
+		exit 0
+	EOF
+	test_must_fail git -C race-prune remote prune origin >out 2>err &&
+	test "$two" = "$(git -C race-prune rev-parse refs/remotes/origin/race)" &&
+	! grep "\[pruned\]" out
+'
+
 test_expect_success 'hook allows updating ref if successful' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
-- 
2.39.3 (Apple Git-146)

