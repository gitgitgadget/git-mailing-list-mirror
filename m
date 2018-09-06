Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71EC51F404
	for <e@80x24.org>; Thu,  6 Sep 2018 02:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIFHVn (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 03:21:43 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39831 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIFHVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 03:21:43 -0400
Received: by mail-wm0-f48.google.com with SMTP id q8-v6so9631579wmq.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 19:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PgPIaxXo4GXb/CJL0xnLvJyojebhaSapYWyc/abeio=;
        b=kMHQsWhB6n+o85u5kEWtlgO/dXirxXciaXEJ1FE/hw03k7kq9X88YLPi0rFwbbMJ/m
         rrBgxs98MUiEwgO4Q49DwcYgjVQkUfucvOUX1h3YgbVjE+wEFbtXRIkXDQ0hRvC6SHCx
         r7/qhyi0t0tOu3lGRtKMNr4JgV2UeTC6AxA7hEEkPNJezvjICAXCLDdHL6uNcTP9pysQ
         ZUrwm5HoCsDEymAGPWa2NtbLGcPROicCsfymUpX0DZjg8dzWXt+ajtRnA4eZOsz2baoG
         ptss7EPm89FtbskaLODJhjWIkCp7rMY6rNFkpFm7LMrOEYR1mgrE6W1Dvlu+eCumEw42
         4xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PgPIaxXo4GXb/CJL0xnLvJyojebhaSapYWyc/abeio=;
        b=ouRDkw5TNYYbyJG/CaRW5kB4HXNJNuOs4M4XAxqW3MjOQxp2HVgkQHxtJ98qTCzCiN
         E+BR4TPdXY1SiA3vfFWhpu5VqbbFI1x86sdM/vSAHjgMwsJ2t/9BUcbuLmzMlN2DLh0D
         +bEU/3/wDzrNqKY4Qy5yDMH5d+bd3O+dyXcbp1W+Ge4NrUqG/6F8nbPX68pOnBjLbui8
         xftiOMLvv0boHJHBw8aMb8ZubGD3simnosd9otH4hA0JpUk5ZwqRzgcjwXeCFFtGgbhi
         08Laq4C6KYiADjQejhdjTt6GTzaMpTBTwvCKllGpm+jsTkp2BxJ1KxqsnnJsFehmQnHy
         vGyw==
X-Gm-Message-State: APzg51AuOjaoDvPHmpIj7u2oU2UE8UWimVYhD50GzYjyBLVC/xLw7TP4
        ytRFyGnFQFCFtfkUOaYTdV5WbdZ7xew=
X-Google-Smtp-Source: ANB0VdYzbuZ/0FW1XlZNPyGOjBkmhZHJT6oGVo4gxjBJPRWRpFAPOLRffOwBKsJlpDIiKZ9HdYVPHA==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr709553wma.41.1536202115408;
        Wed, 05 Sep 2018 19:48:35 -0700 (PDT)
Received: from localhost.localdomain (x4db1b35b.dyn.telefonica.de. [77.177.179.91])
        by smtp.gmail.com with ESMTPSA id y10-v6sm3979999wrl.87.2018.09.05.19.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 19:48:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 3/5] split index: add a test to demonstrate the racy split index problem
Date:   Thu,  6 Sep 2018 04:48:08 +0200
Message-Id: <20180906024810.8074-4-szeder.dev@gmail.com>
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
and racy file modifications, with case #3 demonstrating the racy split
index problem:

  1. Split the index when the worktree contains a racily clean file:

       echo "cached content" >file
       git update-index --split-index --add file
       echo "dirty worktree" >file    # size stays the same

     This case already works properly.  Even though the cache entry's
     stat data matches with the file in the worktree, subsequent git
     commands will notice that the (split) index and the file have the
     same mtime, and then will go on to check the file's content.

  2. Split the index when it (i.e. the not yet splitted index)
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
     file in the worktree, and then go on to check the file's content.

  3. Update the split index when the shared index contains a racily
     clean cache entry:

       echo "cached content" >file
       git update-index --split-index --add file
       echo "dirty worktree" >file
       # ... wait ...
       git update-index --add other-file

     This case fails due to the racy split index problem.  In the
     second 'git update-index' prepare_to_write_split_index() gathers
     all cache entries that should be written to the new split index.
     Alas, this function never looks out for racily clean cache
     entries, and since the file's stat data in the worktree hasn't
     changed since the shared index was written, the entry won't be
     replaced in the new split index.  Consequently, do_write_index()
     doesn't even get this racily clean cache entry, and can't smudge
     its stat data.  Subsequent git commands will then see that the
     index has more recent mtime than the file and that the (not
     smudged) cached stat data still matches with the file in the
     worktree, and, ultimately, will erroneously consider the file
     clean.

  4. Add a racily clean file to an already split index:

       git update-index --split-index
       echo "cached content" >file
       git update-index --add file
       echo "dirty worktree" >file

     This case already works properly.  After the second 'git
     update-index' writes the newly added file's cache entry to the
     new split index, it basically works in the same way as case #1.

  5. Update the split index when it contains a racily clean cache
     entry:

       git update-index --split-index
       echo "cached content" >file
       git update-index --add file
       echo "dirty worktree" >file
       # ... wait ...
       git update-index --add other-file

     This case already works properly.  Since the second 'git
     update-index' writes the newly added file's cache entry to the
     split index, the third 'git update-index's do_write_index() now
     has a chance to look at this entry, notices its raciness, and
     writes smudged stat data to the new split index.

