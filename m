Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2084C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiCLDMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiCLDMe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B890293F06
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u10so15565618wra.9
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aWmqn8MAJLAeThHWU5bSr6RMPD/6iD3YKKgzwJH9dvM=;
        b=pP/vv49jUujRJGVT0j+ICBynYBLel7Z6QEpJ7ovxIAwlnNltxM7euuymC9d+bw4+E9
         Qi7AoDrVsNGIlvfw73bFQJxUpfGltHajSSUjny3wRBIz7PHoZQ4padIAQoP/h9bzRS9M
         J6SY/iCNm6rk3pg9CwykydNO5ktY5YE9+cL2msBQz2Z7WXqKvjMF7S9lCl0vQZ0SgZYu
         R0CflPYNZgjtdTsbDOKPXk988tBcLPy535iQ9VdJ3bkCnM91YIw10seFzXVL++CqTg/z
         BG/29y+8EfZ7vSg1vrOV5ersGglK874B92FeHq1Ycq1WoNUtALzMzDVgF0N8Sy8pa3QE
         hjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aWmqn8MAJLAeThHWU5bSr6RMPD/6iD3YKKgzwJH9dvM=;
        b=fbIB9YLy3DIqDpDcWalpdhh8XsjLfq4SuA6WC81yTyzoZ0fBlV/URVfe8ifNSRIvzn
         ZhcjZ9qy6QH7Q0W7o723kzpQ4ULTsjVC6MaxqpNqpWyQIg/+Q8A8hi1oc1nKq6IajtwQ
         SNorsXnxN+DUMDWPEOxl/I4lXW9B+O6xKlyu7rv3/hZW6XAZcX5oyE1eRo4KT5QBjm9w
         Ok/+4cBdAmj9xOq+yiN8zcovHQFiYYomBE28lxjqIklbnNS9+M9cxYEmAHZEW48a9lNs
         QjsyplBZlKKS7Q3MhPMN8hw9eTgWE+y8gcn41vxnIvRaHWu7y6MKbIqnFRljo14GzcME
         uT0Q==
X-Gm-Message-State: AOAM533amGps+Ux0C//pg5N2ezO1Z21BEdA7HnnSdUkvHj5JcVXILKgD
        Sl0Y3/oiGdB/diPtTPRXwCuHYqd7UxE=
X-Google-Smtp-Source: ABdhPJySt5JhmIX9g2Q/IATgc2ZpO7peXGYwlHyQKepqSwcR5Vm8vsXhEeCiG7RkoBiYzVx8UUeZkg==
X-Received: by 2002:a05:6000:128f:b0:1f1:e586:87af with SMTP id f15-20020a056000128f00b001f1e58687afmr9311731wrx.222.1647054687805;
        Fri, 11 Mar 2022 19:11:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6688000000b001f04ae0bb6csm7649623wru.58.2022.03.11.19.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:27 -0800 (PST)
Message-Id: <a814ea9e8d29a5eb702570bc3c11379479bd7b4e.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:18 +0000
Subject: [PATCH v2 6/9] git-sparse-checkout.txt: add a new EXAMPLES section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
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
 Documentation/git-sparse-checkout.txt | 43 +++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 883b7f4c44f..dddf5ac6942 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -136,6 +136,43 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
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
+	It is possible for commands to update the working tree in a
+	way that does not respect the selected sparsity directories.
+	This can come from tools external to Git writing files, or
+	even affect Git commands because of either special cases (such
+	as hitting conflicts when merging/rebasing), or because some
+	commands didn't fully support sparse checkouts (e.g. the old
+	`recursive` merge backend had only limited support).  This
+	command reapplies the existing sparse directory specifications
+	to make the working directory match.
+
 INTERNALS -- SPARSE CHECKOUT
 ----------------------------
 
@@ -154,12 +191,6 @@ directory, it updates the skip-worktree bits in the index based
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

