Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B1F1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeD2UVp (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36421 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754247AbeD2UVc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id n10so11120614wmc.1
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H2BNQWSEAQ1PT1AFqttaiK1J7GbRG1m8jMsvbszmcoA=;
        b=NVq08DrIoN/pkZDvBMPjadQQYBIYbvIUuEPjPBO1kkbmYjzh74EGHKx46+a6Zm/Om/
         7vcGF9/lMq1uGQN/mD80ZGKI5O807z1+joFFvfmtm4emf947Ds119tF11VH2EUoxT2C1
         wraX17EoXZt0h1x0Sd73zpgpOGnrEU7dU36uBuC7EOmeaCyDiSrYnQQRYk/hUGZOs9kd
         twCf1iZHmfSxpW7PccTkdwTlgFv6+n242ev0UnbFCnieCyHuaRhNl9bAOIwTCGgsGmNq
         gEuIZ+SZUXfMyGQVOowH/TTnzqjHVSN+KJbl4BEI9zBlkQ5zrQPgdYLlorKZHhhjR9ix
         YOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H2BNQWSEAQ1PT1AFqttaiK1J7GbRG1m8jMsvbszmcoA=;
        b=WEDfPzIuEo6cpfW7ilGtnqKIAHloFdvjOOKxs05fF+0C7fycAXsGYrCF4+xu5f0vvS
         ihpCMJomCbsgX3SbHeKXNkiLE4jDJCZdOt0cvXtjq/S1lHuRXOa2RSLHyg6BXED0uiF3
         puR2UzUWRzNtJ8K07Qq44tCUZLGx8S3jYGbBcb/3QNs7Ygb+OO38FUHhmtvL1xFnJnPN
         ie91ZYo16NsMvPO2SOEyMpV/0V8SVKmwJMowaLaGpEiFG8+L/eHGMTdPvhrB1FMLH+oY
         4FZBZMd9thQ7KCEUMO2uE7B1TZrsCZ8W9Gjt3gM/s4G/9zQ6h9rTufc/z+4pXa0ZRFK4
         5Ezw==
X-Gm-Message-State: ALQs6tCmzIlPVenKZ4DQE8XwzNCLnUPvSCBCCn1hunx80Rs/M3yKC8JH
        nebiIRouJwnH3F4luFGvKKsBUaUR
X-Google-Smtp-Source: AB8JxZowVX8NZdwD0QgKaRz7tIvPMfgGyT+keO2WNvtO545aaysHQRDCVEUAzEoIDEcsgDrF1kEHGQ==
X-Received: by 10.28.111.87 with SMTP id k84mr4924883wmc.142.1525033290603;
        Sun, 29 Apr 2018 13:21:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] fetch tests: add a test clobbering tag behavior
Date:   Sun, 29 Apr 2018 20:20:59 +0000
Message-Id: <20180429202100.32353-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite only incidentally (and unintentionally) tested for the
current behavior of eager tag clobbering on "fetch". This follow-up to
the previous "push tests: assert re-pushing annotated tags" change
tests for it explicitly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 71fc902062..9cf14c5cc1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1003,6 +1003,30 @@ test_force_push_tag () {
 test_force_push_tag "lightweight tag" "-f"
 test_force_push_tag "annotated tag" "-f -a -m'msg'"
 
+test_force_fetch_tag () {
+	tag_type_description=$1
+	tag_args=$2
+
+	test_expect_success "fetch will clobber an existing $tag_type_description" "
+		mk_test testrepo heads/master &&
+		mk_child testrepo child1 &&
+		mk_child testrepo child2 &&
+		(
+			cd testrepo &&
+			git tag Tag &&
+			git -C ../child1 fetch origin tag Tag &&
+			>file1 &&
+			git add file1 &&
+			git commit -m 'file1' &&
+			git tag $tag_args Tag &&
+			git -C ../child1 fetch origin tag Tag
+		)
+	"
+}
+
+test_force_fetch_tag "lightweight tag" "-f"
+test_force_fetch_tag "annotated tag" "-f -a -m'msg'"
+
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-- 
2.17.0.290.gded63e768a

