Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8EAC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhLNLsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhLNLsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDBDC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:47:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so13565065wms.3
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CKAQqGlcfYdHKQnvmpVGJkWBi/JUbxBaZU+tbtzll4g=;
        b=mpfopkNu5bBgbHTBK8YVuhTbqtG/Lu089qVYPSO4GZTKF8V4VTyg/1vs7A9ZeXBEt+
         Irz5jwvDSpBpAct1gW5yApWY9ub0r5N+1UulWCYpX9GslvGY+2XqVfUpWBeQBUuNiXT7
         7ChNJ/rvXUdgmNxmi9gkqBGvjzY9u1TREQHxEgedOechGg47w1P2pSVrW75bxATLAxPt
         T4uV+1SKZ3neUSQaIb5sUVwiXAmkF5o8PMcICMvx5sV5nToQjzKefxuskBiej023jWEt
         mGJR+6lL8i8wKmwNFe+rnqAU7BQjB+BsriFoHRmYBKVzHbRQXEEPAsS5dOoJth5CVwZb
         5wSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CKAQqGlcfYdHKQnvmpVGJkWBi/JUbxBaZU+tbtzll4g=;
        b=0S4bK9P9cYi3rxAzR0jLV/JPCnf4a6jULrRuD5iDpc4HhEkD/Jn26dZwFGbQdrysrM
         eIx7JdntpXlaF3OfCRLSmMnzgLhm5wZkZk1xouHrVsOW1jRjUP4tKo3a5MGFA54ynm6e
         JIr6LZH49CfFtSKc2MMYMKbARspRI7iSXj1TlvB6EkN1hCvIH1nseHjqQFrSP5+bzrTz
         yL3Xa32hU5V5r8kA6fmqBDpApV0lu3mNet8XZuGA+QKCqPVI1m0vs6/qbWx65Nubg0Vb
         0Wxa5Ad0011iy9/0HH6A/t3pfcpsdf41BerpPPq6u1c+0lLG/pDaJpeGyTLXhvi3nO0/
         HLgg==
X-Gm-Message-State: AOAM5306Z+JsGOQxgiF1mh2eOt07FUklmu1YBMFcnJXKOw4g0DoZEwD+
        JKHH3jwTXFvE4rASnKoD8lEcEsDlwhM=
X-Google-Smtp-Source: ABdhPJyi3E1NfB3iZ3dohcXu8kLTCQc0x/ltlU3Wunh88WABoaUA+fBCn3usijFVe3mXVLhLOu7dYA==
X-Received: by 2002:a1c:4b07:: with SMTP id y7mr6286263wma.188.1639482478092;
        Tue, 14 Dec 2021 03:47:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm13415829wru.41.2021.12.14.03.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:47:57 -0800 (PST)
Message-Id: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:45 +0000
Subject: [PATCH v4 00/11] Reftable coverity fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series was targeted to 'next'.

This addresses some complaints from Coverity that Peff reported.

v3:

 * revert some changes suggested by stolee
 * add unittest for zlib corruption.

Han-Wen Nienhuys (11):
  reftable: fix OOB stack write in print functions
  reftable: fix resource leak in block.c error path
  reftable: fix resource leak blocksource.c
  reftable: check reftable_stack_auto_compact() return value
  reftable: ignore remove() return value in stack_test.c
  reftable: fix resource warning
  reftable: all xxx_free() functions accept NULL arguments
  reftable: order unittests by complexity
  reftable: drop stray printf in readwrite_test
  reftable: handle null refnames in reftable_ref_record_equal
  reftable: make reftable_record a tagged union

 reftable/block.c          |  28 +++---
 reftable/block_test.c     |  22 ++---
 reftable/blocksource.c    |   6 +-
 reftable/generic.c        |  35 ++++----
 reftable/iter.c           |   4 +-
 reftable/merged.c         |  33 +++----
 reftable/pq.c             |   3 +-
 reftable/pq_test.c        |  31 +++----
 reftable/reader.c         |  95 ++++++++++----------
 reftable/readwrite_test.c |  67 +++++++++++++-
 reftable/record.c         | 185 ++++++++++++++++----------------------
 reftable/record.h         |  42 ++++-----
 reftable/record_test.c    | 181 +++++++++++++++++++------------------
 reftable/stack.c          |  12 +--
 reftable/stack_test.c     |   3 +-
 reftable/writer.c         |  42 +++++----
 t/helper/test-reftable.c  |   9 +-
 17 files changed, 428 insertions(+), 370 deletions(-)


