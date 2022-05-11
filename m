Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF5C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 01:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbiEKBsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 21:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240637AbiEKBrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 21:47:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6625E2
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:47:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k2so906742wrd.5
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zOv2Y4JSjAQ+XIqTP8yGgN/I5/3fvybJEvtQtlez+lQ=;
        b=Kk/9kswKfxJEi5Wj4soWR6UjggZO4k7kIv64yTg0LRJAm8kuiJ0nPRemNrofOuloGc
         gsoAArZtQ4rXUosnmzf0mlIzAAkvzfMGae7s/kUkFuJN74Ml6ZNeX/RUojd8d0C0a+Sy
         xAU2IFqDe+C2m3oQn0DbXSJ+g3dVnE2f0td8QEwbFx1B2Hgqbhf+T9DcUJOjyufLPMB9
         kNEZsl3qmZewH/dsds4yRHaj6wHuJzTJb2JuBNkxD329z4aq8B+IoEtoKpYPSfdL+vnR
         KBcTn1tPf1a+lCT8StiWYa8LkZIGgpNwV8ar0/fIs/3SI++vXW+3N9Yypjzgb/JD/GkH
         T5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zOv2Y4JSjAQ+XIqTP8yGgN/I5/3fvybJEvtQtlez+lQ=;
        b=JYKNVFMjRkDeIIUBhxx/u8q3t0X2pgicLusHAZPhOCbrp5NMjsST/6JtQQdyhI5aj6
         P8FmsPN//3yjEaCr3SK9coq0EWlDmOEpb1NZIiRzpsyFFb3yxuBVkdf4jhBbc3npKC90
         7LMS/EO6ifz3UmvrsErxglbSH1glG0jBcHHy33EX699roOYSztzVdrQ20o8/TSgG1olT
         ypWMZtG3JiyrCYJEyc1Ww1IqriSj59rc8yYoUrgTcGFaA/XXGGqGYdZyivfU6SbRZqYT
         Cpp4E7+ioEJ4XXrrFszkG9Hf8okoAqpoqOy3vzPyrWdk+eADkW1vxqZ2jznBzrvcJrPX
         0cPw==
X-Gm-Message-State: AOAM532pOxI/lKUphKlMKRas1QvHd9mZOf2dbgdEF1gMW5d9VUI2BgU2
        MuD0ierlsN0IFXCGN8gRSUSR10sZ77g=
X-Google-Smtp-Source: ABdhPJxE2C6AVipwgsC2/NvSJaTUgFqiNJinCGn68PCbTulNm3mt5/v/57l0rqi38+Vz28YZyF+0BQ==
X-Received: by 2002:a5d:6792:0:b0:20a:d352:10de with SMTP id v18-20020a5d6792000000b0020ad35210demr21070700wru.326.1652233662943;
        Tue, 10 May 2022 18:47:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c4e5200b003958af7d0c8sm658702wmq.45.2022.05.10.18.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:47:41 -0700 (PDT)
Message-Id: <d7699289ea61f71aa869e491c7a35d067dc57115.1652233654.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 May 2022 01:47:32 +0000
Subject: [PATCH v2 3/5] MyFirstContribution: reference "The cover letter" in
 "Preparing Email"
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

The previous commit added a standalone section on the purpose of the
cover letter, drawing inspiration from the existing content of the
"Preparing Email" section.

Adjust "Preparing Email" to reference "The cover letter", to avoid
content duplication.

Also, use the imperative mode for the cover letter subject, as is done
in "The cover letter".

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 38 +++++++--------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index de62a61771c..078b96d674a 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1040,46 +1040,26 @@ directory you specified - you're nearly ready to send out your review!
 [[preparing-cover-letter]]
 === Preparing Email
 
-In addition to an email per patch, the Git community also expects your patches
-to come with a cover letter, typically with a subject line [PATCH 0/x] (where
-x is the number of patches you're sending). Since you invoked `format-patch`
-with `--cover-letter`, you've already got a template ready. Open it up in your
-favorite editor.
+Since you invoked `format-patch` with `--cover-letter`, you've already got a
+cover letter template ready. Open it up in your favorite editor.
 
 You should see a number of headers present already. Check that your `From:`
-header is correct. Then modify your `Subject:` to something which succinctly
-covers the purpose of your entire topic branch, for example:
+header is correct. Then modify your `Subject:` (see <<cover-letter,above>> for
+how to choose good title for your patch series):
 
 ----
-Subject: [PATCH 0/7] adding the 'psuh' command
+Subject: [PATCH 0/7] Add the 'psuh' command
 ----
 
 Make sure you retain the ``[PATCH 0/X]'' part; that's what indicates to the Git
-community that this email is the beginning of a review, and many reviewers
-filter their email for this type of flag.
+community that this email is the beginning of a patch series, and many
+reviewers filter their email for this type of flag.
 
 You'll need to add some extra parameters when you invoke `git send-email` to add
 the cover letter.
 
-Next you'll have to fill out the body of your cover letter. This is an important
-component of change submission as it explains to the community from a high level
-what you're trying to do, and why, in a way that's more apparent than just
-looking at your diff. Be sure to explain anything your diff doesn't make clear
-on its own.
-
-Here's an example body for `psuh`:
-
-----
-Our internal metrics indicate widespread interest in the command
-git-psuh - that is, many users are trying to use it, but finding it is
-unavailable, using some unknown workaround instead.
-
-The following handful of patches add the psuh command and implement some
-handy features on top of it.
-
-This patchset is part of the MyFirstContribution tutorial and should not
-be merged.
-----
+Next you'll have to fill out the body of your cover letter. Again, see
+<<cover-letter,above>> for what content to include.
 
 The template created by `git format-patch --cover-letter` includes a diffstat.
 This gives reviewers a summary of what they're in for when reviewing your topic.
-- 
gitgitgadget