[1] In the branch leading to the merge commit v2.1.0-rc0~45 (Merge
    branch 'nd/split-index', 2014-07-16).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1701-racy-split-index.sh | 164 ++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100755 t/t1701-racy-split-index.sh

diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
new file mode 100755
index 0000000000..c92ba9ce5e
--- /dev/null
+++ b/t/t1701-racy-split-index.sh
@@ -0,0 +1,164 @@
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
+	sane_unset GIT_TEST_SPLIT_INDEX GIT_FSMONITOR_TEST &&
+	git config splitIndex.maxPercentChange 100 &&
+
+	echo something >other-file &&
+	# No raciness with this file.
+	test-tool chmtime =-20 other-file
+'
+
+check_cached_diff () {
+	git diff-index --patch --cached $EMPTY_TREE racy-file >diff &&
+	tail -1 diff >actual &&
+	echo "+cached content" >expect &&
+	test_cmp expect actual
+}
+
+for trial in 0 1 2 3 4
+do
+	test_expect_success "split the index when the worktree contains a racily clean file #$trial" '
+		test_when_finished "rm -f .git/index .git/sharedindex.*" &&
+
+		# The next three commands must be run within the same
+		# second (so both writes to racy-file result in the same
+		# mtime) to create the interesting racy situation.
+		echo "cached content" >racy-file &&
+
+		# Update and split the index.  The cache entry of
+		# racy-file will be stored in the shared index.
+		git update-index --split-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		check_cached_diff
+	'
+done
+
+for trial in 0 1 2 3 4
+do
+	test_expect_success "split the index when it contains a racily clean cache entry #$trial" '
+		test_when_finished "rm -f .git/index .git/sharedindex.*" &&
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
+		# below will get a more recent mtime than racy-file,
+		# and, consequently, subsequent git commands wont
+		# consider the entry racily clean.
+		sleep 1 &&
+
+		# Update and split the index when it contains the
+		# racily clean cache entry of racy-file; the stat data
+		# in that entry should be smudged, so the file wont
+		# appear clean for subsequent git commands.
+		git update-index --split-index --add other-file &&
+
+		check_cached_diff
+	'
+done
+
+for trial in 0 1 2 3 4
+do
+	test_expect_failure "update the split index when the shared index contains a racily clean cache entry #$trial" '
+		test_when_finished "rm -f .git/index .git/sharedindex.*" &&
+
+		# The next three commands must be run within the same
+		# second.
+		echo "cached content" >racy-file &&
+
+		# Update and split the index.  The cache entry of
+		# racy-file will be stored in the shared index.
+		git update-index --split-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		# Now wait a bit to ensure that the split index written
+		# below will get a more recent mtime than racy-file.
+		sleep 1 &&
+
+		# Update the split index when the shared index contains
+		# the racily clean cache entry of racy-file.  A
+		# corresponding replacement cache entry with smudged
+		# stat data should be added to the new split index, so
+		# the file wont appear clean for subsequent git commands.
+		#
+		# Alas, such a smudged replacement entry is not added!
+		git update-index --add other-file &&
+
+		check_cached_diff
+	'
+done
+
+for trial in 0 1 2 3 4
+do
+	test_expect_success "add a racily clean file to an already split index #$trial" '
+		test_when_finished "rm -f .git/index .git/sharedindex.*" &&
+
+		git update-index --split-index &&
+
+		# The next three commands must be run within the same
+		# second.
+		echo "cached content" >racy-file &&
+
+		# Update the split index.  The cache entry of racy-file
+		# will be stored in the split index.
+		git update-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		check_cached_diff
+	'
+done
+
+for trial in 0 1 2 3 4
+do
+	test_expect_success "update the split index when it contains a racily clean cache entry #$trial" '
+		test_when_finished "rm -f .git/index .git/sharedindex.*" &&
+
+		git update-index --split-index &&
+
+		# The next three commands must be run within the same
+		# second.
+		echo "cached content" >racy-file &&
+
+		# Update the split index.  The cache entry of racy-file
+		# will be stored in the split index.
+		git update-index --add racy-file &&
+
+		# File size must stay the same.
+		echo "dirty worktree" >racy-file &&
+
+		# Now wait a bit to ensure that the split index written
+		# below will get a more recent mtime than racy-file.
+		sleep 1 &&
+
+		# Update the split index when it contains the racily
+		# clean cache entry of racy-file; the stat data in that
+		# entry should be smudged.
+		git update-index --add other-file &&
+
+		check_cached_diff
+	'
+done
+
+test_done
-- 
2.19.0.rc0.188.g56c5ee2db1

