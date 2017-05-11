Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7A31FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755334AbdEKJUO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:20:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34160 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755325AbdEKJUM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:20:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so5509746wmf.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0rzhGBI6uVw9+otZYd2oQm61kvh3b3AC6bSAGi6yzg=;
        b=cS4gUTaukWMGuOFDc4iCDcjMEBtP6CzsynVINAU6IuZiQJgxHCKUU4f64TBjhOn60K
         gsC9Itd78/DQr5lTRLJ6jmuXj9ccNIn6YvwsTPbl5kEbMfKGnRMcx3++FKS4KA3GcShW
         q+q3OujErXjeuM0Bqags3/73b4GPkYXdvLkCmua4Bu8uP8OTAW9CNAcv0mYKGB/lUwM6
         PEbEg4/BQG6LyGJ22tx9qplyo3H1ZXi4MP0LpiSjbpdVDF6YfG2xIocMzI5ZHq0Rhlvc
         /y76wkeu1oQ0oPc1IPns5CKMW5wtotGLdfQuIt5JChX7tuyaEVN2l9fXOwMrX1083nMq
         zDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0rzhGBI6uVw9+otZYd2oQm61kvh3b3AC6bSAGi6yzg=;
        b=E8KHhmrMlT0k1PMT2XqfFCBF8Y4Hzss8Y3GkZkhqsOrYULAFrCXm3BrVCRIlHOQPV/
         VxrxxYsG8JGQ1Pn3b+2S5lAiWBWzwfVsLamg1HtHHoNkXD8gunpKxWJQhSosMc0K+iVa
         Y0Tn7Mcg1P4FHuz7kZd/utTylAzFUDQ+l98zggHKN+83YCYUOfE82PNG9igIy7idUBlC
         LNuaQrHxTZ+yZsAs9aLIpewzEhDPRrynwDbOULj0AE+onq79iXTG9vOtDNGHWRL/wjLw
         rrowyoLV1babpMAZGGCxsYJyFAphOcKoUeg9aceGYWTck5bwb3IiQfQYFYhuoCzZRUqD
         MrVQ==
X-Gm-Message-State: AODbwcCJ5nRsV2lst4ZjpqyaaKQzRU3rS6GwmdLAdDkVE/DqCeBWRvax
        I8v6jX7/iJQYkA==
X-Received: by 10.80.182.89 with SMTP id c25mr12028ede.55.1494494411407;
        Thu, 11 May 2017 02:20:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:20:10 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 27/29] pack-objects: fix buggy warning about threads
Date:   Thu, 11 May 2017 09:18:27 +0000
Message-Id: <20170511091829.5634-28-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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

