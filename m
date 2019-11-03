Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EBC31F4C0
	for <e@80x24.org>; Sun,  3 Nov 2019 00:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfKCAWC (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 20:22:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54461 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfKCAWC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 20:22:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id c12so8443806wml.4
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SPKR10h/+qvoD/6/u/lBPZeFzG3fwDsbVBxzXRKjVIc=;
        b=uXktGiNVj/3gtohgk5/m37s3ZvA2POk455hijGmGrAVXsq0Ai4aHGmybUJsDgBJklA
         WyxwuWtF2ZdfWlnrHQzk8dqrtw2KQMsDNML7RNGeCl9TZM7G2gFbukdW30YoIFrh8auR
         oolr+r4gRhwPhWLYPu9qs/M7zlsFSOwe6ImBnRTh3WutGntmaNbNvWt7gqZ5SGjfbqZ+
         YXyMDAf7MmR7+M9ifKIb7A2R5kdMtwRWmjZxbsDL+Mi1JHh9EUSPUktfw+x+czz+Q+Bh
         avmpuFayvymHAobKXN4/jxm4vJjyTXJw3zjmE4rVdNhD94QK+KIrPuXcvkmaK+HdjaQb
         SObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SPKR10h/+qvoD/6/u/lBPZeFzG3fwDsbVBxzXRKjVIc=;
        b=lzaeYmC0DlS7CXqJkMffozckVMXb9cW93DtpAze5T2eKmDzLMt+G+/OghwZJ9yzEXa
         SQW3hGpDGazyJ4lS8Hue9EUayBjLEJGWX64/3SpMSZYBs0HXgaSUA/k5x5DutmmisL+x
         zBj6VNSzjIb+djgigE0s1JTcXF76hOLS6HgrFt/hC1YqBhVlgXIiIpSJz29Hn1buCRju
         4+LaE0PQgGP39r58eM2Wt6vN6D3dNLEuzS0k1rAe4GAUpQHYq/sb3s1BgpOiatSVNMZQ
         TkXShpQw7z8lSPY8n54RIQdOJthTfaX+aVLt8SVbyTZcFsdnqM2VhOsApa7HnVRCLpfd
         MP1Q==
X-Gm-Message-State: APjAAAV5THgP2lsT4QLzxNt2SQLsgJv16q8UVsVWHpOxmIzaCeOSdK6b
        nlR27agCK3qxWgm31gLRqXaDBoyX
X-Google-Smtp-Source: APXvYqx/EAtppsckdUQahs1Au3YOem9oJf9d/XmEAJXHjb4ihy+i6E6aQGXsuqFNIbeAHt49ZmFaOw==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr12731709wme.76.1572740519936;
        Sat, 02 Nov 2019 17:21:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm10178379wrc.73.2019.11.02.17.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 17:21:59 -0700 (PDT)
Message-Id: <3dbb1c0e0ca455801b54959816eb7888fc4e0c20.1572740518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.443.git.1572740518.gitgitgadget@gmail.com>
References: <pull.443.git.1572740518.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 00:21:56 +0000
Subject: [PATCH 1/2] fetch: add the command-line option `--write-commit-graph`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This option overrides the config setting `fetch.writeCommitGraph`, if
both are set.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/fetch-options.txt | 4 ++++
 builtin/fetch.c                 | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 43b9ff3bce..a2f78624a2 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -92,6 +92,10 @@ ifndef::git-pull[]
 	Run `git gc --auto` at the end to perform garbage collection
 	if needed. This is enabled by default.
 
+--[no-]write-commit-graph::
+	Write a commit-graph after fetching. This overrides the config
+	setting `fetch.writeCommitGraph`.
+
 -p::
 --prune::
 	Before fetching, remove any remote-tracking references that no
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0c345b5dfe..ba2a81c392 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -77,6 +77,7 @@ static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
+static int fetch_write_commit_graph = -1;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -198,6 +199,8 @@ static struct option builtin_fetch_options[] = {
 		 N_("run 'gc --auto' after fetching")),
 	OPT_BOOL(0, "show-forced-updates", &fetch_show_forced_updates,
 		 N_("check for forced-updates on all updated branches")),
+	OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
+		 N_("write the commit-graph after fetching")),
 	OPT_END()
 };
 
@@ -1865,7 +1868,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	string_list_clear(&list, 0);
 
 	prepare_repo_settings(the_repository);
-	if (the_repository->settings.fetch_write_commit_graph) {
+	if (fetch_write_commit_graph > 0 ||
+	    (fetch_write_commit_graph < 0 &&
+	     the_repository->settings.fetch_write_commit_graph)) {
 		int commit_graph_flags = COMMIT_GRAPH_WRITE_SPLIT;
 		struct split_commit_graph_opts split_opts;
 		memset(&split_opts, 0, sizeof(struct split_commit_graph_opts));
-- 
gitgitgadget

