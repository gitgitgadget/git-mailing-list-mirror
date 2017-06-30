Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264AB201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbdF3UxS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:18 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36472 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbdF3UxR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:17 -0400
Received: by mail-pf0-f171.google.com with SMTP id q86so72397502pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pmtV7V2W9b0dcdFM/2i4iMM6gNB2LQA/soS6ZhgafWg=;
        b=mUHoGZuhRiXDXcTdIqFNXmQf3uohDL2NCLifS4mwVYEnFTXgupDOrlIJbPZx+bD7MQ
         6T1lSDmSMbP/fyGWRlMHm52IifL+R9JST6CMLYnG4jC2NvVmmV4Fa8T1Fjv2rtLxcW6v
         MPJlnqhNrp8w3/IZ+QNIN06FxA58bfIesXJLwPqS/HAijtO89IGhwCvpXW4hqYnCjAuj
         yfbbtg8UnWJQisHiDo6MxpE9fALQ0JXbuveaGDDw2IFr2Bk32l06aWcthvVN+kc2n8G6
         VLQRvel1YQ9bHL7fQpBG6pgHbchJiodNvkDB4IIAQXjg4WgO8Itk+4cbc/cZKoFzDS1B
         kl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pmtV7V2W9b0dcdFM/2i4iMM6gNB2LQA/soS6ZhgafWg=;
        b=a7PRzKiwqDPRt3+EN32NhA+mcOv5R7CtadTj3d/aK3JFUBNj/WFZFhzwYFw3dHzX3q
         UGHM4cmZT0FRa/+0qsNdi4pZrD4NX/r5JMCtbJAIM6Z45ay2WHlksyrxcelVpmnGVz81
         LgJK7YWsrhphUmPxczjOQ9L+eZrUZom+jYR0T/J4m3CAkcifxRzDzTnoLPwUd9ejpwyv
         nXM2p01bMinDDxd/R6Qw2VkGq2qjr5dNzXaMIydHAL4veDtAna1aweRmHZQr+JCMtFht
         rgOi78opfhrA4HoEn17RARwdtmaIctq/4cMchh/aLQ+D9drBlrvUSfOtvwWCLy4wYXdM
         IyXA==
X-Gm-Message-State: AKS2vOzRz7ZAlTU6leDZu3H1ngd3Q7UAlXKwg4aeOc5NDhpRDu+IpM4U
        VEaPL8GUk5QoljCs
X-Received: by 10.84.215.203 with SMTP id g11mr27085018plj.287.1498855996149;
        Fri, 30 Jun 2017 13:53:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id 5sm16986564pfe.60.2017.06.30.13.53.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 01/25] diff.c: readability fix
Date:   Fri, 30 Jun 2017 13:52:46 -0700
Message-Id: <20170630205310.7380-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'.
Use that.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 00b4c86698..2874dfc6fc 100644
--- a/diff.c
+++ b/diff.c
@@ -3282,8 +3282,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	const char *other;
 	const char *attr_path;
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	name  = one->path;
+	other = (strcmp(name, two->path) ? two->path : NULL);
 	attr_path = name;
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
-- 
2.13.0.31.g9b732c453e

