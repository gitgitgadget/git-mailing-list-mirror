Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCFC433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356565AbhKYQNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356420AbhKYQMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:12:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670EC061397
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so4984483wme.4
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OuCqtHRK/vK4Q099RfeF3vUiPh0kfiXb7vMkw7ScbpY=;
        b=MMF04sY9+A+/ZpWg/hnb2x1Z76QLB1f3dnpti2V1Svytf7qU42EU0X7hECdF2LWBKk
         8qHPVf5nI7DgfOaIuBI5xMsx1vji5Dhw40/a9Um+FV0dLvK6NjCP0Ruh88AoIkLO56qf
         SICY+eKQYIzdIP0cpTOMAjA0TnLHDnhsM/yYKO9ZuhupsX6Q1CS6n1MH0h33O5vcYptt
         HiGRBPYIX4dG8snmM3N5RWYeDXx8zOQZeJW6GjLLjfwWD1Uqvt6Cn/D3X2e8U3FlgIyd
         WRMJ/KmpiQ5aZglCMxVn26wN+ktBxGyhkrPImjdv9aM7pnCvqYazxPIrJotPU5oTONik
         f7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OuCqtHRK/vK4Q099RfeF3vUiPh0kfiXb7vMkw7ScbpY=;
        b=Lnz+w6Lkfwkvv8GQFnVLWr9i16bC6P2FdtxMll+MvMt67YlMu6vnQZhvIuY7sJoL+W
         2c68gecc0cvwIYG5WQ5HQ5fbUfAC5jFvYKdFATAZwK1wyUbIvq6TzdY297VJTxZcyLsL
         K9jKFFUMKCdBTkUXXUUBS+z3HqjiLeaPVL/WbNk5CVhX2ju/iCOg7ieMUgOC4HrmFfun
         aUTiBtXI9YoShyleyrkRnjnT0kXJ31A0UvC5qYNdChBV7TMR+jSh4YsGXen1hjCw90Dc
         X/VonUbsjeloKhlQcegG+1QwbPTsLdYz42x1kn6NPBzGQjdC2kNc64zg+vzlaZF5r+5L
         NXmQ==
X-Gm-Message-State: AOAM532jsbnhy2/DlGVXzlw6wSGgQhEeH0POzvngbgZbMvfaH5hUIXoa
        nzlh4YifPmXXB5EJ3om4+VTEDAf1lQM=
X-Google-Smtp-Source: ABdhPJxxeUYhXX6R5TgN6lnCKvAgDqZOE5+X4p2Ke7BR2xPRKzaea6qaL3miVyCRBs1QyZcD/ETo3w==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr8481002wmm.189.1637855874448;
        Thu, 25 Nov 2021 07:57:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay29sm3071033wmb.44.2021.11.25.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:57:53 -0800 (PST)
Message-Id: <9d8394d8c7666b13403394332d826a3729a1a3e0.1637855872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:57:48 +0000
Subject: [PATCH v2 1/5] show-branch: show reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Before, --reflog option would look for '\t' in the reflog message. As refs.c
already parses the reflog line, the '\t' was never found, and show-branch
--reflog would always say "(none)" as reflog message

Add test.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/show-branch.c  | 12 +++++++-----
 t/t3202-show-branch.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 082449293b5..f1e8318592c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -761,6 +761,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			char *logmsg;
 			char *nth_desc;
 			const char *msg;
+			char *end;
 			timestamp_t timestamp;
 			int tz;
 
@@ -770,11 +771,12 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				reflog = i;
 				break;
 			}
-			msg = strchr(logmsg, '\t');
-			if (!msg)
-				msg = "(none)";
-			else
-				msg++;
+
+			end = strchr(logmsg, '\n');
+			if (end)
+				*end = '\0';
+
+			msg = (*logmsg == '\0') ? "(none)" : logmsg;
 			reflog_msg[i] = xstrfmt("(%s) %s",
 						show_date(timestamp, tz,
 							  DATE_MODE(RELATIVE)),
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index ad9902a06b9..d4d64401e4b 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -4,6 +4,9 @@ test_description='test show-branch'
 
 . ./test-lib.sh
 
+# arbitrary reference time: 2009-08-30 19:20:00
+GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
+
 test_expect_success 'setup' '
 	test_commit initial &&
 	for i in $(test_seq 1 10)
@@ -146,4 +149,16 @@ test_expect_success 'show branch --merge-base with N arguments' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show branch --reflog=2' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [refs/heads/branch10@{0}] (4 years, 5 months ago) commit: branch10
+	>	 ! [refs/heads/branch10@{1}] (4 years, 5 months ago) commit: branch10
+	>	--
+	>	+  [refs/heads/branch10@{0}] branch10
+	>	++ [refs/heads/branch10@{1}] initial
+	EOF
+	git show-branch --reflog=2 >actual &&
+	test_cmp actual expect
+'
+
 test_done
-- 
gitgitgadget

