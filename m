Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B196A1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 15:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeIQVBo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:01:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39201 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbeIQVBo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:01:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so10185935wmq.4
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHQog8wWglL1VjDBTuoTM2qe92yu1F2IKTDoc9aZoBM=;
        b=vcRtgZbQ/Se1YJY7J0HpYyk2GnZK/gtTP4fhPB9rBHiCYzMACHlEjAENNNgVDoDJPu
         yMYDk8DS4rzXWnuf+fAwfaz78NeSp5kYmiuozf+6Wc1oXXi0pTOyizQy8dbrTBJwWKi1
         z0Be6QxB+60U3LeMr+G632Y7tzQQ+FyCw/VzX+BmTJHPCGP/aemwgX9YWKzKoYHTyF9i
         iQVQxhgHnauTROJjJvf7pLxBOnOI2pI65V4WeBZsjUS3taOOXy7IzrrIVOukM+kYcbKa
         dMEjGdzO69/sFGpRGE4nVajpQ86ESvEpIvOKa2T8txLqaigcHJJzU3k68BHtFwADQYH3
         TNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHQog8wWglL1VjDBTuoTM2qe92yu1F2IKTDoc9aZoBM=;
        b=gzj4P/RxwHw6jzS7w4LLzFVy2w9UK9uZT1XbcP6TWvZp7e/q1Cc5Ojmqs1jKV8iJXS
         56UVFU9xGUxg873no/D75cqV6tDlimXBlMzHHi79jdXSosSFq7MU7zWm3WaFQnXH+KVg
         yqVMhTFqK0T69uoAlEi+A0ggoR0OMuUJl1MrXlmBhW7aCo0DZ+mz+9QunS1XZQaP2ljp
         9N2aFbXZdcjaVDRpmBESINk4eWOsR+/5pCriEkCb9IvwCTDtriQM0LNpImXYIW16Xzic
         F/57hHtLPpmYYeTSNQnguZyWT+7QehUkwAwtoyunNQxGwMAMmgc3DBuKjK3qCOTmIWyG
         C1AQ==
X-Gm-Message-State: APzg51Bh79VfRa/pTNR0qdK6p+YV1mCOrxeFYsZz7IjqDv2eNLraRwrk
        2H63tJ80Y60YIAO2b2aPwECl1L+VunQ=
X-Google-Smtp-Source: ANB0VdbUn6IHQIzwlAh+rJzghSWFu/Sq4hgj/j1v4WO+/3/m7mnSYkxjunlX2Ye6GSyrddLfH0nT6w==
X-Received: by 2002:a1c:1d87:: with SMTP id d129-v6mr11648448wmd.34.1537198430587;
        Mon, 17 Sep 2018 08:33:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 144-v6sm10680560wma.19.2018.09.17.08.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 08:33:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] commit-graph verify: add progress output
Date:   Mon, 17 Sep 2018 15:33:36 +0000
Message-Id: <20180917153336.2280-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a
In-Reply-To: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the reasons explained in the "commit-graph write: add progress
output" commit leading up to this one, emit progress on "commit-graph
verify". Since e0fd51e1d7 ("fsck: verify commit-graph", 2018-06-27)
"git fsck" has called this command if core.commitGraph=true, but
there's been no progress output to indicate that anything was
different. Now there is (on my tiny dotfiles.git repository):

    $ git -c core.commitGraph=true -C ~/ fsck
    Checking object directories: 100% (256/256), done.
    Checking objects: 100% (2821/2821), done.
    dangling blob 5b8bbdb9b788ed90459f505b0934619c17cc605b
    Verifying commits in commit graph: 100% (867/867), done.

And on a larger repository, such as the 2015-04-03-1M-git.git test
repository:

    $ time git -c core.commitGraph=true -C ~/g/2015-04-03-1M-git/ commit-graph verify
    Verifying commits in commit graph: 100% (1000447/1000447), done.
    real    0m7.813s
    [...]

Since the "commit-graph verify" subcommand is never called from "git
gc", we don't have to worry about passing some some "report_progress"
progress variable around for this codepath.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 2c5d996194..e6e4c03986 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -922,6 +922,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	int generation_zero = 0;
 	struct hashfile *f;
 	int devnull;
+	struct progress *progress = NULL;
 
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -989,11 +990,14 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
 
+	progress = start_progress(_("Verifying commits in commit graph"),
+				  g->num_commits);
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
 		uint32_t max_generation = 0;
 
+		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		graph_commit = lookup_commit(r, &cur_oid);
@@ -1070,6 +1074,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 				     graph_commit->date,
 				     odb_commit->date);
 	}
+	stop_progress(&progress);
 
 	return verify_commit_graph_error;
 }
-- 
2.19.0.rc2.392.g5ba43deb5a

