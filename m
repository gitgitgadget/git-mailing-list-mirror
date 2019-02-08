Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A506F1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfBHJF5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39020 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfBHJF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id f132so1381428pfa.6
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sc8aNSrFrkIsJ24E90PonvCAYYh0CKWAqBoNE0dd9TI=;
        b=pKAECDbpFQbC1yx7/UdLT8MKFPph0mB7ES2+zIfB6g8LSPD5MBTZ8kebwTASBnPvUA
         M46vd3B2NDUljAM6DBKxDo9UJnkYRaLVwr5l5/JZvIMxyJ5/PaZ+GOfkLYrszlZuWpBT
         5vbW8TYgg9d6873on93X8uEAXcN2LMBOhWIFhPCCvMEW/P7NTujq2Iu9x+6XKJsK7lr/
         5jEq9+IS/oMSauftl/ogy7Sjh0iu3343j+n8YVVo0eKDQw/0wPpTTxqKg24hX+frbqhu
         oJKCOHLqr8n28eDyDhJIi+blzQq29haOLQjhsFEHZOoO9ocl4BSmhLZoHHgrbAP08A6d
         fa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sc8aNSrFrkIsJ24E90PonvCAYYh0CKWAqBoNE0dd9TI=;
        b=Y7ctb/TypJXWRktwARyyqYfn7oeM0tTcrw50TQ4hI4A/WE4/R1IVvBIF3HP5c3uS3b
         Xv5+UVjBZuXiqGczTMuzQpJI9g3729vdEaMzhkMiKyC1Doy2MjalmCyZdFvopr/73EnW
         N6rU8L2vwOvWGBnxmnBvAVCo6t96oa5//1zZAK8igOOHDhqiY+hg+FIkNVWm7NeFHc81
         m3nf0QcOGyISE60uvawJgh8V7MDjbwqHVeBDNCwKMMQO+3+Fww1FL6B2+Gp/iOXdmNoj
         XWu7hgNJEYhBl74BdssWA37H9MEk6e4vXXUL+ZLzlefnSwsF/aO812Da5c9EE3aiiMMH
         0RVQ==
X-Gm-Message-State: AHQUAub+i+udf35nCJEsNIffMtS0uQIVM1mbn4BVzDWm1awIhCWi4IVb
        7jEaHh6XVH9j3atZMqSvprY=
X-Google-Smtp-Source: AHgI3IYSDBisuLC1qJJj06K6ibLyIgUQp7r7F3lxdR72VkD9TpGTcWZMdHkkJfiMcsJPiIqXfIJseA==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr20884525pfq.61.1549616756478;
        Fri, 08 Feb 2019 01:05:56 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id u186sm1965774pfu.51.2019.02.08.01.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/19] t: add tests for switch
Date:   Fri,  8 Feb 2019 16:03:59 +0700
Message-Id: <20190208090401.14793-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2060-switch.sh | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 t/t2060-switch.sh

diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
new file mode 100755
index 0000000000..1e1e834c1b
--- /dev/null
+++ b/t/t2060-switch.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='switch basic functionality'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit first &&
+	git branch first-branch &&
+	test_commit second &&
+	test_commit third &&
+	git remote add origin nohost:/nopath &&
+	git update-ref refs/remotes/origin/foo first-branch
+'
+
+test_expect_success 'switch branch no arguments' '
+	test_must_fail git switch
+'
+
+test_expect_success 'switch branch' '
+	git switch first-branch &&
+	test_path_is_missing second.t
+'
+
+test_expect_success 'switch to a commit' '
+	test_must_fail git switch master^{commit}
+'
+
+test_expect_success 'switch and detach' '
+	test_when_finished git switch master &&
+	git switch --detach master^{commit} &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_expect_success 'switch and detach current branch' '
+	test_when_finished git switch master &&
+	git switch master &&
+	git switch --detach &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_expect_success 'switch and create branch' '
+	test_when_finished git switch master &&
+	git switch -c temp master^ &&
+	test_cmp_rev master^ refs/heads/temp &&
+	echo refs/heads/temp >expected-branch &&
+	git symbolic-ref HEAD >actual-branch &&
+	test_cmp expected-branch actual-branch
+'
+
+test_expect_success 'force create branch from HEAD' '
+	test_when_finished git switch master &&
+	git switch --detach master &&
+	git switch -C temp &&
+	test_cmp_rev master refs/heads/temp &&
+	echo refs/heads/temp >expected-branch &&
+	git symbolic-ref HEAD >actual-branch &&
+	test_cmp expected-branch actual-branch
+'
+
+test_expect_success 'new orphan branch' '
+	test_when_finished git switch master &&
+	git switch --orphan new-orphan master^ &&
+	test_commit orphan &&
+	git cat-file commit refs/heads/new-orphan >commit &&
+	! grep ^parent commit
+'
+
+test_expect_success 'switching ignores file of same branch name' '
+	test_when_finished git switch master &&
+	: >first-branch &&
+	git switch first-branch &&
+	echo refs/heads/first-branch >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_commit expected actual
+'
+
+test_expect_success 'guess and create branch ' '
+	test_when_finished git switch master &&
+	test_must_fail git switch foo &&
+	git switch --guess foo &&
+	echo refs/heads/foo >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.20.1.682.gd5861c6d90

