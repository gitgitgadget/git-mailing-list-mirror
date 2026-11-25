Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571095;
	b=zMSMmksD7UfG+VHdoZI1btZTzINEAYaKtlSop1+BcBLUgJvEtTdvNHPm0sodjdr3+dUQ
	 urp1+wmSIhzrUtEppRBy99sHw1MHowm4DYLXCZuCHyRdmeZ+7wm2UTcQbkRQCD8TQh98Z
	 whYUb5QPWGoo9tc/wkxvwZi6Do9knnbaUDF4I4MIbIhhgtpODWhQMiU5v5X1aiGc3oAZH
	 g3MmjFjc+TfkmwFNuK5QZwlGV5rRV1FjwSk1+ZtWSc5k/AqUXIDLo1H5ZarWhWpu5GDgK
	 XmYXddHQL4UnYvq+84hzO5Z5961jLao6iwFJoU+YuFYw9Kgv3Zi0wJJXzYJCpsSRsNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=BQT9EAhzlGcbyRyp/6ZK4rYLbcN5ng2SS8unOq3VXaM=;
	b=W7b+XaDU2J3Y49HM8jigoHdIPUdzeFWbkTSYz8R0m7HOEjGrjSCrp/KdBEon3siUl2yH
	 guB9HZx72QLtnhfA79iFqueaZBAVyLAtoeBrmaO1LZzWXObrKz40yeA73NajmFw7ERR/P
	 uRy/mMb+jxj9EjMUouYMGojWBIZ1BZV9v47iCp5cF0ykH8r7r8mI7o8iXPbhtelauyFVy
	 AmpIs/C4OmLnZXsPFB5CLQLnZRRZv/WchnfybWQ/BHCXAjlgkdlXTAG72XFIzXmI6Vgaw
	 v/e4QumO+xKaOvGncIuREkmbqfuHLajU5leGQYfH1zUx/g+ByCA/eZXT/XCnz99UpnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KUaBkDzI;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DFB606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58DFB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KUaBkDzI
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc751eddf25so3394408a12.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795571094; x=1796175894; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BQT9EAhzlGcbyRyp/6ZK4rYLbcN5ng2SS8unOq3VXaM=;
        b=KUaBkDzIdD/uQaMDaslouEOhVrYrXUQZlShvS9/R9qgA3T84Wbs08W/sxU/RoTRBr1
         UCqITJjaAS/jXmVt1zXZZx0wCZ3J+2ZIhO119nfzJ3mB7wiFJbYoL/Pau6IgFksgQvOm
         W0gDAO+Juvyn1LIaq9uWQCpMjGd7rKqwQg8upIXQ8UayyLlepPLJFOVCyt8nWQ8pmO4k
         poIx0+7O1YiY61fV5xRJpYjd/Io+oYjxxodaeDl1dOHibbCARflo+0WzISg9LexMJKIN
         w/934Tss9XxorxA5GUwh60pG5O3KECpDbWS1lfpX+tQGSfLG7yQZFSl+xNqHgASEQWnD
         7low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795571094; x=1796175894;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQT9EAhzlGcbyRyp/6ZK4rYLbcN5ng2SS8unOq3VXaM=;
        b=1kG/6pSKLJ+tTP45pX+mzEoxmOnyALekiY0o3NQIR5npNDZiNJSqFjYREuOdj4Mh24
         7wCQB3xedcrYaAoJ95moF/3QTtwuJPqEwBHT5DUojGFtwZmNJkUSuN67qQa1tzKa2N5G
         AZM9j4ON4Yq3r2qOIOGL5uMCDAe49zB+18Q7GVFrbt7DmHkI3C04mx2SU2qyaoPPytgG
         PepvK/Da2txMeMeiSDsvHr1Ns29lE46v2Oq3bZJVoCdN63T4kztYxJ1F3UAZJtJjRLzA
         f3wmAmllV7qz0hFdZkbaK2xHfJFnCJWK9FR7pW5blT63JVwGHUESxtSUYJDqUBKYZf1G
         gMpQ==
X-Gm-Message-State: APuU4Z96rhdFYH7qRi50IeIeX49wk+gOOSLGjtwSSx+te2LoHT3ESaw9
	TSGPLBefnFTtjyvYZQ1F4qPM64LThaRYt3dY5MQSs/HBxq+QZ3CMmuB27miV/A==
