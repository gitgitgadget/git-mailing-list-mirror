Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A8C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 07:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiB1HPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 02:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiB1HPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 02:15:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF05F38BD3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 23:14:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so13803142wrg.11
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 23:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7fo/V08RV85KG5bCKUNg8voV6oaYzkfPFN9ggvBAVsA=;
        b=M1/Tj5xIV8hZCxJetIF913RP9kCqCKTt3Zlb0NFZZyLchwNgRrjaIttnoEjgGrc7Rx
         NsezrhrF57ZRqkfd5WcoR7cjaaEmlQ14qCt2b7j6ezg09N55gDmwpLuzgivbQmd4iBmo
         kOE7RcaL5XgvulBERKvTZGDyblDQFj2K22G4MyLtw2F5o6zPvJd45shMrl1LWOoJVs+8
         L2ZRPgsn4JNNTYgkFgVTxDpx9sHUULi/PEqJdjGkmjQONLHKLK4urqRwiV9ZFR9Gp46d
         BEQ5Z8AMt8tTp/rtgvGPkUEjW9wQWI93cF7h9RpaZWuBu/nrgXeS7EtSQXFOF94Ce8i+
         CasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7fo/V08RV85KG5bCKUNg8voV6oaYzkfPFN9ggvBAVsA=;
        b=wE6a+2WrblawhxG1RA76uPY5Ttrg3rBn5S00eNaH6wwlNliBWHJlC2QJp2g7t8K2ba
         UNsNSgqqETNoZREjxCvuLHiikR132YEtJE29OjoQdXc9JKEIVQSZFXhngwSM7Nv5udw9
         7/a1E64IabNpXHtrxTAEGWmy9XrWP2zwft2vyGvHaGcesOISQpmyaRb6B12EQnTr8wVv
         MsYPMVzJ9a61Avj28mQoH8fReBB0wZhpHx/5CGyMnl+mjrlh4L1wk1DD/Jc0VJXPq2Fd
         rn+FiK43GTmYKVAdOtt8euwsMmqEhd2CLzYDzxgV382rlMLTm1/JxQLGCa4LtYTC0XX+
         8LAg==
X-Gm-Message-State: AOAM532j7tBujvb7xOUUxeEmJLkSxau0PFTya4PabRJDasNfM574QkHu
        2sNhPgnFpyxofQ8wjeRDDCBZ81oyxfk=
X-Google-Smtp-Source: ABdhPJxmMshdFZXysIc9Jr4AxUxcsOoRDX5eCIVZr6YXXmcia5H5b5oV0bgcS6pz42xLhrqKNGTfTA==
X-Received: by 2002:a5d:6d44:0:b0:1e4:9a6d:c171 with SMTP id k4-20020a5d6d44000000b001e49a6dc171mr15380182wri.468.1646032470102;
        Sun, 27 Feb 2022 23:14:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b003815a59c065sm3976293wms.36.2022.02.27.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:14:29 -0800 (PST)
Message-Id: <d5b18c7949fdea966d31b2b8ca3f8aa8ed3a86b6.1646032466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
        <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 07:14:26 +0000
Subject: [PATCH v3 2/2] t3200: tests for new branch.autosetupmerge option
 "simple"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In the previous commit a new autosetupmerge option was introduced.

Extend the existing branch tests with three new cases testing this
option - the obvious matching-name and non-matching-name cases, and
also a non-matching-ref-type case.

The matching-name case needs to temporarily create an independent
repo to fetch from, as the general strategy of using the local repo as
the remote in these tests precludes locally branching with the same
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
