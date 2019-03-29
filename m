Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1E420248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfC2Km3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:42:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38178 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2Km3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so877376pfo.5
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JaZr5bfvKebPGrUdO51lGrPiGGQVqoesD4eykAnZKR8=;
        b=YLVfv3qpHrEQerYGlAT34QF/hOBIDjXwbUD6fEGI1A4ApeEAlAXVo2Nylf1uHndcvE
         cuvTEM2ow0Xb57KeRsGgX5v3lTKS3ZkAS75xS+sIpbKE8Lbw+WpijY+fdBa+KMsSitF7
         7x6HzIJ4pvBFfdBtKwLpijBTSwr4azhbt8n1PY5eXuF7VarQF7adt9LYBmF0koTNCjSs
         aA4e1H2j8BU7naAV+O2UoZLrqHcqSwwIHJ3RH9Y6YF5OzLjP7dpQ5wKEqYS1hVp1UzCz
         z3NGbnEYghnNb//B1AMBvifHJdCRkcTFLPY5a9z4Gu/yyUsVOlpKnohDws2dHNctTYEH
         ZKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaZr5bfvKebPGrUdO51lGrPiGGQVqoesD4eykAnZKR8=;
        b=CCeSqbIww53NY/vSrucdGfoYbLr7PFjbOj8qPSIVmFuH5D50CJ7FhrjhtxltOV5GAV
         9AR5HDrUpsYtpBXG6U3xr5FVsq+pThsUj4hnNlcbk/xmcV7j9/MNHZJeCeCG1TqRcTYq
         yA42Si2pyML8c/ZEQt3zQD1BU1H93oMXyyYGGOEJYBcdvK46km/XiX3rV4igXwsk0YV+
         TwQHs15birH4SbrN9MPKIpO4pfsdG6HFENODLHKQM1LyyC/tJMGvOCCGuP/s4kuL0uiG
         nfKAvgGsA7n8H1mXfdRkofpLRHE51WecmFm9xmFqNHFlHFsHhJxenmp1ya7cnWasC84d
         wRiw==
X-Gm-Message-State: APjAAAXoWAy/iG0sJYjlHkvttEWLADYr/rFeAI8n+amlJsvSO66/NVCZ
        p36gkgdvPYWRK5PuYTrF1jw=
X-Google-Smtp-Source: APXvYqzmnOE4vfLic8ya2zwnRSaTnqionqTF3eudBDhot48obMb0w6WSibY+T1ktyF5ls6yydj04UA==
X-Received: by 2002:a62:cfc4:: with SMTP id b187mr18520723pfg.130.1553856148986;
        Fri, 29 Mar 2019 03:42:28 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id g64sm5680958pfg.13.2019.03.29.03.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:42:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:42:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 25/27] t: add tests for switch
Date:   Fri, 29 Mar 2019 17:39:17 +0700
Message-Id: <20190329103919.15642-26-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2060-switch.sh (new +x) | 96 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
new file mode 100755
index 0000000000..f9efa29dfb
--- /dev/null
+++ b/t/t2060-switch.sh
@@ -0,0 +1,96 @@
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
+test_expect_success 'switch and detach' '
+	test_when_finished git switch master &&
+	test_must_fail git switch master^{commit} &&
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
+	test_must_fail git switch -c temp &&
+	git switch -C temp &&
+	test_cmp_rev master refs/heads/temp &&
+	echo refs/heads/temp >expected-branch &&
+	git symbolic-ref HEAD >actual-branch &&
+	test_cmp expected-branch actual-branch
+'
+
+test_expect_success 'new orphan branch from empty' '
+	test_when_finished git switch master &&
+	test_must_fail git switch --orphan new-orphan HEAD &&
+	git switch --orphan new-orphan &&
+	test_commit orphan &&
+	git cat-file commit refs/heads/new-orphan >commit &&
+	! grep ^parent commit &&
+	git ls-files >tracked-files &&
+	echo orphan.t >expected &&
+	test_cmp expected tracked-files
+'
+
+test_expect_success 'switching ignores file of same branch name' '
+	test_when_finished git switch master &&
+	: >first-branch &&
+	git switch first-branch &&
+	echo refs/heads/first-branch >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'guess and create branch ' '
+	test_when_finished git switch master &&
+	test_must_fail git switch --no-guess foo &&
+	git switch foo &&
+	echo refs/heads/foo >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'not switching when something is in progress' '
+	test_when_finished rm -f .git/MERGE_HEAD &&
+	# fake a merge-in-progress
+	cp .git/HEAD .git/MERGE_HEAD &&
+	test_must_fail git switch -d @^
+'
+
+test_done
-- 
2.21.0.479.g47ac719cd3

