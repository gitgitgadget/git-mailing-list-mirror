Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D11C6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiI0OIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiI0OIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:08:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB9F1B86A7
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s14so15280702wro.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=cb6qS7UZuhF0dyAHG5D4cSxCfo7N1tZNBWx+9A3s2Co=;
        b=lQXyLUmBNaHph1SDaTNZ1dUqVW/BQ0JJoeEibzmc5LCz8X3z4OparCp2VZpO3FxQ2g
         01nJmAOmPB2wyBNyoAgCV1CU5c2bAY6nQVgz2rD6tieugdiWd2iPHE84pc8rTO6OZUXl
         r5uiy4puQTLkfSk35FsMtGBJ4vahii535h4dce88WF506pvReErdp540SZPcI3Y4yqn/
         elO0vpcTRb4WFMiCn+JQIz+NYCcyN/mYzFdmpP26Fmwb7MHsUr23tzsLN2M14/cOXYZz
         a4JM9v5xdkAUyPpYnW6PGQWN7xFTSjQjs4HS4uGpqbl8AJPm678QQ56flnTuUZMcUM1Z
         wTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cb6qS7UZuhF0dyAHG5D4cSxCfo7N1tZNBWx+9A3s2Co=;
        b=V90Pj77CLlX/ED5xH64kuBBoguuIJatf5068c0Uy1xxzmcTzLho8gmCoAvQYcMu0Zm
         X2GnWM8mNGkCGABqsTFZ7UJakquwoPxyZSMXfZjH4VKugHEx/3wyBgMw8KIUijnqGDUB
         owhYeNQLfP62z+VVpTluHBT1V8cINhaGOGPKcdkZAjJwJl1rmIeaU7qLVyTVTJpHfgqR
         LvZO0ZNJbyS5PSqSg48zOVl6hewCgVQ7QESSNe3B2GoFUCA5f2WrGfe0K2JE7Gg3aXm7
         HTdT6N31sRlosRgl6U2PGj93sp4hR+qTIRzeeU2vXignSiFTqPVlE+0Xw5Daj29d14N6
         glRg==
X-Gm-Message-State: ACrzQf3mvSqyU/xu2eJCyLwB/VhkmzLTAXuzkx7HuwGYn6SriaBEc1cb
        diiTN4wYHoZoPLxVGuIwGXxvnaZy4H8=
X-Google-Smtp-Source: AMsMyM57p0quhUY9Q8oRoT72JZSyuGYoxjPmj/fPR5ZvSHWIc+oiifOxM7AS+uJhxoNpWyzQL5FWbA==
X-Received: by 2002:adf:f74d:0:b0:22c:bbb7:de3b with SMTP id z13-20020adff74d000000b0022cbbb7de3bmr2382979wrp.243.1664287715417;
        Tue, 27 Sep 2022 07:08:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b003a6a3595edasm2039527wmp.27.2022.09.27.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:08:35 -0700 (PDT)
Message-Id: <f277a7a429db8f54fa06dd1965d62ec491e6d84b.1664287711.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 14:08:29 +0000
Subject: [PATCH 3/5] config: add BUG() statement instead of possible segfault
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The git_die_config() method calls git_config_get_value_multi() but
immediately navigates to its first value without checking if the result
is NULL or empty. Callers should only call git_die_config() if there is
at least one value for the given 'key', but such a mistaken use might
slip through. It would be better to show a BUG() statement than a
possible segfault.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index bf89afbdab0..0c41606c7d4 100644
--- a/config.c
+++ b/config.c
@@ -2833,8 +2833,13 @@ void git_die_config(const char *key, const char *err, ...)
 		va_end(params);
 	}
 	values = git_config_get_value_multi(key);
-	kv_info = values->items[values->nr - 1].util;
-	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
+
+	if (values && values->nr) {
+		kv_info = values->items[values->nr - 1].util;
+		git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
+	} else {
+		BUG("expected a non-empty list of values");
+	}
 }
 
 /*
-- 
gitgitgadget

