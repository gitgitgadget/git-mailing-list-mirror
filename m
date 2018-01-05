Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD981F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeAEJM6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 04:12:58 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35620 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeAEJMy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 04:12:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id a79so1214022wma.0
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 01:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yzWvzrfLgjfUU5EsC79c+wCaMeI5nxhBy+vLPz7kiS4=;
        b=GqnoFKJkhsQwsUYYVfMRemCENRdFcnUJqUIKafAworRL/LmTsDxFHWfq0NlXjWYeNk
         xYBiE1JuQEybYwgQeG2JHds3V3kLNm4gtm0J3lAfL5z8b8AmQuow9yor8h45OIKeA+dG
         nV9La39e6nPYz25Ag07mh39n8k8/oeDKBjGHnMmzM1xovU7ssAbyZsQ6vRDjLtvnK1J+
         /FaeAljN07JmoTvFz1FghTgeLUd1UNiYPzp/Yz83AIXOAKGX1VGSsmwoSuqk1h+/PPhu
         2fTgcLiJRFlcvnEmYYqcie/ohGbXET2z55jKuxFTczS46iePgnn9I3IffnKCA8HrmpsR
         BehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yzWvzrfLgjfUU5EsC79c+wCaMeI5nxhBy+vLPz7kiS4=;
        b=gXagE+lZ9jAci1HvXBxRAPl1jFF9ctuKrpGV4h373iA6cn8bv5kq6H32sTUdh+JxC8
         lRTGA/bwJwD1vgnRSAQloQvq4pXDor4Dq11zHvd0pFle/1lqreyPuXJno/K1CLLKW3/t
         INfTa9NSg1tDDBCfRXrIGS7DzdCT24zCTD6xTYYnpozfyOSyuexVULVNioHrNeLrBjg1
         c1F7SiEg9ry4BcYiL519qzJ8I4Agn5JKi5hQeD1aMAC9CAltWTc+D+x+LRllQ6/q/RC7
         qMLkO7iZSrawt30zBgf/+YYA9nOMgMNdg876iSSkaV59IcIBOq9BMn0nxgM5j+00/miO
         nHKw==
X-Gm-Message-State: AKGB3mJo5QKnghAPJrZNhZMnXWX4KiO+gG2iM04kX5uy7BFrVNvCeNDz
        wlPOB3WTMuLXVac0+KpHmNvS1NP+
X-Google-Smtp-Source: ACJfBott1AfKGs5NC/mB38Oj90uCPzeUglsqpEFtrD58g5I8qWQwcqpcf0DiCadL+NQwR1twh9O+pQ==
X-Received: by 10.28.232.12 with SMTP id f12mr1785714wmh.24.1515143573175;
        Fri, 05 Jan 2018 01:12:53 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id y42sm7903531wrc.96.2018.01.05.01.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 01:12:52 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 1/7] perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}
Date:   Fri,  5 Jan 2018 10:12:20 +0100
Message-Id: <20180105091226.16083-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.40.gbe5e688583
In-Reply-To: <20180105091226.16083-1-chriscool@tuxfamily.org>
References: <20180105091226.16083-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The way we check ENV{GIT_PERF_SUBSECTION} could trigger
comparison between undef and "" that may be flagged by
use of strict & warnings. Let's fix that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index e401208488..769d418708 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -70,7 +70,7 @@ if (not @tests) {
 }
 
 my $resultsdir = "test-results";
-if ($ENV{GIT_PERF_SUBSECTION} ne "") {
+if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
 	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
 }
 
-- 
2.16.0.rc0.40.gbe5e688583

