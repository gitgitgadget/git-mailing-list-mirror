Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B561FAE2
	for <e@80x24.org>; Sat, 24 Mar 2018 07:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbeCXHZS (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:25:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39929 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCXHZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:25:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id p142-v6so21365045lfd.6
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E16ypiZ00ivPkCN1XEiworaSqfjNm0FnZicg9VkGB38=;
        b=Zq/P3zS6ZcxRWk1/RHtuhhLiSjmXKd4xadbu5jiw1v76WmRSRk8/cZJbbXa/9oTtiR
         Ot9J8OIux1B3agkkX0WqeFNUiCndeW6ICPmalYNxr4GNd9GKsepBF2Xuv8T/bfOryCae
         gLAgMC41AVoVy8cMMCFebhKnrD2xghP6fxvLQ+lETAR5uqC5cUDsMzATG8LjJXHAFFJf
         UzwRTru+VK/6EhmPdY87YXiuJGSmHsz7L5elrf8QBQZGCk5T48KHLjHMyuv/FuiQiYBa
         mWbbvYG/9zTLyu1qMA+dDj0OMd7P6/Y3l2YMAqVvefOtPdhgTgHd10SLEQUVqV9geJEb
         gC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E16ypiZ00ivPkCN1XEiworaSqfjNm0FnZicg9VkGB38=;
        b=lkJqrUvYrECDXWOTsKEPC/vi7H/xt2OYEGe2Nx7U/yEzvGIy1gfdvuptAxJLfRuC9E
         J2ezsVoJOzGtRFEOczWMaqF5Skvas/NVHHuwA96ZIqanZxM+nEmUbXeWyR5JlRvqJj33
         8sdeJBHBTybJRli4d/t5aLJe1FNFLmLaqwoWCXTLfOLz8G0nCVXtAz8ytFAHLVhJGXqZ
         QsYh2YkRVDbZQqs5SKDLrI6uPXNee/eoS/c9LywgLv6o6ofNYnhW63hJzZN2CGfHmQb7
         LSVKYD9LIfmKLOjJP+9pkx/K+3UFUJdN6Pr1OT+1AZP5zP0EffNHheQJHD4BqRCSDl7W
         zcCg==
X-Gm-Message-State: AElRT7FstdTKyoa3K9IXjIBQjikH+vp5PUt/HXpazc4eHtcKGmSjjUfv
        F+fZxIiHcVKNUWbzrdCEjkvHFg==
X-Google-Smtp-Source: AG47ELvuJwBXXUJHLHrsYVY2LgskJk0Z95G+2OWuFlS+q+PzMTPmVCPRjRIEnTODfLys09pX0IJDVw==
X-Received: by 10.46.128.77 with SMTP id p13mr20739172ljg.56.1521876315532;
        Sat, 24 Mar 2018 00:25:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b67-v6sm2684028lfh.26.2018.03.24.00.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:25:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 0/7] nd/repack-keep-pack updates
Date:   Sat, 24 Mar 2018 08:25:00 +0100
Message-Id: <20180324072507.21059-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180316192745.19557-1-pclouds@gmail.com>
References: <20180316192745.19557-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 is mostly refining tests and other minor fixes on v3

- --keep-base-pack is renamed to --keep-largest-pack
- "Counting objects" progress line is back
- test and docs updates

Interdiff

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b602f918f..cf862d3edf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1562,7 +1562,8 @@ gc.bigPackThreshold::
 	If non-zero, all packs larger than this limit are kept when
 	`git gc` is run. This is very similar to `--keep-base-pack`
 	except that all packs that meet the threshold are kept, not
-	just the base pack. Defaults to zero.
+	just the base pack. Defaults to zero. Common unit suffixes of
+	'k', 'm', or 'g' are supported.
 +
 Note that if the number of kept packs is more than gc.autoPackLimit,
 this configuration variable is ignored, all packs except the base pack
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 19b0d1741b..7549094900 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-base-pack]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
 
 DESCRIPTION
 -----------
@@ -84,11 +84,10 @@ packs.
 	Force `git gc` to run even if there may be another `git gc`
 	instance running on this repository.
 
