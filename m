Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E495C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589D4610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhJ1QYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhJ1QYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B102C061767
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso9931285wmd.3
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=TvV2yv/gWyvwyASy1idiqglLGLJgJVKrGIS2ddq0oLU=;
        b=TdRS2AB9FM94FF4T7/PHSxH+/IXS4+byJUpMaCpe1AvUz8dSJQVsSv+7HLQruK9F2H
         fjqK/5pWLHiFLoBXLactqlJwshb47PHZY2E9Ghc+2N3Fxl5h/uw9TwNuWr2KYbZOrA2c
         QU7REHEuo2uF/DorvD/1VBMrLaTnjzujCnRQQ5f7YrVNr8qNIJ5Zn2sKUkIO+1IGu288
         lLv/eL0YKPaTGSW/9uh5XYnCI9Nq8PW0mh+rkm/0b8/NhFsL7XsBY1NTc9jUQ76vgEC/
         2k0t2XVyMrpKfGLEvODEjvoXnKVU6PWYo5q+D5RB5PfHegaJunnoTm8rk0zwrYHSk3lk
         aCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=TvV2yv/gWyvwyASy1idiqglLGLJgJVKrGIS2ddq0oLU=;
        b=cUO7RIqaLbhInJD7f94SAUtPvH7RD2CwAoe0DPSOHZIdba4rttxcNIJbvppssAOWQE
         iWQ7lWPAvYobcC46r5N7LHHiGTFRykdsTpjS3D5lTUJBC7EscjlojoZhrVLbiyMkWdOA
         LBfI4/YFhmL7yg94QUXY4lEeyjdo/1QEDgPHU57ZmknTomhZbcelXY5YIh7pJgNbFX3s
         vxNv1vEBpItFULiKZU5oDd+lZzHmbmLprmQJ42MJf3BPVvxFKZ0PlD2UjBB933v2ve2/
         tY9L+jl/cw+zhhp2MFmzTfP5NRM2E4aBsxh6MJO2PZHZCykTi1SjqsHON2f3suinKpcn
         7BCw==
X-Gm-Message-State: AOAM5323T/CV/l98YvLfHMJvekLbXXVKCs5S0LzoYRobapGjskxrFrr0
        ZxbVnyA4u+9qB87Xlaz0Go3oZaj+k/0=
X-Google-Smtp-Source: ABdhPJxiDZV4N+7Lspjlac6m4E1bjn+0cC/XXnba1LtOP+kNuM7FOJpjnhH7V9KwCQHRTxEGtzmmQg==
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr13563839wmp.43.1635438128627;
        Thu, 28 Oct 2021 09:22:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm3417717wrc.74.2021.10.28.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:08 -0700 (PDT)
Message-Id: <8e078e6ea17b51766256e427e7bca5ce7d9af809.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:22:00 +0000
Subject: [PATCH v2 5/9] doc: git-ls-files: express options as optional
 alternatives
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

That's how alternative options are expressed in general.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-ls-files.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 6d11ab506b7..2e3d695fa21 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,9 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git ls-files' [-z] [-t] [-v] [-f]
-		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
-		(-[c|d|o|i|s|u|k|m])*
-		[--eol]
+		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
+		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
+		[--directory [--no-empty-directory]] [--eol]
 		[--deduplicate]
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
-- 
gitgitgadget

