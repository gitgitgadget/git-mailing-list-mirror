Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A3B1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934926AbeF3JIt (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:08:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40245 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbeF3JIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:32 -0400
Received: by mail-lf0-f65.google.com with SMTP id y200-v6so2870845lfd.7
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdqFgIpb9rkKHeq1/35yBpH/8vzXLEUWjXCxm5KIftg=;
        b=IJbh1SC+LtCJyR+uf0RnaCbD0BRQbN9SogX6C4kDcZuC2UGS7ZyhWGeLbRvHVng8er
         87L/2dQyoN/Q0nByUDs898U5KZAxt/7Gm3/SLl8srKjrLJ11kErVEFF7mKplmctwm5GU
         bnHy6HutBaEvZFKq2Q33ehx7heMU7oO+pZORpwWnKM3cgNnl20A6SDkkEAh+EbuSmEQr
         ELtfr3ABjiWF0FocLfIAlQFXuZlSklKldkCSWhMJO9EQZ/tcNI7ATTtIFS1nTDtVPjJi
         vKkpQMOPm08wElVglv605yn7mPyHpcnc/deSEHWLTAIhNtH7opp/3io/r4Yk98wa762/
         IuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdqFgIpb9rkKHeq1/35yBpH/8vzXLEUWjXCxm5KIftg=;
        b=jlp4Qski8Jm4wyLQnQiiPRFXX6kmRMwE7iYOuIITpSIgcddfMgPe0yc/mxd9h7Qf/O
         xG3YwzJPzUvJdie5Rj01ze/6UFRrh3ZwN/Ig46eXou2bhHzbWsYI00dPGLFnoH5TqC5B
         tx01SzvkbXMEBLCZIAWlloPLTdFOKIH6sC3BfI/73KgvaA6pdVlhwHKgvvBu0BHL4tZn
         NrBs3zIcYSX+oKd+ORgMp0u3I2TrBWfrX51ImurukiiJLOAfMerirXEntEfmriRvAOT4
         gw56PoKtjGMJbUF4Z2HpIYYoUXo7cdAKGZDYwTZaW+MhiG1JNxfAiBzWjBIo1vEHNmWN
         0CtQ==
X-Gm-Message-State: APt69E1sUz5w3RDrn65BKhkIoiNPv6Og6QJpjkQqwwT3XejQWEZ+nio7
        oCVwxVW+SMyE7Bi2NgPQ6dimHg==
X-Google-Smtp-Source: AAOMgpcbD6E3yPUzKFjkIO+OyjJsuqdlopFeMJ9/52Z5uztfZljOZkqI8dj1HdjPWoPSumQM00MKDw==
X-Received: by 2002:a19:d890:: with SMTP id r16-v6mr5691052lfi.7.1530349710749;
        Sat, 30 Jun 2018 02:08:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/23] builtin/pack-objects.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:01 +0200
Message-Id: <20180630090818.28937-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of these are straight forward. GETTEXT_POISON does catch the last
string in cmd_pack_objects(), but since this is --progress output, it's
not supposed to be machine-readable.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 108 +++++++++++++++++++++--------------------
 t/t5500-fetch-pack.sh  |   2 +-
 2 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a6ece425d..5c697279a9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -140,7 +140,7 @@ static void *get_delta(struct object_entry *entry)
 
 	buf = read_object_file(&entry->idx.oid, &type, &size);
 	if (!buf)
-		die("unable to read %s", oid_to_hex(&entry->idx.oid));
+		die(_("unable to read %s"), oid_to_hex(&entry->idx.oid));
 	base_buf = read_object_file(&DELTA(entry)->idx.oid, &type,
 				    &base_size);
 	if (!base_buf)
@@ -149,7 +149,7 @@ static void *get_delta(struct object_entry *entry)
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
 	if (!delta_buf || delta_size != DELTA_SIZE(entry))
-		die("delta size changed");
+		die(_("delta size changed"));
 	free(buf);
 	free(base_buf);
 	return delta_buf;
