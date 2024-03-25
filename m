Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB226FBB7
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387470; cv=none; b=OjDMTOeOK08zAlF3o759v3f0W2mGyh0Kb5HAxnSNmMxRWS5dGWYK6vlkHc6B+wAxREAy6Aa4T8Kozi5uYVza6HUYKKhy0UMbqfmLvyjstQmYJ9jwPrbgvR6DsK/Pix9vM0HjEz767qYF36psabgBAe4T/1lCM5XxeozONr41Voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387470; c=relaxed/simple;
	bh=PxxsTghCwbpI/R/U/vBtRR0e0Qp2R4u1xzBNbevGXTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjqFKy35yRPe+keSew4ByImz7yaNr7I+rZCUQlbDAfQoBLGHo3hrEhixA875LgaC68dlN/c6vs1A2fRvhFBC+NJYlBihOkN8F5KhXd+vST+DaNlIqI52xdCabY+SdV0a0h8gaVruKj3rdON/oFjrBOtHXDgz8kqFfCuj8O/kpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YLtozCOw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YLtozCOw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a16114b69so410583785a.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387467; x=1711992267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DrJj5MFYE1iAgO/hSuHaso91cQRw3aJ8mDD+yDQ0OmI=;
        b=YLtozCOwnExcWTH/Kmr1VwvtSGkadToP4i2IQy2SedeskmhSI44hRbru3IuqUs0ywC
         jpXL6juXB23lWJRyCUET6p8EYWKLrln3quDBnnJzDhU0oED7dE7LdkEmMV+HpiIicpeK
         mfTHCSgv0SRNP9RCkQw8tSzPoOSHJmZRXSgmNk3l2ix0sHBAJQdxshP4EavQg7FruAy8
         9z/2MbIt5+/0xXIAoxY+TEaBm6jMTKdILSh/W3wfyvu3xOB0EipnJ+ciPC278TdSc3y0
         18cv9vYRnbe0v+X8dwsv8PFvgzxG6BUqrWpVMWf0vuWiAlufhZZA+/lGUN216pO2BYaM
         HdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387467; x=1711992267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrJj5MFYE1iAgO/hSuHaso91cQRw3aJ8mDD+yDQ0OmI=;
        b=xS2JmP/wKZBqxOMfAh+bWZTz10pQlt96wjammEalH60G4XL4E19bjXEit6nWOFFdJR
         Lc783kTja8nb+rr2t5RkmlZNnlOglSvGMlILtjgCFUdQMUyjl8zWve9SWXf6XBuVPAxc
         +5JQMda+X4YKsU+8ggEFNDqsZyJB4lFC65+sS+Xux3WZG9QwePvxlGkNmqxwIcsZrnRI
         Y6IdRTKsqxBWsH9Z7fAkG52e5FipIbPOtAhkRqOKva6LhwxFmIKB1vCXWN446KOYDgYf
         9l/DlyqQKJg9TwLE48VjVao33062LbONBYDDNOpYGrWjfjUFBnq5GWNCDukp8nefBBpB
         Lc0w==
X-Gm-Message-State: AOJu0YyA4bVCXWmdQX8ge6D46Pj2N8EhBTQwlZQ07oNJnDRX4A4HOrDm
	VDaMTbFA3UHrSKBEzyOzLh8O1LNMQIT5cnYqEER37/zM+WllEQF8P0gHtnW5bPdGakr2G1AWbl9
	OCvs=
X-Google-Smtp-Source: AGHT+IEUdKuG5lf1ORCRt122533QQUINqLbdDumEAGnHi6u8qCzHY4uWMOOu94AZFLHlFQPInAYD4A==
X-Received: by 2002:a05:620a:628b:b0:78a:40f0:7d20 with SMTP id ov11-20020a05620a628b00b0078a40f07d20mr10260333qkn.19.1711387467123;
        Mon, 25 Mar 2024 10:24:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u11-20020ae9c00b000000b0078a3871bdf3sm2285517qkk.4.2024.03.25.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:26 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/11] midx: move `midx_repack` (and related functions) to
 midx-write.c
