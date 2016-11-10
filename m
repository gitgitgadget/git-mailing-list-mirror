Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80B620229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936179AbcKJUer (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:47 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33951 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933893AbcKJUen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:43 -0500
Received: by mail-pf0-f170.google.com with SMTP id n85so151862738pfi.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nGizHu36zMr0Q4UrK33n59p1YwHrniLg/Y1q7TIE8Lg=;
        b=dqjHH8lhq3Pp404nq1dn+5jlAeqF7UiCFnPjGq02TMTqEH/U3PbGBNt9aiZk8F9ZJv
         bLzQtDvrOVZjSJ2bmgw4BFi5j08K4HnpIdgVYCOXlXa8tT75lZlcTl43CWsAGVFii6HF
         MI4KLk9ZZq9UcKPXjJVG6pkifc3zXT6UT9kwPZjlVxqa2xmWZZFX1eKRo22HL/t/Spsu
         2z7wQ92mVI65SFncdt46+/+3+JP2xjHXbmBNzwomV5/y5EdGMRkD1+Hk4D0MA5ivFxxN
         RSlwq7SUBj24GM2RZKadvnkFsC2LgPXuQSZAztaUSCvFcmRg3oPAwpoAsSu8A5EIL0tg
         8RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nGizHu36zMr0Q4UrK33n59p1YwHrniLg/Y1q7TIE8Lg=;
        b=bPXA/odZfznlPbdVG8xt0I72RlNYWSueqhOg4WC6ABG5OniAUceGU+FNHTOw9WLK6e
         xyysdU5s89vnhCkJ8htG5Lxy/oscopd1xe4QIMSpmR0OEDF4Xl1UQ5bD+cCDEC+G7bt/
         Yk8oRbTk8oZ2UOWMVaEq4OkDZtK6FwPZwYZ1QFzhKT6RHombpvl5J2yO418bjwK4yCoS
         AUxCOLFigqn9hBRwB/Th68nfYj4AWy9le5iMAz+hAuFmMxeS/IkBALsYd/zTdFQDRh3c
         D8l5fi/UaODDkrlNsiPJ75ykdKtzfKQUbdoeNpla+2BsRls0P6sRxzdH42DaANaZcDLQ
         pfVg==
X-Gm-Message-State: ABUngvdx1eBDiXUQ+tNbByhOH4vXtNQ8hG55a5uj6iuw3At/OxhU1ZJLD3VQRr/qPpAiSqrb
X-Received: by 10.99.123.22 with SMTP id w22mr22613565pgc.155.1478810083076;
        Thu, 10 Nov 2016 12:34:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id 89sm4273250pfi.70.2016.11.10.12.34.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/35] attr.c: mark where #if DEBUG ends more clearly
Date:   Thu, 10 Nov 2016 12:33:59 -0800
Message-Id: <20161110203428.30512-7-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index a7f2c3f..95416d3 100644
--- a/attr.c
+++ b/attr.c
@@ -469,7 +469,7 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_push(a) do { ; } while (0)
 #define debug_pop(a) do { ; } while (0)
 #define debug_set(a,b,c,d) do { ; } while (0)
-#endif
+#endif /* DEBUG_ATTR */
 
 static void drop_attr_stack(void)
 {
-- 
2.10.1.469.g00a8914

