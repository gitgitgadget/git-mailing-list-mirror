Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE67C1F428
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeHMS6O (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:14 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:37809 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMS6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:14 -0400
Received: by mail-lf1-f49.google.com with SMTP id j8-v6so11658178lfb.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aO8DWRpjfA5igcRSG6BhJfxSNZhUdgz8MakZvkUpmuU=;
        b=VbiDtNA9yQgguqYIx2JdAHI1vg88g7DZvA1+sWED4yBFCbI6Ti75fn1xnwTO7ESscQ
         RLdzck/ydvHkfjipnOD2IhKwLjkHsI3lDZvUWM+ZX6irkVgQBA33k3go/pO0nMsbI0uf
         90L18JrZpMOWxW/+8UKawwRjyzCyOH/5ckb3pO3tqaN0yMCGoEVeSi0KrIp+4WCLIq+0
         9EEDppZHGSPwtSncFJbI0WshztpnJJzKvMeYlNjPDTOV0p5gHu7NLNjlmh4XSgKHTEM2
         QopOKdEOD0ciDFJiszx7ebwQ85BUV1icbPObEc536iEktwuJWtlin754EgO/YtTI1MHX
         iSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aO8DWRpjfA5igcRSG6BhJfxSNZhUdgz8MakZvkUpmuU=;
        b=QwAg6MmzXspa08L61JkJI6/4NpK9z+g4RnyPyiYtmiU6KvdjT/z1DzddODghqyEilC
         HU6tMCLHg4902eCymiIpRx+/sWSPT/+GzJ4V1ngY9KGsePIgz01jgAYm8fLVzYr9Klo9
         2SKQHTzbvX2AwBFAE8W7LAFw0XZ0FK0js0Chhx+j16ARosyuZ+fVaT/LWWkQZ8/7iNGz
         LK9EQOqjBDlCjvfZazqXkilNqWUt9ZQFJRd6Og9tPGv3iAmSg1qEGFDlKl1+My8Ma4oa
         jWU1raH8gb6f+3kGQSHJnBAGijFFHkFxOv+pMrgbMeFnxtBQ9pwXas2C+3zTEiOm02r5
         C0PQ==
X-Gm-Message-State: AOUpUlHV+B3GTUcefoUpfu0fnXK2tESTxOuz/eDR1iW4+wRFHGcgC0bZ
        LPWN9O9ATjMy0BKHWlGZXcE0G//G
X-Google-Smtp-Source: AA+uWPwRlOa+5zAIzejpJBxV+Jr7bbIEBY5RCQBXuCaaczHqe49kRnAf8it4eAX/YfAX11ja7gs38w==
X-Received: by 2002:a19:d819:: with SMTP id p25-v6mr11495250lfg.36.1534176918533;
        Mon, 13 Aug 2018 09:15:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/24] Kill the_index part3
Date:   Mon, 13 Aug 2018 18:14:17 +0200
Message-Id: <20180813161441.16824-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third part of killing the_index (at least outside
builtin/). Part 1 [1] is dropped. Part 2 is nd/no-extern on 'pu'. This
part is built on top of nd/no-extern.

This series would actually break 'pu' because builtin/stash.c uses
three functions that are updated here. So we would need something like
the following patch to make it build again.

I don't know if that adds too much work on Junio. If it does, I guess
I'll hold this off for a while until builtin/stash.c gets merged
because reordering these patches, pushing the patches that break
stash.c away, really takes a lot of work.

[1] https://public-inbox.org/git/20180616054157.32433-1-pclouds@gmail.com/

