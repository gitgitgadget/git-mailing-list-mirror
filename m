Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4486520248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfCVJcS (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:32:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40275 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCVJcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:32:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so1119807pgo.7
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUfue73ZCfN3XboApdoqEHg56GFX0kKKikXxjGE2MYQ=;
        b=cY5x74tituMVl0mnstyxV1xFX6kQ6oxyytu/AUmaXjnWidBH9VLtLXYuym3l7PPuXd
         0lHeblLgd+ojcWkpPfkCzaSxUOl3+wHO65wBU84o8qhgu2te67aGiDT1nGKpGg1Z/Jzi
         l852IiwIK1lCfs4ZytDwMYPu49+e3/LKpgbuQcVj7xlVh9PP29AdFtz6Zx640ndXoiiX
         SzEU34/F0LQElwcKe0yNqywvMz+zuE1lGIBQ3yDQy6aNmNiJd9Hy9bf3hbstKNo/u5me
         hcpVek2T0VSK/G1bZasCnMkYtGseSHJs14Zte1ZmzMS1wSz4tUYWCAzMOWpigQCw1hq2
         Z/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUfue73ZCfN3XboApdoqEHg56GFX0kKKikXxjGE2MYQ=;
        b=ah2mkVC4+/POS/iEQ30+VqXUOIpDoMEYGrPgpEh3UOIaWvygWNvRqCgKSgNYkBQYc+
         nkvI/bMI5S1MJdsB8pWc0KRGJ9f0fiDoNWJNGD5YfJZeNMbR0I1q97sgqIiYbAss3fen
         ZFVxbdmOtsZ1Y7IJYc1qHQfvWgIj8pIIWzcofnX7GejU/LoBtx/ZAIy/gcT5TsRjlycK
         cBvFOqGTkhyUUMZncewMehi1Ou4jaTl9d/VK+cWtRxI52mjvvS3Wd4cyvXaLJmxj73+A
         LeQ3qNQm/AN3PP0dKjhid2JS9Ct1bS7UHNY8sDre5yl1pW4G9xnjY60Q0ypPxyviWAV4
         YyGA==
X-Gm-Message-State: APjAAAXR1h2g82Bfhpq++bHTE0Yhx3tywaC6TzRFZtw8Sh8bvf7ofiFf
        6LuvqAcrPvpeXWn9VDhDunwCTpoeDow=
X-Google-Smtp-Source: APXvYqw7BF8WTdySEvaF+1qFOrSewpdz8+EPWI02SvwtXjbJOY7FeUkfEdFUzRu2eqyiTE0aBy2Udw==
X-Received: by 2002:a65:624c:: with SMTP id q12mr7711290pgv.75.1553247136403;
        Fri, 22 Mar 2019 02:32:16 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id o5sm17221375pgc.16.2019.03.22.02.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 02:32:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 22 Mar 2019 16:32:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/4] unpack-trees: rename "gently" flag to "quiet"
Date:   Fri, 22 Mar 2019 16:31:36 +0700
Message-Id: <20190322093138.13765-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190322093138.13765-1-pclouds@gmail.com>
References: <20190322093138.13765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gently flag was added in 17e4642667 (Add flag to make unpack_trees()
not print errors. - 2008-02-07) to suppress error messages. The name
"gently" does not quite express that. Granted, being quiet is gentle but
it could mean not performing some other actions. Rename the flag to
"quiet" to be more on point.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 unpack-trees.c     | 6 +++---
 unpack-trees.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6037b296..22fb6c0cae 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -700,7 +700,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.initial_checkout = is_cache_unborn();
 		topts.update = 1;
 		topts.merge = 1;
-		topts.gently = opts->merge && old_branch_info->commit;
+		topts.quiet = opts->merge && old_branch_info->commit;
 		topts.verbose_update = opts->show_progress;
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
diff --git a/unpack-trees.c b/unpack-trees.c
index e6c1cc8302..2e5d7b202e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -219,7 +219,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 			     enum unpack_trees_error_types e,
 			     const char *path)
 {
-	if (o->gently)
+	if (o->quiet)
 		return -1;
 
 	if (!o->show_all_errors)
@@ -1042,7 +1042,7 @@ static int unpack_nondirectories(int n, unsigned long mask,
 static int unpack_failed(struct unpack_trees_options *o, const char *message)
 {
 	discard_index(&o->result);
-	if (!o->gently && !o->exiting_early) {
+	if (!o->quiet && !o->exiting_early) {
 		if (message)
 			return error("%s", message);
 		return -1;
@@ -2343,7 +2343,7 @@ int bind_merge(const struct cache_entry * const *src,
 		return error("Cannot do a bind merge of %d trees",
 			     o->merge_size);
 	if (a && old)
-		return o->gently ? -1 :
+		return o->quiet ? -1 :
 			error(ERRORMSG(o, ERROR_BIND_OVERLAP),
 			      super_prefixed(a->name),
 			      super_prefixed(old->name));
diff --git a/unpack-trees.h b/unpack-trees.h
index 0135080a7b..d344d7d296 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -56,7 +56,7 @@ struct unpack_trees_options {
 		     diff_index_cached,
 		     debug_unpack,
 		     skip_sparse_checkout,
-		     gently,
+		     quiet,
 		     exiting_early,
 		     show_all_errors,
 		     dry_run;
-- 
2.21.0.548.gd3c7d92dc2