Message-ID: <487a0ccda8c781a4e7cfdd14d32b0466a867ddff.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

Move `midx_repack()`, the main function which implements the sub-command
'git multi-pack-index repack' into midx-write.c.

This patch does not introduce any behavioral changes and is best viewed
with `--color-moved`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.c       | 196 -------------------------------------------------
 2 files changed, 202 insertions(+), 196 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 4aab273243..6dd58be7e0 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,5 +1,11 @@
 #include "git-compat-util.h"
+#include "config.h"
+#include "hex.h"
+#include "packfile.h"
 #include "midx.h"
+#include "run-command.h"
+#include "pack-bitmap.h"
+#include "revision.h"
 
 extern int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_include,
@@ -10,3 +16,199 @@ extern int write_midx_internal(const char *object_dir,
 
 extern struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir);
+
+struct repack_info {
+	timestamp_t mtime;
+	uint32_t referenced_objects;
+	uint32_t pack_int_id;
+};
+
+static int compare_by_mtime(const void *a_, const void *b_)
+{
+	const struct repack_info *a, *b;
+
+	a = (const struct repack_info *)a_;
+	b = (const struct repack_info *)b_;
+
+	if (a->mtime < b->mtime)
+		return -1;
+	if (a->mtime > b->mtime)
+		return 1;
+	return 0;
+}
+
+static int fill_included_packs_all(struct repository *r,
+				   struct multi_pack_index *m,
+				   unsigned char *include_pack)
+{
+	uint32_t i, count = 0;
+	int pack_kept_objects = 0;
+
+	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
+
+	for (i = 0; i < m->num_packs; i++) {
+		if (prepare_midx_pack(r, m, i))
+			continue;
+		if (!pack_kept_objects && m->packs[i]->pack_keep)
+			continue;
+		if (m->packs[i]->is_cruft)
+			continue;
+
+		include_pack[i] = 1;
+		count++;
+	}
+
+	return count < 2;
+}
+
+static int fill_included_packs_batch(struct repository *r,
+				     struct multi_pack_index *m,
+				     unsigned char *include_pack,
+				     size_t batch_size)
+{
+	uint32_t i, packs_to_repack;
+	size_t total_size;
+	struct repack_info *pack_info;
+	int pack_kept_objects = 0;
+
+	CALLOC_ARRAY(pack_info, m->num_packs);
+
+	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
+
+	for (i = 0; i < m->num_packs; i++) {
+		pack_info[i].pack_int_id = i;
+
+		if (prepare_midx_pack(r, m, i))
+			continue;
+
+		pack_info[i].mtime = m->packs[i]->mtime;
+	}
+
+	for (i = 0; i < m->num_objects; i++) {
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+		pack_info[pack_int_id].referenced_objects++;
+	}
+
+	QSORT(pack_info, m->num_packs, compare_by_mtime);
+
+	total_size = 0;
+	packs_to_repack = 0;
+	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
+		int pack_int_id = pack_info[i].pack_int_id;
+		struct packed_git *p = m->packs[pack_int_id];
+		size_t expected_size;
+
+		if (!p)
+			continue;
+		if (!pack_kept_objects && p->pack_keep)
+			continue;
+		if (p->is_cruft)
+			continue;
+		if (open_pack_index(p) || !p->num_objects)
+			continue;
+
+		expected_size = st_mult(p->pack_size,
+					pack_info[i].referenced_objects);
+		expected_size /= p->num_objects;
+
+		if (expected_size >= batch_size)
+			continue;
+
+		packs_to_repack++;
+		total_size += expected_size;
+		include_pack[pack_int_id] = 1;
+	}
+
+	free(pack_info);
+
+	if (packs_to_repack < 2)
+		return 1;
+
+	return 0;
+}
+
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
+{
+	int result = 0;
+	uint32_t i;
+	unsigned char *include_pack;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	FILE *cmd_in;
+	struct strbuf base_name = STRBUF_INIT;
+	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
+
+	/*
+	 * When updating the default for these configuration
+	 * variables in builtin/repack.c, these must be adjusted
+	 * to match.
+	 */
+	int delta_base_offset = 1;
+	int use_delta_islands = 0;
+
+	if (!m)
+		return 0;
+
+	CALLOC_ARRAY(include_pack, m->num_packs);
+
+	if (batch_size) {
+		if (fill_included_packs_batch(r, m, include_pack, batch_size))
+			goto cleanup;
+	} else if (fill_included_packs_all(r, m, include_pack))
+		goto cleanup;
+
+	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
+	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
+
+	strvec_push(&cmd.args, "pack-objects");
+
+	strbuf_addstr(&base_name, object_dir);
+	strbuf_addstr(&base_name, "/pack/pack");
+	strvec_push(&cmd.args, base_name.buf);
+
+	if (delta_base_offset)
+		strvec_push(&cmd.args, "--delta-base-offset");
+	if (use_delta_islands)
+		strvec_push(&cmd.args, "--delta-islands");
+
+	if (flags & MIDX_PROGRESS)
+		strvec_push(&cmd.args, "--progress");
+	else
+		strvec_push(&cmd.args, "-q");
+
+	strbuf_release(&base_name);
+
+	cmd.git_cmd = 1;
+	cmd.in = cmd.out = -1;
+
+	if (start_command(&cmd)) {
+		error(_("could not start pack-objects"));
+		result = 1;
+		goto cleanup;
+	}
+
+	cmd_in = xfdopen(cmd.in, "w");
+
+	for (i = 0; i < m->num_objects; i++) {
+		struct object_id oid;
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+
+		if (!include_pack[pack_int_id])
+			continue;
+
+		nth_midxed_object_oid(&oid, m, i);
+		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
+	}
+	fclose(cmd_in);
+
+	if (finish_command(&cmd)) {
+		error(_("could not finish pack-objects"));
+		result = 1;
+		goto cleanup;
+	}
+
+	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
+
+cleanup:
+	free(include_pack);
+	return result;
+}
diff --git a/midx.c b/midx.c
index 5f22f01716..3bd8c58642 100644
--- a/midx.c
+++ b/midx.c
@@ -2055,199 +2055,3 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 
 	return result;
 }
