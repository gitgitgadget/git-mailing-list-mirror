Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C2F1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 17:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfAWRve (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 12:51:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWRve (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 12:51:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so3530624wrs.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 09:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/7lW8u/KmbSt9n3dcAKLLdZ7x710jLJ5a0FHMoTevY=;
        b=lhlr/xPZxcDs/vxxZ6G0pOldRKuBsedbpul63UwITAVBSd/lmmpV/nTcvCMWdbBy3z
         Std3ATSDOPhWwo/dDFDntXHlAvL/M1Yl18LuzfEWubF4PgjbEwtJHzPwwA8usX4mY0L3
         O/7dbOSUJUlBGytYGu9MIwNzZQYOvWyMgmDIWp7o9+uNZdpmOEIhjrhykOiWHPsK2P+d
         LPJBEKW90Esm+LsKLbo1Za2n7UPWS57gg6fn1SvsD/mM9Se5tHcroZNnn+/Jt6ZyEuIC
         0PMDv56D3Qi/tbHO05F+1Jp1HGNLuhfdHMJC5Xqax8EaMdibfIx99prv1OsI42u7gm63
         PYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/7lW8u/KmbSt9n3dcAKLLdZ7x710jLJ5a0FHMoTevY=;
        b=MYZJPwS6Xd5fq+HT8vyNObg+WwDbaGmfFqplaA3XogihGJBqrAmqbQr9RKdQG1WRn/
         A5rz25B4exYLcQY3fMPmljexboxT+b4xrdsoOlLNtSU7JlQCcJCcekMMP98gotBwghuC
         jzskrO3IDWzjUfLj4GRF3l5AqIIHealrjDklmYMq+x1a/GZNAXkVwPp7RUhQoboyQPZQ
         CM8DuFQ34ciwWMoD8q/PKg0QPiNqgF2g0gq9GIAXa4TxXS32y/Us1IdttAEL8xUX8XIX
         Nb/5IlS5EuaORgE2bPUbHxM9rmk63M9nQc/1+xFA/06mhTmNY+RMwztvRmQ4S++m30fs
         Etfg==
X-Gm-Message-State: AJcUukdfdGM+OXf6KwdZIBuQQV861DJCAOP/XaNlUXEZ2iyS3RJgQUMV
        fLjkUFQEkOfNCB+Pi/lDc98=
X-Google-Smtp-Source: ALg8bN7LuCG++kMuN0/TK1G2ene7Ac8YvqfRnvk7LD4bhTDRe9jKVPxNwnfYytveobw74iVi5ccW3Q==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr3732458wrp.111.1548265891940;
        Wed, 23 Jan 2019 09:51:31 -0800 (PST)
Received: from localhost.localdomain (x4db59613.dyn.telefonica.de. [77.181.150.19])
        by smtp.gmail.com with ESMTPSA id p4sm83877983wrs.74.2019.01.23.09.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 09:51:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6.1 03/10] commit-graph: don't call write_graph_chunk_extra_edges() unnecessarily
Date:   Wed, 23 Jan 2019 18:51:22 +0100
Message-Id: <20190123175122.30649-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.642.gc55a771460
In-Reply-To: <20190119202121.3590-4-avarab@gmail.com>
References: <20190119202121.3590-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The optional 'Extra Edge List' chunk of the commit graph file stores
parent information for commits with more than two parents.  Since the
chunk is optional, write_commit_graph() looks through all commits to
find those with more than two parents, and then writes the commit
graph file header accordingly, i.e. if there are no such commits, then
there won't be a 'Extra Edge List' chunk written, only the three
mandatory chunks.

However, when it later comes to writing actual chunk data,
write_commit_graph() unconditionally invokes
write_graph_chunk_extra_edges(), even when it was decided earlier that
that chunk won't be written.  Strictly speaking there is no bug here,
because write_graph_chunk_extra_edges() won't write anything if it
doesn't find any commits with more than two parents, but then it
unnecessarily and in vain looks through all commits once again in
search for such commits.

Don't call write_graph_chunk_extra_edges() when that chunk won't be
written to spare an unnecessary iteration over all commits.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This is basically a s/large/extra/ in the commit message, as pointed
out by Martin somewhere upthread.  The patch is unchanged.

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
2.20.1.642.gc55a771460

