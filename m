Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C521F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436851AbeKWAIB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55782 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436840AbeKWAH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:07:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so8911646wmc.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZMbiccRM6UYVJfNDn+I7hL2sDEeAx0TWmuHfPrTITo=;
        b=N5ErTXsBV1N7Cdx96FBz7dpDm+0p6UxBpbPnhBqWw09V7q2pwYEEvjWyvM4yd6FMzV
         AE1bbEGPwbi2QpgO1vycnkz538GWXUwsgyd0zwyQh9E1mQKymFJrDvZxHErLgneF0Lug
         VQOr2J5pDQqUhSaEe9n3DdBGatgBsdaTOng7nR4RHKTEGwf2uN4TAdKid2c1azf+bm4t
         Tw5V6wi01wAQKrZ6Qmr0g7K7GSjJRNwJW7kAoHgPzD39eh6hXcvffmbF46Blc+QHUg2h
         dmFlD2VrA4p9lBs3Jh5W69/ieXE0LrWOzKK++ZCJD6VML2dZc8f9ULDf+v2Uzh6CORFo
         IYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZMbiccRM6UYVJfNDn+I7hL2sDEeAx0TWmuHfPrTITo=;
        b=iP9meXxIU4wjV4MJ6rW2zlPiECR4lWXt5zGhwe/brxRAwycnwsBL6gln020flDAbGu
         2l+ZPp0Vo+KuBVEgCERtvpseDpLTxDd0bHnibZmId9iPpvpQRhQKj7eto7SEgmuy9kAK
         tZCgDTCPSADc2SUvokuPYf2l0atZvFPk9Qhq4Y/1nWs19B6ngfw5tERH22oJEjd7/gJi
         B4XO14/YmqQ0VRRLv/hBk+F5j520qDPQCuWS8ob6o5TXqFIJJD2bjC0IECPMt0x2OgXG
         10IMSgJN3sSa/3JobvqeXAlCVj6kqjIm1jjA0JZVEJHsfxEVOVKWimANYvriht92xMIm
         JJbA==
X-Gm-Message-State: AGRZ1gIadEj+njdd5n9oV4ZgFIf8COeTaF20L1rwM/4KcCjfOWDYkhME
        hGiQM8VBGwWZgNASdpHGKIOKOyvy
X-Google-Smtp-Source: AFSGD/VlTnqgYuPwC3TzpA+tsToKUGnuaqEOo3mExEhE6iQDgDIeiA9l/exMvMS6aSwDeEAy/vU9Xw==
X-Received: by 2002:a1c:d08b:: with SMTP id h133mr9647314wmg.8.1542893315377;
        Thu, 22 Nov 2018 05:28:35 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:34 -0800 (PST)
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
Subject: [PATCH v3 02/10] commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
Date:   Thu, 22 Nov 2018 13:28:15 +0000
Message-Id: <20181122132823.9883-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181121012600.26951-1-szeder.dev@gmail.com>
References: <20181121012600.26951-1-szeder.dev@gmail.com>
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

