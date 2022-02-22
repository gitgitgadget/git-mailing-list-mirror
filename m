Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1817DC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiBVASc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbiBVASb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C925581
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so465364wmp.5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8jYl8gjf0naJJiVvZzP4wht3NW0AgZiyMz69tEpui/o=;
        b=JB2oYeTzZ0vKJClshiOCrDpj3Lg5HvmprcDQcvNMxjUNL0HWS76P8x1sez5vdyD2qo
         tLeYgarrY0plt27pIIKx3D2ZpK5Ke3r/BD2EHESw2aWUPkpnOAaW7q2Pf+ww9Cfonkgn
         vyzWQ846Y9ixru5cSCrbe5BRCoBsAtroIBZsNQ4diX+GCV3Mlt3hf0CoOCJHEEJvxL0y
         VkTVEZTUhjuXr97HWK0ru/dRQ1xUJ2ElZgTtlLSXNngAKCB/XQU49bzcpmD8qiX7g4fj
         DNsRc0jjjmK0/OQm1fAE7rZf6tfstx8h3B2UAPCOm2Jkxp/4Tu+rAsM8xdDc9KbBxCVo
         g1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8jYl8gjf0naJJiVvZzP4wht3NW0AgZiyMz69tEpui/o=;
        b=EdEdvzpXoG5K74S0zsT+0mx5W3gBCObQiHalOGaviZDqDGzW3j4FQlsmd3tgwjOUy8
         ujZoJ5tu3HCMAUyxA/Xyg6vGRnqjiZMX7TDl6a9v2qeBBT6Uxj4FKXxlqzIjQWaW63sV
         bOlsDzxEbGWdZx1EQLxJSXAgf2l72DmVVxeBZ/qQusgc7QWq6PHP8+P7Cl2icRRXupK4
         bjoTr0rWpGe+AZVRrSIsroqUY/KB6pxdssKKHJxbSy3RgcwU+ybumIMaMehLjKFdO+YW
         zXiZF2ambi32NHcUWdUHO+C6PkGC+kglOXcQ33kXwdQyHuyP/uXctZJrixklL6tmPjDk
         iuYQ==
X-Gm-Message-State: AOAM532x+5Hz6HEBddO11O5UBkTR4lzYC62S6Wr7oJZUvpZINpuyA3/I
        JRZZK5wNx5PsBf0ui92WeE4hBMR3fAI=
X-Google-Smtp-Source: ABdhPJw4ARIBQmFGXE8VUiOBK8vGGccuncvAP2CqWAXK9PmlMik3dhngMbVWq5mAtFkg8IzXwNd85g==
X-Received: by 2002:a7b:c19a:0:b0:37b:c68c:7162 with SMTP id y26-20020a7bc19a000000b0037bc68c7162mr1092009wmi.7.1645489082929;
        Mon, 21 Feb 2022 16:18:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm31398959wrn.51.2022.02.21.16.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:02 -0800 (PST)
Message-Id: <a113ed9a8449b57e2a88a24244f3e45b24a01862.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:50 +0000
Subject: [PATCH v2 01/11] worktree: combine two translatable messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
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

