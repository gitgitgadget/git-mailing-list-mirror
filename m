Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F345BECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 15:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiH2PMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiH2PME (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 11:12:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E017FFB4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b16so2961222wru.7
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=INSp9ODgFBimHntLRKzgvnj5KBQj+US8b8e2OelsXQI=;
        b=VObxgBLFcZyFwOIuHxNDB4GRTFqR14rqcc2QyqdaUCVc3L+/BefWYyGm2pln4w0DQQ
         8qfKZGkq/uMpSxi4lDQcYipGN3xglQoW5uG62fJhpphXzXUu18ZtBQ5ymlFXYe8qW6NW
         +dr6M+eSi6cyeh8klo9kG+UXgPVXMbJsHHwsUJI7ZcURfAxnQb72uTBfjMrLpDZmclJW
         nf2KopDmm32Y/PnHj9WV63Tzri5Hk3DSKg3RnWf8yDEej27sNc5zjatMVFWdTrkbvCLo
         qaT3BQbegY9kPur7ZXXUSXEaYgEyk7bnul4XagbkSFXPwII2WeAe4HtJAKmjrQswseGp
         pk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=INSp9ODgFBimHntLRKzgvnj5KBQj+US8b8e2OelsXQI=;
        b=fZMrK66UrZzrIZnnOfUwvRKcJPnuzf88LfF1tYbT//kXi9FrBvXFvlWo6UnNOvqAoH
         94CrAG0++dzGbvqVt/Ri4ssIBU7ve9eokQ7Nsf4rR6Im2vbFffj7ZXCdWIACLc2214yH
         Ji5q8RCyWOAO+qh6bFFhURU/NhedpUCyW38ekY7jHkedlBy8gFC7YwtXHbh54B4i3+BY
         B2ZUn2TdWrkZ3qhpd0kQeniXHXs6jjylLrvPhiHkka1MDcIfFYlDbz/oliJJ/4rYXS/Y
         HpOcyMPHyuUpc+0nPh/05NciQs61KzMhiSYwvpsshGDKvuLTAkPSCdic3PZN5zDCU2EC
         Fwcw==
X-Gm-Message-State: ACgBeo0YaAUXtJRk3eCEocekXRVPr5LWjM5Z8FRh5cda5tdUvYnlC1jq
        EJN/VvIdPJU28ydp1F1kXfEI2s2tZwg=
X-Google-Smtp-Source: AA6agR7UPHy8zCtPqQBL+OM8Nkiq57zmPcRcJHWjxkOCA4FeUbADY7eDeZFp2D7qkvWSdoKZF1QM9Q==
X-Received: by 2002:a05:6000:1c1e:b0:225:84e6:658f with SMTP id ba30-20020a0560001c1e00b0022584e6658fmr6814621wrb.6.1661785920457;
        Mon, 29 Aug 2022 08:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6091000000b002237fd66585sm7254301wrt.92.2022.08.29.08.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:11:59 -0700 (PDT)
Message-Id: <a01fa5d25e4a94dd8ece5e328f853c000a2ad0f9.1661785916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 15:11:52 +0000
Subject: [PATCH v3 1/5] t3701: redefine what is "bogus" output of a diff
 filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When parsing the colored version of a diff, the interactive `add`
command really relies on the colored version having the same number of
lines as the non-colored version. That is an invariant.

However, in the 'detect bogus diffFilter output' test case in t3701, we
essentially required a hunk header that contains parseable `@@ ... @@`
hunk headers, and called all colored diffs without such hunks bogus.

The reason for this is that we would like to show the users the adjusted
hunk headers _including_ the extra part after the `@@ ... @@`
information, which usually contains things like the function name or
soms such.

Now, there is a _very_ popular diff colorizer called `diff-so-fancy`
that does not produce such colored diffs as the built-in `add` command
expects. Nevertheless, the Perl variant of the `add` command handles
those nicely, essentially by ignoring the hunk header and saying "there
is nothing else we can show except the original hunk header, even if we
had to adjust the line range and the original hunk header might get that
wrong".

In preparation for teaching the built-in interactive `add` to be a bit
more lenient, let's change the 'detect bogus diffFilter output' test
case so that it verifies that a mismatched number of lines causes the
command to error out, but not an unparseable hunk header.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3b7df9bed5a..88d8133f38f 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -761,7 +761,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	git reset --hard &&
 
 	echo content >test &&
-	test_config interactive.diffFilter "sed 1d" &&
+	test_config interactive.diffFilter "sed q" &&
 	printf y >y &&
 	force_color test_must_fail git add -p <y
 '
-- 
gitgitgadget

