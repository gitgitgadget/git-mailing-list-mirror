Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0205320248
	for <e@80x24.org>; Tue, 19 Mar 2019 09:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCSJjp (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 05:39:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33691 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCSJjp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 05:39:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id i7so10250536pgq.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3HhrA/KKllbkEDsz1qJK25qtSS0M+e61/zavz+0dWJQ=;
        b=hUzhACiWn9fuinR+0ru3V5djxDcrf9EtU5w6x/YYfGVDq7GYaCt9PJPIOlffEmgNks
         7gLFcAavzUwuIwEzP7HnuWxauDj/PZyHCdD/S8RAeaqqYGzmvD5F3WmJfi/+4K32Cqg/
         zFczw29Ahfwaelx04AMDOZMQCE37fGutg4hJJ0uwlIyu2IcxxChxypuE7y1jdVy6VfUY
         aOvrcLAXSJXvAH9CGI+iJd7mWJzoi1Pac/r3QfngXg4PclS7tBGh1YV+Z1QSoX4VoP6y
         EsG5T1u/jatv/1mx4uQOVPrNbC66hXG/In7usU9/Sg5TJN9axWEQlR3netijdt6mdpgN
         xcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HhrA/KKllbkEDsz1qJK25qtSS0M+e61/zavz+0dWJQ=;
        b=qmvOo6CPxzbG+fvRL4Hv0v1+P5iuaddxS7tl1NpQZNVlFbJP04BpkUINVC03m2PSDU
         YPIWW7SU3Ba38OLct4qS/xHRf8+Z9OyrHk2I6g4ZHo409VVrsqZQIVUmxkyX3hNkmwmS
         S6Ao+6eZ0loCmIcLM3LJJf5RD2ipvnmr8odEIgJ3SN8XFEzs4kOYXhr/TMseY99Qgusc
         9scWqkvaIWyn2lUJphDkSX/ke9HgS74ejr9Py41cLEHJY01y7Qvu0Mp1A2/Re9J9d8en
         uYuGXvRtucDHLhIzeRHwvGWhTE/XyQs+maaIrJTx8fvfPCqqT+ZEj4aEqismCcLceDLl
         Wf/Q==
X-Gm-Message-State: APjAAAWfjtwWNXVAIqcfDgq/U9aoeY7tEZ9S9Aa5+cfDER6IL967LI4m
        yqmYwF65m0k6iyPz+MLnIlw=
X-Google-Smtp-Source: APXvYqxPa+TTHqmjthdlNzks7TXPoIIz4dUCVcCfljp9Zox2d0UhAgaHnjMDdVuUn9UNJ48kn9UrmQ==
X-Received: by 2002:a63:b52:: with SMTP id a18mr955259pgl.393.1552988384649;
        Tue, 19 Mar 2019 02:39:44 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id v15sm22851755pfa.75.2019.03.19.02.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 02:39:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 19 Mar 2019 16:39:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        pclouds@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH] checkout.txt: note about losing staged changes with --merge
Date:   Tue, 19 Mar 2019 16:39:10 +0700
Message-Id: <20190319093910.20229-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have staged changes in path A and perform 'checkout
--merge' (which could result in conflicts in a totally unrelated path
B), changes in A will be gone. Which is unexpected. We are supposed
to keep all changes, or kick and scream otherwise.

This is the result of how --merge is implemented, from the very first
day in 1be0659efc (checkout: merge local modifications while switching
branches., 2006-01-12):

1. a merge is done, unmerged entries are collected
2. a hard switch to a new branch is done, then unmerged entries added
   back

There is no trivial fix for this. Going with 3-way merge one file at a
time loses rename detection. Going with 3-way merge by trees requires
teaching the algorithm to pick up staged changes. And even if we detect
staged changes with --merge and abort for safety, an option to continue
--merge is very weird. Such an option would keep worktree changes, but
drop staged changes.

Because the problem has been with us since the introduction of --merge
and everybody has been pretty happy (except Phillip, who found this
problem), I'll just take a note here to acknowledge it and wait for
merge wizards to come in and work their magic. There may be a way
forward [1].

[1] CABPp-BFoL_U=bzON4SEMaQSKU2TKwnOgNqjt5MUaOejTKGUJxw@mail.gmail.com

Reported-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This is my "fix" for Phillip's second problem. I chose to reply here
 because this is where an actual fix was discussed. The test script to
 demonstate it is here

 https://public-inbox.org/git/7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com/

 Documentation/git-checkout.txt | 2 ++
 builtin/checkout.c             | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f179b43732..877e5f503a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -242,6 +242,8 @@ should result in deletion of the path).
 +
 When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.
++
+When switching branches with `--merge`, staged changes may be lost.
 
 --conflict=<style>::
 	The same as --merge option above, but changes the way the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6037b296..f95e7975f7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -726,6 +726,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			struct tree *result;
 			struct tree *work;
 			struct merge_options o;
+			struct strbuf sb = STRBUF_INIT;
+
 			if (!opts->merge)
 				return 1;
 
@@ -736,6 +738,13 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			if (!old_branch_info->commit)
 				return 1;
 
+			if (repo_index_has_changes(the_repository,
+						   get_commit_tree(old_branch_info->commit),
+						   &sb))
+				warning(_("staged changes in the following files may be lost: %s"),
+					sb.buf);
+			strbuf_release(&sb);
+
 			/* Do more real merge */
 
 			/*
-- 
2.21.0.548.gd3c7d92dc2

