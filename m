Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717FD20248
	for <e@80x24.org>; Thu, 14 Mar 2019 21:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCNVr5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 17:47:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40442 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfCNVr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 17:47:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id u10so1623838wmj.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYkMdXApGE4aYrKM81d6b9cOCU0BUZFifHyy+rtD0CI=;
        b=Ej7n2z5BhUDMgQdWCJRUI0eMXwMJsvojnAyGGKZoWa0mi/1sFjSKaus6W+aVchI0MD
         McZ7HUSST7A5Tez8UrsGTonXHuMRFDJUywgkUzr4PG3eWmXiw5YmpHDzuO/7EYrt+7RF
         ZZzxhn5Kxu9QLFiQ2OaPkLtdkp62NRY8OqHgmAAiL0okhnyLO7z21h38DxOKR4FgMg8u
         i0ynCPfxXPgZUrVXGnTrh+VV4i1pXquSm/pVAtjWbOSJwasqjnZA7jqj18/DBcyqvJI1
         4FVXumxqq6AMZGn5GgieaLg2JtVzkBRwqrgz7ABVVgvHIAgfLtSRuZaf6Lmy6dEecgGT
         XV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYkMdXApGE4aYrKM81d6b9cOCU0BUZFifHyy+rtD0CI=;
        b=JqSHy8p6BD9UpMr0kPmY26dgVKqCWuk15ytcBXx7AvbvjkwiLlujeS2f9CPoQbpXTN
         n6tekfqxQ4MsMrueJX4NWxuTIWSrItqNT5wQZoTdHj6/4tKIlUIRXjNeOHmTLTVCdveg
         8Y/H0YOd1hSbEy5oTYU6M9NPyi28HdANbhS1WnPU3P5Z39PhJiHQCTp5ToyIUOe4ZkoI
         x1yvEVKAmLL/YOyVVXp6cOX94c9msbJ/GOZji8/zd5gh7sxLT7wvC3+3iL4WQZlhnXzb
         kHudJ1cxlJUE8S0dy9lqbwstWpm5C9ijDVrGe3kRKH5orM162wCE2WUAhEsMgN6nAGc4
         4XbA==
X-Gm-Message-State: APjAAAWe8sYqSAd4T6MXtfyrkYNBOare4KrhbCkUyKW8LQRv6okfw220
        XtVQ332o6DPgxGP1CFytF09r1yfySIg=
X-Google-Smtp-Source: APXvYqxGF9Jz+gXAG8xSvvXx39tm9YG59sFNew3Y6OK14QTdsDbTdC9XSMTWBsQ4rvoS2pP8azz3sw==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr376262wmi.4.1552600074821;
        Thu, 14 Mar 2019 14:47:54 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h137sm194348wmg.41.2019.03.14.14.47.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 14:47:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] commit-graph tests: test a graph that's too small
Date:   Thu, 14 Mar 2019 22:47:34 +0100
Message-Id: <20190314214740.23360-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the recently split-up components of the corrupt_graph_and_verify()
function to assert that we error on graphs that are too small. The
error was added in 2a2e32bdc5 ("commit-graph: implement git
commit-graph read", 2018-04-10), but there was no test for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 56a616831e..ce3459a6f5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -399,6 +399,12 @@ corrupt_graph_and_verify() {
 
 }
 
+test_expect_success 'detect too small' '
+	corrupt_graph_setup &&
+	echo "a small graph" >$objdir/info/commit-graph &&
+	corrupt_graph_verify "too small"
+'
+
 test_expect_success 'detect bad signature' '
 	corrupt_graph_and_verify 0 "\0" \
 		"graph signature"
-- 
2.21.0.360.g471c308f928

