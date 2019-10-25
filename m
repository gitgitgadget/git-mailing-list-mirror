Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37E31F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 22:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfJYWVB (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 18:21:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42724 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYWVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 18:21:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so3979519wrs.9
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3fNQhvgFkiFUT9VpcfiG0kl1dA2p2Ftw9aIvFNg+0To=;
        b=lNsXfZkh7piEid7/kiSR8UKRsz3idLnLrQzcLiTSvlTvzQtkRpkjnQ0j9+OvyzR8GW
         ZdWyqacL/kzRHRAxZjskdwVzVymMciM2lniNZ0S6NqxErnp20dgEbEaj9PSet97REtyg
         9jF1xwW5kh3Qgps6aSE6qBze/jnIkLq6lVnx678lbaUW9vuUuoCuO7oeVZ6ZdlzgsZ7I
         SJr9jUI3KjXcI7SrYE5NKoz4a+QD1UZXN4xAhcXm1Yjzv4hm8/0951v55Jt3DBdgkXWt
         +8cpExJ7CsiuTx4senR237fedNEuSMGdm0Byb69Cc30nLOH9SakM18kAJgQx9LJBIjJt
         VzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3fNQhvgFkiFUT9VpcfiG0kl1dA2p2Ftw9aIvFNg+0To=;
        b=ESMVUrqIlA7DdkU/RipySJiFno7ONjleTSLo4GpW6sR3JOMM4bmlPFL3Ht2SzRpxL1
         G2cpGen8IwZwPVzM7mhVRceKmO1o7+mlib2lzCMqWPAJDZ02I/7DiC/1N0u/4OiWBocS
         x6QpPsQolAM8vhjeO3b/FIbjASSdyRac/uoK+0Ww4VpTea2NVyhAL7zDbzH2yuqF5o1Z
         0RsRxcDG7sdJ/xvotElMp6QrzQDr5xdFgLEXDfw+AKlPnMUAict67bDrCeU+eVFWSbYS
         Nax/2jv2mndz872imaSWcSl26MQ0PmBAVajdoA+dn3UL+0ne+aETxeYWY7tJAgGZXGjn
         ehuA==
X-Gm-Message-State: APjAAAVwqPKo9A1LwdLkk0AQ0umpR4xWdyTqxb1yPxt/s5Vl10d6SF7f
        W3S/hjXcJ3B99Mq7I7E9qQt7d/N3
X-Google-Smtp-Source: APXvYqwXpYtjOwReZUXNIaSTCllDtgBp0o4WXllaqedQKd+7bcdI/tQWW3DSc0L4C9ISkZB6KgkJXA==
X-Received: by 2002:adf:f342:: with SMTP id e2mr5217787wrp.61.1572042058999;
        Fri, 25 Oct 2019 15:20:58 -0700 (PDT)
Received: from evergreen.lan (5.223.75.194.dyn.plus.net. [194.75.223.5])
        by smtp.gmail.com with ESMTPSA id o187sm8038170wmo.3.2019.10.25.15.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 15:20:58 -0700 (PDT)
From:   Mihail Atanassov <m.atanassov92@gmail.com>
To:     git@vger.kernel.org
Cc:     Mihail Atanassov <m.atanassov92@gmail.com>
Subject: [PATCH] Documentation/git-bisect.txt: add --no-ff to merge command
Date:   Fri, 25 Oct 2019 23:20:32 +0100
Message-Id: <20191025222032.3399-1-m.atanassov92@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hotfix application example uses `git merge --no-commit` to apply
temporary changes to the working tree during a bisect operation. In some
situations this can be a fast-forward and `merge` will apply the hotfix
branch's commits regardless of `--no-commit` (as documented in the `git
merge` manual).

In the pathological case this will make a `git bisect
run` invocation to loop indefinitely between the first bisect step and
the fast-forwarded post-merge HEAD.

Add `--no-ff` to the merge command to avoid this issue, and make a note
of it for the reader.

Signed-off-by: Mihail Atanassov <m.atanassov92@gmail.com>
---
 Documentation/git-bisect.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4b45d837a7..58b5585874 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -412,8 +412,10 @@ $ cat ~/test.sh
 #!/bin/sh
 
 # tweak the working tree by merging the hot-fix branch
-# and then attempt a build
-if	git merge --no-commit hot-fix &&
+# and then attempt a build. Note the `--no-ff`: `git merge`
+# will otherwise still apply commits if the current HEAD can be
+# fast-forwarded to the hot-fix branch.
+if	git merge --no-commit --no-ff hot-fix &&
 	make
 then
 	# run project specific test and report its status
-- 
2.16.4

