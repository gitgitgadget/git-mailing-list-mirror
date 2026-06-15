Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819C3E4C81
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524367; cv=none; b=CYZTrz7g0ISJpN/1593t3xZ9ZTJ7JyB5ymV4xhEcrxpgPSprlP6vR2FKPm1OtJaDlCAHbeVuUDI1G6kDtWu2MhPOp/u87zcple+e6WYc30w04n0WXplcT/5s5X0+O1MTs6Njo7za2QqQ9ACO1Gp3CnugECj6FZGEy+8BjXIealk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524367; c=relaxed/simple;
	bh=9fjGLum8gBXFtUuZRUPMZtiCacBgFRDtLWmFUHr8f4w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bN8iYdmICtIAtjQ2YP9tf9k7vbIIi1x83JhcStMFCUTZJv4N+VgPaJbOcd5SwONUIZJ7b8m/OnqCIb4D53+zFGx+OBNti30MWSHwHN7+QASCUcjirCLeUTa2aitzOxiawudmW+HOvWRP2lHSYTdKw7QTHV3yw38nNpSdietxhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNdnHsCl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNdnHsCl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51788280e71so37570281cf.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524363; x=1782129163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy7SaaMfPnT0B4vBX2crEhLDeHijN3U7kRCxGSoCQnc=;
        b=oNdnHsClUlq7WsUegfkVEWnk2tUJt7ApzvnOQScav0HpRDPWzYFSAg/yM015RgIO6o
         iUZkk6XNPT1WSGE3vnPjVQ/kpIgOHYFrN1TKibYOt8quslf3NlJc8q/WbjKmY36W+0pg
         cWpeEm1MY5GLtcX28YEOmOzQ+SdKEoRiJL2w6thUBokukIs4HK5gyzsBqvP7DipF4zFu
         KvPQZmOCu84MScugegEl3G7lx3nsXImOROQglZusWod3rQKZtrPRmbyLbD1TIMN/Dmqv
         ZpDkXHiDURb8b1C5WwTwYvflC26s6vNpbIbOU3j2Fow3qs958EXOZhlpSs+LimiLvi4P
         2lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524363; x=1782129163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gy7SaaMfPnT0B4vBX2crEhLDeHijN3U7kRCxGSoCQnc=;
        b=LHnT7RGQD2DdflZtpRuXzh5gNy5lrm3BtaZ4lj4GIFXpJopcHG5/YmK7f4hZCUyaCe
         YZAR9SzomMlXCC/QVLuVfMQFRQ3XHFw/ulDRjJvhotuR2rHF0MhXvu8iLBQhqn2+gznc
         D8zp5CTivikEEHaLTgnKCeuVf7Bq4LXUpagnyN4VmFha0lIOvLBnszvYZFb6XTK40phx
         0sxMEnVGHlzmtu+4fM2YD4Z8C57PnCD7VWKOFZRF4Q6HESy3TAn7esfOHj/aAJ4wkDe6
         xTz/mxc5snW7U3f8J2tzy5JAJQ6FS3OQUq4+C8anrY/zwKXJ+Iw/BHia4Hh4LLh1odFG
         h8qA==
X-Gm-Message-State: AOJu0Yx2zATun0qUa52mUtb6lYX5wGs5VfJuBNeNCoxRxdU2JCzPiTND
	FbzKP/LefL2onMjr/gYhRl3Ds0C97GVnLd0WQaD0a6cMd4Y1qePR44rs9iTb1Q==
X-Gm-Gg: Acq92OHeGNzpNPtClrNv+0AqEXMP+n7/BuX9SLx++0YmVTPvCyEgo4Hu43ZaUHGU05I
	ICbAgjSs5XegoGTE5s9p7iTQFMw3ZpkZF+K0Xy8wC6flE1PZqPmXUDMxUnQE0F5XQs5rAGacByn
	WmRCJk1ZETkYNpTjoDznswRPPSYRP1lAeDFqhkm116aYCfJ58QT+Th8HKsBiGgH5627jAjDXaZD
	pVcMXorIS135NWXqB2a9nuPX5PIhFBVrdBAca9a1l/UZv14QbByLKkTj0rGnYEH7dooRBfAm64A
	UasY56p/fiu/pPtq8abxy+LTrW2cWCRbBrjVRlYKoNLGplLKKNvACVjCnIalwZrv7huSkaTCy6g
	bkMK1VnEv1AL0trtesypCYSEahxMbCjrRpyCmosTBNrOBnDTQKAdY83XOk36b99KN81KzQNymSu
	CIxRGQOF1wWcBVfoWTHEifRvqoITC1cJabP/+i3g==
X-Received: by 2002:a05:622a:8d0f:b0:517:84f3:6908 with SMTP id d75a77b69052e-517fe4d6cbcmr178024621cf.32.1781524362659;
        Mon, 15 Jun 2026 04:52:42 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a2227sm103833941cf.16.2026.06.15.04.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:52:41 -0700 (PDT)
Message-Id: <37d030d8675e94caee2eecb8398691d385d444bd.1781524349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 11:52:29 +0000
Subject: [PATCH v2 7/7] odb: use size_t for object_info.sizep and the size
 APIs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `js/objects-larger-than-4gb-on-windows` widened the streaming,
index-pack and unpack-objects code paths, in the interest of keeping the
patches somewhat reasonably-sized, it left the public ODB API still
typed in `unsigned long`. In particular `struct object_info::sizep` and
the four wrappers built on top of it (`odb_read_object`,
`odb_read_object_peeled`, `odb_read_object_info`, `odb_pretend_object`)
still return the unpacked size through `unsigned long *`, so on Windows
`cat-file -s` and the `git add` / `git status` paths for a >4 GiB blob
silently cap at 4 GiB.

Widen the field and the four wrappers. The previous commits already
widened the `unpack_entry()` cascade and pack-objects' in-core size
accessors, so most of the cascade arrives here with no further work: the
temporary shims in `packed_object_info_with_index_pos()` and in
`unpack_entry()`'s delta-base recovery path go away, the two
`SET_SIZE(entry, cast_size_t_to_ulong(canonical_size))` calls in
`check_object()` and the matching one in `drop_reused_delta()` collapse
to plain `SET_SIZE`, and `oe_get_size_slow()`'s tail
`cast_size_t_to_ulong()` is gone too.

What remains narrow are the boundaries this series does not
intend to touch: the diff, blame, textconv and fast-import machinery.

