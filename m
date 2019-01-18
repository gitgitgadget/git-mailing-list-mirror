Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E371F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfARRGH (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:06:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37569 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfARRGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:06:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so15940514wrt.4
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6gdPcIFguEaLY2jATW4ZxoHaMwJmr2lE7kldC1VQ3s=;
        b=uy3XJFeLOEkijVcV5fVQAY50TAPi7HttllfQSrFBq2SF3DflQdQ9vcUkCqabi12ulb
         BSZgJbfajOqb1p8S6/7slhk0IdzC3nGvy7W0NUfGi3mfvg4f5ZNrIqQeEnT7VqnZXAO/
         F5fcGtc+r0qfYreqzBKr2Lq/VqEEKQcmxp9+ubkDwbS5JnnEFrKMPM4kOXwNSV9cAnRe
         jm/jeXzPctDM6Rvsu8qM1P8nE81Mp6up5YNIvKefTsJabLFcL2hHiqN5YnN81FXr4jg1
         dIzJotuprGRiU7RecI+ugdbjiaELHu7Ae7jfzoAHgMEWxGiOq1g3W5nxqzZc5MbRKTAx
         KCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6gdPcIFguEaLY2jATW4ZxoHaMwJmr2lE7kldC1VQ3s=;
        b=GPxVrOBtDSdrqcLFAZxBhH9aW3o0dfltGp+8r0X5qvcMU6Rf9oeCRgrVLmZIeVIIwf
         rMhATSyVb2rHVuTG6GVT4XczJXBQx+ROUwFZ+xfkkDG3rZLpUysIiNKt9OpELFOGGhxc
         wG3KoSCwgGFm761ZqNNiIHcXgaotQxC5pn66emqvqsbs0BQRl5b9d4FovuJp54D/Yin6
         ho0ikjNdr/xlkVTEMbEYZ/nOtZeLp1ikzb7yi1HJ08tQ6JLXVDgAxV43Qru1QMo0W+/s
         3iuNUyslbfT4El6Oet4vX+Uj43nFozl4V2+ED66CXvTJyiO1EBHcC2vz3H1vyBYVhuoJ
         Tvgg==
X-Gm-Message-State: AJcUukfDXf8XW5egAQPCy0hCpBi0h6lcwSeeiMtnnX3ZESPVeRh3NtO3
        392HIInA4NAKwVQKXvXZusM=
X-Google-Smtp-Source: ALg8bN7LZ+ySbUMRmQKBO7+AFB+DMUt5NCHVOZdb7ZHeyoTBdCaYeviwxFRQOUhqIVtiopBDkpekCQ==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr16976028wru.226.1547831165508;
        Fri, 18 Jan 2019 09:06:05 -0800 (PST)
Received: from localhost.localdomain (x4dbd9ead.dyn.telefonica.de. [77.189.158.173])
        by smtp.gmail.com with ESMTPSA id x186sm50476023wmg.41.2019.01.18.09.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Jan 2019 09:06:04 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/2] commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
Date:   Fri, 18 Jan 2019 18:05:49 +0100
Message-Id: <20190118170549.30403-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <20190118170549.30403-1-szeder.dev@gmail.com>
References: <a82a2bec-07f5-ccd2-85ab-b9efd406929e@gmail.com>
 <20190118170549.30403-1-szeder.dev@gmail.com>
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

However, when it later comes to writing actual chunk data,
write_commit_graph() unconditionally invokes
write_graph_chunk_large_edges(), even when it was decided earlier that
that chunk won't be written.  Strictly speaking there is no bug here,
because write_graph_chunk_large_edges() won't write anything if it
doesn't find any commits with more than two parents, but then it
unnecessarily and in vain looks through all commits once again in
search for such commits.

Don't call write_graph_chunk_large_edges() when that chunk won't be
written to spare an unnecessary iteration over all commits.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 544d6b8b4a..bf9eb44ca9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -940,7 +940,8 @@ void write_commit_graph(const char *obj_dir,
 	write_graph_chunk_fanout(f, commits.list, commits.nr);
 	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_extra_edges(f, commits.list, commits.nr);
+	if (num_extra_edges)
+		write_graph_chunk_extra_edges(f, commits.list, commits.nr);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.1.499.gf60de1223c

