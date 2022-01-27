Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA48C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 22:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbiA0WD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbiA0WD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 17:03:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C4C061747
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso6845788wmj.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BfAlWV34H5VQG7iupCZfkkUC148jP4TKM9b5OnmUizk=;
        b=DSDa8EwzZhGIJSCP+cd+phaT1+WbszN1UZ/4xoM4Tr/n8BdzR5Zx8Zc6R0ZsG4wd7S
         gp77jOrn0zuDWJpjdgD9M9WmyamAe1teFs3e8PB9SeqFb6ZW01jYSM/V5YoAPgihMnwp
         L81pmxa1FEnX6hSYWpxJ59MiPCME/X+YUhO0wbApIRbvp1AyyehtOt3PzuiwnknOZMhW
         1oHuVaAJ3eSHJvTrCJ/Pkwcribx7c2J/S5Do83p93lw90hNr6n1G1MPyWPex7l8Kqr+v
         7OdcMiW9jLlXM6tD64o0KTJMc/Nqrc+fvj7ZyID7KEEDu3pGxFiq6Z9SFFb3+mrC8SV7
         qwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BfAlWV34H5VQG7iupCZfkkUC148jP4TKM9b5OnmUizk=;
        b=b89l9J5C3qHMrtiXYI7rVARGbzXGnsPw/f7juIpdC8kGQP+wfeLgm4A4M1W5FEo51F
         +Xa9JxP7NHTk9nBI4LeXUZZfpcsd8UTSGFDwWv/6G685lcBJ3YR7b92fKbYiPr87XMgQ
         IZ3MX4JE7Jvg0bSV9+5zjIVY2Ekip9vylX0X5OYHHKcecULM4pnAa992tK1wqWeFCe44
         ws/XfQnKMgyNP8AN7ToDVys9JsGy8v7q4YlzNVsxU8f7Wnt2DaHGk7trDBTzRji2sm0s
         tRP/MZtwM9jyKv0htVGj3amiN6uWEDTLvBMHBh61CV0uspnMN00PH0blXmzUNmGczXT4
         urZw==
X-Gm-Message-State: AOAM532Qdt8GGVlBWvSqnbqBwdrwb9oeLKVEA3LSu8+Dub1Li7b+P8Os
        PMMl8rY63t62kgfoGRDl4RP6HSI3r+g=
X-Google-Smtp-Source: ABdhPJzcimKcfoOYY4oHcktxYOnIKJdFmKD5cemvzK8EN3B8aqy57gx81ZealOj/iqWjsf9hAuSBBg==
X-Received: by 2002:a05:600c:3845:: with SMTP id s5mr13483639wmr.134.1643321035361;
        Thu, 27 Jan 2022 14:03:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm388366wmq.41.2022.01.27.14.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:03:54 -0800 (PST)
Message-Id: <e8e736ee3c28db02c0f390c61a1e0e74f8e4065f.1643321031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
References: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 22:03:50 +0000
Subject: [PATCH 3/4] Remove documentation for `stash.useBuiltin`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 8a2cd3f5123 (stash: remove the stash.useBuiltin setting, 2020-03-03),
we removed the setting, and for a couple of major versions, we still
documented the setting, telling users that it is gone.

We can now safely remove even the documentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/stash.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index 9ed775281fb..b9f609ed76b 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -1,10 +1,3 @@
-stash.useBuiltin::
-	Unused configuration variable.  Used in Git versions 2.22 to
-	2.26 as an escape hatch to enable the legacy shellscript
-	implementation of stash.  Now the built-in rewrite of it in C
-	is always used. Setting this will emit a warning, to alert any
-	remaining users that setting this now does nothing.
-
 stash.showIncludeUntracked::
 	If this is set to true, the `git stash show` command will show
 	the untracked files of a stash entry.  Defaults to false. See
-- 
gitgitgadget

