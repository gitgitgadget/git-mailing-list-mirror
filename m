Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC0C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BC860F48
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbhJOT5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbhJOT5H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:57:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41ECC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:55:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y3so28403821wrl.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=PIEwNc9olofE26hnuyWWQsKyNrMK7eSkjx8HR6LObzjakGnXBV9Y8IBr8b17Rf/qYa
         eB1qvAMHFNwf+vZYlhWiYZ24g2kgmt12rdjJ/SdNuF8owQktTGFXNjKQDzjsgU+q9DEI
         YjqL6Egq7i+6DSHgsXiqtrys002zaixT5F8CQhth7txwmlSPloNDPHepTezDkWWprrlj
         9cxRkCgv+iqwp4SJ7NFgfB6zlgpsk9E0lvqReCo5fy77chKHXSmeTYGElk5UHkq10zOm
         Ft6s5AsV1n+QbKcup4WtuvbMwhaSJk7wgCZIjHyVaWSedQwgami1Bt02aDtsR2oTBaZE
         kGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=VHsbPYs6bZ3Ev3VUJVzcBTXY1pdntGddQmO9wm719IHat0u1wLdsswLYYQZZjcRHFl
         FMmObGzmWjh8B7tyxy/0QCCIyAzFRzUCTuCOvL/tGLlCDzpcEewvPhLN4QhqLKjv5dGD
         IApBopA91Wsyh5Z99bkAio9nW1PvriVzZCmgcOcWOEPpFRhF2td0RWUxSscdgcRG8T7i
         U0yYpH56+pdW7DseNTJdnb5o+Knyx5W3gYXIS/CXajeL9hn47Di3ukjXQFG+m6tI1qvo
         4uUD+gt5iXgMQSS1TiKvq3EQmEbQs2ctrG88LrPwb9YHlU3tTpNBwbWfNi22n06XQ/fz
         P/qA==
X-Gm-Message-State: AOAM53165UPBBJp6IGGBSIbqeep+3fzju9pwWClA6Ezml5mDOGfr3lWw
        XS0pGRnyNBCMjkiWgXodZSI7WflWgN0=
X-Google-Smtp-Source: ABdhPJym1nCqvOMJ6x9/6IyRYPQclXz1xR6ptwnRf18Ma9J6THAf1FBlRFjBeNjB56g94idrZ5K3VQ==
X-Received: by 2002:adf:ca09:: with SMTP id o9mr16226874wrh.303.1634327699677;
        Fri, 15 Oct 2021 12:54:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3sm5758551wrg.23.2021.10.15.12.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 12:54:59 -0700 (PDT)
Message-Id: <6974ce7e7f568444518f9ff405747653516b2613.1634327697.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Oct 2021 19:54:56 +0000
Subject: [PATCH 1/2] test-read-cache.c: prepare_repo_settings after config
 init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Move `prepare_repo_settings` after the git directory has been set up in
`test-read-cache.c`. The git directory settings must be initialized to
properly assign repo settings using the worktree-level git config.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/helper/test-read-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b52c174acc7..0d9f08931a1 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -39,8 +39,6 @@ int cmd__read_cache(int argc, const char **argv)
 	int table = 0, expand = 0;
 
 	initialize_the_repository();
-	prepare_repo_settings(r);
-	r->settings.command_requires_full_index = 0;
 
 	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
 		if (skip_prefix(*argv, "--print-and-refresh=", &name))
@@ -56,6 +54,9 @@ int cmd__read_cache(int argc, const char **argv)
 	setup_git_directory();
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(r);
+	r->settings.command_requires_full_index = 0;
+
 	for (i = 0; i < cnt; i++) {
 		repo_read_index(r);
 
-- 
gitgitgadget

