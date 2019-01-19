Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0894E1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfASUVt (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37750 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbfASUVt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so18997010wrt.4
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgVxHNCxtKCaVqyy5QtmUnUqBhaKqiPOUl7lcgQMAIk=;
        b=TuADVFrKg5v3/3GoMD5rQVnbbbcRO0qwLs1Og9zM9KPm05WC9hhrMcJFIOUw6/fXKz
         BggoQrnUP2h3xvPpKusptKVclHuWFm4ZS3CiSGj5tFDtI5h14SnltR4kOhZ0/zT3yCLa
         +sOAdqcUyrmULsmH7A67y2cNRQk61uf8KX9QPdMSNVtW+nn4PND+IEyBmW8FbOcdMpx1
         vV3hHdBVoRuzMRDyMdQY2de59/HKZiqdJbaZOiYrjpiwnnmRHhKlINSxwPkndH+f3TiM
         j9mOC+7r7j4yD8JA3Otf9f0O1UXBPQYPWEvbdfsFZJZycnLxJWbKi4GkF9T7xe43uLJ2
         PNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgVxHNCxtKCaVqyy5QtmUnUqBhaKqiPOUl7lcgQMAIk=;
        b=MLLwhCKI2jOu7KFLC5OFssxj3VewIrEV4HWXEwh0husPspjwMzu2RsQnxLOx3/0+4t
         kPRGzwBRnbTNUyDSt6BiBGibO0NHX+WBlGUbDtayQP81xQHvuY69DNEZNHq5S8elnxt9
         MkHKVap1ch/uTuxGGjPjznX8lQaTlA4pvYknxtVMYaDJJpYcGbRIxd0if2HqqCSjbyxU
         sMxdQVTHfDrgWvGUglvajkqMm74Gu3wvTUZtLtQkzsi91btgdmmXSlpowZjn9QQeBgPr
         7dDuSStLswgMJHZa43lnPbXjpzbNpjYUl5xuFcOa6KXGwqXvUfA31BLD2tkOstB7QDug
         9n0Q==
X-Gm-Message-State: AJcUukcODchFKyjv/M2S45NNmMQXq7dMlYxt8oN4sWGEjbpAiTcCzNz7
        6/eqzRFJlxPnL1bOVt6zSkzvOtfDpe0=
X-Google-Smtp-Source: ALg8bN6sCDhizRfNkke0+XNuknzyGNtQhyL2ni87GbGuYJxKTv3ECmbwKGnpGAdn39XnjAuJQ92/VQ==
X-Received: by 2002:adf:9123:: with SMTP id j32mr22666638wrj.122.1547929306879;
        Sat, 19 Jan 2019 12:21:46 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:46 -0800 (PST)
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
Subject: [PATCH v6 05/10] commit-graph write: more descriptive "writing out" output
Date:   Sat, 19 Jan 2019 21:21:16 +0100
Message-Id: <20190119202121.3590-6-avarab@gmail.com>
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

Make the "Writing out" part of the progress output more
descriptive. Depending on the shape of the graph we either make 3 or 4
passes over it.

Let's present this information to the user in case they're wondering
what this number, which is much larger than their number of commits,
has to do with writing out the commit graph. Now e.g. on linux.git we
emit:

    $ ~/g/git/git --exec-path=$HOME/g/git -C ~/g/linux commit-graph write
    Finding commits for commit graph: 6529159, done.
    Expanding reachable commits in commit graph: 815990, done.
    Computing commit graph generation numbers: 100% (815983/815983), done.
    Writing out commit graph in 4 passes: 100% (3263932/3263932), done.

A note on i18n: Why are we using the Q_() function and passing a
number & English text for a singular which'll never be used? Because
the plural rules of translated languages may not match those of
English, and to use the plural function we need to use this format.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a407d5bff4..7c639c6a65 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -784,6 +784,7 @@ void write_commit_graph(const char *obj_dir,
 	struct commit_list *parent;
 	struct progress *progress = NULL;
 	uint64_t progress_cnt = 0;
+	struct strbuf progress_title = STRBUF_INIT;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
@@ -959,16 +960,23 @@ void write_commit_graph(const char *obj_dir,
 		hashwrite(f, chunk_write, 12);
 	}
 
-	if (report_progress)
+	if (report_progress) {
+		strbuf_addf(&progress_title,
+			    Q_("Writing out commit graph in %d pass",
+			       "Writing out commit graph in %d passes",
+			       num_chunks),
+			    num_chunks);
 		progress = start_delayed_progress(
-			_("Writing out commit graph"),
+			progress_title.buf,
 			num_chunks * commits.nr);
+	}
 	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
 	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
 	if (num_extra_edges)
 		write_graph_chunk_extra_edges(f, commits.list, commits.nr, progress, &progress_cnt);
 	stop_progress(&progress);
+	strbuf_release(&progress_title);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-- 
2.20.1.153.gd81d796ee0

