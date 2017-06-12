Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD62820C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbdFLVea (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:34:30 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33827 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbdFLVe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:34:27 -0400
Received: by mail-pg0-f54.google.com with SMTP id v18so50393801pgb.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JAYT1Ik6308rojk564r+ALr0yTxpyLMJtc+NeWFrISI=;
        b=eHeSNJeoxqIqRitYOwrRD9HJ74zCWJT9yMOx9CH9GxB1M0H2Xw0c/JpGZ0l8Kg6P0d
         kdIPEAvXsVW76l+e7bQfuF/iRDZoYOdfeFPuO7ws1hLOKSUS7p8ANm9AqBVSjNQlF1JR
         MSXSKUugNj29bZ9TvthAeNomm+JCgGWG/ICfzEon+0IsV2JwWVhYbYEJoS5OqOpdtPjM
         nSV8FRBAL2dxusLqU9ASTg8sk1ab07z+oZE3zxYS1RWOo7zPhEvmtEnZMWUBzYJW4XGJ
         Uv6Y0sm/vsa5mQP8ACzNAhAEs1Mc+EujoMsX/nJronYFwrYGVpjH6WECX+vQTsmxtXr2
         O8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JAYT1Ik6308rojk564r+ALr0yTxpyLMJtc+NeWFrISI=;
        b=SdODuFulX7Jio8oi07NRL9k8gg67SSY0D+QNUO/WWnM/WO4UQcmA434rpmyJ697nDe
         SxBw5K44wy+hQY6RkvSi377OjkzJNqLd1vprf/txTutvF84JmndkcnreBYb1dbvAbxNp
         tnSYnQ7qTQRjqy9Ph5nkon5UxXb7vbctCk+k9BCtwkCJwU7CCPrOmXTIkUVz6YK3eGHz
         oqkpF1D42nMBY1aIprHKdSPjABi+iuYvWW9q4u9Ry0XkobQ6fQVuUnKDj3QSgBWMjuno
         RbucPpD4D5I8rGRIqOrrwgd1hU39pd/yPTZJDAAb6slrcbeXTYxr6bRgX62I20c5Cl3X
         jkJA==
X-Gm-Message-State: AODbwcAzw7rQzUDxjUP0Vi8UO9CnAQTjn9v9RxmGCzgQuANm55oh6Yy+
        hvQnZo+aJSQk3LNDufiSRg==
X-Received: by 10.98.98.6 with SMTP id w6mr57736541pfb.67.1497303266226;
        Mon, 12 Jun 2017 14:34:26 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id v21sm13333468pfk.75.2017.06.12.14.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 14:34:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/4] config: remove git_config_iter
Date:   Mon, 12 Jun 2017 14:34:04 -0700
Message-Id: <20170612213406.83247-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612213406.83247-1-bmwill@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since there is no implementation of the function 'git_config_iter' lets
stop exporting it and remove the prototype from config.h.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.h b/config.h
index f7f8b66c5..c70599bd5 100644
--- a/config.h
+++ b/config.h
@@ -165,7 +165,6 @@ extern int git_configset_get_pathname(struct config_set *cs, const char *key, co
 extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
 extern void git_config_clear(void);
-extern void git_config_iter(config_fn_t fn, void *data);
 extern int git_config_get_string_const(const char *key, const char **dest);
 extern int git_config_get_string(const char *key, char **dest);
 extern int git_config_get_int(const char *key, int *dest);
-- 
2.13.1.518.g3df882009-goog

