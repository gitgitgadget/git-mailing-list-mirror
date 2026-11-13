Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607917;
	b=rSdi1hxEu/P5sb2IR5FR6/Ka6IcZUdWhWsHQ68Q4aQMiHg1x2FgKw6vAmxoT40VawphG
	 lExkZv5+HKi/ii47GXbx9HJz1zYEyXTrhCsJTun3Wga8LGylBYkSH9MHdORwo/6E2bP0A
	 bPqyrs1Zn8F/t0KwdiEHNc3E7QsC9Gs5C7bVDjqaTGyS81sM4vO66FFXUBybpjTAV1Z4O
	 4cyZmJkekjWvumlyjohWsCCDad7wasrj2Ri96rJaQpZte1DiK334U8tPE2TRas45IIRDk
	 O4odbQ7qB8Wov9dS433dwsaykemrk1+GDRhlzl2qeDFLraFTAFWX3usuyDMp9pUvdGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=f4a8xWUiDmtOiGSStrrxbjV6KSbRwlqaBoVswrk2GCU=;
	b=Z95OLBY8RShwIYlFHOso44VEsTkEjKqbcpcO1c73HYZK+MBr8mlx/kPLWH+LL91HoEv1
	 SYs5/i/NZ3OhmQXiGQLC2Rllxzvf968aYWdlV0X9eGkM+Mj1YgoTkoxR/SdshiIYY1uzx
	 I8nfPFEAjAWRD57K3R+qhxlCUB5ngNfrJrKtPlGLvX7uGCqqInGR9ftcMrA4NvTLHG2t/
	 jQLtqN0RKKsiscddTQXtgTUERMWqVqSv74kadL8u2j7QR5KYhLc18cKhmGuK9bC9pcM6t
	 Fc2Qsbwp3anI1LYUF9hoNmxjeoY53qt4m35CzQnZOLAX6uzplqN3Z2omSnW8W364LIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EpOqX1qn;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82679606A33E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 22:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82679606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EpOqX1qn
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3acec6677so1911847c88.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794607917; x=1795212717; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f4a8xWUiDmtOiGSStrrxbjV6KSbRwlqaBoVswrk2GCU=;
        b=EpOqX1qn8B/EWoHvR8/8a9RlEqzAPiwuJGRkaD2cIPuKVbYNhX9zvD6HBU0IIArU8s
         hD6kTFqfAHnGmebCmLlpHIMJLJjitJhzPZmixOtS9VXBRBk25JJNUULD1nYhJ+Y+NOF9
         PmltZB1MPC5bu/MZ3JuzftoJCZApBTr2KKfbMLrfmJPJv4kYfOXcWSS/h62tpIs7rIWW
         v2seIJfPbes28PJz7xvoLfry5J0S9J0XaEtG1CJU0dS8oSRqoChPXGGcYpiMx86r/qrs
         H4ECHuN3kmtDoT1xGgVSIVfg33eXm/N6I6HTBNgUqkQIfLGn0VGFjuK8zPQ5WYs9A5uh
         XOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607917; x=1795212717;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4a8xWUiDmtOiGSStrrxbjV6KSbRwlqaBoVswrk2GCU=;
        b=0Y6iN/qP6l0bca9r0GK4V0s47zc//ynax81KOI0QH1AsqVXKfMk++0IArOMc8OV9eY
         14O14ZGzA4t9w9WtOFIlM4jydF1vkI1+1ltC8Ksf1y0FLgfoY2amG+cYjK8e/leOJB95
         0xtGEm9ACNRsYgWlhMMw/LlTBgT0a7IGlPRaVoOe33IvhDIgGanW98UeR6ldkDTH+Cty
         Q6LeeMxq1cpAiMZRQ2elbsgB+vfdzM6Ri2J9bm1VEAohY1PuaArsP5rpiE6gkPf6KnP9
         HkMCa7KOMU60Gl2mge6D+cySU/3MqPLIhf643lOJOfHO3HQu1wGHaT/BShG/3n7gl3Fd
         WYzg==
X-Gm-Message-State: APuU4Z915PGjwS5Ve1NxUb+0Ykplo9ipT00AXkJlF2uD6Iqf/M9MkWa+
	NB7l+hxlksQHseZikZU0buFMhdSkRJmJ1xcHPKvrZZFsGLUVPYEJ3bzdqgB3qA==
