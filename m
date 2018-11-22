Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B82E1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436865AbeKWAIG (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436841AbeKWAIG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so1320525wra.6
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdH8TBMpoTNwQjoxz4yhF/yvn7D4nB5iIyCYr+WoxXg=;
        b=cP1ymCb1SV1lP8yCnA1ASNlPx0GK9durDd5R91RPlpy0FDcxMrMO5BEMmBsZScruyD
         GoTRnqqdNhKrLvAQDTBayF4SA8GXfHafE4rXMbByf9V+B8jsZHk9wZ0rzkWB/+Oha9H8
         dYuvP24AiAGcE8b/gSxgEPuMD25h2r/gtPfN9Gj27MJ3X38rYFbmqShR39qDYtj9n6Oy
         lKCU1f677ilkpWuOuJ81G15PGmr8Ljr1scjJ4egZuvmdr9jyyFR6pDTmzZESiCSUCRMp
         NPcFje+/mzspqHnm77oVz4C4VzqMkmK50Iz7ZFvsnqkSZ0MVZw0z5t9zYP3Iw3xjWyZA
         AT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdH8TBMpoTNwQjoxz4yhF/yvn7D4nB5iIyCYr+WoxXg=;
        b=GLifrBZZU3wNLdgkTJnVbuHXO0PlEueOP5Qi4ohvoO+67pnLy0ZhXyGGXRbZLipXJA
         FfXGYSCshkOu4jn8GbJjsCwStwuvVFSIKMLEIMYvkmLFfJZYZyHImAzV2i39COHQrwhh
         g77LtAb3c8pfUlTy8lAbr1vc7slVJYlNJRsKVKzVYdevxJ7jRXbK+9onUYQzAXDRO/0L
         20obrUlz6U8vkdtGCs0olUFJ9j9ppHbflOj5xHCJ9JfDyihny/KPwHQmoGYcVLvEu08m
         9dP9TwLJNqxXJx+Sq7zRfnuVdfDTMDAJzN+UNME+x7H88xPxWz/y2eOfkcLQ7T8LIcwd
         TrkQ==
X-Gm-Message-State: AA+aEWbzDLR05mmmkQAKRNXN4vL68fPm8UnlW2JvO9E3SxZ7QYRjzjzX
        k/H1PHFZSMVBCpxRg2D0pUcY0zEZ
X-Google-Smtp-Source: AFSGD/WTP7j7TaEI/UAFru8cVlPUWjwPyXee/A4MidRsiU4XzZzblqQ+mj7rD+zLaTJrJ6Me+/92Gg==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr9488509wrx.315.1542893323079;
        Thu, 22 Nov 2018 05:28:43 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:42 -0800 (PST)
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
Subject: [PATCH v3 07/10] commit-graph write: add more descriptive progress output
Date:   Thu, 22 Nov 2018 13:28:20 +0000
Message-Id: <20181122132823.9883-8-avarab@gmail.com>
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

Make the progress output shown when we're searching for commits to
include in the graph more descriptive. This amends code I added in
7b0f229222 ("commit-graph write: add progress output", 2018-09-17).

Now, on linux.git, we'll emit this sort of output in the various modes
we support:

    $ git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6365492/6365492), done.
    [...]

    # Actually we don't emit this since this takes almost no time at
    # all. But if we did (s/_delayed//) we'd show:
    $ git for-each-ref --format='%(objectname)' | git commit-graph write --stdin-commits
    Finding commits for commit graph from 584 refs: 100% (584/584), done.
    [...]

    $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    Finding commits for commit graph in 3 packs: 6365492, done.
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
index d6166beb19..cb1aebeb79 100644
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

