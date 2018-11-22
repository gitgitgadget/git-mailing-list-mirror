Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232031F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437784AbeKWCTc (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35254 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731999AbeKWCTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so9704922wrb.2
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZMbiccRM6UYVJfNDn+I7hL2sDEeAx0TWmuHfPrTITo=;
        b=Mj4Va2wUPBn72vzBg7kGFh+AxoVYpRhnqAKCKO/7Sf+/nyre1QoYXojSNw2j5DK19V
         TZ1fA7NH+MgQAiNhQC9zR0xJJo5Gub2k1X4HnrMsdVu641lZpZ9CgxE7uPtek0P0vzUv
         /F8AQLPl1Olmhj5ZRxUebDVZPbC92SaboNc32dS/C2gIVucFRRwKEj1IWSqY1DRrTVbd
         qcxC6e7Mls5C3B+/CvcTSRUXSyiDpI/0iT7jM1ZBzwCJybIWyO1pJuV3yIPWdBit3oVY
         ef4tbGoRGhvydFD+Yjzp9aS10dsn67o3OEEmU2qDeHoiRDTZkgqw/4b6n4eXVaf42+i0
         yiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZMbiccRM6UYVJfNDn+I7hL2sDEeAx0TWmuHfPrTITo=;
        b=HZ6xJa7N9EumNtPaHgWbQrT2ixurqRfMAoOIMVrPODpP+ase+Jh51YfpDKh4W+0R+D
         81XJMLVU1kcXm6MKNw4MtqFo/JI0gW48KZHb6Yz3O0JXnBCT4H8jMHcC72cF+5Yf/LSJ
         RO1uirPMUXxUpoNS3nnOsDLqV+8Cr+2NTEwEEFW3+ShoAeMeB0WJdw5/fHK2uN/AMSCh
         hZunHx8WyFcuoD/hAenYz6weAVaO2QEphrHeZl55aLl+XiR86LZKnyTJUYXxf+t23/oF
         rxK6z2o1D9vWbRjelVwk9qRFtCupFXLrjP/+lwcXKIdiSm+YTUij6qR7RUPIKqNLCVxt
         s43w==
X-Gm-Message-State: AA+aEWYrU6A5OTguRVOcTwtv+TybMOoC3iRq4V64n87nzodklNOZRnW/
        advkqhniQhCNropWITBFTQBg2ofNrOQ=
X-Google-Smtp-Source: AFSGD/WQal1FTb+jsfOui529BfT8neuzkagz7cms1w0LWz9/RYTYIe8cBsykVJy9Cjpl3w//VLqWuQ==
X-Received: by 2002:adf:e9d1:: with SMTP id l17mr9645837wrn.73.1542901176776;
        Thu, 22 Nov 2018 07:39:36 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:36 -0800 (PST)
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
Subject: [PATCH v4 02/10] commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
Date:   Thu, 22 Nov 2018 15:39:14 +0000
Message-Id: <20181122153922.16912-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
References: <20181122132823.9883-1-avarab@gmail.com>
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
2.20.0.rc0.387.gc7a69e6b6c

