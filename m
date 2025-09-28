Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B841FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097355; cv=none; b=mOLxJ252nMGnxz4PQItp4dUGrOm2Q8kYg8uJ5Jj/+by5ud7Dtiq0Accw1NQTVC+V9kT0arI5SuWVVnUO0kJLwk+40UqrhkWA+7Ds3tKPswOPWSiKVVu6nQCV5+yr7kJhvxhGb9OvTRQFmsRBtxDdCf3s1NtDgfqgYy1k/oltw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097355; c=relaxed/simple;
	bh=1gfReA6NoSiLYyHeTZqZ4+ABpo3CjfR+aEEgNRWDxFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qwft8UGAqDhKOurYsLrFDuRih29c1A+DUYJwnSLVmVRIe/iP7/4EBOillK9q8DygJxq2pRloXC5ZGPhfJr5xCbiQ150nE0bKJr63ZXhjKJgCdynWPtXlpn9AxIIxOeuXjKgajrVH57TIPs7f9qckVrAuEWRvH7V2rG8pQn1iI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CPG+Knnb; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CPG+Knnb"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-74625f748a0so42005817b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097352; x=1759702152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhPvhO81LTCgvLZuKtzdxno1Chc2HPQuwogXRmEs2Ro=;
        b=CPG+KnnbB4WuR9mhT4I2Yija+G3lU4q9bgV6zdfzW5kUkdEtXqAPwICpZje+eus04S
         7Lyz51HiNjYbQu5GeZE8UdrdzXEiCUWI7lMMI4Fxrulfzfg6xaGQ5WnRXja1rxJNYjP/
         UylzgKzPWKcDZVmqN7IIY00Li3svfJX5q8UmqB+FPFwKvdxF7tkmmDje9y4p1RmIV6Bp
         Ljw2W04XT129T++Av8VqxbksZB1YKJg4+zl7M6dOkpQ4FF/MT3m0c/0LWMosTonJP2DB
         tlhSMH8LIAgsBQwVWb6Bf10gJxuI96EwMOQnZ7qlGiTQq/fHCCOuPKpv8RQYyg1IASOt
         k0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097352; x=1759702152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhPvhO81LTCgvLZuKtzdxno1Chc2HPQuwogXRmEs2Ro=;
        b=XxWXj0N3384b3ntwDV6b3WswTGPzdRMhmOmJV3QWHIFjU1nIJi8D792g1Nj2+xHSRN
         3R9iP3IpQ4Wfz6FJnw3yaJsTHrjRVKiTMFCQOqoh7BPPdNXSPcyOogCqrcx7gDehDPN+
         r4ULD2FEtzFO7Lzwyp/vugcjsRyEhimVCIh6fawSdWoxQMygOl3lY2s4v51vcKpG1HNb
         t9d8q31qfhAAQJcZjooLzKByxbLqbXDWmlLlyz1f/6HF2sHJeR7pxnJlBYTUL8F1oJWZ
         4z8om5OwWTJ+fAuXTBhM1Bro5+mMTnjZcgwzgn1dhESAbfanpdEdtByejaMmK+z1pQBC
         uPIw==
X-Gm-Message-State: AOJu0YxW7G2L9B91husc0tuDO6/jdnWT0KjzwR4WhnAP7qxlWiA7IJuh
	YXV3829ew4mq0MB/PJbHOFJ8w1xcT/zULuja63Va+1dCQIP83eDBkbzRlOyPflPT5Fzi3k9tgSv
	gpbDKcZC2FQ==
