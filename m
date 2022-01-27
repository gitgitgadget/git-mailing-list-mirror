Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86638C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 22:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiA0WD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiA0WDz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 17:03:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49583C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v123so2932903wme.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PelSFQVpQLFNIKq/2LDMyrLyUPU3gsfPQHV5mjoS3iA=;
        b=IxXRYmIvzMxMbR+WX0lfVuERL56ZImIpa+RiI5Zuv9cEWuoma7HDSKYWbbEgN8yLPZ
         xx4k56iT9uvP4vTgKB9n5/nnN32wrOPmQ2/ujUHL9YpBTGLVm508hjhNxRDbHjdMizvu
         vP+WFxiMR9CwaPhhBdMDXvp7PWJbSLRVVqbV2UEKASOYNdNxmZLrYxmvjHvagNtndGin
         pweJh/kQCxVNmeD1D7s/5ZjBxKogE8b7/NK9Jl8lA0wy4aaKehhIEQFbEPPRQ+qPARzm
         E2H6yfT8b/pAshnjHeAwJjenIxywtbEJ9Atguhnr8Mdtu4xyVyruSd+427D16OSfv67E
         INog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PelSFQVpQLFNIKq/2LDMyrLyUPU3gsfPQHV5mjoS3iA=;
        b=ZK64/5Y2psYmqsEfh/UW/WRlF/ic9lSeRfKJ32rHDo3FMiETgtKMPn2OicnCw4qTu7
         TCUCv+pu7VfLiPk7pq0arxo7Y5AKIVKIH652fWY2J4wpCcwykET7pcFDC0gTRq5MsihS
         Stcll7OEdwUk+U9jlBcfubkZ3kK4H72j6UsAO4z4pIIoJa0hUMG5jJnT+iScW02oZdre
         i4fSeOtCYuNjlWJ9lPU165zMNnvNZD7wFwzwzFCTJKayJ6/3/yJ/9P0acTcoWJ43Hv59
         512EkRb8vb7O0lhBMQIiY6o6YGVerIziDYcRkRSM6WKsTrMUbjqjhY0ZcI6BMHx90d89
         LPzw==
X-Gm-Message-State: AOAM531yGxewxFnRYqonoSxMKO6xbgwIwiAeu5xmtskO8iNIYZZZL158
        LKJt3LjE1gFKFkbGPcyLh/dMu8ZrYA4=
X-Google-Smtp-Source: ABdhPJwKa0CobVflLUgo8jsolc4vU92UMppvEPZ5q6lGdzNChnp6cxLkfyj9DWTWKT2Cf7+00WJLXw==
X-Received: by 2002:a05:600c:34c6:: with SMTP id d6mr10104691wmq.103.1643321033732;
        Thu, 27 Jan 2022 14:03:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm2953197wrq.31.2022.01.27.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:03:53 -0800 (PST)
Message-Id: <78676cee5f75e7928ce31e929b872f50b6819e51.1643321031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
References: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 22:03:48 +0000
Subject: [PATCH 1/4] git-sh-setup: remove remnant bits referring to
 `git-legacy-stash`
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
we removed `git-legacy-stash.sh`. But `git-sh-setup.sh` somehow still
thinks about it. Let's just not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-sh-setup.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index b93f39288ce..d92df37e992 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -101,7 +101,6 @@ $LONG_USAGE")"
 	case "$1" in
 		-h)
 		echo "$LONG_USAGE"
-		case "$0" in *git-legacy-stash) exit 129;; esac
 		exit
 	esac
 fi
-- 
gitgitgadget

