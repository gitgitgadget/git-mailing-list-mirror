Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529F51F404
	for <e@80x24.org>; Thu,  6 Sep 2018 02:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeIFHVz (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 03:21:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44246 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIFHVz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 03:21:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so9608869wro.11
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsojoh1UP3e7nudp6zpT3savoc+lhWvFgEOqkZoQN4A=;
        b=CfT7ojeWoJ98e9I0KE4ZHJs/qCjLSKwGAV+GtHTnpg8WAnTdpyUr9cchPCFLx/8fAb
         YufPkkjKDzl8wcaM3dc7wBbBAYGjwKs25mwbbggU/GnC3xiNu+unVXJHDOnox1fXxnk/
         dyZ/uAnbMuKFNpj3ECwywsadKOdtpCbUs2j5Gdvoy/HCfE1Id5ggUmtlF6Aj3xJ1PIwk
         7GQswv0RkKN4EJ1kVlPWpoyzTR6KD56lcFNUjAVBhRcbNkADSwsqF/YRk2VHM0Wz/8aa
         r56kGrGK+Axl+9/dQqOqlfUCJmukTcVER78hV+IbKYC2/OxhbpRkbbSMIR6ihloUsfFX
         xYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsojoh1UP3e7nudp6zpT3savoc+lhWvFgEOqkZoQN4A=;
        b=AFiqkuPCYofizQOhlIl93SEBMPNLp7UYDm4/5yXxufNozt+FyQ2bnsuJ2tlsLrapKD
         xojSoalC9ghpg/qId34+cDdAyWmXVYRfIeKMXBqrgjlLv4nj+W1eYMOv7OL0g6h0L4nD
         D0bLy308CfHoZM9nHIyvrS83LLNZ0UnBfvSuzzMsVVTP5/JF9UFx4dqEedwgpxanJgE3
         NhzC4+8bJWeQWeSobWO73MEqJ/WbDIY9rYE0hXDsQNpQHuylBdQnHVsQeAIAQbQ9yhkD
         IFk5dUtwIE7RDwkNYRYOw7muiS4GSb9FqeJK4pDLSN+pm7ouFA59Ie8JzSdvFThzv5Hg
         vkQA==
X-Gm-Message-State: APzg51AI8XoO8yiomaJG830D4zPhZz+Kjv7E0JDP6JCuZ+r55368rmQu
        fAJtRdOssiRKglbW3pBd7grYUDLCQmo=
X-Google-Smtp-Source: ANB0VdbSNmjTZFB15y1V2kf9n6wn/BPiFKPQ9AXGUBStwpOAIPVtsOdQa2nCi2yqgIT0bjGwbXQJ0A==
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr466589wrh.148.1536202126782;
        Wed, 05 Sep 2018 19:48:46 -0700 (PDT)
Received: from localhost.localdomain (x4db1b35b.dyn.telefonica.de. [77.177.179.91])
        by smtp.gmail.com with ESMTPSA id y10-v6sm3979999wrl.87.2018.09.05.19.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 19:48:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 5/5] split-index: smudge and add racily clean cache entries to split index
Date:   Thu,  6 Sep 2018 04:48:10 +0200
Message-Id: <20180906024810.8074-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.188.g56c5ee2db1
In-Reply-To: <20180906024810.8074-1-szeder.dev@gmail.com>
References: <20180906024810.8074-1-szeder.dev@gmail.com>
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
then go on to check the file's content.

In the above example, however, in the second 'git update-index'
prepare_to_write_split_index() gathers all cache entries that should
be written to the new split index.  Alas, this function never looks
out for racily clean cache entries, and since the file's stat data in
the worktree hasn't changed since the shared index was written, it
won't be replaced in the new split index.  Consequently,
do_write_index() doesn't even get this racily clean cache entry, and
can't smudge its stat data.  Subsequent git commands will then see
that the index has more recent mtime than the file and that the (not
smudged) cached stat data still matches with the file in the worktree,
and, ultimately, will erroneously consider the file clean.

