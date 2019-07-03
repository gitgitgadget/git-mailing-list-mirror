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
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E281F461
	for <e@80x24.org>; Wed,  3 Jul 2019 10:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGCKsH (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 06:48:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42773 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCKsG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 06:48:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id a10so1134568wrp.9
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vz8DOxyaIp9s28CBDIPK+Uig2iaTnPvOp4hEyL7GhRY=;
        b=f0N8MBFiyHhlOhuO8G836DdgSUAAF/VbltPy+S+Fmejn3zkYqu/v2kT7+LvKR6VeEI
         b99crC6c9Cn5JncbSpJAbuB7zPoSMl+79UpwZ3OUaPKmoeoY6pOZs6I56V6yqwWc+PFe
         Z6ewCpNTh7IIXEaYoaDIGVJ/0ByKBP1wGPSugqnRrhbW2Eny9aEUtkDbgxcI0drTdqBq
         oOHVygPAoaSw8IjTpRePlOujYCHFO1ugg+hKUqAGv0SYc3jCYaiUey1yDNLT2nfNlKA1
         bfovz+RvGJjifALGqfJ+aj8tF4V+obDLIjc9tE/2hZvvTdYRTOSBjeCfIXe/1ahD8VIk
         PgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vz8DOxyaIp9s28CBDIPK+Uig2iaTnPvOp4hEyL7GhRY=;
        b=oUZC5DjrRhUWX6Xq4CpZtFW17YUo8iE3XNHnL7lA0VHaGX9Q4UQGW1v6tDwfLUPH+A
         YTVwz7bF3a9yA9Sw+YvfTl+cBPfcaommht33HgJziTykQSm4jYGYOTZ5MoQ3P63dZCrU
         Se/IbDdI7Du7olIB2LNFJTHHrd27eQbNAbwnWyelUijmKfgddootb/EdGhivtaWj8ixk
         H3VdcQMLWr145fOckSBMLitRL29kx+7eJpbkkspo6dBTOGItFNc/VWAwfVJJv/ZnxhiE
         eanx5G3+L5Son5I4fGK6a+S4IwWEbqld9xYuBNEW0fE/VF3VW/nKREU0RLu07Zoe19xJ
         CSkg==
X-Gm-Message-State: APjAAAW9+An9N/VYcOfg5moGfsVqzQUACl36AUOMIjfHJxMDJVOQsrHr
        6F3YUSTlHZuar9ObSfnQZmE=
X-Google-Smtp-Source: APXvYqy3A2IEQT8Gkrlxk8/9gwLov23Aa4z3DiCtsP7QpfTQ3ZR5ytSnVRqNwpA9cFwkmGyyGQXeJQ==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr21277785wrm.87.1562150884800;
        Wed, 03 Jul 2019 03:48:04 -0700 (PDT)
Received: from localhost.localdomain (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id h84sm2168562wmf.43.2019.07.03.03.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jul 2019 03:48:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] ci: disable Homebrew's auto cleanup
Date:   Wed,  3 Jul 2019 12:47:48 +0200
Message-Id: <20190703104748.32533-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.621.ge52941b842.dirty
In-Reply-To: <20190703104748.32533-1-szeder.dev@gmail.com>
References: <20190629170108.GF21574@szeder.dev>
 <20190703104748.32533-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lately Homebrew learned to automagically clean up information about
outdated packages during other 'brew' commands, which might be useful
for the avarage user, but is a waste of time in CI build jobs, because
the next build jobs will start from the exact same image containing
the same outdated packages anyway.

Export HOMEBREW_NO_AUTO_UPDATE=1 to disable this auto cleanup feature,
shaving off about 20-30s from the time needed to install dependencies
in our macOS build jobs on Travis CI.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 7f546c8552..8cc72503cb 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,7 +34,7 @@ linux-clang|linux-gcc)
 	popd
 	;;
 osx-clang|osx-gcc)
-	export HOMEBREW_NO_AUTO_UPDATE=1
+	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
 	test -z "$BREW_INSTALL_PACKAGES" ||
-- 
2.22.0.621.ge52941b842.dirty

