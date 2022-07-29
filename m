Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53D3C04A68
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 15:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiG2Plf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiG2PlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:41:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CA711C0C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:41:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l4so6450363wrm.13
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6incKFQfBj9vNSGGve/0uWH0sf8XVQD3ti9aXy4ciRE=;
        b=meD0fgxjBNXZ8uBR6zM1qhc1K3EzgnSxI8fHtq4yT3KgbhZC46DRIPM7BGRk5XErls
         e2ZDypi/XPAAnSsUabtACtRbc25GpxzB7dotO1T4bwWTtR3ecBb+OPty0lF1S53+iU+M
         H36KaN+ZwA/9NZm4+pFhYk68PU/zNEqaJDiDCCmuA9/0BjJVkY5aQ4IyxaFn+VV+1Ucr
         COXtxSoqEpoVIqUjzhQHjHLui/y15YE+yRAtJ4HZeo6/2mysy/fDYlzBIw7LrAmeHIqK
         95XuO46XtcoziiZgebmwkNk0vBMdEjzHCMq0eUGFPNjEnWGnX8TVyaA/PIztHXqYjtLE
         cWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6incKFQfBj9vNSGGve/0uWH0sf8XVQD3ti9aXy4ciRE=;
        b=iXBqhXa4XMH675kN05JQAXDNj1cqyiUoQz3jzvA17Jy6RcunKnkABshmTjeiCFewi4
         d7WnjmIO/uWsAVfBQP6koNXUCRB82GDdjn9QqIrM73yE7uqZ83wAmlvANyWzoUNbaltp
         1Or/eEw+EtDbd68xMou2O7rfeN/D/FMHmsiNuSxmTH3ccY+dKhnXt04BJoBumP16hqQK
         l97zPkwDL6ErY+ucKFqZvnP2qAkp+Ly2hX6deMB8HREZuxShAgRErXe4NhsL1BR6CGRV
         +sMlwnbrekLhc/9Ls3EQUxcdS5WsoP1smxa0jUE6bk6dTaHgsYAV5Qq5m18364DE4KR9
         y6vA==
X-Gm-Message-State: ACgBeo1eZh7YTT2nVO7zCaVD23e0Y73xDJYuZNkeV7EWoFt2XMZ4JH9O
        GNhqZNdyzf8A2glQkBx41Q1l7eZBzpM=
X-Google-Smtp-Source: AA6agR7DuASLpxYddY1rcbRnqFHbsOeXDbnii595hHm3ZtijYJHXDBzOCZpY6BXTmV9fwLIYLNxrtQ==
X-Received: by 2002:a5d:6252:0:b0:21e:4457:1bca with SMTP id m18-20020a5d6252000000b0021e44571bcamr2817428wrv.287.1659109277732;
        Fri, 29 Jul 2022 08:41:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b0021d63fe0f03sm3948878wru.12.2022.07.29.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:41:16 -0700 (PDT)
Message-Id: <019fb837d68fda459ff474f6763572461c7189a6.1659109272.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
        <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 15:41:10 +0000
Subject: [PATCH v2 2/3] mingw: remove unneeded `NO_GETTEXT` directive
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

In f9206ce2681 (mingw: let's use gettext with MSYS2, 2016-01-26), we
flipped the switch to build Git for Windows with support for gettext.

However, the way we flipped the switch was by changing the value of the
`NO_GETTEXT` variable from a non-empty string to the empty string, as if
there was any `NO_GETTEXT` definition we needed to override.

But that was a mistake: while there _is_ a definition, it is in the
`THIS_IS_MSYSGIT` section, i.e. it does not affect the Git for Windows
part at all.

Let's just remove that unnecessary line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index fd7b6a90429..e897b80b3a7 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -717,7 +717,6 @@ else
 		INSTALL = /bin/install
 		INTERNAL_QSORT = YesPlease
 		HAVE_LIBCHARSET_H = YesPlease
-		NO_GETTEXT =
 		USE_GETTEXT_SCHEME = fallthrough
 		USE_LIBPCRE = YesPlease
 		NO_CURL =
-- 
gitgitgadget

