Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9C41F453
	for <e@80x24.org>; Mon, 29 Oct 2018 13:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeJ2WCt (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 18:02:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54860 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeJ2WCt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 18:02:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so8187483wma.4
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMX4GBsLMVAfmgf4EkAoDLt3MFRb4NlfIiHTt3svfFc=;
        b=dEYSRWD03xf4qKgIgI2WFw5px4ipujWkPHyfyuOB9NC4/ApUL0lEhZfjsbes7c3KFT
         BseAPLa7iGcoOMDAvhvY+U49duCqMXcF9VBxuru4+mnlBsLFRsjW0CzIdmDfOMSOHdcl
         6yGnGDQckzTIhlygQuzhUht7nkvcXmPuC90D7m8ouCQC4C3CWoqtBNC6q5RN3NLd9qyA
         MNITOzyrBI7MoO5opiXLu29KOMnsQIMrZkPw8pewvmIRJBTMbpd6tr8qs6i8uxfYzwGW
         O+29o3dBjR4/WD50tGQKqlMRku+1yZCh8pS4kQn+ot+cpDIExcoe05hGKRvxycpjo6hC
         e00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMX4GBsLMVAfmgf4EkAoDLt3MFRb4NlfIiHTt3svfFc=;
        b=Ye64xEt+NYmVPCnVo5QmpK9WhSSMfV9kNauvNMkkZ7IHAhC+zuGunKBEfX+jU5NwjO
         U0oA1MNKJ2ntvwJVZ3dCrTKSPyJHRnsoFf/qg8WLgK21Y8PhV+xmldkXchA3196t8duk
         IPFcoI5WE3Wxx5Vy0gGtaRucZoFf5XW+Y6DWZMhh8TFg1f1/BlBmhzXL4lxthme2LgVM
         ij+wRUsqkVVaNK4BOXl318CPmJ/OmBfL1ge+Fl3JvEp/dzlsdebQo3IlAEFs4ac4Obhn
         MomA4wNe8mVFqe/P3bY7o/uVev5QvAusrXX+s2Bm6aH9oxXrTB8FMbCp9c1QYJzczXOC
         7XdQ==
X-Gm-Message-State: AGRZ1gLnZY964cXyJqEEX54DCCTTNe3vZ1r9WCKrCl6QW1R2bxGvjVQ6
        0+V+MH1WXNmzEyHoCpjSSQA=
X-Google-Smtp-Source: AJdET5dqi1LKgqGvtzQQ5g6A/T3yZVQRV3JB1pA5FFj7299D8fYedqZ/ZjSQ8sMOKZ6nym97C/z7Qw==
X-Received: by 2002:a1c:3403:: with SMTP id b3-v6mr13521187wma.108.1540818850005;
        Mon, 29 Oct 2018 06:14:10 -0700 (PDT)
Received: from localhost.localdomain (x4d0c66d6.dyn.telefonica.de. [77.12.102.214])
        by smtp.gmail.com with ESMTPSA id 7-v6sm1427046wrl.27.2018.10.29.06.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 06:14:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib: introduce the '-V' short option for '--verbose-log'
Date:   Mon, 29 Oct 2018 13:13:59 +0100
Message-Id: <20181029121359.7323-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.723.g6817e59acc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'--verbose-log' is one of the most useful and thus most frequently
used test options, but due to its length it's a pain to type on the
command line.

Let's introduce the corresponding short option '-V' to save some
keystrokes.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Or it could be '-L', to emphasize the "log" part of the long option, I
don't really care.

 t/README      | 1 +
 t/test-lib.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index 8847489640..2e9bef2852 100644
--- a/t/README
+++ b/t/README
@@ -154,6 +154,7 @@ appropriately before running "make".
 	As the names depend on the tests' file names, it is safe to
 	run the tests with this option in parallel.
 
+-V::
 --verbose-log::
 	Write verbose output to the same logfile as `--tee`, but do
 	_not_ write it to stdout. Unlike `--tee --verbose`, this option
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 897e6fcc94..47a99aa0ed 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -67,7 +67,7 @@ case "$GIT_TEST_TEE_STARTED, $* " in
 done,*)
 	# do not redirect again
 	;;
-*' --tee '*|*' --va'*|*' --verbose-log '*)
+*' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)
 	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
 	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
 
@@ -316,7 +316,7 @@ do
 			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
 		fi
 		shift ;;
-	--verbose-log)
+	-V|--verbose-log)
 		verbose_log=t
 		shift ;;
 	*)
-- 
2.19.1.723.g6817e59acc

