Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBA370D49
	for <git@vger.kernel.org>; Wed, 27 May 2026 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900965; cv=none; b=Ys0jG9IegA536Ou+sMffCn906g8EjNtv+pXlJx2A/SwTHTviqrwA420loU7Y0f7ac+k53qNbEvUy+il4e92sxMXaMAjaOyv3acLWlXtBYw/0nLB5EN8NPB7trsJLlAvkgA8hL2HG9C4srwrV99PRr1FfLQAy2DzlXP232wEooRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900965; c=relaxed/simple;
	bh=Kg3qaDOnHUhHbrSoO/TbFsefPfyJH+zvEKAJrguduwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7nEalNEwONmhRlDDq6qDc6TpDVNkGNlFQBQ9ba+LSrn+usmZvlwUvTorEVHB1GDCBbZgRKBrj0bZ54MCSwSIgUeItOiogJ/X2yWLGFZlDCgDL6sAurBKxaxalRFQr00xbvm5hY7zpMNWSPdAf18+ufjkRI3OLlx96HoUmPBINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=KinUahfy; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="KinUahfy"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7c5d8f45465so116820277b3.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779900962; x=1780505762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QYrjkXQh1WmHY19i31K3shrzNjMCzDZNdrQIakBQu7E=;
        b=KinUahfyDwQCsHPW3sWzKL3S4UP8UNDowdzUapqE/txwB/A+JB144rlztwv30yQF/e
         lAvKRCeZ7dID0Vwb2FR2wB+JR7zDDVF1O9dkStN2KgZAJnVJwjc/m0i+MdMdrAUsahUf
         Au3UnbkiDAlsrn+/ScOuewMeoEIqJJuyA+MRvNvC9zNysO/zNqiMWzgmwgVYgs+ldh1y
         Q3YioXW/wBLsDLU7Z06KHjwB3D6hFxbLZfZRxciVys4mSQGTRVYOUfPWSu6PYlz4LXfS
         bNMY2THvQRB1FhHmIHP3Q5thPY7NhwHogRNIZirhV6PywN1RuVUNObeMje9HwwWDStgO
         a7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900962; x=1780505762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYrjkXQh1WmHY19i31K3shrzNjMCzDZNdrQIakBQu7E=;
        b=Fn1RiOU9YIVlXpj5JgK4ZJB8ij/Jz+UI2dw22+AxXrT/Lm/ch2EBjQtpTEjhy3erFW
         DKZs9E3C1PZmkUczKZqvNt2z0AOWd7GY0XheSe+QTJQRSif7nlshw7IxX+/hYaLt78Rx
         NYGohiK1kr3WUSUNK1QwiLPBs5uS47aN9YXdBiAjirkHYXJuHaATqDky51vxKkCs+onz
         T4yTlF8ppLVK865g5E2uHSuDbtTMSJCDG90v96gefuNEg2suLeQ56Xr/QSkW1JMrOqrp
         DhXFYMpf0yF9PKMbv+uFUwogIJJOYrdt+PJHlxjysfISu3elv0nJvD3mqShXePTPRUS/
         VA6A==
X-Gm-Message-State: AOJu0Yx4v5WbidrzCQOF1TgWrdl3ZE3mABmY5OAGKjJt51CRvvvDwYX+
	Lk2i/UY3VA65UUyb6HInSmiGKDJYgTCeGVcpN9kjfhcPQ5kfs1uD4rAOe+6vkE3OUaOAYX3kaU6
	BkdNiwjs=
X-Gm-Gg: Acq92OGKbpqqRfoAh4qf2kKh/ykt2+1akfIidJbpJuQjqH4LE6LncqGVLHaXGST0KxI
	q1KTQBmlbjKV5lY3zGiKEWAVtGhIh67f3rzRy9fGpYMrSICR2M/Fy1BvDqVaozSZE4/2CciA3GI
	pPpONpNlnmOnhOgiWnOFIZhV71naNuLSyMQsfomnX5Tuh7XwfDKv2TVRGgFPCc2atrrUf8tlWZf
	NHjjSUL4IuDCl7PN6jH+JZMit9oc/NNKFJvZYPOD16eR6rDep2oBo8Ze2xj8vCyttnico+WAmyZ
	+V2QNA/vSA0laeofriUwGq8lKqHB4cUsqhH4OFaPHIucNc9ef+ckX86CSHm1pm+WlorpYWTw6EJ
	RW4zVqKhOwFdrudGkHs6Ioh+V5JvHRncaP8R1X0bePD+Zh5iFHiyp6mr9BUF+p1Qeu1XyY83t7t
	EoPiIlK8lTIvkSyxc7Kdp7pyD8mb5PImbbyQpuEKc30hTfmCJKwciNHpqYqFuLe9pMDcpvTPNM8
	vQpZfDh2fByWNnCz4hFZbNG0W1z8FtzHLEqY+lv8NPeE3DyJfaayWOsWr8q4/H1P0GU+1K+l9Ti
	DPmRXc4bfcACHX+b3HDLlocIfKg=
