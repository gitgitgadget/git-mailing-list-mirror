Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFFC1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeCFKmg (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:42:36 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32893 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKmf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:42:35 -0500
Received: by mail-pg0-f66.google.com with SMTP id g12so8114624pgs.0
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBqy3wkh/9JgU23kAk0Dn+14Vr/C0JRK7BE4dSizwF0=;
        b=K8yo0gM8h/MjL4pS93sDzJ8IfKDS45f5tuidC3M3xi2ACjT3ZQ+c2dO9gzI5gpN5V7
         x16Bydp3yzx+TPNNtalgz3PjkdtkrZN00MZZmZMmLZAkAAAhESwphMsoFOWTTocWbL9r
         PWvER24WiNkDPrT3fEqv0zxU8PObVs9i8dbYOnjW1cVOYPD3KgU9IJQGFmJaF1q4cekH
         0YhPitnvdDukYXIMSrTOXduCni1IattxpSBRvoGDI7AaXk0FJuQMVAJ/nXr78XseRxB3
         fK+nb/WaHa2F6wnorEW3Gmo8adaYP4thJmWaK/MRxb1Ta+oqF5Iu+ZO1wxAGk7mVMc6r
         +K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBqy3wkh/9JgU23kAk0Dn+14Vr/C0JRK7BE4dSizwF0=;
        b=ksbbc43ICdODuzp0pC5MDrQYdwhxurJwsvAsPGaYkf8fvA+K3CMk/zBdFRXzLmHNDW
         JRwWmH9OZqMp345iva7U0VAk7UuCkORdazE1YrFeNzLNkQhf2KojNFHCxsnBWuBZiGLp
         vtnUVntHD6A/eAHSEazd2PjXUi0+Gc7kMvUjDSdTGkREGUECdcCZig+S5mEyLylV7XD+
         TmFCRmHTnmjQQGJMZWb7EN/ARV6QyvxU/kQLzs2pWUiaqw9a0kdEQUJCHdFOzCjoMwU2
         Vs4RZr9meHd/+AP51hpvA2Z4P3L5fxVscANxKQQ88Zfhyy3JJguNTPIalgIE8g3OWmnQ
         K8cw==
X-Gm-Message-State: APf1xPDEi1B+jcccr+aQ+pzQaF0/YeXh+Hsizd3pgGQvn/nJgGCMUYY4
        xu3FcKAI9r3ATDY0aBwa6fE=
X-Google-Smtp-Source: AG47ELtK0wEYm6SGLn2DyupL2BpM93iOawWM53qVnzjdW7wRPMlV+fCzUr0zd9JJMIZP2e522auoeQ==
X-Received: by 10.98.21.200 with SMTP id 191mr18336511pfv.166.1520332954241;
        Tue, 06 Mar 2018 02:42:34 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id c62sm30545032pfk.127.2018.03.06.02.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:42:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Mar 2018 17:42:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to "repack -ad"
Date:   Tue,  6 Mar 2018 17:41:56 +0700
Message-Id: <20180306104158.6541-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.784.gb291bd247e
In-Reply-To: <20180306104158.6541-1-pclouds@gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com>
 <20180306104158.6541-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pack-objects could be a big memory hog especially on large repos,
everybody knows that. The suggestion to stick a .keep file on the
giant base pack to avoid this problem is also known for a long time.

Let's do the suggestion automatically instead of waiting for people to
come to Git mailing list and get the advice. When a certain condition
is met, "gc --auto" tells "git repack" to keep the base pack around.
The end result would be two packs instead of one.

On linux-2.6.git, valgrind massif reports 1.6GB heap in "pack all"
case, and 535MB [1] in "pack all except the base pack" case. We save
roughly 1GB memory by excluding the base pack.

gc --auto decides to do this based on an estimation of pack-objects
memory usage, which is quite accurate at least for the heap part, and
whether that fits in half of system memory (the assumption here is for
desktop environment where there are many other applications running).

Since the estimation may be inaccurate and that 1/2 threshold is
really arbitrary, give the user a finer control over this mechanism:
if the largest pack is larger than gc.bigBasePackThreshold, it's kept.

PS. A big chunk of the remaining 535MB is the result of pack-objects
running rev-list internally. This will be dealt with when we could run
rev-list externally. Right now we can't because pack-objects internal
rev-list does more regarding unreachable objects, which cannot be done
by "git rev-list".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |   7 ++
 Documentation/git-gc.txt |  13 ++++
 builtin/gc.c             | 153 +++++++++++++++++++++++++++++++++++++--
 builtin/pack-objects.c   |   2 +-
 config.mak.uname         |   1 +
 git-compat-util.h        |   4 +
 pack-objects.h           |   2 +
 t/t6500-gc.sh            |  29 ++++++++
 8 files changed, 204 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10c..120cf6bac9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1549,6 +1549,13 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.bigBasePackThreshold::
+	Make `git gc --auto` only enable `--keep-base-pack` when the
+	base pack's size is larger than this limit (in bytes).
+	Defaults to zero, which disables this check and lets
+	`git gc --auto` determine when to enable `--keep-base-pack`
+	based on memory usage.
+
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
 	unless that file is more than 'gc.logExpiry' old.  Default is
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 571b5a7e3c..35ad420d5c 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -59,6 +59,11 @@ then existing packs (except those marked with a `.keep` file)
 are consolidated into a single pack by using the `-A` option of
 'git repack'. Setting `gc.autoPackLimit` to 0 disables
 automatic consolidation of packs.
++
+If the physical amount of memory is considered not enough for `git
+repack` to run smoothly, `--keep-base-pack` is enabled. This could be
+overridden by setting `gc.bigBasePackThreshold` which only enables
+`--keep-base-pack` when the base pack is larger the specified limit.
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
@@ -78,6 +83,10 @@ automatic consolidation of packs.
 	Force `git gc` to run even if there may be another `git gc`
 	instance running on this repository.
 
+--keep-base-pack::
+	All packs except the base pack are consolidated into a single
+	pack. The largest pack is considered the base pack.
+
 Configuration
 -------------
 
@@ -167,6 +176,10 @@ run commands concurrently have to live with some risk of corruption (which
 seems to be low in practice) unless they turn off automatic garbage
 collection with 'git config gc.auto 0'.
 
+Set environment variable `GIT_TRACE` in order to see the memory usage
+estimation in `git gc --auto` that determines whether the base pack is
+kept.
+
 HOOKS
 -----
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 77fa720bd0..273657ddf4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,10 @@
 #include "argv-array.h"
 #include "commit.h"
 #include "packfile.h"
+#include "pack.h"
+#include "pack-objects.h"
+#include "blob.h"
+#include "tree.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -39,6 +43,8 @@ static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
+static unsigned long big_base_pack_threshold;
+static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
 static struct argv_array reflog = ARGV_ARRAY_INIT;
@@ -126,6 +132,9 @@ static void gc_config(void)
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
 
+	git_config_get_ulong("gc.bigbasepackthreshold", &big_base_pack_threshold);
+	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -164,6 +173,21 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
+static struct packed_git *find_the_base_pack(void)
+{
+	struct packed_git *p, *base = NULL;
+
+	prepare_packed_git();
+
+	for (p = packed_git; p; p = p->next) {
+		if (p->pack_local &&
+		    (!base || base->pack_size < p->pack_size))
+			base = p;
+	}
+
+	return base;
+}
+
 static int too_many_packs(void)
 {
 	struct packed_git *p;
@@ -187,7 +211,101 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit < cnt;
 }
 
-static void add_repack_all_option(void)
+static inline unsigned long total_ram(void)
+{
+	unsigned long default_ram = 4;
+#ifdef HAVE_SYSINFO
+	struct sysinfo si;
+
+	if (!sysinfo(&si))
+		return si.totalram;
+#elif defined(HAVE_BSD_SYSCTL) && defined(HW_MEMSIZE)
+	int64_t physical_memory;
+	int mib[2];
+	size_t length;
+
+	mib[0] = CTL_HW;
+	mib[1] = HW_MEMSIZE;
+	length = sizeof(int64_t);
+	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
+		return physical_memory;
+#elif defined(GIT_WINDOWS_NATIVE)
+	MEMORYSTATUSEX memInfo;
+
+	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
+	if (GlobalMemoryStatusEx(&memInfo))
+		return memInfo;ullTotalPhys;
+#else
+	fprintf(stderr, _("unrecognized platform, assuming %lu GB RAM\n"),
+		default_ram);
+#endif
+	return default_ram * 1024 * 1024 * 1024;
+}
+
+static int pack_objects_uses_too_much_memory(struct packed_git *pack)
+{
+	unsigned long nr_objects = approximate_object_count();
+	size_t mem_want, mem_have, os_cache, heap;
+
+	if (!pack || !nr_objects)
+		return 0;
+
+	if (big_base_pack_threshold)
+		return pack->pack_size >= big_base_pack_threshold;
+
+	/*
+	 * First we have to scan through at least one pack.
+	 * Assume enough room in OS file cache to keep the entire pack
+	 * or we may accidentally evict data of other processes from
+	 * the cache.
+	 */
+	os_cache = pack->pack_size + pack->index_size;
+	/* then pack-objects needs lots more for book keeping */
+	heap = sizeof(struct object_entry) * nr_objects;
+	/*
+	 * internal rev-list --all --objects takes up some memory too,
+	 * let's say half of it is for blobs
+	 */
+	heap += sizeof(struct blob) * nr_objects / 2;
+	/*
+	 * and the other half is for trees (commits and tags are
+	 * usually insignificant)
+	 */
+	heap += sizeof(struct tree) * nr_objects / 2;
+	/* and then obj_hash[], underestimated in fact */
+	heap += sizeof(struct object *) * nr_objects;
+	/* revindex is used also */
+	heap += sizeof(struct revindex_entry) * nr_objects;
+	/*
+	 * read_sha1_file() (either at delta calculation phase, or
+	 * writing phase) also fills up the delta base cache
+	 */
+	heap += delta_base_cache_limit;
+	/* and of course pack-objects has its own delta cache */
+	heap += max_delta_cache_size;
+
+	/*
+	 * Only allow 1/2 of memory for pack-objects, leave the rest
+	 * for the OS and other processes in the system.
+	 */
+	mem_have = total_ram() / 2;
+	mem_want = os_cache + heap;
+
+	trace_printf("gc mem estimation\n"
+		     "mem_have: %" PRIuMAX ", mem_want: %" PRIuMAX ", "
+		     "heap: %" PRIuMAX "\n"
+		     "pack_size: %" PRIuMAX ", index_size: %" PRIuMAX ", "
+		     "nr_objects: %" PRIuMAX "\n"
+		     "base_cache: %" PRIuMAX ", delta_cache: %" PRIuMAX "\n",
+		     (uintmax_t)mem_have, (uintmax_t)mem_want, (uintmax_t)heap,
+		     (uintmax_t)pack->pack_size, (uintmax_t)pack->index_size,
+		     (uintmax_t)nr_objects,
+		     (uintmax_t)delta_base_cache_limit, (uintmax_t)max_delta_cache_size);
+
+	return mem_want >= mem_have;
+}
+
+static void add_repack_all_option(struct packed_git *keep_pack)
 {
 	if (prune_expire && !strcmp(prune_expire, "now"))
 		argv_array_push(&repack, "-a");
@@ -196,6 +314,10 @@ static void add_repack_all_option(void)
 		if (prune_expire)
 			argv_array_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
 	}
+
+	if (keep_pack)
+		argv_array_pushf(&repack, "--keep-pack=%s",
+				 basename(keep_pack->pack_name));
 }
 
 static void add_repack_incremental_option(void)
