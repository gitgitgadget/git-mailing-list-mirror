Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67EB1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFGFFc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:05:32 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34252 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeFGFFc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:05:32 -0400
Received: by mail-ot0-f194.google.com with SMTP id i5-v6so10043138otf.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H+brPoysJLqkqIJIRcANi6S2BdbM6eVy7ups5jCTdoI=;
        b=gpwswktgQ1Gh2OzCqkTlw9X0MhaUXxCaM8iku1wtcKrVJk++NEqfmzJkDMXQIcZYob
         lgfXamYE4tUwQ1GVwFSqic+xnMqZC171tuE5WIaYYcKv3Hlm1XQlGumD5O9jIZBR27dd
         VvpdL84ImhfCyuf0BP23ghGGZbjZl5zVfpHQFS9ht8CSvPjs6o1LKFgD+MhfNeHliOvB
         0A8TI3Wz5EcrHqNefeMo16c2kV6BiUHveayanOfhe25VFyPvmEZZ43p0XIIapV41bVic
         prOp93cm8eg9AD0wd3vbo09yRTHeYSUyUQjU0QPrCcblvCmiq9fPyq9BGkZ9vn8TD7DM
         vXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H+brPoysJLqkqIJIRcANi6S2BdbM6eVy7ups5jCTdoI=;
        b=FIjweGVpfI79B8UjlyrZeVXFeIS41iK59LCuht8k9Wx9oBiJm/CICBTA/CkBRu0bLg
         0pWPl0vBKjA/uFNWJzK5N5IfCkvZOgbizRuQ+5NHZzomxnUFaxc7xbS8MOHowZQDrsqp
         aUeX1XBkOEHGEITYA7o4HOlB4vXFzxxfWR5EU+dIsMqUKw8CjVUmdYoIXbBhvJEk7L9H
         61nkg8gNZ1+Yy+ONjZVvlabJOnQ33Y8PEqAuQYhgzF6hkzLsR/ipwvxWYiZrj17F+n1I
         8iTEZtyOH65pt04Z7FBNUHiKPphC5sjkVx8aXt1TiG2y97OJ6wz8I0FIXtST5LueGkEd
         hNFg==
X-Gm-Message-State: APt69E3qa/Tq/hSjZBBV8kz6+6q7xvLfvIXY7vxV6wriSMDDFNpk/db3
        a3TjoqLIipE9Od/HHM1zqlBQTA==
X-Google-Smtp-Source: ADUXVKIiAbsIEhjVfceeCMq1iLvl1q9MAs76AclJf1p/cD5uXaO7yOvpycamax4k2AB3p+NkvV7EZQ==
X-Received: by 2002:a9d:3578:: with SMTP id l53-v6mr196221ote.15.1528347931364;
        Wed, 06 Jun 2018 22:05:31 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id w189-v6sm5404969oie.45.2018.06.06.22.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:05:30 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] apply: fix grammar error in comment
Date:   Wed,  6 Jun 2018 22:05:25 -0700
Message-Id: <20180607050525.19494-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index d79e61591b..85f2c92740 100644
--- a/apply.c
+++ b/apply.c
@@ -4053,7 +4053,7 @@ static int preimage_oid_in_gitlink_patch(struct patch *p, struct object_id *oid)
 	return get_oid_hex(p->old_sha1_prefix, oid);
 }
 
-/* Build an index that contains the just the files needed for a 3way merge */
+/* Build an index that contains just the files needed for a 3way merge */
 static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 {
 	struct patch *patch;
-- 
2.18.0.rc0.46.g9cee8fce43

