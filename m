Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4471F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfH1Pvh (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:51:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39774 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1Pvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:51:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id y200so61442pfb.6
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwbjFpPureR+T7GJ49YkcBaWGzlDT+EybZRyc71IMXM=;
        b=PUozjPPCIvnyRBfAFv7wBs25Q6YriwOQl6/FGdVI4vZGTO32W9P2eFphL72H+ThdEp
         P5fc3PrRuQ9Og8ry1koF4sUR2M26bvCeGM+98pKg9N7nsNTZxLWrFuqfK8YbHN+l5xnS
         jLjZPep9TQcFh4xgc5zQCkQ7TR39si2rvje2LzQHeITzuuNLBMAnS5pbpS6KPjimkjUf
         4gAYZ0W8xFtxsMvOySV03a5an+gpvoWqF0gDe0HWr2ojbdokQerC1RuAPkc7D+PNjMk9
         1kQxPhfx9uUHGOKtKcjT0pqKrva2EshvnJFR3EsqEWQhM4glbyLoi3iyZYT35KCHAVwi
         yWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwbjFpPureR+T7GJ49YkcBaWGzlDT+EybZRyc71IMXM=;
        b=mgNCf6u8EDCtD4NKRgm6SrSq6/q8prxlt0dtqd2iGDgBVxhRdOoAupaDCMrv5u6vuW
         M9pIYAQj110yJZyDsv2hp294F28tu6W+WNhoupzZqhJDiCwsI9ZOal0Y0BWZHxB1bvMK
         FPriMipjWQrF81Ixx8/hpCJS1TAXMZbg/lV/FFrXo1AZmZSPut3TwOjUzbPvWrKC89Ct
         zCy6Flcn/pSCUhIb3JkWz1Dd+3n6Ok+qeHhRndOOBTNelQiXxqOtmFqYIIeMSvLfPGdr
         hL5Qp7U8LyMMsNCxOMQZ3KDNXwXtJEL/mJwCW2K8QgZcNKc/Lghpwto8uIJKGKwqgtay
         zWEQ==
X-Gm-Message-State: APjAAAUaMHY4a9ye3+9C+b4eW4C1n6L3cJJIN4K91qeKZHeJ2YZfmffl
        B5uHASdsKiTmU66D0NEDG7o=
X-Google-Smtp-Source: APXvYqxWOqOmPj4VWvrSIeWytfIfj58NW8pCNTtVH/a+hyZCJPDMbyVwMHsFrDG3tjUu6DL+jCiVvw==
X-Received: by 2002:a65:5382:: with SMTP id x2mr4064295pgq.422.1567007496634;
        Wed, 28 Aug 2019 08:51:36 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id q8sm2273115pjq.20.2019.08.28.08.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 08:51:36 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] merge-options.txt: clarify meaning of various ff-related options
Date:   Wed, 28 Aug 2019 08:51:31 -0700
Message-Id: <20190828155131.29821-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.9.g568fda2d03
In-Reply-To: <877e6x3bjj.fsf@osv.gnss.ru>
References: <877e6x3bjj.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discovered on the mailing list, some of the descriptions of the
ff-related options were unclear.  Try to be more precise with what these
options do.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1:
  * Grouped much like --option/--no-option items are to make it clearer
    that these are related options, as suggested by Sergey.

 Documentation/merge-options.txt | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 79a00d2a4a..348d66f54b 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -39,21 +39,28 @@ set to `no` at the beginning of them.
 	to `MERGE_MSG` before being passed on to the commit machinery in the
 	case of a merge conflict.
 
---ff::
-	When the merge resolves as a fast-forward, only update the branch
-	pointer, without creating a merge commit.  This is the default
-	behavior.
-
+--ff-only::
 --no-ff::
-	Create a merge commit even when the merge resolves as a
-	fast-forward.  This is the default behaviour when merging an
-	annotated (and possibly signed) tag that is not stored in
-	its natural place in 'refs/tags/' hierarchy.
+--ff::
+	Whether to only allow resolving the merge as a fast forward
+	(only updating the branch pointer to match the merged branch
+	and not creating a merge commit), to never allow it (always
+	creating a merge commit), or to prefer it when possible.  The
+	default is --ff, except when merging an annotated (and
+	possibly signed) tag that is not stored in its natural place
+	in 'refs/tags/' hierarchy (in which case --no-ff is the
+	default).
++
+With --ff-only, resolve the merge as a fast-forward when possible
+(when the merged branch contains the current branch in its history).
+When not possible, refuse to merge and exit with a non-zero status.
++
+With --no-ff, create a merge commit in all cases, even when the merge
+could instead resolve as a fast-forward.
++
+With --ff, resolve the merge as a fast-forward when possible.  When not
+possible, create a merge commit.
 
---ff-only::
-	Refuse to merge and exit with a non-zero status unless the
-	current `HEAD` is already up to date or the merge can be
-	resolved as a fast-forward.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-- 
2.23.0.9.g568fda2d03

