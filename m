Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34CF1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfGKR0q (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:26:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43701 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKR0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:26:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id h59so2757919otb.10
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kwetX+ZK0Xii14Ovg7+FtsnCGZzIMpO4geBuLqgpBN4=;
        b=LHlVBpZJIcLUCc1p+431UyxiUNgBasBIcbNImRHAPs5ALqWUCIYs7oRnCOptiPKA5O
         1kD7kpqh/3+S7hO3AR+XAwWud8vYDBShakRp/eglux75Mo82Ll1b56QtjyPe/Zm/dwf8
         oKU9BxIPhG+VFuwraAbEW/wPAyd0HeX28YKut3N8Ccuh973AC4k5UakPo3+7is3147Sw
         zb/lwpn1NlhUE/Ec3V+fCkOW10E7USXwF7NzkZmhlgG2EKdiFCj7cyIcK3wpkpcjNtFi
         KkrMIvsd/HMYNJ+TGOIDGY3/czMJVzocG+xLc5NPHCsTrVXuW9Q6IWzt20m4xsaAEcgV
         dbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kwetX+ZK0Xii14Ovg7+FtsnCGZzIMpO4geBuLqgpBN4=;
        b=Dxj7FTDR4sy8RVo3c1FE4fVyE/3KaAfzHNRl88njenvyRxxWVeuzxMIP/IG0LYUSpy
         i9vzS5mz6GTHAHu8II6H2EOv4PSMxaDDEkJwyxvPI4WjVcbCL0nVk5DxMkj6rM24CrJR
         2KFQj2oREgX7+yPRQk9N3zV3RURn3b+ex8INF/RzQddwhRNtsXGbkjBGNcWL1IUU26T/
         +JqDE1Wk+WRJg7AzWOZT4vWgWQ+X2u96VAngaRJwo8mvQTQWFbfSAq/Wz+pz+4RpGFUH
         G+Fbb1GKrkuWJhWg4kNautyPU9BHKNe8XmcDfZpyZfpVQhxd3oc7ETr+kNGYGNzS8tD9
         sAGw==
X-Gm-Message-State: APjAAAWH7ZLdqmPmYPHec38qVY0XjKptHoY4g57t+w8xa7OGvAPebIIv
        GkNhQZb/kzznYOPDO75oKImHEWIb
X-Google-Smtp-Source: APXvYqwqlttH/L62HR8e5+rJvVVa/BI0drvuRkkE/w894grKXozyOxP/HXyeYEE391uBAR4WW52U4Q==
X-Received: by 2002:a9d:7843:: with SMTP id c3mr4144868otm.1.1562866005237;
        Thu, 11 Jul 2019 10:26:45 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id h11sm2045933otj.76.2019.07.11.10.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:26:44 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2 3/3] tests: add test for git log --no-use-mailmap
Date:   Thu, 11 Jul 2019 12:26:26 -0500
Message-Id: <20190711172626.16480-4-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711172626.16480-1-ariadne@dereferenced.org>
References: <20190711172626.16480-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to prove that the --no-use-mailmap option works as expected,
we add a test for it which runs with -Dlog.mailmap=true to ensure that
the option successfully negates the configured default.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 t/t4203-mailmap.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 43b1522ea2..23a8947bce 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -465,6 +465,14 @@ test_expect_success 'Only grep replaced author with --use-mailmap' '
 	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
 	test_must_be_empty actual
 '
+cat >expect <<\EOF
+Author: santa <me@company.xx>
+EOF
+
+test_expect_success 'Grep author with --no-use-mailmap + log.mailmap=True' '
+	git -c log.mailmap=True log --no-use-mailmap --author santa | grep Author >actual &&
+	test_cmp expect actual
+'
 
 # git blame
 cat >expect <<\EOF
-- 
2.17.1

