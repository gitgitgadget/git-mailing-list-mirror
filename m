Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288941F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeH0Xbj (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:31:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38265 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Xbj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so110697wmi.3
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1v5DmCm/GQCa9MSuy8uss6Vj0H6pVdILDOzoaSvjMc0=;
        b=DgId6BCMG6sUQ+nSxx4DQGNrIJLPcX69aOxcXpZ9k57O7pEy+p34Pv7FbctAYb9kJP
         7NgXDQmH3GlKYZWDAVOHmkwp4rBxUIY873I8fWiRvH9aVJHmTauQuc+EN2XNBwUZl+Gz
         RVRXCxNQj3y1rXqnnzPVmx2vO76UcW1cfKAKjDLjxAA5U5HjtHwhJIRRwcTCJeQASLxr
         j+bM+eG+0CaKKiVGvgaf1oCv51H4qTIGcz6r5UVlZhTt1aAxx32vOKJcPXbcQMOpRtGz
         BqTyt6DuSflafKIb2B8EcsgdHGZDw1zhNrmVP23XdQS14I3pDHrUaa0nWTZSrEDtiLwq
         JNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1v5DmCm/GQCa9MSuy8uss6Vj0H6pVdILDOzoaSvjMc0=;
        b=SgEuiMG2LbgrcYSAXh0LGvXYyqjoVCih0npt77Jfcx///FzaoitTEC5YhG0r9pQhij
         jghs1u4vEaN5FZJa740uMJa2Ev2jIg7afLWV9jgVODbp/MZ+aE1RonKCD1LcL0GXARVl
         2OGj4S5++u5HDcfvocPoNeyEePPkLyG1RK3LwS6k/QRoS/+FUcuNpG5xA0NvbE/uSwUk
         WFsxdLShPmwZCXj8dcGiTLjX0mHmMdLn5vxw2wqXZGCjQzK89hMS7yHNRAQwCzRLEuh4
         Otg/ZY37byd7t9P90wn5Hfz4vUyBKfqa3j/lWudBzfHCMg5JZ7/rFHWEBxYHgDczx2vP
         qP8A==
X-Gm-Message-State: APzg51DK9TsnXhK3Eyk350clANFtXuy3i9AZyW6cojE0stFrJui6gh3b
        /0GcEoSAcpxOpSGtRDnTLpRGwjqD2cE=
X-Google-Smtp-Source: ANB0Vda9O2gEwz1Ax4+LMiQDc+Xpa1CXqRmgnsXtg4eCZpUDgs5WH/vFvo4Tl9AUDQnCd02BNCYPnA==
X-Received: by 2002:a1c:40d5:: with SMTP id n204-v6mr6404359wma.44.1535399017460;
        Mon, 27 Aug 2018 12:43:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm121958wmd.4.2018.08.27.12.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:43:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/7] fsck tests: add a test for no skipList input
Date:   Mon, 27 Aug 2018 19:43:18 +0000
Message-Id: <20180827194323.17055-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180827194323.17055-1-avarab@gmail.com>
References: <20180827194323.17055-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent 65a836fa6b ("fsck: add stress tests for fsck.skipList",
2018-07-27) added various stress tests for odd invocations of
fsck.skipList, but didn't tests for some very simple ones, such as
asserting that providing to skipList with a bad commit causes fsck to
exit with a non-zero exit code. Add such a test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 6d268f3327..cbae31f330 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -137,6 +137,11 @@ test_expect_success 'setup bogus commit' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)"
 '
 
+test_expect_success 'fsck with no skipList input' '
+	test_must_fail git fsck 2>err &&
+	test_i18ngrep "missingEmail" err
+'
+
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
-- 
2.19.0.rc0.228.g281dcd1b4d0