@@ -406,7 +406,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	datalen = revidx[1].offset - offset;
 	if (!pack_to_stdout && p->index_version > 1 &&
 	    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
-		error("bad packed object CRC for %s",
+		error(_("bad packed object CRC for %s"),
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
 		return write_no_reuse_object(f, entry, limit, usable_delta);
@@ -417,7 +417,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 
 	if (!pack_to_stdout && p->index_version == 1 &&
 	    check_pack_inflate(p, &w_curs, offset, datalen, entry_size)) {
-		error("corrupt packed object for %s",
+		error(_("corrupt packed object for %s"),
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
 		return write_no_reuse_object(f, entry, limit, usable_delta);
@@ -548,7 +548,7 @@ static enum write_one_status write_one(struct hashfile *f,
 	 */
 	recursing = (e->idx.offset == 1);
 	if (recursing) {
-		warning("recursive delta detected for object %s",
+		warning(_("recursive delta detected for object %s"),
 			oid_to_hex(&e->idx.oid));
 		return WRITE_ONE_RECURSIVE;
 	} else if (e->idx.offset || e->preferred_base) {
@@ -582,7 +582,7 @@ static enum write_one_status write_one(struct hashfile *f,
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (signed_add_overflows(*offset, size))
-		die("pack too large for current definition of off_t");
+		die(_("pack too large for current definition of off_t"));
 	*offset += size;
 	return WRITE_ONE_WRITTEN;
 }
@@ -748,7 +748,8 @@ static struct object_entry **compute_write_order(void)
 	}
 
 	if (wo_end != to_pack.nr_objects)
-		die("ordered %u objects, expected %"PRIu32, wo_end, to_pack.nr_objects);
+		die(_("ordered %u objects, expected %"PRIu32),
+		    wo_end, to_pack.nr_objects);
 
 	return wo;
 }
@@ -760,15 +761,15 @@ static off_t write_reused_pack(struct hashfile *f)
 	int fd;
 
 	if (!is_pack_valid(reuse_packfile))
-		die("packfile is invalid: %s", reuse_packfile->pack_name);
+		die(_("packfile is invalid: %s"), reuse_packfile->pack_name);
 
 	fd = git_open(reuse_packfile->pack_name);
 	if (fd < 0)
-		die_errno("unable to open packfile for reuse: %s",
+		die_errno(_("unable to open packfile for reuse: %s"),
 			  reuse_packfile->pack_name);
 
 	if (lseek(fd, sizeof(struct pack_header), SEEK_SET) == -1)
-		die_errno("unable to seek in reused packfile");
+		die_errno(_("unable to seek in reused packfile"));
 
 	if (reuse_packfile_offset < 0)
 		reuse_packfile_offset = reuse_packfile->pack_size - the_hash_algo->rawsz;
@@ -779,7 +780,7 @@ static off_t write_reused_pack(struct hashfile *f)
 		int read_pack = xread(fd, buffer, sizeof(buffer));
 
 		if (read_pack <= 0)
-			die_errno("unable to read from reused packfile");
+			die_errno(_("unable to read from reused packfile"));
 
 		if (read_pack > to_write)
 			read_pack = to_write;
@@ -882,7 +883,7 @@ static void write_pack_file(void)
 			 * to preserve this property.
 			 */
 			if (stat(pack_tmp_name, &st) < 0) {
-				warning_errno("failed to stat %s", pack_tmp_name);
+				warning_errno(_("failed to stat %s"), pack_tmp_name);
 			} else if (!last_mtime) {
 				last_mtime = st.st_mtime;
 			} else {
@@ -890,7 +891,7 @@ static void write_pack_file(void)
 				utb.actime = st.st_atime;
 				utb.modtime = --last_mtime;
 				if (utime(pack_tmp_name, &utb) < 0)
-					warning_errno("failed utime() on %s", pack_tmp_name);
+					warning_errno(_("failed utime() on %s"), pack_tmp_name);
 			}
 
 			strbuf_addf(&tmpname, "%s-", base_name);
@@ -935,8 +936,8 @@ static void write_pack_file(void)
 	free(write_order);
 	stop_progress(&progress_state);
 	if (written != nr_result)
-		die("wrote %"PRIu32" objects while expecting %"PRIu32,
-			written, nr_result);
+		die(_("wrote %"PRIu32" objects while expecting %"PRIu32),
+		    written, nr_result);
 }
 
 static int no_try_delta(const char *path)
@@ -1480,7 +1481,7 @@ static void check_object(struct object_entry *entry)
 			while (c & 128) {
 				ofs += 1;
 				if (!ofs || MSB(ofs, 7)) {
-					error("delta base offset overflow in pack for %s",
+					error(_("delta base offset overflow in pack for %s"),
 					      oid_to_hex(&entry->idx.oid));
 					goto give_up;
 				}
@@ -1489,7 +1490,7 @@ static void check_object(struct object_entry *entry)
 			}
 			ofs = entry->in_pack_offset - ofs;
 			if (ofs <= 0 || ofs >= entry->in_pack_offset) {
-				error("delta base offset out of bound for %s",
+				error(_("delta base offset out of bound for %s"),
 				      oid_to_hex(&entry->idx.oid));
 				goto give_up;
 			}
@@ -1974,10 +1975,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		trg->data = read_object_file(&trg_entry->idx.oid, &type, &sz);
 		read_unlock();
 		if (!trg->data)
-			die("object %s cannot be read",
+			die(_("object %s cannot be read"),
 			    oid_to_hex(&trg_entry->idx.oid));
 		if (sz != trg_size)
-			die("object %s inconsistent object length (%lu vs %lu)",
+			die(_("object %s inconsistent object length (%lu vs %lu)"),
 			    oid_to_hex(&trg_entry->idx.oid), sz,
 			    trg_size);
 		*mem_usage += sz;
@@ -1990,7 +1991,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 			if (src_entry->preferred_base) {
 				static int warned = 0;
 				if (!warned++)
-					warning("object %s cannot be read",
+					warning(_("object %s cannot be read"),
 						oid_to_hex(&src_entry->idx.oid));
 				/*
 				 * Those objects are not included in the
@@ -2000,11 +2001,11 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 				 */
 				return 0;
 			}
-			die("object %s cannot be read",
+			die(_("object %s cannot be read"),
 			    oid_to_hex(&src_entry->idx.oid));
 		}
 		if (sz != src_size)
-			die("object %s inconsistent object length (%lu vs %lu)",
+			die(_("object %s inconsistent object length (%lu vs %lu)"),
 			    oid_to_hex(&src_entry->idx.oid), sz,
 			    src_size);
 		*mem_usage += sz;
@@ -2014,7 +2015,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		if (!src->index) {
 			static int warned = 0;
 			if (!warned++)
-				warning("suboptimal pack - out of memory");
+				warning(_("suboptimal pack - out of memory"));
 			return 0;
 		}
 		*mem_usage += sizeof_delta_index(src->index);
@@ -2341,8 +2342,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		return;
 	}
 	if (progress > pack_to_stdout)
-		fprintf_ln(stderr, "Delta compression using up to %d threads.",
-				delta_search_threads);
+		fprintf_ln(stderr, _("Delta compression using up to %d threads"),
+			   delta_search_threads);
 	p = xcalloc(delta_search_threads, sizeof(*p));
 
 	/* Partition the work amongst work threads. */
@@ -2382,7 +2383,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		ret = pthread_create(&p[i].thread, NULL,
 				     threaded_find_deltas, &p[i]);
 		if (ret)
-			die("unable to create thread: %s", strerror(ret));
+			die(_("unable to create thread: %s"), strerror(ret));
 		active_threads++;
 	}
 
@@ -2477,7 +2478,7 @@ static void add_tag_chain(const struct object_id *oid)
 	tag = lookup_tag(oid);
 	while (1) {
 		if (!tag || parse_tag(tag) || !tag->tagged)
-			die("unable to pack objects reachable from tag %s",
+			die(_("unable to pack objects reachable from tag %s"),
 			    oid_to_hex(oid));
 
 		add_object_entry(&tag->object.oid, OBJ_TAG, NULL, 0);
@@ -2543,7 +2544,7 @@ static void prepare_pack(int window, int depth)
 		if (!entry->preferred_base) {
 			nr_deltas++;
 			if (oe_type(entry) < 0)
-				die("unable to get type of object %s",
+				die(_("unable to get type of object %s"),
 				    oid_to_hex(&entry->idx.oid));
 		} else {
 			if (oe_type(entry) < 0) {
@@ -2567,7 +2568,7 @@ static void prepare_pack(int window, int depth)
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
 		stop_progress(&progress_state);
 		if (nr_done != nr_deltas)
-			die("inconsistency with delta count");
+			die(_("inconsistency with delta count"));
 	}
 	free(delta_list);
 }
@@ -2607,11 +2608,11 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
-			die("invalid number of threads specified (%d)",
+			die(_("invalid number of threads specified (%d)"),
 			    delta_search_threads);
 #ifdef NO_PTHREADS
 		if (delta_search_threads != 1) {
-			warning("no threads support, ignoring %s", k);
+			warning(_("no threads support, ignoring %s"), k);
 			delta_search_threads = 0;
 		}
 #endif
@@ -2620,7 +2621,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "pack.indexversion")) {
 		pack_idx_opts.version = git_config_int(k, v);
 		if (pack_idx_opts.version > 2)
-			die("bad pack.indexversion=%"PRIu32,
+			die(_("bad pack.indexversion=%"PRIu32),
 			    pack_idx_opts.version);
 		return 0;
 	}
@@ -2646,13 +2647,13 @@ static void read_object_list_from_stdin(void)
 		}
 		if (line[0] == '-') {
 			if (get_oid_hex(line+1, &oid))
-				die("expected edge object ID, got garbage:\n %s",
+				die(_("expected edge object ID, got garbage:\n %s"),
 				    line);
 			add_preferred_base(&oid);
 			continue;
 		}
 		if (parse_oid_hex(line, &oid, &p))
-			die("expected object ID, got garbage:\n %s", line);
+			die(_("expected object ID, got garbage:\n %s"), line);
 
 		add_preferred_base_object(p + 1);
 		add_object_entry(&oid, OBJ_NONE, p + 1, 0);
@@ -2791,7 +2792,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 		if (open_pack_index(p))
-			die("cannot open pack index");
+			die(_("cannot open pack index"));
 
 		ALLOC_GROW(in_pack.array,
 			   in_pack.nr + p->num_objects,
@@ -2822,7 +2823,7 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
 	if (type < 0) {
-		warning("loose object at %s could not be examined", path);
+		warning(_("loose object at %s could not be examined"), path);
 		return 0;
 	}
 
@@ -2899,7 +2900,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 			continue;
 
 		if (open_pack_index(p))
-			die("cannot open pack index");
+			die(_("cannot open pack index"));
 
 		for (i = 0; i < p->num_objects; i++) {
 			nth_packed_object_oid(&oid, p, i);
@@ -2907,7 +2908,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime))
 				if (force_object_loose(&oid, p->mtime))
-					die("unable to force loose object");
+					die(_("unable to force loose object"));
 		}
 	}
 }
@@ -2991,17 +2992,17 @@ static void get_object_list(int ac, const char **av)
 				use_bitmap_index = 0;
 				continue;
 			}
-			die("not a rev '%s'", line);
+			die(_("not a rev '%s'"), line);
 		}
 		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
-			die("bad revision '%s'", line);
+			die(_("bad revision '%s'"), line);
 	}
 
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
 		return;
 
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 	mark_edges_uninteresting(&revs, show_edge);
 
 	if (!fn_show_object)
@@ -3014,9 +3015,9 @@ static void get_object_list(int ac, const char **av)
 		revs.ignore_missing_links = 1;
 		if (add_unseen_recent_objects_to_traversal(&revs,
 				unpack_unreachable_expiration))
-			die("unable to add recent objects");
+			die(_("unable to add recent objects"));
 		if (prepare_revision_walk(&revs))
-			die("revision walk setup failed");
+			die(_("revision walk setup failed"));
 		traverse_commit_list(&revs, record_recent_commit,
 				     record_recent_object, NULL);
 	}
@@ -3251,35 +3252,35 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_compression_level == -1)
 		pack_compression_level = Z_DEFAULT_COMPRESSION;
 	else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
-		die("bad pack compression level %d", pack_compression_level);
+		die(_("bad pack compression level %d"), pack_compression_level);
 
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
 
 #ifdef NO_PTHREADS
 	if (delta_search_threads != 1)
-		warning("no threads support, ignoring --threads");
+		warning(_("no threads support, ignoring --threads"));
 #endif
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit = pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
-		die("--max-pack-size cannot be used to build a pack for transfer.");
+		die(_("--max-pack-size cannot be used to build a pack for transfer"));
 	if (pack_size_limit && pack_size_limit < 1024*1024) {
-		warning("minimum pack size limit is 1 MiB");
+		warning(_("minimum pack size limit is 1 MiB"));
 		pack_size_limit = 1024*1024;
 	}
 
 	if (!pack_to_stdout && thin)
-		die("--thin cannot be used to build an indexable pack.");
+		die(_("--thin cannot be used to build an indexable pack"));
 
 	if (keep_unreachable && unpack_unreachable)
-		die("--keep-unreachable and --unpack-unreachable are incompatible.");
+		die(_("--keep-unreachable and --unpack-unreachable are incompatible"));
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
 	if (filter_options.choice) {
 		if (!pack_to_stdout)
-			die("cannot use --filter without --stdout.");
+			die(_("cannot use --filter without --stdout"));
 		use_bitmap_index = 0;
 	}
 
@@ -3353,8 +3354,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		prepare_pack(window, depth);
 	write_pack_file();
 	if (progress)
-		fprintf_ln(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
-			   " reused %"PRIu32" (delta %"PRIu32")",
-			   written, written_delta, reused, reused_delta);
+		fprintf_ln(stderr,
+			   _("Total %"PRIu32" (delta %"PRIu32"),"
+			     " reused %"PRIu32" (delta %"PRIu32")"),
+			written, written_delta, reused, reused_delta);
 	return 0;
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index ea6570e819..d2d27f9b54 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -403,7 +403,7 @@ test_expect_success 'fetch creating new shallow root' '
 		git fetch --depth=1 --progress 2>actual &&
 		# This should fetch only the empty commit, no tree or
 		# blob objects
-		grep "remote: Total 1" actual
+		test_i18ngrep "remote: Total 1" actual
 	)
 '
 
-- 
2.18.0.rc2.476.g39500d3211

