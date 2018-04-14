Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AAA1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 19:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeDNTUR (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 15:20:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42218 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDNTUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 15:20:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id s18so15835029wrg.9
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8DMFpmPnGidc/N+8Fe2P0TP+k5DLu910bRgQy5flvmQ=;
        b=pOZoC0efTDvT33IuzkTIfK5josQcMIhwA5Taco4h8RcbdIskNd5Ojfn0HzpCXojPIZ
         FpWsJtp7yFIU4MzfZZKPTAYOpzQ0jnN1jQEM3DWKqirI3uMTcdgrIS/g1RVYGC9w29GD
         DSJm2UKGpiRSV9IlzYDer88M9i9VcGIsxkQT4YiH7Rg2gAqr1+31lSnY7nNJW2vHid6A
         nTh3nd0Dg1ywCclptRdGFWvqOpF+Rhn/ZHVxgKsvek1nqGDVGJYN19Ec/k5pa04oosd/
         sf3HsIpS3+Nx1dWrk/nQ5lmgZRfq03MgIYwTb/kWIfvsN9wM6iOx8SHESHPougVfRBOR
         Gs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8DMFpmPnGidc/N+8Fe2P0TP+k5DLu910bRgQy5flvmQ=;
        b=TNK6OxHwe5bqcGw7dPfJ18U+owBtuX/EOWkP0GjVzWMYO9Ru8kGBkuWgahYzDdk94K
         72FySfw6jcjjnye/s5grBH+C7HUdi8M5qgviB9ZafFo4Ax/vUsF0HTq1MsvN9sGRqa0h
         wCIJwCC8nh/Ed15qQD8/KRZSS0j1Wb8+0GkcOvnOOzxW6LTkK/+gjArO2CMZ92Ev9KFW
         sLUQEuFcpYyOwzSrjQHECWYEtLtIVncxDotl0qBS1/3szl+SjLISRNFDN1Rccfh6t7AT
         dXjjdmZTt3Ruwi/FiTcCVXc2B+OOo4NuVzoGzBBDBlDf4MukDQlK8GVXo7xDW4f1HpAH
         Im4A==
X-Gm-Message-State: ALQs6tAVyfDM0sHcYjAcHLkE1NX+JQX+1vb/EE4Uyi5ekvYckzv28B67
        s8UjIrCJDgkVF8aI6zvmgpZo3DSK
X-Google-Smtp-Source: AIpwx49T5R1yeUrhKNqz03TgAGFu6Dj+FmfEp/nzWEx7XczvVyP2RTH4TAl9X0kirrIZgjxD1jyKPw==
X-Received: by 10.28.35.205 with SMTP id j196mr6255964wmj.108.1523733614895;
        Sat, 14 Apr 2018 12:20:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 31sm8610644wrm.68.2018.04.14.12.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 12:20:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/4] Makefile: add a DEVOPTS to suppress -Werror under DEVELOPER
Date:   Sat, 14 Apr 2018 19:19:45 +0000
Message-Id: <20180414191946.30674-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180414191946.30674-1-avarab@gmail.com>
References: <20180414191946.30674-1-avarab@gmail.com>
In-Reply-To: <20180329150322.10722-1-pclouds@gmail.com>
References: <20180329150322.10722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a DEVOPTS variable that'll be used to tweak the behavior of
DEVELOPER.

I've long wanted to use DEVELOPER=1 in my production builds, but on
some old systems I still get warnings, and thus the build would
fail. However if the build/tests fail for some other reason, it would
still be useful to scroll up and see what the relevant code is warning
about.

This change allows for that. Now setting DEVELOPER will set -Werror as
before, but if DEVOPTS=no-error is provided is set you'll get the same
warnings, but without -Werror.

Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile       | 10 ++++++++++
 config.mak.dev |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index 3038c78325..9a57495fae 100644
--- a/Makefile
+++ b/Makefile
@@ -445,6 +445,16 @@ all::
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev)
+#
+# When DEVELOPER is set, DEVOPTS can be used to control compiler
+# options.  This variable contains keywords separated by
+# whitespace. The following keywords are are recognized:
+#
+#    no-error:
+#
+#        suppresses the -Werror that implicitly comes with
+#        DEVELOPER=1. Useful for getting the full set of errors
+#        without immediately dying, or for logging them.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
diff --git a/config.mak.dev b/config.mak.dev
index 716a14ecc7..7a54426d78 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,4 +1,6 @@
+ifeq ($(filter no-error,$(DEVOPTS)),)
 CFLAGS += -Werror
+endif
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
-- 
2.17.0.290.gded63e768a

