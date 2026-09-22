Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF831F9B1
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079977; cv=none; b=W6AdGQzWeGF9tQ9T5WR/NAuFpZriHW0XUy4N1JAjvIdQEidkDK9X9MsEDLCCZvvL3WNOE5V6zVfpT7EXU6EujOiPIaqsolaShgQfAn8ifiVTQ3r1Vuu33sAPfAMZDmJwQHZCgFiljTkkV3nO9SH5DHiD9bq7PnstnXBwLr4UcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079977; c=relaxed/simple;
	bh=hUyM9G5TpSxQXzPzd1Jc4+uFOMEeSN1dNV283uYuHPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oel++o8KLdf10P5n5JiKOPj+D6SwmxXhaAtijMK8ZNvOKv7aMLasKZ9s+qxzUDlVVsvYZU7psA0onoLQei+veBz82x/9MbAHfZLY8TXSKiWY2N/1sO1Vur9YrL7FxdhmgsMezP9p0O2z89OTwRB+sqqW7YBx/d4ZAqFFyUnzIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guxU4Fgf; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guxU4Fgf"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso497515666b.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079974; x=1790684774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rk0zK0EvFClCZ2UPtOytjoj6QgRfX3BtfygBU+yFFks=;
        b=guxU4FgfsRk0IOE4kKgGZCtSLQRJ9qA+SkP3oQRSAp1Te/T1iilAsAY8PvmjaqTsQe
         onLsNHdkknUNGZu1KPo2LzjSs9cjJJ4hEE/87YX2kMBujBHqE31rKYnOco7vnzCVzxR8
         faMkEnuLK15xHSpu8eRc9FQBzXp5BzGxGkLIeLIHLYRU4r5KzVj/5qNFW1j6tbg4Dmn2
         sMSKx/v70nozWdAPb+wXGh+cnXpPkl4jw01wNpHHklI18LR/THCd4QUn4wSRVQTuPLeL
         ZTUQsDKk7SgWK1wVdFJsXS+ft2zx3zDjyJpAGFj0kqicHnmtdUjpZRZ5ddABT6zRB2mK
         BpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079974; x=1790684774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rk0zK0EvFClCZ2UPtOytjoj6QgRfX3BtfygBU+yFFks=;
        b=vMncRGqav2LpzD3f1JRz4xoiiRwTh49pUyeYC2f92gS0RwkK/BpWY+98PvyI+7swMp
         G2TTRKSRpnN3Wn3Vdx/A0MDcQiU/TD2HYKxVSLt+OauV6EmjZ5eMaDvwNP7ihv4p4A/5
         832jI9KjyfuBlXvbXJ37jukXnTBaPL8u51j4wsjcrwETQo670+zVxO9I1hEzbPhqUb7l
         o50rskr1J3WplDI+qXIXcDJxm/NTN1Ms8dRcaYEWpFJiKfQbm2dKbV158j1O3cfI269B
         ZCFEkt6klWFe2ZZTOsLMyQXqDqk8w07aAVBE6m0GeqBfAvuWFH+/U8CZnE5vXD9QGTYa
         RgDQ==
X-Gm-Message-State: AFuF++lfGQcEzbVNirrLhBfdgGH8Mf43rVGvX6D+jc8VXQhEEgKxspf4
	El8DHY7c+JqvXcDP3FQ8i74ZzbJJfsrFmcf0c0e3P1rCD6NQbAAe/RZrHYN//2kX
X-Gm-Gg: AYBFou1YOZ8woNDdfHYeNUWPuvHZC0qtV6zQ5sxbp0dGYdGq++SEIKZmSHj83mF4PTk
	oUu2PifCaqRo0rZErcLJugZAds/JyyQzA+ikMtcu6ZMl8TWMw+lCbvTHbkxWB+U1AKTwAj6AtpT
	IuRTXws/4ekFRe1IPo3I9wZF0QmBf1mnDMcTUjW/tQVEz3WbUoc/ml076lyNT9Usol2pn8Uyn91
	mjDyyqjQGqLkuaLzXvubLcBbhoUrH2WPR+qLJTqThBYJX5cDktVl4gxgeJDNjtm31CG22rbj+P5
	cqgHc5ptJ3gj8TZ6MhVdEE0SC1MSNGnytRzjtA5oAqLyh+B/4OgNXEKkRqTrOxi0xkjAlRf/RsU
	mUXMQMes8UK7g1jmhEDTRFTVaCxqHCmqZkQB1H7pS766ziUQNf7NjjgzrD1B+udwx9o6UP12Wtk
	y6iTK0aoS3N0km8ION60m1jQUm846n5SzaZKw3um4wp/vmQVp1xIY/ricUm2dzt5PiU3kUMOeml
	/zxTRpApKf5dV7VUhtYFjgnkS5Tb0pfqvQuc2nSa61P912iSzG59rLSXXwO9NaPZY/0HwM8hqKk
	7Oid4RbZ33B6TuFiTOdEK0zP0ZO/R5ojFjx6jrFJjpwQZhwy
X-Received: by 2002:a17:907:7284:b0:c29:52dd:317b with SMTP id a640c23a62f3a-c2a15aeb6b6mr1322914566b.29.1790079973717;
        Tue, 22 Sep 2026 05:26:13 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c54f30dsm77322566b.17.2026.09.22.05.26.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 05:26:13 -0700 (PDT)
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
Subject: [PATCH v3 2/3] branch, tag: retain old OIDs in batched deletions
Date: Tue, 22 Sep 2026 14:26:08 +0200
Message-Id: <2065188aabecd857456b3f2d791edf9f7c8c6c6a.1790079917.git.maciej.ciemborowicz@gmail.com>
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

