Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17EA5202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 15:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935946AbdIYP7o (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 11:59:44 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:46650 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935931AbdIYP7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 11:59:43 -0400
Received: by mail-qk0-f174.google.com with SMTP id z143so7152585qkb.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KlYIoon08a4+nXKDUIkOifHHOa97lY+RtFuy3FJgE7g=;
        b=RtLmPiV5kgKdyBY50XintBq3mfcjYEX2XsOt1fCvgt6qLpmv6I6BpC0HvnpGFE6s6h
         LQ8o1NAuoyZATeyWGusWCwCxnhJBP49h1B9BMXOT6rAmJe2IYOzM6yaTE8CqWj5UHAhb
         t7NTr5ulWjIYbQMWJMBvF4oWbk5ta6zGsT8BsH8ayz1CJLCzVZKd+hKuqwRC/zfKUaJz
         GvrOlSXwqDxaovQqN2miWT8aiYNSbB5Ve1d9ZTg3ZsRq96Y/9Du3NEsiEWnxjHRLRvIr
         Ggum/5vZsSTuChJppOdXW2Kw2KJnIx9ePnet7GiDp7LIAe+OgKYr3MwCJdeqv01gy9Sx
         8vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KlYIoon08a4+nXKDUIkOifHHOa97lY+RtFuy3FJgE7g=;
        b=Ee6NFNObH70ZFSIj1aDfevUH+PPYsK0gfQZGqlh0BMfsxm4txgQBE2A64ryifoDB+x
         NBDt0lLEGPrHly0LEYlGj6ohUchftI8nmXU02sI0qUWdbT5JBOx6RjWCZH4ElvSH45iV
         wuX+zDdMC+oerzbajx9928wLxu7OEDjROv5Y0XToZdjVdVM7P8R5bVo2XJ8dW+qbnytS
         EeWWHO+OgYEW3KuVpaeB8LVASG2SHsrraAIM6Fzh2vNpPV/iF7W4I6aw0XrRcOQ02+oY
         yEww3xRGJpjutRJ+UFsbX2oWOoX9Et+V++QFAxWixaIVsCA2t/sV3pM8VZRQ2aD9ihFT
         t9IQ==
X-Gm-Message-State: AHPjjUjzz3UHT3QCgybOUu5pJ/S1vATG6KzXxjRWhrbaLLhIGLhDZtYr
        lrdfOH/CAfrBRSPjQqysO6rNy+a/j/I=
X-Google-Smtp-Source: AOwi7QAYYc/RyGw0uawmfkbKcyogHxyDaUb6NCJvBgCuHOJspGhhJ10xEivGJh6FaADGucTQr2Rq5w==
X-Received: by 10.55.79.79 with SMTP id d76mr11588810qkb.173.1506355182261;
        Mon, 25 Sep 2017 08:59:42 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id h19sm1439510qta.26.2017.09.25.08.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 08:59:41 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, bmwill@google.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 3/4] Document submodule_to_gitdir
Date:   Mon, 25 Sep 2017 17:59:26 +0200
Message-Id: <20170925155927.32328-4-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170925155927.32328-1-hanwen@google.com>
References: <20170925155927.32328-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 submodule.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/submodule.c b/submodule.c
index b12600fc7..b66c23f5d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1997,6 +1997,9 @@ const char *get_superproject_working_tree(void)
 	return ret;
 }
 
+/* Put the gitdir for a submodule (given relative to the main repository worktree)
+ * into `buf`, or return -1 on error.
+ */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 {
 	const struct submodule *sub;
-- 
2.14.1.821.g8fa685d3b7-goog

