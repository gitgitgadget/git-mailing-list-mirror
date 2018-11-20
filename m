Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5521F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeKUGVg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:21:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33140 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeKUGVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:21:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id 79so5743031wmo.0
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDs38u4VhCwrI+TeHjDJMhrRuItYxAXspp+KKYj0bQE=;
        b=NxSu80MqinHEHaDEoYnb8da9V7VZswUt0+/5DXvJWd85klIO8OAXeHgm2EuoIGSOvP
         V3Hxag+RLmbUcdh7q5QeAVtAZsOsGranbpLRpf/BLTSAPjzWDOOBdos7HxEfqncoqT/V
         NgyMj5sjybydb3PmUEKFzIK0hhKeJ/IE3h4x4xX0fZdwnSZuYzz38xwklbs8kx96qdTi
         MXCIujraggYgc3DsjgemcZf6H0GMtJudTELX0wIAXjgmJ0tzJc8ajaPQ1LaD1mh2QLxn
         9jP2eGiPMNZ/wRA/uYBNgYTwJpuTNcStzviwlDJhLZDXcjH4GKKUla+5MI4VS+FzKTer
         PnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDs38u4VhCwrI+TeHjDJMhrRuItYxAXspp+KKYj0bQE=;
        b=s8w5W9fJ+6wEc5ArQkGh51Odo9G8vf2+UIln1cU4gI8viwO14E9Vp0Cs2K8Kcn96CL
         f46H82MlEy/8t4of8AvoMGDQ6a2oh8LV7N/ZR5bEsq2pTqThBPN+K0yXjU1zotpiK//F
         XvYl+74J9loJ5bKzG4shiOKOLu5NnNt7z4D9x9Ypj5hKkyaldFA/0bYmQWNRvl2u4Buq
         i3Fhf1q42iSrPyKi2Xs3r9P68CpFS+NVUQysKTrg3LaBowDDHsIxWZZOY23oj4K11uXu
         0/2vBsaXfFUele+a6J326WKv2T8S4ChI4cTpULMTD8dj8BklrhI+hjtoLR6BQjeCRID8
         9rXA==
X-Gm-Message-State: AGRZ1gJScBNuSmbmgjKadoKZKTGF5X55R4tCM9jJ51Q/+HQjZL8hFm7h
        G2XZVtYMN+Y8iVbvi3f20h750vqD2kc=
X-Google-Smtp-Source: AJdET5d+lMxuEWFa+S6SJR+7lj1Vjn8jfTECQ/OCEBUJB279QkTUla9//DBYpF+CxHlWGxvjK1Gspg==
X-Received: by 2002:a1c:13c3:: with SMTP id 186-v6mr3224443wmt.125.1542743443632;
        Tue, 20 Nov 2018 11:50:43 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p14sm12589415wrt.37.2018.11.20.11.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:50:42 -0800 (PST)
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
Subject: [PATCH v2 4/6] commit-graph write: add more describing progress output
Date:   Tue, 20 Nov 2018 19:50:25 +0000
Message-Id: <20181120195027.3260-5-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181120165800.GB30222@szeder.dev>
References: <20181120165800.GB30222@szeder.dev>
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
 commit-graph.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7c1afa4704..fd1fd61750 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -779,6 +779,7 @@ void write_commit_graph(const char *obj_dir,
 	struct progress *progress = NULL;
 	uint64_t progress_cnt = 0;
 	unsigned long approx_nr_objects;
+	struct strbuf progress_title = STRBUF_INIT;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -815,8 +816,12 @@ void write_commit_graph(const char *obj_dir,
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
@@ -833,14 +838,20 @@ void write_commit_graph(const char *obj_dir,
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
@@ -860,12 +871,13 @@ void write_commit_graph(const char *obj_dir,
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
@@ -970,6 +982,8 @@ void write_commit_graph(const char *obj_dir,
 				      &progress_cnt);
 	stop_progress(&progress);
 
+	strbuf_release(&progress_title);
+
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
-- 
2.20.0.rc0.387.gc7a69e6b6c

