Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCFCC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376953AbiFPNN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376947AbiFPNN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:13:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB73917A
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c21so1853210wrb.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WJk6WpJm9twMGGM9yT6vKEqpb2pBiIBJq9nE/+PKYLc=;
        b=oa4RgMRXpONHEqZTtATfIBLXJP6kEfTe1lhyNyhuQDeTz8njtdjD/GgwniWeqKav2f
         0iFD4X3OS54ekXtuRJNixVBP/F0O9MUlASkn7eW4E0edAwh1eUk/pwk8vhkbPzD+GKCo
         CK/zFmPfQ+up1gKIbNlHs6SRFEM1G3AHikbR4amPg0QD4KT9ugHDsu+lpb6JmRv1roiD
         JpGsCxAvYQ0Ij4AIlAXhPno5Pd/oQ4HnMPiONZoneUUCEHyGSQWba89vn86uBKrb9IE2
         I/GwLEGl8AAO76fo1KEYoZN2mNDRlPI3xPxkCWumeJagg6yroUCYIjFNBIrUh7iopNRE
         BhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WJk6WpJm9twMGGM9yT6vKEqpb2pBiIBJq9nE/+PKYLc=;
        b=Ce29dGWFopuUeOnJ+pzmMdH+1rWFz2KBUaRXxk2/MkVoQS3eM3xE9xub7juLrfN+FT
         RsQ1QKtWMl1/+kUd2hAW85L3F4qeWceuEIvNUaGSecX1G6E1/A8D32WD57x6q83eWr9Y
         2Hwj/KX1jKDWleK4TCi3qmnbBv9a5TioqY4kYMnwaunBGUUhmEZ5fDC9zZTqawH6JcdO
         JkKSdQFgV8YdcCAj/v42PzUVdUXQfCLek394AF5Ud8CWCWwF+IiWoOXGtYMDZppOAOBm
         jwwE3EQ6AVdC65U8KbMQT2WmdDRWKK1S0FtlVvMJT9n/ZSGLwn9ElzoZTCy1Ulv2uqXi
         xN/w==
X-Gm-Message-State: AJIora+S+QTBpR51qNtS8jeIsPsBlVzSgb8H/eZol5Ckjs3NJaQTAEBh
        +QiwRcr4/axHv3QsfYg72LMQdwkDgC0BPw==
X-Google-Smtp-Source: AGRyM1tc/ZGat1ZB2dd7yBTpGR8KlVKX8fcpZuAjs0ZW0ZJRUdZPxsrT71hgdMt4ovtWInYMjFp4Pg==
X-Received: by 2002:a05:6000:18a8:b0:212:ae71:a3f6 with SMTP id b8-20020a05600018a800b00212ae71a3f6mr4528232wri.635.1655385231516;
        Thu, 16 Jun 2022 06:13:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b0039c8d181ac6sm6542254wmq.26.2022.06.16.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:13:50 -0700 (PDT)
Message-Id: <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 13:13:46 +0000
Subject: [PATCH v2 0/4] Reactions to v2.37.0-rc0 test coverage report
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add test coverage or simplify code based on discoveries in the
test coverage report (specifically, some that I highlighted at [1]).

[1]
https://lore.kernel.org/git/3d1c6dfd-1df6-3393-df5e-692719375772@github.com/

 1. Add tests for 'git update-index --verbose'.
 2. Add 'git gc --cruft' without '--prune=now' to test.
 3. Drop an always-NULL parameter from an internal method.
 4. Revert 080ab56a4 (cache-tree: implement cache_tree_find_path(),
    2022-05-23).

Any subset of these could be taken (or dropped), but I thought they would be
worth considering.


Updates in v2
=============

 * A useless addition of --verbose was removed from a test in patch 1.
 * Comments are updated in patch 2 based on Taylor's recommendations.
 * Added --prune="01-01-1980" to exercise the --cruft-expiration logic
   underneath 'git gc --cruft'.

Thanks, -Stolee

Derrick Stolee (4):
  t2107: test 'git update-index --verbose'
  t5329: test 'git gc --cruft' without '--prune=now'
  pack-write: drop always-NULL parameter
  cache-tree: remove cache_tree_find_path()

 cache-tree.c                  | 27 ---------------------------
 cache-tree.h                  |  2 --
 pack-write.c                  | 17 ++++++-----------
 t/t2107-update-index-basic.sh | 31 +++++++++++++++++++++++++------
 t/t5329-pack-objects-cruft.sh |  4 +++-
 5 files changed, 34 insertions(+), 47 deletions(-)


base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1261%2Fderrickstolee%2Ftest-coverage-response-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1261/derrickstolee/test-coverage-response-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1261

Range-diff vs v1:

 1:  c6803df1b6a ! 1:  c22963b49e6 t2107: test 'git update-index --verbose'
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## t/t2106-update-index-assume-unchanged.sh ##
     -@@ t/t2106-update-index-assume-unchanged.sh: test_expect_success 'do not switch branches with dirty file' '
     - 	git reset --hard &&
     - 	git checkout other &&
     - 	echo dirt >file &&
     --	git update-index --assume-unchanged file &&
     -+	git update-index --verbose --assume-unchanged file &&
     - 	test_must_fail git checkout - 2>err &&
     - 	test_i18ngrep overwritten err
     - '
     -
       ## t/t2107-update-index-basic.sh ##
      @@ t/t2107-update-index-basic.sh: test_expect_success '--cacheinfo does not accept blob null sha1' '
       	echo content >file &&
 2:  f59a0c326a0 ! 2:  ca5dbc29e40 t5329: test 'git gc --cruft' without '--prune=now'
     @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'expiring cruft objects with
       		comm -13 reachable objects >unreachable &&
       
      -		git repack --cruft -d &&
     -+		# Write a cruft pack instead of deleting files.
     -+		git gc --cruft &&
     ++		# Write a cruft pack containing all unreachable objects.
     ++		git gc --cruft --prune="01-01-1980" &&
       
       		mtimes=$(ls .git/objects/pack/pack-*.mtimes) &&
       		test_path_is_file $mtimes &&
       
     -+		# Ignore the cruft pack and delete every unreachable object.
     ++		# Prune all unreachable objects from the cruft pack.
       		git gc --cruft --prune=now &&
       
       		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
 3:  b67e110bf60 = 3:  b956a371c70 pack-write: drop always-NULL parameter
 4:  81d8e2b5fdd = 4:  8486a1d6eca cache-tree: remove cache_tree_find_path()

-- 
gitgitgadget
