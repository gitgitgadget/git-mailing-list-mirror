Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465CF1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfASUVw (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbfASUVu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so18941510wrt.11
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yGvz4PfCVxMpFmK3i8eeRubVvP4JHN04hM8h8FInwE=;
        b=QZaFXp0hSxv6SeHd+rvwc48tZ5Lk1WCclJVG/LtlIpRyf7nQM42ZZB/EIft8CLyaKl
         CncZZa/3yVIQ3KKpFJuCxkxStihdnob3GinbikhTOBVj0NfisbMM9TN/L336xleRboyb
         kItV5cXYOUIiGRm9lth0H59VB/kP2R+3NN6B2/0u4qLxd+V3jnr9ps/MywhaetmDs22F
         4bLuooo0tsFIkkRnCgYUtXn5tHVQDNcwITxSCn/ZCFw7d5YvYVNjWsFmvfy9I3Ct+j25
         jVDGmmQnBfp7cbmE7utsRPacYoNoubOQUnje0/NKxsnl+cFErec88dzWmSMPOY/nMW3V
         svcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yGvz4PfCVxMpFmK3i8eeRubVvP4JHN04hM8h8FInwE=;
        b=pF4HTKMASNDn7kC6nN2oNA3Mp8PbucAcxLyfQ/LIIkVMMf5qTu6EOm3s+y4oIHNEC0
         HgmJ/0pypp+g47IYaZsr634ok2HbNo4ozF+OumniUuLDAYPF39Ra3TdMJOO0OjYRTReX
         rVnAidegNlO4lS9Edv6D0Acrf/sUrFe3He6+bTjLzkvlqEZGSNrQKy1UZO+fiy/upcD4
         03uEWKSKI8WDQJdYaC/6xTMdaMP6zA457YhfLmFovJPXcd0dJCZCpFUXsFC6DlXVhAQB
         eyRiBX9t/n33tlj6WXia+0tcD/Vpua+GqGlWYLnaUT5IqNSGVGWer+vID/82YkLsHP4U
         I4xw==
X-Gm-Message-State: AJcUukeMtEruSkG1xoYJx2vC5FUiVhrvJAP8fWVtmtJYLIW71MZDdeD1
        SUZ1Ap9lfNiZo6nfYpvZrUKMFo8JmY0=
X-Google-Smtp-Source: ALg8bN5rh0qbGXnXdv1kSxua/wiO9GMpCu+11P1h9PSNE2thJJd4FVMxHT9fJJHTjeP/Xleim8QDTw==
X-Received: by 2002:adf:b243:: with SMTP id y3mr22321251wra.184.1547929308189;
        Sat, 19 Jan 2019 12:21:48 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:47 -0800 (PST)
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
Subject: [PATCH v6 06/10] commit-graph write: show progress for object search
Date:   Sat, 19 Jan 2019 21:21:17 +0100
Message-Id: <20190119202121.3590-7-avarab@gmail.com>
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

Show the percentage progress for the "Finding commits for commit
graph" phase for the common case where we're operating on all packs in
the repository, as "commit-graph write" or "gc" will do.

Before we'd emit on e.g. linux.git with "commit-graph write":

    Finding commits for commit graph: 6529159, done.
    [...]

And now:

    Finding commits for commit graph: 100% (6529159/6529159), done.
    [...]

Since the commit graph only includes those commits that are packed
(via for_each_packed_object(...)) the approximate_object_count()
returns the actual number of objects we're going to process.

Still, it is possible due to a race with "gc" or another process
maintaining packs that the number of objects we're going to process is
lower than what approximate_object_count() reported. In that case we
don't want to stop the progress bar short of 100%. So let's make sure
it snaps to 100% at the end.

The inverse case is also possible and more likely. I.e. that a new
pack has been added between approximate_object_count() and
for_each_packed_object(). In that case the percentage will go beyond
100%, and we'll do nothing to snap it back to 100% at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7c639c6a65..3124dfae13 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -785,12 +785,14 @@ void write_commit_graph(const char *obj_dir,
 	struct progress *progress = NULL;
 	uint64_t progress_cnt = 0;
 	struct strbuf progress_title = STRBUF_INIT;
+	unsigned long approx_nr_objects;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
 
 	oids.nr = 0;
-	oids.alloc = approximate_object_count() / 32;
+	approx_nr_objects = approximate_object_count();
+	oids.alloc = approx_nr_objects / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
 
@@ -871,9 +873,12 @@ void write_commit_graph(const char *obj_dir,
 	if (!pack_indexes && !commit_hex) {
 		if (report_progress)
 			oids.progress = start_delayed_progress(
-				_("Finding commits for commit graph"), 0);
+				_("Finding commits for commit graph"),
+				approx_nr_objects);
 		for_each_packed_object(add_packed_commits, &oids,
 				       FOR_EACH_OBJECT_PACK_ORDER);
+		if (oids.progress_done < approx_nr_objects)
+			display_progress(oids.progress, approx_nr_objects);
 		stop_progress(&oids.progress);
 	}
 
-- 
2.20.1.153.gd81d796ee0

