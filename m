Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2BDC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiBYSxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiBYSxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:53:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A4537A1D
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:52:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c192so2177752wma.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e7Zl/FeBFM+SXKGzdeD7uESsrx8p8RQRmwdLO6qv5nQ=;
        b=awD181z+MTmyJ/+zZDw1Y9jDYZ2b+AwosZIWKqzd2JvzB5K2xhx0qFjfE0Y8HdCop/
         VW/3a45Di6kJb6xM1K4Tig2roJghukHsr7gcqsuyDDG6OcznqrxDlTNZ/349jYnAmN2s
         R0F0ly70zLaGn0a3ZaQOeHrzKbNUzvkDII7eu2MZEEqzYsF3CdAvc59Ra/ZCjoLfeDcx
         /l5MrkFmkVwnRxng+GANL/RXaSYbCt666HJYoq+S9xQtW2jez7nioQ3FdCGOcH5ZFw51
         tsWCADn6e+vmWyRhxQ6/RXQqhfoFSsdxtrW0pLG+5gY26J4BEdX/9MoMBjOmcHPPKc0Z
         AEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e7Zl/FeBFM+SXKGzdeD7uESsrx8p8RQRmwdLO6qv5nQ=;
        b=fsAswnu8fbDfWtwatg/1FwWDi/wS85KqSqyw6XcqTNRmJPQg5Gy7cSajUHld+KJqzd
         jyxXzHEBbUCphiV3Ju03n4oP2X65hotDeHbVJFcHdKtOAHZVORpjc4Ha3X3SAVxbW16/
         d1Bts4xF4dFyn80LHqmi9dbdA0xlLh6O9H27bJjanwfu8pCr87gAPfWx8WtMpltJ/sxN
         WF2EX0c2LPJ6kEaaFA2WQFUppE1U2vYWsW0aCOH1ZykFMXbvQPNDeFzoPG42aviQm9bj
         elIv3qb6KdK1CRJho32ZheS2gnvTu6hOtFUbLiQh2oE1bK2yh7eoAJ+rhFcrvWbse65d
         DcZw==
X-Gm-Message-State: AOAM533U2ZDimREvvtlRUE+apmR/ur7UKyapr8T4wBwhEMmPpuiDV1fF
        E4nGspJZcrWlUcF+GXdNwYuMJkKonfM=
X-Google-Smtp-Source: ABdhPJyxqdnyWF3ciDzQZVb/GnZdxlMxfRZpe4NmUw+1B47cFobA6ZzgoXmBzLMbpPIkxl7uotZxMg==
X-Received: by 2002:a05:600c:4c9a:b0:381:2d4a:759a with SMTP id g26-20020a05600c4c9a00b003812d4a759amr3856932wmp.57.1645815145828;
        Fri, 25 Feb 2022 10:52:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w26-20020a7bc11a000000b0037bf8fa8c02sm3158692wmi.13.2022.02.25.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:52:25 -0800 (PST)
Message-Id: <c16a8fe01e7bb5811b883346bf381525b413bb9c.1645815142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
        <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 18:52:22 +0000
Subject: [PATCH v2 2/2] t3200: tests for new branch.autosetupmerge option
 "simple"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In the previous commit a new autosetupmerge option was
introduced. Here the existing branch tests are extended
with three new cases testing this option - the obvious
matching-name and non-matching-name cases, and also a
non-matching-ref-type case.

The matching-name case needs to temporarily create
an independent repo to fetch from, as the general
strategy of using the local repo as the remote in these
tests precludes locally branching with the same
name as in the "remote".

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t3200-branch.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7a0ff75ba86..15cc58f1e64 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -886,6 +886,41 @@ test_expect_success 'branch from tag w/--track causes failure' '
 	test_must_fail git branch --track my11 foobar
 '
 
+test_expect_success 'simple tracking works when remote branch name matches' '
+	test_create_repo otherserver &&
+	test_commit -C otherserver my_commit 1 &&
+	git -C otherserver branch feature &&
+	git config branch.autosetupmerge simple &&
+	git config remote.otherserver.url otherserver &&
+	git config remote.otherserver.fetch refs/heads/*:refs/remotes/otherserver/* &&
+	git fetch otherserver &&
+	git branch feature otherserver/feature &&
+	rm -fr otherserver &&
+	test $(git config branch.feature.remote) = otherserver &&
+	test $(git config branch.feature.merge) = refs/heads/feature
+'
+
+test_expect_success 'simple tracking skips when remote branch name does not match' '
+	git config branch.autosetupmerge simple &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch my-other local/main &&
+	test -z "$(git config branch.my-other.remote)" &&
+	test -z "$(git config branch.my-other.merge)"
+'
+
+test_expect_success 'simple tracking skips when remote ref is not a branch' '
+	git config branch.autosetupmerge simple &&
+	git tag mytag12 main &&
+	git config remote.localtags.url . &&
+	git config remote.localtags.fetch refs/tags/*:refs/remotes/localtags/* &&
+	(git show-ref -q refs/remotes/localtags/mytag12 || git fetch localtags) &&
+	git branch mytag12 localtags/mytag12 &&
+	test -z "$(git config branch.mytag12.remote)" &&
+	test -z "$(git config branch.mytag12.merge)"
+'
+
 test_expect_success '--set-upstream-to fails on multiple branches' '
 	echo "fatal: too many arguments to set new upstream" >expect &&
 	test_must_fail git branch --set-upstream-to main a b c 2>err &&
-- 
gitgitgadget
