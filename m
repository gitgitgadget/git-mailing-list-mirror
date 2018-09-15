Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C561F42B
	for <e@80x24.org>; Sat, 15 Sep 2018 16:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeIOViK (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:10 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36859 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeIOViK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:10 -0400
Received: by mail-lj1-f174.google.com with SMTP id v26-v6so9861000ljj.3
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LV+E0hGWhWoCRs8ULC4inEHyyGUjr58LpAxc3mKPguA=;
        b=WXR2PHtp5i2TT7hUCWeAYBjAdxI0O+1CKnN352Lma7bO1bxHhRbm6UVVql2ztw+ySh
         FCJ4WqkYNRfleKR+oFrtzEE3H0W98T4MbD5NQYIoi+ByFX3YylmPcqICwKJ7KUPbZ7Pc
         ywJBy78A+lva6q+WuKi1o53WfLjrQsD4i8jw/R67K5MgoeZLHLqPiQqqLUj9txJQk7q7
         eSQuWmjHbtth8Y/CDdD6Cem8Us+Webcct/8Q0p6NHT3cHtQR3Ur9t3ihotLJY8tmPk6E
         WEqRu6IUUlKEHri55VKWTjriB4PKEtah0dKgR+4yHM1FqpUX2MPCfO1o6nLPJsFskam8
         tiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LV+E0hGWhWoCRs8ULC4inEHyyGUjr58LpAxc3mKPguA=;
        b=Y124uC6kjGTbfOqYVT8Am1Li/YPfel09QYVu07OckdM2bGiwBDC9KtvhVXmGNFztJf
         nTd11Di+X/NsoudiEX/0ayJ7AbJniUHz/buM+OzNakFWff3nmiDP8LHUwqkJ+oL0k9VQ
         I9z8AiUn/TGz1LDUKmZOLMt6D3MmmgxoCaUvT4PGZUHWRW5y/XH7aI3+dVgjvRlMcNY4
         u5/UuNHDKGLr94Q9YA38tUOe5jIvb/N6DnmmfLG+lXl2t4UzOaSex5XG3fGe39ACcvvU
         hXYnNdm0pJE53JvuLL1L/ECNo5i6xnPvxpFGlvnB8UBrDHTmH7zWa8YjdQYfgwTPJXU7
         JKpw==
X-Gm-Message-State: APzg51DVU6UomZmMMbB7wf4GeccKJM1O+3ZE2pjlWGu6pwX/1oi3LQa3
        l6HxXvObKy8A9/oC5RfU89at8PM6
X-Google-Smtp-Source: ANB0VdYzTIiHGtr8stkzFCoQr3b6GS+H29ze9cf2DGjNXOWRaxo9xLVz95VcNGtjtePWXPISQDa9/A==
X-Received: by 2002:a2e:658a:: with SMTP id e10-v6mr9938547ljf.99.1537028317933;
        Sat, 15 Sep 2018 09:18:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 00/23] Kill the_index part 4
Date:   Sat, 15 Sep 2018 18:17:36 +0200
Message-Id: <20180915161759.8272-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 includes one word change (interdiff below) and signoff (oops!).

diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
index 83e62533a0..03f9ea6ac4 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -17,7 +17,7 @@ Functions
 
 `repo_init_revisions`::
 
-	Initialize a rev_info structure with default values. The second
+	Initialize a rev_info structure with default values. The third
 	parameter may be NULL or can be prefix path, and then the `.prefix`
 	variable will be set to it. This is typically the first function you
 	want to call when you want to deal with a revision list. After calling


