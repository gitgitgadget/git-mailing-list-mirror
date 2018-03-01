Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CF71F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966844AbeCAJVU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:21:20 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34198 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966683AbeCAJVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:21:10 -0500
Received: by mail-pf0-f194.google.com with SMTP id j20so2199089pfi.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5uWYGSASnNfJ+aQGGc4LPBH5EzrpztOmmP33pp+go4=;
        b=rIWoxw2PIH2z85PFqlfyRcI2Db1Dq1wwyuHM2Uc90BzJN/KX2MNuz8CE355GSxDaab
         ixKXS6nLstzY8QYEb9VeQNdOreGma2XtTPrKuLXoh+23u5HHgz15bALO3Jhq0hfr6+sG
         absdgDpSIrPIkABkWcIGpZuRszsnuotjQiUy4TWH02oY+GLf2aC0gksEccBmqK9XcFfd
         y1EfIpV5ph6t3eIPnrVx1Hhw5bW22xgQK4Dzx2DaVyRO+a8jqxvcUe7cikzKsSRBZKbg
         oRTIo20ogTZkQWtHvXDiMvr8Cawe2K8fB5EpdLHzj1J02ou5fTnNqTyi0qpovwD5XQUO
         8jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5uWYGSASnNfJ+aQGGc4LPBH5EzrpztOmmP33pp+go4=;
        b=TkDi/f/j7+lwLvmjGEQ00McLbuB0fmdLSppvyZ82M+IUj6SSWRMqQ0Zo5k2m0s0qL8
         94ScTdiyJC5KC0zI6btfmoPM/GMdYN+NE7RoOYjEsX8RwCIXmVQEssuNdLJwle2GE5ho
         3VE/CxerPnbmBHgDmIR63QXeVw08SeUe8DV41oRPnhjOBXQxJaQLfX+0dKPoLE+q0f/n
         vxXLhA/VJHFMAHfstbavxUNcYxWzg0vBIcTAT3ZYurYoPeG8Oyo5WJX0BmQJ+lZRfXdw
         2/UdekFwsXMBJgA7dTGuKpWO7TTS64yZ1ATRROp7WqY5NYRB0ZWh/prqR/QZJ90vzGGK
         FJgQ==
X-Gm-Message-State: APf1xPCH7oiMGlkY13Rss5jW8jO8YRA6I9HRC+GZNopH1mL/x/A+d+ft
        Cp9mmidlGKHNXXgbMuNOxOTcOA==
X-Google-Smtp-Source: AG47ELtwdYJGF9G6OfaucDhAe2eHaz5OXN4enP2y/N+h6497KIG6qnSdzQuxfIsI4zpgzVxgpNVBHQ==
X-Received: by 10.99.186.73 with SMTP id l9mr976293pgu.83.1519896069811;
        Thu, 01 Mar 2018 01:21:09 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id a3sm6212117pgw.10.2018.03.01.01.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:21:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:21:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 1/1] gc --auto: exclude the largest giant pack in low-memory config
Date:   Thu,  1 Mar 2018 16:20:46 +0700
Message-Id: <20180301092046.2769-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301092046.2769-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301092046.2769-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pack-objects could be a big memory hog especially on large repos,
everybody knows that. The suggestion to stick a .keep file on the
largest pack to avoid this problem is also known for a long time.

Let's do the suggestion automatically instead of waiting for people to
come to Git mailing list and get the advice. When a certain condition
is met, gc --auto create a .keep file temporary before repack is run,
then remove it afterward.

gc --auto does this based on an estimation of pack-objects memory
usage and whether that fits in one third of system memory (the
assumption here is for desktop environment where there are many other
applications running).

Since the estimation may be inaccurate and that 1/3 threshold is
arbitrary, give the user a finer control over this mechanism as well:
if the largest pack is larger than gc.bigPackThreshold, it's kept.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/gc.c           | 125 +++++++++++++++++++++++++++++++++++++++--
 builtin/pack-objects.c |   2 +-
 config.mak.uname       |   1 +
 git-compat-util.h      |   4 ++
 pack-objects.h         |   2 +
 5 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 77fa720bd0..2d9965bcdf 100644
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
+static unsigned long big_pack_threshold = 0;
+static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
 static struct argv_array reflog = ARGV_ARRAY_INIT;
@@ -49,6 +55,7 @@ static struct argv_array rerere = ARGV_ARRAY_INIT;
 
 static struct tempfile *pidfile;
 static struct lock_file log_lock;
+static struct strbuf temp_keep_file = STRBUF_INIT;
 
 static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
 
