Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337851F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeKUBee (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:34:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34826 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbeKUBee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:34:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so2590595wmh.0
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXOeROURnrObUX+SnooD1hB2aI9MdA4lzTWJB+Iaq2c=;
        b=RVtt1NeOCKGke7uHk+7XG1jxR0mNf0Q+75XHZ59y/+oOn4E6fSE2i4uP8KDawzQAIq
         lMF3jJ9dfMKAfyUBez/8UJSmCGknHari3kanzKbpYWg5IQXdvw1LJf7yXWJf/CDeRg25
         sF99uvdeAaDdxZhiyC2qzz5Q7vxWSsJr5HVTCQBsYKEIneu5Pz9kY4v0IhfsyaqJ4ZuP
         sDfpSWz8j5rHeaTepXGgFYbNSZJ6VQt68m9hn25Gu6T3MuMii+WU8ay4TJiYp7g/Bs3p
         U0nvn9KGYrcwyYioMj5iBeTEZtx7dyOvz/nk7eMsXYxeJY+BU4aAg4Vsc9UNmUF5y7u7
         kaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXOeROURnrObUX+SnooD1hB2aI9MdA4lzTWJB+Iaq2c=;
        b=oRpMejkH4N8zlekVMeBPZO2UO7flI1YPYAvo7ol7az5HaEE5z7YxXlPPV0ZbaGr6xg
         HaTiQNiYgaoockyx6v406srwF8Xjaga6Vk3uS0PK1gQS4xLqrTHIiN2HwvK/PC/eHywr
         st5ROVQr4RcMhe/915N1C4if/p+R1dv2hPS4qdH/kbOKd7lHh6wgI1BVzxUEkGT5QFA7
         DCyvs1U+7Vy7pT1MsTNx9SwUBeDbOcK0Vteq6SOAcBISLSPjhhRyQT6WNd2/Yqf6bH7W
         qpSmaVcWJPhris0Z8bVzcKthHHXm9BQitQ6MAK7A5YtSYKZA+Q34KPb+EvC2PN+cWM6y
         jJvQ==
X-Gm-Message-State: AA+aEWZizEbgHnNqxUkZOJJSjp62LRpoATgYdxEqWQYMjxVwedsTlm9e
        VktWDy7cYvz1vvlPXz5udNyOJYmVCiM=
X-Google-Smtp-Source: AJdET5cJTPlz6txpRJVQls4QiT7dHzLSC1006su9kMJdoGlk9j11oYIajdLrnjDiopba+ez88LFaZQ==
X-Received: by 2002:a1c:ab07:: with SMTP id u7-v6mr2479470wme.16.1542726297757;
        Tue, 20 Nov 2018 07:04:57 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j13sm26378460wrx.5.2018.11.20.07.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:04:57 -0800 (PST)
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
Subject: [PATCH 3/6] commit-graph write: show progress for object search
Date:   Tue, 20 Nov 2018 15:04:40 +0000
Message-Id: <20181120150443.12997-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181119225720.GV30222@szeder.dev>
References: <20181119225720.GV30222@szeder.dev>
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

    Finding commits for commit graph: 6418991, done.
    [...]

And now:

    Finding commits for commit graph: 100% (6418991/6418991), done.
    [...]

Since the commit graph only includes those commits that are
packed (via for_each_packed_object(...)) the
approximate_object_count() returns the actual number of objects we're
going to process.

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
index afce20dd4d..4d03f8aa7f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -784,12 +784,14 @@ void write_commit_graph(const char *obj_dir,
 	struct commit_list *parent;
 	struct progress *progress = NULL;
 	uint64_t progress_cnt;
+	unsigned long approx_nr_objects;
 
 	if (!commit_graph_compatible(the_repository))
 		return;
 
 	oids.nr = 0;
-	oids.alloc = approximate_object_count() / 32;
+	approx_nr_objects = approximate_object_count();
+	oids.alloc = approx_nr_objects / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
 
@@ -869,8 +871,11 @@ void write_commit_graph(const char *obj_dir,
 	if (!pack_indexes && !commit_hex) {
 		if (report_progress)
 			oids.progress = start_delayed_progress(
-				_("Finding commits for commit graph"), 0);
+				_("Finding commits for commit graph"),
+				approx_nr_objects);
 		for_each_packed_object(add_packed_commits, &oids, 0);
+		if (oids.progress_done < approx_nr_objects)
+			display_progress(oids.progress, approx_nr_objects);
 		stop_progress(&oids.progress);
 	}
 
-- 
2.20.0.rc0.387.gc7a69e6b6c

