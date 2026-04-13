Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15B39EF15
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124604; cv=none; b=YOk99QbRpjCva/HNj/BWP9vLxx9OTIMD13mlsJhUwFUY4m7rYCzLQ1iYIBs4aXsY5xzrQnyoT2oWBLnE5f87pbM5/0brffioeTR2kt8N4E8xGl3gJXo7mqu43Nn0WyLL5iEIbpRV0HTsdlWRYUUH1C2WEUiuaXyqz9/VkeIcy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124604; c=relaxed/simple;
	bh=k3x2OLOJPmNwd9K2Crfr0z0WpivVld3ZaULEhvbV0yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj7yz0S0yW1IHxsRrCiaN/kvZXRmNEDq5+RnvnIxSBrLZLxcw+lTqHASN+VT3uExtGjyXnT+ipE/4amIvXGDyVSkHw48/Pv9MnMqZmd/+v0NqE4qwJu+i5XMw58LRCjul9EJfsGSTeHM3YdhGY6Jot6dY2Uj7/PsyelyULdPM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ByAmSTb2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ByAmSTb2"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79885f4a8ffso50307467b3.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124602; x=1776729402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ1rt6a0d4MNTb8/BRcWEkqWxEPfGobXBTuDLKCQC9c=;
        b=ByAmSTb2aGo9vUQmCHIahEjuP6hXSYDmtJOZ678vHynqWMzI0+1Mkw1kGU1AEb/M6t
         QBvfzmwIzG/VQOgd3Vd+kqQKDNKBimxeklwtH6c1e/YuWI+APhsfYq81HQl0l6gMic8h
         qGbQWWytDrns+iPvqFjCnc0b70fchp+AHaxdKAy3uLfv56fD4NvJ+oW/DI6ylTiKv2JU
         E+WBS4QqhXBkg3omDynow/Rn9GyAA5y7Kocdtr3uOAz86AAaFMK6Ggnlu9uiASdECqgX
         4LzASBQpQD+qgHpmLWsnLkV/GxpN+rCOVi8HUTIjlvIdMAwe8eDQ0mez2RmIEK7BQqNc
         WEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124602; x=1776729402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJ1rt6a0d4MNTb8/BRcWEkqWxEPfGobXBTuDLKCQC9c=;
        b=ooGDdKZ1dMB4Wv4ntUTMyK+bHidCDFUqkiy5b2L+sowCzSZ38h403SuIdPPaw7vpoK
         sTEFrbjyuMYgUQnxxCyv9Qa8hthUpPuywTRwayZHQCuKErVjTlisqiS4SqsddRopjHH7
         bK+3o77d4QEO7XyA+9MgftqFcN8pyNh3ECWvyr1//3fKDUTTI/Q04s1GMAu4ZT1ZRo5j
         lVVLmUn7YNmRt7zlFw0ODOL7hnEjJk1OerFi6jhJTpt0oPfHP3GcH3D0qm/Rg425q8QZ
         nip3msflOL/cKxaOKt0RLWnGcv7d+MpPP4JDU5zgZopf8TVc4xfJWiogqUw9J0dfYhC0
         YxNA==
X-Gm-Message-State: AOJu0YxuZ5ZJ9C+JPKHFj8BkMMXEcEA8b2L4rnUnlbG6Dz35OhqY8g7J
	ruBn7rjbLN7oFs/OpcAjTSf7yx/3yIXJ6ojMIMTXIJ7+bywrH+4bR0P3X5PEXxj2pt+/ev348Tk
	TaiNKnKQ=