@@ -218,9 +340,14 @@ static int need_to_gc(void)
 	 * we run "repack -A -d -l".  Otherwise we tell the caller
 	 * there is no need.
 	 */
-	if (too_many_packs())
-		add_repack_all_option();
-	else if (too_many_loose_objects())
+	if (too_many_packs()) {
+		struct packed_git *exclude = find_the_base_pack();
+
+		if (!pack_objects_uses_too_much_memory(exclude))
+			exclude = NULL;
+
+		add_repack_all_option(exclude);
+	} else if (too_many_loose_objects())
 		add_repack_incremental_option();
 	else
 		return 0;
@@ -353,6 +480,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	const char *name;
 	pid_t pid;
 	int daemonized = 0;
+	int keep_base_pack = -1;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -362,6 +490,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
 		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
+		OPT_BOOL(0, "keep-base-pack", &keep_base_pack,
+			 N_("repack all other packs except the base pack")),
 		OPT_END()
 	};
 
@@ -427,8 +557,19 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			 */
 			daemonized = !daemonize();
 		}
-	} else
-		add_repack_all_option();
+	} else {
+		struct packed_git *base_pack = find_the_base_pack();
+		struct packed_git *exclude = NULL;
+
+		if (keep_base_pack != -1) {
+			if (keep_base_pack)
+				exclude = base_pack;
+		} else if (base_pack && big_base_pack_threshold &&
+			   base_pack->pack_size >= big_base_pack_threshold)
+			exclude = base_pack;
+
+		add_repack_all_option(exclude);
+	}
 
 	name = lock_repo_for_gc(force, &pid);
 	if (name) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8e3f870d71..fcdd398eb7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -79,7 +79,7 @@ static uint16_t write_bitmap_options;
 static int exclude_promisor_objects;
 
 static unsigned long delta_cache_size = 0;