---keep-base-pack::
-	All packs except the base pack and those marked with a `.keep`
-	files are consolidated into a single pack. The largest pack is
-	considered the base pack. When this option is used,
-	`gc.bigPackThreshold` is ignored.
+--keep-largest-pack::
+	All packs except the largest pack and those marked with a
+	`.keep` files are consolidated into a single pack. When this
+	option is used, `gc.bigPackThreshold` is ignored.
 
 Configuration
 -------------
diff --git a/builtin/gc.c b/builtin/gc.c
index 140c1bb7dd..d0b04e369e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -344,7 +344,7 @@ static int need_to_gc(void)
 				find_base_packs(&keep_pack, 0);
 			}
 		} else {
-			struct packed_git * p = find_base_packs(&keep_pack, 0);
+			struct packed_git *p = find_base_packs(&keep_pack, 0);
 			uint64_t mem_have, mem_want;
 
 			mem_have = total_ram();
@@ -504,8 +504,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
 		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
-		OPT_BOOL(0, "keep-base-pack", &keep_base_pack,
-			 N_("repack all other packs except the base pack")),
+		OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
+			 N_("repack all other packs except the largest pack")),
 		OPT_END()
 	};
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7d738627fc..1379b4cb92 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -54,7 +54,8 @@ static int pack_loose_unreachable;
 static int local;
 static int have_non_local_packs;
 static int incremental;
-static int ignore_packed_keep, ignore_packed_keep_in_core;
+static int ignore_packed_keep_on_disk;
+static int ignore_packed_keep_in_core;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
@@ -983,14 +984,15 @@ static int want_found_object(int exclude, struct packed_git *p)
 	 * Otherwise, we signal "-1" at the end to tell the caller that we do
 	 * not know either way, and it needs to check more packs.
 	 */
