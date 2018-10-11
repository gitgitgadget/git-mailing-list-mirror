Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B70C1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeJKRJu (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:09:50 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37838 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeJKRJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:09:50 -0400
Received: by mail-ed1-f45.google.com with SMTP id c22-v6so7635908edc.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NC+nmqR2Ce6MrjsF7+pY2dMCTec4HEYgScbFFXh/GQ=;
        b=LMH4mlFX+iHYlZS6RGzoiBN1pzFjNRoXP1FCys+/uEp/UYBbRI85tgnQk8MW9rjwLQ
         qgyiap3guSP2YrY8crjRU/R5CKVowPmrwW2KSjo+sgu5oX6lS4o4C46UOvUWJ7hFXwAb
         UYirmlXmbI9FvuYfR5UpQA88QHOy2gOuu7CTTdpBbwtwrnbHI98yqsUJ3FnxVVOuM5tL
         5IgbRnK2XxXWlCzsD9ir1/NgZeoOnZ1maJSqQ10ZgGrWf/K7eIie9N5O/TOTkTJNwNoP
         nD3nFVs3SYiGP8SnbB3o4XPeB3WYYgBpx24QpCWZOCtVB7NzK3a4QzgBKlbdw7CPl9pH
         uKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NC+nmqR2Ce6MrjsF7+pY2dMCTec4HEYgScbFFXh/GQ=;
        b=KavQPUigHKJYS4cNxn/BuAEoy1jUSj3OFQjCzwMEWbPUlEtd/ZQfXryeYgKizDGOMC
         OKSBKHjJLZhsqRDeW5fquyAKS36u5lEP52QX57eow8o24lD9PptepPgZWya/igXMgFSI
         zEaSklUm0SymhYTX8LDBEtJog9JYoGnv7ROsvzMvK91rzDoodoIH66UiOs1Ez3o70EcG
         SjlOgP8GKvBafqQslHaPQ0Ub3WQvsBMEoSO/qnczDRN24pYb7pelRpBKkfYqZckEqJUI
         q+uYsIiDTUJkFNofaE9idn+ttPy0jEqUXXRqvEUYZGfFj6CxKvmDgKzlQsD0/hHggjXs
         IQww==
X-Gm-Message-State: ABuFfoixWuuQWt5Me4uVJpkeFbVCw00fKCl/OUfhx5H5fVS8ZuSKeZ4o
        0Lff4XY+tG+kbYCUhMm0VpU=
X-Google-Smtp-Source: ACcGV60LsUyFfkAaOGY4WHj0J32TKPDnMVtWKMpwLYTrgWfQMW12WDVMgD2dPokKvoR0IG0QefFW7w==
X-Received: by 2002:a50:cdd8:: with SMTP id h24-v6mr1719210edj.151.1539250997771;
        Thu, 11 Oct 2018 02:43:17 -0700 (PDT)
Received: from localhost.localdomain (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id q25-v6sm7034721eda.18.2018.10.11.02.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Oct 2018 02:43:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 2/6] split-index: add tests to demonstrate the racy split index problem
Date:   Thu, 11 Oct 2018 11:43:05 +0200
Message-Id: <20181011094309.18626-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.465.gaff195083f
In-Reply-To: <20181011094309.18626-1-szeder.dev@gmail.com>
References: <20180928162459.17138-1-szeder.dev@gmail.com>
 <20181011094309.18626-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the split index feature was introduced [1], refreshing a
split index is prone to a variant of the classic racy git problem.
There are a couple of unrelated tests in the test suite that
occasionally fail when run with 'GIT_TEST_SPLIT_INDEX=yes', but
't1700-split-index.sh', the only test script focusing solely on split
index, has never noticed this issue, because it only cares about how
the index is split under various circumstances and all the different
ways to turn the split index feature on and off.

Add a dedicated test script 't1701-racy-split-index.sh' to exercise
the split index feature in racy situations as well; kind of a
"t0010-racy-git.sh for split index" but with modern style (the tests
do everything in &&-chained list of commands in 'test_expect_...'
blocks, and use 'test_cmp' for more informative output on failure).

The tests cover the following sequences of index splitting, updating,
and racy file modifications, with the last two cases demonstrating the
racy split index problem:

  1. Split the index while adding a racily clean file:

       echo "cached content" >file
       git update-index --split-index --add file
       echo "dirty worktree" >file    # size stays the same

     This case already works properly.  Even though the cache entry's
     stat data matches with the modifid file in the worktree,
     subsequent git commands will notice that the (split) index and
     the file have the same mtime, and then will go on to check the
     file's content and notice its dirtiness.

  2. Add a racily clean file to an already split index:

       git update-index --split-index
       echo "cached content" >file
       git update-index --add file
       echo "dirty worktree" >file

     This case already works properly.  After the second 'git
     update-index' writes the newly added file's cache entry to the
     new split index, it basically works in the same way as case #1.

  3. Split the index when it (i.e. the not yet splitted index)
     contains a racily clean cache entry, i.e. an entry whose cached
     stat data matches with the corresponding file in the worktree and
     the cached mtime matches that of the index:

       echo "cached content" >file
       git update-index --add file
       echo "dirty worktree" >file
       # ... wait ...
       git update-index --split-index --add other-file

     This case already works properly.  The shared index is written by
     do_write_index(), i.e. the same function that is responsible for
     writing "regular" and split indexes as well.  This function
     cleverly notices the racily clean cache entry, and writes the
     entry to the new shared index with smudged stat data, i.e. file
     size set to 0.  When subsequent git commands read the index, they
     will notice that the smudged stat data doesn't match with the
     file in the worktree, and then go on to check the file's content
     and notice its dirtiness.

  4. Update the split index when it contains a racily clean cache
     entry:

       git update-index --split-index
       echo "cached content" >file
       git update-index --add file
       echo "dirty worktree" >file
       # ... wait ...
       git update-index --add other-file

     This case already works properly.  After the second 'git
     update-index' the newly added file's cache entry is only stored
     in the split index.  If a cache entry is present in the split
     index (even if it is a replacement of an outdated entry in the
     shared index), then it will always be included in the new split
     index on subsequent split index updates (until the file is
     removed or a new shared index is written), independently from
     whether the entry is racily clean or not.  When do_write_index()
     writes the new split index, it notices the racily clean cache
     entry, and smudges its stat date.  Subsequent git commands
     reading the index will notice the smudged stat data and then go
     on to check the file's content and notice its dirtiness.

  5. Update the split index when a racily clean cache entry is stored
     only in the shared index:

       echo "cached content" >file
       git update-index --split-index --add file
       echo "dirty worktree" >file
       # ... wait ...
       git update-index --add other-file

     This case fails due to the racy split index problem.  In the
     second 'git update-index' prepare_to_write_split_index() decides,
     among other things, which cache entries stored only in the shared
     index should be replaced in the new split index.  Alas, this
     function never looks out for racily clean cache entries, and
     since the file's stat data in the worktree hasn't changed since
     the shared index was written, the entry won't be replaced in the
     new split index.  Consequently, do_write_index() doesn't even get
     this racily clean cache entry, and can't smudge its stat data.
     Subsequent git commands will then see that the index has more
     recent mtime than the file and that the (not smudged) cached stat
     data still matches with the file in the worktree, and,
     ultimately, will erroneously consider the file clean.

  6. Update the split index after unpack_trees() copied a racily clean
     cache entry from the shared index:

       echo "cached content" >file
       git update-index --split-index --add file
       echo "dirty worktree" >file
       # ... wait ...
       git read-tree -m HEAD

     This case fails due to the racy split index problem.  This
     basically fails for the same reason as case #5 above, but there
     is one important difference, which warrants the dedicated test.
     While that second 'git update-index' in case #5 updates
     index_state in place, in this case 'git read-tree -m' calls
     unpack_trees(), which throws out the entire index, and constructs
     a new one from the (potentially updated) copies of the original's
     cache entries.  Consequently, when prepare_to_write_split_index()
     gets to work on this reconstructed index, it takes a different
     code path than in case #5 when deciding which cache entries in
     the shared index should be replaced.  The result is the same,
     though: the racily clean cache entry goes unnoticed, it isn't
     added to the split index with smudged stat data, and subsequent
     git commands will then erroneously consider the file clean.

Note that in the last two 'test_expect_failure' cases I omitted the
'#' (as in nr. of trial) from the tests' description on purpose for
now, as it breakes the TAP output [2]; it will be added at the end of
the series, when those two tests will be flipped to
'test_expect_success'.

[1] In the branch leading to the merge commit v2.1.0-rc0~45 (Merge
    branch 'nd/split-index', 2014-07-16).

[2] In the TAP output a '#' should separate the test's description
    from the TODO directive emitted by 'test_expect_failure'.  The
    additional '#' in "#$trial" interferes with this, the test harness
    won't recognize the TODO directive, and will report that those
    tests failed unexpectedly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1701-racy-split-index.sh | 218 ++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)
 create mode 100755 t/t1701-racy-split-index.sh

diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
new file mode 100755
index 0000000000..fbb77046da
--- /dev/null
+++ b/t/t1701-racy-split-index.sh
@@ -0,0 +1,218 @@
+#!/bin/sh
+
+# This test can give false success if your machine is sufficiently
+# slow or all trials happened to happen on second boundaries.
+
+test_description='racy split index'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	# Only split the index when the test explicitly says so.
+	sane_unset GIT_TEST_SPLIT_INDEX &&
+	git config splitIndex.maxPercentChange 100 &&
+
+	echo "cached content" >racy-file &&
+	git add racy-file &&
+	git commit -m initial &&
+
+	echo something >other-file &&
+	# No raciness with this file.
+	test-tool chmtime =-20 other-file &&
+
+	echo "+cached content" >expect
+'
+
+check_cached_diff () {
+	git diff-index --patch --cached $EMPTY_TREE racy-file >diff &&
+	tail -1 diff >actual &&
+	test_cmp expect actual
+}
+
+trials="0 1 2 3 4"
+for trial in $trials
+do
+	test_expect_success "split the index while adding a racily clean file #$trial" '
+		rm -f .git/index .git/sharedindex.* &&
+
+		# The next three commands must be run within the same
+		# second (so both writes to racy-file result in the same
+		# mtime) to create the interesting racy situation.
+		echo "cached content" >racy-file &&
+
+		# Update and split the index.  The cache entry of
+		# racy-file will be stored only in the shared index.
+		git update-index --split-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		# Subsequent git commands should notice that racy-file
+		# and the split index have the same mtime, and check
+		# the content of the file to see if it is actually
+		# clean.
+		check_cached_diff
+	'
+done
+
+for trial in $trials
+do
+	test_expect_success "add a racily clean file to an already split index #$trial" '
+		rm -f .git/index .git/sharedindex.* &&
+
+		git update-index --split-index &&
+
+		# The next three commands must be run within the same
+		# second.
+		echo "cached content" >racy-file &&
+
+		# Update the split index.  The cache entry of racy-file
+		# will be stored only in the split index.
+		git update-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		# Subsequent git commands should notice that racy-file
+		# and the split index have the same mtime, and check
+		# the content of the file to see if it is actually
+		# clean.
+		check_cached_diff
+	'
+done
+
+for trial in $trials
+do
+	test_expect_success "split the index when the index contains a racily clean cache entry #$trial" '
+		rm -f .git/index .git/sharedindex.* &&
+
+		# The next three commands must be run within the same
+		# second.
+		echo "cached content" >racy-file &&
+
+		git update-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		# Now wait a bit to ensure that the split index written
+		# below will get a more recent mtime than racy-file.
+		sleep 1 &&
+
+		# Update and split the index when the index contains
+		# the racily clean cache entry of racy-file.
+		# A corresponding replacement cache entry with smudged
+		# stat data should be added to the new split index.
+		git update-index --split-index --add other-file &&
+
+		# Subsequent git commands should notice the smudged
+		# stat data in the replacement cache entry and that it
+		# doesnt match with the file the worktree.
+		check_cached_diff
+	'
+done
+
+for trial in $trials
+do
+	test_expect_success "update the split index when it contains a new racily clean cache entry #$trial" '
+		rm -f .git/index .git/sharedindex.* &&
+
+		git update-index --split-index &&
+
+		# The next three commands must be run within the same
+		# second.
+		echo "cached content" >racy-file &&
+
+		# Update the split index.  The cache entry of racy-file
+		# will be stored only in the split index.
+		git update-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		# Now wait a bit to ensure that the split index written
+		# below will get a more recent mtime than racy-file.
+		sleep 1 &&
+
+		# Update the split index when the racily clean cache
+		# entry of racy-file is only stored in the split index.
+		# An updated cache entry with smudged stat data should
+		# be added to the new split index.
+		git update-index --add other-file &&
+
+		# Subsequent git commands should notice the smudged
+		# stat data.
+		check_cached_diff
+	'
+done
+
+for trial in $trials
+do
+	test_expect_failure "update the split index when a racily clean cache entry is stored only in the shared index $trial" '
+		rm -f .git/index .git/sharedindex.* &&
+
+		# The next three commands must be run within the same
+		# second.
+		echo "cached content" >racy-file &&
+
+		# Update and split the index.  The cache entry of
+		# racy-file will be stored only in the shared index.
+		git update-index --split-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		# Now wait a bit to ensure that the split index written
+		# below will get a more recent mtime than racy-file.
+		sleep 1 &&
+
+		# Update the split index when the racily clean cache
+		# entry of racy-file is only stored in the shared index.
+		# A corresponding replacement cache entry with smudged
+		# stat data should be added to the new split index.
+		#
+		# Alas, such a smudged replacement entry is not added!
+		git update-index --add other-file &&
+
+		# Subsequent git commands should notice the smudged
+		# stat data.
+		check_cached_diff
+	'
+done
+
+for trial in $trials
+do
+	test_expect_failure "update the split index after unpack trees() copied a racily clean cache entry from the shared index $trial" '
+		rm -f .git/index .git/sharedindex.* &&
+
+		# The next three commands must be run within the same
+		# second.
+		echo "cached content" >racy-file &&
+
+		# Update and split the index.  The cache entry of
+		# racy-file will be stored only in the shared index.
+		git update-index --split-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		# Now wait a bit to ensure that the split index written
+		# below will get a more recent mtime than racy-file.
+		sleep 1 &&
+
+		# Update the split index after unpack_trees() copied the
+		# racily clean cache entry of racy-file from the shared
+		# index.  A corresponding replacement cache entry
+		# with smudged stat data should be added to the new
+		# split index.
+		#
+		# Alas, such a smudged replacement entry is not added!
+		git read-tree -m HEAD &&
+
+		# Subsequent git commands should notice the smudged
+		# stat data.
+		check_cached_diff
+	'
+done
+
+test_done
-- 
2.19.1.465.gaff195083f

