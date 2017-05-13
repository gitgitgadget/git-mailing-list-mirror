Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029E720188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758899AbdEMXRb (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36819 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758687AbdEMXR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:29 -0400
Received: by mail-qt0-f193.google.com with SMTP id j13so11206908qta.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0rzhGBI6uVw9+otZYd2oQm61kvh3b3AC6bSAGi6yzg=;
        b=oDclZjipXootfAzVJl/ZnVi33Hu642oO3zYCu/Mqcj9KNrWrJbwkDC8VgUpATUln75
         hAYbTvpdbcB7wCcfH9PP2KPCnieAYgLVKVdo7JBHyAV+ocBHydJQ5qJ8jebpVUvvAR3l
         0wCoTmRWIRKhKFqVMgLQprEstnxmRCH+1mQKNSDg0nX6tNjLRxc6DqJWQgNAud7ezErr
         BwmW3yMsIidc7pboQP2PAtx14jW0x8CUU2UxA4RRJcAWzVldwljCzeXNeIUjFn4IV6Q8
         J8kjmpK5tdz4R7HWOk0a/8272jdySq4QQsN+6KRBqAX1Zj6C99c7heewTJQTO72j09Mg
         sMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0rzhGBI6uVw9+otZYd2oQm61kvh3b3AC6bSAGi6yzg=;
        b=SHAMqHsF9tap01dCC+PcTo7q4oBRGZHBICJ1t7IWLMQK1NUbAUahwo7UcADv+PmjU/
         lYnnorXVH8C2G1DABMLMqEo6nax6P1AT06oX7zqJTgJn5BcCp1Xk+sV5+nehDojrC3Yr
         S54U+xSTmKbm10EflUjJ6X3qMdt+NzB925p2PCDrfhOjFaEwNXhyPOCjhzCtQ981sMfG
         3re4QUdULt0fgLXPhYSwmeEjq2r78BbRt4R6OZBegiqHr3paYkJCliSwlaYsxPMGPMWu
         FMeDlVuLqIFspQV28u51kUo4KE+jot0dloBMqOFMtFRU719mTHrZcuN5sdqsXvPE/hig
         63jw==
X-Gm-Message-State: AODbwcBejlQTRky9YndAONJTfw1ozoV5nuT88jS966oSGE0tOLk3NjJh
        oxKUHlofv2G94A==
X-Received: by 10.200.42.252 with SMTP id c57mr10625655qta.282.1494717448631;
        Sat, 13 May 2017 16:17:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:17:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 27/29] pack-objects: fix buggy warning about threads
Date:   Sat, 13 May 2017 23:15:07 +0000
Message-Id: <20170513231509.7834-28-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a buggy warning about threads under NO_PTHREADS=YesPlease. Due to
re-using the delta_search_threads variable for both the state of the
"pack.threads" config & the --threads option, setting "pack.threads"
but not supplying --threads would trigger the warning for both
"pack.threads" & --threads.

Solve this bug by resetting the delta_search_threads variable in
git_pack_config(), it might then be set by --threads again and be
subsequently warned about, as the test I'm changing here asserts.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 4 +++-
 t/t5300-pack-object.sh | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fe35d1b5a..f1baf05dfe 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2472,8 +2472,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			die("invalid number of threads specified (%d)",
 			    delta_search_threads);
 #ifdef NO_PTHREADS
-		if (delta_search_threads != 1)
+		if (delta_search_threads != 1) {
 			warning("no threads support, ignoring %s", k);
+			delta_search_threads = 0;
+		}
 #endif
 		return 0;
 	}
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 1629fa80b0..0ec25c4966 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -445,8 +445,7 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
 	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
 	cat err &&
 	grep ^warning: err >warnings &&
-	test_line_count = 2 warnings &&
-	grep -F "no threads support, ignoring --threads" err &&
+	test_line_count = 1 warnings &&
 	grep -F "no threads support, ignoring pack.threads" err &&
 	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
-- 
2.11.0