Modify prepare_to_write_split_index() to recognize racily clean cache
entries, and mark them to be added to the split index.  This way
do_write_index() will get these racily clean cache entries as well,
and will then write them with smudged stat data to the new split
index.

Note that after this change if the index is split when it contains a
racily clean cache entry, then a smudged cache entry will be written
both to the new shared and to the new split indexes.  This doesn't
affect regular git commands: as far as they are concerned this is just
an entry in the split index replacing an outdated entry in the shared
index.  It did affect a few tests in 't1700-split-index.sh', though,
because they actually check which entries are stored in the split
index; the previous patch made the necessary adjustments.  And racily
clean cache entries and index splitting are rare enough to not worry
about the resulting duplicated smudged cache entries, and the
additional complexity required to prevent them is not worth it.

Several tests failed occasionally when the test suite was run with
'GIT_TEST_SPLIT_INDEX=yes'.  Here are those that I managed to trace
back to this racy split index problem, starting with those failing
more frequently, with a link to a failing Travis CI build job for
each.  The highlighted line shows when the racy file was written,
which is not always in the failing test (but note that those lines are
in the 'after failure' fold, and your browser might unhelpfully fold
it up before you could take a good look).

  t3903-stash.sh:
    https://travis-ci.org/git/git/jobs/385542084#L5858

  t4024-diff-optimize-common.sh:
    https://travis-ci.org/git/git/jobs/386531969#L3174

  t4015-diff-whitespace.sh:
    https://travis-ci.org/git/git/jobs/360797600#L8215

  t2200-add-update.sh:
    https://travis-ci.org/git/git/jobs/382543426#L3051

  t0090-cache-tree:
    https://travis-ci.org/git/git/jobs/416583010#L3679

There might be others, e.g. perhaps 't1000-read-tree-m-3way.sh' and
others using 'lib-read-tree-m-3way.sh', but I couldn't confirm yet.

[1] In the branch leading to the merge commit v2.1.0-rc0~45 (Merge
    branch 'nd/split-index', 2014-07-16).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 cache.h                     |  2 ++
 read-cache.c                |  2 +-
 split-index.c               | 12 +++++++++++-
 t/t1701-racy-split-index.sh |  4 +---
 4 files changed, 15 insertions(+), 5 deletions(-)

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
index 84f067e10d..b4458f31f6 100644
--- a/split-index.c
+++ b/split-index.c
@@ -220,8 +220,18 @@ void prepare_to_write_split_index(struct index_state *istate)
 			}
 			ce->ce_flags |= CE_MATCHED; /* or "shared" */
 			base = si->base->cache[ce->index - 1];
-			if (ce == base)
+			if (ce == base) {
+				/*
+				 * Racily clean cache entries must be
+				 * written to the split index, so the
+				 * subsequent do_write_index() can smudge
+				 * their stat data.
+				 */
+				if (!ce_uptodate(ce) &&
+				    is_racy_timestamp(istate, ce))
+					ce->ce_flags |= CE_UPDATE_IN_BASE;
 				continue;
+			}
 			if (ce->ce_namelen != base->ce_namelen ||
 			    strcmp(ce->name, base->name)) {
 				ce->index = 0;
diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
index c92ba9ce5e..6780d08367 100755
--- a/t/t1701-racy-split-index.sh
+++ b/t/t1701-racy-split-index.sh
@@ -77,7 +77,7 @@ done
 
 for trial in 0 1 2 3 4
 do
-	test_expect_failure "update the split index when the shared index contains a racily clean cache entry #$trial" '
+	test_expect_success "update the split index when the shared index contains a racily clean cache entry #$trial" '
 		test_when_finished "rm -f .git/index .git/sharedindex.*" &&
 
 		# The next three commands must be run within the same
@@ -100,8 +100,6 @@ do
 		# corresponding replacement cache entry with smudged
 		# stat data should be added to the new split index, so
 		# the file wont appear clean for subsequent git commands.
-		#
-		# Alas, such a smudged replacement entry is not added!
 		git update-index --add other-file &&
 
 		check_cached_diff
-- 
2.19.0.rc0.188.g56c5ee2db1

