Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6544C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359594AbiELXnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359603AbiELXnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:43:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4B289BF1
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d5so9273223wrb.6
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=omZd82WqRODSZdAJWA5SF/bc9gSX6LVfdB5B/V4bIXw=;
        b=AZXDgGuP1gd0IzKHKlizcyGJo3yBMHh/jSb1AEVIkkGFt+e2S09gd91Idf8K6Xsp0d
         3R5kuRX6EjqRwyrFn5APxY9+hqI9+b56A8lg1jYtsMyI21L1jK0M5/3Oz3aIVrSvI2BL
         Kc8ra90xO+EvJNYt38QBlZb6PNK7ZLdOXSwC9kY5xzDiap8P+z5VVGSYdXitx9nyPKcD
         C83oy7vjqchffM0ySiYRCiYOU5cXDIemCjD7cvKqhrV946FiRWys49O5nJZF3gtbUnmW
         XD2fTSLXWz3wlmobrxT3/gQz9jlc4lONAisD2btdnDk+VzZD7HIELHjYgifBSEbJpFiC
         YCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=omZd82WqRODSZdAJWA5SF/bc9gSX6LVfdB5B/V4bIXw=;
        b=aHG02mnZi61h2XSY4Fsjatz0SlSLdn6plGT7k49mjmz3iejFD9+wXdo03IkBM1sJoY
         ZpnOImCrZWluGRX1cbukBxQLwSITnMcEZ2A0aDor/6EeHFa3oKm+e1JgKUYO/RX/6cTS
         CUywl0WNwJLGah6pAQYbz/l70VvLM3wGpPAq2+0mnCoKYikQeEfJStbh7mA8+wSrCePS
         xkDAD3YZUiFk9ZLDTgq576iocRwiWsybHqNZYAA6zP4GDTSxWCEKJMUPOsmBSd5kZ+PE
         kJGjEv2K7qWWkYMo0AMUnHkR+Lu0w7HQgj5WL1mxN2wyoDNL/jtv6mj3pu/QiGwPJ6Uz
         vE8Q==
X-Gm-Message-State: AOAM5301zOy90O+7Rlc0hckyIWo6MgOjUA0PcjoSBced5cqgqurjaA0y
        ZS+DQRJTXtTGv+++mNUrgciczNZwmlc=
X-Google-Smtp-Source: ABdhPJyvG81jHgovpb+7YLeuHutpZ8VAURAJ6nzm6dbuOqVDssPVcIX1ll5KZ0EoWPI5dRvu71Or6Q==
X-Received: by 2002:a05:6000:1786:b0:20c:6063:5014 with SMTP id e6-20020a056000178600b0020c60635014mr1620090wrg.251.1652399021994;
        Thu, 12 May 2022 16:43:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az31-20020a05600c601f00b003944821105esm881969wmb.2.2022.05.12.16.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:43:41 -0700 (PDT)
Message-Id: <2caec6e619a89e9e10399da0feb04fa0a21b15a4.1652399017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 May 2022 23:43:35 +0000
Subject: [PATCH v3 3/5] MyFirstContribution: reference "The cover letter" in
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
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
index 94f722d4b7f..f6ee5b8b1ae 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1046,46 +1046,26 @@ directory you specified - you're nearly ready to send out your review!
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

