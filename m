Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F75F1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIGXMX (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:12:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45170 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIGXMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:12:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so15829165wrb.12
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8wMRdmGN9/RM72VtsI6oeDpdDrVdXKEyh59sL3i1bk=;
        b=cRfM4k+bXceylLqTgcuVDxQl9ilqhoOGKjX1Hm/buMjR4DJdx+TMIbUTCW+osAT/6l
         CfoToDuIIr0CL691FtzGTh9FzMqMraSFLHW+SEgM51m0ExmjCBGWxFKJDFW7XL1ZsXRE
         H12Ws0ptCSHHF2y8mPpu/N5t+6Xg6IQN+N/NrOGMSqJOoJEr0a+bUSL8g8+L1uuGVtmW
         Z0C+uqT7npEGr2015fBySCt1g2/NobpK0EQDp9ituShJf/JVOKW1FyWwXf6tyUn/8Mrp
         nWWU01q9S3epoL7DYxSc003UIVchPb5i717QnxqMdjo6DZD0dNaD/csqIGoFgyktCgPu
         Q0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8wMRdmGN9/RM72VtsI6oeDpdDrVdXKEyh59sL3i1bk=;
        b=E0HH7T+/mLTJB/zGE2set9gNMluNG4/1ea+VFegcYF6Qr+zhU6Iejp/I3hC723YduQ
         FLGyDq1UiFJOn0iEUmeq+LsE9nWx6W4vgDtvWL5OFrX8jVmhTikFvK6J4lrp/ZU9VoAa
         SjIo6XxrWmgI8kfKydnx1HjTPNbZG6GcbKMJ9fHCUG01l2rr+t+I/ueXCLcCRFIz5Mr9
         n8ebFOyjYIwnc3EvhC7CMJ2kSD4ZDTexY7qE/mZXA8HchTPFQhmb+x5ESE50uMYUxsPi
         eqMLSufyzRFQu0tNdU58eio9HTvkwzum4aCqAzqjlz7ysWQ+xUdc535Pw1BVbaZzYVcI
         BGug==
X-Gm-Message-State: APzg51AejcRbnKZ19AWUNxIuE0y3/gZ9etyPG8oS+EOTgoOt9TYX8l8S
        m9v1sVZdvqpCLhaDDD//+X9Hck6C
X-Google-Smtp-Source: ANB0VdbThFbGiLEmFhmJ16nUCXj1+XimBK4PSlNdYmTViYZzzoMzRR3NwrQT4xPEThC52bQseVKeng==
X-Received: by 2002:adf:cc8d:: with SMTP id p13-v6mr2190638wrj.67.1536345011149;
        Fri, 07 Sep 2018 11:30:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m68-v6sm15396550wmb.10.2018.09.07.11.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:30:10 -0700 (PDT)
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
Subject: [PATCH v2 2/2] commit-graph verify: add progress output
Date:   Fri,  7 Sep 2018 18:29:54 +0000
Message-Id: <20180907182954.2413-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180904202729.13900-1-avarab@gmail.com>
References: <20180904202729.13900-1-avarab@gmail.com>
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
index 2c5d996194..0bfb8c180e 100644
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
 
+	progress = start_progress("Verifying commits in commit graph",
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
2.19.0.rc1.350.ge57e33dbd1

