Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B001820248
	for <e@80x24.org>; Wed, 13 Mar 2019 11:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCML44 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 07:56:56 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:45475 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCML4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 07:56:55 -0400
Received: by mail-ed1-f47.google.com with SMTP id f19so1223781eds.12
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RFGe3S4JIvGOE8+CxkfHjHeLLGyo5hOvUaJ4Yz20k58=;
        b=DxGilpS5YFFyF4sU7O+u2732THZW4THmwBo+FDvE4/ugWPbu0cHP/lu5nw9gEDh8ef
         4hXWQnMB+C24nJaL3jWLMgJQF92vXeV/5HaJ1xrVYBaOFuZFOw0iWRPuKMOIfvy/UQ67
         8MGqLP6GLZbOJz7zg9HwFTNAogLu5WjZoYlHgiDCLIafl5MOo6i+efcDc8fefUhGev33
         QZjSuSNhFwvzw5kY+yW5hooyR+9rkd8aeeN7P3NY8aLGzH4KG6y6IT1TuumUlXgjlco2
         2JXKRkckntDgRM97rB3S/DkA6KyGNlYM6E1Cqn2CsqXys+a6sOStu4G1ZDSvbJ0zU+b+
         OxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RFGe3S4JIvGOE8+CxkfHjHeLLGyo5hOvUaJ4Yz20k58=;
        b=lTiw8U0ljAysEjTHCdyp1//J8UgH9wUgObdTJyaF4r63ZZPwMa63wmkgqwWaBqJtPz
         xqyG/0mLecGCD4ExWZq5pi11AwuFf2ipESctHuXSxi7b8bVNS0OHhPXDZZh5vrzfagsW
         MstTHFnue5HbGDkmZM+Y2SSBHqD/RZFdld5jPDP9oK6AdxLeW3suwmXw6iEpi32CzZtY
         Q/AgdzjbHYZsbz1e/Aoann34lCwrMvVCPjBxWnSANN6Tw463CcyjxVjfv/+3xY41UXjF
         mSOUmsYvdaIwPjjM3vGCB3vFeAC3P/veJjVvwfI5Gs82kJbNGbU8EwJm06xaz1bq1u/s
         Av/A==
X-Gm-Message-State: APjAAAUS18bhlv9g1r6m4oXY05+1CrLQ6tqLbNQPjQ/zCxuCLPaBKzpW
        RO3jzE1lIPOUz77foNUKBSAeDbFg
X-Google-Smtp-Source: APXvYqwQr1ixfMmwBN9G+skYwtJBrd/W+518HjSrMMi0mSel0fplub+Vs03dqw0IpnRkwcUvaQvt0g==
X-Received: by 2002:a17:906:7045:: with SMTP id r5mr6136515ejj.147.1552478213656;
        Wed, 13 Mar 2019 04:56:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m32sm566984edc.17.2019.03.13.04.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 04:56:53 -0700 (PDT)
Date:   Wed, 13 Mar 2019 04:56:53 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 11:56:52 GMT
Message-Id: <f06126c3a11119bf6e2a830bbac312f65582387f.1552478212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.162.git.gitgitgadget@gmail.com>
References: <pull.162.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] check-docs: fix for setups where executables have an
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, for example, executables (must) have the extension `.exe`.
Our `check-docs` target was not prepared for that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 537493822b..df56bf0cd1 100644
--- a/Makefile
+++ b/Makefile
@@ -3074,7 +3074,7 @@ ALL_COMMANDS += git-gui git-citool
 .PHONY: check-docs
 check-docs::
 	$(MAKE) -C Documentation lint-docs
-	@(for v in $(ALL_COMMANDS); \
+	@(for v in $(patsubst %$X,%,$(ALL_COMMANDS)); \
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
@@ -3103,7 +3103,7 @@ check-docs::
 		    -e 's/\.txt//'; \
 	) | while read how cmd; \
 	do \
-		case " $(ALL_COMMANDS) " in \
+		case "  $(patsubst %$X,%,$(ALL_COMMANDS)) " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
-- 
gitgitgadget
