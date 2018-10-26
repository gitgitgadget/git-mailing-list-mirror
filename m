Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F321F453
	for <e@80x24.org>; Fri, 26 Oct 2018 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJ0Hq5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 03:46:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55513 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeJ0Hq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 03:46:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so2881177wmc.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqP4ifgdyK4zyDNdbbZLEqxXMcAsbdFVTcoO9nvJutA=;
        b=nUqIGU6IOqOCu8Ajkocbe3yT31RnIXGBdFVvy+0TyyTsJBYNn9pXNqKODuYJ2pk50Z
         i3uV+8+yIY45r8eiNPrCvP/W4YpELXzaPSVowIZXEK/acTd5DE9/MKr6N1KLHPynS6+K
         GZ39L9x+9RmZkz+y8ozFET7EC0T/bXmVRVRYFoOxTWV59Q9Q9ANK6y666VnQhYYc3x1R
         Pr8iQ+OAP3u0uWS2MenN04/X0Lx1h7ieocmUa+PADzjaGiMbZr7AXnWMtuBaq41knTQA
         4E9mWW7PtmnKpg84zyTXSjpYQk2HiLlClU0nnWCn4kxmePC7YGBCmrYsS7yEsvByQt6Z
         qo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqP4ifgdyK4zyDNdbbZLEqxXMcAsbdFVTcoO9nvJutA=;
        b=kG/CbVNI1K/9ErFr5Nutlv6NXTT+qD9PCvffJbhDDX1czriWZ1vHD9kXIztuh2EGb/
         eyCNdHaJD2t94SZnP52tfZ9fnaCZSZRshrP/WM0SB8p4VJoAV3YMDPL23zZfoijqx7Ak
         PP/3r4fHI/g3O5dygTfYy9ZgJrOfGcoSNgg+KtYsB12FGoVIb0QBzuRqaZEp4NnnJUQD
         0/tJwXOqL5MzbJ38HIDl59Ro1r7nyvkeQ9GBpdtQpNrstMsTHoqqm+SLy/fF8LXpWoEm
         2xqDqzlMbp1JVtS/klRb6OPBiZVFj4UGyGKCc4/GJDdNCUkOvpmOzORD9h1Ms7+PNWMW
         8V4g==
X-Gm-Message-State: AGRZ1gJcBiLBcUFS1FvERfKxNh/X4fNJh6P9OxyduFLb/FefxkT6Rvze
        FncVYdCoM0blFde6MLXrJkf8HxIKEhw=
X-Google-Smtp-Source: AJdET5eSxc+Fj3YSSQZPhSTPMQcHsqozmbn0X44EurgSQdgDPZvZt44gf8j8gwBw4vTpVPwE3IeAGA==
X-Received: by 2002:a1c:2746:: with SMTP id n67-v6mr6795934wmn.116.1540595278669;
        Fri, 26 Oct 2018 16:07:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5632830wmt.16.2018.10.26.16.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:07:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/8] push: test that <src> doesn't DWYM if <dst> is unqualified
Date:   Fri, 26 Oct 2018 23:07:39 +0000
Message-Id: <20181026230741.23321-7-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181026192734.9609-1-avarab@gmail.com>
References: <20181026192734.9609-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test asserting that "git push origin <src>:<dst>" where <src> is
a branch, tag, tree or blob in refs/remotes/* doesn't DWYM when <dst>
is unqualified. This has never worked, but there's been no test for
this behavior.

See f88395ac23 ("Renaming push.", 2005-08-03), bb9fca80ce ("git-push:
Update description of refspecs and add examples", 2007-06-09) and
f8aae12034 ("push: allow unqualified dest refspecs to DWIM",
2008-04-23) which are most relevant commits that have changed or
documented the behavior of this feature in the past.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5505-remote.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2e58721f98..979a13b415 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1246,5 +1246,33 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	)
 '
 
+test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
+	(
+		cd two &&
+		git tag -a -m "Some tag" some-tag master &&
+		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
+		git update-ref refs/blobs/my-file-blob HEAD:file
+	) &&
+	(
+		cd test &&
+		git config --add remote.two.fetch "+refs/tags/*:refs/remotes/two-tags/*" &&
+		git config --add remote.two.fetch "+refs/trees/*:refs/remotes/two-trees/*" &&
+		git config --add remote.two.fetch "+refs/blobs/*:refs/remotes/two-blobs/*" &&
+		git fetch --no-tags two &&
+
+		test_must_fail git push origin refs/remotes/two/another:dst 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/two-tags/some-tag:dst-tag 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/two-trees/my-head-tree:dst-tree 2>err &&
+		test_i18ngrep "error: The destination you" err &&
+
+		test_must_fail git push origin refs/remotes/two-blobs/my-file-blob:dst-blob 2>err &&
+		test_i18ngrep "error: The destination you" err
+	)
+'
+
 
 test_done
-- 
2.19.1.759.g500967bb5e

