Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC5B1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKKGEI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38039 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKGEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so9937811pfp.5
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9a8G5kz9cJ3FZX9IWgVC3DJC0TEcv81RP7d+j//JFU=;
        b=E9pKhLGXdrbZV4+W4CiUheW5KWr6YYF80BSxDgLIJruySx/KWJJnfeOdQuphP88pPC
         d7cEsfAEJHaIAGep/2UZ1JpBFQ57nzN5Pya+RyUhED2MdsaIdR20F6toLpfOQHtnhWI0
         glNDJMhmz/hIsRwTH1XTmHlncujN5VWZzgBw3RX+McZ7Pgn7R3U2wbOk6ld1C2IOZwO3
         KoZE5RjQBv0i2p2JDkZ8PubjdfIILOvbuZ5Fc0wM1F3poSzGhQl/56Iubu0ZTNLDejmr
         laUwCjaPcXXMYOUgGDSH8U5/j7KBi8eD2PKlsyqWhUC269bv3bM9hwEw/17MEEjlasRq
         Hewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9a8G5kz9cJ3FZX9IWgVC3DJC0TEcv81RP7d+j//JFU=;
        b=mmYFbxn8CIThIbdhf51YFgBsI9iesi2y8PB0Nkdn9jWO+qg0qhxbHXUP/5GoXYi51k
         nFoKh86HMhGyZVzFcrLCwdOFkvSHdOYeDUkcHw1ZHLODjkj/lIJ99SOkANFZNuUUKZ8g
         4TjTEWNxUtu1/LSBKulROOGhaT3JrlkgUdwjEAT6EovOAF/ZicOmstAI3fvkFrdsNC6G
         UJWcu73iq1buhBD09OsMBXs3k43tm+MCAF0UDgsoxF3sDmdaAt37c4tTJ1aF+aQXFmWm
         eefxZF3u2Rw0mIHEp5wd4Rkndvd6O1NN6I6gXaBJpgKJhjQTR7lGftUnj5TefqsbkgXu
         DeLw==
X-Gm-Message-State: APjAAAWTCQOAbvQ/iLkMwKb7xC6JqG4w8Uu24oH56ePdPh4bH5wsAEzg
        tLLUe7MMvvCFDRSQb5Jw3oQSc9cm
X-Google-Smtp-Source: APXvYqzr2o0R/krujtnZi5ChkegR2qbgxjI2mMJDTGXMB/QorRFdLjbWqZj7SRCmhe4fhjgMeLZfyw==
X-Received: by 2002:a62:e308:: with SMTP id g8mr28313128pfh.121.1573452246793;
        Sun, 10 Nov 2019 22:04:06 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:05 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 0/9] sequencer: handle other encoding better
Date:   Mon, 11 Nov 2019 13:03:33 +0700
Message-Id: <cover.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <20191031092618.29073-1-congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change from v5:
- claim t3434 instead of t3433

Doan Tran Cong Danh (9):
  t0028: eliminate non-standard usage of printf
  configure.ac: define ICONV_OMITS_BOM if necessary
  t3900: demonstrate git-rebase problem with multi encoding
  sequencer: reencode to utf-8 before arrange rebase's todo list
  sequencer: reencode revert/cherry-pick's todo list
  sequencer: reencode squashing commit's message
  sequencer: reencode old merge-commit message
  sequencer: reencode commit message for am/rebase --show-current-patch
  sequencer: fallback to sane label in making rebase todo list

 configure.ac                     |  49 ++++++++++++++++++
 sequencer.c                      |  32 ++++++++----
 t/t0028-working-tree-encoding.sh |   4 +-
 t/t3434-rebase-i18n.sh           |  84 +++++++++++++++++++++++++++++++
 t/t3434/ISO8859-1.txt            | Bin 0 -> 15 bytes
 t/t3434/eucJP.txt                | Bin 0 -> 68 bytes
 t/t3900-i18n-commit.sh           |  37 ++++++++++++++
 7 files changed, 195 insertions(+), 11 deletions(-)
 create mode 100755 t/t3434-rebase-i18n.sh
 create mode 100644 t/t3434/ISO8859-1.txt
 create mode 100644 t/t3434/eucJP.txt