X-Gm-Gg: ASbGncvnZNsxyaAnMMTWgIIHVYEP9hkJbMV4AQNDiNr9CXhYPMthq3uqCD/GiQurlTi
	ZCFccojzIxF6mdGJdfCQRN8PhlJKKxovsEzrkVQiDI6Ig61mpk/BaO9Z1wA1OInWNWJ0MlbiW63
	hMw50ASlhhJIqMO5I+2GwJhAAzlMaFCDauF2w/YLEcSV8JPkOUWbPLE1mkERj+ZiuXZ0Ebav3Vr
	BzRMTboLatq4cpGnZWbQqgL8TuMaTIIrXIe3CTnvdFf6PBO2DwmQcSoJOCHStL4LZYZLZKlHBxu
	vEZ1AFhaw7ffa4oBiM2HI5KGLNEq1cvJdfpya8UDu3mZwOu5L2EDGuh+uXztnn9OGDJsmJuIkqW
	DSPq/zFdLbPIw3YGikiDz1APFzP43NyhL2Aw57i+cIl2dUT9IptEkNwKPFbSEds5HwjE6e7ZAz7
	hcBZDi8Dn9cbQ3rmRhWSzBGNoh/A==
X-Google-Smtp-Source: AGHT+IFeYTx1Q8NoIeyLm9Y4Wwq/w+YTMyUuTi9np6Cl196Mri1C65bJsPUNqkyzfDlWz/cUA8dL4w==
X-Received: by 2002:a53:7c07:0:b0:62d:9854:f1c3 with SMTP id 956f58d0204a3-6361a85f9e4mr13329031d50.33.1759097352390;
        Sun, 28 Sep 2025 15:09:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38393c76bsm2935398276.25.2025.09.28.15.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:12 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 31/49] builtin/repack.c: remove ref snapshotting from builtin
Message-ID: <06ca4ab5b7b7d062bf552505de74db29b185a99f.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

When writing a MIDX, 'git repack' takes a snapshot of the repository's
references and writes the result out to a file, which it then passes to
'git multi-pack-index write' via the '--refs-snapshot'.

This is done in order to make bitmap selections with respect to what we
are packing, thus avoiding a race where an incoming reference update
causes us to try and write a bitmap for a commit not present in the
MIDX.

Extract this functionality out into a new repack-midx.c compilation
unit, and expose the necessary functions via the repack.h API.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile         |  1 +
 builtin/repack.c | 68 ------------------------------------------
 meson.build      |  1 +
 repack-midx.c    | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 repack.h         |  4 +++
 5 files changed, 83 insertions(+), 68 deletions(-)
 create mode 100644 repack-midx.c

diff --git a/Makefile b/Makefile
index a6da12a326..3360743afb 100644
--- a/Makefile
+++ b/Makefile
@@ -1138,6 +1138,7 @@ LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
 LIB_OBJS += repack-geometry.o
+LIB_OBJS += repack-midx.o
 LIB_OBJS += repack-promisor.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
diff --git a/builtin/repack.c b/builtin/repack.c
index b49e2dab9a..5a1f1cb562 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -178,74 +178,6 @@ static int midx_has_unknown_packs(char **midx_pack_names,
 	return 0;
 }
 