@@ -93,6 +100,18 @@ static void process_log_file(void)
 	}
 }
 
+static void delete_temp_keep_file(void)
+{
+	unlink(temp_keep_file.buf);
+}
+
+static void delete_temp_keep_file_on_signal(int signo)
+{
+	delete_temp_keep_file();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static void process_log_file_at_exit(void)
 {
 	fflush(stderr);
@@ -126,6 +145,9 @@ static void gc_config(void)
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
 
+	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
+	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -164,7 +186,7 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
-static int too_many_packs(void)
+static int too_many_packs(struct packed_git **largest_pack)
 {
 	struct packed_git *p;
 	int cnt;
@@ -173,22 +195,104 @@ static int too_many_packs(void)
 		return 0;
 
 	prepare_packed_git();
+	*largest_pack = NULL;
 	for (cnt = 0, p = packed_git; p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
 			continue;
+		if (!*largest_pack || (*largest_pack)->pack_size  < p->pack_size)
+			*largest_pack = p;
 		/*
 		 * Perhaps check the size of the pack and count only
 		 * very small ones here?
 		 */
 		cnt++;
 	}
+
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
+	int length;
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
+	size_t mem_want, mem_have;
+
+	if (!pack || !nr_objects)
+		return 0;
+
+	if (big_pack_threshold)
+		return pack->pack_size >= big_pack_threshold;
+
+	/* First we have to scan through at least one pack */
+	mem_want = pack->pack_size + pack->index_size;
+	/* then pack-objects needs lots more for book keeping */
+	mem_want += sizeof(struct object_entry) * nr_objects;
+	/*
+	 * internal rev-list --all --objects takes up some memory too,
+	 * let's say half of it is for blobs
+	 */
+	mem_want += sizeof(struct blob) * nr_objects / 2;
+	/*
+	 * and the other half is for trees (commits and tags are
+	 * usually insignificant)
+	 */
+	mem_want += sizeof(struct tree) * nr_objects / 2;
+	/* and then obj_hash[], underestimated in fact */
+	mem_want += sizeof(struct object *) * nr_objects;
+	/*
+	 * read_sha1_file() (either at delta calculation phase, or
+	 * writing phase) also fills up the delta base cache
+	 */
+	mem_want += delta_base_cache_limit;
+	/* and of course pack-objects has its own delta cache */
+	mem_want += max_delta_cache_size;
+
+	/* Only allow 1/3 of memory for pack-objects */
+	mem_have = total_ram() / 3;
+
+	return mem_want >= mem_have;
+
+}
+
+static void add_repack_all_option(struct packed_git *exclude_pack)
 {
+	if (pack_objects_uses_too_much_memory(exclude_pack)) {
+		strbuf_addstr(&temp_keep_file, exclude_pack->pack_name);
+		strbuf_strip_suffix(&temp_keep_file, ".pack");
+		strbuf_addstr(&temp_keep_file, ".keep");
+	}
 	if (prune_expire && !strcmp(prune_expire, "now"))
 		argv_array_push(&repack, "-a");
 	else {
@@ -205,6 +309,7 @@ static void add_repack_incremental_option(void)
 
 static int need_to_gc(void)
 {
+	struct packed_git *largest_pack = NULL;
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
@@ -218,8 +323,8 @@ static int need_to_gc(void)
 	 * we run "repack -A -d -l".  Otherwise we tell the caller
 	 * there is no need.
 	 */
-	if (too_many_packs())
-		add_repack_all_option();
+	if (too_many_packs(&largest_pack))
+		add_repack_all_option(largest_pack);
 	else if (too_many_loose_objects())
 		add_repack_incremental_option();
 	else
@@ -428,7 +533,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			daemonized = !daemonize();
 		}
 	} else
-		add_repack_all_option();
+		add_repack_all_option(NULL);
 
 	name = lock_repo_for_gc(force, &pid);
 	if (name) {
@@ -450,6 +555,16 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (gc_before_repack())
 		return -1;
 
+	if (temp_keep_file.len) {
+		int fd = open(temp_keep_file.buf, O_CREAT | O_RDWR, 0644);
+		if (fd != -1) {
+			sigchain_push_common(delete_temp_keep_file_on_signal);
+			atexit(delete_temp_keep_file);
+			close(fd);
+		} else {
+			strbuf_release(&temp_keep_file);
+		}
+	}
 	if (!repository_format_precious_objects) {
 		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
 			return error(FAILED_RUN, repack.argv[0]);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c674b2843..722cc999dc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -78,7 +78,7 @@ static uint16_t write_bitmap_options;
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
-- 
2.16.1.435.g8f24da2e1a

