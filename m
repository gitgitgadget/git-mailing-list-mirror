Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A453A1F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfKHJoC (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32850 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbfKHJoC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so3809466plb.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7D+iyRDgVNfDZ+uS22GPjeko+ozAvsMJAkSciGSgp8=;
        b=GKbvGzgkAo1nDNQXJjdV7VsHD5/7jVLs90L89I+Gdp6iN3f/Y6m4VQYl2t2oismXXI
         MDgxGDcs9WfdjikLJQ8IN5BOtosyLmfEQnoIg0hLPQ6NEpcuHdXUmhD65XKVO7ulLg+d
         PKHG/16aLV1z+ybJW8aNDXqY9AwHzs5hsjULF88EnWwL3rP5aniuWC7LVWosS92BNok5
         Lz3MlFu9QH0HYAyZb9usfw9IWmIoH9JOEmaTyu3m3aRm862aVZcdKL5oAhM+OLnZAQzN
         UyPcl2FXfvuAmyABZBJcGem7pCN3xeki1ersSB6YH3tfTlrBSj/lZu15FgN0c+RBK3uC
         li1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7D+iyRDgVNfDZ+uS22GPjeko+ozAvsMJAkSciGSgp8=;
        b=M6gt8ewzhmELWd+EyG8gCF9M5LayhQUNS2pqdhzYnxKS6TYvLL2vXwzGWE1R4TEcpS
         PVwmRi5ZOnP/YiprRMrmLF7+7AgUk5vmlcB6jUsTk+fOJlHkL06D+wz7rLpRpwNz5mJ3
         dBmu3EUJPzLl8XjOLUVGXkHK7NGXI5GafVdHpKM/58K4Xj/qkSSiaZE96HaTPhp0+RTE
         1+b1H+BjR8p/mootGrT1UUTEVCVTzN74p53zGgBa8eUCNOyEX2mBM0bAgjeXzj855ol+
         OoOIlm8DUieYlzTX7eZ/rra6Hbxz/D2uC9/IWT+nqrFi3y62BdG9XMp47Y/THN0XW/rU
         IyLQ==
X-Gm-Message-State: APjAAAXNoHwmZZuBqqNM4GhkC6kp5qF+GqK/oOsTfKcvTJARQi1PbY1C
        AlNQ9z8XRIBKYCdFBhdT7tewKDIe
X-Google-Smtp-Source: APXvYqwggegRvntRTa4LzajIg+j7AWQde/TbZ9ePe9b34874I+CRTlWnZ+46XFqr5kXnxhkJhbivww==
X-Received: by 2002:a17:90a:3390:: with SMTP id n16mr11620135pjb.53.1573206240432;
        Fri, 08 Nov 2019 01:44:00 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:43:59 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 0/9] Improve odd encoding integration
Date:   Fri,  8 Nov 2019 16:43:42 +0700
Message-Id: <cover.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <20191031092618.29073-1-congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The series is shifting from fixing test that failed on musl based Linux to
correct the internal working encoding and output encoding of git-am
git-cherry-pick git-rebase and git-revert.

Change from v4:
- Update commit message per review
- Add test for last 2 patches
- Notice a breakage with git rebase --rebase-merges (see patch 7)


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
 t/t3433-rebase-i18n.sh           |  84 +++++++++++++++++++++++++++++++
 t/t3433/ISO8859-1.txt            | Bin 0 -> 15 bytes
 t/t3433/eucJP.txt                | Bin 0 -> 68 bytes
 t/t3900-i18n-commit.sh           |  37 ++++++++++++++
 7 files changed, 195 insertions(+), 11 deletions(-)
 create mode 100755 t/t3433-rebase-i18n.sh
 create mode 100644 t/t3433/ISO8859-1.txt
 create mode 100644 t/t3433/eucJP.txt