Nguyễn Thái Ngọc Duy (23):
  archive.c: remove implicit dependency the_repository
  read-cache.c: remove 'const' from index_has_changes()
  diff.c: reduce implicit dependency on the_index
  combine-diff.c: remove implicit dependency on the_index
  blame.c: rename "repo" argument to "r"
  diff.c: remove the_index dependency in textconv() functions
  grep.c: remove implicit dependency on the_index
  diff.c: remove implicit dependency on the_index
  read-cache.c: remove implicit dependency on the_index
  diff-lib.c: remove implicit dependency on the_index
  ll-merge.c: remove implicit dependency on the_index
  merge-blobs.c: remove implicit dependency on the_index
  merge.c: remove implicit dependency on the_index
  patch-ids.c: remove implicit dependency on the_index
  sha1-file.c: remove implicit dependency on the_index
  rerere.c: remove implicit dependency on the_index
  userdiff.c: remove implicit dependency on the_index
  line-range.c: remove implicit dependency on the_index
  submodule.c: remove implicit dependency on the_index
  tree-diff.c: remove implicit dependency on the_index
  ws.c: remove implicit dependency on the_index
  revision.c: remove implicit dependency on the_index
  revision.c: reduce implicit dependency the_repository

 Documentation/technical/api-diff.txt          |   4 +-
 .../technical/api-revision-walking.txt        |   4 +-
 apply.c                                       |  19 +-
 archive-zip.c                                 |  14 +-
 archive.c                                     |   2 +-
 bisect.c                                      |   4 +-
 blame.c                                       |  63 +++--
 builtin/add.c                                 |   4 +-
 builtin/am.c                                  |  10 +-
 builtin/blame.c                               |   4 +-
 builtin/cat-file.c                            |   6 +-
 builtin/checkout.c                            |   7 +-
 builtin/commit.c                              |   4 +-
 builtin/describe.c                            |   4 +-
 builtin/diff-files.c                          |   2 +-
 builtin/diff-index.c                          |   2 +-
 builtin/diff-tree.c                           |   2 +-
 builtin/diff.c                                |   4 +-
 builtin/difftool.c                            |   2 +-
 builtin/fast-export.c                         |   2 +-
 builtin/fmt-merge-msg.c                       |   2 +-
 builtin/grep.c                                |   7 +-
 builtin/hash-object.c                         |   2 +-
 builtin/log.c                                 |  25 +-
 builtin/merge-tree.c                          |   2 +-
 builtin/merge.c                               |  16 +-
 builtin/pack-objects.c                        |   2 +-
 builtin/prune.c                               |   2 +-
 builtin/pull.c                                |   9 +-
 builtin/range-diff.c                          |   2 +-
 builtin/reflog.c                              |   2 +-
 builtin/replace.c                             |   2 +-
 builtin/rerere.c                              |   6 +-
 builtin/reset.c                               |   1 +
 builtin/rev-list.c                            |   2 +-
 builtin/revert.c                              |   2 +-
 builtin/shortlog.c                            |   2 +-
 builtin/submodule--helper.c                   |   2 +-
 builtin/update-index.c                        |   2 +-
 bundle.c                                      |   4 +-
 cache.h                                       |  14 +-
 combine-diff.c                                |  32 ++-
 diff-lib.c                                    |  21 +-
 diff-no-index.c                               |   9 +-
 diff.c                                        | 261 ++++++++++--------
 diff.h                                        |  22 +-
 diffcore-break.c                              |  12 +-
 diffcore-delta.c                              |  12 +-
 diffcore-pickaxe.c                            |   8 +-
 diffcore-rename.c                             |  35 ++-
 diffcore.h                                    |  13 +-
 grep.c                                        |  34 ++-
 grep.h                                        |  10 +-
 http-push.c                                   |   2 +-
 line-log.c                                    |  25 +-
 line-range.c                                  |  22 +-
 line-range.h                                  |   6 +-
 list-objects.c                                |   8 +-
 ll-merge.c                                    |  17 +-
 ll-merge.h                                    |   5 +-
 merge-blobs.c                                 |  16 +-
 merge-blobs.h                                 |   7 +-
 merge-recursive.c                             |   7 +-
 merge.c                                       |  20 +-
 notes-merge.c                                 |   9 +-
 pack-bitmap-write.c                           |   2 +-
 patch-ids.c                                   |   4 +-
 patch-ids.h                                   |   3 +-
 read-cache.c                                  |  33 ++-
 ref-filter.c                                  |   2 +-
 remote.c                                      |   2 +-
 rerere.c                                      | 121 ++++----
 rerere.h                                      |  10 +-
 revision.c                                    |  76 ++---
 revision.h                                    |  15 +-
 sequencer.c                                   |  18 +-
 sha1-file.c                                   |  50 ++--
 shallow.c                                     |   2 +-
 submodule.c                                   |  34 ++-
 submodule.h                                   |   9 +-
 t/helper/test-revision-walking.c              |   2 +-
 transport.c                                   |   9 +-
 tree-diff.c                                   |   2 +-
 userdiff.c                                    |   5 +-
 userdiff.h                                    |   3 +-
 ws.c                                          |   5 +-
 wt-status.c                                   |  10 +-
 87 files changed, 749 insertions(+), 552 deletions(-)

-- 
2.19.0.rc0.337.ge906d732e7

