Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF60ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiH3NzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiH3Nyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:54:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F60D10FB
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:54:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e13so13421792wrm.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=IMltBZ4M0IkpvwXFSb8AG5YF2NMVr6CiU5ni2/ATH48=;
        b=Q1G+in45TGMbhcW4xPfRLB4n+Lok/cU6x7iDmt2rBnv83nxqAgcKSxQuczWRFsfJFA
         UScTvwPabkbtSRfG1/iMn61sUG8PkxeHn9W9q9Q4vmyatd95auOY5V69lTHqkllDW79S
         fQPgO95c08jS+8Mivuz25cSfS5hxs4f2zzo1o1Cv9qVO+ogYXbdEyHVpYJltk4gIyddT
         zZsHEd76ghacyxT89W22alKhfq1qGUtDhmU587mntJbfYMKhZiYd42l7dGGBz3dwQAdC
         ELoUhBIeQbpClTckrNJgRWgRa/WIroIFCopS1VbUlxfvJnDmYY+hI1GXYFI2vQWZlIxO
         ai8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=IMltBZ4M0IkpvwXFSb8AG5YF2NMVr6CiU5ni2/ATH48=;
        b=d0wemjjJAReVW6zIYyWN7V/sLgSge3eGJ9wef3glZPhVRIPIIZAW9GshXQM9El+L+Z
         i/44v+fIoTTt9mobOCv1kL8jhQ40Jm6P44G7KcglqwlY8T8TAghV7/9VD5th3vgmUcvZ
         n/MJtVuSgAoCDHRQhz0hBfmknC43GWcbJjVDd1XIc/70qQHazDnP8+TNiajvMAA9+XNZ
         0Jw4Lc3S/xGAmqmLz3Gv0YJjMWyTq1ypLSJWEaJcZzHawOuDhW0VyS1WAA7fcw5ZbYGb
         M1CPGhKQoOMjRx7tLhoBYDfvFamWUP+rdSgNdpg9NMbAP2yaonux8n+4YYVS2nMY0aTH
         8yNQ==
X-Gm-Message-State: ACgBeo20s7T3nXxmtM8lE1zLhIkmgV3uVA1ZBN62tLVzg05xjDwtc44m
        R40xtv3Zh+0q1tx8a+6LUR/HGodaBds=
X-Google-Smtp-Source: AA6agR6oIKOFjOoyYoK4lAxZM6GVzaQggFEB/HnqGxdtZzZiNiHoIJODs/ashKbIhRr8dIB3m1hIPA==
X-Received: by 2002:a05:6000:1789:b0:225:7557:94f9 with SMTP id e9-20020a056000178900b00225755794f9mr8943392wrg.635.1661867670361;
        Tue, 30 Aug 2022 06:54:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19-20020a5d58d3000000b00226de10c0c2sm4448144wrf.15.2022.08.30.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:54:29 -0700 (PDT)
Message-Id: <736f2dde6918822e5f8234dc8cddcb94aa3f92ac.1661867664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 13:54:24 +0000
Subject: [PATCH 3/3] t6132(NO_PERL): do not run the scripted `add -p`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When using the non-built-in version of `git add -p` in a `NO_PERL`
build, we expect that invocation to fail.

However, when b02fdbc80a4 (pathspec: correct an empty string used as a
pathspec element, 2022-05-29) added a test case to t6132 to exercise
`git add -p`, it did not add appropriate prereqs (which admittedly did
not exist back then).

Let's specify the appropriate prereqs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6132-pathspec-exclude.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 9fdafeb1e90..cada952f9ae 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -293,7 +293,11 @@ test_expect_success 'add with all negative' '
 	test_cmp expect actual
 '
 
-test_expect_success 'add -p with all negative' '
+test_lazy_prereq ADD_I_USE_BUILTIN_OR_PERL '
+	test_have_prereq ADD_I_USE_BUILTIN || test_have_prereq PERL
+'
+
+test_expect_success ADD_I_USE_BUILTIN_OR_PERL 'add -p with all negative' '
 	H=$(git rev-parse HEAD) &&
 	git reset --hard $H &&
 	git clean -f &&
-- 
gitgitgadget