diff --git a/builtin/stash.c b/builtin/stash.c
index 74eda822ce..f34edba21f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -294,7 +294,7 @@ static int apply_patch_from_buf(struct strbuf *patch, int cached, int reverse,
 	const char *patch_path = ".git/stash_patch.patch";
 	FILE *patch_file;
 
-	if (init_apply_state(&state, NULL))
+	if (init_apply_state(&state, the_repository, NULL))
 		return -1;
 
 	state.cached = cached;
@@ -873,7 +873,7 @@ static int get_untracked_files(const char **argv, const char *prefix,
 	max_len = fill_directory(&dir, the_repository->index, &pathspec);
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (!dir_path_match(ent, &pathspec, max_len, seen)) {
+		if (!dir_path_match(the_repository->index, ent, &pathspec, max_len, seen)) {
 			free(ent);
 			continue;
 		}
@@ -1299,7 +1299,7 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
 
 		for (i = 0; i < active_nr; ++i) {
 			const struct cache_entry *ce = active_cache[i];
-			if (!ce_path_match(ce, &ps, ps_matched))
+			if (!ce_path_match(&the_index, ce, &ps, ps_matched))
 				continue;
 		}
 
Nguyễn Thái Ngọc Duy (24):
  diff.c: move read_index() code back to the caller
  cache-tree: wrap the_index based wrappers with #ifdef
  attr: remove an implicit dependency on the_index
  convert.c: remove an implicit dependency on the_index
  dir.c: remove an implicit dependency on the_index in pathspec code
  preload-index.c: use the right index instead of the_index
  ls-files: correct index argument to get_convert_attr_ascii()
  unpack-trees: remove 'extern' on function declaration
  unpack-trees: add a note about path invalidation
  unpack-trees: don't shadow global var the_index
  unpack-trees: convert clear_ce_flags* to avoid the_index
  unpack-trees: avoid the_index in verify_absent()
  pathspec.c: use the right index instead of the_index
  submodule.c: use the right index instead of the_index
  entry.c: use the right index instead of the_index
  attr: remove index from git_attr_set_direction()
  grep: use the right index instead of the_index
  archive.c: avoid access to the_index
  archive-*.c: use the right repository
  resolve-undo.c: use the right index instead of the_index
  apply.c: pass struct apply_state to more functions
  apply.c: make init_apply_state() take a struct repository
  apply.c: remove implicit dependency on the_index
  blame.c: remove implicit dependency on the_index

 apply.c                     | 66 +++++++++++++++++++++----------------
 apply.h                     |  4 +++
 archive-tar.c               |  2 +-
 archive-zip.c               |  2 +-
 archive.c                   | 47 ++++++++++++++++----------
 archive.h                   | 16 +++++++--
 attr.c                      | 52 +++++++++++++++++------------
 attr.h                      | 11 ++++---
 blame.c                     | 52 +++++++++++++++++------------
 blame.h                     |  1 +
 builtin/add.c               |  6 ++--
 builtin/am.c                |  2 +-
 builtin/apply.c             |  2 +-
 builtin/archive.c           |  2 +-
 builtin/blame.c             |  1 +
 builtin/cat-file.c          |  2 +-
 builtin/check-attr.c        |  6 ++--
 builtin/checkout-index.c    |  1 +
 builtin/checkout.c          |  2 +-
 builtin/clean.c             |  2 +-
 builtin/commit.c            |  2 +-
 builtin/diff-tree.c         |  8 +++--
 builtin/grep.c              |  6 ++--
 builtin/ls-files.c          | 17 +++++-----
 builtin/pack-objects.c      |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 builtin/update-index.c      |  2 +-
 builtin/upload-archive.c    |  3 +-
 cache-tree.c                | 12 -------
 cache-tree.h                | 17 ++++++++--
 convert.c                   | 41 +++++++++++++----------
 convert.h                   | 15 ++++++---
 diff-lib.c                  |  4 +--
 diff.c                      | 12 +------
 diff.h                      |  1 -
 dir.c                       | 27 ++++++++-------
 dir.h                       | 16 +++++----
 entry.c                     |  9 ++---
 ll-merge.c                  |  4 +--
 merge-recursive.c           |  2 +-
 pathspec.c                  |  2 +-
 preload-index.c             |  2 +-
 read-cache.c                |  2 +-
 rerere.c                    |  2 +-
 resolve-undo.c              |  2 +-
 revision.c                  |  2 +-
 sequencer.c                 |  4 +--
 sha1-file.c                 |  4 +--
 submodule.c                 |  8 ++---
 unpack-trees.c              | 57 ++++++++++++++++++++------------
 unpack-trees.h              |  4 +--
 userdiff.c                  |  2 +-
 ws.c                        |  2 +-
 wt-status.c                 |  6 ++--
 55 files changed, 337 insertions(+), 245 deletions(-)

-- 
2.18.0.1004.g6639190530