-static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
+static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
diff --git a/config.mak.uname b/config.mak.uname
index 6a1d0de0cc..ae9cbccec1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	BASIC_CFLAGS += -DHAVE_SYSINFO
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531e..a84b21986d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -284,6 +284,10 @@ extern char *gitdirname(char *);
 #include <openssl/err.h>
 #endif
 
+#ifdef HAVE_SYSINFO
+# include <sys/sysinfo.h>
+#endif
+
 /* On most systems <netdb.h> would have given us this, but
  * not on some systems (e.g. z/OS).
  */
diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..af4f46c026 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,8 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+#define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 41b0be575d..863fdbb0fd 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -5,6 +5,13 @@ test_description='basic git gc tests
 
 . ./test-lib.sh
 
+test_expect_success 'setup' '
+	# do not let the amount of physical memory affects gc
+	# behavior, make sure the pack_objects_uses_too_much_memory()
+	# always returns false
+	git config gc.bigBasePackThreshold 2g
+'
+
 test_expect_success 'gc empty repository' '
 	git gc
 '
@@ -116,6 +123,28 @@ test_expect_success 'background auto gc respects lock for all operations' '
 	test_path_is_file .git/refs/heads/should-be-loose
 '
 
+test_expect_success 'gc --keep-base-pack' '
+	test_create_repo keep-pack &&
+	(
+		cd keep-pack &&
+		for i in 10; do
+			test_commit $i
+		done &&
+		git gc &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 1 pack-list &&
+		BASE_PACK=.git/objects/pack/pack-*.pack &&
+		for i in 10; do
+			test_commit more-$i
+		done &&
+		git gc --keep-base-pack &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 2 pack-list &&
+		test_path_is_file $BASE_PACK &&
+		git fsck
+	)
+'
+
 # DO NOT leave a detached auto gc process running near the end of the
 # test script: it can run long enough in the background to racily
 # interfere with the cleanup in 'test_done'.
-- 
2.16.2.784.gb291bd247e

