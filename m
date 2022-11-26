Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F62C4321E
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 17:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKZRYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 12:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKZRYH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 12:24:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2BF1CB2B
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 09:24:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so9974707wrr.8
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 09:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AXIJoRvcvgQ8ye7XDXryu1GweiGia22Q8QYWcDrmBjA=;
        b=oxMCN8Ym3z/HXEMqN5NwM+u25RJAOkUzHjlA6VxYPGMC//mzUGOlUS4aoCMll2opZ6
         zm4hOeBKi2x7VGRIUe3s+YmTKSVRc/ZB8XGDGdQk8nflOwzbthfc2asWbJ0rCiSAHNoN
         HohkTzNDBNdB/+tO1dOE/pybTZEPIhB8iftK+tExmee/x4Vez+iS4+h3ubY7QbqPnk/3
         IUM0TsNCuVxNmN2SkQWdbS9Y8LD5elhjIPUCZjB8hXwgTaa2jbyKeQfKZmUvO4LJZvwK
         Qii0Y+AJUepmRQV/oo9rQT3oV0Ch1zM4r6VMG9crqNEmpbgz7khl2SPSfy0lEYvM7InG
         cyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXIJoRvcvgQ8ye7XDXryu1GweiGia22Q8QYWcDrmBjA=;
        b=f3Ko0moQb9vtgyOVgWU3rk+mIwOAl3Om6LmBzeGkajcxV2O64rzZSaYoNzlWi3T+oj
         3H+Nrqqi2qZz+hHa908XHDNq/KwrdTFyuqK1AB52FJZ1vgYTM4IZS7de/chCzF2WfdSz
         jHsKNfZnjAKVxjhqtPClT43664d0G2QQWw9KlR84dIsS00v0Xw14EAwUfNc7XvHtp7vF
         C3BQsZJJlkMLnMp/yqLYuZWqTCOstylgiyO50IPreY3AvqKqkyNA6CJ+wwGkxGsNuQDA
         JQuZg0RAEli299iCSagbi+TcB5ucLEMhoJMfd6glchrHrJ/lSEHpLB9lW+uXkZkG7Jsl
         HZQA==
X-Gm-Message-State: ANoB5pn2klTEFUzXn7p4uR8/5BQsfsp1P1VSDjBJDF+ac6XYghlhlEU9
        HBRQQSxml41pRsZLgbNdBSiifdGIQ1I=
X-Google-Smtp-Source: AA0mqf6lPrHc4J3GPurVLdEFtbSm+bI/uWg02as7dnYdHmNs1QZjAZy6rU3Rj3cGUx7gdlm2RVRzsg==
X-Received: by 2002:a5d:6b0e:0:b0:236:7439:61e7 with SMTP id v14-20020a5d6b0e000000b00236743961e7mr18785303wrw.611.1669483443585;
        Sat, 26 Nov 2022 09:24:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003b4fe03c881sm12826779wmq.48.2022.11.26.09.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 09:24:03 -0800 (PST)
Message-Id: <pull.1435.git.1669483442230.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 26 Nov 2022 17:24:02 +0000
Subject: [PATCH] i18n: fix command template placeholder format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    i18n: fix command template placeholder format
    
    This patch applies to the revision 2.39 rc0 during the l10n process.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1435%2Fjnavila%2Ffix_i18n_v2.39-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1435/jnavila/fix_i18n_v2.39-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1435

 Documentation/git-revert.txt | 2 +-
 builtin/revert.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 5016755efb6..d2e10d3dceb 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
+'git revert' [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>...
 'git revert' (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
diff --git a/builtin/revert.c b/builtin/revert.c
index ee32c714a76..6a9b550a61f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -21,7 +21,7 @@
  */
 
 static const char * const revert_usage[] = {
-	N_("git revert [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>..."),
+	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
 	N_("git revert (--continue | --skip | --abort | --quit)"),
 	NULL
 };

base-commit: c000d916380bb59db69c78546928eadd076b9c7d
-- 
gitgitgadget
