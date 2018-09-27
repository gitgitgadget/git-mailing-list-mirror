Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9156B1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 12:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeI0TCw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 15:02:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46638 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeI0TCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 15:02:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so2414606wrr.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hEZ5De8oCji5UiXgJDPiLuzikPiToc+tVSLF3ftIlx4=;
        b=MhgebWIFJC6FoyF4vKbc/FJZ72VKaw+pbLARjezWHhC6XWg+uLEF1WkKT25phJFX4b
         LOw/ZxZ5Ki7L//r9NP1mmMTdj6Zr2vDmW3TM3/aMKcKOXa2/KjrokRuVAzBlgZToce0e
         JqM40NIqhDDWqw4uVaEFI+zlNbu5vnZ7VcTQQ3lGZLppgwvAD6jIEqHwLuReAJAh/scY
         kYCGnAI6FEitiZqEyYPpUZnu4GatZeTYqDqYkL/uZMCkvM23HcMicvBzOfWlFT/jjj8R
         nJeN/acgHOjrheZaN+fuFuBfFUxUENiNFYCW3x6Q+IYM/aARtia2Ydh7DNwQmDz2sdXk
         3ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hEZ5De8oCji5UiXgJDPiLuzikPiToc+tVSLF3ftIlx4=;
        b=jB9OccRH3KrpQR80T6xtXBHCxJ5OsL6FnkTiCnrUMYgFExeTHW6XiRJdmsUOK9XNPG
         1qoMkirIY4b04aJJPvmA1Xu9wdw6zVguvdApOHkitwmk1hZfH3Prm10C4bTL3xgh67HB
         a0kd5wR6eo+xWsRFI0/vrLUG0sK3+pGMY9E23zcCaHT2aluCy7k4MVYGr/1hlhzSFISl
         50SlnIpGFa2ebH9Am6nERZGV7hbi/uUCU99U8WMRoIBGxqY7EDbM91utIPCb3yPWon0T
         CF6PLECShgTC7qtD30SZXG3KSE9S5/8GMUuJIoXxe/jEa+KPws+yCeLcNWbA9OF/xO4F
         6KdA==
X-Gm-Message-State: ABuFfoi4FxUmM1uQVzNKJmXTohVYu2MS+YHm+O0OpyLTIkD71BIEK4BI
        rF4GMdxGLHP3W283aq7LNfXDw6Qf
X-Google-Smtp-Source: ACcGV62yCqPqGXT/V5WkaMkWQiYE1vEOswq9lTSlnHaOlJ5d8cahNgolT8Oia5gR24OrKaX4Q9UL9w==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr8802162wrc.277.1538052282838;
        Thu, 27 Sep 2018 05:44:42 -0700 (PDT)
