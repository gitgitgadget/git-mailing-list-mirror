Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75A71F461
	for <e@80x24.org>; Sat,  6 Jul 2019 16:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGFQQy (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jul 2019 12:16:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54245 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGFQQy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jul 2019 12:16:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so11869032wmj.3
        for <git@vger.kernel.org>; Sat, 06 Jul 2019 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sL528vjd5UMzLaf2Ut3S61eIu6kdbe8uf4CMxBZfXKc=;
        b=jnGwyhwCRwyjOldJbfbNKlbMqATwGaSv+tUcV0I+DC12y7gPKdy7XPsqYFTy2ja1Gv
         x9t37iiPVxGqLXBHzTRQhs/nRYNkhnRfumn6UMxCHKRimJ3BQFOYP7PCGRjDa0Wh2uXo
         4J5NF90X0KgLoaOwk27pCa9x0wS6kGXKq1uGTsDXkiHbX0Qeu9LKOwqjnIAhhHFAjYMu
         YrA0GuUPyxdzkfokq43Q7yc2LewBTKVx4wS0OZDMRsLXHwdRzlSCXaueJtNKGh3zh8Lb
         zvPpnCafxWVxn2TB1lp16+mypfAzbyC930IsXa7P5iZQdRGu0gV1IgfU+z/pmWT6RHXx
         MHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sL528vjd5UMzLaf2Ut3S61eIu6kdbe8uf4CMxBZfXKc=;
        b=dJvToCyPpnK4UVN/Jcmwxc69neoRpR5V6zpWsCamrysBC1XJwdrdZW2otifIItmhOy
         108rLXQTZDYqkq5tcNujQFvHPE/Ia2FrDiodSbnpidoiUAjAU+9zYdtan6mCwReXqMRO
         NrbR0ZoIrLPWe3Umrx5R2zVnmlyFKH2VgEbO2v5tohk4LaL5ZtNs9SNAC9zAPPfECqBr
         KAJ+n+7PPKd7wHGIiEytN/M74KfpfEGy2G2d+Kv0POEEzonOb0eLbB1duNxNDqLsveli
         SZGxRUA6x0c7GfQteEchqvQpFinMvbZuFkFuVRGHx0O5fyByeXV2aVuGxvFaaFCECevr
         lN6w==
X-Gm-Message-State: APjAAAWN1GeGtGva8wo1qVbZ0seMFWCy8PmuCwuEmipiHiPATcqOakxa
        sAYYWKmAmsDmBP2jR4P6F6U=
X-Google-Smtp-Source: APXvYqw6BqMAd8mgjJToivdWAPgr/Gi6MbtEYKal+6vTXK+46ojoXla9uJ15N9LUx5Dz/t1vM8ZctA==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr8859221wmk.14.1562429812125;
        Sat, 06 Jul 2019 09:16:52 -0700 (PDT)
Received: from localhost.localdomain (x4dbd7982.dyn.telefonica.de. [77.189.121.130])
        by smtp.gmail.com with ESMTPSA id o7sm7611700wmc.36.2019.07.06.09.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 09:16:51 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] ci/lib.sh: update a comment about installed P4 and Git-LFS versions
Date:   Sat,  6 Jul 2019 18:16:48 +0200
Message-Id: <20190706161648.20836-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.667.g5c3548c1fe
In-Reply-To: <20190703104748.32533-1-szeder.dev@gmail.com>
References: <20190703104748.32533-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A comment 'ci/lib.sh' claims that the "OS X build installs the latest
available versions" of P4 and Git-LFS, but since 02373e56bd (ci: don't
update Homebrew, 2019-07-03) that's no longer the case, as it will
install the versions which were recorded in the image's Homebrew
database when the image was created.

Update this comment accordingly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 288a5b3884..0c7171a173 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -163,8 +163,10 @@ linux-clang|linux-gcc)
 	export GIT_TEST_HTTPD=YesPlease
 
 	# The Linux build installs the defined dependency versions below.
-	# The OS X build installs the latest available versions. Keep that
-	# in mind when you encounter a broken OS X build!
+	# The OS X build installs much more recent versions, whichever
+	# were recorded in the Homebrew database upon creating the OS X
+	# image.
+	# Keep that in mind when you encounter a broken OS X build!
 	export LINUX_P4_VERSION="16.2"
 	export LINUX_GIT_LFS_VERSION="1.5.2"
 
-- 
2.22.0.667.g5c3548c1fe

