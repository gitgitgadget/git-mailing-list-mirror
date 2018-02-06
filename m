Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0D41F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeBFA2N (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:28:13 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46054 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeBFA2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:28:09 -0500
Received: by mail-pg0-f65.google.com with SMTP id m136so163185pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7fozc9ZJMGHZRXzbyYcMci+FxeXb1cDCW57CUbsG+yc=;
        b=wPYAiASOma9WGlKijUcJhZRoa90RqRpX6obf/rs+FD2gsQP4rv4H/2FnBuK6nuPBR9
         u4zA0alEIg+/PU5SKES4TCTaW18ORsyktXtIubs1DHe5EjCqUNarsaghjScETSRZC3UC
         UEUI5KogqYICOw2AxdqHOBObiFVN5rFK45b3vIH6xRooVzRsMSwSnS3MJbK3iK7phkqF
         r2Z4vHFjCr+BcHnVxmp+5+PDuK8OAxC1mtW40La1VPzuYSaybSMmVOV+Y/OQiAvFHT+C
         7U3I5SCQxHR32Jau2W4Y8jkeIvweS4BnfP0H5ntppGTO9NHx8ReknUuCHELGmPG2SUot
         IheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7fozc9ZJMGHZRXzbyYcMci+FxeXb1cDCW57CUbsG+yc=;
        b=ujmdJqWB5Nj95Eh2VacpbPfb2ZgICKUEBCFf+KMnK63xfBbmNGGu86rTTNLnf1PwSY
         TkIWWengQ6ZJyy6QPL93FgBUZFhHryT4CAY3pqSUucTlM7uCeMptgCGEhSNRhSSo6Eo9
         SwcXvH3DIE8sU79qBh+OmUjU3RTgVBdp3xWWy2BlU7mWBjbDA+KvTRKlFepkUv0ItgYf
         x4zSWa/0C7MFpdjT060P3AAz8KYZqWrS4Sr+A7VmGV9S4LBz7QhtnL395fN84ttrYOIz
         9MaSEzQxUCL2hGbo5MYEfHS5liUOodxOwYN/trjws/Cr+L4vwKMNK2Rhm+unqrU9ROzK
         ONbA==
X-Gm-Message-State: APf1xPBuabBkfxFyyM5izLBICqMUfLsjoWU6uIHNNn+7Q8tup7DUbj9F
        D8fcSE8H6X/a95UaBI/OZ9JQFtAl8jA=
X-Google-Smtp-Source: AH8x224O4ETSCEv60S8JvWhBaU7JQCBzapa3gSsiteYw40Sj6Mbrf6s5guDT+fbhHZZkJH4PW2rngw==
X-Received: by 10.101.102.3 with SMTP id w3mr454088pgv.326.1517876887560;
        Mon, 05 Feb 2018 16:28:07 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m3sm15458381pgs.90.2018.02.05.16.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:28:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 164/194] commit: add repository argument to paint_down_to_common
Date:   Mon,  5 Feb 2018 16:17:19 -0800
Message-Id: <20180206001749.218943-66-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index ed7349bbd7..3886266785 100644
--- a/commit.c
+++ b/commit.c
@@ -805,7 +805,8 @@ static int queue_has_nonstale(struct prio_queue *queue)
 }
 
 /* all input commits in one and twos[] must have been parsed! */
-static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
+#define paint_down_to_common(r, o, n, t) paint_down_to_common_##r(o, n, t)
+static struct commit_list *paint_down_to_common_the_repository(struct commit *one, int n, struct commit **twos)
 {
 	struct prio_queue queue = { compare_commits_by_commit_date };
 	struct commit_list *result = NULL;
@@ -877,7 +878,7 @@ static struct commit_list *merge_bases_many_the_repository(struct commit *one, i
 			return NULL;
 	}
 
-	list = paint_down_to_common(one, n, twos);
+	list = paint_down_to_common(the_repository, one, n, twos);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -944,7 +945,7 @@ static int remove_redundant(struct commit **array, int cnt)
 			filled_index[filled] = j;
 			work[filled++] = array[j];
 		}
-		common = paint_down_to_common(array[i], filled, work);
+		common = paint_down_to_common(the_repository, array[i], filled, work);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -1063,7 +1064,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 		if (parse_commit(the_repository, reference[i]))
 			return ret;
 
-	bases = paint_down_to_common(commit, nr_reference, reference);
+	bases = paint_down_to_common(the_repository, commit, nr_reference, reference);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
-- 
2.15.1.433.g936d1b9894.dirty