Range-diff against v4:
 1:  daa0c27d28 =  1:  b3d6c4e720 t0028: eliminate non-standard usage of printf
 2:  c50964f413 !  2:  fe63a6bc44 configure.ac: define ICONV_OMITS_BOM if necessary
    @@ Commit message
     
             make ICONV_OMITS_BOM=Yes
     
    -    However, typing the flag all the time is cumbersome and error-prone.
    +    However, configure script wasn't taught to detect those systems.
     
    -    Add a check into configure script to detect this flag automatically.
    +    Teach configure to do so.
     
         Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
 3:  47888f236c !  3:  30f15075c4 t3900: demonstrate git-rebase problem with multi encoding
    @@ t/t3900-i18n-commit.sh: test_commit_autosquash_flags eucJP fixup
     +	new=$3
     +	msg=$4
     +	test_expect_failure "commit --$flag into $old from $new" '
    -+		git checkout -b '$flag-$old-$new' C0 &&
    -+		git config i18n.commitencoding '$old' &&
    -+		echo '$old' >>F &&
    -+		git commit -a -F "$TEST_DIRECTORY/t3900/'$msg'" &&
    ++		git checkout -b $flag-$old-$new C0 &&
    ++		git config i18n.commitencoding $old &&
    ++		echo $old >>F &&
    ++		git commit -a -F "$TEST_DIRECTORY"/t3900/$msg &&
     +		test_tick &&
     +		echo intermediate stuff >>G &&
     +		git add G &&
     +		git commit -a -m "intermediate commit" &&
     +		test_tick &&
    -+		git config i18n.commitencoding '$new' &&
    -+		echo '$new-$flag' >>F &&
    -+		git commit -a --'$flag' HEAD^ &&
    ++		git config i18n.commitencoding $new &&
    ++		echo $new-$flag >>F &&
    ++		git commit -a --$flag HEAD^ &&
     +		git rebase --autosquash -i HEAD^^^ &&
     +		git rev-list HEAD >actual &&
     +		test_line_count = 3 actual
 4:  42115f1e33 !  4:  17165b81e5 sequencer: reencode to utf-8 before arrange rebase's todo list
    @@ Commit message
         Thus, t3900::test_commit_autosquash_flags is failing on musl libc.
     
         Reencode to utf-8 before arranging rebase's todo list.
    -    By doing this, we also remove a breakage introduced in the previous
    -    commit.
    +
    +    By doing this, we also remove a breakage noticed by a test added in the
    +    previous commit.
     
         Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
    @@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
      	msg=$4
     -	test_expect_failure "commit --$flag into $old from $new" '
     +	test_expect_success "commit --$flag into $old from $new" '
    - 		git checkout -b '$flag-$old-$new' C0 &&
    - 		git config i18n.commitencoding '$old' &&
    - 		echo '$old' >>F &&
    + 		git checkout -b $flag-$old-$new C0 &&
    + 		git config i18n.commitencoding $old &&
    + 		echo $old >>F &&
 5:  5a871d7226 =  5:  40fa759492 sequencer: reencode revert/cherry-pick's todo list
 6:  1c6194a598 !  6:  ed6cfab5d2 sequencer: reencode squashing commit's message
    @@ sequencer.c: static int commit_staged_changes(struct repository *r,
     
      ## t/t3900-i18n-commit.sh ##
     @@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
    - 	old=$2
    - 	new=$3
    - 	msg=$4
    -+	squash_msg=
    -+	if test $flag = squash; then
    -+		squash_msg='
    -+		subject="squash! $(head -1 expect)" &&
    -+		printf "\n%s\n" "$subject" >> expect &&
    -+		'
    -+	fi
    - 	test_expect_success "commit --$flag into $old from $new" '
    - 		git checkout -b '$flag-$old-$new' C0 &&
    - 		git config i18n.commitencoding '$old' &&
    -@@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
    - 		git commit -a --'$flag' HEAD^ &&
    + 		git commit -a --$flag HEAD^ &&
      		git rebase --autosquash -i HEAD^^^ &&
      		git rev-list HEAD >actual &&
     -		test_line_count = 3 actual
     +		test_line_count = 3 actual &&
    -+		iconv -f '$old' -t utf-8 "$TEST_DIRECTORY/t3900/'$msg'" >expect &&
    -+		'"$squash_msg"'
    ++		iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
    ++		if test $flag = squash; then
    ++			subject="$(head -1 expect)" &&
    ++			printf "\nsquash! %s\n" "$subject" >>expect
    ++		fi &&
     +		git cat-file commit HEAD^ >raw &&
    -+		(sed "1,/^$/d" raw | iconv -f '$new' -t utf-8) >actual &&
    ++		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
     +		test_cmp expect actual
      	'
      }
 7:  95df3cdadf <  -:  ---------- sequencer: reencode old merge-commit message
 8:  0606b2408d <  -:  ---------- sequencer: reencode commit message for am/rebase --show-current-patch
 -:  ---------- >  7:  def9adf97e sequencer: reencode old merge-commit message
 -:  ---------- >  8:  2e95ca57d2 sequencer: reencode commit message for am/rebase --show-current-patch
 -:  ---------- >  9:  860dee65f4 sequencer: fallback to sane label in making rebase todo list
-- 
2.24.0.8.g2e95ca57d2.dirty

