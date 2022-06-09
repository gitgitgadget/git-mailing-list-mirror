Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE997C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 11:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiFILfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiFILdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 07:33:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9073D7D6A
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 04:32:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so12446278wms.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VJMvU4ZBAG/mTNO81ze0RUPnJLbCHhKZRu250ls0VX0=;
        b=NSDxKVlWV5rfhhHmzozWEqvd34x+XSkFlhd5JKmCeBub46R5zHefC/aYM8ByNcvilN
         PC6Hx4q2x3PM7xotk+UNSXK5IJJD1iNLMpceGO+TiQ/7huIKPN4+uatahbrM28diNEi0
         jjskF72dfh4eSix2hKUeWI9Y34rW4a1Y3aNvvytmFUSAy+JmHjpWl133UTdN4X9x6+CM
         H9v1AYdp6vhFYn8HtDASn/+zhPVskOz9mrnphLPDT+IasgqOleXMzfdB6F0jKUz/Mmrn
         9m+jLyzLbD1NBBD7QZi2VWbPVWTUUJ1kclMehg7O7IrAltGmMv7jRNNf048bRTB0F2G7
         L8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VJMvU4ZBAG/mTNO81ze0RUPnJLbCHhKZRu250ls0VX0=;
        b=LXCRBF4/yagnS5Y+nT/ka4zb1a5gqMjhNGuCEVWSt8UmI/5NqhktkfIOyOvNsYtCaM
         6Ji8fyJ3pS3zDh09nbMuyozHPXTsbC8f85JryCBVAQVewROt/qHw4uGgYf3vy9asNz1D
         xExW4UbYD5kbpqHUqZZlsqlopjCyM/RNk4dYYh3oY+RD0a1sPZpBufIOIh5VC2+fL5TK
         tz3JaNIGrcpZLicMiNOGHb+6GgYd4uZ/ZBokOYqKOrg3Jm7xZuLMhIMPLwXkRZGE0QaV
         7TE+D13DeczFrxF2dffAi4gJRookDDwg/ttdtICtKLxxwrVZBvqcile/vszCmTJHoW27
         hI7Q==
X-Gm-Message-State: AOAM532cl+t38cnjETbNP5QpcN/HnyTLU0PgPnxDI8vQFPn5xFPNBx0F
        fxC6pz3szddC/lVq596Bc/Tcd0AWH9rwlML1
X-Google-Smtp-Source: ABdhPJwTQNoqFdUX8laGhTJw31ulcPmxPNvcsp7U6nXCp+dj/PqQdu9rFjSpCtrFEOC6xvp4fORFTA==
X-Received: by 2002:a05:600c:3ac7:b0:397:5cb4:a2b5 with SMTP id d7-20020a05600c3ac700b003975cb4a2b5mr2869533wms.5.1654774352031;
        Thu, 09 Jun 2022 04:32:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003974b95d897sm21696527wmb.37.2022.06.09.04.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:32:31 -0700 (PDT)
Message-Id: <19d6e34f038121b927cdfacc3c4ae5abd1791415.1654774347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 11:32:27 +0000
Subject: [PATCH 2/2] ci(github): also mark up compile errors
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

When GCC produces those helpful errors, we will want to present them in
the GitHub workflow runs in the most helpful manner. To that end, we
want to use workflow commands to render errors and warnings:
https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions

In the previous commit, we ensured that grouping is used for the build
in all jobs, and this allows us to piggy-back onto the `group` function
to transmogrify the output.

Note: If `set -o pipefail` was available, we could do this in a little
more elegant way. But since some of the steps are run using `dash`, we
have to do a little `{ ...; echo $? >exit.status; } | ...` dance.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2f6d9d26e40..b747e34842c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -29,8 +29,14 @@ else
 		set +x
 		begin_group "$1"
 		shift
-		"$@"
-		res=$?
+		# work around `dash` not supporting `set -o pipefail`
+		{
+			"$@" 2>&1
+			echo $? >exit.status
+		} |
+		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 file=\2 line=\3::\1/'
+		res=$(cat exit.status)
+		rm exit.status
 		end_group
 		return $res
 	}
-- 
gitgitgadget
