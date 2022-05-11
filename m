Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60853C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 01:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiEKBsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 21:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbiEKBrt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 21:47:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D56A1DA7F
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:47:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso2336765wma.0
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KMXOk1tvSHhYsPdV9+MPOTx+EM/dzssS8wUUh7sT8ew=;
        b=ZPiREeRZJRm/eY9k7aGe0U7KNwB0MyArtBWabiKww3odWv9rbyQ5rGSOImoIP0EHN5
         AzpXGyH0VW+Yni/YCA69pF8Pz+auvO2wMvZBMePqYxKC0tfOXLMP9XiTvcsY8NwWytqL
         sz2L5RzrkEkjnrSr3kAsMm8QYl5OmlKdJ1e+ECsrmD5fG8OY+tZBF5pZAcYCncX6l9lR
         Vmff/q7OFK4Mbra9gipLuPBZWCS66V4+J3KnYy/VDMG0CsgXaPogx3Iyf9Lq+RcfZlzP
         pih/aBXhuE9OEGyohnRmXE0x1Ccf0hH+2q4OGrhlI9GF7Y7TelJbs0BLF2/dLLf5RLKk
         BvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KMXOk1tvSHhYsPdV9+MPOTx+EM/dzssS8wUUh7sT8ew=;
        b=AABzh5yfDhEnpWfSNiLzG2ZlMK2+yp7lYjEku3iE0mB0MMXSuIehLCNNCdN91u8U2h
         CQ7gPJo07LUwhfr/TCrcSQ9UR0O+AWjgCd8GSTpvwibxsl4H9vA/hA1aoKay1NDmMWms
         5liEkKtxybiCs2XG2mE56TrMAipLktpkwql047C+umLTTA/R5WaLE0xJffHk2Lrg6sVZ
         YNGyhuJJWmatp8KN819mM8rH5LqGoZc5qvAQlGfOpZJHr7fKlraKGz8p1r8WSZURbUX7
         BSJ9/x03Y0kXINXXseCsZR+qpY1npfw2iR4ANBZGGyV1oaiXIPeV5P7gb8Ztk1/gciUp
         L+KA==
X-Gm-Message-State: AOAM533iRPaQ+VyIn0bDO00Z4le/TqW2x4KT23lM8JPOnVQBEjKZUGs+
        wPbu64p69fXM1iq4AJkHlhxFkp2v2u4=
X-Google-Smtp-Source: ABdhPJwp0HBmO2TSUL7fGChrjn7JS52zOJ+tcPjy32+6kbdje4I0cVtn1XgZSXhTvcudBmWpXlBG6g==
X-Received: by 2002:a05:600c:21c8:b0:394:7796:49c0 with SMTP id x8-20020a05600c21c800b00394779649c0mr2453587wmj.191.1652233666642;
        Tue, 10 May 2022 18:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c349300b003942a244f2bsm4222648wmq.4.2022.05.10.18.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:47:45 -0700 (PDT)
Message-Id: <33256c6b4bafe2a3993338a7499dfec52a02a9a0.1652233654.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 May 2022 01:47:34 +0000
Subject: [PATCH v2 5/5] MyFirstContribution: drop PR description for GGG
 single-patch contributions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

By default, GitHub prefills the PR description using the commit message
for single-commit PRs. This results in a duplicate commit message below
the three-dash line if the contributor does not empty out the PR
description before submitting, which adds noise for reviewers.

Add a note to that effect in MyFirstContribution.txt.

This partly addresses:
https://github.com/gitgitgadget/gitgitgadget/issues/340

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 728dc437854..01b9e5db117 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -898,6 +898,16 @@ respectively as the subject and body of the cover letter for your change. Refer
 to <<cover-letter,"The cover letter">> above for advice on how to title your
 submission and what content to include in the description.
 
+NOTE: For single-patch contributions, your commit message should already be
+meaningful and explain at a high level the purpose (what is happening and why)
+of your patch, so you usually do not need any additional context. In that case,
+remove the PR description that GitHub automatically generates from your commit
+message (your PR description should be empty). If you do need to supply even
+more context, you can do so in that space and it will be appended to the email
+that GitGitGadget will send, between the three-dash line and the diffstat
+(see <<single-patch,Bonus Chapter: One-Patch Changes>> for how this looks once
+submitted).
+
 When you're happy, submit your pull request.
 
 [[run-ci-ggg]]
-- 
gitgitgadget
