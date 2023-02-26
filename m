Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F10C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 18:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBZSAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 13:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZSAe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 13:00:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EF1A25C
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 10:00:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso1019940wmq.1
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GAgsTdxXFfICP3tEcjMlDAmWRt5EdVW2Kd218GTTNYo=;
        b=Ivf58Ca+EgnuA4zu8EgS1opb8ZyhPiu4Km/z7xZJk4UW57kMEDjtiPsn+GviQieLyJ
         goLdY1snvHXVDJ5INQ1rVQxYYsgVMpraY603hRICraS84T6NAIyrS4MZj67CW4FASI5w
         Nt/hFx+ISo2+o+dT7VCPChZCycGnNNFg2lmPWSlezMlMidBr6qvrJny0L+qvmmFhkaSH
         H0R6XfHsG+Oq+VZZ8kNDd1Q5Af/LyMV288QfLzGJbvqmmK87liGUADxHSlCfNtsd3WL9
         FwbhgcDkteiKh/XqlVU6OGxYPovwwj0DTeDLknWdvyyYjhePrdaJq2gXF5BxEdX+YPfI
         FoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAgsTdxXFfICP3tEcjMlDAmWRt5EdVW2Kd218GTTNYo=;
        b=jkryvdgdJZRZY49T6hmOniD4dlUf+Pbr9+2JFwJn4py4dfjsEGaxw8NBCKah1dQdow
         LgYwtYxOjxfzqP/OQkEx+PHw43yz/9EAgAzw8nL6X6ueCUds0YgqClESoljZvS5s/deP
         A2qSa2Es2NUDPqQjv61v4Yl10PAaS56DsTwMrvb1iLXPGw4a/fBSoASiGFo/Ydxh7ZbG
         Q3OD8SrkHF67IOVfxcnbnNK75Yel5OEMhJqJ7wcQd6IanzHEc3HuyS5jHmxkOo+yI0sV
         E4th/9Xq4XTwJHuuivUFfi9waHvaYhoahWhdu+qs/HE2uhwFzNb/go5gco23c5y9a9yw
         UoPg==
X-Gm-Message-State: AO0yUKWb4B2Y6I4Oe1fEbOQQHhMJCJpbT1CSUK6LFLNUdj9zH352oZMA
        IubWT4Rhnz50rA14Mq/RVqoFyR3jXTM=
X-Google-Smtp-Source: AK7set+4+VpoKLUitQlEcG0PIcamc9w5Vr7kuQGJAv46fDSOUUoFDwBCKq66kGR5R26K0MxlgnA7Hg==
X-Received: by 2002:a05:600c:4fcc:b0:3ea:9530:22a6 with SMTP id o12-20020a05600c4fcc00b003ea953022a6mr4646588wmq.1.1677434430368;
        Sun, 26 Feb 2023 10:00:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b003eaf666cbe0sm6757186wmq.27.2023.02.26.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 10:00:30 -0800 (PST)
Message-Id: <pull.1462.git.git.1677434429160.gitgitgadget@gmail.com>
From:   "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Feb 2023 18:00:29 +0000
Subject: [PATCH] rebase: fix capitalisation autoSquash in i18n string
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Elijah Newren <newren@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Fangyi Zhou <me@fangyi.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fangyi Zhou <me@fangyi.io>

The config option (as documented) for rebase.autoSquash has a capital S,
whereas the command line option has a small case s.

Cf. <20220617100309.3224-1-worldhello.net@gmail.com>

Signed-off-by: Fangyi Zhou <me@fangyi.io>
---
    rebase: fix capitalisation autoSquash in i18n string
    
    The config option (as documented) for rebase.autoSquash has a capital S,
    whereas the command line option has a small case s.
    
    Cf. 20220617100309.3224-1-worldhello.net@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1462%2Ffangyi-zhou%2Frebase-i18n-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1462/fangyi-zhou/rebase-i18n-message-v1
Pull-Request: https://github.com/git/git/pull/1462

 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d529..9a18f9b4b89 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1513,7 +1513,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				die(_("apply options and merge options "
 					  "cannot be used together"));
 			else if (options.autosquash == -1 && options.config_autosquash == 1)
-				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
+				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
 			else if (options.update_refs == -1 && options.config_update_refs == 1)
 				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
 			else

base-commit: dadc8e6dacb629f46aee39bde90b6f09b73722eb
-- 
gitgitgadget
