Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294F3DD524
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801720; cv=none; b=pYAZpnJAkxCw2IJppM6QuZbtYKQvZQKXM92RKVQX/1Urw4Pt2zD0rrQ7iSqYgcf/7dr4jSuXCb38EmU/NYCX+OfJ602zhkwUJz5EZnAyYF27nkWhJmcVcpSgDs0XqItfMdXDqDl+0NlWT8KrcyunG+DFrwqMB4/y1TxJmGSolyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801720; c=relaxed/simple;
	bh=ogc/39joTXbRTOapjTat3jcaIOpA/VA1EPenOhWCfvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuMteh/JngRjqo6neLEi2RZX+Uv+sn/MazlNnv8hHGp+DrFTr7zx+vs/kw40VF68ZF6f2p8rZT+dtKbQkzocmUM9wDsjUi+yiqlUkAWLBb4BgPH1PS7SONhgL7YJLupqjf9Uqjhjz6yQJtf7ha4Z3lKZCQgHSMwr1qRvqHkt8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ofULLkrW; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ofULLkrW"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so2721589fac.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801717; x=1777406517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nxjkn2NsnThnkSLuFzQnVRha13va4MGf4Bf70mo5+QM=;
        b=ofULLkrWABBclNqkeG6vNTiw096VEtaCjgP8lLd2YzN6z8EF2ejZvKomuEEyodGIUx
         X69qJECpkMxeUtTJRuGGyScLyuFn5K1gNuPkMJWSeKiZV2DlyH0PT0sUF124BsuAGWYk
         JPX0hKG/+RUmoZklNe8H0Fo6GitYkpq4wPOjVyCfJHZ7/sKRbijToQDPX+aLnGOhLTln
         hTYyowO5Ksj0JM39TxuFDXByier5m2i30HOuccNOskBaUT/1v6fai7yUQT8rDjCIgZL3
         xChkN3puI9kfOWmbdevkt4mgL2vxflQ9Uu/wEvlz33q1t3DHG1DFE7eZ30CR6nstvKLk
         kAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801717; x=1777406517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nxjkn2NsnThnkSLuFzQnVRha13va4MGf4Bf70mo5+QM=;
        b=RANSBheACToMpQznWzORZXaC5e48leUjStnHJiL2Sdl9eb/1n3aL0+mF1JwWrQSrhq
         ou5v1l1vkTiVQ9mIZy5DqnY/LhuTa/Idc5xjzm31VztTAgUmEtdr85N3GzIWmRqXxA1w
         ry2gdWqfmNfzhWkQznva6nBvdZ/33HjOI4tj8NguWr28Z/41m6jSE7qJrQMlKOA1fcrW
         gl3GeQ3n9D6eZlDGHtCj8xwlhE3+XN5U8PWptnmpls0tC9wOPXT5jayfTstS2TnP5ND2
         S4qhPl/QBS6Bjhi34y1RZpH2IG74n5HBZf/kFNaXdZcg+3j4nAHDAZBirYjP9f+urJ0d
         bZZQ==
X-Gm-Message-State: AOJu0YwI02scGcgJ4bBMjTNbNQ5hE/TWvqwW8LSQWV5ki4/rYA3HZD9p
	GDyKXN+GyR3Sez57WN62ZhAgtbsO1rmxDDk6bkDfc/pytRHps1fB2DPMVCDlIohJVK+mizv0J1H
	ZWCj01P8=
X-Gm-Gg: AeBDietIycW8FH8p36h+v0U9g+WTbQ7JEpn6nZhtYb9b5tQNdQQD9btVQ5y8m9R91k6
	HtHJdfa/2DlpwaQflRhcDA57V3FvkfgVkV8Tes2eBh8dXAaG9qhKQ3zhuZDC+/pSOxfxhujcw3i
	R+ZpVQRQ9azUPsavuiHx+nHTB5tf8y46r6uSrIuAfHi6snZKw/YpvY8sG1gI6M2q1jcaMvKIMG7
	KrL9++XJBjqfC5DqkX6slvIapv/gSkCZvEIk6DfQpum6nJq99EwQfCoiEQH6DsHxZhHgzk95hcL
	JJQIp3K9n4JMHZVa37bexi1RU5Hb7wqGFC0+4ah1b+RCjB4/mJbcXp68YVk/7IjJ5ZM9+RFwaR1
	UoxwN8FQeFUyYZOcp2uA67FW3gG8JAUmcl/FCb4sn67hhvq0srwlaKQU5dZsqUvmfLVBYbJyB54
	DzHsWnQ6unySkjfZIz28a9FtLUoIMlZDfCrdam0cM8+ypLiJWk3XzHvrFpY8/pgQGW11HwibydH
	7Vt/ZleySPNEbUMVltiNdKNco2asOZYqMRgjldmDl0IL9lAvgz8dN/4Ivoz+SMboyBu7iuhOH/A
	xnJKBudxMrD4lq5wUEa361SKgTk=
