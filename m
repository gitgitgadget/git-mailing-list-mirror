Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84A491F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393166AbfAPNaL (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50230 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732885AbfAPNaK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so1994762wmd.0
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4AHvfXjVpz6hSJF3GoDRx1XH41Ax8rfPJUlEQHS2Dw=;
        b=G3fl2do7c0wuoPdxRQ9nwmgB+xVqmILqLdQP+m5zt6E0cOCUl1a1tvusrWb05RrLgf
         laTuRFIxqJ+QNO9wiSIDmfCwmZKKhOStlVbQuZ1yWHT3zyHgpb/bps7MSyaPxi28flAF
         GNBYWD4Pf8A9299uNUoF/JgHU0VUqOepqg7L2c+rX3tSZhUkO647B0IFZfiDBf3FdDff
         +xnBg4WMOkPTpB8rpvEeRt/4NcFQJ+491HdeErAnOmo1OL8uXju1/VcF+bsqCi1xqoAp
         HEojY8LR8aVVevnCSXabnoqVz9GzEdp4fEMDVAr751oKm4OdfdvS63nNy9CylGKrmWRN
         tjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4AHvfXjVpz6hSJF3GoDRx1XH41Ax8rfPJUlEQHS2Dw=;
        b=DSjqZYMyYRWWEyoKDO/uapvzKUXow1aOBQ2Rj3Nl0PcXCSbD41m6a1rt6NJ86o0Qux
         XCBCkdJ/aJXdCHdavEh7KTuCtUUjrg+qWbGM2XpJd1c3M+/N6dNYWjhKDxlohtG7Pqw4
         aeeIHKkofm3hwzdwHvxczSy9beW8fOF8EqFkXuvhAX92MX7rdJRMmWljRFVyW+YbZgB7
         17vRiTSlwihUdXW7coXcIeMxqkcTaNkSYdUtE4GQPsIlGuMKeZztEeW4vgnYDXzPUxnM
         qP+plZ8601RMebkwNVWB+UZ0ZmfPFH9FPHONAGXHldrvAMW+VKErENTxCZmX1ya1+znS
         tNWQ==
X-Gm-Message-State: AJcUukcSNe/UA6QKkCcFcPhRIYPqgl12T/rN5ESZFuj6u5n4bwNNmLV8
        JifQ8gWVjiyXwWo7XaK8PEvGQzY9
X-Google-Smtp-Source: ALg8bN68h5YFZD72ueQHK4o8rwRtRaRDHOXB0iqStU3F/w9LILd4+WOgexRTHZH+d8heUgMSVZyRoQ==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr7820073wmd.67.1547645407618;
        Wed, 16 Jan 2019 05:30:07 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/9] commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
Date:   Wed, 16 Jan 2019 14:29:40 +0100
Message-Id: <20190116132947.26025-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20181122153922.16912-2-avarab@gmail.com>
References: <20181122153922.16912-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index ab292e5d01..38b62051c2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -944,7 +944,8 @@ void write_commit_graph(const char *obj_dir,
 	write_graph_chunk_fanout(f, commits.list, commits.nr);
 	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_large_edges(f, commits.list, commits.nr);
+	if (num_large_edges)
+		write_graph_chunk_large_edges(f, commits.list, commits.nr);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.1.153.gd81d796ee0

