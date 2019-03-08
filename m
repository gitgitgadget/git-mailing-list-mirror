Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AEC920248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCHJ7n (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:59:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35880 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfCHJ7n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:59:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so13768109pgr.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAwU0aOj1/IwBkIPhzITRQE06TOUgMON3CoayBYboMo=;
        b=jGC4JRr4z5TjvW1YFeaZC1VofTakEHIyY2aLGzE3PC98FMp7RVwlscbM6ePBVrjGmA
         ufki+Cs7Qe5GEYhNyhxXYpF8K2x4kacCKOL+NSSABaG1PbMVkZFeGD5JudskwEoe1jHm
         YBTHhWF16GAvc4jZXSPrSIPGC3U82CSKjrafp4c/UD7ZcZGjehN9CKBOSjYGl3hTkYwa
         GEDAzZAZfKM+SkTWUfQOKex9nF79lKhKGEHGPz0JoVWGhZvUnel0ZRmidn4zo8a7KFBM
         qis7ByDoSe4aP4AiMMmAz2TwbhwB9Xv7rn23HqU/kDagbr8vJx3VG+Nux6YYQJeW15Ao
         JtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAwU0aOj1/IwBkIPhzITRQE06TOUgMON3CoayBYboMo=;
        b=D/m+K0wGWc+WXADYLPHSeZuOOVmhG3tqfaQ/ehYC4tPm4IhGHFsIwy3kgQvxX2hYf3
         xkv+HnXa+l4NwfZJnHBy2MVu4qV7J92Oi8eQf1xhs3h/BzjTRoSMepLJ8o9Uz/M3dyh4
         pMWVmrPD9JnsFXPhjYNgWmX4f4bHFgj4C1aYt0sdIwnTcy3NNkc7ifQkA0WQLqgCPGfN
         zaG6w6mWT37AFcaH4/pcLgDSvqbUNo97heNs02gk0VYxWi7CAnYkNlQ5MoiB6USfB0KF
         fChUzJqP59g7loEhAtT/ANC3W42gVvmyiH/dRHUQgeg6BErYWPxndEPILH93yu5Z3hVB
         90bA==
X-Gm-Message-State: APjAAAU/3AqJ3ZfW5X5mSpsKMQoSJSXkdSV2o0X0diGGp5sw6RqdQAO7
        2poa9KQcbJlmm71lZCYZERw=
X-Google-Smtp-Source: APXvYqwopu1TJe6GJjdPGkv5D1H7eLXYbOy5c183oDdYXvxS25LSecFasA7QIbxDIW3U48S+gpp1TA==
X-Received: by 2002:a62:f204:: with SMTP id m4mr17371725pfh.58.1552039182622;
        Fri, 08 Mar 2019 01:59:42 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id y8sm1773862pge.35.2019.03.08.01.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:59:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:59:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 19/21] t: add tests for switch
Date:   Fri,  8 Mar 2019 16:57:50 +0700
Message-Id: <20190308095752.8574-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.21.0.rc1.337.gdf7f8d0522

