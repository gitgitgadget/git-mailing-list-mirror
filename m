Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA931F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeACDFt (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:05:49 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42730 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeACDFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:05:38 -0500
Received: by mail-pl0-f66.google.com with SMTP id bd8so372025plb.9
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FbK0Zp6PkGry2YsG8J6SvrWOvrw7kcGSzn9n/mE4M4g=;
        b=Er6KymcCwYgBUNYbALy+Kw9rC0oLmceN8vNe6sLnMxmx3fCciKxX7MuP/bl3Kz9y/5
         kLtsYR0Sm6yFcCzpm9oxQJE3FPugp+9v1NBb9dIwJ3XOABA08xp03drLNLXF9vk3NiPz
         CLKO2KjPu5DOmsBrQJGfF/7ERGzmjmDG8Z3Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FbK0Zp6PkGry2YsG8J6SvrWOvrw7kcGSzn9n/mE4M4g=;
        b=czKxro+Iu/Q+gbR8K9n3Zi5NHEivUCJz6yuwTIJ5uZt1krxhaefWhkHwKgpRdh0i1t
         bfsc4tXBEltORlIOzCk6cH5YzJ1I39SAA8bZKW7lRP0cPIAV4Vqyypm92r68eUqPcgOg
         BZxecGa7eR4Z8V9GT77V3YWKGDgHJ9YGBJcm7xhegRrUIM2hLH8HNofhzFkjMIRNV9hI
         IZs01wgtrnQUPJl3Q1KdTOaw7AA3S4H0yC/uUBbb0TqmPm0Omi+Xy8UWxN94A3kEILSL
         aGWTuhGLxG31qVhm976OApV02P0LOZAFSOtxNHPgtftJqVgpzc2UecxAo2ZHVdBR+G2k
         Q3Ww==
X-Gm-Message-State: AKGB3mI87oFbl0f5pZQQlL+Lc/NnC42cf4osBy8s4fkAYwYgYkpVU+PD
        KVUyGfY8X3qYUfUkmpscYutspUoXOe4=
X-Google-Smtp-Source: ACJfBovUGYCPXGlH6Q6dnjpOHpk9+BFJUvI047nrGCkkTpQYBxfYr/k31SPzzVNJVfV0GJC0Jtsq5g==
X-Received: by 10.84.171.195 with SMTP id l61mr110991plb.129.1514948737232;
        Tue, 02 Jan 2018 19:05:37 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id 82sm107742pfm.136.2018.01.02.19.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 19:05:36 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 4/6] fsmonitor: Make output of test-dump-fsmonitor more concise
Date:   Tue,  2 Jan 2018 19:04:54 -0800
Message-Id: <36db77ccb5c025a73bf3f5841cd11607427ffdc0.1514948078.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.31.gddce0adfe
In-Reply-To: <20180103030456.8181-1-alexmv@dropbox.com>
References: <20180103030456.8181-1-alexmv@dropbox.com>
In-Reply-To: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
References: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than display one very long line, summarize the contents of that
line.  The tests do not currently rely on any content except the first
line ("no fsmonitor" / "fsmonitor last update").

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 t/helper/test-dump-fsmonitor.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 48c4bab0b..5d61b0d62 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -4,7 +4,8 @@
 int cmd_main(int ac, const char **av)
 {
 	struct index_state *istate = &the_index;
-	int i;
+	uint64_t now = getnanotime();
+	int i, valid = 0;
 
 	git_config_push_parameter("core.fsmonitor=keep");
 	setup_git_directory();
@@ -14,10 +15,17 @@ int cmd_main(int ac, const char **av)
 		printf("no fsmonitor\n");
 		return 0;
 	}
-	printf("fsmonitor last update %"PRIuMAX"\n", (uintmax_t)istate->fsmonitor_last_update);
+
+	printf("fsmonitor last update %"PRIuMAX", (%.2f seconds ago)\n",
+	       (uintmax_t)istate->fsmonitor_last_update,
+	       (now - istate->fsmonitor_last_update)/1.0e9);
 
 	for (i = 0; i < istate->cache_nr; i++)
-		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
+		if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID)
+			valid++;
+
+	printf("  valid: %d\n", valid);
+	printf("  invalid: %d\n", istate->cache_nr - valid);
 
 	return 0;
 }
-- 
2.15.1.31.gddce0adfe

