Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483AAC433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 01:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiEKBru (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 21:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiEKBrp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 21:47:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF73FB7C9
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:47:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p189so337034wmp.3
        for <git@vger.kernel.org>; Tue, 10 May 2022 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1sKa3vnsehTwBo+B3VB+gR17FLImq6uo4R52FY4QKyA=;
        b=nR4TbKdRS5ye+eBT2pGgqjqvSCWn4E29AWoBteauypTaQi/Pnx1O4lCnmIkuwOgflD
         GnA4JO5A2/TeLl3j6PwxpZkvlNtLbsw2kdfofRO3ihe5KcBmSdZjaBigJvItrx7GgY7W
         JfXFz1jQ/J7jMzhG267YeTxEEIwBxs8WfW5dcv+D0zZ0yzaj9Ub74GJGP9d98Zh+v1+z
         uuT4KA4n3xnv6TITDBhi/4vVJgYGCWMgTk+chElDiA8R/GP//3YPQZSAqLhsy/1e2P+R
         Q85OJEww1Av+wg5VdTE8HuqD45ZEc8lHN7BZKfgUalWl1oL9jWduP86F44By6Z4UgbgV
         EHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1sKa3vnsehTwBo+B3VB+gR17FLImq6uo4R52FY4QKyA=;
        b=F5OCF6Vt9POoGBBdooDSPrgzX7GiWabXalF2EjWauCOm3a+GRop0oK5PEsDcs2ynb/
         wtgLQbEgECIgQ+xy7B+gVeR7Z95dNUfpQAk+he45h5H5atMYNeZ1qweQ6IlGDg9Q9Nl0
         dYbjoAhuXdvmjLQlwVyTd1pccCkGdTmwqCOb5ZP/eAapF418f1RekhspfgjAJWmaAyYu
         o+tKUYA8XdBnwtBlJk2U03/H5oAmJx2l/4i06tF1lsZag/iuxbwAtlBSwpuMZqm93k4l
         Micq/JORBk+OhmXgvQgdFBA5ETNgMloNX+vpMMWb6yQAViE0uQil598CVCtNs9Jwbmsw
         QDlA==
X-Gm-Message-State: AOAM530igQpxLmejwV9XXIfyjgqKsnV6ty3xEHufKF6niGCU4VTlxxWz
        NO7BMmssuQEahFE3i4GMKWvcwWKoFaA=
X-Google-Smtp-Source: ABdhPJx9Mqw95IQX2woZLSZlFujiSi0VQs9ID9fuC5aVqwoeRUXeGaW8m1EfJWqw/lh6nwFFWXhLxg==
X-Received: by 2002:a7b:c086:0:b0:393:f6fa:cfc7 with SMTP id r6-20020a7bc086000000b00393f6facfc7mr2486147wmh.62.1652233661145;
        Tue, 10 May 2022 18:47:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4e02000000b0020c5253d922sm316568wrt.110.2022.05.10.18.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:47:40 -0700 (PDT)
Message-Id: <9552d80a80d9574c8f256696fad06f48b39b51c9.1652233654.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 May 2022 01:47:31 +0000
Subject: [PATCH v2 2/5] MyFirstContribution: add standalone section on cover
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
 Documentation/MyFirstContribution.txt | 39 ++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 22848f84bec..de62a61771c 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -764,6 +764,43 @@ We can note a few things:
   v3]", etc. and sent with a new cover letter, itself a reply to the cover
   letter of the previous iteration (more on that below).
 
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
+should be in your commit messages, not in your cover letter.
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
+
 At this point the tutorial diverges, in order to demonstrate two
 different methods of formatting your patchset and getting it reviewed.
 
@@ -1000,7 +1037,7 @@ but want reviewers to look at what they have so far. You can add this flag with
 Check and make sure that your patches and cover letter template exist in the
 directory you specified - you're nearly ready to send out your review!
 
-[[cover-letter]]
+[[preparing-cover-letter]]
 === Preparing Email
 
 In addition to an email per patch, the Git community also expects your patches
-- 
gitgitgadget