-	if (!ignore_packed_keep && !ignore_packed_keep_in_core &&
+	if (!ignore_packed_keep_on_disk &&
+	    !ignore_packed_keep_in_core &&
 	    (!local || !have_non_local_packs))
 		return 1;
 
 	if (local && !p->pack_local)
 		return 0;
 	if (p->pack_local &&
-	    ((ignore_packed_keep && p->pack_keep) ||
+	    ((ignore_packed_keep_on_disk && p->pack_keep) ||
 	     (ignore_packed_keep_in_core && p->pack_keep_in_core)))
 		return 0;
 
@@ -1716,7 +1718,7 @@ static void get_object_details(void)
 	struct object_entry **sorted_by_offset;
 
 	if (progress)
-		progress_state = start_progress(_("Getting object details"),
+		progress_state = start_progress(_("Counting objects"),
 						to_pack.nr_objects);
 
 	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
@@ -2818,7 +2820,7 @@ static int pack_options_allow_reuse(void)
 {
 	return pack_to_stdout &&
 	       allow_ofs_delta &&
-	       !ignore_packed_keep &&
+	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
 	       (!local || !have_non_local_packs) &&
 	       !incremental;
@@ -3059,7 +3061,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("create thin packs")),
 		OPT_BOOL(0, "shallow", &shallow,
 			 N_("create packs suitable for shallow fetches")),
-		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
+		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
@@ -3192,19 +3194,19 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	prepare_packed_git();
 	add_extra_kept_packs(&keep_pack_list);
-	if (ignore_packed_keep) {
+	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
 		for (p = packed_git; p; p = p->next)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
-			ignore_packed_keep = 0;
+			ignore_packed_keep_on_disk = 0;
 	}
 	if (local) {
 		/*
-		 * unlike ignore_packed_keep above, we do not want to
-		 * unset "local" based on looking at packs, as it
-		 * also covers non-local objects
+		 * unlike ignore_packed_keep_on_disk above, we do not
+		 * want to unset "local" based on looking at packs, as
+		 * it also covers non-local objects
 		 */
 		struct packed_git *p;
 		for (p = packed_git; p; p = p->next) {
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 96ca70f9cc..100f287b97 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -50,6 +50,31 @@ test_expect_success 'gc is not aborted due to a stale symref' '
 	)
 '
 
+test_expect_success 'gc --keep-largest-pack' '
+	test_create_repo keep-pack &&
+	(
+		cd keep-pack &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		git gc &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 1 pack-list &&
+		BASE_PACK=.git/objects/pack/pack-*.pack &&
+		test_commit four &&
+		git repack -d &&
+		test_commit five &&
+		git repack -d &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 3 pack-list &&
+		git gc --keep-largest-pack &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 2 pack-list &&
+		test_path_is_file $BASE_PACK &&
+		git fsck
+	)
+'
+
 test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
 	test_config gc.auto 3 &&
 	test_config gc.autodetach false &&
@@ -123,28 +148,6 @@ test_expect_success 'background auto gc respects lock for all operations' '
 	test_path_is_file .git/refs/heads/should-be-loose
 '
 
-test_expect_success 'gc --keep-base-pack' '
-	test_create_repo keep-pack &&
-	(
-		cd keep-pack &&
-		for i in 10; do
-			test_commit $i
-		done &&
-		git gc &&
-		( cd .git/objects/pack && ls *.pack ) >pack-list &&
-		test_line_count = 1 pack-list &&
-		BASE_PACK=.git/objects/pack/pack-*.pack &&
-		for i in 10; do
-			test_commit more-$i
-		done &&
-		git gc --keep-base-pack &&
-		( cd .git/objects/pack && ls *.pack ) >pack-list &&
-		test_line_count = 2 pack-list &&
-		test_path_is_file $BASE_PACK &&
-		git fsck
-	)
-'
-
 # DO NOT leave a detached auto gc process running near the end of the
 # test script: it can run long enough in the background to racily
 # interfere with the cleanup in 'test_done'.
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 05ae0de3aa..6162e2a8e6 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -4,6 +4,12 @@ test_description='git repack works correctly'
 
 . ./test-lib.sh
 
+commit_and_pack() {
+	test_commit "$@" >/dev/null &&
+	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
+	echo pack-${SHA1}.pack
+}
+
 test_expect_success 'objects in packs marked .keep are not repacked' '
 	echo content1 > file1 &&
 	echo content2 > file2 &&
@@ -200,22 +206,16 @@ test_expect_success 'repack --keep-pack' '
 	test_create_repo keep-pack &&
 	(
 		cd keep-pack &&
-		test_commit one &&
-		git repack -d &&
-		test_commit two &&
-		git repack -d &&
-		test_commit three &&
-		git repack -d &&
-		test_commit four &&
-		git repack -d &&
-		( cd .git/objects/pack && ls *.pack ) >pack-list &&
-		test_line_count = 4 pack-list &&
-		KEEP1=$(head -n1 pack-list) &&
-		KEEP4=$(tail -n1 pack-list) &&
-		git repack -a -d --keep-pack $KEEP1 --keep-pack $KEEP4 &&
+		P1=$(commit_and_pack 1) &&
+		P2=$(commit_and_pack 2) &&
+		P3=$(commit_and_pack 3) &&
+		P4=$(commit_and_pack 4) &&
+		ls .git/objects/pack/*.pack >old-counts &&
+		test_line_count = 4 old-counts &&
+		git repack -a -d --keep-pack $P1 --keep-pack $P4 &&
 		ls .git/objects/pack/*.pack >new-counts &&
-		grep -q $KEEP1 new-counts &&
-		grep -q $KEEP4 new-counts &&
+		grep -q $P1 new-counts &&
+		grep -q $P4 new-counts &&
 		test_line_count = 3 new-counts &&
 		git fsck
 	)

Nguyễn Thái Ngọc Duy (7):
  t7700: have closing quote of a test at the beginning of line
  repack: add --keep-pack option
  gc: add --keep-largest-pack option
  gc: add gc.bigPackThreshold config
  gc: handle a corner case in gc.bigPackThreshold
  gc --auto: exclude base pack if not enough mem to "repack -ad"
  pack-objects: show some progress when counting kept objects

 Documentation/config.txt           |  12 +++
 Documentation/git-gc.txt           |  19 +++-
 Documentation/git-pack-objects.txt |   9 +-
 Documentation/git-repack.txt       |   9 +-
 builtin/gc.c                       | 167 +++++++++++++++++++++++++++--
 builtin/pack-objects.c             |  84 +++++++++++----
 builtin/repack.c                   |  21 +++-
 cache.h                            |   1 +
 config.mak.uname                   |   1 +
 git-compat-util.h                  |   4 +
 pack-objects.h                     |   2 +
 t/t6500-gc.sh                      |  32 ++++++
 t/t7700-repack.sh                  |  27 ++++-
 13 files changed, 352 insertions(+), 36 deletions(-)

-- 
2.17.0.rc0.348.gd5a49e0b6f

