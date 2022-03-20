Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B551C433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 07:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbiCTHRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 03:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244953AbiCTHR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 03:17:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E7C3372
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n35so5310897wms.5
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VMEUndPqaZqgnJ/fjVlg4dlleAN5tgf3inMupsE+RpY=;
        b=PeQNqgWamu952xky887NFZMZXDos8ra51+NDLNZsJBdmeiSqvI1dPoZKV0xTpR9Yiy
         Oz2LvtcIZHpgv3RXw92TDyzgpQqwAyG1HdVpV4VwBulglJfazeWrkgl6aan/WYV3kXGE
         glElfxMRb5vTUZJv8kMFM62g7AvivmWR8KZCnWMQUMbxiG5TwdfgPvy2CYsFT0IP3ZjE
         SXHUCVllhAwGyn/N3wXl8E8Tkcxj2FaaUeX2uaj1yXMHheP3gQ6Eao91zgpsFRyLlz8M
         mN6Og4Vj4gUkbwCylDYbqjggBRsDYuChBpTMYjXsmPlRjeg9x9Gvk018aoo2JzJGyCIi
         SREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VMEUndPqaZqgnJ/fjVlg4dlleAN5tgf3inMupsE+RpY=;
        b=IQFZ4ES7vuC6vh74KnPsJ94M2vcegf7mUgWhswW7eUc4d1bxqL4qqWq/Sfw1qvY3eC
         +wU1Tq30so/T7oK8nld5NnMMJ2+zGVROPNIy6iGxd7CnHzyAltFhSm4zZQ6RocRTAYcQ
         Ig8LFpfzA6fODcLie+WprWJ0npYTc9HWuK0FQNlr7mBW/ZM93AYE6LcFjnUfFFMm6OlV
         AwAup9jgzVSW4W70i7AZtOYz6TozRDwbGALYXqJNzdbvNt7sgo0CLu44zhqFJ1tVRuuT
         Fsc3JrQiE2PPGBxb1QrU/9rcg5K8EHp5tDAF4uKsMbz6MYtXcc3+dV5HWwKA7qWIUcr1
         u/Dg==
X-Gm-Message-State: AOAM531Nd1+y9se/SMkUZJHimea5LPpvQ0c6cN17et0aq+ri5NKqfBi7
        wvOTY3QKKeToYRb2bDlYRrmJLMUYpmU=
X-Google-Smtp-Source: ABdhPJyiJuAxZZcUqvRcx5DFINhsOK5gfca3aG1Lv48CTUCoC5RcYaxQT8h/7PmfdT0kCck+VGq2hA==
X-Received: by 2002:a05:600c:1da2:b0:38c:6dc3:fcb8 with SMTP id p34-20020a05600c1da200b0038c6dc3fcb8mr14625173wms.121.1647760565624;
        Sun, 20 Mar 2022 00:16:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b00389a6241669sm15300721wms.33.2022.03.20.00.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 00:16:05 -0700 (PDT)
Message-Id: <54797dbc52060b7fa913642cd5266f7e159a5bc9.1647760561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 07:15:56 +0000
Subject: [PATCH v2 3/7] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables bulk-checkin for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
batch fsync functionality.

There is some risk with this change, since under batch fsync, the object
files will be in a tmp-objdir until update-index is complete.  This
usage is unlikely, since any tool invoking update-index and expecting to
see objects would have to synchronize with the update-index process
after passing it a file path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 75d646377cc..38e9d7e88cb 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1110,6 +1111,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	the_index.updated_skipworktree = 1;
 
+	/* we might be adding many objects to the object database */
+	plug_bulk_checkin();
+
 	/*
 	 * Custom copy of parse_options() because we want to handle
 	 * filename arguments as they come.
@@ -1190,6 +1194,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	/* by now we must have added all of the new objects */
+	unplug_bulk_checkin();
 	if (split_index > 0) {
 		if (git_config_get_split_index() == 0)
 			warning(_("core.splitIndex is set to false; "
-- 
gitgitgadget

