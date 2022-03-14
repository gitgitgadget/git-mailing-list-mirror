Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF636C433FE
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiCNQL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbiCNQLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:11:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55E23E0C3
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x15so24725036wru.13
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=837qGVpXFZzM+0YUSLB3JsjOQ4eE6KaJGG+jcxv7f0o=;
        b=gb1rOUAN4aWwXNzWfkZER804Fcy5Dhs2ojoPyuPyFP2PX3tQG26dGxX5VzIxqK6FTV
         FjSnQo0K2NqvViVwSIiV3cvcWKsLiCS8krO6rarwtQHO49YiL5nOpNP4Zq/7BYXxop9Z
         h602p1YgU9pipRqRAoeQPjyHa65NzSjOj4GCKeyNWAVUVpA3ZhmKjyrbyFGW9F6e/LhJ
         62At2bMLSH1/hsph5FaCkkGc2VmNyEaP3vNG71MMBF1rL/b67x7PiVVg4sjqggaqSOzQ
         csBGH/e8exUPyXa3Wn0BjQ8jd4SE0sBuILH/zuqg9x+UmzwfyyEZ3HcEz+RKoUYA4IIc
         IAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=837qGVpXFZzM+0YUSLB3JsjOQ4eE6KaJGG+jcxv7f0o=;
        b=tuZ+jKC48QkxFloW3lrOmwQ/NsJZe23GuMtH9ASNYNVk1QVFgDKCI9VVU97W4yCPRi
         y79fmWZcth9FWT6Pa0Gq4ueDKY1HJrhlRiPL6kZwRGb4zXzoO7hlgGQ2g1ZorHfG1xlP
         1plr8RH81Fwh1K6qRQpq2/k9WFUy1C06mHT9Eqbxl8vPn0LoKmGkHl1amfMc3BmT3iWk
         CH8/qlPekWaVUj3FrJrqmagdOGUzSX3rNiI+HgwcOGhFAlMS8yOHZZo+uJ43AZDH5gLK
         XBBuRj+hSvNEVjzYZhkjREwNgsL6Ko3dfWjgDfXvClinpgW8NHMGO1m0HjZAEjw62ilC
         FZuA==
X-Gm-Message-State: AOAM530TfP2M1LAP9p4+ANs9peaTv38hMbsgNd+CSfsd4HfsIwqeTl3w
        B3tOKcf1R9fHlEhN13Masc90Q9zWi3k=
X-Google-Smtp-Source: ABdhPJya2CGD4ftWDA6j7n69y6lf+R+bXdEtAwuNGQRL2Ledwq9Bxziw5s7CzNVcqLdt13XZynSjVA==
X-Received: by 2002:adf:fd08:0:b0:1f1:d7a7:f304 with SMTP id e8-20020adffd08000000b001f1d7a7f304mr17705502wrr.36.1647274235346;
        Mon, 14 Mar 2022 09:10:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020adff382000000b001f022ef0375sm13617379wro.102.2022.03.14.09.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:10:34 -0700 (PDT)
Message-Id: <cffca0ea5c6b09fa1a0725f81440b6358f79d303.1647274230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 16:10:29 +0000
Subject: [PATCH v2 4/5] reset: suppress '--no-refresh' advice if logging is
 silenced
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If using '--quiet' or 'reset.quiet=true', do not print the 'resetnoRefresh'
advice string. For applications that rely on '--quiet' disabling all
non-error logs, the advice message should be suppressed accordingly.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index feab85e03de..c8a356ec5b0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -535,7 +535,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
-				if (advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+				if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
 					advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
 						 "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
 						 "to make this the default."), t_delta_in_ms / 1000.0);
-- 
gitgitgadget

