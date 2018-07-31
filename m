Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A176A1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbeGaOsE (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:48:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35982 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbeGaOsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:48:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so1618375wmc.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCKdZoSJKyyZgRlYvvmDVptvOdxIOzDyvbytlOBnScc=;
        b=KcfeC6RIXdX05POK8soGX2RAC3InQGFnhT0Zr0NnsH/wzo2VWPhwCMYyveglRv4E/p
         o7NtDJkUZmUQ7CKNVnFPqLniQmv6kcXAHw5+asmIW6mTqOGt5xuByCjA/6XCH4HI9fWA
         Jn7gAhWc43ylo4ZmHjaZoBveJ6+fm9cIla2FMO4iQmuIK15YOFi3NXgFKBap9EncYjE5
         4VAZdXGZZWKr4LflyWXJu2xt2eWvaC0AltL1ocjyYBxNssrBZxhw4GYqE6LUOoggt1nZ
         pzFPy72MZRA52E7QsIvzjkBt3RYjJIbjaJFcIBcGtAFj7IRfcl86otpjkw/vuOpTYE/9
         2vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCKdZoSJKyyZgRlYvvmDVptvOdxIOzDyvbytlOBnScc=;
        b=OnWc1ns+91sc8nEOSvKOUO2pf1a4bSfSeSnmsiOGUpS9ggP1CUgCI1vXJzCO/QGUl9
         JVVmNbMCrxvxHIhITaCySuwj31KxA3jzI7/RXxhcAIZsuw5nJDnCb9SsdlGg/cxJivKz
         sghA4W8muHGNv3Q1KIemjwsCwCvaEHj3ou6SZTq4uldcnQ9pbJWlRi5z3Vtdf+oOg6UW
         6YaLfVpv1ejDJ5z0gLW43GHDf8E+CAnGtEitCHChZiySCbGmHTpSXEXCCYmPxhmZaKJG
         /Dw4dIUWZ/az9ETg+vKAI8WzPgwvdBZNHtaK7gPP0y8VruppJbSfgqw65i+diJXUBavQ
         RTFA==
X-Gm-Message-State: AOUpUlFxAwfXcGT+psp6vWbj+/aO3R9rF8pFzTnY0xis0wdWQg31ICsY
        JwZ0FwBPHk2eNcjtKSREBz0L5JIglu0=
X-Google-Smtp-Source: AAOMgpcnMNOiUg2Piv6xg7SOoemObntt58BWIxFKeLJVlQAYuYhjpwTgUddsF/+LnBbV1od3OiQeUw==
X-Received: by 2002:a1c:8d0a:: with SMTP id p10-v6mr2274983wmd.121.1533042467713;
        Tue, 31 Jul 2018 06:07:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] fetch tests: add a test clobbering tag behavior
Date:   Tue, 31 Jul 2018 13:07:16 +0000
Message-Id: <20180731130718.25222-9-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
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
index 1331a8de08..8912312be7 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1011,6 +1011,30 @@ test_force_push_tag () {
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
2.18.0.345.g5c9ce644c3

