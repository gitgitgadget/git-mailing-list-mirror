Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C3BC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhK3L6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbhK3L6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824D1C061756
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so14599908wmc.2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8D4/O9BIeJDyx7UkKc8qSSrWGbYPXQcqw1HfHqLPa9c=;
        b=n//zSFARJc9bbE9d64h0XzS3KyIzJsrVfR5BHU99OJGIYA2mx/smIT2CUae0lrClAt
         ZaVd6kzYOggEmmwe6qL8g+MZhJbcegAAw4lBqyh6v4xz5WdViHGeED96HEYUx6VRCufR
         x289Lh0xDyhw/ZcA6nIpCmaVKH5gz5naiWCLza+IEy25tySdirt9ts5vqb2/HN1FtOBd
         Esk/3n5qKIYKOaKcNQcVslfnzgG+VyXJWlCBmet24fIXGB3K/d/hOZpSaEhE1X27ysED
         YmN07COzKVRV+2EE5t4l53aOzXzpaa8VtjF70RCvqj0To9PjfenbZex0NIoqy6sibHco
         YfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8D4/O9BIeJDyx7UkKc8qSSrWGbYPXQcqw1HfHqLPa9c=;
        b=HAFlO9gKXmWwUCeYi0IMVPm3gQ3IrEYTlEJ9VZXWdSP5MIha7IoBMMYIYyQgUvzsBu
         PqAHVl2jhXx3dZ4VZ9y+h4uVkKwd7bO8aOQk642EDfOKGrks33EhAPkGO9AJMN0UuOOy
         W/rk6dEpgt2+1M83Zi5k/RXef96yuZ6aMjLtQA1z907qAKBnWrYI/5+JM6lVYdqsMrry
         rpxA1LGTSltb/Nm2UFJLMalximQ51S7ShD8v1Vl23/N7cVIE25N5z9tRON3sBztZ1mgG
         oL2XV7RbUqkl/d47jytjY7ZKyCOfFLumv0mn7PNmvV0fCb7CzGsdWU172FRY0naH8gPO
         fixw==
X-Gm-Message-State: AOAM531FYteXCmExCdrtburf+BCBGgHogbmFZfXZnu1vvhruYNh8wE/e
        CXcKdowpsOmgA9IkXvsYecc/GZ/cIs8=
X-Google-Smtp-Source: ABdhPJx5CEz93LinUSIJrjZY2ta8qU+JyK9+5IEnUjGE/gIcGgrToxLEvaPWnTry2NTtiWiuLI8XiA==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr4416669wmk.152.1638273293032;
        Tue, 30 Nov 2021 03:54:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm16112517wrw.5.2021.11.30.03.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:54:52 -0800 (PST)
Message-Id: <74cd64109319748e532339017b3b76a4823f9c86.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:35 +0000
Subject: [PATCH v9 03/17] scalar: start documenting the command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Let's build up the documentation for the Scalar command along with the
patches that implement its functionality.

Note: To discourage the feature-incomplete documentation from being
mistaken for the complete thing, we do not yet provide any way to build
HTML or manual pages from the text file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 contrib/scalar/scalar.txt

diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
new file mode 100644
index 00000000000..5f7131861a5
--- /dev/null
+++ b/contrib/scalar/scalar.txt
@@ -0,0 +1,38 @@
+scalar(1)
+=========
+
+NAME
+----
+scalar - an opinionated repository management tool
+
+SYNOPSIS
+--------
+[verse]
+scalar <command> [<options>]
+
+DESCRIPTION
+-----------
+
+Scalar is an opinionated repository management tool. By creating new
+repositories or registering existing repositories with Scalar, your Git
+experience will speed up. Scalar sets advanced Git config settings,
+maintains your repositories in the background, and helps reduce data sent
+across the network.
+
+An important Scalar concept is the enlistment: this is the top-level directory
+of the project. It usually contains the subdirectory `src/` which is a Git
+worktree. This encourages the separation between tracked files (inside `src/`)
+and untracked files, such as build artifacts (outside `src/`). When registering
+an existing Git worktree with Scalar whose name is not `src`, the enlistment
+will be identical to the worktree.
+
+The `scalar` command implements various subcommands, and different options
+depending on the subcommand.
+
+SEE ALSO
+--------
+linkgit:git-maintenance[1].
+
+Scalar
+---
+Associated with the linkgit:git[1] suite
-- 
gitgitgadget

