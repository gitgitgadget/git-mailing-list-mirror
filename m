Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE6AC433FE
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359622AbiELXoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359595AbiELXnq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:43:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F4289BE0
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so9235566wrh.11
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hL6JSLdjVbdVjD5T2UlHRtSJRkuLVyPAPM4zlPDnOU8=;
        b=Qy1KK7CpC1JrQFinywOg1Agz77DzEOut6PiE8+iDYaBofWwWG8j3/1p2xuCZfBOTIo
         7JAyZHAKGIZ3uNQ1NBUnEBw/x5Yi3Q8i1DWQCEdM1XXt3XHIyEVbjzgTg1AVhby23AfR
         pqtbgfGuZ0fv5Z51LfMqmAyHNP1NlRxGfyhhyiHlRfHhf6bhtrQTRkV+pCZAkuhYAed+
         RJZ8qryQO0PBlXwFNT4MI2XXJhVTaFbUv5wlQ53QSxgZPPSh+3bgFkc5RGerakSoiouN
         P8Raju2A56TE0YeIiaO5IZztmnI0PYa6qkqX+uxgjhaTZiTYn2RDSdAmahH7PFD8RNQd
         ci1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hL6JSLdjVbdVjD5T2UlHRtSJRkuLVyPAPM4zlPDnOU8=;
        b=7yl5I/HvaVMX1QR5dbX7N4O+8CHPyGTNAsfYqx8GaBBW/hz7wO5ioBKGkOya8lsIIz
         mfTPMsWw5L9W3LSbKzHgqYC2eU/qEefVMDThsgbEtHjesXB4xGjvW9JV52bJoJBlA/N7
         5iOG6DxWOy39DHlec9z1mbT9ZUTd6ANPGRvc+EztErtbkTIbqS+vaLbWzouhKWGWZb6H
         9jq0efoeJjhCAM/xoRuJ6pKN451l7/3kO16co3jf2RxeX2JuZevwR2RGjGt7K574yeF8
         v5byl9m5C7hZxLTje8BkZIEznGRvh11r7F3Nx5WCw9l0TL0IjdjJE5L/XC9flW5/GuUn
         iqSQ==
X-Gm-Message-State: AOAM530NP8GImdoy7j6P0/VrxYQCzyVBCkKRCr5LNSSErBmzlu+yjhaw
        vMBBWL2fZz4yIflZnKUpf29UsCt+Z3o=
X-Google-Smtp-Source: ABdhPJy/JmK4c/mITGdNO9bnU6OYwF7qIH1k1pXGu4RcGn4AgK0wX3rnyYGSJPQao3HMWu7j9Nkhmw==
X-Received: by 2002:a5d:47cc:0:b0:20c:6b7c:8a19 with SMTP id o12-20020a5d47cc000000b0020c6b7c8a19mr1552009wrc.608.1652399020952;
        Thu, 12 May 2022 16:43:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020adfc789000000b0020cd8f1d25csm753195wrg.8.2022.05.12.16.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:43:40 -0700 (PDT)
Message-Id: <ee3238f5a9169f0c7d046089c7951791b8db3cab.1652399017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 May 2022 23:43:34 +0000
Subject: [PATCH v3 2/5] MyFirstContribution: add standalone section on cover
 letter
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

An explanation of the purpose of the cover letter is included in the
"Sending Patches with git send-email" / "Preparing Email" section but is
missing from the "Sending Patches via GitGitGadget" section.

Add a standalone section "The cover letter" under the "Getting Started:
Anatomy of a Patch Series" header to explain what the cover letter is
used for and to draft the cover letter of the 'psuh' topic used in the
tutorial.

For now we mostly copy content from the "Sending Patches with git
send-email" section but do not adjust that section, nor the GGG section,
to reference the new section. This is done in following commits.

Also, adjust the "Preparing Email" Asciidoc anchor to avoid conflicts.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/MyFirstContribution.txt | 51 ++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 22848f84bec..94f722d4b7f 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -760,9 +760,52 @@ We can note a few things:
   _n_-commit series.
 - Each patch is sent as a reply to an introductory email called the _cover
   letter_ of the series, prefixed "[PATCH 0/_n_]".
-- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
-  v3]", etc. and sent with a new cover letter, itself a reply to the cover
-  letter of the previous iteration (more on that below).
+- Subsequent iterations of the patch series are labelled "PATCH v2", "PATCH
+  v3", etc. in place of "PATCH". For example, "[PATCH v2 1/3]" would be the first of
+  three patches in the second iteration. Each iteration is sent with a new cover
+  letter (like "[PATCH v2 0/3]" above), itself a reply to the cover letter of the
+  previous iteration (more on that below).
+
+NOTE: A single-patch topic is sent with "[PATCH]", "[PATCH v2]", etc. without
+_i_/_n_ numbering (in the above thread overview, no single-patch topic appears,
+though).
+
+[[cover-letter]]
+=== The cover letter
+
+In addition to an email per patch, the Git community also expects your patches
+to come with a cover letter. This is an important component of change
+submission as it explains to the community from a high level what you're trying
+to do, and why, in a way that's more apparent than just looking at your
+patches.
+
+The title of your cover letter should be something which succinctly covers the
+purpose of your entire topic branch. It's often in the imperative mood, just
+like our commit message titles. Here is how we'll title our series:
+
+---
+Add the 'psuh' command
+---
+
+The body of the cover letter is used to give additional context to reviewers.
+Be sure to explain anything your patches don't make clear on their own, but
+remember that since the cover letter is not recorded in the commit history,
+anything that might be useful to future readers of the repository's history
+should also be in your commit messages.
+
+Here's an example body for `psuh`:
+
+----
+Our internal metrics indicate widespread interest in the command
+git-psuh - that is, many users are trying to use it, but finding it is
+unavailable, using some unknown workaround instead.
+
+The following handful of patches add the psuh command and implement some
+handy features on top of it.
+
+This patchset is part of the MyFirstContribution tutorial and should not
+be merged.
+----
 
 At this point the tutorial diverges, in order to demonstrate two
 different methods of formatting your patchset and getting it reviewed.
@@ -1000,7 +1043,7 @@ but want reviewers to look at what they have so far. You can add this flag with
 Check and make sure that your patches and cover letter template exist in the
 directory you specified - you're nearly ready to send out your review!
 
-[[cover-letter]]
+[[preparing-cover-letter]]
 === Preparing Email
 
 In addition to an email per patch, the Git community also expects your patches
-- 
gitgitgadget