X-Received: by 2002:a05:690c:3608:b0:7ba:eefe:9f75 with SMTP id 00721157ae682-7d3357d588emr264596317b3.31.1779900961689;
        Wed, 27 May 2026 09:56:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38be36898sm76770527b3.27.2026.05.27.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:56:01 -0700 (PDT)
Date: Wed, 27 May 2026 12:56:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 6/8] pack-bitmap: sort bitmaps before XORing
Message-ID: <ahciIDuESxNa9Fzn@nand.local>
References: <cover.1779207127.git.me@ttaylorr.com>
 <b0a4f31353a7053ab37b6d8c8f22c69bcfadfe50.1779207127.git.me@ttaylorr.com>
 <20260527100406.GG981444@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527100406.GG981444@coredump.intra.peff.net>

On Wed, May 27, 2026 at 06:04:06AM -0400, Jeff King wrote:
> On Tue, May 19, 2026 at 12:12:50PM -0400, Taylor Blau wrote:
>
> > Reachability bitmaps may be stored as XORs against nearby bitmaps, up to
> > 10 away. However, when callers provide selected commits in an arbitrary
> > order, the writer may miss good ancestor/descendant pairs and produce
> > much larger bitmap files without changing query coverage.
> >
> > Sort the selected bitmaps in date order (from oldest to newest) before
> > computing XOR offsets, leaving pseudo-merge bitmaps alone (which we will
> > deal with separately in following commits).
>
> That order certainly makes the most sense. I'd have thought we ended up
> there incidentally because of the order in which we consider the
> commits, but perhaps not. I wonder if this got much worse when we
> re-wrote the bitmap generation code a few years ago.
>
> That was in v2.31.0, I think. Repacking linux.git with bitmaps, though,
> I couldn't find any difference in size between v2.30 and v2.31. They're
> both ~67M. But that also didn't shrink with this patch, either.
>
> If you have some spare CPU cycles to burn, I would be interested in a
> comparison of the bitmap size of your test repo using v2.30.0, v2.31.1,
> and this patch.

I started running this experiment, but I don't think I actually have
enough CPU cycles to let it finish ;-). Pre-v2.31 bitmap generation is
*really* slow[^1], and after multiple hours (forcing the same selection
of bitmaps by back-porting and adjusting 'test-tool bitmap') I couldn't
seem to make any meaningful progress.

I'm sure that you could get some plausible numbers out of benchmarking
this on a smaller repository. In case you're interested, here's the
patch I wrote on top of v2.30.0:

--- 8< ---
diff --git a/Makefile b/Makefile
index 7b64106930a..9ce9f2b483c 100644
--- a/Makefile
+++ b/Makefile
@@ -690,6 +690,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))

 TEST_BUILTINS_OBJS += test-advise.o
+TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5e998bdaa79..55dbb475120 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -113,7 +113,7 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 static struct object **seen_objects;
 static unsigned int seen_objects_nr, seen_objects_alloc;

-static inline void push_bitmapped_commit(struct commit *commit, struct ewah_bitmap *reused)
+void bitmap_writer_push_commit(struct commit *commit, struct ewah_bitmap *reused)
 {
 	if (writer.selected_nr >= writer.selected_alloc) {
 		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
@@ -402,7 +402,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,

 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
-			push_bitmapped_commit(indexed_commits[i], NULL);
+			bitmap_writer_push_commit(indexed_commits[i], NULL);
 		return;
 	}

@@ -440,7 +440,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 			}
 		}

-		push_bitmapped_commit(chosen, reused_bitmap);
+		bitmap_writer_push_commit(chosen, reused_bitmap);

 		i += next + 1;
 		display_progress(writer.progress, i);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 1203120c432..a882efdb16a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -74,6 +74,8 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
 				    uint32_t index_nr);
 void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack);
