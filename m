Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4614420248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfCQMwH (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:52:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39751 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMwG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:52:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so9502471pgp.6
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9zzyC4bUuDWsMj21SIT1PpDwknwIOMyd+a0pgKlEsc=;
        b=di2eiLs30KzgPd/tn2aJ0Cj6gqGn81ODB0e3nWJMTlxWeV0MF7SGeB4RvC8ifh7gQP
         LAbuFeBlSEDh50oLADcZUXvrDmFxXlRP67HIt7C2yM3nZb0fTo/UjtUJZp1LDHVqlfv/
         3XcBr5AYpan51VTDEeD4qdj06soLoPwOPpv/DGDBF/ZofVuIpnVRWxDgeL9mQqKmqb1b
         dAs4nMHFnXEZ5GhlWpxfD2zw+8ysFJreFJZrM+D2t6t1c0NfogO2o5F5RjGXrVC/SL+y
         wdQx3RVke+0UP+qQIR1raRi8qS81/Efyu9e1tkl9tbE6Td+ZxS1b7KP3jTt3zjw6X8M5
         XBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9zzyC4bUuDWsMj21SIT1PpDwknwIOMyd+a0pgKlEsc=;
        b=L5qTCnYkhg3bTjLzRj3OWK+7qQplWa7b4OviYkmexeEQAi79jDyntlboDiG+jZrMdg
         aG4E7zh3U0LdkU742HTm+ahRB5sv97g0Lo49jEUa4PvLbq9M6r9Yr5CAhwZymC0VR3tT
         pcKARk9FRCL1iFuSoBy4SQmsGpQqxl/+AWPhbzEGgBL8SGhoumuKz6aP5wCPtGbZInCU
         J0vREAEUkdrHQK02UAI8pXR8gtu5Oq5qaP2Dt5K1KtINXczsgh9AvuHfyk1VkSw/hKtQ
         NZ8xnieY2qZ7RtNPZV7cz++TPMUDnZLQlVZrAFMtAD/ym4YCA4PL19IVIcOX1qSB/Che
         e1Yg==
X-Gm-Message-State: APjAAAXekZB+cvi3t4FaR5O6NpLa07TGgpUU6ofl9SPAu40adjDRdBnM
        GYzmgDhUZa9ju3PGx8LUmeY=
X-Google-Smtp-Source: APXvYqxwniGE3ATqMPu5cb7ofJGgzKp+DcKK5UBPFNb9OuoVZyM9b0HELOyJecFrTzZ+B/R3Afs24g==
X-Received: by 2002:a63:545f:: with SMTP id e31mr12557131pgm.409.1552827126054;
        Sun, 17 Mar 2019 05:52:06 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i21sm983790pfa.14.2019.03.17.05.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:52:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:52:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 24/26] t: add tests for switch
Date:   Sun, 17 Mar 2019 19:49:24 +0700
Message-Id: <20190317124926.17137-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2060-switch.sh (new +x) | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
new file mode 100755
index 0000000000..62ec1bb924
--- /dev/null
+++ b/t/t2060-switch.sh
@@ -0,0 +1,97 @@
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
+test_expect_success 'switching when something is in progress' '
+	test_when_finished rm -f .git/MERGE_HEAD &&
+	# fake a merge-in-progress
+	cp .git/HEAD .git/MERGE_HEAD &&
+	test_must_fail git switch -d @^ &&
+	git switch --ignore-in-progress -d @^ &&
+	git switch -
+'
+
+test_done
-- 
2.21.0.548.gd3c7d92dc2

