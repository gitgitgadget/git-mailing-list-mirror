Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFFA1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 01:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeKUL6N (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 06:58:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34617 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUL6N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 06:58:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so2148488wmd.1
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 17:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NR6/tKJclSI0+Ww7dq8sSTwJO3T/t1c31LStNPWH0NY=;
        b=Tx/JJWI3jmzICxAdZD0K15tW5FnCA7rSP8O7p17DVN0RNaV76iLvxJZ5xP4vjkOD8q
         Dl1O/2+QMYEmNOWzElYzYceQ0n50qYMTsNvxiv0+2jpOczk4ylRgUhW3ickuttifKFuI
         GZv+o99Ih1godMM1chxSdUyr8Dk4pu6s7d6jQs0TaJI5IE26s5SSx22J+0W9dpOqKBna
         /HdzPoolzdX8E5X6KZZYIlu3D1R7/aV6bdFT01LJsD0VHv/qTczP5NJuGr/hrwgX0sqe
         oWF1kh3DMP0HnHEPGRWkf+ZFOxWRgJiEmDvsuKJ6/T5rmUfh/cQkR8Lm1aS4cuNv1gQy
         /a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NR6/tKJclSI0+Ww7dq8sSTwJO3T/t1c31LStNPWH0NY=;
        b=W9nfQhFTA3dWnB3KnaumkoJ5PUMlC4jWP9Ca8USnCmF6uVOdRmK9ESjxSZ/lM8Nccx
         U1D/Dff5Wg9I/d76tSzQi5w9fDIYM4Ezyv89/RP4B7/SNqs07OOPcvW98sXZS3caLRwC
         l1eCiUH7lf/VHHTbxkbdc8Ci4imOzd9wDwh7F9IG2uGpeB1Ju4bJhWXQSSxq/ay8C+Gn
         9I9/i4OLARKesPRQsme9dVLMBw+TwVJqsyRYGW5c02QsY4ugcOc1cXB6NTb51NLMKwZ5
         47J01isAXm2kgAkz/c3XfGpXiDqcCbziGhJpMl6d7UjXghmbQdIyPiSdN6nprbeDWXi2
         16pA==
X-Gm-Message-State: AA+aEWbNYFKU/kSyEzdniLTtMygvf85P61gBmmvBvcCzBHr+f5z0DhVs
        0KdhWOqd/sVxsCrGlIpLGw4=
X-Google-Smtp-Source: AJdET5eqi/q93Uz44abtMc7VeZr8zC8dPY6FiQSAMK+MrRyEBIcERn5RJQxZ07Y46zbwEcv+V6hS6w==
X-Received: by 2002:a1c:18c:: with SMTP id 134mr3765002wmb.94.1542763564979;
        Tue, 20 Nov 2018 17:26:04 -0800 (PST)
Received: from localhost.localdomain (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id e7-v6sm34848457wra.10.2018.11.20.17.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 17:26:04 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
Date:   Wed, 21 Nov 2018 02:26:00 +0100
Message-Id: <20181121012600.26951-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.134.gf0022f8e60
In-Reply-To: <20181121012344.26711-1-szeder.dev@gmail.com>
References: <20181121012344.26711-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The optional 'Large Edge List' chunk of the commit graph file stores
parent information for commits with more than two parents.  Since the
chunk is optional, write_commit_graph() looks through all commits to
find those with more than two parents, and then writes the commit
graph file header accordingly, i.e. if there are no such commits, then
there won't be a 'Large Edge List' chunk written, only the three
mandatory chunks.

However, when it comes to writing chunk data, write_commit_graph()
unconditionally invokes write_graph_chunk_large_edges(), even when it
was decided earlier that that chunk won't be written.  Strictly
speaking there is no bug here, because write_graph_chunk_large_edges()
won't write anything because it won't find any commits with more than
two parents, but then it unnecessarily and in vain looks through all
commits once again in search for such commits.

Don't call write_graph_chunk_large_edges() when that chunk won't be
written to spare an unnecessary iteration over all commits.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7b4e3a02cf..965eb23a7b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -940,7 +940,8 @@ void write_commit_graph(const char *obj_dir,
 	write_graph_chunk_fanout(f, commits.list, commits.nr);
 	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_large_edges(f, commits.list, commits.nr);
+	if (num_large_edges)
+		write_graph_chunk_large_edges(f, commits.list, commits.nr);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.0.rc0.134.gf0022f8e60

