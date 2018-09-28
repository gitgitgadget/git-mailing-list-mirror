Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4791F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeI1WuE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:50:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37593 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1WuE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:50:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id y26-v6so2818277wma.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BnazkoRB68yqh9CsAV0vCdukrEovXKyoN2RpedXiuHE=;
        b=NlrfbS+M4KLYTmETmXJjYYuYzTKNlcJVABqFSTpAlNmibLOPkn3u5EUdVKMQ+XaNQt
         fcLyDaGbSv1z8AY23kFTHEGOgyep86QWxAgtW3ElgLyuCk/6GqSkzerYwLhCCh9s709L
         TVfdCr++YARsKjWnAV3uupbFbkqbrgyJSytQlStkChNVYjGI5ChMk+b5JcXutYOv5k94
         WPJCApTMnObP+TG7tMOSOg73q+uzO1jdh2J+va/uTpv+XvwcUeL61UbSJAsJwX7m/0RW
         QK2/xLxjjN+NQuy3QtlQmUgrDo5pgaI+uoSzRiLZnEp3RlxuU22BMOVtGks1B4dfGSJq
         G+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnazkoRB68yqh9CsAV0vCdukrEovXKyoN2RpedXiuHE=;
        b=LHNr5YmQ+MfRmKTzF1Q4WJ3jRp62zFXdT0xGigPRxkrR0AdSpR01w/M8FMTOKXWRka
         EhVzCHJTxHHcXED8AeZUUkle34Fs9SEYbq7hK1U/Xa4A2hSdRueSXQjoaNjqrl01Acba
         FMi36kUCgcHbNvIOyyFjqD9GE83TbOAuBtgpwMM9d7ECE+5MxFNH1rOsanO43wG+NhBR
         9C5SpxEWLfILBRxMXo44ViYJK1VVRz4Mi6zddCaK5AuBHia1ZBCILdnjQd4sXXomxC9a
         mB3s0Zl+79DPe4JhsB02WKR92r0htMk6CEKVF/hsO7LG2hwMLDyn4xpJL4KqtzTJOo+Y
         pueQ==
X-Gm-Message-State: ABuFfogO8QbLYqM53zRDyTgqUuR290ilnAhXuHwodjOz3eKP2KzPpcWP
        OOcn09ioTv1GKJ/KQU7Tl7wbaPm+
X-Google-Smtp-Source: ACcGV60gzvnICsVAcM5LpDzfTCXfq5cLlcwTWbYG9S1FnToY6jgVi4vl4SCbPaUmyB15qEQ1HtUTxw==
X-Received: by 2002:a1c:f10a:: with SMTP id p10-v6mr88340wmh.127.1538151929551;
        Fri, 28 Sep 2018 09:25:29 -0700 (PDT)
Received: from localhost.localdomain (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id s24-v6sm1628247wmc.7.2018.09.28.09.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 09:25:28 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 6/6] split-index: smudge and add racily clean cache entries to split index
Date:   Fri, 28 Sep 2018 18:24:59 +0200
Message-Id: <20180928162459.17138-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.361.gafc87ffe72
In-Reply-To: <20180928162459.17138-1-szeder.dev@gmail.com>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the split index feature was introduced [1], refreshing a
split index is prone to a variant of the classic racy git problem.

Consider the following sequence of commands updating the split index
when the shared index contains a racily clean cache entry, i.e. an
entry whose cached stat data matches with the corresponding file in
the worktree and the cached mtime matches that of the index:

  echo "cached content" >file
  git update-index --split-index --add file
  echo "dirty worktree" >file    # size stays the same!
  # ... wait ...
  git update-index --add other-file

Normally, when a non-split index is updated, then do_write_index()
(the function responsible for writing all kinds of indexes, "regular",
split, and shared) recognizes racily clean cache entries, and writes
them with smudged stat data, i.e. with file size set to 0.  When
subsequent git commands read the index, they will notice that the
smudged stat data doesn't match with the file in the worktree, and
then go on to check the file's content and notice its dirtiness.