X-Received: by 2002:a05:6871:4396:b0:41c:b538:e19c with SMTP id 586e51a60fabf-42adedba3b0mr11244780fac.38.1776801717124;
        Tue, 21 Apr 2026 13:01:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2e8esm13211348fac.10.2026.04.21.13.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:01:56 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:01:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/9] t/helper: add 'test-tool bitmap write' subcommand
Message-ID: <c0df35f8ebd910e7844ea0ce0c9de62dfe18d423.1776801694.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776801694.git.me@ttaylorr.com>

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
 t/helper/test-bitmap.c  | 113 +++++++++++++++++++++++++++++++++++++++-
 t/t5310-pack-bitmaps.sh |  24 +++++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 16a01669e41..381e9b58b2c 100644
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
@@ -35,6 +38,111 @@ static int bitmap_dump_pseudo_merge_objects(uint32_t n)
 	return test_bitmap_pseudo_merge_objects(the_repository, n);
 }
 
+static int add_packed_object(const struct object_id *oid,
+			     struct packed_git *pack,
+			     uint32_t pos,
+			     void *_data)
+{
+	struct packing_data *packed = _data;
+	struct object_entry *entry;
+	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
+
+	oi.typep = &type;
+
+	entry = packlist_alloc(packed, oid);
+	entry->idx.offset = nth_packed_object_offset(pack, pos);
+	if (packed_object_info(pack, entry->idx.offset, &oi) < 0)
+		die("could not get type of object %s",
+		    oid_to_hex(oid));
+	oe_set_type(entry, type);
+	oe_set_in_pack(packed, entry, pack);
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
+	struct packing_data packed = { 0 };
+	struct bitmap_writer writer;
+	struct pack_idx_entry **index;
+	struct strbuf buf = STRBUF_INIT;
+	uint32_t i;
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
+	prepare_packing_data(the_repository, &packed);
+
+	for_each_object_in_pack(p, add_packed_object, &packed,
+				ODB_FOR_EACH_OBJECT_PACK_ORDER);
+
+	/*
+	 * Build the index array now that data.packed.objects[] is
+	 * fully allocated (packlist_alloc() may have reallocated it
+	 * during the loop above).
+	 */
+	ALLOC_ARRAY(index, p->num_objects);
+	for (i = 0; i < p->num_objects; i++)
+		index[i] = &packed.objects[i].idx;
+
+	bitmap_writer_init(&writer, the_repository, &packed, NULL);
+	bitmap_writer_build_type_index(&writer, index);
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
+		bitmap_writer_push_commit(&writer, c, 0);
+	}
+
+	select_pseudo_merges(&writer);
+	if (bitmap_writer_build(&writer) < 0)
+		die("failed to build bitmaps");
+
+	bitmap_writer_set_checksum(&writer, p->hash);
+
+	QSORT(index, p->num_objects, idx_oid_cmp);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, p->pack_name);
+	strbuf_strip_suffix(&buf, ".pack");
+	strbuf_addstr(&buf, ".bitmap");
+	bitmap_writer_finish(&writer, index, buf.buf, 0);
+
+	bitmap_writer_free(&writer);
+	strbuf_release(&buf);
+	free(index);
+	clear_packing_data(&packed);
+
+	return 0;
+}
+
 int cmd__bitmap(int argc, const char **argv)
 {
 	setup_git_directory();
@@ -51,13 +159,16 @@ int cmd__bitmap(int argc, const char **argv)
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
index f693cb56691..efeb71593bf 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -648,4 +648,28 @@ test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
 	test_grep corrupted.bitmap.index stderr
 '
 
+test_expect_success 'test-tool bitmap write determines bitmap selection' '
+	test_when_finished "rm -fr bitmap-write-helper" &&
+	git init bitmap-write-helper &&
+	(
+		cd bitmap-write-helper &&
+
+		test_commit_bulk 64 &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		git rev-parse HEAD >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test-tool bitmap list-commits >bitmaps.raw &&
+		sort bitmaps.raw >bitmaps &&
+		test_cmp in bitmaps &&
+
+		git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		git rev-list --count --objects HEAD >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.54.0.9.gb905fd5d0ae

