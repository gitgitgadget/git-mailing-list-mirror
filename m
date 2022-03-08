Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B36C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbiCHHlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbiCHHkx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441683DDEC
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:39:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so26967630wrg.11
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PcEhBMfiRsbLFIkiYM4ha4Qn6/cpSDgGqF0zPHthGdk=;
        b=WU5OGn1O1VMyF4Jnoy4We2+mbvrdeHY88ClIT6vXP3aS9dVZKwkbUAZ358gN0napDJ
         RuhjfwA0EMdrmn1Y7I0DaM19oKXDQXyxY+Nvu0rjTvy6qQL4TuiCUX3ZHDi/AowPOmUO
         eS6tw7NwshiPgiaKuj5X40mkfGqYJTKOMpYIU57vzPFo74BXIQgtw5Ap+AzqthJMbycH
         /X/5fZiBQyrBD6Jo9QgouPU3EcSTSnLApjsE+eZmGsbrexEBVJvKD/yzsI7hwO9TMKW1
         BJnTrK4yn3N5c59mp+nRmybeC40zT9WFr5QRFqOOqgtfIONlo7TTm/DFNHJoqnlnTnMw
         7Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PcEhBMfiRsbLFIkiYM4ha4Qn6/cpSDgGqF0zPHthGdk=;
        b=IQ2kJ3IR11mTJAJq6UHAXcov4LLnMS1+8OYK5sogiVY/Wf9SIhpPGuM2NFmlkSuwow
         fR67pZcaQG4AovcKRclrh+HVg652ST9rK/B5kASfFgOT749yskn3ZOjTlRFvMth/uomu
         BcbFys7h+QFbfTpwYmNVay2wDMqHZRqbG85EBUlNNdRJUrD4+iCMcr50uNQfcJAzQEl+
         A5J7X7OBzeMBWUWJ9FYQSxdJ9lGVJKFGYtp1zmUDO0r1rJTsuJuyFeWGia20k8SW5mJO
         a8lQXGTpxB8y/Csxs807BKKwlVX7+Rq0M3cYVBeyigxX1QhQHyRUVTmFX5EkClBYsLll
         JJkg==
X-Gm-Message-State: AOAM5315kCys9lZYf+M7rjQ1XfY+Tg4b0o8AKd1PP+8d1jNI3P2lA94l
        Uu/cOB4ofpQmFzcbTOQFHgoTqPge0OY=
X-Google-Smtp-Source: ABdhPJy1Yr6gBEEM6/eIixPUvRi1/y4Qff1P3D8/Xi2rAVKwvbXXJQp4vxFSe/xQRKmx2QUA4Mo9Rg==
X-Received: by 2002:a05:6000:1044:b0:1eb:f72c:7f25 with SMTP id c4-20020a056000104400b001ebf72c7f25mr10858631wrx.155.1646725195663;
        Mon, 07 Mar 2022 23:39:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020adfb608000000b0020229d72a4esm1733924wre.38.2022.03.07.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:55 -0800 (PST)
Message-Id: <3265f41bcab7202991da5a7a160a85820fbff0c4.1646725188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:45 +0000
Subject: [PATCH 6/9] git-sparse-checkout.txt: add a new EXAMPLES section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since many users like to learn from examples, provide a section in the
manual with example commands that would be used and a brief explanation
of what each does.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 42 +++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 883b7f4c44f..2cfb1d8f599 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -136,6 +136,42 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
 the disable command, so the easy restore of calling a plain `init`
 decreased in utility.
 
+EXAMPLES
+--------
+`git sparse-checkout set MY/DIR1 SUB/DIR2`::
+
+	Change to a sparse checkout with all files (at any depth) under
+	MY/DIR1/ and SUB/DIR2/ present in the working copy (plus all
+	files immediately under MY/ and SUB/ and the toplevel
+	directory).  If already in a sparse checkout, change which files
+	are present in the working copy to this new selection.  Note
+	that this command will also delete all ignored files in any
+	directory that no longer has either tracked or
+	non-ignored-untracked files present.
+
+`git sparse-checkout disable`::
+
+	Repopulate the working directory with all files, disabling sparse
+	checkouts.
+
+`git sparse-checkout add SOME/DIR/ECTORY`::
+
+	Add all files under SOME/DIR/ECTORY/ (at any depth) to the
+	sparse checkout, as well as all files immediately under
+	SOME/DIR/ and immediately under SOME/.  Must already be in a
+	sparse checkout before using this command.
+
+`git sparse-checkout reapply`::
+
+	It is possible for commands to update the working tree in a way
+	that does not respect the selected sparsity directories, either
+	because of special cases (such as hitting conflicts when
+	merging/rebasing), or because some commands didn't fully support
+	sparse checkouts (e.g. the old `recursive` merge backend had
+	only limited support).  This command reapplies the existing
+	sparse directory specifications to make the working directory
+	match.
+
 INTERNALS -- SPARSE CHECKOUT
 ----------------------------
 
@@ -154,12 +190,6 @@ directory, it updates the skip-worktree bits in the index based
 on this file. The files matching the patterns in the file will
 appear in the working directory, and the rest will not.
 
-To enable the sparse-checkout feature, run `git sparse-checkout set` to
-set the patterns you want to use.
-
-To repopulate the working directory with all files, use the
-`git sparse-checkout disable` command.
-
 
 INTERNALS -- CONE PATTERN SET
 -----------------------------
-- 
gitgitgadget