Received: from localhost.localdomain (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id c8-v6sm1938543wrn.43.2018.09.27.05.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 05:44:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/5] Fix the racy split index problem
Date:   Thu, 27 Sep 2018 14:44:29 +0200
Message-Id: <20180927124434.30835-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.361.gafc87ffe72
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second attempt to fix the racy split index problem, which
causes occasional failures in several random test scripts when run
with 'GIT_TEST_SPLIT_INDEX=yes'.  The important details are in patches
1 and 5 (corresponding to v1's 3 and 5).

Changes since v1:

  - Most importanly, patch 5 adds a second is_racy_timestamp()
    condition to prepare_to_write_split_index() to deal with those
    racily clean cache entries that were copied from the shared index
    by unpack_trees() while it created a new index.
    This should fix the remainig failures in 't3903-stash.sh' with
    split index enabled.

    Furthermore, together with patch 4 they add a bunch of comments to
    the most (alas, not all) conditions in
    prepare_to_write_split_index()'s first loop, trying to explain in
    plain English which cache entries are handled by each of those
    conditions.  I might have gone a bit overboard with the comments,
    but I think they would have helped me a lot while working on these
    fixes...

  - Patch 1 adds one more failing test to demonstrate the raciness
    after unpack_trees() created a new index.

    Updated some of the comments in those tests, and I also reordered
    some tests, because I found that it's more logical to explain them
    in this order.  (However, this made 'range-diff' think that it's a
    total rewrite, which is not really true... but even though I could
    convince it otherwise by adjusting the --creation-factor, the
    results were utterly unreadable.)

  - Patch 4 is new and...  interesting?  I'd like to hear Duy's
    thoughts on this one.

  - Patch 3 is new and...  I hesitate to call it a bugfix, because,
    luckily, there is no real and visible bug, but it's a fix
    nonetheless.

  - Commit message updates here and there.

  - Addressed Ævar's nits in patch 2.

  - The first two patches from v1 have already been merged to
    'master' (cff90bdc5c (Merge branch 'sg/split-index-test',
    2018-09-24)).


SZEDER Gábor (5):
  split-index: add tests to demonstrate the racy split index problem
  t1700-split-index: date back files to avoid racy situations
  split-index: count the number of deleted entries
  split-index: don't compare stat data of entries already marked for
    split index
  split-index: smudge and add racily clean cache entries to split index

 cache.h                     |   2 +
 read-cache.c                |   2 +-
 split-index.c               | 121 +++++++++++++++++---
 t/t1700-split-index.sh      |  49 +++++----
 t/t1701-racy-split-index.sh | 214 ++++++++++++++++++++++++++++++++++++
 5 files changed, 348 insertions(+), 40 deletions(-)
 create mode 100755 t/t1701-racy-split-index.sh

Range-diff:
1:  71d973e4c0 < -:  ---------- t1700-split-index: drop unnecessary 'grep'
2:  5d46f58a07 < -:  ---------- t0090: disable GIT_TEST_SPLIT_INDEX for the test checking split index
3:  e60fa2dd9e < -:  ---------- split index: add a test to demonstrate the racy split index problem
-:  ---------- > 1:  a5b46af0ff split-index: add tests to demonstrate the racy split index problem
4:  799c9c7739 ! 2:  ed26c9703e t1700-split-index: date back files to avoid racy situations
    @@ -43,7 +43,7 @@
      
     +# Create a file named as $1 with content read from stdin.
     +# Set the file's mtime to a few seconds in the past to avoid racy situations.
    -+create_file () {
    ++create_non_racy_file () {
     +	cat >"$1" &&
     +	test-tool chmtime =-5 "$1"
     +}
    @@ -56,7 +56,7 @@
      
      test_expect_success 'add one file' '
     -	: >one &&
    -+	create_file one &&
    ++	create_non_racy_file one &&
      	git update-index --add one &&
      	git ls-files --stage >ls-files.actual &&
      	cat >ls-files.expect <<-EOF &&
    @@ -65,7 +65,7 @@
      
      test_expect_success 'modify original file, base index untouched' '
     -	echo modified >one &&
    -+	echo modified |create_file one &&
    ++	echo modified | create_non_racy_file one &&
      	git update-index one &&
      	git ls-files --stage >ls-files.actual &&
      	cat >ls-files.expect <<-EOF &&
    @@ -74,7 +74,7 @@
      
      test_expect_success 'add another file, which stays index' '
     -	: >two &&
    -+	create_file two &&
    ++	create_non_racy_file two &&
      	git update-index --add two &&
      	git ls-files --stage >ls-files.actual &&
      	cat >ls-files.expect <<-EOF &&
    @@ -83,7 +83,7 @@
      
      test_expect_success 'add original file back' '
     -	: >one &&
    -+	create_file one &&
    ++	create_non_racy_file one &&
      	git update-index --add one &&
      	git ls-files --stage >ls-files.actual &&
      	cat >ls-files.expect <<-EOF &&
    @@ -92,7 +92,7 @@
      
      test_expect_success 'add new file' '
     -	: >two &&
    -+	create_file two &&
    ++	create_non_racy_file two &&
      	git update-index --add two &&
      	git ls-files --stage >actual &&
      	cat >expect <<-EOF &&
    @@ -101,7 +101,7 @@
      test_expect_success 'set core.splitIndex config variable to true' '
      	git config core.splitIndex true &&
     -	: >three &&
    -+	create_file three &&
    ++	create_non_racy_file three &&
      	git update-index --add three &&
      	git ls-files --stage >ls-files.actual &&
      	cat >ls-files.expect <<-EOF &&
    @@ -113,7 +113,7 @@
     +test_expect_success 'set core.splitIndex config variable back to true' '
      	git config core.splitIndex true &&
     -	: >three &&
    -+	create_file three &&
    ++	create_non_racy_file three &&
      	git update-index --add three &&
      	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
      	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
    @@ -122,7 +122,7 @@
      	EOF
      	test_cmp expect actual &&
     -	: >four &&
    -+	create_file four &&
    ++	create_non_racy_file four &&
      	git update-index --add four &&
      	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
      	cat >expect <<-EOF &&
    @@ -131,7 +131,7 @@
      test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
      	git config --unset splitIndex.maxPercentChange &&
     -	: >five &&
    -+	create_file five &&
    ++	create_non_racy_file five &&
      	git update-index --add five &&
      	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
      	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
    @@ -140,7 +140,7 @@
      	EOF
      	test_cmp expect actual &&
     -	: >six &&
    -+	create_file six &&
    ++	create_non_racy_file six &&
      	git update-index --add six &&
      	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
      	cat >expect <<-EOF &&
    @@ -149,7 +149,7 @@
      test_expect_success 'check splitIndex.maxPercentChange set to 0' '
      	git config splitIndex.maxPercentChange 0 &&
     -	: >seven &&
    -+	create_file seven &&
    ++	create_non_racy_file seven &&
      	git update-index --add seven &&
      	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
      	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
    @@ -158,7 +158,7 @@
      	EOF
      	test_cmp expect actual &&
     -	: >eight &&
    -+	create_file eight &&
    ++	create_non_racy_file eight &&
      	git update-index --add eight &&
      	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
      	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
    @@ -167,19 +167,19 @@
      
      test_expect_success 'shared index files expire after 2 weeks by default' '
     -	: >ten &&
    -+	create_file ten &&
    ++	create_non_racy_file ten &&
      	git update-index --add ten &&
      	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
      	just_under_2_weeks_ago=$((5-14*86400)) &&
      	test-tool chmtime =$just_under_2_weeks_ago .git/sharedindex.* &&
     -	: >eleven &&
    -+	create_file eleven &&
    ++	create_non_racy_file eleven &&
      	git update-index --add eleven &&
      	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
      	just_over_2_weeks_ago=$((-1-14*86400)) &&
      	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
     -	: >twelve &&
    -+	create_file twelve &&
    ++	create_non_racy_file twelve &&
      	git update-index --add twelve &&
      	test $(ls .git/sharedindex.* | wc -l) -le 2
      '
    @@ -188,13 +188,13 @@
      	git config splitIndex.sharedIndexExpire "16.days.ago" &&
      	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
     -	: >thirteen &&
    -+	create_file thirteen &&
    ++	create_non_racy_file thirteen &&
      	git update-index --add thirteen &&
      	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
      	just_over_16_days_ago=$((-1-16*86400)) &&
      	test-tool chmtime =$just_over_16_days_ago .git/sharedindex.* &&
     -	: >fourteen &&
    -+	create_file fourteen &&
    ++	create_non_racy_file fourteen &&
      	git update-index --add fourteen &&
      	test $(ls .git/sharedindex.* | wc -l) -le 2
      '
    @@ -203,14 +203,14 @@
      	just_10_years_ago=$((-365*10*86400)) &&
      	test-tool chmtime =$just_10_years_ago .git/sharedindex.* &&
     -	: >fifteen &&
    -+	create_file fifteen &&
    ++	create_non_racy_file fifteen &&
      	git update-index --add fifteen &&
      	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
      	git config splitIndex.sharedIndexExpire now &&
      	just_1_second_ago=-1 &&
      	test-tool chmtime =$just_1_second_ago .git/sharedindex.* &&
     -	: >sixteen &&
    -+	create_file sixteen &&
    ++	create_non_racy_file sixteen &&
      	git update-index --add sixteen &&
      	test $(ls .git/sharedindex.* | wc -l) -le 2
      '
    @@ -219,7 +219,7 @@
      		git config core.sharedrepository "$mode" &&
      		git config core.splitIndex true &&
     -		: >one &&
    -+		create_file one &&
    ++		create_non_racy_file one &&
      		git update-index --add one &&
      		echo "$modebits" >expect &&
      		test_modebits .git/index >actual &&
-:  ---------- > 3:  899e5090d3 split-index: count the number of deleted entries
-:  ---------- > 4:  02646f1a1b split-index: don't compare stat data of entries already marked for split index
5:  38b5f0fe72 ! 5:  290ac26055 split-index: smudge and add racily clean cache entries to split index
    @@ -22,25 +22,29 @@
         them with smudged stat data, i.e. with file size set to 0.  When
         subsequent git commands read the index, they will notice that the
         smudged stat data doesn't match with the file in the worktree, and
    -    then go on to check the file's content.
    +    then go on to check the file's content and notice its dirtiness.
     
         In the above example, however, in the second 'git update-index'
    -    prepare_to_write_split_index() gathers all cache entries that should
    -    be written to the new split index.  Alas, this function never looks
    -    out for racily clean cache entries, and since the file's stat data in
    -    the worktree hasn't changed since the shared index was written, it
    -    won't be replaced in the new split index.  Consequently,
    -    do_write_index() doesn't even get this racily clean cache entry, and
    -    can't smudge its stat data.  Subsequent git commands will then see
    -    that the index has more recent mtime than the file and that the (not
    -    smudged) cached stat data still matches with the file in the worktree,
    -    and, ultimately, will erroneously consider the file clean.
    +    prepare_to_write_split_index() decides which cache entries stored only
    +    in the shared index should be replaced in the new split index.  Alas,
    +    this function never looks out for racily clean cache entries, and
    +    since the file's stat data in the worktree hasn't changed since the
    +    shared index was written, it won't be replaced in the new split index.
    +    Consequently, do_write_index() doesn't even get this racily clean
    +    cache entry, and can't smudge its stat data.  Subsequent git commands
    +    will then see that the index has more recent mtime than the file and
    +    that the (not smudged) cached stat data still matches with the file in
    +    the worktree, and, ultimately, will erroneously consider the file
    +    clean.
     
         Modify prepare_to_write_split_index() to recognize racily clean cache
    -    entries, and mark them to be added to the split index.  This way
    -    do_write_index() will get these racily clean cache entries as well,
    -    and will then write them with smudged stat data to the new split
    -    index.
    +    entries, and mark them to be added to the split index.  Note that
    +    there are two places where it should check raciness: first those cache
    +    entries that are only stored in the shared index, and then those that
    +    have been copied by unpack_trees() from the shared index while it
    +    constructed a new index.  This way do_write_index() will get these
    +    racily clean cache entries as well, and will then write them with
    +    smudged stat data to the new split index.
     
         Note that after this change if the index is split when it contains a
         racily clean cache entry, then a smudged cache entry will be written
    @@ -49,19 +53,19 @@
         an entry in the split index replacing an outdated entry in the shared
         index.  It did affect a few tests in 't1700-split-index.sh', though,
         because they actually check which entries are stored in the split
    -    index; the previous patch made the necessary adjustments.  And racily
    -    clean cache entries and index splitting are rare enough to not worry
    -    about the resulting duplicated smudged cache entries, and the
    -    additional complexity required to prevent them is not worth it.
    +    index; a previous patch in this series has already made the necessary
    +    adjustments in 't1700'.  And racily clean cache entries and index
    +    splitting are rare enough to not worry about the resulting duplicated
    +    smudged cache entries, and the additional complexity required to
    +    prevent them is not worth it.
     
         Several tests failed occasionally when the test suite was run with
         'GIT_TEST_SPLIT_INDEX=yes'.  Here are those that I managed to trace
         back to this racy split index problem, starting with those failing
         more frequently, with a link to a failing Travis CI build job for
    -    each.  The highlighted line shows when the racy file was written,
    -    which is not always in the failing test (but note that those lines are
    -    in the 'after failure' fold, and your browser might unhelpfully fold
    -    it up before you could take a good look).
    +    each.  The highlighted line [2] shows when the racy file was written,
    +    which is not always in the failing test but in a preceeding setup
    +    test.
     
           t3903-stash.sh:
             https://travis-ci.org/git/git/jobs/385542084#L5858
    @@ -75,7 +79,7 @@
           t2200-add-update.sh:
             https://travis-ci.org/git/git/jobs/382543426#L3051
     
    -      t0090-cache-tree:
    +      t0090-cache-tree.sh:
             https://travis-ci.org/git/git/jobs/416583010#L3679
     
         There might be others, e.g. perhaps 't1000-read-tree-m-3way.sh' and
    @@ -84,6 +88,10 @@
         [1] In the branch leading to the merge commit v2.1.0-rc0~45 (Merge
             branch 'nd/split-index', 2014-07-16).
     
    +    [2] Note that those highlighted lines are in the 'after failure' fold,
    +        and your browser might unhelpfully fold it up before you could
    +        take a good look.
    +
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      diff --git a/cache.h b/cache.h
    @@ -121,39 +129,94 @@
      			base = si->base->cache[ce->index - 1];
     -			if (ce == base)
     +			if (ce == base) {
    -+				/*
    -+				 * Racily clean cache entries must be
    -+				 * written to the split index, so the
    -+				 * subsequent do_write_index() can smudge
    -+				 * their stat data.
    -+				 */
    -+				if (!ce_uptodate(ce) &&
    -+				    is_racy_timestamp(istate, ce))
    ++				/* The entry is present in the shared index. */
    ++				if (ce->ce_flags & CE_UPDATE_IN_BASE) {
    ++					/*
    ++					 * Already marked for inclusion in
    ++					 * the split index, either because
    ++					 * the corresponding file was
    ++					 * modified and the cached stat data
    ++					 * was refreshed, or because there
    ++					 * is already a replacement entry in
    ++					 * the split index.
    ++					 * Nothing more to do here.
    ++					 */
    ++				} else if (!ce_uptodate(ce) &&
    ++					   is_racy_timestamp(istate, ce)) {
    ++					/*
    ++					 * A racily clean cache entry stored
    ++					 * only in the shared index: it must
    ++					 * be added to the split index, so
    ++					 * the subsequent do_write_index()
    ++					 * can smudge its stat data.
    ++					 */
     +					ce->ce_flags |= CE_UPDATE_IN_BASE;
    ++				} else {
    ++					/*
    ++					 * The entry is only present in the
    ++					 * shared index and it was not
    ++					 * refreshed.
    ++					 * Just leave it there.
    ++					 */
    ++				}
      				continue;
     +			}
      			if (ce->ce_namelen != base->ce_namelen ||
      			    strcmp(ce->name, base->name)) {
      				ce->index = 0;
    +@@
    + 				 * the split index.
    + 				 * Nothing to do.
    + 				 */
    ++			} else if (!ce_uptodate(ce) &&
    ++				   is_racy_timestamp(istate, ce)) {
    ++				/*
    ++				 * A copy of a racily clean cache entry from
    ++				 * the shared index.  It must be added to
    ++				 * the split index, so the subsequent
    ++				 * do_write_index() can smudge its stat data.
    ++				 */
    ++				ce->ce_flags |= CE_UPDATE_IN_BASE;
    + 			} else {
    + 				/*
    + 				 * Thoroughly compare the cached data to see
     
      diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
      --- a/t/t1701-racy-split-index.sh
      +++ b/t/t1701-racy-split-index.sh
     @@
      
    - for trial in 0 1 2 3 4
    + for trial in $trials
      do
    --	test_expect_failure "update the split index when the shared index contains a racily clean cache entry #$trial" '
    -+	test_expect_success "update the split index when the shared index contains a racily clean cache entry #$trial" '
    - 		test_when_finished "rm -f .git/index .git/sharedindex.*" &&
    +-	test_expect_failure "update the split index when a racily clean cache entry is stored only in the shared index $trial" '
    ++	test_expect_success "update the split index when a racily clean cache entry is stored only in the shared index #$trial" '
    + 		rm -f .git/index .git/sharedindex.* &&
      
      		# The next three commands must be run within the same
     @@
    - 		# corresponding replacement cache entry with smudged
    - 		# stat data should be added to the new split index, so
    - 		# the file wont appear clean for subsequent git commands.
    + 		# entry of racy-file is only stored in the shared index.
    + 		# A corresponding replacement cache entry with smudged
    + 		# stat data should be added to the new split index.
     -		#
     -		# Alas, such a smudged replacement entry is not added!
      		git update-index --add other-file &&
      
    - 		check_cached_diff
    + 		# Subsequent git commands should notice the smudged
    +@@
    + 
    + for trial in $trials
    + do
    +-	test_expect_failure "update the split index after unpack trees() copied a racily clean cache entry from the shared index $trial" '
    ++	test_expect_success "update the split index after unpack trees() copied a racily clean cache entry from the shared index #$trial" '
    + 		rm -f .git/index .git/sharedindex.* &&
    + 
    + 		# The next three commands must be run within the same
    +@@
    + 		# index.  A corresponding replacement cache entry
    + 		# with smudged stat data should be added to the new
    + 		# split index.
    +-		#
    +-		# Alas, such a smudged replacement entry is not added!
    + 		git read-tree -m HEAD &&
    + 
    + 		# Subsequent git commands should notice the smudged
-- 
2.19.0.361.gafc87ffe72

