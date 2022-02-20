Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE7C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiBTRy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:54:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBTRyx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B99527F4
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so23279749wrc.6
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8jYl8gjf0naJJiVvZzP4wht3NW0AgZiyMz69tEpui/o=;
        b=VTGa+RFflIvFU1XkqcBSf9DFyYzlaAUWQ+MfiL8Ns1KbgAmOKznn6NzNf+et7ZJ29+
         x36h2eYumbhnjB3vMIlpQWW4ksVO0SRUuIPTtHCNcP+Vxo3J0CwWI4DJXANsiOLGYqNf
         h/V99NS1ATI/AVL4tZxIvDDZSnygsOJb/oY1baImZgwDVleTAspw/EjytXtDc+zmi3Po
         NSdrEu/ru+JbQ04VOnyarCgCBMid8iaguXskgE8UKjQ6/HCrk0CZGQa5FqWLs2MGHVNH
         WgGk5l+TKdqMDHNDKbso4MzFbQQwevooSVCuukGd11n7wDygGIkVyV9riuaWsSWmzCVh
         xWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8jYl8gjf0naJJiVvZzP4wht3NW0AgZiyMz69tEpui/o=;
        b=D7ykQt1vT7zPbijFwFYegflkwjMwbCZ44dDnJ4klZqcyQjqbDpyxX+zTyl0gKAA/X2
         +iyKXP0HFFRV4FoaaGsSsYGefqt31hAZDKbei7XeX4maAai7UDHTPDykPb9930Gm0rQl
         Vbtoh6gj7yD+P+LGLK+rfnvvZEwOkZ/YHN7ymxTwyRYrHir1K5uYrUW0SE4eOQVxvzgL
         vvNmrPCIhbWN8MZYGfwxpdmC+PQ/XcYXtayjpOW5a/FmxXVhuAob8FY5AovGF78CkEOj
         ud5B1ZFRpzTP2yYyAge58hdvR3SWLM2PgnsG3Ll0HGszy8Ehj7qWvHM721F3weW8rUs3
         IrQQ==
X-Gm-Message-State: AOAM531xpms5hfY59Ql2q/Aru5ZiBlanjbYKRvuCCSxNCUS6IqQNVpLP
        JwWfUL9B0bxCizcmbwdGrtI6FBmfrfs=
X-Google-Smtp-Source: ABdhPJzZSZeoPHPEcljPN9033/1Za2yMeMZwR0zIi1I5BqIdZdzuZiT8caypGK5wM5HZmOO65UwlUw==
X-Received: by 2002:a5d:4536:0:b0:1e5:64fb:a531 with SMTP id j22-20020a5d4536000000b001e564fba531mr12785476wra.264.1645379669879;
        Sun, 20 Feb 2022 09:54:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm5163949wmi.47.2022.02.20.09.54.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:29 -0800 (PST)
Message-Id: <a113ed9a8449b57e2a88a24244f3e45b24a01862.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:17 +0000
Subject: [PATCH 01/11] worktree: combine two translatable messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

These two messages differ only by the config key name, which should not
be translated. Extract those keys so the messages can be translated from
the same string.

Reported-by: Jean-Noël AVILA <jn.avila@free.fr>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c6eb636329a..7c272078dc9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -384,11 +384,13 @@ static int add_worktree(const char *path, const char *refname,
 			    bare &&
 			    git_config_set_multivar_in_file_gently(
 					to_file, "core.bare", NULL, "true", 0))
-				error(_("failed to unset 'core.bare' in '%s'"), to_file);
+				error(_("failed to unset '%s' in '%s'"),
+				      "core.bare", to_file);
 			if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
 			    git_config_set_in_file_gently(to_file,
 							  "core.worktree", NULL))
-				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
+				error(_("failed to unset '%s' in '%s'"),
+				      "core.worktree", to_file);
 
 			git_configset_clear(&cs);
 		}
-- 
gitgitgadget