In the above example, however, in the second 'git update-index'
prepare_to_write_split_index() decides which cache entries stored only
in the shared index should be replaced in the new split index.  Alas,
this function never looks out for racily clean cache entries, and
since the file's stat data in the worktree hasn't changed since the
shared index was written, it won't be replaced in the new split index.
Consequently, do_write_index() doesn't even get this racily clean
cache entry, and can't smudge its stat data.  Subsequent git commands
will then see that the index has more recent mtime than the file and
that the (not smudged) cached stat data still matches with the file in
the worktree, and, ultimately, will erroneously consider the file
clean.

Modify prepare_to_write_split_index() to recognize racily clean cache
entries, and mark them to be added to the split index.  Note that
there are two places where it should check raciness: first those cache
entries that are only stored in the shared index, and then those that
have been copied by unpack_trees() from the shared index while it
constructed a new index.  This way do_write_index() will get these
racily clean cache entries as well, and will then write them with
smudged stat data to the new split index.

Note that after this change if the index is split when it contains a
racily clean cache entry, then a smudged cache entry will be written
both to the new shared and to the new split indexes.  This doesn't
affect regular git commands: as far as they are concerned this is just
an entry in the split index replacing an outdated entry in the shared
index.  It did affect a few tests in 't1700-split-index.sh', though,
because they actually check which entries are stored in the split
index; a previous patch in this series has already made the necessary
adjustments in 't1700'.  And racily clean cache entries and index
splitting are rare enough to not worry about the resulting duplicated
smudged cache entries, and the additional complexity required to
prevent them is not worth it.

Several tests failed occasionally when the test suite was run with
'GIT_TEST_SPLIT_INDEX=yes'.  Here are those that I managed to trace
back to this racy split index problem, starting with those failing
more frequently, with a link to a failing Travis CI build job for
each.  The highlighted line [2] shows when the racy file was written,
which is not always in the failing test but in a preceeding setup
test.

  t3903-stash.sh:
    https://travis-ci.org/git/git/jobs/385542084#L5858

  t4024-diff-optimize-common.sh:
    https://travis-ci.org/git/git/jobs/386531969#L3174

  t4015-diff-whitespace.sh:
    https://travis-ci.org/git/git/jobs/360797600#L8215

  t2200-add-update.sh:
    https://travis-ci.org/git/git/jobs/382543426#L3051

  t0090-cache-tree.sh:
    https://travis-ci.org/git/git/jobs/416583010#L3679

There might be others, e.g. perhaps 't1000-read-tree-m-3way.sh' and
others using 'lib-read-tree-m-3way.sh', but I couldn't confirm yet.

[1] In the branch leading to the merge commit v2.1.0-rc0~45 (Merge
    branch 'nd/split-index', 2014-07-16).

[2] Note that those highlighted lines are in the 'after failure' fold,
    and your browser might unhelpfully fold it up before you could
    take a good look.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 cache.h                     |  2 ++
 read-cache.c                |  2 +-
 split-index.c               | 42 ++++++++++++++++++++++++++++++++++++-
 t/t1701-racy-split-index.sh |  8 ++-----
 4 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 4d014541ab..3f419b6c79 100644
--- a/cache.h
+++ b/cache.h
@@ -781,6 +781,8 @@ extern void *read_blob_data_from_index(const struct index_state *, const char *,
 #define CE_MATCH_REFRESH		0x10
 /* don't refresh_fsmonitor state or do stat comparison even if CE_FSMONITOR_VALID is true */
 #define CE_MATCH_IGNORE_FSMONITOR 0X20
+extern int is_racy_timestamp(const struct index_state *istate,
+			     const struct cache_entry *ce);
 extern int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..8f644f68b4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -337,7 +337,7 @@ static int is_racy_stat(const struct index_state *istate,
 		);
 }
 
