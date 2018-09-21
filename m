Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A1F1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390356AbeIUVrW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37872 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUVrV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id b12-v6so4557322lfa.4
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTT7rsOxODb2sZpmGeSHLlUALrayu3zJaHXbptTwVtg=;
        b=qq8u0Czv9Fn0E62pZnP9j1yTdrBlGNElTXCSBwj9RJ+TpZB4Czn8u8120elvBMqisQ
         6/wUJhuPjW4Xq1+uDHv/vrvK7BGpb8kWyuo7RJMo+/1TPQrnl86CzOABTqpfbOCvqgHG
         J60PdiChIeo+ou8rlQ/TTQclk8GspkpBbq656fHqXLXGVl5h/oHJxvKVOUQCDxF2d7R/
         mYsfwhZ4rkt+RqHbg0N7qDGR0NN/90OHGcyNk3/ZlC/GVVJWw9muVkwnFdaipfKNJlMC
         beg+w9Xh5oiVECd9O+aJ66EpEmsaFfDGjhHGO0XXdl8wKJ3LjihnYamZJNd3couLzh9X
         nZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTT7rsOxODb2sZpmGeSHLlUALrayu3zJaHXbptTwVtg=;
        b=rlb0tcIUBvnXNe+rQTtYcYziuk2ctMHMDbQ/6/3HDAeVlojnpswmomGZuhFeMbGYx/
         Jqtmk7QhPIOyRvhBOa4r6ik+2weqZQxDrw7mwJE/tqphaK2BTiqgJbzcwfeU5/ffwyP3
         ifbZIcsz+Nomct5wFPYBie0E3vuRd4FNw5XB71eVpkvY37WnJIq6JGo7JyBTO3QKGQE2
         oWu7BXgbkMJHfCIssL7Z6eYQS7KNJA8oe2MUeoYm05mCL50R+uEAr/dn2z+yrAzl/D/D
         4zwJ11NyrdeA89wgnTCpPFtnqAhUWKLWuNUIuVTdcF5OFcqvORkJNtrOs+5RBd5uL0qC
         Vg2w==
X-Gm-Message-State: APzg51AUn1Xt6oDiwcy8EKBXMJKS0850Yg16n6An7qYGaf5DHOtwf6IZ
        hW2vwccdYRxOHyLRIjLF5T4=
X-Google-Smtp-Source: ANB0VdbYnjJ2dPmbmRR+BQ7DkUl/WOSY4eGUrV6s+Yus5N/Q3ezu0JLCo6kPx8YDFsmEhu267YihEQ==
X-Received: by 2002:a19:988a:: with SMTP id a132-v6mr29467814lfe.76.1537545467828;
        Fri, 21 Sep 2018 08:57:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 00/23] Kill the_index part 4
Date:   Fri, 21 Sep 2018 17:57:16 +0200
Message-Id: <20180921155739.14407-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 only has commit message update in one patch. range-diff below.

Also, from "What's cooking" today

On Fri, Sep 21, 2018 at 7:22 AM Junio C Hamano <gitster@pobox.com> wrote:
> * nd/the-index (2018-09-17) 23 commits
>  ...
>
>  Will merge to 'next'.
>
>  As expected, this has close to irritating amount of textual conflicts
>  with the topics in-flight.  Hopefully we can minimize the pain by
>  letting it pass through quickly?
>

No objection. I have to warn Junio though, there is still part 5, so
the pain will be still there for a bit longer. Unless the new rebase
and stash topics get merged first.

 1:  9b907ae529 !  1:  2203a5fbac read-cache.c: remove 'const' from index_has_changes()
    @@ -3,16 +3,19 @@
         read-cache.c: remove 'const' from index_has_changes()
     
         This function calls do_diff_cache() which eventually needs to set this
    -    "istate" to unpack_options->src_index (*). This is an unfortunate fact
    -    that unpack_trees() _will_ destroy src_index so we can't really pass a
    +    "istate" to unpack_options->src_index [1]. This is an unfortunate fact
    +    that unpack_trees() _will_ update [2] src_index so we can't really pass a
         const index_state there. Just remove 'const'.
     
    -    (*) Right now diff_cache() in diff-lib.c assigns the_index to
    +    [1] Right now diff_cache() in diff-lib.c assigns the_index to
             src_index. But the plan is to get rid of the_index, so it should
             be 'istate' from here that gets assigned to src_index.
     
    +    [2] Some transient bits in the source index are touched. Optional
    +        extensions can also be removed. But other than that the source
    +        tree should still be valid.
    +
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/cache.h b/cache.h
      --- a/cache.h
 2:  27518df579 =  2:  fc60c5dfcf diff.c: reduce implicit dependency on the_index
 3:  bd45a50b6d =  3:  9bb467ec06 combine-diff.c: remove implicit dependency on the_index
 4:  90ac73d37b =  4:  4304405578 blame.c: rename "repo" argument to "r"
 5:  c36071a4ab =  5:  71c1bb997e diff.c: remove the_index dependency in textconv() functions
 6:  9321bb37a9 =  6:  0c9371ebd6 grep.c: remove implicit dependency on the_index
 7:  41b046463c =  7:  e6aba3aad9 diff.c: remove implicit dependency on the_index
 8:  f0d1e5da57 =  8:  8e4c25023f read-cache.c: remove implicit dependency on the_index
 9:  3b7c181005 =  9:  f605feb11e diff-lib.c: remove implicit dependency on the_index
10:  0f2ed0b54d = 10:  fb06c902e2 ll-merge.c: remove implicit dependency on the_index
11:  46d37956a5 = 11:  5a75125df6 merge-blobs.c: remove implicit dependency on the_index
12:  8b7e116fba = 12:  c13cd5443d merge.c: remove implicit dependency on the_index
13:  7d5bd2dfbd = 13:  575aea07ed patch-ids.c: remove implicit dependency on the_index
14:  c672034cb3 = 14:  78a0762057 sha1-file.c: remove implicit dependency on the_index
15:  ce460601c2 = 15:  91bf6b553a rerere.c: remove implicit dependency on the_index
16:  5b338d60aa = 16:  b0ee54a0ad userdiff.c: remove implicit dependency on the_index
17:  af2269eba7 = 17:  6a7cea2510 line-range.c: remove implicit dependency on the_index
18:  8090b8415f = 18:  a19193217a submodule.c: remove implicit dependency on the_index
19:  5db39ed3ef = 19:  b0dc3a2f5d tree-diff.c: remove implicit dependency on the_index
20:  d3811221c8 = 20:  60e495cd36 ws.c: remove implicit dependency on the_index
21:  c313cf1f20 = 21:  5b3c7e6ca4 revision.c: remove implicit dependency on the_index
22:  c915607c60 = 22:  357394f04d revision.c: reduce implicit dependency the_repository

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
2.19.0.640.gcd3aa10a8a

