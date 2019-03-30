Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9147020248
	for <e@80x24.org>; Sat, 30 Mar 2019 14:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfC3O2V (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 10:28:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36540 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfC3O2U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 10:28:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so1369563pfn.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC7ogn1dZXaQ13yVn0z4VykUOjFkAe+PZoyncoSnCgY=;
        b=UpwXbPKUg6szpmo8CaVGNVY6v0x3I22pnLDXNZykLTSHDNZI1aPljpiY05TU2xHhAr
         QJsjL/RS8CP/O3BeYRHbzFY94c8Sm2HsiAoI7ztvD34u0hBBxYMVV0LyfgVDyTX1TyFY
         cMJHka4vQKkhPIkxtbVMhrlV8icuM7RhjNRfEKe+Ua/D+L/+iqQkNlNEGnhhQ7jZ3UCj
         qzZ7mA0RfEtq+RJOYBFCuozrPm/dSbTZh6qntr4AeaqTYgVYD/4pnDwv/sD3BMGocLtd
         kXwIA/QMkd3GkkymS2pOSAlZ48h1cNLtRYOFfAEBGo2zdsZHSWMbLqYq3nKnvL3nZWNc
         5vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC7ogn1dZXaQ13yVn0z4VykUOjFkAe+PZoyncoSnCgY=;
        b=LmjqoS+vw2nowf9gLmzdNssmcHuZMcucCromkjIanWRR/Q3q8lGUIo2HxVdwAPhAK5
         p12YBFBG+ua96UXVxzakZ0pNvkM9rB58mVEjXe51+dVoyt774KB/2rkzvE7DzV+IO5IQ
         faI2lCcjxs6yk5y+TW0XVqoWWggf1+JKB9oawU+Lm7Sn+P7CfobBv8f/FrYzO4VHyFOm
         nSC/QAhd16ouk+3tbvCDoKJi5lp8gZL8woBSKrdQwYp2fLzstnx3wkZVfFC58JbEkEZC
         V/FszlMeundNh0zVF0cYuCB3kXqFNWj4v7RqBgwlI7GGFo10XG1QCMGAr2I4VRaP17yc
         kyXg==
X-Gm-Message-State: APjAAAVvZ+OXG/dtPmWcgHKzl+gN8jCI2MuMogSQALnD+carGCphfFVu
        sA3JNIWG0uv5NQz2OReKxiXtlNB7Hks=
X-Google-Smtp-Source: APXvYqyzo5hB36uVXuuNxmw4kHJCo8yDfMMr6E/DSL6vPPn8ob9TwPBdS+xg8PonvB503ucJXpDQTg==
X-Received: by 2002:a62:6c6:: with SMTP id 189mr52168183pfg.36.1553956099916;
        Sat, 30 Mar 2019 07:28:19 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id v12sm6621737pfe.148.2019.03.30.07.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:28:19 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [GSoC][PATCH v4 4/5] t0000: use test_cmp instead of "test" builtin
Date:   Sat, 30 Mar 2019 22:27:57 +0800
Message-Id: <731463ed9892c283b6acb0ce69e097769e43de62.1553954776.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553954776.git.ttjtftx@gmail.com>
References: <cover.1553954776.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
---
 t/t0000-basic.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 3de13daabe..49923c5ff1 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1118,16 +1118,18 @@ P=$(test_oid root)
 
 test_expect_success 'git commit-tree records the correct tree in a commit' '
 	commit0=$(echo NO | git commit-tree $P) &&
-	git show --pretty=raw $commit0 >actual &&
-	tree=$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
-	test "z$tree" = "z$P"
+	git show --pretty=raw $commit0 >output &&
+	echo "$P" >expect &&
+	sed -n -e "s/^tree //p" -e "/^author /q" output >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git commit-tree records the correct parent in a commit' '
 	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
-	git show --pretty=raw $commit1 >actual &&
-	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual) &&
-	test "z$commit0" = "z$parent"
+	git show --pretty=raw $commit1 >output &&
+	echo "$commit0" >expect &&
+	sed -n -e "s/^parent //p" -e "/^author /q" output >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git commit-tree omits duplicated parent in a commit' '
-- 
2.21.0