-static int is_racy_timestamp(const struct index_state *istate,
+int is_racy_timestamp(const struct index_state *istate,
 			     const struct cache_entry *ce)
 {
 	return (!S_ISGITLINK(ce->ce_mode) &&
diff --git a/split-index.c b/split-index.c
index 7d8799f6b7..d989b27286 100644
--- a/split-index.c
+++ b/split-index.c
@@ -235,8 +235,39 @@ void prepare_to_write_split_index(struct index_state *istate)
 			}
 			ce->ce_flags |= CE_MATCHED; /* or "shared" */
 			base = si->base->cache[ce->index - 1];
-			if (ce == base)
+			if (ce == base) {
+				/* The entry is present in the shared index. */
+				if (ce->ce_flags & CE_UPDATE_IN_BASE) {
+					/*
+					 * Already marked for inclusion in
+					 * the split index, either because
+					 * the corresponding file was
+					 * modified and the cached stat data
+					 * was refreshed, or because there
+					 * is already a replacement entry in
+					 * the split index.
+					 * Nothing more to do here.
+					 */
+				} else if (!ce_uptodate(ce) &&
+					   is_racy_timestamp(istate, ce)) {
+					/*
+					 * A racily clean cache entry stored
+					 * only in the shared index: it must
+					 * be added to the split index, so
+					 * the subsequent do_write_index()
+					 * can smudge its stat data.
+					 */
+					ce->ce_flags |= CE_UPDATE_IN_BASE;
+				} else {
+					/*
+					 * The entry is only present in the
+					 * shared index and it was not
+					 * refreshed.
+					 * Just leave it there.
+					 */
+				}
 				continue;
+			}
 			if (ce->ce_namelen != base->ce_namelen ||
 			    strcmp(ce->name, base->name)) {
 				ce->index = 0;
@@ -257,6 +288,15 @@ void prepare_to_write_split_index(struct index_state *istate)
 				 * the split index.
 				 * Nothing to do.
 				 */
+			} else if (!ce_uptodate(ce) &&
+				   is_racy_timestamp(istate, ce)) {
+				/*
+				 * A copy of a racily clean cache entry from
+				 * the shared index.  It must be added to
+				 * the split index, so the subsequent
+				 * do_write_index() can smudge its stat data.
+				 */
+				ce->ce_flags |= CE_UPDATE_IN_BASE;
 			} else {
 				/*
 				 * Thoroughly compare the cached data to see
diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
index fbb77046da..5dc221ef38 100755
--- a/t/t1701-racy-split-index.sh
+++ b/t/t1701-racy-split-index.sh
@@ -148,7 +148,7 @@ done
 
 for trial in $trials
 do
-	test_expect_failure "update the split index when a racily clean cache entry is stored only in the shared index $trial" '
+	test_expect_success "update the split index when a racily clean cache entry is stored only in the shared index #$trial" '
 		rm -f .git/index .git/sharedindex.* &&
 
 		# The next three commands must be run within the same
@@ -170,8 +170,6 @@ do
 		# entry of racy-file is only stored in the shared index.
 		# A corresponding replacement cache entry with smudged
 		# stat data should be added to the new split index.
-		#
-		# Alas, such a smudged replacement entry is not added!
 		git update-index --add other-file &&
 
 		# Subsequent git commands should notice the smudged
@@ -182,7 +180,7 @@ done
 
 for trial in $trials
 do
-	test_expect_failure "update the split index after unpack trees() copied a racily clean cache entry from the shared index $trial" '
+	test_expect_success "update the split index after unpack trees() copied a racily clean cache entry from the shared index #$trial" '
 		rm -f .git/index .git/sharedindex.* &&
 
 		# The next three commands must be run within the same
@@ -205,8 +203,6 @@ do
 		# index.  A corresponding replacement cache entry
 		# with smudged stat data should be added to the new
 		# split index.
-		#
-		# Alas, such a smudged replacement entry is not added!
 		git read-tree -m HEAD &&
 
 		# Subsequent git commands should notice the smudged
-- 
2.19.0.361.gafc87ffe72

