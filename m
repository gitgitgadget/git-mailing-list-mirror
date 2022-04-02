Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14956C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345070AbiDBQNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357802AbiDBQMy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 12:12:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BA164BD5
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 09:11:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so8197632wrc.13
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=1R2UzCg28D/ALA1Cki6FHlH7wtdUVpK2izrcgPgAf9I=;
        b=ktPGmjbfMrzcYNuZoo9GOg9830pQ4Uh/yT4H17xZL0WRrLwM+E8kXSinNMPyhDOw6q
         qbU82k8Kx4rAhagGlHx5yEm/nekXVEPoX3l0WNylpuDpXJ1LRjxGReEL0FqJPb4nXoZv
         QUCorxKxri1rhfC8y/GRn9vhWdA7qxWjPsJnEN9jND2hrvIY0NGgNRN3nmNvsGhL5FOI
         EwogsmIea3YNUb1ul1GWmYXPEnFQb+SMmgV8XQ4LaKYXcNKLFaWwx4vwtOuJ5gTfN6NJ
         i0YOZoZP53XYQL9LkXnvLtqT2LL64M2ujOAlvuQmXAkqnBq/ZpGWHthJsIVdI2+icFmy
         A/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=1R2UzCg28D/ALA1Cki6FHlH7wtdUVpK2izrcgPgAf9I=;
        b=6QJreM9JeEUeKLbvC4IC0xwb9df80xufJbQVrkv3RXzt2Y6iWkkMVclgHEAlK7znik
         8PLcwQzMvpum8Y4We3dp/Df2B/vjht6gkMAPEbptYaFVEzC0njdtWlbLvE4azm/Bn2F6
         BeEgRQxkuZw63uXwIuuym61gHqIVsG+J+PQyIDC59tQbD20zYfKFRhxBgWUq+gzHWxGV
         RfEjQCs4wHIFnIKZnQr8tU/Fgcy+u85RIrpwC9+2EQWi3T7tRBwyp9dK3IJ3kckbFLlJ
         aeIwOtYbBqdgtV0CAYZIQdxRFStb4MA4gg96pA6kPle8s4pgG+ae6CpglnQoGm+4ocu7
         KoDg==
X-Gm-Message-State: AOAM532J+7D1XHGZLgOEHU3x9oKRdHsfZsBRaXqScTk10EUJYHe3WK0c
        kFGa6lnsaMw+dyXo+bZl6RouJOsXBIc=
X-Google-Smtp-Source: ABdhPJyvXinbJSXZA3mTzFOjLJppbYlKoptUdfe+muyuoPRSWMVuLZtWJZw83lI5lUPZuSV4uWHbIA==
X-Received: by 2002:adf:d1e5:0:b0:205:85f5:656c with SMTP id g5-20020adfd1e5000000b0020585f5656cmr11316603wrd.65.1648915860034;
        Sat, 02 Apr 2022 09:11:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b0038ca32d0f26sm5202430wmq.17.2022.04.02.09.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:10:59 -0700 (PDT)
Message-Id: <1888778902aa1d0d2cf118cfb7fe4b2e407953c6.1648915853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
        <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 02 Apr 2022 16:10:52 +0000
Subject: [PATCH v2 5/6] i18n: factorize read-cache error messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 read-cache.c     | 8 ++++----
 t/t1600-index.sh | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1ad56d02e1d..639765e8ff1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1735,8 +1735,8 @@ static unsigned int get_index_format_default(struct repository *r)
 		if (r->settings.index_version >= 0)
 			version = r->settings.index_version;
 		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
-			warning(_("index.version set, but the value is invalid.\n"
-				  "Using version %i"), INDEX_FORMAT_DEFAULT);
+			warning(_("'%s' set, but the value is invalid.\n"
+				  "Using version %i"), "index.version", INDEX_FORMAT_DEFAULT);
 			return INDEX_FORMAT_DEFAULT;
 		}
 		return version;
@@ -1745,8 +1745,8 @@ static unsigned int get_index_format_default(struct repository *r)
 	version = strtoul(envversion, &endp, 10);
 	if (*endp ||
 	    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
-		warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
-			  "Using version %i"), INDEX_FORMAT_DEFAULT);
+		warning(_("'%s' set, but the value is invalid.\n"
+			  "Using version %i"), "GIT_INDEX_VERSION", INDEX_FORMAT_DEFAULT);
 		version = INDEX_FORMAT_DEFAULT;
 	}
 	return version;
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 010989f90e6..60339db529f 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -19,7 +19,7 @@ test_expect_success 'bogus GIT_INDEX_VERSION issues warning' '
 		git add a 2>err &&
 		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
-			warning: GIT_INDEX_VERSION set, but the value is invalid.
+			warning: '\''GIT_INDEX_VERSION'\'' set, but the value is invalid.
 			Using version Z
 		EOF
 		test_cmp expect.err actual.err
@@ -34,7 +34,7 @@ test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
 		git add a 2>err &&
 		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
-			warning: GIT_INDEX_VERSION set, but the value is invalid.
+			warning: '\''GIT_INDEX_VERSION'\'' set, but the value is invalid.
 			Using version Z
 		EOF
 		test_cmp expect.err actual.err
@@ -58,7 +58,7 @@ test_expect_success 'out of bounds index.version issues warning' '
 		git add a 2>err &&
 		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
-			warning: index.version set, but the value is invalid.
+			warning: '\''index.version'\'' set, but the value is invalid.
 			Using version Z
 		EOF
 		test_cmp expect.err actual.err
-- 
gitgitgadget