Range-diff against v5:
 1:  b3d6c4e720 =  1:  9f83d4533b t0028: eliminate non-standard usage of printf
 2:  fe63a6bc44 =  2:  a9adb3d061 configure.ac: define ICONV_OMITS_BOM if necessary
 3:  30f15075c4 =  3:  c41046e717 t3900: demonstrate git-rebase problem with multi encoding
 4:  17165b81e5 =  4:  0ab92e7999 sequencer: reencode to utf-8 before arrange rebase's todo list
 5:  40fa759492 =  5:  23f9de4527 sequencer: reencode revert/cherry-pick's todo list
 6:  ed6cfab5d2 =  6:  f04a9d1698 sequencer: reencode squashing commit's message
 7:  def9adf97e !  7:  4dfdd4b83e sequencer: reencode old merge-commit message
    @@ sequencer.c: static int do_merge(struct repository *r,
      		int len;
      
     
    - ## t/t3433-rebase-i18n.sh (new) ##
    + ## t/t3434-rebase-i18n.sh (new) ##
     @@
     +#!/bin/sh
     +#
    @@ t/t3433-rebase-i18n.sh (new)
     +. ./test-lib.sh
     +
     +compare_msg () {
    -+	iconv -f "$2" -t "$3" "$TEST_DIRECTORY/t3433/$1" >expect &&
    ++	iconv -f "$2" -t "$3" "$TEST_DIRECTORY/t3434/$1" >expect &&
     +	git cat-file commit HEAD >raw &&
     +	sed "1,/^$/d" raw >actual &&
     +	test_cmp expect actual
    @@ t/t3433-rebase-i18n.sh (new)
     +test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
     +	git switch -c merge-eucJP-UTF-8 first &&
     +	git config i18n.commitencoding eucJP &&
    -+	git merge -F "$TEST_DIRECTORY/t3433/eucJP.txt" second &&
    ++	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
     +	git config i18n.commitencoding UTF-8 &&
     +	git rebase --rebase-merges master &&
     +	compare_msg eucJP.txt eucJP UTF-8
    @@ t/t3433-rebase-i18n.sh (new)
     +test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
     +	git switch -c merge-eucJP-ISO-2022-JP first &&
     +	git config i18n.commitencoding eucJP &&
    -+	git merge -F "$TEST_DIRECTORY/t3433/eucJP.txt" second &&
    ++	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
     +	git config i18n.commitencoding ISO-2022-JP &&
     +	git rebase --rebase-merges master &&
     +	compare_msg eucJP.txt eucJP ISO-2022-JP
    @@ t/t3433-rebase-i18n.sh (new)
     +
     +test_done
     
    - ## t/t3433/eucJP.txt (new) ##
    - Binary files /dev/null and t/t3433/eucJP.txt differ
    + ## t/t3434/eucJP.txt (new) ##
    + Binary files /dev/null and t/t3434/eucJP.txt differ
 8:  2e95ca57d2 !  8:  28e82d6394 sequencer: reencode commit message for am/rebase --show-current-patch
    @@ sequencer.c: static int make_patch(struct repository *r,
      		res |= write_message(subject, strlen(subject), buf.buf, 1);
      		unuse_commit_buffer(commit, commit_buffer);
     
    - ## t/t3433-rebase-i18n.sh ##
    -@@ t/t3433-rebase-i18n.sh: test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP
    + ## t/t3434-rebase-i18n.sh ##
    +@@ t/t3434-rebase-i18n.sh: test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP
      	compare_msg eucJP.txt eucJP ISO-2022-JP
      '
      
    @@ t/t3433-rebase-i18n.sh: test_expect_failure 'rebase --rebase-merges update encod
     +		echo for-conflict >two.t &&
     +		git add two.t &&
     +		git config i18n.commitencoding $old &&
    -+		git commit -F "$TEST_DIRECTORY/t3433/$msgfile" &&
    ++		git commit -F "$TEST_DIRECTORY/t3434/$msgfile" &&
     +		git config i18n.commitencoding $new &&
     +		test_must_fail git rebase -m master &&
     +		test -f .git/rebase-merge/message &&
    @@ t/t3433-rebase-i18n.sh: test_expect_failure 'rebase --rebase-merges update encod
     +
      test_done
     
    - ## t/t3433/ISO8859-1.txt (new) ##
    - Binary files /dev/null and t/t3433/ISO8859-1.txt differ
    + ## t/t3434/ISO8859-1.txt (new) ##
    + Binary files /dev/null and t/t3434/ISO8859-1.txt differ
 9:  860dee65f4 !  9:  78daf050de sequencer: fallback to sane label in making rebase todo list
    @@ sequencer.c: static int make_script_with_merges(struct pretty_print_context *pp,
      		/* label the tips of merged branches */
      		for (; to_merge; to_merge = to_merge->next) {
     
    - ## t/t3433-rebase-i18n.sh ##
    -@@ t/t3433-rebase-i18n.sh: test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
    + ## t/t3434-rebase-i18n.sh ##
    +@@ t/t3434-rebase-i18n.sh: test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
      	compare_msg eucJP.txt eucJP UTF-8
      '
      
    @@ t/t3433-rebase-i18n.sh: test_expect_success 'rebase --rebase-merges update encod
     +test_expect_success 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
      	git switch -c merge-eucJP-ISO-2022-JP first &&
      	git config i18n.commitencoding eucJP &&
    - 	git merge -F "$TEST_DIRECTORY/t3433/eucJP.txt" second &&
    + 	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
-- 
2.24.0.164.g78daf050de.dirty

