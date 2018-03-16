Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535F01F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeCPTeQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:34:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44563 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeCPTeM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:34:12 -0400
Received: by mail-lf0-f68.google.com with SMTP id g203-v6so2502715lfg.11
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeBCdoJ6ccFgD+pFhvYjYLDdRCHx/audLFFx3Z3Lc0g=;
        b=lAoT3VDEvmNxNDMOZmYJ4s/u2kFamyyWx1om7IKJq0U2y9n2UTOBF9jNYd0tDl4DAp
         aFd26DzclHZctEXy0VzinAEMacM+vlaXMotdcQpxqIHR+jOgPV90Vb2S/YHWwxxQb5SQ
         4KjChE58DJP2dfVjERJzluhuwim9QlHmuEFxU9BYOzFRX6gX6TBQlBZR8+vWaur/FP6o
         R3Rw7CSf825VsDrgLzZedvEn6RLAkPOZzvPk+k3anW66K/REK40f6vMJJgrYUGWw2UhW
         1O89vZHVMf+XToV8dmmvozEz4I0ONlub2zUxKbVnSp8pTdUA62Pr4lk1N6AOwv65LupG
         ItYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeBCdoJ6ccFgD+pFhvYjYLDdRCHx/audLFFx3Z3Lc0g=;
        b=JTTRLkKZr0yAtet8vt1v/vuUl6GCB1xuuLxlZjs9nHr26e/Z0WrHNmgJukUNw6Q3ZH
         ynfn7bshT2HqwVXbuL63JtMW0ofGtdFbRhGobS1sSWNaGDiEqHgqjUFjCePK3UySpBbg
         7bwZEnfvOsHWTE/G8FzrXAgUphAN+/5j3LNN0zXKXM2//w/aWm4IxQWubC0FclfLL/nz
         24Zk2cXP9qdLNv6/EWOpN1oPG7dwWsHoVhwNoMtPSssz31r/6kB7j+LLuoTcG2wjh8cd
         ZyaSuu5qSr4Od+f0Xs/SOckT08XA0GbzJPrEN7ukQKS7cEI+NWuR3k1Vwqf3SM3NMHf1
         3HzA==
X-Gm-Message-State: AElRT7GU1DPLXX6PGikqAErSMkNkKGisGrKXC7im82prBhsXh0eV/C9h
        fOo7rJ3auYGCI0bVDVMRFTyBtg==
X-Google-Smtp-Source: AG47ELsWHEQ2J+anBhE4tgZI3GToOOnlNH8qOc039umTloDl3RDL2T3saqdd1Ew5i4WIDiGE/uTmsw==
X-Received: by 2002:a19:4402:: with SMTP id r2-v6mr1856566lfa.105.1521228851277;
        Fri, 16 Mar 2018 12:34:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 9sm1763747lju.64.2018.03.16.12.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 12:34:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc job
Date:   Fri, 16 Mar 2018 20:33:55 +0100
Message-Id: <20180316193355.20161-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180303014605.10603-1-pclouds@gmail.com>
References: <20180303014605.10603-1-pclouds@gmail.com>
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
 I still think it's a good thing to do. So here's the rebased version
 (v1 collides badly with another series, which has landed)

 .travis.yml               |  3 +++
 ci/run-build-and-tests.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 5f5ee4f3bd..0b3c50f5e7 100644
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
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3735ce413f..f6f346c468 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -7,6 +7,22 @@
 
 ln -s "$cache_dir/.prove" t/.prove
 
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
+
 make --jobs=2
 make --quiet test
 if test "$jobname" = "linux-gcc"
-- 
2.16.2.903.gd04caf5039

