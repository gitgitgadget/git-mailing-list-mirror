Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C8D207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdEBWYi (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:38 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34025 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbdEBWXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:48 -0400
Received: by mail-pf0-f170.google.com with SMTP id e64so3512703pfd.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bgp3jlVNhmoXJI/ueBfHepJs2EBAqzvVYXOzO2y8cjc=;
        b=ZvMEEApUyKlZT4b2BrGQhXd8FYDxmJ9yqFIBYaOeUn2jINMbG9X+kxgzWw95QdunlE
         4TNBijPe1IaLLMYIa72Nv2vYlXD8tL+R+h+6khe5h33KccrfiCIAX2nbTR6ow/v+FE5x
         2hIWFuW3cyk852rgEa/NjRQEm2Ih+q6W27skUIxjfbXHX/I30e0YLL8cBqdeqwiQiz2H
         zmc3way7VxkcYVh0NnpeZAynsI3nxfAq3JonfQUc4uaZStrkpXj/5m/VGFbsU9dLd8mq
         dwfESWJVDA7mreNmUW3Ufmz8PO5G6aw5/1i2c0O3OYvDMap9AZpWa5lPtd64TYmSLSta
         wmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bgp3jlVNhmoXJI/ueBfHepJs2EBAqzvVYXOzO2y8cjc=;
        b=I5C+auJzjNDVHYa90oHPg4/mxR6hAppQooSwrUetoSMdbq4ocp6QA7CvmF7GHBtYoM
         hc1TNzqzlZcaeKCuN4gkOZM6DFFV49/QiwU34HdNz1K0j4AhPTWQF5sXnAm0NKWh+iDv
         iLrII+Ae7wEHiKXn7HGdqyvE5oKJqLDbe1U7aN8rVv/jqXxsy5daObeS3G8RISDTQ9T1
         79oqHmj2NH/PwwZMMD2S7/qEcQu60V65mujvyocJEuTGw2HYSgF8Dq84EQvx8uYUJJ7h
         knHxHPUbdsFRiZudgnDZ6IMoaWmm0FnfrBDN6HDcwiPG2xfjrphXyHbzgHOQMzHtAOiS
         yRSw==
X-Gm-Message-State: AN3rC/7MUgQ+PmG9Tld3ASaZbbm3uZeW2AWEF0/EKoeBykLetbsDc744
        8eyqj0SeN6bQsqTv
X-Received: by 10.98.57.203 with SMTP id u72mr1434001pfj.9.1493763827828;
        Tue, 02 May 2017 15:23:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id q6sm738936pfq.18.2017.05.02.15.23.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 16/24] cache.h: drop rename_cache_entry_at
Date:   Tue,  2 May 2017 15:23:14 -0700
Message-Id: <20170502222322.21055-17-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One define was unused, the other occurs just once. Easy patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/mv.c | 2 +-
 cache.h      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 40e40bb098..1a3c61994c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -287,7 +287,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		pos = index_name_pos(&the_index, src, strlen(src));
 		assert(pos >= 0);
 		if (!show_only)
-			rename_cache_entry_at(pos, dst);
+			rename_index_entry_at(&the_index, pos, dst);
 	}
 
 	if (gitmodules_modified)
diff --git a/cache.h b/cache.h
index 54c1bbf0d1..4c12ff265e 100644
--- a/cache.h
+++ b/cache.h
@@ -354,8 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
-#define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
-- 
2.13.0.rc1.39.ga6db8bfa24

