Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6941F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393178AbfAPNaV (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50245 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393158AbfAPNaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so1995416wmd.0
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cxa4SSIuR7pbrMARIgZVDIxmMdjMX0GROeVkZ+dhHF8=;
        b=i4+8WFjL+MLjQk2iUNQ8YhB6JjjvgotItVH9GkOp8YYmY6KMK25wzINgsFyKufDUFV
         wTiLSXsbalD3lF9bIQGElXWyOkMWxpR3k3AU3N10YQVGQx7J5psKkp+Zu2K1qTC/NlXC
         sl/dUxLaCtqkxRwg+2gAt568uPcHk7Zar8umo5c3f/uKSmfjzhNDtD/qxwe5bvWb4uKg
         QedFWyTeRjI3pTLgP8QhhTREK/YPEkJGS8ScPtUpkaUVbLmd17X9gnnYKRf6Qc1X1Cyt
         z3t7l0ZDBqS4RDeWWbr6YHMJq9ylRL7giroX8tqw3XLGPBvYFPzX0R0tcQzYwST6XC2O
         TvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cxa4SSIuR7pbrMARIgZVDIxmMdjMX0GROeVkZ+dhHF8=;
        b=V06Tdiu/Fowi2dGNy9RG3mMesRaDSAtMCXjLY3QoW1dZ7RroZPO5vD7kY8onHWtnMO
         TJ9eRi1usCEXTOeI39puNZZ9XFtFjOInamm2qpFaA8mo3W6B+otHnkMCxdHgMaHHMcI5
         6nBYEsdMSbbh95UXmLpC6oaLX3f8axvMLPwHpIukgTLmrtQAuGbPh40OxWKEsYyln39B
         kiDUigp+iR7kFUAk5Z/s+MIOSi6ry4pbA1JtjSrv58xOOftZV9IFPCQrknDPoEsPDUCb
         U0weCcUuaKZ1OcFWtahET3Zjy24qKu8Th5G1h5Dv5s0UIVHOzuAptosmFQ43NQvdVV2M
         V17w==
X-Gm-Message-State: AJcUukeKiE2fUHPr7mn2Hn3jiv/QHJYmwqgvn4n2STpdQ9aocsYVh5fY
        8RtCbXrdMeG9gpxFe498eGed7QFP/zE=
X-Google-Smtp-Source: ALg8bN70aYf417IXFdFEyCUMNCE73H2DdfDVIqPkyaachsSXoMGmlMK0mKev+9LO3499Z74EL7X9vQ==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr6989422wmc.133.1547645418508;
        Wed, 16 Jan 2019 05:30:18 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:16 -0800 (PST)
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
Subject: [PATCH v5 6/9] commit-graph write: add more descriptive progress output
Date:   Wed, 16 Jan 2019 14:29:44 +0100
Message-Id: <20190116132947.26025-7-avarab@gmail.com>
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

Make the progress output shown when we're searching for commits to
include in the graph more descriptive. This amends code I added in
7b0f229222 ("commit-graph write: add progress output", 2018-09-17).

Now, on linux.git, we'll emit this sort of output in the various modes
we support:

    $ git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
    [...]

    # Actually we don't emit this since this takes almost no time at
    # all. But if we did (s/_delayed//) we'd show:
    $ git for-each-ref --format='%(objectname)' | git commit-graph write --stdin-commits
    Finding commits for commit graph from 630 refs: 100% (630/630), done.
    [...]

    $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    Finding commits for commit graph in 3 packs: 6529159, done.
    [...]

The middle on of those is going to be the output users might see in
practice, since it'll be emitted when they get the commit graph via
gc.writeCommitGraph=true. But as noted above you need a really large
number of refs for this message to show. It'll show up on a test
repository I have with ~165k refs:

    Finding commits for commit graph from 165203 refs: 100% (165203/165203), done.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f0bcb3c690..c6f8e73980 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -822,8 +822,12 @@ void write_commit_graph(const char *obj_dir,
 		strbuf_addf(&packname, "%s/pack/", obj_dir);
 		dirlen = packname.len;
 		if (report_progress) {
-			oids.progress = start_delayed_progress(
-				_("Finding commits for commit graph"), 0);
+			strbuf_addf(&progress_title,
+				    Q_("Finding commits for commit graph in %d pack",
+				       "Finding commits for commit graph in %d packs",
+				       pack_indexes->nr),
+				    pack_indexes->nr);
+			oids.progress = start_delayed_progress(progress_title.buf, 0);
 			oids.progress_done = 0;
 		}
 		for (i = 0; i < pack_indexes->nr; i++) {
@@ -840,14 +844,20 @@ void write_commit_graph(const char *obj_dir,
 			free(p);
 		}
 		stop_progress(&oids.progress);
+		strbuf_reset(&progress_title);
 		strbuf_release(&packname);
 	}
 
 	if (commit_hex) {
-		if (report_progress)
-			progress = start_delayed_progress(
-				_("Finding commits for commit graph"),
-				commit_hex->nr);
+		if (report_progress) {
+			strbuf_addf(&progress_title,
+				    Q_("Finding commits for commit graph from %d ref",
+				       "Finding commits for commit graph from %d refs",
+				       commit_hex->nr),
+				    commit_hex->nr);
+			progress = start_delayed_progress(progress_title.buf,
+							  commit_hex->nr);
+		}
 		for (i = 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
@@ -867,12 +877,13 @@ void write_commit_graph(const char *obj_dir,
 			}
 		}
 		stop_progress(&progress);
+		strbuf_reset(&progress_title);
 	}
 
 	if (!pack_indexes && !commit_hex) {
 		if (report_progress)
 			oids.progress = start_delayed_progress(
-				_("Finding commits for commit graph"),
+				_("Finding commits for commit graph among packed objects"),
 				approx_nr_objects);
 		for_each_packed_object(add_packed_commits, &oids, 0);
 		if (oids.progress_done < approx_nr_objects)
-- 
2.20.1.153.gd81d796ee0

