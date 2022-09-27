Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D729C6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiI0OIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiI0OIk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:08:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814318B4B3
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay36so6638770wmb.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Mq//iR1FgTrAp+BKUA+j08BJ/o+mgSDvcEr5zCgxKbc=;
        b=J8wPbV8ruvHp5cKRJTAUbyv/R1DRtaVs/eHIVJ2E6oS5ScjvXoXD6phb3a1+ajk1pY
         4Wy0S5ybvjlJswWO1WWB2xtf35owTBz/++O923y7PWEVqCj7ra2LOtLCK/4ENaymM8x0
         /zAG/3cihWpnr6jwCx5OefpzlCynBxrfJxV4OC/GcV0YTAsT06Yo8ndpG60uKqALWbB8
         fgIXqWm894ZooO6zwWT+XEYn97+t0qMWagAL8jVmq6tspQ8Y2PHZEQHf845GgNpnFefz
         pS2PzWfg7nMeHaNdNjOcDi3xhwZ0s3m79RkjQcuFlpbGYenVPhXxSNmLU9jJlYZ3LMcV
         9jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Mq//iR1FgTrAp+BKUA+j08BJ/o+mgSDvcEr5zCgxKbc=;
        b=flJW9Z7mhJh0iaaV93uyJZjlbi/FqX8ZkybcArMmQZZjm17PXRKFoB+kbJVeAzziBq
         dVexsm+u5zHDmz7ks7ZzCVYhq5sC2IABfukWhivvR4HXC1tG4clHX6Eyay9qLRadw6si
         BfQEeOuX73n2J/NPo3WXDEZb0n0EvdGabe7jvkzHdm87cXz+NItd0gOM140BcQ7dFnt0
         s7+oa9RT4Z0plWfN9hfpf10fO4jcSzYw020CIwmaEDfqJofKTmA3H+gKfBzwD1h1YZkR
         Qy9GbCo/S2fpi9ZTrS/3b9Uy1sMoTiWwnduLoXpF3lsH67mWoihl2bSMn0ZnqEYvJzMU
         O6qw==
X-Gm-Message-State: ACrzQf1YRNcPMU5gso3RsyVoeq9YWx/ZACc5EKCUBh63uUPPol10gXio
        3YsTdilDZDhwY3s5Ls5X0mUzXEkBsAw=
X-Google-Smtp-Source: AMsMyM4l6EMDJaNgu0WtWXAn3rhn+/KIrzmQj0TVaSkreF5UhoVW6WYJ1G0jJuNe5Bu1tVMPjZRnqQ==
X-Received: by 2002:a05:600c:3b8f:b0:3b4:9cdc:dbd8 with SMTP id n15-20020a05600c3b8f00b003b49cdcdbd8mr2883890wms.148.1664287716280;
        Tue, 27 Sep 2022 07:08:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b003b492b30822sm1929799wmr.2.2022.09.27.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:08:35 -0700 (PDT)
Message-Id: <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 14:08:30 +0000
Subject: [PATCH 4/5] config: return an empty list, not NULL
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

For the multi-valued config API methods, Git previously returned a NULL
list instead of an empty list. Previous changes adjusted all callers to
instead expect an empty, non-NULL list, making this a safe change.

The next change will remove the NULL checks from all callers.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c | 3 ++-
 config.h | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 0c41606c7d4..2d4ca1ae6dc 100644
--- a/config.c
+++ b/config.c
@@ -2415,8 +2415,9 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 
 const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
 {
+	static struct string_list empty_list = STRING_LIST_INIT_NODUP;
 	struct config_set_element *e = configset_find_element(cs, key);
-	return e ? &e->value_list : NULL;
+	return e ? &e->value_list : &empty_list;
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
diff --git a/config.h b/config.h
index ca994d77147..9897b97c0b9 100644
--- a/config.h
+++ b/config.h
@@ -458,7 +458,7 @@ int git_configset_add_parameters(struct config_set *cs);
 /**
  * Finds and returns the value list, sorted in order of increasing priority
  * for the configuration variable `key` and config set `cs`. When the
- * configuration variable `key` is not found, returns NULL. The caller
+ * configuration variable `key` is not found, returns an empty list. The caller
  * should not free or modify the returned pointer, as it is owned by the cache.
  */
 const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
@@ -543,8 +543,8 @@ int git_config_get_value(const char *key, const char **value);
 /**
  * Finds and returns the value list, sorted in order of increasing priority
  * for the configuration variable `key`. When the configuration variable
- * `key` is not found, returns NULL. The caller should not free or modify
- * the returned pointer, as it is owned by the cache.
+ * `key` is not found, returns an empty list. The caller should not free or
+ * modify the returned pointer, as it is owned by the cache.
  */
 const struct string_list *git_config_get_value_multi(const char *key);
 
-- 
gitgitgadget

