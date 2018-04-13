Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9119B1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbeDMVTM (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45242 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDMVTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:10 -0400
Received: by mail-io0-f194.google.com with SMTP id 141so11723858iou.12
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0w4yAgWMxr4/x6wnJu756LDKOqgfo6eE6aPUd9TtsTE=;
        b=RGplD3tGbdqPT9AM4AcmVGGbZe6gtY5LPBq1tN+aJSSX5/hG3DrydyHsQR9KplXoOC
         KVUSkZx3XPixyvvs77orwn0IqeuG2em8FQ4IKbWhLnmg9LytsLlSjfc1dMLzfZ091PG1
         rGHfh5Q5MWknHORMLFCMCVLJqKcsV7uSjFc2Fv12IaoA3jew/cd9aO2m8gf61e9gZmYF
         lhgDxKJ40Qvqt53/RipHkoLbGaPvTvA+ZgncHyktz0XNLPcZJwfU08SFWnG1HJmlCsG2
         ZYX/2i3nqz7I83+qXdK9yd2rK9zpNPHimnQJFM1BDagzbKA11jzoaBYsrbkDK1ZFN/3s
         7IjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0w4yAgWMxr4/x6wnJu756LDKOqgfo6eE6aPUd9TtsTE=;
        b=gedVIbFyYyBGH7DtEHRh8tN0nd6L2TP6Wja4fBlUZ6TeK6iMKjduroqrqdSHUbRHvq
         4eLZ1OxXy82WriVPXRmqvq8sNu8f/X5kK/DME7ZvndcSONCOGRPdv5+jWr/1Q2QX7vkI
         QCPYSKSP9v609LUB7MIxquvLojecyYLB1PKgy92/df05IMXw6brGm+5sZuYdZEsfRjFx
         oRYT/OSYcE2u6vs38elu9ZLjm0gYm/HZpFmrNLwjswb+Dy2yz3aR+3a34QVJUD7o25bL
         z6TImIxY6xrUhqkjgxu1HcfX7HjaC15viyotWGtGY0EfvixdK05bnpJUy1patg7hbTLb
         0vHA==
X-Gm-Message-State: ALQs6tBbRxv0jBu/vT9s/HFKLSAoS/GavCjpSbqkqSHXDBbSGqwe/sbU
        9gBeYlYKWLYaHuFqSp7rAhX7QBxxhUQ=
X-Google-Smtp-Source: AIpwx4/+1lzcejSh1P53/Gv7Bp4wdJI5w5N3YwOux1PL5eHRSoUDdZlDfuhY05v9n5X4StCFhWaoAA==
X-Received: by 10.107.137.158 with SMTP id t30mr14409978ioi.230.1523654349239;
        Fri, 13 Apr 2018 14:19:09 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:08 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 1/9] t7004: fix mistaken tag name
Date:   Fri, 13 Apr 2018 15:18:29 -0600
Message-Id: <20180413211837.99415-2-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180413211837.99415-1-mastahyeti@gmail.com>
References: <20180413211837.99415-1-mastahyeti@gmail.com>
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We have a series of tests which create signed tags with
various properties, but one test accidentally verifies a tag
from much earlier in the series.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ben Toews <mastahyeti@gmail.com>
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2aac77af70..ee093b393d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1056,7 +1056,7 @@ test_expect_success GPG \
 	git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
 	get_tag_msg blanknonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
-	git tag -v signed-tag
+	git tag -v blanknonlfile-signed-tag
 '

 # messages with commented lines for signed tags:
--
2.15.1 (Apple Git-101)
