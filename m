Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9E91F45F
	for <e@80x24.org>; Tue,  7 May 2019 11:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfEGLKe (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 07:10:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33945 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfEGLKe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 07:10:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so11425558wrq.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZ09F0zIC1aRUXkCpfJu/ka2c41fGJ/Me7TwSVoH/Lg=;
        b=KOdXZawkV45Zr7HLPf6TMUNjI38UgylJkwrrNYbn5Ucllr/K7zujDtEpOGYbvGlPUD
         mHi0Xz2kG71KZEvouCtUSGXeUYpJMaqo44PYWjGZumJ4vyz8SFLDX3yaO4oKrwx7H5MY
         aSzmF57Q9xXDd4qt3YnHbXqu7asAcjSk0g72K0m12ZtUnvw+spmtlBCAEv4r9o0Asq/v
         ABgN/jhP2d+6tSSbWsNOTpSqtzjvcMvilwIKlPA2Lo0gVrZ3V2Qg6Cr+fmtzxr9csM8L
         e1zPLmsLOu4tNSh+7J/b9GlYA5sy3VfNjININ+81w6B0Pl9Rdtae+yLPTTBf3Lbq+dW/
         AD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ09F0zIC1aRUXkCpfJu/ka2c41fGJ/Me7TwSVoH/Lg=;
        b=f67Hn4wJY2ET/PsyAD0oIRK7Rxf+IMVswARBGhHdpsv2RbBdaMskMNJH0G49SfwBln
         Sr7Acy5YKpOB+cuR3BChwgIUFX7bxqAkdFMg0u01Wwzl7BqaPSi7Zw9EiIITbgdykK+Z
         cLWZbLA/8m0ZHGRZTeVsgEWGo2VYhNXFFGLFyYgZwIFfqugT73HS/ug+TC06LeZjWquo
         SkCsHDmQnICELdupGVS7OQ9vyxopo7M6GJl6Mha7f6PMYzSUg3i1QMEykKOZ8VpcQ4Ek
         fXIl8O9B23A1dYxsmwxMArzVmsooaG08r2NclSFLPtu+PHzinQPENrrxRenJ7n7jaS4l
         fdbQ==
X-Gm-Message-State: APjAAAVL/q3XVcCVwRVxZ32j0sGi8RXds9yCjM7CCA49ADTe7YjYQfyF
        dUuXkVy0yWtYZ1gEaRvB6C9e4xRSBZY=
X-Google-Smtp-Source: APXvYqwO/3K4TZb/yY8Lv9JI/AgV/I2rQEpHFEbEdE2u3c4YVzNFOnn/c5LbOkfvaKJM3p/CNFUYdA==
X-Received: by 2002:adf:9c87:: with SMTP id d7mr16371061wre.68.1557227431536;
        Tue, 07 May 2019 04:10:31 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm11246108wre.78.2019.05.07.04.10.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 04:10:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] Fix fsmonitor after discard_index()
Date:   Tue,  7 May 2019 13:10:19 +0200
Message-Id: <20190507111021.12840-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <pull.165.v2.git.gitgitgadget@gmail.com>
References: <pull.165.v2.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v3 is all Johannes's patches. The outstanding review on v2 could
be clarified with a commit message change, which I've addressed, and
v2 conflicted with a cache.h change that's since landed in "master",
which I've rebased this on.

Junio: We're getting closer to the release so it would be great to
have this. It's been broken for a long time, but having this finaly
fixed in v2.22 would be great. The functional code changes are also
isolated to the fsmonitor code path, which reduces the risk and makes
this easier to review/reason about.

Johannes Schindelin (2):
  fsmonitor: demonstrate that it is not refreshed after discard_index()
  fsmonitor: force a refresh after the index was discarded

 cache.h                     |  3 ++-
 fsmonitor.c                 |  5 ++---
 read-cache.c                |  1 +
 t/helper/test-read-cache.c  | 24 +++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh |  8 ++++++++
 5 files changed, 36 insertions(+), 5 deletions(-)

Range-diff:
1:  51a7edf22a = 1:  c31f834b07 fsmonitor: demonstrate that it is not refreshed after discard_index()
2:  79fdd0d586 ! 2:  7bf5f9f610 fsmonitor: force a refresh after the index was discarded
    @@ -6,8 +6,10 @@
         flag that says whether the fsmonitor hook has been run, i.e. it is now
         per-index.
     
    -    It also gets re-set when the index is discarded, fixing the bug where
    -    fsmonitor-enabled Git would miss updates under certain circumstances.
    +    It also gets re-set when the index is discarded, fixing the bug
    +    demonstrated by the "test_expect_failure" test added in the preceding
    +    commit. In that case fsmonitor-enabled Git would miss updates under
    +    certain circumstances, see that preceding commit for details.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     
    @@ -15,11 +17,11 @@
      --- a/cache.h
      +++ b/cache.h
     @@
    - 	struct cache_time timestamp;
    - 	unsigned name_hash_initialized : 1,
      		 initialized : 1,
    --		 drop_cache_tree : 1;
    -+		 drop_cache_tree : 1,
    + 		 drop_cache_tree : 1,
    + 		 updated_workdir : 1,
    +-		 updated_skipworktree : 1;
    ++		 updated_skipworktree : 1,
     +		 fsmonitor_has_run_once : 1;
      	struct hashmap name_hash;
      	struct hashmap dir_hash;
-- 
2.21.0.593.g511ec345e18

