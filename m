Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5501F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeCPT2L (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:28:11 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40784 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeCPT2H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:28:07 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so12922661lfb.7
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZ6RLJ3m+1epUWi+6Yu6SSMVXf8uU2CWQEw2hEBe1Dg=;
        b=Qlm2f2tNvr92Xv8+DiTi8qxZ3uP327zlTAoh42dhV1hmOrPaHvrT3I4PAvotoFAdUM
         9U3v+QcGhBk5FyEUs+Xm8vCwgHd+I46A1RKbMGFHiujH//H504QKmcxvCuRN8irYyVWP
         OhDYlypGQyUmlzllrsKQGwVFxoyeq4nPJ2ENY3PkdLRl7JP7ly53y0NkYXBQ18hjPpuc
         r74eiVpBdDX01J6ImnMo6feNeUfsi74YHINtf8i704dNdtso/hIDZwb5hkkTw4VAXm5n
         6ePTIUPg9PJ0D8eaDSBtoa5Pb6MPlqPXdb3J/59uUDGRRYqFZt07bVJ029Et4t9ek8fu
         fB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZ6RLJ3m+1epUWi+6Yu6SSMVXf8uU2CWQEw2hEBe1Dg=;
        b=o43UQzeRBUWtIqZDQcIHca0ykMuE+DwkpBHdDRGZPg2SENZR2bjlKhIDEHSwCZgcGI
         ASCKMnrJHP6Fww8c40nGGhEFT0eB7JlT3JzDazkVcwzMEGQyBnp3OXy70zuOyAbHo0EQ
         8AwoqvTk2JRJD8DhZhcDBHSthWEpEeRKcxzm10zi4ImmQ5O9Z98AZVnyLVr4M+rZ8Q3t
         mvgeFOG2ij4v1sAM4KcUhNGU9aFdo1PeffPZ7ESpfTpv9FC92q4LG5Dl1VYcRHnCGqt0
         MPjFm1HxVzieIheeWuIRONmEiGn7q5WMDmKcXnkubfWc5jeFUTBIEG0F4ix5dsRH7KKT
         2bNQ==
X-Gm-Message-State: AElRT7FLCR/ounAtmJEbOglvYwDRYRgdo1kD6qcILJ3Y2cHrf8wkEtpp
        VO05oqTMAFAcoXjY9cRLLV0=
X-Google-Smtp-Source: AG47ELvvXrwtlBbIdpV0/MajKNHmbjyiKjFAYL7pS26YyDJnnAi4Gs9q36xn4TfaGX0z9ZIVNtT65w==
X-Received: by 10.46.92.7 with SMTP id q7mr2140757ljb.21.1521228485108;
        Fri, 16 Mar 2018 12:28:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm1766085lja.41.2018.03.16.12.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 12:28:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 0/7] nd/repack-keep-pack updates
Date:   Fri, 16 Mar 2018 20:27:38 +0100
Message-Id: <20180316192745.19557-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180306104158.6541-1-pclouds@gmail.com>
References: <20180306104158.6541-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not in mergeable state yet. But since there's lots of changes
and I'm pretty sure there's still room for improvement when it comes
to configuration and stuff, I'm posting it anyway to get the
discussion continue.

- --keep-pack does not imply --honor-pack-keep or --pack-kept-objects
  anymore. If you want it, you pass those in. If not, only
  --keep-pack'd packs are kept.

- v2 03/05 feels too big to me so it's now broken down in a couple
  patches.

- freebsd support is added and tested (which probably means OS X
  support is good too). Windows code for getting memory size remains
  untested.

- platforms that do not have support for getting memory will not have
  this "keep base pack on gc --auto" turned on. This may be just safer
  than printing "unrecognized platform" which may not reach platform
  developers anyway.

- gc.bigBasePackThreshold is renamed to gc.bigPackThreshold and now
  keeps all packs larger than this limit.

- fix the off-by-one in "enumerating objects" code.

