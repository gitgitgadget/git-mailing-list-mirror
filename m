Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247691F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436875AbeKWAIK (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40885 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436868AbeKWAIK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so9096720wmf.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAQNtl0wQPq2/iqzkGlKQ3h4QraiGznQoYz2HPAhxsc=;
        b=ALApmU5SYQ6FfDP6WAGhb5RqIGTPDg0dtaATi7Pj5a3ZLlg3yM5RKZpoJ4cDjL7MgG
         I75rdqbbuVDLmBXepo4Sz9pYDQkxqnYLWdiB9ulqPTld0+2XVGk3c3smdTZoOcpDR/sm
         kaS61/6g0aBELliQeebkV2MI20MbgzMjkRFihNiTLCSlX2p79SKNrPiC/8/0rzbI0cuy
         22eRG1n5uccVEGA6tA4zg1PDc2WkkzYjrEbUQKnsEbRcebuOOnf8f2GL9Vp+aEtjoHeZ
         dapE8apUSlVajQcKiAI8w8HkPHaMbld1tHkQfExjWr11Eb0K9B0vBSG3GeAE30SecqtO
         64nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAQNtl0wQPq2/iqzkGlKQ3h4QraiGznQoYz2HPAhxsc=;
        b=APcqQfsUz3feg4V8YcDRvQj1qVbHq8ZBHw8X1bu5lB5ABZquS+zVJ4T1zDiajhzBFL
         V90omNqIt7JtWzyGkH1L0dxt74tzZnIKC6FGK7XTn6yauqmqq32P7GwYewslOIqMM5fZ
         itlTOZnj/4jW+5XjicK5i+hTs1vwoTWh4iJ06zurVqZ1c07K+cQ0+H8D1BzrFayjVM+T
         0HkGjzHeW+NgPBp2+K/55Is/TGeRdqtEAag+O+n3lrCxJX2rMEp/NxY4Tjuklv8BZgFJ
         /mU3wNVtV0effJ73UIVS1KwJ/qVHBzrUbNQdzamXAB6Gq/fCUtwpzt/eDqwibYE3FCst
         edoQ==
X-Gm-Message-State: AA+aEWb8a0xOnIlqG4iHPDUUH8VjlPlgcEnwHf+2juZ+l1U4xMqGoR9c
        oFZLVaodAXD+pwR67UODSMTXd3vssu8=
X-Google-Smtp-Source: AJdET5f3grfg9t4z7bogtbPwuMsn3f3DtdrLzwVEGsTuypwpzfHS5wgWH4LMhXNjG/Vwocl2eiPBdw==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr9792109wmh.118.1542893327748;
        Thu, 22 Nov 2018 05:28:47 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:47 -0800 (PST)
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
Subject: [PATCH v3 10/10] commit-graph write: emit a percentage for all progress
Date:   Thu, 22 Nov 2018 13:28:23 +0000
Message-Id: <20181122132823.9883-11-avarab@gmail.com>
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

Change the "Annotating commit graph" progress output to show a
completion percentage. I added this in 7b0f229222 ("commit-graph
write: add progress output", 2018-09-17) and evidently didn't notice
how easy it was to add a completion percentage.

Now for the very large test repository mentioned in previous commits
we'll emit (shows all progress output):

    Finding commits for commit graph among packed objects: 100% (48333911/48333911), done.
    Annotating commit graph: 100% (21435984/21435984), done.
    Counting distinct commits in commit graph: 100% (7145328/7145328), done.
    Finding extra edges in commit graph: 100% (7145328/7145328), done.
    Computing commit graph generation numbers: 100% (7145328/7145328), done.
    Writing out commit graph in 5 passes: 100% (35726640/35726640), done.

And for linux.git:

    Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
    Annotating commit graph: 100% (2391666/2391666), done.
    Computing commit graph generation numbers: 100% (797222/797222), done.
    Writing out commit graph in 5 passes: 100% (3986110/3986110), done.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index a6e6eeb56b..c893466042 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -660,10 +660,17 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 	struct commit *commit;
 	struct progress *progress = NULL;
 	int j = 0;
+	/*
+	 * We loop over the OIDs N times to close the graph
+	 * below. This number must be kept in sync with the number of
+	 * passes.
+	 */
+	const int oid_passes = 3;
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Annotating commit graph"), 0);
+			_("Annotating commit graph"),
+			oid_passes * oids->nr);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
-- 
2.20.0.rc0.387.gc7a69e6b6c

