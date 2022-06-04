Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9164C433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiFDLSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiFDLR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 07:17:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D51F620
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 04:17:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u8so9056092wrm.13
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0JP3vqFd04HuLyUor0tZpNkGmwQPKOs/mYUhfcjqENk=;
        b=ThKtTRn5WsrM3tW3AityUg1HwqQLrExCnMpnYK1kiV6Gl76M+ZL76TMa2BJ5R1GZTf
         OkXtMEqNnvHcgQi2L5Nt2kIPz676b5VZJBofi2d5fes229ZuipWE3QTGTJ/dohVivJZU
         KHVjFt21ca7lV475qXrxv+NgYv7MDyl4RkcnYbby8ckDMPRNSWE0ZImvJD+MWjhFP0Np
         FV0e+HX6nHldcLdOKux+4TrTCwqHv2apKFtQ1yM09RCuRkZ6cCkIKXuG6vnH962nzwvV
         hbnmzaWqHpm8+ko9nUkrQqS6xQR9AerVHUkWQJwa3b9L+DXG9IqDlfb9H8mdMkQ2PR78
         Si+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0JP3vqFd04HuLyUor0tZpNkGmwQPKOs/mYUhfcjqENk=;
        b=Iyg4wlTbjR/mYpTVnQ/N5ZTIDTvCl+lEpv7H5cIV1ubWzdTNQPVCYu2a9a6ftxq6ap
         fLjpQkuaYhh1zWaZLrjWD2AADmQN7XROhLKi4mcedVPPq83MZvRT8e+tR+nn5HnxXl38
         UbLqOfa8s7KaJIPXT24MPUjZO6AJCm/qZa3O7Fex+H8KHU7WnX7yhZZT7VaLCO7vXJqx
         8Jfybd2q4JO1gXnHA7dxJWEoBQksgzxA/Fq7nAEtfeJD0K2e6S6U1rXZyh40+0K9nNYs
         DcpCXDoDFLsj9UEa2tA7uKyei/yKfFkqv/RMdo07Xjcoz/nr4LS0y0+PqZ5uJ/ycuo3h
         v7hA==
X-Gm-Message-State: AOAM530AbSTVAbGs8+e4S0o5BzMMkjpJLjF0kTyZAbYLwAVNoZcOtG84
        8YwR3awMuGG/jwVcI7q2F43l2qYtQA8VGnat
X-Google-Smtp-Source: ABdhPJzxvg6J2qyviZ6qCc0PMNu/outTVy66isyWTgMRiUntqaxnQtG/CGdoG/V8U3d8T4sNdhEEig==
X-Received: by 2002:adf:c64c:0:b0:20f:e8f0:be4c with SMTP id u12-20020adfc64c000000b0020fe8f0be4cmr12383083wrg.614.1654341474473;
        Sat, 04 Jun 2022 04:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c4ed300b0039c4506bd25sm2971473wmq.14.2022.06.04.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:17:53 -0700 (PDT)
Message-Id: <fe000f062078e544361c87c319830cd36aabbc91.1654341469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Jun 2022 11:17:48 +0000
Subject: [PATCH v2 3/4] rebase: note `preserve` merges may be a pull config
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

The `--preserve-merges` option was removed by v2.34.0. However
users may not be aware that it is also a Pull configuration option,
which is still offered by major IDE vendors such as Visual Studio.

Extend the `--preserve-merges` die message to also direct users to
the possible use of the `preserve` option in the `pull.rebase` config.
This is an additional 'belt and braces' information statement.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/rebase.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 17cc776b4b1..5f8921551e1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1205,7 +1205,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			     builtin_rebase_usage, 0);
 
 	if (preserve_merges_selected)
-		die(_("--preserve-merges was replaced by --rebase-merges"));
+		die(_("--preserve-merges was replaced by --rebase-merges\n"
+			"Note: Your `pull.rebase` configuration may also be  set to 'preserve',\n"
+			"which is no longer supported; use 'merges' instead"));
 
 	if (action != ACTION_NONE && total_argc != 2) {
 		usage_with_options(builtin_rebase_usage,
-- 
gitgitgadget