- while I tend to agree to make the "50% physical memory"
  configurable. I'm not sure if I should add a config var for that
  (which leads to more questions like, should we allow to say "30%
  _free_ memory" as well?) or I should just give the memory estimation
  to a user and he/she can decide what to do with it via hooks.

Interdiff

-- 8< --
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 120cf6bac9..ce40112e31 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1549,12 +1549,16 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
-gc.bigBasePackThreshold::
-	Make `git gc --auto` only enable `--keep-base-pack` when the
-	base pack's size is larger than this limit (in bytes).
-	Defaults to zero, which disables this check and lets
-	`git gc --auto` determine when to enable `--keep-base-pack`
-	based on memory usage.
+gc.bigPackThreshold::
+	If non-zero, all packs larger than this limit are kept when
+	`git gc` is run. This is very similar to `--keep-base-pack`
+	except that all packs that meet the threshold are kept, not
+	just the base pack. Defaults to zero.
++
+Note that if the number of kept packs is more than gc.autoPackLimit,
+this configuration variable is ignored, all packs except the base pack
+will be repacked. After this the number of packs should go below
+gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 35ad420d5c..19b0d1741b 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-base-pack]
 
 DESCRIPTION
 -----------
@@ -55,15 +55,16 @@ all loose objects are combined into a single pack using
 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autoPackLimit`,
-then existing packs (except those marked with a `.keep` file)
+then existing packs (except those marked with a `.keep` file
+or over `gc.bigPackThreshold` limit)
 are consolidated into a single pack by using the `-A` option of
-'git repack'. Setting `gc.autoPackLimit` to 0 disables
-automatic consolidation of packs.
-+
-If the physical amount of memory is considered not enough for `git
-repack` to run smoothly, `--keep-base-pack` is enabled. This could be
-overridden by setting `gc.bigBasePackThreshold` which only enables
-`--keep-base-pack` when the base pack is larger the specified limit.
+'git repack'.
+If the amount of memory is estimated not enough for `git repack` to
+run smoothly and `gc.bigPackThreshold` is not set, the largest
+pack will also be excluded (this is the equivalent of running `git gc`
+with `--keep-base-pack`).
+Setting `gc.autoPackLimit` to 0 disables automatic consolidation of
+packs.
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
@@ -84,8 +85,10 @@ overridden by setting `gc.bigBasePackThreshold` which only enables
 	instance running on this repository.
 
 --keep-base-pack::
-	All packs except the base pack are consolidated into a single
-	pack. The largest pack is considered the base pack.
+	All packs except the base pack and those marked with a `.keep`
+	files are consolidated into a single pack. The largest pack is
+	considered the base pack. When this option is used,
+	`gc.bigPackThreshold` is ignored.
 
 Configuration
 -------------
@@ -176,10 +179,6 @@ run commands concurrently have to live with some risk of corruption (which
 seems to be low in practice) unless they turn off automatic garbage
 collection with 'git config gc.auto 0'.
 
-Set environment variable `GIT_TRACE` in order to see the memory usage
-estimation in `git gc --auto` that determines whether the base pack is
-kept.
-
 HOOKS
 -----
 
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 1975477160..403524652a 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]]
+	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--stdout [--filter=<filter-spec>] | base-name]
 	[--shallow] [--keep-true-parents] < object-list
 
@@ -126,9 +126,12 @@ base-name::
 	has a .keep file to be ignored, even if it would have
 	otherwise been packed.
 
---keep-pack=<pack name>::
-	Ignore the given pack. This is the equivalent of having
-	`.keep` file on the pack. Implies `--honor-pack-keep`.
+--keep-pack=<pack-name>::
+	This flag causes an object already in the given pack to be
+	ignored, even if it would have otherwise been
+	packed. `<pack-name>` is the the pack file name without
+	leading directory (e.g. `pack-123.pack`). The option could be
+	specified multiple times to keep multiple packs.
 
 --incremental::
 	This flag causes an object already in a pack to be ignored
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 12b073e115..ce497d9d12 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>] [--threads=<n>]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 
 DESCRIPTION
 -----------
@@ -133,9 +133,12 @@ other objects in that pack they already have locally.
 	with `-b` or `repack.writeBitmaps`, as it ensures that the
 	bitmapped packfile has the necessary objects.
 
---keep-pack=<pack name>::
+--keep-pack=<pack-name>::
 	Exclude the given pack from repacking. This is the equivalent
-	of having `.keep` file on the pack. Implies `--pack-kept-objects`.
+	of having `.keep` file on the pack. `<pack-name>` is the the
+	pack file name without leading directory (e.g. `pack-123.pack`).
+	The option could be specified multiple times to keep multiple
+	packs.
 
 --unpack-unreachable=<when>::
 	When loosening unreachable objects, do not bother loosening any
diff --git a/builtin/gc.c b/builtin/gc.c
index ff914264a5..140c1bb7dd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -43,7 +43,7 @@ static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
-static unsigned long big_base_pack_threshold;
+static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
@@ -132,7 +132,7 @@ static void gc_config(void)
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
 
-	git_config_get_ulong("gc.bigbasepackthreshold", &big_base_pack_threshold);
+	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
 	git_config(git_default_config, NULL);
@@ -173,18 +173,27 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
-static struct packed_git *find_the_base_pack(void)
+static struct packed_git *find_base_packs(struct string_list *packs,
+					  unsigned long limit)
 {
 	struct packed_git *p, *base = NULL;
 
 	prepare_packed_git();
 
 	for (p = packed_git; p; p = p->next) {
-		if (p->pack_local &&
-		    (!base || base->pack_size < p->pack_size))
+		if (!p->pack_local)
+			continue;
+		if (limit) {
+			if (p->pack_size >= limit)
+				string_list_append(packs, p->pack_name);
+		} else if (!base || base->pack_size < p->pack_size) {
 			base = p;
+		}
 	}
 
+	if (base)
+		string_list_append(packs, base->pack_name);
+
 	return base;
 }
 
@@ -211,21 +220,24 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit < cnt;
 }
 
-static inline unsigned long total_ram(void)
+static uint64_t total_ram(void)
 {
-	unsigned long default_ram = 4;
-#ifdef HAVE_SYSINFO
+#if defined(HAVE_SYSINFO)
 	struct sysinfo si;
 
 	if (!sysinfo(&si))
 		return si.totalram;
-#elif defined(HAVE_BSD_SYSCTL) && defined(HW_MEMSIZE)
+#elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM))
 	int64_t physical_memory;
 	int mib[2];
 	size_t length;
 
 	mib[0] = CTL_HW;
+# if defined(HW_MEMSIZE)
 	mib[1] = HW_MEMSIZE;
+# else
+	mib[1] = HW_PHYSMEM;
+# endif
 	length = sizeof(int64_t);
 	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
 		return physical_memory;
@@ -235,24 +247,18 @@ static inline unsigned long total_ram(void)
 	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
 	if (GlobalMemoryStatusEx(&memInfo))
 		return memInfo.ullTotalPhys;
-#else
-	fprintf(stderr, _("unrecognized platform, assuming %lu GB RAM\n"),
-		default_ram);
 #endif
-	return default_ram * 1024 * 1024 * 1024;
+	return 0;
 }
 
-static int pack_objects_uses_too_much_memory(struct packed_git *pack)
+static uint64_t estimate_repack_memory(struct packed_git *pack)
 {
 	unsigned long nr_objects = approximate_object_count();
-	size_t mem_want, mem_have, os_cache, heap;
+	size_t os_cache, heap;
 
 	if (!pack || !nr_objects)
 		return 0;
 
-	if (big_base_pack_threshold)
-		return pack->pack_size >= big_base_pack_threshold;
-
 	/*
 	 * First we have to scan through at least one pack.
 	 * Assume enough room in OS file cache to keep the entire pack
@@ -284,28 +290,16 @@ static int pack_objects_uses_too_much_memory(struct packed_git *pack)
 	/* and of course pack-objects has its own delta cache */
 	heap += max_delta_cache_size;
 
-	/*
-	 * Only allow 1/2 of memory for pack-objects, leave the rest
-	 * for the OS and other processes in the system.
-	 */
-	mem_have = total_ram() / 2;
-	mem_want = os_cache + heap;
-
-	trace_printf("gc mem estimation\n"
-		     "mem_have: %" PRIuMAX ", mem_want: %" PRIuMAX ", "
-		     "heap: %" PRIuMAX "\n"
-		     "pack_size: %" PRIuMAX ", index_size: %" PRIuMAX ", "
-		     "nr_objects: %" PRIuMAX "\n"
-		     "base_cache: %" PRIuMAX ", delta_cache: %" PRIuMAX "\n",
-		     (uintmax_t)mem_have, (uintmax_t)mem_want, (uintmax_t)heap,
-		     (uintmax_t)pack->pack_size, (uintmax_t)pack->index_size,
-		     (uintmax_t)nr_objects,
-		     (uintmax_t)delta_base_cache_limit, (uintmax_t)max_delta_cache_size);
-
-	return mem_want >= mem_have;
+	return os_cache + heap;
 }
 
-static void add_repack_all_option(struct packed_git *keep_pack)
+static int keep_one_pack(struct string_list_item *item, void *data)
+{
+	argv_array_pushf(&repack, "--keep-pack=%s", basename(item->string));
+	return 0;
+}
+
+static void add_repack_all_option(struct string_list *keep_pack)
 {
 	if (prune_expire && !strcmp(prune_expire, "now"))
 		argv_array_push(&repack, "-a");
@@ -316,8 +310,7 @@ static void add_repack_all_option(struct packed_git *keep_pack)
 	}
 
 	if (keep_pack)
-		argv_array_pushf(&repack, "--keep-pack=%s",
-				 basename(keep_pack->pack_name));
+		for_each_string_list(keep_pack, keep_one_pack, NULL);
 }
 
 static void add_repack_incremental_option(void)
@@ -341,12 +334,33 @@ static int need_to_gc(void)
 	 * there is no need.
 	 */
 	if (too_many_packs()) {
-		struct packed_git *exclude = find_the_base_pack();
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+		if (big_pack_threshold) {
+			find_base_packs(&keep_pack, big_pack_threshold);
+			if (keep_pack.nr >= gc_auto_pack_limit) {
+				big_pack_threshold = 0;
+				string_list_clear(&keep_pack, 0);
+				find_base_packs(&keep_pack, 0);
+			}
+		} else {
+			struct packed_git * p = find_base_packs(&keep_pack, 0);
+			uint64_t mem_have, mem_want;
+
+			mem_have = total_ram();
+			mem_want = estimate_repack_memory(p);
 
-		if (!pack_objects_uses_too_much_memory(exclude))
-			exclude = NULL;
+			/*
+			 * Only allow 1/2 of memory for pack-objects, leave
+			 * the rest for the OS and other processes in the
+			 * system.
+			 */
+			if (!mem_have || mem_want < mem_have / 2)
+				string_list_clear(&keep_pack, 0);
+		}
 
-		add_repack_all_option(exclude);
+		add_repack_all_option(&keep_pack);
+		string_list_clear(&keep_pack, 0);
 	} else if (too_many_loose_objects())
 		add_repack_incremental_option();
 	else
@@ -558,17 +572,17 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			daemonized = !daemonize();
 		}
 	} else {
-		struct packed_git *base_pack = find_the_base_pack();
-		struct packed_git *exclude = NULL;
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
 		if (keep_base_pack != -1) {
 			if (keep_base_pack)
-				exclude = base_pack;
-		} else if (base_pack && big_base_pack_threshold &&
-			   base_pack->pack_size >= big_base_pack_threshold)
-			exclude = base_pack;
+				find_base_packs(&keep_pack, 0);
+		} else if (big_pack_threshold) {
+			find_base_packs(&keep_pack, big_pack_threshold);
+		}
 
-		add_repack_all_option(exclude);
+		add_repack_all_option(&keep_pack);
+		string_list_clear(&keep_pack, 0);
 	}
 
 	name = lock_repo_for_gc(force, &pid);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2ec911bf10..ac8f29dd52 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -54,7 +54,7 @@ static int pack_loose_unreachable;
 static int local;
 static int have_non_local_packs;
 static int incremental;
-static int ignore_packed_keep;
+static int ignore_packed_keep, ignore_packed_keep_in_core;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
@@ -983,13 +983,15 @@ static int want_found_object(int exclude, struct packed_git *p)
 	 * Otherwise, we signal "-1" at the end to tell the caller that we do
 	 * not know either way, and it needs to check more packs.
 	 */
-	if (!ignore_packed_keep &&
+	if (!ignore_packed_keep && !ignore_packed_keep_in_core &&
 	    (!local || !have_non_local_packs))
 		return 1;
 
 	if (local && !p->pack_local)
 		return 0;
-	if (ignore_packed_keep && p->pack_local && p->pack_keep)
+	if (p->pack_local &&
+	    ((ignore_packed_keep && p->pack_keep) ||
+	     (ignore_packed_keep_in_core && p->pack_keep_in_core)))
 		return 0;
 
 	/* we don't know yet; keep looking for more packs */
@@ -1092,7 +1094,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
-	display_progress(progress_state, nr_seen++);
+	display_progress(progress_state, ++nr_seen);
 
 	if (have_duplicate_entry(oid, exclude, &index_pos))
 		return 0;
@@ -1119,7 +1121,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 {
 	uint32_t index_pos;
 
-	display_progress(progress_state, nr_seen++);
+	display_progress(progress_state, ++nr_seen);
 
 	if (have_duplicate_entry(oid, 0, &index_pos))
 		return 0;
@@ -2684,7 +2686,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		struct object_id oid;
 		struct object *o;
 
-		if (!p->pack_local || p->pack_keep)
+		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 		if (open_pack_index(p))
 			die("cannot open pack index");
@@ -2746,7 +2748,8 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 	p = (last_found != (void *)1) ? last_found : packed_git;
 
 	while (p) {
-		if ((!p->pack_local || p->pack_keep) &&
+		if ((!p->pack_local || p->pack_keep ||
+				p->pack_keep_in_core) &&
 			find_pack_entry_one(oid->hash, p)) {
 			last_found = p;
 			return 1;
@@ -2789,7 +2792,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	struct object_id oid;
 
 	for (p = packed_git; p; p = p->next) {
-		if (!p->pack_local || p->pack_keep)
+		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
 		if (open_pack_index(p))
@@ -2816,6 +2819,7 @@ static int pack_options_allow_reuse(void)
 	return pack_to_stdout &&
 	       allow_ofs_delta &&
 	       !ignore_packed_keep &&
+	       !ignore_packed_keep_in_core &&
 	       (!local || !have_non_local_packs) &&
 	       !incremental;
 }
@@ -2939,13 +2943,14 @@ static void add_extra_kept_packs(const struct string_list *names)
 		if (!p->pack_local)
 			continue;
 
-		for (i = 0; i < names->nr; i++) {
-			if (fspathcmp(name, names->items[i].string))
-				continue;
+		for (i = 0; i < names->nr; i++)
+			if (!fspathcmp(name, names->items[i].string))
+				break;
 
-			p->pack_keep = 1;
-			ignore_packed_keep = 1;
-			break;
+		if (i < names->nr) {
+			p->pack_keep_in_core = 1;
+			ignore_packed_keep_in_core = 1;
+			continue;
 		}
 	}
 }
diff --git a/builtin/repack.c b/builtin/repack.c
index 6a1dade0e1..6c636e159e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -100,7 +100,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 		size_t len;
 		int i;
 
-		for (i = 0;i < extra_keep->nr; i++)
+		for (i = 0; i < extra_keep->nr; i++)
 			if (!fspathcmp(e->d_name, extra_keep->items[i].string))
 				break;
 		if (extra_keep->nr > 0 && i < extra_keep->nr)
@@ -227,8 +227,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
-	if (keep_pack_list.nr && pack_kept_objects > 0)
-		die(_("incompatible --keep-pack and --pack-kept-objects"));
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
diff --git a/cache.h b/cache.h
index 21fbcc2414..42d700f3d8 100644
--- a/cache.h
+++ b/cache.h
@@ -1635,6 +1635,7 @@ extern struct packed_git {
 	int pack_fd;
 	unsigned pack_local:1,
 		 pack_keep:1,
+		 pack_keep_in_core:1,
 		 freshened:1,
 		 do_not_close:1,
 		 pack_promisor:1;
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 863fdbb0fd..96ca70f9cc 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -7,9 +7,9 @@ test_description='basic git gc tests
 
 test_expect_success 'setup' '
 	# do not let the amount of physical memory affects gc
-	# behavior, make sure the pack_objects_uses_too_much_memory()
-	# always returns false
-	git config gc.bigBasePackThreshold 2g
+	# behavior, make sure we always pack everything to one pack by
+	# default
+	git config gc.bigPackThreshold 2g
 '
 
 test_expect_success 'gc empty repository' '
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 553d907d34..05ae0de3aa 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -200,16 +200,22 @@ test_expect_success 'repack --keep-pack' '
 	test_create_repo keep-pack &&
 	(
 		cd keep-pack &&
-		for cmit in one two three four; do
-			test_commit $cmit &&
-			git repack -d
-		done &&
+		test_commit one &&
+		git repack -d &&
+		test_commit two &&
+		git repack -d &&
+		test_commit three &&
+		git repack -d &&
+		test_commit four &&
+		git repack -d &&
 		( cd .git/objects/pack && ls *.pack ) >pack-list &&
 		test_line_count = 4 pack-list &&
-		KEEP1=`head -n1 pack-list` &&
-		KEEP4=`tail -n1 pack-list` &&
+		KEEP1=$(head -n1 pack-list) &&
+		KEEP4=$(tail -n1 pack-list) &&
 		git repack -a -d --keep-pack $KEEP1 --keep-pack $KEEP4 &&
 		ls .git/objects/pack/*.pack >new-counts &&
+		grep -q $KEEP1 new-counts &&
+		grep -q $KEEP4 new-counts &&
 		test_line_count = 3 new-counts &&
 		git fsck
 	)
-- 8< --

Nguyễn Thái Ngọc Duy (7):
  repack: add --keep-pack option
  gc: add --keep-base-pack
  gc: detect base packs based on gc.bigPackThreshold config
  gc --auto: exclude base pack if not enough mem to "repack -ad"
  gc: handle a corner case in gc.bigPackThreshold
  pack-objects: show some progress when counting kept objects
  pack-objects: display progress in get_object_details()

 Documentation/config.txt           |  11 ++
 Documentation/git-gc.txt           |  20 +++-
 Documentation/git-pack-objects.txt |   9 +-
 Documentation/git-repack.txt       |   9 +-
 builtin/gc.c                       | 167 +++++++++++++++++++++++++++--
 builtin/pack-objects.c             |  68 +++++++++---
 builtin/repack.c                   |  21 +++-
 cache.h                            |   1 +
 config.mak.uname                   |   1 +
 git-compat-util.h                  |   4 +
 pack-objects.h                     |   2 +
 t/t6500-gc.sh                      |  29 +++++
 t/t7700-repack.sh                  |  25 +++++
 13 files changed, 339 insertions(+), 28 deletions(-)

-- 
2.16.2.903.gd04caf5039

