Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691581F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfASUV5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33002 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfASUV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so3362602wmh.0
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rm9+woAdDa4oRH3tO6XwiozqZ01ZHYXmDWRkXBwcn2k=;
        b=EtYLvhvODOuhVVNmh1NiKDiiQl+reVB1cIRD9OiMTRZ9Fr8cjHqONCc15uZehS7FNO
         Sj6h8vpOxb7Xb4lrM27bQJiLeJ/xRFMlWtSXYXP1PSKcKpCph7WyiOKgVsJz64xftiB/
         G0NzdEtMYCf2f3uE1DX9Pjoj6GOPR3IIEjU3x3sDUMAXtlmx6pBxBCG4kb9IFqHmTAzF
         Ha+O+kZq7zUdxWFznpT1OKzb5TTqznDDIjchqw9aiTn/VPpToJTDsYNg+n0pVmh9FNDo
         3JvrQtibuiSeIEcRLHKL7gdou38VZ6IPiBvI+XP72Y/tNLWbRVMWACU0H7kjcrH4U/MN
         VSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rm9+woAdDa4oRH3tO6XwiozqZ01ZHYXmDWRkXBwcn2k=;
        b=DqhSPZBVTX5YynPmJcaTuWR+5sKSHkk+EOIq9hJsL/6CdSxeMUlqwYwZemsCp6LZgG
         +IEmTyWpRHYepxjrkw+7+exuRXUyDxuCgJvyfRDLtrQwzapkB7Bio+RxIWNdqzQakqvI
         4Dp01fRuttvcvxox+Ah1VjWe+bYsbfDijCUmx5cx1cPAOoVp1if05/aal4Ze+8Nbtu1t
         LOjvh6iKW8kgkQg0+B8CHJc0Ja9DAniLZx6s7WhLnc7+40MqqTsJzJbExxgFtfe/alA9
         utz8W0jXdAqRbcNOIwYFe5xX2Ra0abMdXjJ0ap4THPPa2ZsdWgluKMVatJOZSJpEeYF/
         3KsA==
X-Gm-Message-State: AJcUukfvcB3QFx+Bg+YUoDspX90jKqIJZA9fJPOaX7g15JuFHhEBqH74
        0PLSFiyGFXZmBTGvxr/RXj5FkffEIng=
X-Google-Smtp-Source: ALg8bN6FL5TYkU2joKDqDkhWH+Rrx2FojOFiFjEiYXeIcRx7v37B2z11T4kWU9nl2nWl0FjOniJZAQ==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr19476448wmg.55.1547929313803;
        Sat, 19 Jan 2019 12:21:53 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:53 -0800 (PST)
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
Subject: [PATCH v6 10/10] commit-graph write: emit a percentage for all progress
Date:   Sat, 19 Jan 2019 21:21:21 +0100
Message-Id: <20190119202121.3590-11-avarab@gmail.com>
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

Follow-up 01ca387774 ("commit-graph: split up close_reachable()
progress output", 2018-11-19) by making the progress bars in
close_reachable() report a completion percentage. This fixes the last
occurrence where in the commit graph writing where we didn't report
that.

The change in 01ca387774 split up the 1x progress bar in
close_reachable() into 3x, but left them as dumb counters without a
percentage completion. Fixing that is easy, and the only reason it
wasn't done already is because that commit was rushed in during the
v2.20.0 RC period to fix the unrelated issue of over-reporting commit
numbers. See [1] and follow-ups for ML activity at the time and [2]
for an alternative approach where the progress bars weren't split up.

Now for e.g. linux.git we'll emit:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
    Expanding reachable commits in commit graph: 100% (815990/815980), done.
    Computing commit graph generation numbers: 100% (815983/815983), done.
    Writing out commit graph in 4 passes: 100% (3263932/3263932), done.

1. https://public-inbox.org/git/20181119202300.18670-1-avarab@gmail.com/
2. https://public-inbox.org/git/20181122153922.16912-11-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 889cdefc49..017225ccea 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -653,15 +653,15 @@ static void add_missing_parents(struct packed_oid_list *oids, struct commit *com
 
 static void close_reachable(struct packed_oid_list *oids, int report_progress)
 {
-	int i, j;
+	int i;
 	struct commit *commit;
 	struct progress *progress = NULL;
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Loading known commits in commit graph"), j = 0);
+			_("Loading known commits in commit graph"), oids->nr);
 	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, ++j);
+		display_progress(progress, i + 1);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 		if (commit)
 			commit->object.flags |= UNINTERESTING;
@@ -675,9 +675,9 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 	 */
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Expanding reachable commits in commit graph"), j = 0);
+			_("Expanding reachable commits in commit graph"), oids->nr);
 	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, ++j);
+		display_progress(progress, i + 1);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit && !parse_commit(commit))
@@ -687,9 +687,9 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Clearing commit marks in commit graph"), j = 0);
+			_("Clearing commit marks in commit graph"), oids->nr);
 	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, ++j);
+		display_progress(progress, i + 1);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit)
-- 
2.20.1.153.gd81d796ee0