Even so, this patch is unfortunately quite large.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c                       |  6 ++--
 archive.c                     |  4 +--
 attr.c                        |  2 +-
 bisect.c                      |  2 +-
 blame.c                       | 15 ++++++---
 builtin/cat-file.c            | 61 ++++++++++++++++-------------------
 builtin/difftool.c            |  2 +-
 builtin/fast-export.c         |  7 ++--
 builtin/fast-import.c         | 22 +++++++++----
 builtin/fsck.c                |  2 +-
 builtin/grep.c                | 12 +++----
 builtin/index-pack.c          |  6 ++--
 builtin/log.c                 |  2 +-
 builtin/ls-files.c            |  2 +-
 builtin/ls-tree.c             |  4 +--
 builtin/merge-tree.c          |  6 ++--
 builtin/mktag.c               |  2 +-
 builtin/notes.c               |  6 ++--
 builtin/pack-objects.c        | 33 +++++++++++++------
 builtin/repo.c                |  4 ++-
 builtin/tag.c                 |  4 +--
 builtin/unpack-file.c         |  2 +-
 builtin/unpack-objects.c      |  6 ++--
 bundle.c                      |  2 +-
 combine-diff.c                |  4 ++-
 commit.c                      | 10 +++---
 config.c                      |  2 +-
 diff.c                        |  5 ++-
 dir.c                         |  2 +-
 entry.c                       |  4 +--
 fmt-merge-msg.c               |  4 +--
 fsck.c                        |  2 +-
 grep.c                        |  4 ++-
 http-push.c                   |  2 +-
 list-objects-filter.c         |  2 +-
 mailmap.c                     |  2 +-
 match-trees.c                 |  4 +--
 merge-blobs.c                 |  6 ++--
 merge-blobs.h                 |  2 +-
 merge-ort.c                   |  2 +-
 notes-cache.c                 |  2 +-
 notes-merge.c                 |  2 +-
 notes.c                       |  8 +++--
 object-file.c                 |  6 ++--
 object.c                      |  2 +-
 odb.c                         | 12 +++----
 odb.h                         | 10 +++---
 odb/source-loose.c            | 12 ++-----
 odb/streaming.c               | 13 +-------
 pack-bitmap.c                 |  4 +--
 packfile.c                    | 12 ++-----
 path-walk.c                   |  2 +-
 protocol-caps.c               |  5 +--
 read-cache.c                  |  6 ++--
 ref-filter.c                  |  2 +-
 reflog.c                      |  2 +-
 rerere.c                      |  2 +-
 submodule-config.c            |  2 +-
 t/helper/test-pack-deltas.c   |  3 +-
 t/helper/test-partial-clone.c |  2 +-
 t/unit-tests/u-odb-inmemory.c |  2 +-
 tag.c                         |  4 +--
 tree-walk.c                   | 10 +++---
 tree.c                        |  2 +-
 xdiff-interface.c             |  2 +-
 65 files changed, 209 insertions(+), 191 deletions(-)

