Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA211F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437804AbeKWCTk (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38336 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391765AbeKWCTj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so6211859wrw.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYMxWgScE7YnkHE220fRPaP6PpCZGeCHVYzI+5d38D4=;
        b=qzb4TajYgU8zwDMduqs1EVzlI0Au7HsMyHyvw7mIUjqAeRI+9OQ5nWb0mv/i4VjPPd
         JgH/tOt5H1iKuOzK+PCmeokvyyYwqXWiSF74F3o+/jLaqRC4fVkDfhs2TyjrUiJv0HvC
         9mbOwF0xyWK/V6+XNoOC5/CKBiFUBd3qesVDbMZwTo0bXhIzeKndpwC3d8G0RBo7RmSc
         f3t66ns1zncI6nIROAnkMbjphcLABMd5R7QFiYPGiNbbXHs7rtAKtZewbrvpPyLb2Jkt
         QDd/Y7ZUcS19c80mWp4+kON/Wj6OEPMOSyhQgbfmfbsZGwr0wt8GyeFA1SH/kTLLAvHn
         w59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYMxWgScE7YnkHE220fRPaP6PpCZGeCHVYzI+5d38D4=;
        b=ukCFE2Enay8kNDVNg+ceYzOP9Dl6kDViMBhgVVeMaDeB/Vo6XPj8MFGjJw1EfjQPLO
         qKOXaS9xZISGkA2ylYxDcP7xP+v1djYkVXVynNmGWZ4zSyH8qHO6jrjxTQVKM6F6+wu5
         IOUchQl9glIg8Jq+P5/4ZjrDUUY/GG5kz0qm/F872LRir7wWiG+zmex16P/loUOnXXgW
         6myNr5dhCqcBdsAqjQUvRL0dnObu1NP8Y+KHrkr6qgH8sdb8JLowD4DfDF6feszNiLhd
         QdwjVJ8EY8r4Fgneq1ISDWthd656moe2FGR16n3rZ7UNjdvsbW92jtk83P/l0VsAwcOr
         47UA==
X-Gm-Message-State: AA+aEWarz6HmUl383STaF4Yk59exACtaYIr9Xpnpf+EAATPTcyJJBhRn
        sECAiNhiLasqSK66oRhmbWpDm1vV4yc=
X-Google-Smtp-Source: AFSGD/WiwA6VbsDYlUCWp2vXRv7R6J2W1DGp1vf+lVGhqCNJ8529LR9QCutgt4TBQ/U+d5VEuCMjTQ==
X-Received: by 2002:adf:9071:: with SMTP id h104-v6mr10074656wrh.65.1542901184738;
        Thu, 22 Nov 2018 07:39:44 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:43 -0800 (PST)
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
Subject: [PATCH v4 07/10] commit-graph write: add more descriptive progress output
Date:   Thu, 22 Nov 2018 15:39:19 +0000
Message-Id: <20181122153922.16912-8-avarab@gmail.com>
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

Make the progress output shown when we're searching for commits to
include in the graph more descriptive. This amends code I added in
7b0f229222 ("commit-graph write: add progress output", 2018-09-17).

Now, on linux.git, we'll emit this sort of output in the various modes
we support:

    $ git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
    [...]

    # Actually we don't emit this since this takes almost no time at
    # all. But if we did (s/_delayed//) we'd show:
    $ git for-each-ref --format='%(objectname)' | git commit-graph write --stdin-commits
    Finding commits for commit graph from 584 refs: 100% (584/584), done.
    [...]

    $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    Finding commits for commit graph in 2 packs: 6365442, done.
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
index 42d8365f0d..43b15785f6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -818,8 +818,12 @@ void write_commit_graph(const char *obj_dir,
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
@@ -836,14 +840,20 @@ void write_commit_graph(const char *obj_dir,
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
@@ -863,12 +873,13 @@ void write_commit_graph(const char *obj_dir,
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
2.20.0.rc0.387.gc7a69e6b6c