base-commit: fae76fe5da3df25d752f2251b7ccda3f62813aa9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1152%2Fhanwen%2Freftable-coverity-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1152/hanwen/reftable-coverity-v4
Pull-Request: https://github.com/git/git/pull/1152

Range-diff vs v3:

  1:  1c1a3ff92bd =  1:  1c1a3ff92bd reftable: fix OOB stack write in print functions
  2:  975a570d388 !  2:  923293b79b4 reftable: fix resource leak in error path
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    reftable: fix resource leak in error path
     +    reftable: fix resource leak in block.c error path
      
          Add test coverage for corrupt zlib data.
      
     @@ reftable/block.c: int block_reader_init(struct block_reader *br, struct reftable
       
      -	return 0;
      +done:
     -+	if (uncompressed) {
     -+		reftable_free(uncompressed);
     -+	}
     ++	reftable_free(uncompressed);
      +	return err;
       }
       
     @@ reftable/readwrite_test.c: static void test_log_write_read(void)
      +	struct reftable_write_options opts = {
      +		.block_size = 256,
      +	};
     -+	struct reftable_iterator it = { NULL };
     -+	struct reftable_reader rd = { NULL };
     -+	struct reftable_block_source source = { NULL };
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_reader rd = { 0 };
     ++	struct reftable_block_source source = { 0 };
      +	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
     @@ reftable/readwrite_test.c: static void test_log_write_read(void)
      +		},
      +	};
      +
     -+	for (i = 0; i < sizeof(message)-1; i++) {
     ++	for (i = 0; i < sizeof(message)-1; i++)
      +		message[i] = (uint8_t)(rand() % 64 + ' ');
     -+	}
      +
      +	reftable_writer_set_limits(w, 1, 1);
      +
  3:  0b9c7176d71 =  3:  7a914f77756 reftable: fix resource leak blocksource.c
  4:  1dda4ee717f =  4:  51b4a17a2e1 reftable: check reftable_stack_auto_compact() return value
  5:  36858e2070b =  5:  43989afcb5a reftable: ignore remove() return value in stack_test.c
  6:  80b1988b885 =  6:  1c7f15d811c reftable: fix resource warning
  7:  2939286924c <  -:  ----------- reftable: fix NULL derefs in error paths
  -:  ----------- >  7:  47ba5ddceb8 reftable: all xxx_free() functions accept NULL arguments
  8:  9dce18d7349 !  8:  aba8b8113ad reftable: order unittests by complexity
     @@ Metadata
       ## Commit message ##
          reftable: order unittests by complexity
      
     -    This is a more pratical ordering when working on refactorings of the reftable
     +    This is a more practical ordering when working on refactorings of the reftable
          code.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     @@ t/helper/test-reftable.c
       
       int cmd__reftable(int argc, const char **argv)
       {
     -+	// test from simple to complex.
     ++	/* test from simple to complex. */
       	basics_test_main(argc, argv);
      +	record_test_main(argc, argv);
       	block_test_main(argc, argv);
  9:  6b0af68f0b9 =  9:  f2af404d7f1 reftable: drop stray printf in readwrite_test
 10:  bff85cb0809 = 10:  d2ce1bfef9f reftable: handle null refnames in reftable_ref_record_equal
 11:  b3e592b9c27 = 11:  0ffc1cf0e42 reftable: make reftable_record a tagged union

-- 
gitgitgadget