-struct midx_snapshot_ref_data {
-	struct repository *repo;
-	struct tempfile *f;
-	struct oidset seen;
-	int preferred;
-};
-
-static int midx_snapshot_ref_one(const char *refname UNUSED,
-				 const char *referent UNUSED,
-				 const struct object_id *oid,
-				 int flag UNUSED, void *_data)
-{
-	struct midx_snapshot_ref_data *data = _data;
-	struct object_id peeled;
-
-	if (!peel_iterated_oid(data->repo, oid, &peeled))
-		oid = &peeled;
-
-	if (oidset_insert(&data->seen, oid))
-		return 0; /* already seen */
-
-	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
-		return 0;
-
-	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
-		oid_to_hex(oid));
-
-	return 0;
-}
-
-static void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
-{
-	struct midx_snapshot_ref_data data;
-	const struct string_list *preferred = bitmap_preferred_tips(repo);
-
-	data.repo = repo;
-	data.f = f;
-	data.preferred = 0;
-	oidset_init(&data.seen, 0);
-
-	if (!fdopen_tempfile(f, "w"))
-		 die(_("could not open tempfile %s for writing"),
-		     get_tempfile_path(f));
-
-	if (preferred) {
-		struct string_list_item *item;
-
-		data.preferred = 1;
-		for_each_string_list_item(item, preferred)
-			refs_for_each_ref_in(get_main_ref_store(repo),
-					     item->string,
-					     midx_snapshot_ref_one, &data);
-		data.preferred = 0;
-	}
-
-	refs_for_each_ref(get_main_ref_store(repo),
-			  midx_snapshot_ref_one, &data);
-
-	if (close_tempfile_gently(f)) {
-		int save_errno = errno;
-		delete_tempfile(&f);
-		errno = save_errno;
-		die_errno(_("could not close refs snapshot tempfile"));
-	}
-
-	oidset_clear(&data.seen);
-}
-
 static void midx_included_packs(struct string_list *include,
 				struct existing_packs *existing,
 				char **midx_pack_names,
diff --git a/meson.build b/meson.build
index c929ad6f7e..42171d1851 100644
--- a/meson.build
+++ b/meson.build
@@ -464,6 +464,7 @@ libgit_sources = [
   'remote.c',
   'repack.c',
   'repack-geometry.c',
+  'repack-midx.c',
   'repack-promisor.c',
   'replace-object.c',
   'repo-settings.c',
diff --git a/repack-midx.c b/repack-midx.c
new file mode 100644
index 0000000000..354df729a5
--- /dev/null
+++ b/repack-midx.c
@@ -0,0 +1,77 @@
+#include "git-compat-util.h"
+#include "repack.h"
+#include "hash.h"
+#include "hex.h"
+#include "odb.h"
+#include "oidset.h"
+#include "pack-bitmap.h"
+#include "refs.h"
+#include "tempfile.h"
+
+struct midx_snapshot_ref_data {
+	struct repository *repo;
+	struct tempfile *f;
+	struct oidset seen;
+	int preferred;
+};
+
+static int midx_snapshot_ref_one(const char *refname UNUSED,
+				 const char *referent UNUSED,
+				 const struct object_id *oid,
+				 int flag UNUSED, void *_data)
+{
+	struct midx_snapshot_ref_data *data = _data;
+	struct object_id peeled;
+
+	if (!peel_iterated_oid(data->repo, oid, &peeled))
+		oid = &peeled;
+
+	if (oidset_insert(&data->seen, oid))
+		return 0; /* already seen */
+
+	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
+		return 0;
+
+	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
+		oid_to_hex(oid));
+
+	return 0;
+}
+
+void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
+{
+	struct midx_snapshot_ref_data data;
+	const struct string_list *preferred = bitmap_preferred_tips(repo);
+
+	data.repo = repo;
+	data.f = f;
+	data.preferred = 0;
+	oidset_init(&data.seen, 0);
+
+	if (!fdopen_tempfile(f, "w"))
+		 die(_("could not open tempfile %s for writing"),
+		     get_tempfile_path(f));
+
+	if (preferred) {
+		struct string_list_item *item;
+
+		data.preferred = 1;
+		for_each_string_list_item(item, preferred)
+			refs_for_each_ref_in(get_main_ref_store(repo),
+					     item->string,
+					     midx_snapshot_ref_one, &data);
+		data.preferred = 0;
+	}
+
+	refs_for_each_ref(get_main_ref_store(repo),
+			  midx_snapshot_ref_one, &data);
+
+	if (close_tempfile_gently(f)) {
+		int save_errno = errno;
+		delete_tempfile(&f);
+		errno = save_errno;
+		die_errno(_("could not close refs snapshot tempfile"));
+	}
+
+	oidset_clear(&data.seen);
+}
diff --git a/repack.h b/repack.h
index cea7969ae4..803e129224 100644
--- a/repack.h
+++ b/repack.h
@@ -98,4 +98,8 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 				    const char *packdir);
 void pack_geometry_release(struct pack_geometry *geometry);
 
+struct tempfile;
+
+void midx_snapshot_refs(struct repository *repo, struct tempfile *f);
+
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

