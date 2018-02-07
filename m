Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A551F576
	for <e@80x24.org>; Wed,  7 Feb 2018 09:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeBGJWE (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 04:22:04 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39071 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeBGJWB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 04:22:01 -0500
Received: by mail-pg0-f65.google.com with SMTP id w17so63120pgv.6
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 01:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPZ2WZraVaGWllth3KLcyPBOU7HVFP7tuZpzSXqulwY=;
        b=g905+qeUBhihQgceRD0+cmKNIkDIf7Hr7Hl23JZDrijbb/7VR8hkm9H0eWSrdvkdSv
         WVYZWisNm6r80Zi60O9G+6q3HmJnpE8xWFYijaJGdKL5I2DHT04M0vsSdLE7BcEDfrX4
         h1gaUBjUAs0BoB6bboFM3W0vtObjdpUMGK0tB5Dw7QyO1lHHKC4C6c8FebCLeOexXRyA
         C86mb30u65Xqe6DiIiXnl4QJ0hc/fUDhr/XVByqI2A7kCUPYS/MJyrMfQz0r4moBxIgc
         3WOjjsTVBcghpaRAQtJ+QIzduMnzyoGgBE+YVPcNoxpLYKJswQ+ukE1RFj1yblOQLxPF
         AceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPZ2WZraVaGWllth3KLcyPBOU7HVFP7tuZpzSXqulwY=;
        b=eYwBxnX3jhJs2s6wyTjmV9899LxRnc8d5+YyXBWv2MCzp7Jp2QyXdl+R3wbSR+Fmpd
         zjKZGkQzUk3ToE2N1iWcgMbPla7mb/8s1Isw2QFOxjuX4nQjcCFza8kUlkPCOxdY3yWZ
         IfBaudB1k/DuCYAMtZjWj26XhKKQieVmclVRn8EVwBxEsy08ESz1b3I0R1wbU6PqyRtq
         DJ3CaQJ8WPr4FrW6Iagr0XL6otkNLVbLGHnLtXYgA8zbc1FiYP3/XkWMxmm109Ho3QFR
         iB6sb8oJIMVCa5FqGGmPmInLXD/zeD0inNFBueYCrwi+e2nwS/3UzZ/7np+wMYIfrHNN
         yrkA==
X-Gm-Message-State: APf1xPC3S6kseaIkd6JJoMwwj7BKNSug5RktsJCa2dapzX/yRdP9Y4h2
        pJbHQ9jqNVHjx3LGKn88Iu0=
X-Google-Smtp-Source: AH8x227fxVAUDfuFYN5m9+IDIgvapXxCKdeCnGgqVsXtPM8rA1rdgH/OEecKek94bgrHxmRhow4wLA==
X-Received: by 10.98.8.206 with SMTP id 75mr5390776pfi.172.1517995320887;
        Wed, 07 Feb 2018 01:22:00 -0800 (PST)
Received: from ash ([171.233.100.40])
        by smtp.gmail.com with ESMTPSA id h8sm3245617pfk.121.2018.02.07.01.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2018 01:22:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 07 Feb 2018 16:21:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] dir.c: ignore paths containing .git when invalidating untracked cache
Date:   Wed,  7 Feb 2018 16:21:40 +0700
Message-Id: <20180207092141.4312-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180204093823.3671-1-pclouds@gmail.com>
References: <20180204093823.3671-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_directory() code ignores all paths named ".git" even if it's not
a valid git repository. See treat_path() for details. Since ".git" is
basically invisible to read_directory(), when we are asked to
invalidate a path that contains ".git", we can safely ignore it
because the slow path would not consider it anyway.

This helps when fsmonitor is used and we have a real ".git" repo at
worktree top. Occasionally .git/index will be updated and if the
fsmonitor hook does not filter it, untracked cache is asked to
invalidate the path ".git/index".

Without this patch, we invalidate the root directory unncessarily,
which:

- makes read_directory() fall back to slow path for root directory
  (slower)

- makes the index dirty (because UNTR extension is updated). Depending
  on the index size, writing it down could also be slow.

A note about the new "safe_path" knob. Since this new check could be
relatively expensive, avoid it when we know it's not needed. If the
path comes from the index, it can't contain ".git". If it does
contain, we may be screwed up at many more levels, not just this one.

Noticed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 My v1 was rubbish. It's no wonder Ben didn't see my intention. v2
 corrects the "is .git in a given path?" logic and adds a test to
 verify it.

 dir.c                       | 10 ++++++----
 dir.h                       |  2 +-
 fsmonitor.c                 |  2 +-
 fsmonitor.h                 |  2 +-
 t/t7519-status-fsmonitor.sh | 39 +++++++++++++++++++++++++++++++++++++
 unpack-trees.c              |  2 +-
 6 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 7c4b45e30e..fce45fc55e 100644
