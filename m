Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C43A20248
	for <e@80x24.org>; Sat, 23 Mar 2019 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfCWPZo (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 11:25:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46427 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfCWPZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 11:25:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id a22so3474771pgg.13
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zL52v53Y03n+ceEFJ89GWw/GvEQpi29fWEbH6Av6QkI=;
        b=Z9ydceLzTZ7P+P6+dIsO2x07MzJbAna4cwOhiiUrIfZam/7KJyyKrV47Oa5tcpS7t1
         F3AnuTCG4c0gRiCI8UVxkC4WEgFqGLb9NQebHn3fYxb6XS2VCMRJnL+nEytW7VXR37j6
         e1eIEcKlA7VuljSQa/8AbjrC5Di+qjwGChnb4BtIqQJEOHPBeei/EPcIQ9+imf+kXg53
         pc2TjP5XhdPPpvgfBLrh13NKgoVYhORYEq2FBRd4vOXH8141wnzzErFd0yyubHppyLhr
         6k7FYdKQ4d4JgSjWCzD28b1hgSlNAPFNk+kGQa3GX8RpkVluOt153V1KXxDyRxRFTT2+
         0a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zL52v53Y03n+ceEFJ89GWw/GvEQpi29fWEbH6Av6QkI=;
        b=Dea2z/aooFEKa/FawiJy2w3tSm6THuFNt3fmsyzOO27vJ7MZFxVyskr6DQT79bYT1u
         4oWrjUwJe4+66mx2nyQdlG6BpbWD7D5tr+44Gd2bTABIJA9ExG3W5ekoQl7+9XLIVymo
         zvQR5x48t1X7SiGRUsUdviWlMXmBjISYq+B/Msid80XeOgpnqxJO+V9cIHbkzcHp3WWU
         tripYr5rK+1xhbiYIflk41ySE/Z0DQ53i/1DhCG9G0/SaL91XaaO9FFWKNVkNZfPDrsD
         GwvIae8Wfm4dH7uFjgMygxFiYl3GXE3AmiNM3cCwCsipeeSni05JhJdoBMhjVfCNzlCy
         jZUA==
X-Gm-Message-State: APjAAAUM8rHTqFbKYy0TjyV8yrWXsmpaeP//JcZPiDQT8vFbX8XrrU0z
        MIKNvcYMde851lQjindoCHRKgxs/
X-Google-Smtp-Source: APXvYqzjSCx/QouBg8mn/D67NYzTdhRlBGkEOg0zVG8zX43aL/P+6JVaazMlcShfcOXvR5zP/jTPkA==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr15335336plt.195.1553354743288;
        Sat, 23 Mar 2019 08:25:43 -0700 (PDT)
Received: from archbookpro.localdomain ([172.56.17.211])
        by smtp.gmail.com with ESMTPSA id k9sm22953148pfc.57.2019.03.23.08.25.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 08:25:42 -0700 (PDT)
Date:   Sat, 23 Mar 2019 08:25:36 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] t3416: test rebase --keep-base
Message-ID: <6398944a6f9e696a6f6f7d616447160af93b0639.1553354374.git.liu.denton@gmail.com>
References: <cover.1553354374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553354374.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test rebase --keep-base to ensure it works correctly in the normal case
and fails when there are multiple merge-bases, both in regular and
interactive mode. Also, test to make sure conflicting options causes
rebase to fail.

While we're at it, add a missing set_fake_editor call to
'rebase -i --onto master...side'.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3416-rebase-onto-threedots.sh | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index ddf2f64853..9c2548423b 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -99,7 +99,64 @@ test_expect_success 'rebase -i --onto master...side' '
 	git checkout side &&
 	git reset --hard K &&
 
+	set_fake_editor &&
 	test_must_fail git rebase -i --onto master...side J
 '
 
+test_expect_success 'rebase --keep-base --onto incompatible' '
+	test_must_fail git rebase --keep-base --onto master...
+'
+
+test_expect_success 'rebase --keep-base --root incompatible' '
+	test_must_fail git rebase --keep-base --root
+'
+
+test_expect_success 'rebase --keep-base master from topic' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	git rebase --keep-base master &&
+	git rev-parse C >base.expect &&
+	git merge-base master HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --keep-base master from side' '
+	git reset --hard &&
+	git checkout side &&
+	git reset --hard K &&
+
+	test_must_fail git rebase --keep-base master
+'
+
+test_expect_success 'rebase -i --keep-base master from topic' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	set_fake_editor &&
+	EXPECT_COUNT=2 git rebase -i --keep-base master &&
+	git rev-parse C >base.expect &&
+	git merge-base master HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase -i --keep-base master from side' '
+	git reset --hard &&
+	git checkout side &&
+	git reset --hard K &&
+
+	set_fake_editor &&
+	test_must_fail git rebase -i --keep-base master
+'
+
 test_done
-- 
2.21.0.512.g57bf1b23e1