Before 8198907795 (use delete_refs when deleting tags or branches,
2021-01-21), branch and tag deletion passed each resolved old OID to
delete_ref(). This prevented the command from deleting a ref that another
process had changed after it was inspected.

The conversion to batched deletion dropped those old OIDs. Besides making
the deletions unconditional, this causes reference-transaction hooks to
report zero as both the old and new OID.

Both commands still resolve the old OIDs before starting the deletion. Pass
those values to refs_delete_refs(). This restores the old race protection
and lets hooks receive useful old values without adding ref reads. If a ref
changes concurrently, reject its deletion and preserve the new value.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 builtin/branch.c                 |  6 ++++-
 builtin/tag.c                    | 27 ++++++++++++++------
 t/t1416-ref-transaction-hooks.sh | 44 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c9f259d04..f222a2644 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -16,6 +16,7 @@
 #include "commit.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "oid-array.h"
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
@@ -248,6 +249,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 	struct string_list_item *item;
 	int branch_name_pos;
 	const char *fmt_remotes = "refs/remotes/%s";
@@ -342,6 +344,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		item = string_list_append(&refs_to_delete, name);
+		oid_array_append(&old_oids, &oid);
 		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
 				    : (ref_flags & REF_ISSYMREF) ? target
 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
@@ -352,7 +355,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 
 	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
 	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
-			     &refs_to_delete, NULL, REF_NO_DEREF))
+			     &refs_to_delete, &old_oids, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
@@ -377,6 +380,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(describe_ref);
 	}
 	string_list_clear(&refs_to_delete, 0);
+	oid_array_clear(&old_oids);
 
 	free(name);
 	strbuf_release(&bname);
diff --git a/builtin/tag.c b/builtin/tag.c
index 40874a292..32b70c369 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -105,28 +105,38 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 	return had_error;
 }
 
+struct tags_to_delete {
+	struct string_list refs;
+	struct oid_array old_oids;
+};
+
 static int collect_tags(const char *name UNUSED, const char *ref,
 			const struct object_id *oid, void *cb_data)
 {
-	struct string_list *ref_list = cb_data;
+	struct tags_to_delete *data = cb_data;
+	struct string_list_item *item;
 
-	string_list_append(ref_list, ref);
-	ref_list->items[ref_list->nr - 1].util = oiddup(oid);
+	item = string_list_append(&data->refs, ref);
+	item->util = oiddup(oid);
+	oid_array_append(&data->old_oids, oid);
 	return 0;
 }
 
 static int delete_tags(const char **argv)
 {
 	int result;
-	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct tags_to_delete data = {
+		.refs = STRING_LIST_INIT_DUP,
+		.old_oids = OID_ARRAY_INIT,
+	};
 	struct string_list_item *item;
 
-	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
+	result = for_each_tag_name(argv, collect_tags, &data);
 	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
-			     &refs_to_delete, NULL, REF_NO_DEREF))
+			     &data.refs, &data.old_oids, REF_NO_DEREF))
 		result = 1;
 
-	for_each_string_list_item(item, &refs_to_delete) {
+	for_each_string_list_item(item, &data.refs) {
 		const char *name = item->string;
 		struct object_id *oid = item->util;
 		if (!refs_ref_exists(get_main_ref_store(the_repository), name))
@@ -136,7 +146,8 @@ static int delete_tags(const char **argv)
 
 		free(oid);
 	}
-	string_list_clear(&refs_to_delete, 0);
+	string_list_clear(&data.refs, 0);
+	oid_array_clear(&data.old_oids);
 	return result;
 }
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 4fe9d9b23..01b5ba8c4 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -14,6 +14,50 @@ test_expect_success setup '
 	POST_OID=$(git rev-parse POST)
 '
 
+test_expect_success 'hook gets old values for batched branch/tag deletion' '
+	test_when_finished "rm -f actual" &&
+	git branch to-delete PRE &&
+	git tag delete-tag POST &&
+	git pack-refs --all &&
+	test_hook reference-transaction <<-\EOF &&
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
+	cat >expect <<-EOF &&
+		$PRE_OID $ZERO_OID refs/heads/to-delete
+		$POST_OID $ZERO_OID refs/tags/delete-tag
+	EOF
+	git branch -D to-delete &&
+	git tag -d delete-tag &&
+	test_cmp expect actual
+'
+
+test_expect_success 'branch deletion rejects a concurrent update' '
+	git branch delete-race PRE &&
+	test_hook reference-transaction <<-\EOF &&
+		marker=$(git rev-parse --git-path delete-race-once)
+		if test "$1" = preparing && test ! -e "$marker"
+		then
+			>"$marker"
+			git update-ref refs/heads/delete-race POST
+		fi
+		exit 0
+	EOF
+	test_must_fail git branch -D delete-race 2>err &&
+	test_grep "is at $POST_OID but expected $PRE_OID" err &&
+	test_cmp_rev POST refs/heads/delete-race
+'
+
 test_expect_success 'hook allows updating ref if successful' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
-- 
2.39.3 (Apple Git-146)