X-Gm-Gg: AZFdTZegnh1G1v0iTfltvfVLG9kK1bjj9lddgmwMJooKn4ljwOLVCdT3500KjW6hmhO
	o0KAA6rCAk5Bh81YdS7G/Mqm9xxmpBJrIyILNZjVAFfJ7UMoFw3V+PsbLSXCGuVEN2Xb/Zml+Mj
	K5Z4iqq0sJ3PKU5kFfuUf6KxR1v52jIs9cWmZl6pQ4ADdREOlmTSc7v3tGnXLElQt4Pz74s/yTX
	uvBlYOWf4KF8X1yY4Qmqdf6HPJvN5rVNNv1jU2nPaI3nOt1rtx5KAvgPV8arjIIbWX3R2QhLrw7
	a/VGUd6WMFFnAqlv2GeV+WyYOrE5bokYOzdDSgFjg/kUmjWnkXHBe7SGv8j+6MHIO26KZVQQ7ff
	BWOJImz9rDAMlC5TCkl8LdQctwWwszFhbJIYVf0kWdAzu4bnF8RNy6OLlSBKasTxYfktTO/XZx1
	SPYgJGzNsZjHu86moFNO4gx7Ag/7Q3A4SqzahCkR8w7VmremDngU7bYOlB/TeTBR0HcFuQj6WAq
	2Vtzis446YhpuZ6L/V7lPZV79Uxdttl4uHGavnzfSOW+oEGdm7p7RMzcQGh1rbeqM1hVeH6tldD
	ra/+BYH/uB8j+EDmZRT/FF1xAXp3h9bkHWZxyh0K1ByNvzOsNpOi
X-Received: by 2002:a05:6300:8095:b0:3de:8ee8:8323 with SMTP id adf61e73a8af0-4014c946a9emr14766793637.29.1795571094474;
        Tue, 24 Nov 2026 17:44:54 -0800 (PST)