X-Gm-Gg: AYBFou08L1u0qjoKNQM7o44Om4qPg9xAbe73nbP2PZ8Q4ATa/300KjD4leuZPErniFg
	Wi7Bjyg4ccXlT8BVtNAHYrzwCE/FWWDgRyWWffmYjSk7LWw78wyJDOtlbJzZ44++oObOrP5y+C8
	UUhxflwm/gCOxcxep1BgFJPE1jalCgcM/44hmbKT4s4oPAgjE8CbEEuHA/D+jIkWtfOaUY4xAx7
	Y2IAJmNeQenipNSkGXMLg1PyQ3RuKyafJFEVIcMNC1Kqv/z01DYKC+pXpynXG4clzGc8Y3OXlsK
	rNPJ13VT2lIPjtTdFE9bbzNK4946P9C8D/bVg1jTZT+VXNLfb7lBSbggultqKLumKyb8FxMD52v
	Sobc4VzAKfd0p9qt7240oxLE6c/rrIBtrjwxHeg1xF8i/a4s01O8eDDvLT/7bjxv8XQWDpxtp1O
	vnCH/oD00Pc9UakZgnfNbWr2goXm2Yn9AQRy9/fXqzk0iBPyHAIZzNQWXo2jVFbp6D5J1cU+JxO
	aNu9oyanUGmQ43Axkt0fAjYBVIWEmwncP5YyR7T73NT2GrEj+BBVmO6zaIE7fJn3H+sLiq/xL4M
	u4MslVYqQKTC7i47OdoPAANw7gVapbr84gVESFRNlQJTTbppxrgKKXGT
X-Received: by 2002:a05:7300:b284:b0:35e:2c6:d46c with SMTP id 5a478bee46e88-37966e3abf5mr3736428eec.10.1794607916361;
        Fri, 13 Nov 2026 14:11:56 -0800 (PST)
Received: from [127.0.0.1] ([172.184.174.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm9392783eec.4.2026.11.13.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:11:55 -0800 (PST)
Message-Id: <ba2534e3bc411352271f085725287c468860ae85.1794607911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
From: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Nov 2026 22:11:51 +0000
Subject: [PATCH 2/2] repack: also copy loose objects excluded by
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
index df1390154f..e2025c29ee 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -191,6 +191,10 @@ depth is 4095.
 	not rewritten. All objects are written before any existing
 	pack is removed.
 
+	Loose objects in this repository that the filter excludes are
+	copied to `<dir>` as well, and with `-d` the source copies are
+	removed once everything has been written.
+
 --drop-filtered::
 	Delete the local objects that match the `--filter` specification
 	instead of keeping them in a separate packfile, reclaiming the
diff --git a/builtin/repack.c b/builtin/repack.c
index 140a992f1b..a946ad28a3 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -183,6 +183,7 @@ int cmd_repack(int argc,
 	const char *expire_to = NULL;
 	const char *filter_to = NULL;
 	const char *filter_to_loose = NULL;
+	struct oidset moved_loose = OIDSET_INIT;
 	const char *opt_window = NULL;
 	const char *opt_window_memory = NULL;
 	const char *opt_depth = NULL;
@@ -721,6 +722,14 @@ int cmd_repack(int argc,
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
@@ -777,6 +786,7 @@ int cmd_repack(int argc,
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(repo, opts);
+		remove_moved_loose_objects(repo, &moved_loose);
 
 		if (!keep_unreachable &&
 		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
@@ -801,6 +811,7 @@ cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
 	oidset_clear(&drop_oids);
+	oidset_clear(&moved_loose);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
 	pack_objects_args_release(&po_args);
diff --git a/repack-filtered.c b/repack-filtered.c
index 51c9dfeb13..cb1f034f09 100644
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
index 5aa4b698f1..37dc5fdb13 100755
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
 test_expect_success '--filter-to-loose failure to write leaves the source intact' '
 	setup_loose_src &&
 	>not-a-dir &&
@@ -564,6 +602,27 @@ test_expect_success '--filter-to-loose failure to write leaves the source intact
 	git -C loose-src.git cat-file -e $big
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