X-Gm-Gg: AeBDiet79xTKDz+gJvVvFOZuDsateQhSWrVADnlZ3DUaY1CLRLQa4S0VH2zqoAABvzi
	4KvyQW695aWWSmxCkuwbvDxvJrahHpzYPi/XWNdbsLvm9WPOI67wj84xtuSHJJVFK+i3y/rCzFN
	PxRNL/RbUoaBbmoYyWxQutcGKHwA409XKyH2fNFjfvkvtg5dWwkL6GuKrOk8Y0X5n3yclWDzY4T
	jr8wO+QIer2+q5Stgz64DrysWLXDuBWYkCJmFtAOtRWnl1m8cglPM/pCe9IrUD0WWuOrDkZXS3n
	E1rJtgv8xDGMhL0JIOnVL2yAYFGImC4ScTVsVFwxWk/5Tseb1LDDvawSojiyyKBX8CA5+njz0or
	u6qb71G1P9vy9XJ9WDLjWrW1gZBM1JkNTkQGKrD0sawuG1ZpnhrZwR6vPNFdUU4H4YBq+X1SwiN
	hGjzDTRghKWM1DpZU/9kDA7CTWb2hQUNBhg+cGWmaP5U/hBjND3PgOHyo3c1et0Diux4TYdI4MZ
	lhk4Rc1YTP/aAtLUkGBdq2nzCEC3uxa9EyTD34TnS/Iy7rCPDpPmLPrLVcv0YvGaW9WhWVnq+Tb
	S4U90zO/raIuywVVdlbJmuKHmvU7LHVRWI8nag==
X-Received: by 2002:a05:690c:6e87:b0:7a1:dbab:9406 with SMTP id 00721157ae682-7af6ef40077mr158110907b3.8.1776124601785;
        Mon, 13 Apr 2026 16:56:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa0618fsm57901887b3.37.2026.04.13.16.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:56:41 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:56:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
Message-ID: <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776124588.git.me@ttaylorr.com>

In f16eb1c091 (pseudo-merge: fix disk reads from find_pseudo_merge(),
2026-03-31), we noted that `apply_pseudo_merges_for_commit()` is never
triggered by the existing test suite, and that this bears further
investigation.

This patch is the first one to begin that investigation. The following
patches will expose and fix a variety of bugs in the implementation of
pseudo-merge bitmaps.

In order to do so, however, many of these tests require very precise
selection of which commits receive bitmaps and which do not. To date,
there isn't a standard approach to easily facilitate this. Address this
by introducing a `test-tool bitmap write` subcommand that writes a
bitmap for a given packfile, reading the set of commits which should
receive individual bitmaps from stdin like so:

    test-tool bitmap write <pack-basename> </path/to/commits.list

, where "<pack-basename>" is the filename for a specific packfile (e.g.,
"pack-abc123.pack"), and "/path/to/commits.list" is a list of commit
OIDs which will receive bitmaps.

The helper respects `bitmapPseudoMerge.*` configuration for creating
pseudo-merge bitmaps alongside the regular commit bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-bitmap.c  | 110 +++++++++++++++++++++++++++++++++++++++-
 t/t5310-pack-bitmaps.sh |  24 +++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 16a01669e41..96c0000c787 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -2,7 +2,10 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "hex.h"
+#include "odb.h"
 #include "pack-bitmap.h"
+#include "pseudo-merge.h"
 #include "setup.h"
 
 static int bitmap_list_commits(void)
@@ -35,6 +38,108 @@ static int bitmap_dump_pseudo_merge_objects(uint32_t n)
 	return test_bitmap_pseudo_merge_objects(the_repository, n);
 }
 