Received: from [127.0.0.1] ([4.242.29.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87344058bsm7891308b3a.41.2026.11.24.17.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 17:44:54 -0800 (PST)
Message-Id: <0f1f0356b46e59cb588b046540034e09dfa7fe7d.1795571091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
	<pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
From: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 01:44:51 +0000
Subject: [PATCH v2 2/2] repack: also copy loose objects excluded by
 --filter-to-loose
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Martin Fick <mfick@nvidia.com>,
    Christian Couder <christian.couder@gmail.com>,
    Adithya Chakilam <achakilam@nvidia.com>,
    Adithya Chakilam <achakilam@nvidia.com>

From: Adithya Chakilam <achakilam@nvidia.com>

--filter-to-loose only writes objects that were in an existing pack,
because the filtered pack is built with --stdin-packs. Loose objects
that the filter excludes stay behind in the source repository, so the
destination does not get the complete set of filtered-out objects.

Copy such loose objects to the destination as well. An object already
present in the destination is not rewritten. With -d, the source copies
are removed once everything is written.

Signed-off-by: Adithya Chakilam <achakilam@nvidia.com>
---
 Documentation/git-repack.adoc |   4 ++
 builtin/repack.c              |  11 ++++
 repack-filtered.c             | 108 ++++++++++++++++++++++++++++++++++
 repack.h                      |  13 ++++
 t/t7700-repack.sh             |  59 +++++++++++++++++++
 5 files changed, 195 insertions(+)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index bcd7c1fe54..1cba380177 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -192,6 +192,10 @@ depth is 4095.
 	not rewritten. All objects are written before any existing
 	pack is removed.
 
+	Loose objects in this repository that the filter excludes are
+	copied to `<directory>` as well, and with `-d` the source copies are
+	removed once everything has been written.
+
 --drop-filtered::
 	Delete the local objects that match the `--filter` specification
 	instead of keeping them in a separate packfile, reclaiming the
diff --git a/builtin/repack.c b/builtin/repack.c
index dc2b4a3ce2..46a50d7c7d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -184,6 +184,7 @@ int cmd_repack(int argc,
 	const char *expire_to = NULL;
 	const char *filter_to = NULL;
 	const char *filter_to_loose = NULL;
+	struct oidset moved_loose = OIDSET_INIT;
 	const char *opt_window = NULL;
 	const char *opt_window_memory = NULL;
 	const char *opt_depth = NULL;
@@ -725,6 +726,14 @@ int cmd_repack(int argc,
 		ret = write_filtered_pack(&opts, &existing, &names);
 		if (ret)
 			goto cleanup;
+
+		if (filter_to_loose) {
+			ret = move_loose_filtered_objects(repo,
+					&po_args.filter_options, filter_to,
+					&moved_loose);
+			if (ret)
+				goto cleanup;
+		}
 	}
 
 	string_list_sort(&names);
@@ -781,6 +790,7 @@ int cmd_repack(int argc,
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(repo, opts);
+		remove_moved_loose_objects(repo, &moved_loose);
 
 		if (!keep_unreachable &&
 		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
@@ -805,6 +815,7 @@ cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
 	oidset_clear(&drop_oids);
+	oidset_clear(&moved_loose);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
 	pack_objects_args_release(&po_args);
diff --git a/repack-filtered.c b/repack-filtered.c
index b33274b5b8..180c28a758 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -9,6 +9,11 @@
 #include "list-objects-filter.h"
 #include "odb.h"
 #include "promisor-remote.h"
+#include "copy.h"
+#include "object-file.h"
+#include "odb/source-files.h"
+#include "oidset.h"
+#include "path.h"
 #include "sigchain.h"
 
 static void start_unpack_objects(struct child_process *unpack,
@@ -171,3 +176,106 @@ cleanup:
 	oidset_clear(&all_promisor_blobs);
 	return ret;
 }
+
+static int collect_loose_oid(const struct object_id *oid,
+			     const char *path UNUSED, void *cb_data)
+{
+	oidset_insert(cb_data, oid);
+	return 0;
+}
+
+static void dest_loose_path(struct strbuf *buf, const char *objdir,
+			    const struct object_id *oid)
+{
+	const char *hex = oid_to_hex(oid);
+
+	strbuf_reset(buf);
+	strbuf_addf(buf, "%s/%.2s/%s", objdir, hex, hex + 2);
+}
+
+int move_loose_filtered_objects(struct repository *repo,
+				const struct list_objects_filter_options *filter,
+				const char *dest_objdir,
+				struct oidset *moved)
+{
+	struct odb_source_files *files =
+		odb_source_files_downcast(repo->objects->source);
+	struct oidset loose = OIDSET_INIT;
+	struct oidset omitted = OIDSET_INIT;
+	struct oidset_iter iter;
+	const struct object_id *oid;
+	struct strbuf src = STRBUF_INIT;
+	struct strbuf dst = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
+	int ret = 0;
+
+	if (filter->choice != LOFC_BLOB_LIMIT)
+		return 0;
+
+	ret = for_each_loose_file_in_source(&files->dirs->loose->base,
+					    collect_loose_oid, NULL, NULL,
+					    &loose);
+	if (ret)
+		goto out;
+	ret = list_objects_filter__filter_oidset(repo, filter, &loose,
+						 &omitted);
+	if (ret)
+		goto out;
+
+	oidset_iter_init(&omitted, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		odb_loose_path(files->dirs->loose, &src, oid);
+		dest_loose_path(&dst, dest_objdir, oid);
+
+		/*
+		 * Only the destination decides whether the copy is needed;
+		 * the object being present in the source says nothing.
+		 */
+		if (!access(dst.buf, F_OK)) {
+			oidset_insert(moved, oid);
+			continue;
+		}
+
+		if (safe_create_leading_directories(repo, dst.buf) < 0) {
+			ret = error_errno(_("unable to create leading directories of '%s'"),
+					  dst.buf);
+			goto out;
+		}
+		strbuf_reset(&tmp);
+		strbuf_addf(&tmp, "%s.tmp-%"PRIuMAX, dst.buf,
+			    (uintmax_t)getpid());
+		if (copy_file(repo, tmp.buf, src.buf, 0444) ||
+		    finalize_object_file(repo, tmp.buf, dst.buf)) {
+			unlink(tmp.buf);
+			ret = error(_("unable to copy loose object '%s' to '%s'"),
+				    src.buf, dst.buf);
+			goto out;
+		}
+		oidset_insert(moved, oid);
+	}
+
+out:
+	oidset_clear(&loose);
+	oidset_clear(&omitted);
+	strbuf_release(&src);
+	strbuf_release(&dst);
+	strbuf_release(&tmp);
+	return ret;
+}
+
+void remove_moved_loose_objects(struct repository *repo,
+				const struct oidset *moved)
+{
+	struct odb_source_files *files =
+		odb_source_files_downcast(repo->objects->source);
+	struct strbuf path = STRBUF_INIT;
+	struct oidset_iter iter;
+	const struct object_id *oid;
+
+	oidset_iter_init(moved, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		odb_loose_path(files->dirs->loose, &path, oid);
+		unlink(path.buf);
+	}
+	strbuf_release(&path);
+}
diff --git a/repack.h b/repack.h
index d5528745ec..18a0dc6314 100644
--- a/repack.h
+++ b/repack.h
@@ -168,6 +168,19 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
 			struct string_list *names);
 
+/*
+ * Copy loose objects that the filter excludes into the loose-object store
+ * at `dest_objdir`, recording them in `moved`.
+ */
+int move_loose_filtered_objects(struct repository *repo,
+				const struct list_objects_filter_options *filter,
+				const char *dest_objdir,
+				struct oidset *moved);
+
+/* Delete the source copies of objects copied by move_loose_filtered_objects. */
+void remove_moved_loose_objects(struct repository *repo,
+				const struct oidset *moved);
+
 int enumerate_promisor_blobs(struct repository *repo,
 			     const struct list_objects_filter_options *filter,
 			     struct oidset *to_drop);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1b74d40551..d48ab73293 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -547,6 +547,44 @@ setup_loose_src () {
 	fi
 }
 
+test_expect_success '--filter-to-loose copies loose filtered out blobs, and -d removes the source copy' '
+	setup_loose_src loose &&
+	test_path_is_file loose-src.git/objects/$(test_oid_to_path $big) &&
+
+	# without -d the source copy is left alone
+	git -C loose-src.git -c repack.writebitmaps=false repack -a \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $big) &&
+	test_path_is_file loose-src.git/objects/$(test_oid_to_path $big) &&
+
+	# with -d it is removed from the source after being copied
+	rm -rf loose-dst.git/objects/$(dirname $(test_oid_to_path $big)) &&
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $big) &&
+	test_path_is_missing loose-src.git/objects/$(test_oid_to_path $big) &&
+	echo $(pwd)/loose-dst.git/objects >loose-src.git/objects/info/alternates &&
+	git -C loose-src.git cat-file -e $big
+'
+
+test_expect_success '--filter-to-loose leaves an identical existing destination object alone' '
+	setup_loose_src &&
+
+	test-tool genrandom big 2k |
+	GIT_OBJECT_DIRECTORY=loose-dst.git/objects git hash-object -w --stdin &&
+
+	path=loose-dst.git/objects/$(test_oid_to_path $big) &&
+	test_path_is_file $path &&
+
+	ls -i $path >before &&
+	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=1k --filter-to-loose=../loose-dst.git/objects &&
+
+	ls -i $path >after &&
+	test_cmp before after &&
+	git -C loose-dst.git fsck
+'
+
 test_expect_success '--filter-to-loose requires an existing directory' '
 	setup_loose_src &&
 
@@ -605,6 +643,27 @@ test_expect_success '--filter-to-loose resolves a relative path from a subdirect
 	test_path_is_file extra-loose-objects/$(test_oid_to_path $big)
 '
 
+test_expect_success '--filter-to-loose failure to copy a loose object leaves the source intact' '
+	setup_loose_src loose &&
+	path=$(test_oid_to_path $big) &&
+	>loose-dst.git/objects/$(dirname $path) &&
+
+	find loose-src.git/objects/pack -name "*.pack" | sort >packs-before &&
+	test_must_fail git -C loose-src.git -c repack.writebitmaps=false \
+		repack -a -d --filter=blob:limit=1k \
+		--filter-to-loose=../loose-dst.git/objects 2>err &&
+
+	test_grep "unable to create leading directories" err &&
+	find loose-src.git/objects/pack -name "*.pack" | sort >packs-after &&
+	test_cmp packs-before packs-after &&
+
+	find loose-src.git/objects/pack -name ".tmp-*" >tmp-leftovers &&
+	test_must_be_empty tmp-leftovers &&
+
+	test_path_is_file loose-src.git/objects/$path &&
+	git -C loose-src.git cat-file -e $big
+'
+
 test_expect_success '--filter-to-loose does not move objects from kept packs' '
 	setup_loose_src &&
 
-- 
gitgitgadget
