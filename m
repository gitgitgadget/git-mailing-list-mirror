Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E1C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359597AbiELXnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359596AbiELXnq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:43:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFC289BD6
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f2so2251829wrc.0
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7vkdic47aCI4KAByIy33HpQVJzKc8wog5ekF2uIKc1U=;
        b=B02hhJ+DIIN3W7Lil8FGBtfUqz5Zpaqs+7HSK8Gt1bQPyYvaBZdSBJIjLILfnCtckX
         uJiN3VA24D2CqcPYxbbEBrMN5oFeBD86rsmtLL4gloyTuvqYfAckHH7y9oV+S9s1W40d
         ebbgVfhzvLPuLoDRAnBPfciXylBdkwo36N248nAKFdyKYGaom3n9foMSd3kHIpRBvsYs
         9QjibwkqF6n7hHjyW9T0FaKO6lw0q228HDmfjQWt6qBckZc14xA9nD1+uyW1nddZ8pE2
         4xMCMASzn7afJhHgCAbo7OIJ3pf95e5Z8kVGaR3enKPSmx0Vkc2dFbEM99d6LZ9etfJb
         eXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7vkdic47aCI4KAByIy33HpQVJzKc8wog5ekF2uIKc1U=;
        b=KaGrsQMElIhuhu6uUKAIqOjUolHMxRdiNlY0yIPzD2mdATIfk4gZ/y5iwBPuTQ1SA4
         ebrV4qV/3/sM9ulcLXbC8aZ99J6XDBdYeDFOcYjiGCdzPg8rbKWl3Jiagozm0FimSoeD
         wIAvo62fXzdwUDtB/fE+kaYK7CXoFpVm6VkSGvoiTZVLekCCyQLVW8btNUsaYb1+o0oD
         eAA5eJgIMzYA4Rw7PSCgeI0u8sBRL91dJcYqs1vDgf+V3XRz8Tug/hcumjUoOmRLk26o
         3l4pBUNCVuvryAsh9zfKkliPGHJpfHPxnl22UqKwn3mY3+ybFhbo4dzHybH4N0MheZ8C
         dpcg==
X-Gm-Message-State: AOAM530BcAF0scl7P8S6opjwtZRzpfoghZvJdZcILaajBYJw32eBP/fM
        PePO2iOqymZWY8ce04rx2X1BasaUa08=
X-Google-Smtp-Source: ABdhPJyv00HkHMwlxfeKRhWTZb1O4PBHU8Bdr2qdzL2qa5jzbV/D2vmnuYr8OltVibzjBbfbjzbzqQ==
X-Received: by 2002:a5d:4052:0:b0:20a:d8b9:9d4b with SMTP id w18-20020a5d4052000000b0020ad8b99d4bmr1600358wrp.612.1652399019730;
        Thu, 12 May 2022 16:43:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020adfaa02000000b0020cd0762f37sm638460wrd.107.2022.05.12.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:43:39 -0700 (PDT)
Message-Id: <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652399017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 May 2022 23:43:33 +0000
Subject: [PATCH v3 1/5] MyFirstContribution: add "Anatomy of a Patch Series"
 section
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

Before describing how to send patches to the mailing list either with
GitGitGadget or 'git send-email', the MyFirstContribution tutorial
includes a small "Getting Ready to Share" section where the two
different methods are briefly introduced.

Use this section to also describe what a patch series looks like once
submitted, so that readers get an understanding of the end result before
diving into how to accomplish that end result.

Start by copying the "thread overview" section of a recent contribution
from the public-inbox web UI and explaining how each commit is a
separate mail, and point out the cover letter.

Subsequent commits will move the existing description of the purpose of
the cover letter from the 'git send-email' section to this "anatomy"
section.

Also, change the wording in the introductory paragraph to use
"contributions" instead of "patches", since this makes more sense when
talking about GitHub pull requests.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 54 +++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 63a2ef54493..22848f84bec 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -710,13 +710,61 @@ dependencies. `prove` also makes the output nicer.
 Go ahead and commit this change, as well.
 
 [[ready-to-share]]
-== Getting Ready to Share
+== Getting Ready to Share: Anatomy of a Patch Series
 
 You may have noticed already that the Git project performs its code reviews via
 emailed patches, which are then applied by the maintainer when they are ready
-and approved by the community. The Git project does not accept patches from
+and approved by the community. The Git project does not accept contributions from
 pull requests, and the patches emailed for review need to be formatted a
-specific way. At this point the tutorial diverges, in order to demonstrate two
+specific way.
+
+:patch-series: https://lore.kernel.org/git/pull.1218.git.git.1645209647.gitgitgadget@gmail.com/
+:lore: https://lore.kernel.org/git/
+
+Before taking a look at how to convert your commits into emailed patches,
+let's analyze what the end result, a "patch series", looks like. Here is an
+{patch-series}[example] of the summary view for a patch series on the web interface of
+the {lore}[Git mailing list archive]:
+
+----
+2022-02-18 18:40 [PATCH 0/3] libify reflog John Cai via GitGitGadget
+2022-02-18 18:40 ` [PATCH 1/3] reflog: libify delete reflog function and helpers John Cai via GitGitGadget
+2022-02-18 19:10   ` Ævar Arnfjörð Bjarmason [this message]
+2022-02-18 19:39     ` Taylor Blau
+2022-02-18 19:48       ` Ævar Arnfjörð Bjarmason
+2022-02-18 19:35   ` Taylor Blau
+2022-02-21  1:43     ` John Cai
+2022-02-21  1:50       ` Taylor Blau
+2022-02-23 19:50         ` John Cai
+2022-02-18 20:00   ` // other replies ellided
+2022-02-18 18:40 ` [PATCH 2/3] reflog: call reflog_delete from reflog.c John Cai via GitGitGadget
+2022-02-18 19:15   ` Ævar Arnfjörð Bjarmason
+2022-02-18 20:26     ` Junio C Hamano
+2022-02-18 18:40 ` [PATCH 3/3] stash: call reflog_delete from reflog.c John Cai via GitGitGadget
+2022-02-18 19:20   ` Ævar Arnfjörð Bjarmason
+2022-02-19  0:21     ` Taylor Blau
+2022-02-22  2:36     ` John Cai
+2022-02-22 10:51       ` Ævar Arnfjörð Bjarmason
+2022-02-18 19:29 ` [PATCH 0/3] libify reflog Ævar Arnfjörð Bjarmason
+2022-02-22 18:30 ` [PATCH v2 0/3] libify reflog John Cai via GitGitGadget
+2022-02-22 18:30   ` [PATCH v2 1/3] stash: add test to ensure reflog --rewrite --updatref behavior John Cai via GitGitGadget
+2022-02-23  8:54     ` Ævar Arnfjörð Bjarmason
+2022-02-23 21:27       ` Junio C Hamano
+// continued
+----
+
+We can note a few things:
+
+- Each commit is sent as a separate email, with the commit message title as
+  subject, prefixed with "[PATCH _i_/_n_]" for the _i_-th commit of an
+  _n_-commit series.
+- Each patch is sent as a reply to an introductory email called the _cover
+  letter_ of the series, prefixed "[PATCH 0/_n_]".
+- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
+  v3]", etc. and sent with a new cover letter, itself a reply to the cover
+  letter of the previous iteration (more on that below).
+
+At this point the tutorial diverges, in order to demonstrate two
 different methods of formatting your patchset and getting it reviewed.
 
 The first method to be covered is GitGitGadget, which is useful for those
-- 
gitgitgadget

