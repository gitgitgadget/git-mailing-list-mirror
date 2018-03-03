Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B0E1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 01:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965062AbeCCBqQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 20:46:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42583 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964973AbeCCBqP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 20:46:15 -0500
Received: by mail-pg0-f66.google.com with SMTP id y8so4478230pgr.9
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 17:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6EnFYNuRFeMkb6C2eMc7Fm1NPUShTT+q+vyPkqKfTzs=;
        b=XKTkCWooeaso3wWbkfXdNot3OZWuzfe5S2E6nOp8wctOPrgeUf2rVl+Po7oH+NZWZw
         cNEQHrN4ZYyNQPNCtH2432rgTUtQ8EChEBTpgqMXzLEL921O1XK3qwp5tY3nr5WPm4NY
         miIdneDi0SZLdoa/GyquzKNk/dBJZlHzugq/segj5sn3I31IpfAgn5fHk+bN28lGOTzX
         TIpAdpElYvTKCXCH2bARmEc05hzKwmt3c34rlahSbzACmsqOYv053whHU4REOcx2fSbb
         G94/a5VIMsUFbj54vW9IvEPzAH3guK4IMn3okzmQr7c82nYXTrtxovlUmOz539n4Zqcx
         g98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6EnFYNuRFeMkb6C2eMc7Fm1NPUShTT+q+vyPkqKfTzs=;
        b=BP8eyCP4L/LmQ6C8TpmcSR1m8dTz559G2CGVl9FQAtsDmFvjCVkYGwMOej+yFmb+Ey
         P31+8LyviJvZ3jNRte1aJ7fVXIXlIgIME4Xl2f1YgdhlLK/EaC1ksNQYZJEX9CCKlcHp
         8IkuMFwCAklCqcacABygxm8LFPENPIUS3/+ogxfgQu5DTwoyldkiTMeftnR8HXOgj6dP
         Mxt4+R/inMkCa2BlbgWCCuHHx/zXj6jwvo9m+umiE3Z4KrKMSyqSRHEh7RaFkGs1cQl6
         o6eS7Lx3sB3mSYkLLIMyWUIuS8+4cUiHrSkYcxpxQKfuWsC/iGrSWlqoUhwUL/6WOpIg
         6taw==
X-Gm-Message-State: APf1xPATf/yP1AAd9fNXY0uifO8y0Z1nbY36TA+41yIfWJOct2VWAsEd
        Sgra1JSy1qz4dTN7Xc8ZFN94Vw==
X-Google-Smtp-Source: AG47ELvgryV4lsCxsDeADsyCFTRjNjh77Me9kT3bXTUEOg+FH4UpVCZOFfgWIlZLC3XzYGm3yjwHxg==
X-Received: by 10.101.64.10 with SMTP id f10mr5859595pgp.171.1520041574199;
        Fri, 02 Mar 2018 17:46:14 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id y1sm1261155pge.78.2018.03.02.17.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 17:46:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 08:46:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] travis-ci: enable more warnings on travis linux-gcc job
Date:   Sat,  3 Mar 2018 08:46:05 +0700
Message-Id: <20180303014605.10603-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have DEVELOPER config to enable more warnings, but since we can't set
a fixed gcc version to all devs, that has to be a bit more conservative.
On travis, we know almost exact version to be used (bumped to 6.x for
more warnings), we could be more aggressive.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .travis.yml     |  3 +++
 ci/run-build.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 4684b3f4f3..273b1d508a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -16,10 +16,13 @@ compiler:
 
 addons:
   apt:
+    sources:
+    - ubuntu-toolchain-r-test
     packages:
     - language-pack-is
     - git-svn
     - apache2
+    - gcc-6
 
 matrix:
   include:
diff --git a/ci/run-build.sh b/ci/run-build.sh
index 4f940d1032..04e163359c 100755
--- a/ci/run-build.sh
+++ b/ci/run-build.sh
@@ -5,4 +5,19 @@
 
 . ${0%/*}/lib-travisci.sh
 
+if [ "$jobname" = linux-gcc ]; then
+	gcc-6 --version
+	cat >config.mak <<-EOF
+	CC=gcc-6
+	CFLAGS = -g -O2 -Wall
+	CFLAGS += -Wextra
+	CFLAGS += -Wmissing-prototypes
+	CFLAGS += -Wno-empty-body
+	CFLAGS += -Wno-maybe-uninitialized
+	CFLAGS += -Wno-missing-field-initializers
+	CFLAGS += -Wno-sign-compare
+	CFLAGS += -Wno-unused-function
+	CFLAGS += -Wno-unused-parameter
+	EOF
+fi
 make --jobs=2
-- 
2.16.1.435.g8f24da2e1a

