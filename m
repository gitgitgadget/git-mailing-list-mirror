Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BFC1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 12:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeJaVkN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 17:40:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41645 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeJaVkN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 17:40:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so16319345wrw.8
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWxN+Qb7vi7+ywabYzgcNXua3wCZK4R6DupD7KoOI7A=;
        b=DGOtgNT4Db3tjOSFbXnFk6cDxyE4uCpxmWUxsh72ox4Ea4MIHICwwng+cN68DddFjl
         M9dhkLBg0GEzJPq5mMOZ2tXSViLeHT17x1WMd5GOp/7xz+yS4c205ZG8u5NhPeif/Hl7
         DhJQ2shtMbeaDlAWrzFbyBkKJMndK0/Ajj5F7phOPt7AzOaKg+T9Aq1Uu9TdZQXX2S7k
         Pxs7B6JIFOv5NyoCJvMao+GFdDEVK6oOeRU5Fzc971LqHEnEBeC7GDbXxLpDf6wl01fG
         XSmN/qEusEze5XuyRbUZe06dZPGijzZYC7pkuOXl2NN6TIlm4zRcqlb4c5SaMsyDmEUt
         wxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWxN+Qb7vi7+ywabYzgcNXua3wCZK4R6DupD7KoOI7A=;
        b=WgQFnJ0enrz+qV5u/ITAokjePP5secT4kGS71oFVMrXk/RgsNBrhpFWRopTj4OQF1r
         vMuX9TvTb6K1Oan5AEL8Gf4D92k7E/moihhMg6bx11LIiN/r3oj64CIjA1YiHcqRmLpB
         o8GbkE92GDzo4ZqxZDvvbo0qi1Mxe6ZJbgZ912fFTh4a3Mqt2j+zoS5fTMz9jOKQtyqz
         aCYq5hKNNmNkvkS+coyw31RTQRRfLqggfwAL/NNFwqwfumqXfa57xB476bR41vJUaAPV
         q3JP+GkC6kWqlBGgfNQwjf3P37MgCC+4lF6JjL+gcltvbAyJCBaa5/v5wkh7H9YQnZfG
         ismg==
X-Gm-Message-State: AGRZ1gIWN1UTs6cXcu+1bLaZM/edcpZAPqg8zsLqz/uWZn98SK8HsiLp
        B0Gu5DLHMx4sRQ2/Y3KmHmMOmKzCRCs=
X-Google-Smtp-Source: AJdET5eYW5Bl8voPY9woiThyHima+R6xs/IlDaOP5AFE4hx5RsFjk9zjoFDUQa+j5JK8LtCbJKN8MQ==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14-v6mr2510067wrt.326.1540989739492;
        Wed, 31 Oct 2018 05:42:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l42-v6sm2336705wre.37.2018.10.31.05.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 05:42:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Add a GIT_TEST_FSCK test mode
Date:   Wed, 31 Oct 2018 12:42:05 +0000
Message-Id: <20181031124208.29451-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.899.g0250525e69
In-Reply-To: <20181030232337.GC32038@sigill.intra.peff.net>
References: <20181030232337.GC32038@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top Jeff's "cat-file: handle streaming failures
consistently" and implements the test mode I suggested in
https://public-inbox.org/git/877ehzksjd.fsf@evledraar.gmail.com/

In the process I didn't find any other bugs than the 2.12..2.19
regression which is already fixed, but as noted in 3/3 I think it's
worth it to stress test fsck like this. I'll be adding this to my
regular build.

Ævar Arnfjörð Bjarmason (3):
  tests: add a "env-bool" helper to test-tool
  tests: mark those tests where "git fsck" fails at the end
  tests: add a special test setup that runs "git fsck" before exiting

 Makefile                                |  1 +
 t/README                                |  5 ++++
 t/helper/test-env-bool.c                |  9 +++++++
 t/helper/test-tool.c                    |  1 +
 t/helper/test-tool.h                    |  1 +
 t/t0000-basic.sh                        | 26 +++++++++++++++++++
 t/t1006-cat-file.sh                     |  5 ++++
 t/t1305-config-include.sh               |  4 +++
 t/t1404-update-ref-errors.sh            |  4 +++
 t/t1410-reflog.sh                       |  4 +++
 t/t1515-rev-parse-outside-repo.sh       |  4 +++
 t/t3008-ls-files-lazy-init-name-hash.sh |  4 +++
 t/t3103-ls-tree-misc.sh                 |  6 +++++
 t/t3430-rebase-merges.sh                |  6 +++++
 t/t4046-diff-unmerged.sh                |  4 +++
 t/t4058-diff-duplicates.sh              |  5 ++++
 t/t4212-log-corrupt.sh                  |  6 +++++
 t/t5000-tar-tree.sh                     |  5 ++++
 t/t5300-pack-object.sh                  |  5 ++++
 t/t5303-pack-corruption-resilience.sh   |  8 ++++++
 t/t5307-pack-missing-commit.sh          |  7 ++++++
 t/t5312-prune-corruption.sh             |  4 +++
 t/t5504-fetch-receive-strict.sh         |  4 +++
 t/t5601-clone.sh                        |  8 ++++++
 t/t6007-rev-list-cherry-pick-file.sh    |  4 +++
 t/t6011-rev-list-with-bad-commit.sh     |  7 ++++++
 t/t6030-bisect-porcelain.sh             |  6 +++++
 t/t7007-show.sh                         |  6 +++++
 t/t7106-reset-unborn-branch.sh          |  4 +++
 t/t7415-submodule-names.sh              |  4 +++
 t/t7416-submodule-dash-url.sh           |  4 +++
 t/t7417-submodule-path-url.sh           |  4 +++
 t/t7509-commit-authorship.sh            |  4 +++
 t/t8003-blame-corner-cases.sh           |  4 +++
 t/t9130-git-svn-authors-file.sh         |  7 ++++++
 t/test-lib-functions.sh                 |  2 ++
 t/test-lib.sh                           | 33 +++++++++++++++++++++++++
 37 files changed, 225 insertions(+)
 create mode 100644 t/helper/test-env-bool.c

-- 
2.19.1.899.g0250525e69

