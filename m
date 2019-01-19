Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB101F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfASUVq (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37748 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfASUVq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so18996951wrt.4
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UsNJrMfSJ2qH96rKs6jpLOozL3dh50Gq/oVHrSTAsxY=;
        b=jqeXFOyFKLn1SKeCJx9ueM23SmB1HmYuv43Hlmh61rQfeTX9/PtMGyGBF35Tc2MLGQ
         Mf2Uzxmn5v4mylixg/5baV/XM5DAwErfADjB2J6aGbg31g9KwH/VYBEdjVxi2UDJ2VkG
         e65LPATnpY7nCR+9pIKGrS6UG0D2iWl8GL7TNQrltLuOwhGEsKYcTnLurVAKolhRY7R9
         tOlfbulvdrG/R85aEvCxS4MW7zgC3DO1p85lIKsgeyFLp3lRNXmTc1pXTGLxclRERE0i
         zv8cnFAkIV+2Lfdbo5l1eTNNvkdbuQxnt64VeGQhRjenZPW82DGMOuVqNXVxjIBovZug
         oB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsNJrMfSJ2qH96rKs6jpLOozL3dh50Gq/oVHrSTAsxY=;
        b=Vb6JXcb4d7LPtTGFXt+Hgh54IcgIkoAO2oj7Q565IogZoCq+NPNfej0MJhVl01kKza
         CQjDXsm+j+gnhsL/IRLRMQpQzeSj/OMEcTG+hPEgi1hdIa/8BWUeWv7qLuef2GxF56sb
         Sqd7+fpLPUDlnrE2yJgmiiBqIDZS2cfLZ/NfQbHF8xwuHmISscYh41mf2UpNdN5ptwQX
         BuwYSJAgbyHv8BPMzSEmrXjcOXI+IyBexciPtQceOdOiOHuf2KDpLFQDS+nRLsCsmLnh
         AoR7O+kT8AI43J41fDxGvYOTxTa1PQvIctyfvLch14MqwLlkfNjDk0Rju7E+VkyPTCMS
         7rTw==
X-Gm-Message-State: AJcUukdJHhyyx0qJPv6MRW+IDogz6IfZqKss6nifzkONwkRCcsLgTuTs
        CNf7aNKu/lxJp5MT/nfFLjhTvHsvpXo=
X-Google-Smtp-Source: ALg8bN4B38JuRWRqOekzdq+eT5wneftFbcMmN/MPGFaEnsTr2CwRHSirgLpWVxQdrmkX5kNj9tBIMA==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr21704745wrt.180.1547929304209;
        Sat, 19 Jan 2019 12:21:44 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 03/10] commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
Date:   Sat, 19 Jan 2019 21:21:14 +0100
Message-Id: <20190119202121.3590-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190116132947.26025-1-avarab@gmail.com>
References: <20190116132947.26025-1-avarab@gmail.com>
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
index c5c6ab5367..e733ba180a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -946,7 +946,8 @@ void write_commit_graph(const char *obj_dir,
 	write_graph_chunk_fanout(f, commits.list, commits.nr);
 	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_extra_edges(f, commits.list, commits.nr);
+	if (num_extra_edges)
+		write_graph_chunk_extra_edges(f, commits.list, commits.nr);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.1.153.gd81d796ee0

