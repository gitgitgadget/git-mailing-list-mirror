Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B21C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347145AbiEUWTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347136AbiEUWTI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA804F463
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so15875590wrg.12
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=36a1hEOLEFfVby9NbcdamW6LtrVu56U3T7qljbJfkeM=;
        b=LTlfXAt00EirEDjyjOrPZ9axT3ypjzrHUPC8pmIIa91t0YAASnNhMB5OTKlSDh3cU6
         zbOxhQpQ0V9YAEOjfDnFPOzeVuWyUiHyefWTcD8BHmB6ARLAcdPfgWLwtkmmNno8s3X4
         JwZ+n8SaNzo4W7dh1K6PDe9MQBXadXtvvhmWzSr9Y2U2r/UYH8N3FZEdimGTYJf/Ut6d
         iMlIhPeH7Rr+rvwurb5Pl54L7XKuMpXyYkddj9cUVhrSVBUMQuckA0IuXkCk03zH0ito
         +vGhrQpeVLR7ACoV8fMOGuW9rkPf3JZ/oG4FbTQVDADmyC3izOs8T7x1iGiGwbIbll1K
         Unrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=36a1hEOLEFfVby9NbcdamW6LtrVu56U3T7qljbJfkeM=;
        b=QZFBtQCQI/HiBR+C8Yhi3kbwtzGrXJykNBvifwdEThdkeCg5FwqHTc3wQjdxCZin5n
         4+l1VRPTdtamePionCR+vfF5iJxECsqBLCN1OY6FBzEXPFTl8GYqS+yFU7nY71pObM4F
         jqLw6wGU+nnxwIwOBRMrhZ7JmYv23munrLwxGcaCX+NNXg/JzihwtfozhE1X6nJLfyeF
         kfSasWQ2aIY3xloAISUb+qWst5vmY0Xk5AskXsJRWd8InKxjVoaXOFENmYSOoIhNbwop
         tFu1hLdMeeu7DKk5aaW7VnsJCeJXkXmapxofTHhqS/TsEBkyKJN1yPH4j4Z9iiuEw5Gd
         FvJw==
X-Gm-Message-State: AOAM531ug7xRfJbFGv0G99pUo7rXRm5YpGoRNohhY8SGHSnEJ+gB2Cs2
        63tbANsNL/rO8ZgVeuz7KvaSn8WtP08=
X-Google-Smtp-Source: ABdhPJwXc4frFhvtokmNra9IIXc4HeSuIZ+fx26WNj0Z8putzvVKE5E41w9lyqmSPgUZlTaleJallQ==
X-Received: by 2002:adf:dd81:0:b0:20e:5853:1762 with SMTP id x1-20020adfdd81000000b0020e58531762mr13469628wrl.447.1653171546926;
        Sat, 21 May 2022 15:19:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b0039466988f6csm5179606wmb.31.2022.05.21.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:06 -0700 (PDT)
Message-Id: <d3db5252fb8601f59c48fcac0120e1e2bcc33e03.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:52 +0000
Subject: [PATCH v3 08/12] ci(github): skip the logs of the successful test
 cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In most instances, looking at the log of failed test cases is enough to
identify the problem.

In some (rare?) instances, a previous test case that was marked as
successful actually has information pertaining to a later test case that
fails.

To allow the page to load relatively quickly, let's only show the logs
of the failed test cases to be shown. The full logs are available for
download as artifacts, should a deeper investigation become necessary.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-github-workflow-markup.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index d8dc969df4a..1ef0fd5ba87 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -40,6 +40,10 @@ finalize_test_case_output () {
 	fixed)
 		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
 		;;
+	ok)
+		# Exit without printing the "ok" tests
+		return
+		;;
 	esac
 	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
 	test-tool >>$github_markup_output path-utils skip-n-bytes \
-- 
gitgitgadget

