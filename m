Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D8C433EF
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 21:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbiCTV4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbiCTV40 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 17:56:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD8712AAF
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:55:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso7490016wmr.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=d9pu7hbmPd8Hp89pPbBh3nbD40C/8UQUvYI2mXHteDg=;
        b=Oi6pqbAwvQFD2IVF+FUaGUTJx2xwCpbpqkkE21sffRwcWXMdoCzVbQefV36OBW1HmD
         TL1FnmqAQmFRj5/pfG9E1NLh49g4iQhJUSMb6tecHNqPUXg+ayVAOcNxyQ39Wl4FqU/m
         BCgcJcftQpPGVE05wTwOyCBoiV4sQ+PDLoI8jOHTU2sJ2xblHHOkQ62a792zcD9tJodm
         UbsnbYyJZdcU2HtMAMB9NW3ZRk3Zc3TFSNXGp2UiAhaymqdu5/pbFBcqMQVstV79eLQK
         QZlpefhn3tE0N/QUlSg8JB3Q6s12xX82TAczdNBT5qxLE4glMjgItY4Mv1cxWNIqiyMN
         XuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=d9pu7hbmPd8Hp89pPbBh3nbD40C/8UQUvYI2mXHteDg=;
        b=7yKxUvTHbTXnYYdawjKgCI8xE5aIyj/AJsFJpNjsvLsuLmnVyWD2EiqC36XIfLB6+l
         gkka33WFvseMklhoKn5awMXk7y0b4ReXSIrNftJKhIAEKHhj+OphFFY7pyXPWAywLvws
         3TB8Ce7HiKpK4I+nN6DgfrhlVRAzD0vFCwe+tn1U7ZprDl4AKFevCx6HmW9g51dd/+Y7
         Q0WZaQpqVXFA13YqEY64/Lf1GrZEKE4s5IFx93SebacYR4HyGkbEFHRBXfgcARpy+Uv8
         3xewgzFb7SMAZYLjqPaO9Wr3f7ChbT3rrZbb8Lk7zlpjonyLs1jaWJFXnOJKxBmBxwR9
         WqGQ==
X-Gm-Message-State: AOAM531sNySAdcP4PbhRTrklNjFiqw9KzC6lx9aWK/fUNth/AxYoMI95
        2tTZktOXqifvcMUkKlZ7BN++ktsonWY=
X-Google-Smtp-Source: ABdhPJyhtkW04Ls2zc2fMvqUCP2utyeeq1yJKCLqc3xwWwU+UOW49gAikmYvWn4K8X5qdYIGL7rCxA==
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id q10-20020a1ce90a000000b00381504eb57dmr24617193wmc.177.1647813298851;
        Sun, 20 Mar 2022 14:54:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b00389a6241669sm17062469wms.33.2022.03.20.14.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:54:58 -0700 (PDT)
Message-Id: <b8f97e6fde819caa5aeefdf4d2f28d69c7222e4b.1647813292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 21:54:50 +0000
Subject: [PATCH 6/7] i18n: factorize read-cache error messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 read-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1ad56d02e1d..39a633ea4b8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1735,8 +1735,8 @@ static unsigned int get_index_format_default(struct repository *r)
 		if (r->settings.index_version >= 0)
 			version = r->settings.index_version;
 		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
-			warning(_("index.version set, but the value is invalid.\n"
-				  "Using version %i"), INDEX_FORMAT_DEFAULT);
+			warning(_("%s set, but the value is invalid.\n"
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
+		warning(_("%s set, but the value is invalid.\n"
+			  "Using version %i"), "GIT_INDEX_VERSION", INDEX_FORMAT_DEFAULT);
 		version = INDEX_FORMAT_DEFAULT;
 	}
 	return version;
-- 
gitgitgadget

