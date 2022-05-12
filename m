Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B6C43217
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359617AbiELXn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359604AbiELXnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:43:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C6289BFF
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 129so3909676wmz.0
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eJhSanNTrvwh73K6ul8u5rLauB4yVfCuB5NCOfi1PhE=;
        b=oQH1i16nWhsiWLP3qbER5hZpkF3wkIwh679YuaHYua9NH7Q0YszEXA346eMi0p03SO
         XeLO+vimm6hl1ug3wWnlSwFcf/llbIr7t+6ZXieCuejh9NBdn/DZwm5JiBbc7y+Y2k/t
         SThUUQGcf6pRDm1ciB80jgHbQ1F2fe9ZZB+JfBQ/UK8rd9kBIziAkLxlSTSrzTmhZcFe
         AXydGSUWR++FvybLpdDsNhlY/id+9nZFLYr+gC5/5+IBpxxjFG0fXUpO9YX4CJhckm+v
         FcoWUAp2L1TsCZiZ02zzKUbsIJZJJISWveS/h/IzoW8e/WhFJ1OqFBl9UQ6zxW+urEWp
         dKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eJhSanNTrvwh73K6ul8u5rLauB4yVfCuB5NCOfi1PhE=;
        b=scN8p+yfkmBLY/iUnESSJtI3QUZNBPxvwf9Va4NrlrQJ3QCrKj3lYpYAKFMfB/JdZh
         kv3MGJHIGAcI+ifwTw1Osz9+NBFv5GONIUNoDP9HX5tBYB76lTeHlWU9p8EnaNoE3cXe
         PCFSnLb/iiaNOaUf/3dlUsvuVZHl9wkySm8LYpZuG79le3HVkTxbj41vW9S4eeRkoRSY
         OGMWndb2b9X8DBEgGDEc3G3JATj3ANWKqQ8tIhbmhyqrdzVangK2z8AlO7oaT//Slro0
         nPuqsH7pdmxX8qwGuhkA8GV8z/7SzDV6b9Lxungo7jyC9ZaNtc2lbCZbvlaQ9D8k5A8l
         svzg==
X-Gm-Message-State: AOAM530orCnxhsYYbde4ULinnNCmBRYDvZnLAdnym7f3bFI+/TUgPW0H
        6kqjO6efiSKLATnLdFq/oNDKcSkvHG0=
X-Google-Smtp-Source: ABdhPJwcWHeXhroPS8jJATNj+nj/psfaCiJhdirpt61Q2poVz/n2upMg602uvzDVU+N1Mhr+TPC+pw==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr12457140wmk.77.1652399023151;
        Thu, 12 May 2022 16:43:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c348400b003942a244ec4sm861965wmq.9.2022.05.12.16.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:43:42 -0700 (PDT)
Message-Id: <02598d431e0eb4f7cad9b7703c2fb244c3d15781.1652399017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 May 2022 23:43:36 +0000
Subject: [PATCH v3 4/5] MyFirstContribution: reference "The cover letter" in
 GitGitGadget section
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The "Sending Patches via GitGitGadget" section mentions that the PR
title and description will be used as the cover letter, but does not
explain what is a cover letter or what should be included in it.

Refer readers to the new "The cover letter" section added in a previous
commit.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f6ee5b8b1ae..9eb2dfec959 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -899,8 +899,12 @@ https://github.com/gitgitgadget/git and open a PR either with the "New pull
 request" button or the convenient "Compare & pull request" button that may
 appear with the name of your newly pushed branch.
 
-Review the PR's title and description, as it's used by GitGitGadget as the cover
-letter for your change. When you're happy, submit your pull request.
+Review the PR's title and description, as they're used by GitGitGadget
+respectively as the subject and body of the cover letter for your change. Refer
+to <<cover-letter,"The cover letter">> above for advice on how to title your
+submission and what content to include in the description.
+
+When you're happy, submit your pull request.
 
 [[run-ci-ggg]]
 === Running CI and Getting Ready to Send
-- 
gitgitgadget