+struct bitmap_writer_data {
+	struct packing_data packed;
+	struct pack_idx_entry **index;
+	uint32_t nr;
+};
+
+static int add_packed_object(const struct object_id *oid,
+			     struct packed_git *pack,
+			     uint32_t pos,
+			     void *_data)
+{
+	struct bitmap_writer_data *data = _data;
+	struct object_entry *entry;
+	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
+
+	oi.typep = &type;
+
+	entry = packlist_alloc(&data->packed, oid);
+	entry->idx.offset = nth_packed_object_offset(pack, pos);
+	if (packed_object_info(pack, entry->idx.offset, &oi) < 0)
+		die("could not get type of object %s",
+		    oid_to_hex(oid));
+	oe_set_type(entry, type);
+	oe_set_in_pack(&data->packed, entry, pack);
+	data->index[data->nr++] = &entry->idx;
+
+	return 0;
+}
+
+static int idx_oid_cmp(const void *va, const void *vb)
+{
+	const struct pack_idx_entry *a = *(const struct pack_idx_entry **)va;
+	const struct pack_idx_entry *b = *(const struct pack_idx_entry **)vb;
+
+	return oidcmp(&a->oid, &b->oid);
+}
+
+static int bitmap_write(const char *basename)
+{
+	struct packed_git *p = NULL;
+	struct bitmap_writer_data data = { 0 };
+	struct bitmap_writer writer;
+	struct strbuf buf = STRBUF_INIT;
+
+	prepare_repo_settings(the_repository);
+	repo_for_each_pack(the_repository, p) {
+		if (!strcmp(pack_basename(p), basename))
+			break;
+	}
+
+	if (!p)
+		die("could not find pack '%s'", basename);
+
+	if (open_pack_index(p))
+		die("cannot open pack index for '%s'", p->pack_name);
+
+	prepare_packing_data(the_repository, &data.packed);
+	ALLOC_ARRAY(data.index, p->num_objects);
+
+	for_each_object_in_pack(p, add_packed_object, &data,
+				ODB_FOR_EACH_OBJECT_PACK_ORDER);
+
+	bitmap_writer_init(&writer, the_repository, &data.packed, NULL);
+	bitmap_writer_build_type_index(&writer, data.index);
+
+	while (strbuf_getline_lf(&buf, stdin) != EOF) {
+		struct object_id oid;
+		struct commit *c;
+
+		if (get_oid_hex(buf.buf, &oid))
+			die("invalid OID: %s", buf.buf);
+
+		c = lookup_commit(the_repository, &oid);
+		if (!c || repo_parse_commit(the_repository, c))
+			die("could not parse commit %s", buf.buf);
+
+		bitmap_writer_push_commit(&writer, c, false);
+	}
+
+	select_pseudo_merges(&writer);
+	if (bitmap_writer_build(&writer) < 0)
+		die("failed to build bitmaps");
+
+	bitmap_writer_set_checksum(&writer, p->hash);
+
+	QSORT(data.index, p->num_objects, idx_oid_cmp);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, p->pack_name);
+	strbuf_strip_suffix(&buf, ".pack");
+	strbuf_addstr(&buf, ".bitmap");
+	bitmap_writer_finish(&writer, data.index, buf.buf, 0);
+
+	bitmap_writer_free(&writer);
+	strbuf_release(&buf);
+	free(data.index);
+	clear_packing_data(&data.packed);
+
+	return 0;
+}
+
 int cmd__bitmap(int argc, const char **argv)
 {
 	setup_git_directory();
@@ -51,13 +156,16 @@ int cmd__bitmap(int argc, const char **argv)
 		return bitmap_dump_pseudo_merge_commits(atoi(argv[2]));
 	if (argc == 3 && !strcmp(argv[1], "dump-pseudo-merge-objects"))
 		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
+	if (argc == 3 && !strcmp(argv[1], "write"))
+		return bitmap_write(argv[2]);
 
 	usage("\ttest-tool bitmap list-commits\n"
 	      "\ttest-tool bitmap list-commits-with-offset\n"
 	      "\ttest-tool bitmap dump-hashes\n"
 	      "\ttest-tool bitmap dump-pseudo-merges\n"
 	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
-	      "\ttest-tool bitmap dump-pseudo-merge-objects <n>");
+	      "\ttest-tool bitmap dump-pseudo-merge-objects <n>\n"
+	      "\ttest-tool bitmap write <pack-basename> < <commit-list>");
 
 	return -1;
 }
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f693cb56691..9489e59fa55 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -648,4 +648,28 @@ test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
 	test_grep corrupted.bitmap.index stderr
 '
 
+test_expect_success 'test-tool bitmap write' '
+	git init bitmap-write-helper &&
+	test_when_finished "rm -fr bitmap-write-helper" &&
+	(
+		cd bitmap-write-helper &&
+
+		test_commit_bulk 64 &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		git rev-parse HEAD >commits &&
+		test-tool bitmap write "$(basename $pack)" <commits &&
+
+		test-tool bitmap list-commits | sort >actual &&
+		sort commits >expect &&
+		test_cmp expect actual &&
+
+		git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		git rev-list --count --objects HEAD >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.54.0.rc1.73.g8f4e0170952

