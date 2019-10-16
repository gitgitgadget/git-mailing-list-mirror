Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BAD1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbfJPHHW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 03:07:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39732 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389122AbfJPHHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so1467009wml.4
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z6O0LxUrJwYuVGjxRR7DUhT/1ZDDCrOsg+uVNxrCuxk=;
        b=PxqeFme3XGMonycMMprDXb0Q2VYeKmWVeuuIQ2pKf1UP+NI8a7GOIyO/lqUn8WfkG7
         wjyWt5SQpV06izXvB27LKAmgpZr42yZ6RVhPAQfMdm3ZCRiCsKuIUf8hN0RYVWEiCRFY
         wtHN/CpU3oLcpRmXw5DqaYjcrXubk4MY+xlAOasla8H1Go7GSKQ1dFfsTxFweAN3XMSA
         dVR3szEIXC9QkYtmpbx8M8mBAFeCSK+dpfFcF5U56bKX0xeDzuOJissf64QrCrvsLaJV
         7aXwDdkN019OOLYl+nti7GQn03E7nTsm080JvlsUOgKEJI2C/uwMKyIzjFS5fmKdisk6
         hwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z6O0LxUrJwYuVGjxRR7DUhT/1ZDDCrOsg+uVNxrCuxk=;
        b=r4X/xzfa+wbervlzGqTC84Wo8JWbn53qPtXicJ7rM41gZWkH+bG+ZYh0VbuqDxmkWx
         /SFxW5ImuAS8C3/TPeY77LS3JbJCdNh/bwyQX8DBWcKvuVSYuLQLsEJyLefFjIAD6lNK
         kfy8B1RpCmwTmLO72cZtp8e0UsbO73gY/Yc3bMiVHwIzGCpAf/NtSC+owiQZTm2Aw3yE
         5JT9Ii0EqyuiL3+oTXsIMmNJGO9LXJxofZ/iqYJk85tBhTTcC0hoMTmdv/R2RWQ2x9k2
         rEie5BgZf3VflxiDmMseC1AHE/Ph3PXov01wwXcoLkpeOmq+jcIAGjeNhaj0zRzfi2QN
         miJw==
X-Gm-Message-State: APjAAAVdiKzO8ZVno/9y0ExfLnvWx+UlaaAVAcF0rmNz3uuz5rpXt+36
        gfeM3AJfP4ED/1jkEgE/egA+bWba
X-Google-Smtp-Source: APXvYqzsBQKwSCJCctzgc3og5OzLAs+T1WKy2459mlX1oIsSfX2gJ1TEXqe/GiwH9p5j9XhEz790WA==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr1783827wmj.123.1571209640088;
        Wed, 16 Oct 2019 00:07:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm5284505wrm.11.2019.10.16.00.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:07:19 -0700 (PDT)
Message-Id: <cf97c5182eb98cc0ae72f94d4331abcb4486ca83.1571209637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.git.1571209637.gitgitgadget@gmail.com>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 07:07:16 +0000
Subject: [PATCH 1/2] t1400: wrap setup code in test case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Without this, you cannot use `--run=<...>` to skip that part, and a run
with `--run=0` (which is a common way to determine the test case number
corresponding to a given test case title).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1400-update-ref.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1fbd940408..69a7f27311 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -344,14 +344,16 @@ test_expect_success "verifying $m's log (logged by config)" '
 	test_cmp expect .git/logs/$m
 '
 
-git update-ref $m $D
-cat >.git/logs/$m <<EOF
-$Z $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
-$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
-$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
-$F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
-$Z $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
-EOF
+test_expect_success 'set up for querying the reflog' '
+	git update-ref $m $D &&
+	cat >.git/logs/$m <<-EOF
+	$Z $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+	$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
+	$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
+	$F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
+	$Z $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
+	EOF
+'
 
 ed="Thu, 26 May 2005 18:32:00 -0500"
 gd="Thu, 26 May 2005 18:33:00 -0500"
-- 
gitgitgadget

