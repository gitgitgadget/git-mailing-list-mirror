Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3694420248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfCUUvJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38089 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUUvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so72526wrm.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8oll5fycP5NQ65cUVqGHUhH9m492G2zAt2Gx3deKjc=;
        b=OnUdGvCXI8EibKygGAlB12XlhPiF+1ccv6bF3lgIFj+i+Adb3cCC6EA623q84u3iGu
         nf+11S1X29Vv0An2xHDAWM7rvBnZLZb7p0IIoGejWT4nT7wUGEyWPFyb8/dLPsQlp1sX
         WuBqnA60LmrLQ7bhckI9oJJZFEjesM2wSXSJ7p4HA6x8NIkhRQp9ivhQGJOpIoYkoYBk
         7ZhdwkvULfLhuphveNQg+Z3SrWzxQROlv5Y6y4SDaEoDfHvt0LX/+xDa6ycYb7lmxzLE
         PfQ/nVT1JfK+P4n1BXqDczw6kHr6SgCxyrtN3s2djVuozPPPXVh4XbKTXc/wpjRIAYvS
         MuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8oll5fycP5NQ65cUVqGHUhH9m492G2zAt2Gx3deKjc=;
        b=HcunFMdYPfUEFwKNcF2hq50T7sZesRsBVam5Rd5hwem2AWDjUftg90EkTG6TWVjf6Y
         fUZRMPyp1AWDuYo3h4d8tG7escuFgx+jXoPtfYkH3CKL/kmv/JLZq1aRQSSKFGGgaZL0
         8SYTuHI8060zA/sUGaRoORQOYRz++RezAyYYSAAvAnDOBiv2C2N9y686Ytzt4fSND7vT
         MJ88k0s+DDhcjDot7mxD8Fe55DKIylh6KSPYAQDO3PgZLuMouZcwgVVkWDLnnX4Cr5+g
         1h3oX/1SY94GI7wCqE9qldf68qJuZFVrHm7+jlF9lGaVZUrMaud4yj+5iG5wFIMSQwRR
         q7tw==
X-Gm-Message-State: APjAAAWYOG7Y2JNYGy0srXHzAxmnAAS2npDRemw0KJDDRp+RMMTbgLIV
        V3jncJ4UgXkPONMq6laoEO6oz63R
X-Google-Smtp-Source: APXvYqy3GZfXdLiQYm18f195uX1K3Ixm/Yw/SAlO8z4s0OFEJ9ZB/6oZH58J+TG/ywPs3U0/TsfsRQ==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr4154109wrq.224.1553201466107;
        Thu, 21 Mar 2019 13:51:06 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:05 -0700 (PDT)
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
Subject: [PATCH v2 01/10] gc docs: modernize the advice for manually running "gc"
Date:   Thu, 21 Mar 2019 21:50:45 +0100
Message-Id: <20190321205054.17109-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docs have been recommending that users need to run this manually,
but that hasn't been needed in practice for a long time except in
exceptional circumstances.

Let's instead have this reflect reality and say that most users don't
need to run this manually at all, while briefly describing the sorts
sort of cases where "gc" does need to be run manually.

Since we're recommending that users run this most of the and usually
don't need to tweak it, let's tone down the very prominent example of
the gc.auto=0 command. It's sufficient to point to the gc.auto
documentation below.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a7c1b0f60e..774503e33d 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -20,17 +20,16 @@ created from prior invocations of 'git add', packing refs, pruning
 reflog, rerere metadata or stale working trees. May also update ancillary
 indexes such as the commit-graph.
 
-Users are encouraged to run this task on a regular basis within
-each repository to maintain good disk space utilization and good
-operating performance.
-
-Some git commands may automatically run 'git gc'; see the `--auto` flag
-below for details. If you know what you're doing and all you want is to
-disable this behavior permanently without further considerations, just do:
-
-----------------------
-$ git config --global gc.auto 0
-----------------------
+When common porcelain operations that creates objects are run, they
+will check whether the repository has grown substantially since the
+last maintenance, and if so run `git gc` automatically. See `gc.auto`
+below for how to disable this behavior.
+
+Running `git gc` manually should only be needed when adding objects to
+a repository without regularly running such porcelain commands, to do
+a one-off repository optimization, or e.g. to clean up a suboptimal
+mass-import. See the "PACKFILE OPTIMIZATION" section in
+linkgit:git-fast-import[1] for more details on the import case.
 
 OPTIONS
 -------
-- 
2.21.0.360.g471c308f928

