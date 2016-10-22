Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C4620986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934947AbcJVXcq (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:46 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36978 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756241AbcJVXco (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:44 -0400
Received: by mail-it0-f43.google.com with SMTP id m138so74578408itm.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OAavrT5zCMhCIST9apIX51cDpfjowN7c83vYYTNRD7c=;
        b=AX9ZZ0oyJiutynKcanjRsanksVJAhgg6oF+WEyTOITfdaHCVcmwVt1oVL0TKXlOlI6
         nq+572hYkqXmx/JsVx+ZghPoCR4k/PiDKJvvf2Q7oMF7R4FAMlGQe1vlf4mdr1v1rhhE
         DMbHp4JOuNwTzIr4Py+rVnecakieOanhgqT1ZGBodQnq/GuHg82uS6TcL8AvAO5Lxst2
         dF3qlZqhwm4DSjP53OPQsdOHJzuIQQemlnrj5RREFFm3+3NyOuywLCUdMv5fmuapQRoF
         a96SeWHcwWnQWn6GIwzOv+PWvPNjYqGCp7yRWTF017kf0wvc0Olnx1CYIYKtrn2CfwT7
         S7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OAavrT5zCMhCIST9apIX51cDpfjowN7c83vYYTNRD7c=;
        b=NZNewu4WJBmqE6fjJxNelL+431NNz1iK6qLpb2rHWLAfCFQLVt3NZ8y+gpDOtNGS3h
         FW2JWmNRPsNQxDwjM9YM3Seami0z5t4B7dAF73+GC9xLQK2ckjd3pdVp1ebbOGrIs5Lx
         FVgp/NljWiqDXXgBDo8lg0MRS068qBK875ipQw6fmuqQtyIYmdyXSTHNaKC63LMX5CC+
         XUd53RQhCgPn6woAqAuyzyN8HkKug8z/zjsFqwgZL31e++8GaMwZmMkxwi6Ec8XX/iMn
         GUqdIHFRMaeOnwQ4p4jLWoisopuGFu6a10YGps+qtXFU6dKbpzyHNhpXFHWgEUS8cL5G
         CmJQ==
X-Gm-Message-State: ABUngveiUnMLY1PqOz0F9+5RQQ08W7sdRPweDuo/GCjl+IwEsAEvgDM5HskZ0egBgGD9QE56
X-Received: by 10.36.181.78 with SMTP id j14mr4916712iti.20.1477179163245;
        Sat, 22 Oct 2016 16:32:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id s37sm4563481ioe.16.2016.10.22.16.32.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/36] attr.c: mark where #if DEBUG ends more clearly
Date:   Sat, 22 Oct 2016 16:31:55 -0700
Message-Id: <20161022233225.8883-7-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.10.1.508.g6572022

