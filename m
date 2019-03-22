Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158F120248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfCVJdJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33068 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfCVJdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so3879686wmi.0
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qdcbY4knywdY0KgKM7U5q/OHcbFDdWPUwgxeXJGnTw=;
        b=r3umLyU8h1hqZmNDpofdZiRhPKVb+4/Ezpq9Vvxq19hKaViBvgu+PO9Yo9++MjAgqJ
         UnqwosGyaBjJnc93UVF6iNrkR28VxJf3op7NCMX2xwBKaJ2cgzjs8Pu8r6UJAQuLO2Qk
         FGdGcQ1PlLdW8Lf92aoSYDv2ATHNrrduDjT1VVFy3oi1F4E6hwBFsOObmWfLAQN/LngK
         0x2xt2/rdoo/6hDzXCxUWbllXrYKvFh8Ygz2a3Q3ra2u9jO3g7H30VA+EGF90SIV10rq
         g92QDOGu0zVp3rUunQ/vROGKRnNAtcglLEX/rMIml9W8LKTrjkgRBBxPMirmR9u34wcG
         K6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qdcbY4knywdY0KgKM7U5q/OHcbFDdWPUwgxeXJGnTw=;
        b=WEsmTaY8ZnhQ4d6OheIMogu6jCUHCvJZDWCE9wIQNnuQ2Mcpobtx5m6Y/VV3d/mgQ+
         UX5ztv3CTh4mJs9wX2A72cJCvtholPTB/bYTj5FdBaoMyhmLLtCjdPLWtzSF4AlDV13Y
         XcLLvf4svbb+d7nXsC/9ukR04tNYoPyOO92ffBDoPVvgLcURfszBOOIcc4jr1jBGWGAs
         wJt6ZjgidRhhMRVtb6xu79FFvpNCNdYz8JP4DbZdzxiwX5zetuWd9QQO5DTCqp1InvZP
         sovxNCRZzCcXTnz9tD8BhTNSl4JcLyrwT2wJfsGhnbY6071/5d/0Bl94Dx+5pmcEBTl1
         QSrQ==
X-Gm-Message-State: APjAAAV0iZcbCsDC8WJ8F6GhN3kMEIdD3StiiaDfLviuK7ooTzJaZeNZ
        2QrkslxjiDoyGnqX2k3y+DX4i6d2+7E=
X-Google-Smtp-Source: APXvYqwU0EbhfWQbkDDSwGVxPk3ALfA8vXDcGAQoiIFvQhwsxLOaiQGVQHXOE9DeNzuWy5IMW5ZefA==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr2264929wma.2.1553247186692;
        Fri, 22 Mar 2019 02:33:06 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/11] gc docs: re-flow the "gc.*" section in "config"
Date:   Fri, 22 Mar 2019 10:32:36 +0100
Message-Id: <20190322093242.5508-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-flow the "gc.*" section in "config". A previous commit moved this
over from the "gc" docs, but tried to keep as many of the lines
identical to benefit from diff's move detection.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index a255ae67b0..3e7fc052d9 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -53,9 +53,9 @@ will be repacked. After this the number of packs should go below
 gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 +
 If the amount of memory estimated for `git repack` to run smoothly is
-not available and `gc.bigPackThreshold` is not set, the largest
-pack will also be excluded (this is the equivalent of running `git gc`
-with `--keep-base-pack`).
+not available and `gc.bigPackThreshold` is not set, the largest pack
+will also be excluded (this is the equivalent of running `git gc` with
+`--keep-base-pack`).
 
 gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
@@ -115,12 +115,11 @@ gc.<pattern>.reflogExpireUnreachable::
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
 +
-These types of entries are generally created as
-a result of using `git commit --amend` or `git rebase` and are the
-commits prior to the amend or rebase occurring.  Since these changes
-are not part of the current project most users will want to expire
-them sooner, which is why the default is more aggressive than
-`gc.reflogExpire`.
+These types of entries are generally created as a result of using `git
+commit --amend` or `git rebase` and are the commits prior to the amend
+or rebase occurring.  Since these changes are not part of the current
+project most users will want to expire them sooner, which is why the
+default is more aggressive than `gc.reflogExpire`.
 
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
-- 
2.21.0.360.g471c308f928

