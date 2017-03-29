Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE8820958
	for <e@80x24.org>; Wed, 29 Mar 2017 18:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932384AbdC2SiC (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 14:38:02 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35093 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbdC2SiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 14:38:00 -0400
Received: by mail-pg0-f50.google.com with SMTP id 81so15147930pgh.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWG+9irw5KJCz8Bf1pvnRmHiRGmC1rjTCEWChJYuBVU=;
        b=otqGEZ/e6V0W/QtpOUyvnHsYLXB3pVM7pHhFGAb8+tPx6eyGEjc5WxUwBH+xQVKWic
         DdtI0NrQNYOIgju9avpr+2DIME1q5QySz4zc2awmt1ZApOzytXzdXFALTDfAm67VQR/Y
         3psSun/6kRO9wgfk5/CtAU+i5n2qzQd9nV30yjEgxbRcSLImeVCTo6xm0jxsl49e9kg0
         lyztMwR3mTZ8zibWyObrykvKdTSY5dxSrJxxG5y3CSWxFn7bjte8g+9J/owzhT/ouypk
         DwdePKIGITxApd8olfUoLsO1icx4oYJds7c0JDb19k97uephvVYHzoik0u2YtOMa2iZ1
         t3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWG+9irw5KJCz8Bf1pvnRmHiRGmC1rjTCEWChJYuBVU=;
        b=Jd+8/YOPmJ9atZb+18CyknkPVMh3NHMHo7pJGj3ADU0i5MPK7fKY6HYbIwLcO4VxSx
         Cjgj0vCl4AHwk0bmcARqOTOpUKlvwZCS4+LX9hBJAUIuxTpR/PIwmgFcpPC6na6aopAz
         PHR2nrsjmruOqRaDyVVMwp5mTggMp8H61RiC1erZlNgNHxpWOd93FsDSkSBSnJQjV005
         9yHKt3medNRh2BU1as6Utk58J2IUw6ECVNOsjL/AT1QEGSE3KWaGZmKsah3KNEDLUYaJ
         zadYRSlIV6jg6pxZv1D7oAhbZetaobDWmguFJDg6qv6ofzLnE7rp9Eo4A+Bm1BlCAx/O
         N2tA==
X-Gm-Message-State: AFeK/H3ZyeyLQUTQejFN7yDsEA58ct28ecMvkotPHXJA65YBhXqIBKXTyvav00lp/6j+Ir0V
X-Received: by 10.98.153.198 with SMTP id t67mr2032031pfk.1.1490812679516;
        Wed, 29 Mar 2017 11:37:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id r17sm14914356pgg.19.2017.03.29.11.37.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 11:37:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] unpack-trees.c: align submodule error message to the other error messages
Date:   Wed, 29 Mar 2017 11:37:43 -0700
Message-Id: <20170329183743.27506-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.517.ga53e110413
In-Reply-To: <20170329183743.27506-1-sbeller@google.com>
References: <20170329183743.27506-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the place holder in the error message is for multiple submodules,
we don't want to encapsulate the string place holder in single quotes.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8333da2cc9..9f386cc174 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -167,7 +167,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
 		_("The following working tree files would be removed by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
-		_("Submodule '%s' cannot checkout new HEAD");
+		_("The following submodules cannot checkout a new HEAD:\n%s");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
-- 
2.12.0.rc1.52.g2de7d24de9.dirty

