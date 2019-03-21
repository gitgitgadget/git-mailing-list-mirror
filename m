Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B3520248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfCUNT5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35511 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfCUNT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so3527647pfe.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wk+ZVUI4iEQ4/HIA60XoqykSDt+fIQ9a31MW5fInTlM=;
        b=rhk8hb07EqSwZf9HhWKZiGvMJBlYjHmhFy1fzn67KCvLNXC8xiB6QUUAidnKGo5TI/
         6LfJAJpTk/Cu2V+GzUuoQeZX/ai7twa2isIcfK2la/f2l6n/yOwuzJZYKlLR5FBD1Em1
         7lctuQ3zxHz/twulW83BUEnasey5k3/RR/bJUfLXAAKkeIeIvxEtuTIMcNDjxGSg4+tO
         Ws27czJucCjx5y62Ib18NSBgxwXLMEAWxVNduU8P7ed4DtfpFp9tP9fILp11oiVh7Rix
         grEcYQJeFjt/rUw/pdPTQOyCgeBaBTbt9b3fXh3vA9p73m8KXdY2+tQzKvdJnA5C7J/x
         7Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wk+ZVUI4iEQ4/HIA60XoqykSDt+fIQ9a31MW5fInTlM=;
        b=C8kP6uvl1AX9nwT9QofKCVe3eq42voFMrW4DqxC08TbN/QfDL2+3cKu8iQcDYaBZCl
         dNRQBSHkHopJUkB45Obd+xacnjwvc3lciGwSWhig/Ehdlm+oRZqGcsmkgJDBoNINr0l6
         1+yDStTMeo00zALCzRebrFZ7v2y4MaJ2uYYTn+MG8/Cm5sNL+sl+527XScTC/Is3htD2
         sZht1bmTTy10AGr44WAf0G2x/P7oSYOrxz2OUcJ8jfoziHn3fWhIIJd5B0ZAcX3bLvyt
         j/VATy6u0eZY/9kBwY/TvaxFlkiVRflvyKKARRS0VySVgfZd3E7x5BLGGfFZyYdTe8os
         aNmw==
X-Gm-Message-State: APjAAAXvQdRlgLei1TdEYIfRz+LN+1fnGHy4iv7vku4FniB3eiqNv20u
        indT5gK0M/aYsNhaTwHADXU=
X-Google-Smtp-Source: APXvYqx3MTbYfZ3ALEOO3cq59Ts9VjWZ8/eEWKUfCYeZd/F5g5vlDpCx+v1FTfvL0Iv8ooSTqsZwgw==
X-Received: by 2002:a17:902:70c9:: with SMTP id l9mr3597980plt.131.1553174396569;
        Thu, 21 Mar 2019 06:19:56 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id j14sm7319724pfn.77.2019.03.21.06.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 24/26] t: add tests for switch
Date:   Thu, 21 Mar 2019 20:16:53 +0700
Message-Id: <20190321131655.15249-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 t/t2060-switch.sh (new +x) | 98 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
new file mode 100755
index 0000000000..81e13cf7f0
--- /dev/null
+++ b/t/t2060-switch.sh
@@ -0,0 +1,98 @@
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