+void bitmap_writer_push_commit(struct commit *commit,
+			       struct ewah_bitmap *reused);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
 void bitmap_writer_build(struct packing_data *to_pack);
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
new file mode 100644
index 00000000000..9be03377c06
--- /dev/null
+++ b/t/helper/test-bitmap.c
@@ -0,0 +1,119 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "commit.h"
+#include "packfile.h"
+#include "pack-bitmap.h"
+
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
+	entry->in_pack_offset = nth_packed_object_offset(pack, pos);
+	entry->idx.offset = entry->in_pack_offset;
+	if (packed_object_info(the_repository, pack, entry->in_pack_offset, &oi) < 0)
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
+	struct pack_idx_entry **index;
+	struct strbuf buf = STRBUF_INIT;
+	uint32_t i;
+
+	prepare_repo_settings(the_repository);
+	for (p = get_all_packs(the_repository); p; p = p->next) {
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
+				FOR_EACH_OBJECT_PACK_ORDER);
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
+	bitmap_writer_build_type_index(&packed, index, p->num_objects);
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
+		bitmap_writer_push_commit(c, NULL);
+	}
+
+	bitmap_writer_build(&packed);
+
+	bitmap_writer_set_checksum(p->hash);
+
+	QSORT(index, p->num_objects, idx_oid_cmp);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, p->pack_name);
+	strbuf_strip_suffix(&buf, ".pack");
+	strbuf_addstr(&buf, ".bitmap");
+	bitmap_writer_finish(index, p->num_objects, buf.buf, 0);
+
+	strbuf_release(&buf);
+	free(index);
+
+	return 0;
+}
+
+int cmd__bitmap(int argc, const char **argv)
+{
+	setup_git_directory();
+
+	if (argc == 3 && !strcmp(argv[1], "write"))
+		return bitmap_write(argv[2]);
+
+	usage("\ttest-tool bitmap write <pack-basename> < <commit-list>");
+
+	return -1;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9d6d14d9293..c43d8c0977b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -15,6 +15,7 @@ struct test_cmd {

 static struct test_cmd cmds[] = {
 	{ "advise", cmd__advise_if_enabled },
+	{ "bitmap", cmd__bitmap },
 	{ "bloom", cmd__bloom },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a6470ff62c4..27e6e40ffcb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -5,6 +5,7 @@
 #include "git-compat-util.h"

 int cmd__advise_if_enabled(int argc, const char **argv);
+int cmd__bitmap(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
--- >8 ---

> > On our same testing repository from previous commits, this change shrunk
> > our selection of 1,261 bitmaps from ~635.46 MiB to 176.4 MiB for a
> > ~72.24% reduction in the on-disk size of our *.bitmap file. The time to
> > generate the smaller bitmap file decreased by ~3.69 seconds, though this
> > is likely mostly noise.
>
> Certainly good numbers. The obvious follow-up question is: how does the
> reading side fare? I'd expect it to be a little better, if only because
> there are fewer bytes to consider when XOR-ing. But if there's some
> hidden assumption we're missing, then it could get wildly worse. It
> would be good to confirm that that didn't happen. ;)

It doesn't make a huge difference. Prior to this patch, the timings on
my test repository for 'git rev-list --count --all --objects
--use-bitmap-index' go from:

 -  2.180 ± 0.019 seconds (with pseudo-merges)
 - 52.149 ± 0.224 seconds (without pseudo-merges)

, and after applying this patch, it changes to:

 -  2.611 ± 0.023 seconds (with pseudo-merges)
 - 51.963 ± 0.131 seconds (without pseudo-merges)

It looks like there is a minor slow-down on pseudo-merges, and a minor
speed-up without them. The difference is small enough that I'm willing
to treat it as run-to-run noise.

> >  static void compute_xor_offsets(struct bitmap_writer *writer)
> >  {
> >  	static const int MAX_XOR_OFFSET_SEARCH = 10;
> >
> >  	int i, next = 0;
> > +	int nr = bitmap_writer_nr_selected_commits(writer);
> > +
> > +	if (nr > 1) {
> > +		QSORT(writer->selected, nr, bitmapped_commit_date_cmp);
> > +
> > +		for (i = 0; i < nr; i++) {
> > +			struct bitmapped_commit *stored = &writer->selected[i];
> > +			khiter_t hash_pos = kh_get_oid_map(writer->bitmaps,
> > +							   stored->commit->object.oid);
> > +
> > +			if (hash_pos == kh_end(writer->bitmaps))
> > +				BUG("selected commit missing from bitmap map: %s",
> > +				    oid_to_hex(&stored->commit->object.oid));
> > +
> > +			kh_value(writer->bitmaps, hash_pos) = stored;
> > +		}
> > +	}
>
> OK. It took me a minute to wrap my head around this. The real work is
> done by QSORT(). But because we maintain a hash pointing into that
> array, we have to go through each hash entry and fix up its pointer.

Yup.

> Looks correct.

Thanks,
Taylor

[^1]: ...and I have great empathy for Stolee's suffering here when
  benchmarking his performance improvements to the bitmap generation
  code from back in the day! ;-).