-
-struct repack_info {
-	timestamp_t mtime;
-	uint32_t referenced_objects;
-	uint32_t pack_int_id;
-};
-
-static int compare_by_mtime(const void *a_, const void *b_)
-{
-	const struct repack_info *a, *b;
-
-	a = (const struct repack_info *)a_;
-	b = (const struct repack_info *)b_;
-
-	if (a->mtime < b->mtime)
-		return -1;
-	if (a->mtime > b->mtime)
-		return 1;
-	return 0;
-}
-
-static int fill_included_packs_all(struct repository *r,
-				   struct multi_pack_index *m,
-				   unsigned char *include_pack)
-{
-	uint32_t i, count = 0;
-	int pack_kept_objects = 0;
-
-	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
-
-	for (i = 0; i < m->num_packs; i++) {
-		if (prepare_midx_pack(r, m, i))
-			continue;
-		if (!pack_kept_objects && m->packs[i]->pack_keep)
-			continue;
-		if (m->packs[i]->is_cruft)
-			continue;
-
-		include_pack[i] = 1;
-		count++;
-	}
-
-	return count < 2;
-}
-
-static int fill_included_packs_batch(struct repository *r,
-				     struct multi_pack_index *m,
-				     unsigned char *include_pack,
-				     size_t batch_size)
-{
-	uint32_t i, packs_to_repack;
-	size_t total_size;
-	struct repack_info *pack_info;
-	int pack_kept_objects = 0;
-
-	CALLOC_ARRAY(pack_info, m->num_packs);
-
-	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
-
-	for (i = 0; i < m->num_packs; i++) {
-		pack_info[i].pack_int_id = i;
-
-		if (prepare_midx_pack(r, m, i))
-			continue;
-
-		pack_info[i].mtime = m->packs[i]->mtime;
-	}
-
-	for (i = 0; i < m->num_objects; i++) {
-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
-		pack_info[pack_int_id].referenced_objects++;
-	}
-
-	QSORT(pack_info, m->num_packs, compare_by_mtime);
-
-	total_size = 0;
-	packs_to_repack = 0;
-	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
-		int pack_int_id = pack_info[i].pack_int_id;
-		struct packed_git *p = m->packs[pack_int_id];
-		size_t expected_size;
-
-		if (!p)
-			continue;
-		if (!pack_kept_objects && p->pack_keep)
-			continue;
-		if (p->is_cruft)
-			continue;
-		if (open_pack_index(p) || !p->num_objects)
-			continue;
-
-		expected_size = st_mult(p->pack_size,
-					pack_info[i].referenced_objects);
-		expected_size /= p->num_objects;
-
-		if (expected_size >= batch_size)
-			continue;
-
-		packs_to_repack++;
-		total_size += expected_size;
-		include_pack[pack_int_id] = 1;
-	}
-
-	free(pack_info);
-
-	if (packs_to_repack < 2)
-		return 1;
-
-	return 0;
-}
-
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
-{
-	int result = 0;
-	uint32_t i;
-	unsigned char *include_pack;
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	FILE *cmd_in;
-	struct strbuf base_name = STRBUF_INIT;
-	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
-
-	/*
-	 * When updating the default for these configuration
-	 * variables in builtin/repack.c, these must be adjusted
-	 * to match.
-	 */
-	int delta_base_offset = 1;
-	int use_delta_islands = 0;
-
-	if (!m)
-		return 0;
-
-	CALLOC_ARRAY(include_pack, m->num_packs);
-
-	if (batch_size) {
-		if (fill_included_packs_batch(r, m, include_pack, batch_size))
-			goto cleanup;
-	} else if (fill_included_packs_all(r, m, include_pack))
-		goto cleanup;
-
-	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
-	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
-
-	strvec_push(&cmd.args, "pack-objects");
-
-	strbuf_addstr(&base_name, object_dir);
-	strbuf_addstr(&base_name, "/pack/pack");
-	strvec_push(&cmd.args, base_name.buf);
-
-	if (delta_base_offset)
-		strvec_push(&cmd.args, "--delta-base-offset");
-	if (use_delta_islands)
-		strvec_push(&cmd.args, "--delta-islands");
-
-	if (flags & MIDX_PROGRESS)
-		strvec_push(&cmd.args, "--progress");
-	else
-		strvec_push(&cmd.args, "-q");
-
-	strbuf_release(&base_name);
-
-	cmd.git_cmd = 1;
-	cmd.in = cmd.out = -1;
-
-	if (start_command(&cmd)) {
-		error(_("could not start pack-objects"));
-		result = 1;
-		goto cleanup;
-	}
-
-	cmd_in = xfdopen(cmd.in, "w");
-
-	for (i = 0; i < m->num_objects; i++) {
-		struct object_id oid;
-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
-
-		if (!include_pack[pack_int_id])
-			continue;
-
-		nth_midxed_object_oid(&oid, m, i);
-		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
-	}
-	fclose(cmd_in);
-
-	if (finish_command(&cmd)) {
-		error(_("could not finish pack-objects"));
-		result = 1;
-		goto cleanup;
-	}
-
-	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
-
-cleanup:
-	free(include_pack);
-	return result;
-}
-- 
2.44.0.290.g736be63234b