diff --git a/apply.c b/apply.c
index 3cf544e9a9..5e54453f79 100644
--- a/apply.c
+++ b/apply.c
@@ -3321,7 +3321,7 @@ static int apply_binary(struct apply_state *state,
 	if (odb_has_object(the_repository->objects, &oid, 0)) {
 		/* We already have the postimage */
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *result;
 
 		result = odb_read_object(the_repository->objects, &oid,
@@ -3384,7 +3384,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		strbuf_addf(buf, "Subproject commit %s\n", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		unsigned long sz;
+		size_t sz;
 		char *result;
 
 		result = odb_read_object(the_repository->objects, oid,
@@ -3611,7 +3611,7 @@ static int load_preimage(struct apply_state *state,
 
 static int resolve_to(struct image *image, const struct object_id *result_id)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *data;
 
diff --git a/archive.c b/archive.c
index 51229107a5..59790be986 100644
--- a/archive.c
+++ b/archive.c
@@ -87,7 +87,7 @@ static void *object_file_to_archive(const struct archiver_args *args,
 				    const struct object_id *oid,
 				    unsigned int mode,
 				    enum object_type *type,
-				    unsigned long *sizep)
+				    size_t *sizep)
 {
 	void *buffer;
 	const struct commit *commit = args->convert ? args->commit : NULL;
@@ -158,7 +158,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 	write_archive_entry_fn_t write_entry = c->write_entry;
 	int err;
 	const char *path_without_prefix;
-	unsigned long size;
+	size_t size;
 	void *buffer;
 	enum object_type type;
 
diff --git a/attr.c b/attr.c
index 75369547b3..c61472a4e6 100644
--- a/attr.c
+++ b/attr.c
@@ -768,7 +768,7 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
 					      const char *path, unsigned flags)
 {
 	struct object_id oid;
-	unsigned long sz;
+	size_t sz;
 	enum object_type type;
 	void *buf;
 	unsigned short mode;
diff --git a/bisect.c b/bisect.c
index e29d1cbc64..94c7028d2a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -154,7 +154,7 @@ static void show_list(const char *debug, int counted, int nr,
 		struct commit *commit = p->item;
 		unsigned commit_flags = commit->object.flags;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *buf = odb_read_object(the_repository->objects,
 					    &commit->object.oid, &type,
 					    &size);
diff --git a/blame.c b/blame.c
index 977cbb7097..126e232416 100644
--- a/blame.c
+++ b/blame.c
@@ -1041,10 +1041,13 @@ static void fill_origin_blob(struct diff_options *opt,
 		    textconv_object(opt->repo, o->path, o->mode,
 				    &o->blob_oid, 1, &file->ptr, &file_size))
 			;
-		else
+		else {
+			size_t file_size_st = 0;
 			file->ptr = odb_read_object(the_repository->objects,
 						    &o->blob_oid, &type,
-						    &file_size);
+						    &file_size_st);
+			file_size = cast_size_t_to_ulong(file_size_st);
+		}
 		file->size = file_size;
 
 		if (!file->ptr)
@@ -2869,10 +2872,14 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 		    textconv_object(sb->repo, sb->path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
 				    &sb->final_buf_size))
 			;
-		else
+		else {
+			size_t final_buf_size_st = 0;
 			sb->final_buf = odb_read_object(the_repository->objects,
 							&o->blob_oid, &type,
-							&sb->final_buf_size);
+							&final_buf_size_st);
+			sb->final_buf_size =
+				cast_size_t_to_ulong(final_buf_size_st);
+		}
 
 		if (!sb->final_buf)
 			die(_("cannot read blob %s for path %s"),
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2b64f8f733..adb2ef5130 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -84,7 +84,7 @@ static char *replace_idents_using_mailmap(char *object_buf, size_t *size)
 
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
-			 char **buf, unsigned long *size)
+			 char **buf, size_t *size)
 {
 	enum object_type type;
 
@@ -120,7 +120,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	struct object_id oid;
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	struct object_context obj_context = {0};
 	struct object_info oi = OBJECT_INFO_INIT;
 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
@@ -163,11 +163,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		if (odb_read_object_info_extended(the_repository->objects, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 
-		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
-			size_t s = size;
-			buf = replace_idents_using_mailmap(buf, &s);
-			size = cast_size_t_to_ulong(s);
-		}
+		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG))
+			buf = replace_idents_using_mailmap(buf, &size);
 
 		printf("%"PRIuMAX"\n", (uintmax_t)size);
 		ret = 0;
@@ -188,9 +185,15 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		break;
 
 	case 'c':
-		if (textconv_object(the_repository, path, obj_context.mode,
-				    &oid, 1, &buf, &size))
+	{
+		unsigned long size_ul = 0;
+		int textconv_ret = textconv_object(the_repository, path,
+						   obj_context.mode, &oid, 1,
+						   &buf, &size_ul);
+		size = size_ul;
+		if (textconv_ret)
 			break;
+	}
 		/* else fallthrough */
 
 	case 'p':
@@ -216,11 +219,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
-		if (use_mailmap) {
-			size_t s = size;
-			buf = replace_idents_using_mailmap(buf, &s);
-			size = cast_size_t_to_ulong(s);
-		}
+		if (use_mailmap)
+			buf = replace_idents_using_mailmap(buf, &size);
 
 		/* otherwise just spit out the data */
 		break;
@@ -263,11 +263,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		buf = odb_read_object_peeled(the_repository->objects, &oid,
 					     exp_type_id, &size, NULL);
 
-		if (use_mailmap) {
-			size_t s = size;
-			buf = replace_idents_using_mailmap(buf, &s);
-			size = cast_size_t_to_ulong(s);
-		}
+		if (use_mailmap)
+			buf = replace_idents_using_mailmap(buf, &size);
 		break;
 	}
 	default:
@@ -288,7 +285,7 @@ cleanup:
 struct expand_data {
 	struct object_id oid;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	unsigned short mode;
 	off_t disk_size;
 	const char *rest;
@@ -404,7 +401,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			fflush(stdout);
 		if (opt->transform_mode) {
 			char *contents;
-			unsigned long size;
+			size_t size;
 
 			if (!data->rest)
 				die("missing path for '%s'", oid_to_hex(oid));
@@ -416,9 +413,12 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 					    oid_to_hex(oid), data->rest);
 			} else if (opt->transform_mode == 'c') {
 				enum object_type type;
-				if (!textconv_object(the_repository,
-						     data->rest, 0100644, oid,
-						     1, &contents, &size))
+				unsigned long size_ul = 0;
+				if (textconv_object(the_repository,
+						    data->rest, 0100644, oid,
+						    1, &contents, &size_ul))
+					size = size_ul;
+				else
 					contents = odb_read_object(the_repository->objects,
 								   oid, &type, &size);
 				if (!contents)
@@ -434,7 +434,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 	else {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		void *contents;
 
 		contents = odb_read_object(the_repository->objects, oid,
@@ -442,11 +442,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
 
-		if (use_mailmap) {
-			size_t s = size;
-			contents = replace_idents_using_mailmap(contents, &s);
-			size = cast_size_t_to_ulong(s);
-		}
+		if (use_mailmap)
+			contents = replace_idents_using_mailmap(contents, &size);
 
 		if (type != data->type)
 			die("object %s changed type!?", oid_to_hex(oid));
@@ -546,15 +543,13 @@ static void batch_object_write(const char *obj_name,
 		}
 
 		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
-			size_t s = data->size;
 			char *buf = NULL;
 
 			buf = odb_read_object(the_repository->objects, &data->oid,
 					      &data->type, &data->size);
 			if (!buf)
 				die(_("unable to read %s"), oid_to_hex(&data->oid));
-			buf = replace_idents_using_mailmap(buf, &s);
-			data->size = cast_size_t_to_ulong(s);
+			buf = replace_idents_using_mailmap(buf, &data->size);
 
 			free(buf);
 		}
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 2a21005f2e..26778f8515 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -319,7 +319,7 @@ static char *get_symlink(struct repository *repo,
 		data = strbuf_detach(&link, NULL);
 	} else {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		data = odb_read_object(repo->objects, oid, &type, &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2eb43a28da..0be43104dc 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -317,7 +317,10 @@ static void export_blob(const struct object_id *oid)
 		object = (struct object *)lookup_blob(the_repository, oid);
 		eaten = 0;
 	} else {
-		buf = odb_read_object(the_repository->objects, oid, &type, &size);
+		size_t size_st = 0;
+		buf = odb_read_object(the_repository->objects, oid, &type,
+				      &size_st);
+		size = cast_size_t_to_ulong(size_st);
 		if (!buf)
 			die(_("could not read blob %s"), oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
@@ -880,7 +883,7 @@ static char *anonymize_tag(void)
 
 static void handle_tag(const char *name, struct tag *tag)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf;
 	const char *tagger, *tagger_end, *message;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3dff898c43..d11a2cc2c1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1291,7 +1291,10 @@ static void load_tree(struct tree_entry *root)
 			die(_("can't load tree %s"), oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		buf = odb_read_object(the_repository->objects, oid, &type, &size);
+		size_t size_st = 0;
+		buf = odb_read_object(the_repository->objects, oid, &type,
+				      &size_st);
+		size = cast_size_t_to_ulong(size_st);
 		if (!buf || type != OBJ_TREE)
 			die(_("can't load tree %s"), oid_to_hex(oid));
 	}
@@ -2560,7 +2563,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			die(_("mark :%" PRIuMAX " not a commit"), commit_mark);
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!repo_get_oid(the_repository, p, &commit_oid)) {
-		unsigned long size;
+		size_t size;
 		char *buf = odb_read_object_peeled(the_repository->objects,
 						   &commit_oid, OBJ_COMMIT, &size,
 						   &commit_oid);
@@ -2627,10 +2630,12 @@ static void parse_from_existing(struct branch *b)
 		oidclr(&b->branch_tree.versions[1].oid, the_repository->hash_algo);
 	} else {
 		unsigned long size;
+		size_t size_st = 0;
 		char *buf;
 
 		buf = odb_read_object_peeled(the_repository->objects, &b->oid,
-					     OBJ_COMMIT, &size, &b->oid);
+					     OBJ_COMMIT, &size_st, &b->oid);
+		size = cast_size_t_to_ulong(size_st);
 		parse_from_commit(b, buf, size);
 		free(buf);
 	}
@@ -2722,7 +2727,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 				die(_("mark :%" PRIuMAX " not a commit"), idnum);
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!repo_get_oid(the_repository, from, &n->oid)) {
-			unsigned long size;
+			size_t size;
 			char *buf = odb_read_object_peeled(the_repository->objects,
 							   &n->oid, OBJ_COMMIT,
 							   &size, &n->oid);
@@ -3330,7 +3335,10 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	char *buf;
 
 	if (!oe || oe->pack_id == MAX_PACK_ID) {
-		buf = odb_read_object(the_repository->objects, oid, &type, &size);
+		size_t size_st = 0;
+		buf = odb_read_object(the_repository->objects, oid, &type,
+				      &size_st);
+		size = cast_size_t_to_ulong(size_st);
 	} else {
 		type = oe->type;
 		buf = gfi_unpack_entry(oe, &size);
@@ -3438,8 +3446,10 @@ static struct object_entry *dereference(struct object_entry *oe,
 		buf = gfi_unpack_entry(oe, &size);
 	} else {
 		enum object_type unused;
+		size_t size_st = 0;
 		buf = odb_read_object(the_repository->objects, oid,
-				      &unused, &size);
+				      &unused, &size_st);
+		size = cast_size_t_to_ulong(size_st);
 	}
 	if (!buf)
 		die(_("can't load object %s"), oid_to_hex(oid));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 248f8ff5a0..76b723f36d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -724,7 +724,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 	struct for_each_loose_cb *data = cb_data;
 	struct object *obj;
 	enum object_type type = OBJ_NONE;
-	unsigned long size;
+	size_t size;
 	void *contents = NULL;
 	int eaten;
 	struct object_info oi = OBJECT_INFO_INIT;
diff --git a/builtin/grep.c b/builtin/grep.c
index 6a09571903..26b85479ca 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -520,7 +520,7 @@ static int grep_submodule(struct grep_opt *opt,
 		enum object_type object_type;
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base = STRBUF_INIT;
 
 		obj_read_lock();
@@ -573,7 +573,7 @@ static int grep_cache(struct grep_opt *opt,
 			enum object_type type;
 			struct tree_desc tree;
 			void *data;
-			unsigned long size;
+			size_t size;
 
 			data = odb_read_object(the_repository->objects, &ce->oid,
 					       &type, &size);
@@ -666,7 +666,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
-			unsigned long size;
+			size_t size;
 
 			data = odb_read_object(the_repository->objects,
 					       &entry.oid, &type, &size);
@@ -730,7 +730,7 @@ static void collect_blob_oids_for_tree(struct repository *repo,
 			enum object_type type;
 			struct tree_desc sub_tree;
 			void *data;
-			unsigned long size;
+			size_t size;
 
 			data = odb_read_object(repo->objects, &entry.oid,
 					       &type, &size);
@@ -764,7 +764,7 @@ static void collect_blob_oids_for_treeish(struct grep_opt *opt,
 {
 	struct tree_desc tree;
 	void *data;
-	unsigned long size;
+	size_t size;
 	struct strbuf base = STRBUF_INIT;
 	int len;
 
@@ -841,7 +841,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base;
 		int hit, len;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c4474e681..78da3a6566 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -258,7 +258,7 @@ static unsigned check_object(struct object *obj)
 		return 0;
 
 	if (!(obj->flags & FLAG_CHECKED)) {
-		unsigned long size;
+		size_t size;
 		int type = odb_read_object_info(the_repository->objects,
 						&obj->oid, &size);
 		if (type <= 0)
@@ -905,7 +905,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (collision_test_needed) {
 		void *has_data;
 		enum object_type has_type;
-		unsigned long has_size;
+		size_t has_size;
 		read_lock();
 		has_type = odb_read_object_info(the_repository->objects, oid, &has_size);
 		if (has_type < 0)
@@ -1515,7 +1515,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		struct ref_delta_entry *d = sorted_by_pos[i];
 		enum object_type type;
 		void *data;
-		unsigned long size;
+		size_t size;
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
diff --git a/builtin/log.c b/builtin/log.c
index e464b30af4..d027ce1e0b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -613,7 +613,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 
 static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	unsigned long offset = 0;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 12d5d828ff..f30507215a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -256,7 +256,7 @@ static void expand_objectsize(struct repository *repo, struct strbuf *line,
 	size_t len;
 
 	if (type == OBJ_BLOB) {
-		unsigned long size;
+		size_t size;
 		if (odb_read_object_info(repo->objects, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 57846911ce..46edaffc2e 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -32,7 +32,7 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 	size_t len;
 
 	if (type == OBJ_BLOB) {
-		unsigned long size;
+		size_t size;
 		if (odb_read_object_info(the_repository->objects, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
@@ -220,7 +220,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 		return early;
 
 	if (type == OBJ_BLOB) {
-		unsigned long size;
+		size_t size;
 		if (odb_read_object_info(the_repository->objects, oid, &size) == OBJ_BAD)
 			xsnprintf(size_text, sizeof(size_text), "BAD");
 		else
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 312b595d1e..49f41e520f 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -69,7 +69,7 @@ static const char *explanation(struct merge_list *entry)
 	return "removed in remote";
 }
 
-static void *result(struct merge_list *entry, unsigned long *size)
+static void *result(struct merge_list *entry, size_t *size)
 {
 	enum object_type type;
 	struct blob *base, *our, *their;
@@ -96,7 +96,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 			   base, our, their, size);
 }
 
-static void *origin(struct merge_list *entry, unsigned long *size)
+static void *origin(struct merge_list *entry, size_t *size)
 {
 	enum object_type type;
 	while (entry) {
@@ -119,7 +119,7 @@ static int show_outf(void *priv UNUSED, mmbuffer_t *mb, int nbuf)
 
 static void show_diff(struct merge_list *entry)
 {
-	unsigned long size;
+	size_t size;
 	mmfile_t src, dst;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index f40264a878..37c17e6beb 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -50,7 +50,7 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 {
 	int ret;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *buffer;
 	const struct object_id *repl;
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 9af602bdd7..962df867c8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -150,7 +150,7 @@ static int list_each_note(const struct object_id *object_oid,
 
 static void copy_obj_to_fd(int fd, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = odb_read_object(the_repository->objects, oid, &type, &size);
 	if (buf) {
@@ -313,7 +313,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	char *value;
 	struct object_id object;
 	enum object_type type;
-	unsigned long len;
+	size_t len;
 
 	BUG_ON_OPT_NEG(unset);
 
@@ -721,7 +721,7 @@ static int append_edit(int argc, const char **argv, const char *prefix,
 
 	if (note && !edit) {
 		/* Append buf to previous note contents */
-		unsigned long size;
+		size_t size;
 		enum object_type type;
 		struct strbuf buf = STRBUF_INIT;
 		char *prev_buf = odb_read_object(the_repository->objects, note, &type, &size);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 961d547ef2..b5092d97ee 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -356,14 +356,17 @@ static void *get_delta(struct object_entry *entry)
 	unsigned long size, base_size, delta_size;
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
+	size_t size_st = 0, base_size_st = 0;
 
 	buf = odb_read_object(the_repository->objects, &entry->idx.oid,
-			      &type, &size);
+			      &type, &size_st);
+	size = cast_size_t_to_ulong(size_st);
 	if (!buf)
 		die(_("unable to read %s"), oid_to_hex(&entry->idx.oid));
 	base_buf = odb_read_object(the_repository->objects,
 				   &DELTA(entry)->idx.oid, &type,
-				   &base_size);
+				   &base_size_st);
+	base_size = cast_size_t_to_ulong(base_size_st);
 	if (!base_buf)
 		die("unable to read %s",
 		    oid_to_hex(&DELTA(entry)->idx.oid));
@@ -528,9 +531,11 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 			type = st->type;
 			size = st->size;
 		} else {
+			size_t size_st = 0;
 			buf = odb_read_object(the_repository->objects,
 					      &entry->idx.oid, &type,
-					      &size);
+					      &size_st);
+			size = cast_size_t_to_ulong(size_st);
 			if (!buf)
 				die(_("unable to read %s"),
 				    oid_to_hex(&entry->idx.oid));
@@ -1937,6 +1942,7 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	struct pbase_tree_cache *ent, *nent;
 	void *data;
 	unsigned long size;
+	size_t size_st = 0;
 	enum object_type type;
 	int neigh;
 	int my_ix = pbase_tree_cache_ix(oid);
@@ -1964,7 +1970,8 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	/* Did not find one.  Either we got a bogus request or
 	 * we need to read and perhaps cache.
 	 */
-	data = odb_read_object(the_repository->objects, oid, &type, &size);
+	data = odb_read_object(the_repository->objects, oid, &type, &size_st);
+	size = cast_size_t_to_ulong(size_st);
 	if (!data)
 		return NULL;
 	if (type != OBJ_TREE) {
@@ -2119,13 +2126,15 @@ static void add_preferred_base(struct object_id *oid)
 	struct pbase_tree *it;
 	void *data;
 	unsigned long size;
+	size_t size_st = 0;
 	struct object_id tree_oid;
 
 	if (window <= num_preferred_base++)
 		return;
 
 	data = odb_read_object_peeled(the_repository->objects, oid,
-				      OBJ_TREE, &size, &tree_oid);
+				      OBJ_TREE, &size_st, &tree_oid);
+	size = cast_size_t_to_ulong(size_st);
 	if (!data)
 		return;
 
@@ -2237,7 +2246,7 @@ static void prefetch_to_pack(uint32_t object_index_start) {
 
 static void check_object(struct object_entry *entry, uint32_t object_index)
 {
-	unsigned long canonical_size;
+	size_t canonical_size;
 	enum object_type type;
 	struct object_info oi = {.typep = &type, .sizep = &canonical_size};
 
@@ -2436,7 +2445,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	unsigned *idx = &to_pack.objects[entry->delta_idx - 1].delta_child_idx;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	while (*idx) {
 		struct object_entry *oe = &to_pack.objects[*idx - 1];
@@ -2748,7 +2757,7 @@ size_t oe_get_size_slow(struct packing_data *pack,
 	size_t size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
-		unsigned long sz;
+		size_t sz;
 		packing_data_lock(&to_pack);
 		if (odb_read_object_info(the_repository->objects,
 					 &e->idx.oid, &sz) < 0)
@@ -2833,10 +2842,12 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Load data if not already done */
 	if (!trg->data) {
+		size_t sz_st = 0;
 		packing_data_lock(&to_pack);
 		trg->data = odb_read_object(the_repository->objects,
 					    &trg_entry->idx.oid, &type,
-					    &sz);
+					    &sz_st);
+		sz = cast_size_t_to_ulong(sz_st);
 		packing_data_unlock(&to_pack);
 		if (!trg->data)
 			die(_("object %s cannot be read"),
@@ -2848,10 +2859,12 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		*mem_usage += sz;
 	}
 	if (!src->data) {
+		size_t sz_st = 0;
 		packing_data_lock(&to_pack);
 		src->data = odb_read_object(the_repository->objects,
 					    &src_entry->idx.oid, &type,
-					    &sz);
+					    &sz_st);
+		sz = cast_size_t_to_ulong(sz_st);
 		packing_data_unlock(&to_pack);
 		if (!src->data) {
 			if (src_entry->preferred_base) {
diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..69f3626467 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -784,13 +784,14 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 	for (size_t i = 0; i < oids->nr; i++) {
 		struct object_info oi = OBJECT_INFO_INIT;
 		unsigned long inflated;
+		size_t inflated_st = 0;
 		struct commit *commit;
 		struct object *obj;
 		void *content;
 		off_t disk;
 		int eaten;
 
-		oi.sizep = &inflated;
+		oi.sizep = &inflated_st;
 		oi.disk_sizep = &disk;
 		oi.contentp = &content;
 
@@ -798,6 +799,7 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
 						  OBJECT_INFO_QUICK) < 0)
 			continue;
+		inflated = cast_size_t_to_ulong(inflated_st);
 
 		obj = parse_object_buffer(the_repository, &oids->oid[i], type,
 					  inflated, content, &eaten);
diff --git a/builtin/tag.c b/builtin/tag.c
index d51c2e3349..06c125b53c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -238,7 +238,7 @@ static int git_tag_config(const char *var, const char *value,
 
 static void write_tag_body(int fd, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf, *sp, *orig;
 	struct strbuf payload = STRBUF_INIT;
@@ -388,7 +388,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 	enum object_type type;
 	struct commit *c;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int subject_len = 0;
 	const char *subject_start;
 
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 87877a9fab..387389ed49 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -12,7 +12,7 @@ static char *create_temp_file(struct object_id *oid)
 	static char path[50];
 	void *buf;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	int fd;
 
 	buf = odb_read_object(the_repository->objects, oid, &type, &size);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e7a50c493c..f3849bb654 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -231,7 +231,7 @@ static int check_object(struct object *obj, enum object_type type,
 		die("object type mismatch");
 
 	if (!(obj->flags & FLAG_OPEN)) {
-		unsigned long size;
+		size_t size;
 		int type = odb_read_object_info(the_repository->objects, &obj->oid, &size);
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
@@ -436,6 +436,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 {
 	void *delta_data, *base;
 	unsigned long base_size;
+	size_t base_size_st = 0;
 	struct object_id base_oid;
 
 	if (type == OBJ_REF_DELTA) {
@@ -512,7 +513,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		return;
 
 	base = odb_read_object(the_repository->objects, &base_oid,
-			       &type, &base_size);
+			       &type, &base_size_st);
+	base_size = cast_size_t_to_ulong(base_size_st);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
 		      oid_to_hex(&base_oid));
diff --git a/bundle.c b/bundle.c
index 42327f9739..fd2db2c837 100644
--- a/bundle.c
+++ b/bundle.c
@@ -296,7 +296,7 @@ int list_bundle_refs(struct bundle_header *header, int argc, const char **argv)
 
 static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = NULL, *line, *lineend;
 	timestamp_t date;
diff --git a/combine-diff.c b/combine-diff.c
index b799862068..3ce71db8bb 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -325,7 +325,9 @@ static char *grab_blob(struct repository *r,
 		*size = fill_textconv(r, textconv, df, &blob);
 		free_filespec(df);
 	} else {
-		blob = odb_read_object(r->objects, oid, &type, size);
+		size_t size_st = 0;
+		blob = odb_read_object(r->objects, oid, &type, &size_st);
+		*size = cast_size_t_to_ulong(size_st);
 		if (!blob)
 			die(_("unable to read %s"), oid_to_hex(oid));
 		if (type != OBJ_BLOB)
diff --git a/commit.c b/commit.c
index fd8723502e..7950effc58 100644
--- a/commit.c
+++ b/commit.c
@@ -395,7 +395,7 @@ const void *repo_get_commit_buffer(struct repository *r,
 	const void *ret = get_cached_commit_buffer(r, commit, sizep);
 	if (!ret) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		ret = odb_read_object(r->objects, &commit->object.oid, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
@@ -404,7 +404,7 @@ const void *repo_get_commit_buffer(struct repository *r,
 			die("expected commit for %s, got %s",
 			    oid_to_hex(&commit->object.oid), type_name(type));
 		if (sizep)
-			*sizep = size;
+			*sizep = cast_size_t_to_ulong(size);
 	}
 	return ret;
 }
@@ -437,7 +437,7 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 static void load_tree_from_commit_contents(struct repository *r, struct commit *commit)
 {
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	char *buf;
 	const char *p;
 	struct object_id tree_oid;
@@ -604,7 +604,7 @@ int repo_parse_commit_internal(struct repository *r,
 {
 	enum object_type type;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 	struct object_info oi = {
 		.typep = &type,
 		.sizep = &size,
@@ -1313,7 +1313,7 @@ static void handle_signed_tag(const struct commit *parent, struct commit_extra_h
 	struct merge_remote_desc *desc;
 	struct commit_extra_header *mergetag;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
diff --git a/config.c b/config.c
index a1b92fe083..21b231052c 100644
--- a/config.c
+++ b/config.c
@@ -1442,7 +1442,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 {
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	buf = odb_read_object(repo->objects, oid, &type, &size);
diff --git a/diff.c b/diff.c
index 5a584fa1d5..816b89dc6c 100644
--- a/diff.c
+++ b/diff.c
@@ -4594,8 +4594,9 @@ int diff_populate_filespec(struct repository *r,
 		}
 	}
 	else {
+		size_t size_st = 0;
 		struct object_info info = {
-			.sizep = &s->size
+			.sizep = &size_st
 		};
 
 		if (!(size_only || check_binary))
@@ -4617,6 +4618,7 @@ int diff_populate_filespec(struct repository *r,
 			die("unable to read %s", oid_to_hex(&s->oid));
 
 object_read:
+		s->size = cast_size_t_to_ulong(size_st);
 		if (size_only || check_binary) {
 			if (size_only)
 				return 0;
@@ -4631,6 +4633,7 @@ object_read:
 			if (odb_read_object_info_extended(r->objects, &s->oid, &info,
 							  OBJECT_INFO_LOOKUP_REPLACE))
 				die("unable to read %s", oid_to_hex(&s->oid));
+			s->size = cast_size_t_to_ulong(size_st);
 		}
 		s->should_free = 1;
 	}
diff --git a/dir.c b/dir.c
index 33c81c256e..b6764d98a7 100644
--- a/dir.c
+++ b/dir.c
@@ -324,7 +324,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 			size_t *size_out, char **data_out)
 {
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	char *data;
 
 	*size_out = 0;
diff --git a/entry.c b/entry.c
index 7817aee362..c444fe5a10 100644
--- a/entry.c
+++ b/entry.c
@@ -92,11 +92,9 @@ static int create_file(const char *path, unsigned int mode)
 void *read_blob_entry(const struct cache_entry *ce, size_t *size)
 {
 	enum object_type type;
-	unsigned long ul;
 	void *blob_data = odb_read_object(the_repository->objects, &ce->oid,
-					  &type, &ul);
+					  &type, size);
 
-	*size = ul;
 	if (blob_data) {
 		if (type == OBJ_BLOB)
 			return blob_data;
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 45d8b20e97..14441f23ae 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -528,11 +528,11 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 	for (i = 0; i < origins.nr; i++) {
 		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *buf = odb_read_object(the_repository->objects, oid,
 					    &type, &size);
 		char *origbuf = buf;
-		unsigned long len = size;
+		size_t len = size;
 		struct signature_check sigc = { NULL };
 		struct strbuf payload = STRBUF_INIT, sig = STRBUF_INIT;
 
diff --git a/fsck.c b/fsck.c
index b4ffee6a04..94c8651c7d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1328,7 +1328,7 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 	oidset_iter_init(blobs_found, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *buf;
 
 		if (oidset_contains(blobs_done, oid))
diff --git a/grep.c b/grep.c
index a54e5d86a9..1d75d31421 100644
--- a/grep.c
+++ b/grep.c
@@ -1931,9 +1931,11 @@ void grep_source_clear_data(struct grep_source *gs)
 static int grep_source_load_oid(struct grep_source *gs)
 {
 	enum object_type type;
+	size_t size_st = 0;
 
 	gs->buf = odb_read_object(gs->repo->objects, gs->identifier,
-				  &type, &gs->size);
+				  &type, &size_st);
+	gs->size = cast_size_t_to_ulong(size_st);
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
diff --git a/http-push.c b/http-push.c
index 520d6c3b6a..c61d9f7e02 100644
--- a/http-push.c
+++ b/http-push.c
@@ -365,7 +365,7 @@ static void start_put(struct transfer_request *request)
 	enum object_type type;
 	char hdr[50];
 	void *unpacked;
-	unsigned long len;
+	size_t len;
 	int hdrlen;
 	ssize_t size;
 	git_zstream stream;
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 78316e7f90..c912ff3079 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -280,7 +280,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 	void *filter_data_)
 {
 	struct filter_blobs_limit_data *filter_data = filter_data_;
-	unsigned long object_length;
+	size_t object_length;
 	enum object_type t;
 
 	switch (filter_situation) {
diff --git a/mailmap.c b/mailmap.c
index 3b2691781d..72b639e602 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -186,7 +186,7 @@ int read_mailmap_blob(struct repository *repo, struct string_list *map,
 {
 	struct object_id oid;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	if (!name)
diff --git a/match-trees.c b/match-trees.c
index 4216933d06..2a43c0fa1a 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -61,7 +61,7 @@ static void *fill_tree_desc_strict(struct repository *r,
 {
 	void *buffer;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	buffer = odb_read_object(r->objects, hash, &type, &size);
 	if (!buffer)
@@ -186,7 +186,7 @@ static int splice_tree(struct repository *r,
 	char *subpath;
 	int toplen;
 	char *buf;
-	unsigned long sz;
+	size_t sz;
 	struct tree_desc desc;
 	unsigned char *rewrite_here;
 	const struct object_id *rewrite_with;
diff --git a/merge-blobs.c b/merge-blobs.c
index 6fc2799417..16a75bd1e3 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -9,7 +9,7 @@
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
 	void *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	buf = odb_read_object(the_repository->objects, &obj->object.oid,
@@ -35,7 +35,7 @@ static void *three_way_filemerge(struct index_state *istate,
 				 mmfile_t *base,
 				 mmfile_t *our,
 				 mmfile_t *their,
-				 unsigned long *size)
+				 size_t *size)
 {
 	enum ll_merge_result merge_status;
 	mmbuffer_t res;
@@ -61,7 +61,7 @@ static void *three_way_filemerge(struct index_state *istate,
 
 void *merge_blobs(struct index_state *istate, const char *path,
 		  struct blob *base, struct blob *our,
-		  struct blob *their, unsigned long *size)
+		  struct blob *their, size_t *size)
 {
 	void *res = NULL;
 	mmfile_t f1, f2, common;
diff --git a/merge-blobs.h b/merge-blobs.h
index 13cf9669e5..5797517a06 100644
--- a/merge-blobs.h
+++ b/merge-blobs.h
@@ -6,6 +6,6 @@ struct index_state;
 
 void *merge_blobs(struct index_state *, const char *,
 		  struct blob *, struct blob *,
-		  struct blob *, unsigned long *);
+		  struct blob *, size_t *);
 
 #endif /* MERGE_BLOBS_H */
diff --git a/merge-ort.c b/merge-ort.c
index 544be9e466..4f6273bd51 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3716,7 +3716,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 {
 	void *buf;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	buf = odb_read_object(opt->repo->objects, oid, &type, &size);
 	if (!buf) {
 		path_msg(opt, ERROR_OBJECT_READ_FAILED, 0,
diff --git a/notes-cache.c b/notes-cache.c
index bf5bb1f6c1..74cef802bd 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -82,7 +82,7 @@ char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 	const struct object_id *value_oid;
 	enum object_type type;
 	char *value;
-	unsigned long size;
+	size_t size;
 
 	value_oid = get_note(&c->tree, key_oid);
 	if (!value_oid)
diff --git a/notes-merge.c b/notes-merge.c
index b9322abbcb..118cad2518 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -339,7 +339,7 @@ static void write_note_to_worktree(const struct object_id *obj,
 				   const struct object_id *note)
 {
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *buf = odb_read_object(the_repository->objects, note, &type, &size);
 
 	if (!buf)
diff --git a/notes.c b/notes.c
index 8f315e2a00..ec9c2cb150 100644
--- a/notes.c
+++ b/notes.c
@@ -811,7 +811,8 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 			      const struct object_id *new_oid)
 {
 	char *cur_msg = NULL, *new_msg = NULL, *buf;
-	unsigned long cur_len, new_len, buf_len;
+	unsigned long buf_len;
+	size_t cur_len, new_len;
 	enum object_type cur_type, new_type;
 	int ret;
 
@@ -875,7 +876,7 @@ static int string_list_add_note_lines(struct string_list *list,
 				      const struct object_id *oid)
 {
 	char *data;
-	unsigned long len;
+	size_t len;
 	enum object_type t;
 
 	if (is_null_oid(oid))
@@ -1282,7 +1283,8 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	static const char utf8[] = "utf-8";
 	const struct object_id *oid;
 	char *msg, *msg_p;
-	unsigned long linelen, msglen;
+	unsigned long linelen;
+	size_t msglen;
 	enum object_type type;
 
 	if (!t)
diff --git a/object-file.c b/object-file.c
index bce941874e..3a21c14027 100644
--- a/object-file.c
+++ b/object-file.c
@@ -300,7 +300,7 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 	}
 
 	if (oi->sizep)
-		*oi->sizep = cast_size_t_to_ulong(size);
+		*oi->sizep = size;
 
 	/*
 	 * The length must be followed by a zero byte
@@ -931,7 +931,7 @@ int force_object_loose(struct odb_source *source,
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	void *buf;
-	unsigned long len;
+	size_t len;
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct object_id compat_oid;
 	enum object_type type;
@@ -1614,7 +1614,7 @@ int read_loose_object(struct repository *repo,
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
-	unsigned long *size = oi->sizep;
+	size_t *size = oi->sizep;
 
 	fd = git_open(path);
 	if (fd >= 0)
diff --git a/object.c b/object.c
index 465902ecc6..23b84aa7e2 100644
--- a/object.c
+++ b/object.c
@@ -325,7 +325,7 @@ struct object *parse_object_with_flags(struct repository *r,
 {
 	int skip_hash = !!(flags & PARSE_OBJECT_SKIP_HASH_CHECK);
 	int discard_tree = !!(flags & PARSE_OBJECT_DISCARD_TREE);
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	int eaten;
 	const struct object_id *repl = lookup_replace_object(r, oid);
diff --git a/odb.c b/odb.c
index 965ef68e4e..7d555be09f 100644
--- a/odb.c
+++ b/odb.c
@@ -625,7 +625,7 @@ static int oid_object_info_convert(struct repository *r,
 	enum object_type type;
 	struct object_id oid, delta_base_oid;
 	struct object_info new_oi, *oi;
-	unsigned long size;
+	size_t size;
 	void *content;
 	int ret;
 
@@ -716,7 +716,7 @@ int odb_read_object_info_extended(struct object_database *odb,
 /* returns enum object_type or negative */
 int odb_read_object_info(struct object_database *odb,
 			 const struct object_id *oid,
-			 unsigned long *sizep)
+			 size_t *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -730,7 +730,7 @@ int odb_read_object_info(struct object_database *odb,
 }
 
 int odb_pretend_object(struct object_database *odb,
-		       void *buf, unsigned long len, enum object_type type,
+		       void *buf, size_t len, enum object_type type,
 		       struct object_id *oid)
 {
 	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
@@ -744,7 +744,7 @@ int odb_pretend_object(struct object_database *odb,
 void *odb_read_object(struct object_database *odb,
 		      const struct object_id *oid,
 		      enum object_type *type,
-		      unsigned long *size)
+		      size_t *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT | OBJECT_INFO_LOOKUP_REPLACE;
@@ -762,12 +762,12 @@ void *odb_read_object(struct object_database *odb,
 void *odb_read_object_peeled(struct object_database *odb,
 			     const struct object_id *oid,
 			     enum object_type required_type,
-			     unsigned long *size,
+			     size_t *size,
 			     struct object_id *actual_oid_return)
 {
 	enum object_type type;
 	void *buffer;
-	unsigned long isize;
+	size_t isize;
 	struct object_id actual_oid;
 
 	oidcpy(&actual_oid, oid);
diff --git a/odb.h b/odb.h
index 73553ed5a7..e2f0bbad25 100644
--- a/odb.h
+++ b/odb.h
@@ -228,12 +228,12 @@ struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 void *odb_read_object(struct object_database *odb,
 		      const struct object_id *oid,
 		      enum object_type *type,
-		      unsigned long *size);
+		      size_t *size);
 
 void *odb_read_object_peeled(struct object_database *odb,
 			     const struct object_id *oid,
 			     enum object_type required_type,
-			     unsigned long *size,
+			     size_t *size,
 			     struct object_id *oid_ret);
 
 /*
@@ -245,13 +245,13 @@ void *odb_read_object_peeled(struct object_database *odb,
  * that reference it.
  */
 int odb_pretend_object(struct object_database *odb,
-		       void *buf, unsigned long len, enum object_type type,
+		       void *buf, size_t len, enum object_type type,
 		       struct object_id *oid);
 
 struct object_info {
 	/* Request */
 	enum object_type *typep;
-	unsigned long *sizep;
+	size_t *sizep;
 	off_t *disk_sizep;
 	struct object_id *delta_base_oid;
 	void **contentp;
@@ -356,7 +356,7 @@ int odb_read_object_info_extended(struct object_database *odb,
  */
 int odb_read_object_info(struct object_database *odb,
 			 const struct object_id *oid,
-			 unsigned long *sizep);
+			 size_t *sizep);
 
 enum odb_has_object_flags {
 	/* Retry packed storage after checking packed and loose storage */
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 7d7ea2fb84..66e6bb8d3f 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -72,7 +72,7 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 	void *map = NULL;
 	git_zstream stream, *stream_to_end = NULL;
 	char hdr[MAX_HEADER_LEN];
-	unsigned long size_scratch;
+	size_t size_scratch;
 	enum object_type type_scratch;
 	struct stat st;
 
@@ -355,7 +355,6 @@ static int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct odb_loose_read_stream *st;
 	unsigned long mapsize;
-	unsigned long size_ul;
 	void *mapped;
 
 	mapped = odb_source_loose_map_object(loose, oid, &mapsize);
@@ -379,18 +378,11 @@ static int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 		goto error;
 	}
 
-	/*
-	 * object_info.sizep is unsigned long* (32-bit on Windows), but
-	 * st->base.size is size_t (64-bit). Use temporary variable.
-	 * Note: loose objects >4GB would still truncate here, but such
-	 * large loose objects are uncommon (they'd normally be packed).
-	 */
-	oi.sizep = &size_ul;
+	oi.sizep = &st->base.size;
 	oi.typep = &st->base.type;
 
 	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
 		goto error;
-	st->base.size = size_ul;
 
 	st->mapped = mapped;
 	st->mapsize = mapsize;
diff --git a/odb/streaming.c b/odb/streaming.c
index 7602a8d5d8..20531e864c 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -157,26 +157,15 @@ static int open_istream_incore(struct odb_read_stream **out,
 		.base.read = read_istream_incore,
 	};
 	struct odb_incore_read_stream *st;
-	unsigned long size_ul;
 	int ret;
 
 	oi.typep = &stream.base.type;
-	/*
-	 * object_info.sizep is unsigned long* (32-bit on Windows), but
-	 * stream.base.size is size_t (64-bit). We use a temporary variable
-	 * because the types are incompatible. Note: this path still truncates
-	 * for >4GB objects, but large objects should use pack streaming
-	 * (packfile_store_read_object_stream) which handles size_t properly.
-	 * This incore fallback is only used for small objects or when pack
-	 * streaming is unavailable.
-	 */
-	oi.sizep = &size_ul;
+	oi.sizep = &stream.base.size;
 	oi.contentp = (void **)&stream.buf;
 	ret = odb_read_object_info_extended(odb, oid, &oi,
 					    OBJECT_INFO_DIE_IF_CORRUPT);
 	if (ret)
 		return ret;
-	stream.base.size = size_ul;
 
 	CALLOC_ARRAY(st, 1);
 	*st = stream;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index f9af8a96bd..e8a82945cc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1856,7 +1856,7 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
 static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 				     uint32_t pos)
 {
-	unsigned long size;
+	size_t size;
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.sizep = &size;
@@ -1891,7 +1891,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
 	}
 
-	return size;
+	return cast_size_t_to_ulong(size);
 }
 
 static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
diff --git a/packfile.c b/packfile.c
index c174982d10..78c389e6f3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1607,13 +1607,10 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		size_t size_st = 0;
 		*oi->contentp = cache_or_unpack_entry(p->repo, p, obj_offset,
-						      &size_st, &type);
+						      oi->sizep, &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-		else if (oi->sizep)
-			*oi->sizep = cast_size_t_to_ulong(size_st);
 	} else if (oi->sizep || oi->typep || oi->delta_base_oid) {
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
 	}
@@ -1633,7 +1630,7 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 				goto out;
 			}
 		}
-		*oi->sizep = (unsigned long)size;
+		*oi->sizep = size;
 	}
 
 	if (oi->disk_sizep || (oi->mtimep && p->is_cruft)) {
@@ -1919,7 +1916,6 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			struct object_id base_oid;
 			if (!(offset_to_pack_pos(p, obj_offset, &pos))) {
 				struct object_info oi = OBJECT_INFO_INIT;
-				unsigned long bsz_ul = 0;
 
 				nth_packed_object_id(&base_oid, p,
 						     pack_pos_to_index(p, pos));
@@ -1930,13 +1926,11 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 				mark_bad_packed_object(p, &base_oid);
 
 				oi.typep = &type;
-				oi.sizep = &bsz_ul;
+				oi.sizep = &base_size;
 				oi.contentp = &base;
 				if (odb_read_object_info_extended(r->objects, &base_oid,
 								  &oi, 0) < 0)
 					base = NULL;
-				else
-					base_size = bsz_ul;
 
 				external_base = base;
 			}
diff --git a/path-walk.c b/path-walk.c
index 94ff90bd15..edc8e736d7 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -368,7 +368,7 @@ static int walk_path(struct path_walk_context *ctx,
 		struct oid_array filtered = OID_ARRAY_INIT;
 
 		for (size_t i = 0; i < list->oids.nr; i++) {
-			unsigned long size;
+			size_t size;
 
 			if (odb_read_object_info(ctx->repo->objects,
 						 &list->oids.oid[i],
diff --git a/protocol-caps.c b/protocol-caps.c
index 35072ed60b..8858ea4489 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -50,7 +50,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	for_each_string_list_item (item, oid_str_list) {
 		const char *oid_str = item->string;
 		struct object_id oid;
-		unsigned long object_size;
+		size_t object_size;
 
 		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
 			packet_writer_error(
@@ -66,7 +66,8 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 			if (odb_read_object_info(r->objects, &oid, &object_size) < 0) {
 				strbuf_addstr(&send_buffer, " ");
 			} else {
-				strbuf_addf(&send_buffer, " %lu", object_size);
+				strbuf_addf(&send_buffer, " %"PRIuMAX,
+					    (uintmax_t)object_size);
 			}
 		}
 
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..21ca58beea 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -250,7 +250,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 {
 	int match = -1;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -3462,7 +3462,7 @@ void *read_blob_data_from_index(struct index_state *istate,
 				const char *path, unsigned long *size)
 {
 	int pos, len;
-	unsigned long sz;
+	size_t sz;
 	enum object_type type;
 	void *data;
 
@@ -3490,7 +3490,7 @@ void *read_blob_data_from_index(struct index_state *istate,
 		return NULL;
 	}
 	if (size)
-		*size = sz;
+		*size = cast_size_t_to_ulong(sz);
 	return data;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..8ba91c72a1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -86,7 +86,7 @@ struct ref_trailer_buf {
 static struct expand_data {
 	struct object_id oid;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	off_t disk_size;
 	struct object_id delta_base_oid;
 	void *content;
diff --git a/reflog.c b/reflog.c
index 82337078d0..04edbe5670 100644
--- a/reflog.c
+++ b/reflog.c
@@ -154,7 +154,7 @@ static int tree_is_complete(const struct object_id *oid)
 
 	if (!tree->buffer) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		void *data = odb_read_object(the_repository->objects, oid,
 					     &type, &size);
 		if (!data) {
diff --git a/rerere.c b/rerere.c
index 0296700f9f..068321b24f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -990,7 +990,7 @@ static int handle_cache(struct index_state *istate,
 
 	while (pos < istate->cache_nr) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 
 		ce = istate->cache[pos++];
 		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
diff --git a/submodule-config.c b/submodule-config.c
index a81897b4e0..f75997402a 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -694,7 +694,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
-	unsigned long config_size;
+	size_t config_size;
 	char *config = NULL;
 	struct object_id oid;
 	enum object_type type;
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index c493b75e02..840797cf0d 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -48,7 +48,8 @@ static void write_ref_delta(struct hashfile *f,
 			    struct object_id *base)
 {
 	unsigned char header[MAX_PACK_OBJECT_HEADER];
-	unsigned long size, base_size, delta_size, compressed_size, hdrlen;
+	unsigned long delta_size, compressed_size, hdrlen;
+	size_t size, base_size;
 	enum object_type type;
 	void *base_buf, *delta_buf;
 	void *buf = odb_read_object(the_repository->objects,
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index a7aab426d0..87c59108e0 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -17,7 +17,7 @@ static void object_info(const char *gitdir, const char *oid_hex)
 {
 	struct repository r;
 	struct object_id oid;
-	unsigned long size;
+	size_t size;
 	struct object_info oi = {.sizep = &size};
 	const char *p;
 
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 482502ef4b..6844bfc37c 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -20,7 +20,7 @@ static void cl_assert_object_info(struct odb_source_inmemory *source,
 				  const char *expected_content)
 {
 	enum object_type actual_type;
-	unsigned long actual_size;
+	size_t actual_size;
 	void *actual_content;
 	struct object_info oi = {
 		.typep = &actual_type,
diff --git a/tag.c b/tag.c
index 2f12e51024..1a00ded6eb 100644
--- a/tag.c
+++ b/tag.c
@@ -49,7 +49,7 @@ int gpg_verify_tag(struct repository *r, const struct object_id *oid,
 {
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	type = odb_read_object_info(r->objects, oid, NULL);
@@ -207,7 +207,7 @@ int parse_tag(struct repository *r, struct tag *item)
 {
 	enum object_type type;
 	void *data;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	if (item->object.parsed)
diff --git a/tree-walk.c b/tree-walk.c
index 7e1b956f27..a67f06b9eb 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -87,7 +87,7 @@ void *fill_tree_descriptor(struct repository *r,
 			   struct tree_desc *desc,
 			   const struct object_id *oid)
 {
-	unsigned long size = 0;
+	size_t size = 0;
 	void *buf = NULL;
 
 	if (oid) {
@@ -610,7 +610,7 @@ int get_tree_entry(struct repository *r,
 {
 	int retval;
 	void *tree;
-	unsigned long size;
+	size_t size;
 	struct object_id root;
 
 	tree = odb_read_object_peeled(r->objects, tree_oid, OBJ_TREE, &size, &root);
@@ -682,7 +682,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 		if (!t.buffer) {
 			void *tree;
 			struct object_id root;
-			unsigned long size;
+			size_t size;
 			tree = odb_read_object_peeled(r->objects, &current_tree_oid,
 						      OBJ_TREE, &size, &root);
 			if (!tree)
@@ -778,6 +778,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 		} else if (S_ISLNK(*mode)) {
 			/* Follow a symlink */
 			unsigned long link_len;
+			size_t link_len_st = 0;
 			size_t len;
 			char *contents, *contents_start;
 			struct dir_state *parent;
@@ -797,7 +798,8 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 
 			contents = odb_read_object(r->objects,
 						   &current_tree_oid, &type,
-						   &link_len);
+						   &link_len_st);
+			link_len = cast_size_t_to_ulong(link_len_st);
 
 			if (!contents)
 				goto done;
diff --git a/tree.c b/tree.c
index d703ab97c8..53f7395e9f 100644
--- a/tree.c
+++ b/tree.c
@@ -188,7 +188,7 @@ int repo_parse_tree_gently(struct repository *r, struct tree *item,
 {
 	 enum object_type type;
 	 void *buffer;
-	 unsigned long size;
+	 size_t size;
 
 	if (item->object.parsed)
 		return 0;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 5ee2b96d0a..db6938689f 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -179,7 +179,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 void read_mmblob(mmfile_t *ptr, struct object_database *odb,
 		 const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	if (is_null_oid(oid)) {
-- 
gitgitgadget
