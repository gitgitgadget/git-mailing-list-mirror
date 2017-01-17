Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8E120756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbdAQXfO (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:35:14 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36571 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdAQXfI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:35:08 -0500
Received: by mail-pg0-f45.google.com with SMTP id t6so23037846pgt.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZH66fe2Smh+sBErnn63PanXsb+NlQOabSK9LXJwDdNE=;
        b=BL3TOJ3Uo8sWj4QsdTlJC3jsuBIyfI8AsUWJ0UdCitoHvwWl3kJgIMOd6K6DU/Idfu
         +Oo/71moZ0ORpQvwv01exdvoARvp+XMyGes4sQEyG4jsxokDQmYd/zpiqufOz6xyfv0t
         cRJDOHT1UJweuA4FKg/HDb26iSQZ0aYoSKOyn2J7fHclKZJ2fTGbqfCqAs0+b5xqq6r8
         shXerUPTRNt+OiT6YXaescG/Xsx+pPm9PkB4SDYJuLWCoYGAglOvCdIznY1EdlOaB/I8
         w3Loka1Tc/eh+P9uqEn+x1+sdFRqg7LfzjabhZD3YqbugSDloQLF1O51ggVw+QbykuGk
         8KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZH66fe2Smh+sBErnn63PanXsb+NlQOabSK9LXJwDdNE=;
        b=lZokQ232Nv1dRsnoLxaQg6XUIVzs9Ji7JpbIkl/08otP9ZmZsiv0bbluEcZJGqNSXu
         5hURGi3p3hnLV44MRIUul2m70BoxZ/lkJXJKe92/+awYz4udgvP6OP2wpsYNZQH/uJDm
         r7KjLqWc47SnVuawNZdr7qwKmLXUBzKovMMXXGxOdtbI0uxxJpBPI4HwmZqHqfyMprK6
         899KnGo9xbpm+ommgTLs+nEMOWjCA2dv9L3qt6U+rqplRcr5z9SHPwCRFbKCNqsMQX/j
         0UZoqGh0Bx11sfuFhLnhMPKJUQJLnLMHJ8Nd5ZEvoF55g3Ch28whcwvb8mz3Yr8o1jjF
         Biww==
X-Gm-Message-State: AIkVDXI8yBQrRs+Tys60KwCljPewvC4kr65faj6xWmcSp4BQAhgRDaOnLKEYAI9YzYfkRMWc
X-Received: by 10.99.192.69 with SMTP id z5mr239432pgi.169.1484696107360;
        Tue, 17 Jan 2017 15:35:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:871:ca27:8566:e7e])
        by smtp.gmail.com with ESMTPSA id n79sm21027134pfj.31.2017.01.17.15.35.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jan 2017 15:35:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] document index_name_pos
Date:   Tue, 17 Jan 2017 15:35:00 -0800
Message-Id: <20170117233503.27137-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170117233503.27137-1-sbeller@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/cache.h b/cache.h
index 1b67f078dd..270a0d0ea7 100644
--- a/cache.h
+++ b/cache.h
@@ -575,7 +575,22 @@ extern int verify_path(const char *path);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern void adjust_dirname_case(struct index_state *istate, char *name);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
+
+/*
+ * Searches for an entry defined by name and namelen in the given index.
+ * If the return value is positive (including 0) it is the position of an
+ * exact match. If the return value is negative, the negated value minus 1 is the
+ * position where the entry would be inserted.
+ * Example: In the current index we have the files b,d,e:
+ * index_name_pos(&index, "a", 1) -> -1
+ * index_name_pos(&index, "b", 1) ->  0
+ * index_name_pos(&index, "c", 1) -> -2
+ * index_name_pos(&index, "d", 1) ->  1
+ * index_name_pos(&index, "e", 1) ->  2
+ * index_name_pos(&index, "f", 1) -> -3
+ */
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
+
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
-- 
2.11.0.299.g762782ba8a