--- a/dir.c
+++ b/dir.c
@@ -1773,7 +1773,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	if (!de)
 		return treat_path_fast(dir, untracked, cdir, istate, path,
 				       baselen, pathspec);
-	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
+	if (is_dot_or_dotdot(de->d_name) || !fspathcmp(de->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
 	strbuf_addstr(path, de->d_name);
@@ -2968,10 +2968,12 @@ static int invalidate_one_component(struct untracked_cache *uc,
 }
 
 void untracked_cache_invalidate_path(struct index_state *istate,
-				     const char *path)
+				     const char *path, int safe_path)
 {
 	if (!istate->untracked || !istate->untracked->root)
 		return;
+	if (!safe_path && !verify_path(path))
+		return;
 	invalidate_one_component(istate->untracked, istate->untracked->root,
 				 path, strlen(path));
 }
@@ -2979,13 +2981,13 @@ void untracked_cache_invalidate_path(struct index_state *istate,
 void untracked_cache_remove_from_index(struct index_state *istate,
 				       const char *path)
 {
-	untracked_cache_invalidate_path(istate, path);
+	untracked_cache_invalidate_path(istate, path, 1);
 }
 
 void untracked_cache_add_to_index(struct index_state *istate,
 				  const char *path)
 {
-	untracked_cache_invalidate_path(istate, path);
+	untracked_cache_invalidate_path(istate, path, 1);
 }
 
 /* Update gitfile and core.worktree setting to connect work tree and git dir */
diff --git a/dir.h b/dir.h
index 11a047ba48..06df057054 100644
--- a/dir.h
+++ b/dir.h
@@ -350,7 +350,7 @@ static inline int dir_path_match(const struct dir_entry *ent,
 int cmp_dir_entry(const void *p1, const void *p2);
 int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry *in);
 
-void untracked_cache_invalidate_path(struct index_state *, const char *);
+void untracked_cache_invalidate_path(struct index_state *, const char *, int safe_path);
 void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
diff --git a/fsmonitor.c b/fsmonitor.c
index 0af7c4edba..6d7bcd5d0e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -130,7 +130,7 @@ static void fsmonitor_refresh_callback(struct index_state *istate, const char *n
 	 * as it could be a new untracked file.
 	 */
 	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s'", name);
-	untracked_cache_invalidate_path(istate, name);
+	untracked_cache_invalidate_path(istate, name, 0);
 }
 
 void refresh_fsmonitor(struct index_state *istate)
diff --git a/fsmonitor.h b/fsmonitor.h
index cd3cc0ccf2..65f3743636 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -65,7 +65,7 @@ static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cac
 {
 	if (core_fsmonitor) {
 		ce->ce_flags &= ~CE_FSMONITOR_VALID;
-		untracked_cache_invalidate_path(istate, ce->name);
+		untracked_cache_invalidate_path(istate, ce->name, 1);
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
 	}
 }
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index eb2d13bbcf..756beb0d8e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -314,4 +314,43 @@ test_expect_success 'splitting the index results in the same state' '
 	test_cmp expect actual
 '
 
+test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR' '
+	test_create_repo dot-git &&
+	(
+		cd dot-git &&
+		mkdir -p .git/hooks &&
+		: >tracked &&
+		: >modified &&
+		mkdir dir1 &&
+		: >dir1/tracked &&
+		: >dir1/modified &&
+		mkdir dir2 &&
+		: >dir2/tracked &&
+		: >dir2/modified &&
+		write_integration_script &&
+		git config core.fsmonitor .git/hooks/fsmonitor-test &&
+		git update-index --untracked-cache &&
+		git update-index --fsmonitor &&
+		GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-before" \
+		git status &&
+		test-dump-untracked-cache >../before
+	) &&
+	cat >>dot-git/.git/hooks/fsmonitor-test <<-\EOF &&
+	printf ".git\0"
+	printf ".git/index\0"
+	printf "dir1/.git\0"
+	printf "dir1/.git/index\0"
+	EOF
+	(
+		cd dot-git &&
+		GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-after" \
+		git status &&
+		test-dump-untracked-cache >../after
+	) &&
+	grep "directory invalidation" trace-before >>before &&
+	grep "directory invalidation" trace-after >>after &&
+	# UNTR extension unchanged, dir invalidation count unchanged
+	test_cmp before after
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 96c3327f19..9a327696c5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1506,7 +1506,7 @@ static void invalidate_ce_path(const struct cache_entry *ce,
 	if (!ce)
 		return;
 	cache_tree_invalidate_path(o->src_index, ce->name);
-	untracked_cache_invalidate_path(o->src_index, ce->name);
+	untracked_cache_invalidate_path(o->src_index, ce->name, 1);
 }
 
 /*
-- 
2.16.1.207.gedba492059

