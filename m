Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18461F404
	for <e@80x24.org>; Tue, 26 Dec 2017 21:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdLZV7P (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:59:15 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38820 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdLZV7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:59:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so36613146wme.3
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PwRj7IuavhqesGbFO+pvtGk4kqJPi4ZVqH6eTcTa//g=;
        b=eCvWaM4nFr+w+CMynHqUYwrVZ0sGcH8jjGXZUy2Gqrd0Voe85Wdm2Mg7Qrzrjc4k31
         M5hBeT+NVDj94pFA+QFfK4gofR+uTcJRNi47yAjJ6GzbDWboeymtYDbEvahMQAyIWX0V
         tD+/3flCdKxZe/kCXuQCTDr4TOD048PrXS+M+2bhDTRqU1G3beOYeZq9ns4yf17umrYQ
         2Sqfw6F4Z8vm3GgGwbGfcXS/Ea3SQ5JXYPUA6s1BpNnmusyffnqMnlnfKdYceNNk2C1/
         ydqE7SZIiWExC6pV/Ic7LeCwqeI+F+lRzGXfbTaHY9CauI/e3sQmBnnbtDthLmIrdrIq
         OLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PwRj7IuavhqesGbFO+pvtGk4kqJPi4ZVqH6eTcTa//g=;
        b=Zc605r3+OkMIU3ZmLSAqNq0DaMDyaZuY5b7qWNAtGd/LOtNw007IECU7JewJc4dz6G
         AkPMutamo3qNT3xDG1EMQMAa6QfJTxQsceKKQBpRoyqzxpi3PxPqdIUTpRnT84XRR60w
         vpx9673B6Aa6d1ZOXIKTwoB/a1Fb8n1EXfNbE1kgmsBXsKnxQMyseIBoJotKhcpt+MIN
         5h3+3KXqbkkXQUZHyyDeRictnJRWPteMVpYXPE31TCl0xfZk5f4aRqHM+oQtyZTzTvdu
         Dk+YKf0dymtk7jvsQSWN9wKAS7uZwxsps1zYTMnWJQouYHbFBcimtQEbDCZimn+JLCEi
         Uu4Q==
X-Gm-Message-State: AKGB3mJadfmPuGvmYIcjIbPvD1PvWWVBYuBDr2ZsIJtesjUg8WWNcKSX
        VG911/ADuG1dJJ0huufU0v75iU1Q
X-Google-Smtp-Source: ACJfBot7QLTq0zO5ODoDCFJ3558XSzcK2UnLVWUr+o/7+ArM05/965jiTWkst/9CotRBKWHxRn8nbQ==
X-Received: by 10.28.187.133 with SMTP id l127mr20110275wmf.128.1514325551828;
        Tue, 26 Dec 2017 13:59:11 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id d71sm24516204wma.7.2017.12.26.13.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Dec 2017 13:59:11 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 1/7] perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}
Date:   Tue, 26 Dec 2017 22:59:02 +0100
Message-Id: <20171226215908.425-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org>
References: <20171226215908.425-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.15.1.361.g8b07d831d0

