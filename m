Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29291F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeKLXl6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:41:58 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:47095 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbeKLXl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:41:58 -0500
Received: by mail-pl1-f178.google.com with SMTP id t13so1428597ply.13
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wEV9cIgWs525ZKGNeYbV877/nXZqz6BNojCLkSUJYOg=;
        b=oCElxX2QICSTNpO2YolKeoEqgHu4wEyNTksj++uzZKqBGTVi5fiiueBHycumFItgSq
         IneCX1tQ/e+wlTO8Kx6pRa7WWps0Qq4qMEmapthckmgS4SMZ8uK8hUcwJs8teidlhe4g
         G1jBveP/I1e3S7nOIcYvFp0xODojLxAhSqURX22/e9p4sgUz6UiKRwe4rjrjvWKmXCV5
         shzlKyCBow7JA8XiOnyFaH5CnHWW9NISZIKNI/eGi0l60lBMXAaQJOyQT4fZg3D2lkHN
         3Vfv3f6ijiyuF9rRmxhlcNYH1WlGD5gDZIgUTWa5WOAikHnkulYyfaiaM+ukatBzAi4r
         NP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wEV9cIgWs525ZKGNeYbV877/nXZqz6BNojCLkSUJYOg=;
        b=Oux+WlswRAmyC5S0qxaPAq1cDTxIWyaF1YsR/VjQr5Gkw8dL8y3+jdhAySRKFJSUiz
         8mSsokyKXtqqbujPUFUmmYPjIbMHGijn1uQwStrFunbYfEQ2ri2yi7zBA9U4RzmD6B8w
         j61bPgrHmDnrxGVy93/EnuJTZls3WU+Wg5YL55ugs6Nj2YMcA8iV2KO8qD4wq04WArBI
         4OrP9W0KDW6Owe7lFfjd5s39OjY+JRDQYzw8NSuPst9YocRAtF+pfs1E5OtkCMkp3NE9
         G/YXOq/18skfGHR+w78s26/Gi7ON2o4H7iK5FrT/nsdAI1Ib36aX2etLRRkm5GFt5+Ph
         JzRg==
X-Gm-Message-State: AGRZ1gK6eSOZWvkjwdG1MItGKlQuFJeHDEUhaeO+HYhafpQYyZR0/Qs0
        KXa6KHpGap6Eizo6yk7NSlj3EVFd
X-Google-Smtp-Source: AJdET5dDm+bMh0y9LPYgDwHTSahOB96YmNseh0qqvkMxy6Cdj6K2v37C2lh6P4C6+8LTr0TUtD1q6g==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr1000428ply.261.1542030516579;
        Mon, 12 Nov 2018 05:48:36 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id l23-v6sm29125423pfj.179.2018.11.12.05.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:48:36 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:48:36 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 13:48:27 GMT
Message-Id: <eddea552e414964e19413c02fb07167432e8aaa0.1542030510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/5] t/lib-gettext: test installed git-sh-i18n if
 GIT_TEST_INSTALLED is set
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

It makes very, very little sense to test the built git-sh-i18n when the
user asked specifically to test another one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gettext.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index eec757f104..9eb160c997 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -10,7 +10,12 @@ GIT_TEXTDOMAINDIR="$GIT_BUILD_DIR/po/build/locale"
 GIT_PO_PATH="$GIT_BUILD_DIR/po"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
-. "$GIT_BUILD_DIR"/git-sh-i18n
+if test -n "$GIT_TEST_INSTALLED"
+then
+	. "$(git --exec-path)"/git-sh-i18n
+else
+	. "$GIT_BUILD_DIR"/git-sh-i18n
+fi
 
 if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
 then
-- 
gitgitgadget

