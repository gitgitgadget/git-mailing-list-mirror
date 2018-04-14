Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA56D1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeDNPfb (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32957 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeDNPf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:28 -0400
Received: by mail-lf0-f66.google.com with SMTP id m14-v6so4396404lfc.0
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4gkKhA065O8uxYiVOZZE38juna439sSyzVHonaVlbE=;
        b=lHOfKSe8e56SXbrIkX2JVcLrHilJBYYkv4oSE2gPneIP7wns6Y8dDIO8zaA+Mi64q5
         T12Nv5CvhXMy3gC5NVVmzxzpbyrmCUytcjLPif4D+5Fw44u6lMfzi/DB+IxwgMhDD8Ws
         9joi3RtsesDfUPG/7+cbLavAOK6iBOinC0f9zfLLHn1lQQQ1zQUICvr16OSSJGaVRd1T
         qF279OVfxTBDBHPXVjLs1UQUrinQaFG+bCdbacC6aJ6GD+FqDCSp7wMbm5RUxxwD8l5A
         BMQ2MndRNIdhAi24C6AoBif9wpY89nvCfS0Kwz5ncpq8J+mJxjdOByp+8jtLrU9xRDbL
         R6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4gkKhA065O8uxYiVOZZE38juna439sSyzVHonaVlbE=;
        b=d73gBKDejlvFo3d4sthc5g+2v4R3+Z4AM30XvYNciTG8Q7c4u+vB8jsjNN3GtSvrIt
         wCGibg+aLaEJp7xmluUrHIgCTc+1YcrS1k3jrtgOB2l4QPfTepfMAjJNPFxaf5gD/ddz
         zox6zhd+rPFbu5YLsKsZoYEIVP7K27ubNBsOzdvfdO9CcMNxTUnjQOFMe33v74XJNXlo
         0TgarsSzJgWY7AOAhYutqpwnb+1uyDFeR9xiRilSsdpmUZ6svZ4qTENLKDZgU3J8DuQI
         fxdK/EmqhrSYwDQ0aNUqioR4IimdLifRBWmcNlQlsTMBoTqG91QoM3vzvSvwNVezueQx
         scgA==
X-Gm-Message-State: ALQs6tBKs2D5JfmEBX+X2i+JS6UWebf80gcdro+dwdkYj5Vq3wTakxDa
        rKKHrfvMZCLRwwVBEMAiEWPceg==
X-Google-Smtp-Source: AIpwx49Dye+p63AIF3yPicrLlbbKr20GKolqZPEBrLPSD/oPKMhPyc0UU0zfJPpiIUwmnQb3mfT+yw==
X-Received: by 2002:a19:e501:: with SMTP id c1-v6mr11196869lfh.65.1523720126331;
        Sat, 14 Apr 2018 08:35:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/15] read-cache.c: make $GIT_TEST_SPLIT_INDEX boolean
Date:   Sat, 14 Apr 2018 17:34:59 +0200
Message-Id: <20180414153513.9902-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414153513.9902-1-pclouds@gmail.com>
References: <20180414153513.9902-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at there, document about this special mode when running the test
suite.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 ci/run-build-and-tests.sh |  2 +-
 read-cache.c              |  4 ++--
 t/README                  | 11 +++++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3735ce413f..8190a753de 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -11,7 +11,7 @@ make --jobs=2
 make --quiet test
 if test "$jobname" = "linux-gcc"
 then
-	GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
+	GIT_TEST_SPLIT_INDEX=yes make --quiet test
 fi
 
 check_unignored_build_artifacts
diff --git a/read-cache.c b/read-cache.c
index 10f1c6bb8a..fa3df2e72e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2268,7 +2268,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	if (!istate->version) {
 		istate->version = get_index_format_default();
-		if (getenv("GIT_TEST_SPLIT_INDEX"))
+		if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
 			init_split_index(istate);
 	}
 
@@ -2559,7 +2559,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		goto out;
 	}
 
-	if (getenv("GIT_TEST_SPLIT_INDEX")) {
+	if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0)) {
 		int v = si->base_sha1[0];
 		if ((v & 15) < 6)
 			istate->cache_changed |= SPLIT_INDEX_ORDERED;
diff --git a/t/README b/t/README
index 24ddebfabf..d5e0a3c786 100644
--- a/t/README
+++ b/t/README
@@ -293,6 +293,17 @@ and know what setup is needed for it.  Or when you want to run
 everything up to a certain test.
 
 
+Running tests with special setups
+---------------------------------
+
+The whole test suite could be run to test some special features
+that cannot be easily covered by a few specific test cases. These
+could be enabled by running the test suite with correct GIT_TEST_
+environment set.
+
+GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
+test suite. Accept any boolean values that are accepted by git-config.
+
 Naming Tests
 ------------
 
-- 
2.17.0.367.g5dd2e386c3

