Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D77E20248
	for <e@80x24.org>; Fri, 22 Mar 2019 10:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfCVK26 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 06:28:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33412 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVK25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 06:28:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so1762690wrp.0
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+xe6PNWXnohX3HyYNaG38Njj56vo8zuH+PQfej8GQw=;
        b=f4hnGhABn2iGYcdu906z/1RCpu6wdOAXXd9j+mGIdESPS7t0yXiSIxItUk9RdyDvEt
         sjFJ0qyJ1+33VSduIuI3/GqgP+uvDZnCyLE1FBa1SCrbTDq1Xl06I7TqNULoxaatluYV
         YSjwbK2D/tgFQ+L+fC4l0No3lESbFvBptD+H9VCdfh6P02pn3uuri/JeGSbxQ3JKtT5L
         rxmlGf45zcBQAzZFm9vFtv0SpqfP0pcIlQkFhgxy9HGpX+yY+wWO2/mZ00zeNaduxwKW
         t0vuQAaN6XP/+VD2L5lkKU3QqUFVnBh3CfDCPkjtS0LnJ5GtbBvsIGOCbcd5odesfUp8
         hdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+xe6PNWXnohX3HyYNaG38Njj56vo8zuH+PQfej8GQw=;
        b=jseIGE25sYUoIuaNaUl0TlGE561QggHYHB0sh1DUmQ6i7Md2ruHFUA2CfgZjRBEwbh
         D4wqqSqtAKG/j7qn4a9nGacfdtXenfQSHkYzWbyw051gEVUXqLlnq5BI4YN2QcxTlSeb
         xD+j29O1ciuR8fZ7Z32ZM4CygjOAJNmWQWqg9I9e5U7DNOkI237uzs8ZTKuDqQpQ64fn
         AoNTy7iVuGIgtR3vYuJc6lV8oG+fkO5FF47rK3WsINVq0z+2AMAUV/2/rO3P3/jV5d0i
         bAX1NaAlrGqu28+H18GmGZCQvfqNwxk5OVgFsABnym8PhyUbj405TsZctjz9/HU3+4Vh
         XTLA==
X-Gm-Message-State: APjAAAVe2SQml46/OxHE2avJSCVQxeEnG4pHx0pufirdvMsuKifpsIjL
        /EfBN2ABAJRySR7xMt+C7Oc=
X-Google-Smtp-Source: APXvYqyHULB8V4eyEwA6FzgeNObNcPDtKxhJTMM+blMMy1KhGWQ+DA3JJk6qhvprX2JWllkRKFA2gQ==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr6027837wro.146.1553250536247;
        Fri, 22 Mar 2019 03:28:56 -0700 (PDT)
Received: from localhost.localdomain (x4db501f9.dyn.telefonica.de. [77.181.1.249])
        by smtp.gmail.com with ESMTPSA id 204sm12352591wmc.1.2019.03.22.03.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Mar 2019 03:28:55 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] commit-graph: don't show progress percentages while expanding reachable commits
Date:   Fri, 22 Mar 2019 11:28:17 +0100
Message-Id: <20190322102817.19708-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190119202121.3590-11-avarab@gmail.com>
References: <20190119202121.3590-11-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 49bbc57a57 (commit-graph write: emit a percentage for all
progress, 2019-01-19) was a bit overeager when it added progress
percentages to the "Expanding reachable commits in commit graph" phase
as well, because most of the time the number of commits that phase has
to iterate over is not known in advance and grows significantly, and,
consequently, we end up with nonsensical numbers:

  $ git commit-graph write --reachable
  Expanding reachable commits in commit graph: 138606% (824706/595), done.
  [...]

  $ git rev-parse v5.0 | git commit-graph write --stdin-commits
  Expanding reachable commits in commit graph: 81264400% (812644/1), done.
  [...]

Therefore, don't show progress percentages in the "Expanding reachable
commits in commit graph" phase.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 017225ccea..60c06ce58f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -672,13 +672,13 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 	 * As this loop runs, oids->nr may grow, but not more
 	 * than the number of missing commits in the reachable
 	 * closure.
 	 */
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Expanding reachable commits in commit graph"), oids->nr);
+			_("Expanding reachable commits in commit graph"), 0);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, i + 1);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit && !parse_commit(commit))
 			add_missing_parents(oids, commit);
-- 
2.21.0.539.g07239c3a71.dirty

