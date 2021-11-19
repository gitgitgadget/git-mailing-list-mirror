Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E500C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhKSXGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhKSXGw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBFAC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so20653846wrb.6
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8D4/O9BIeJDyx7UkKc8qSSrWGbYPXQcqw1HfHqLPa9c=;
        b=AvxgtVriyR3+KN9ApzI6rc5OUAHCzJuv1MVG/m/G2aZVhev03PUlSp2IfJDB0Rljs5
         BkXiX1/mBLssrHW7oqm0BVqk/ZiHe5yvf4MJaXpRzolSBgNQFUuPBtqxkdGoUZXPbKmp
         ry6q1pUyzcHWM8TZOjeJdCbVcLrpGInC/B+e5zD2TID8I6n6Uzh+4ppr9pMcTKgiFxv+
         sfL0NbYqb+buJoEV7v1qBwIYEuppNyQosWqrEw+ivUKUmDD2eM5QvaHzs2ZNFSsBl4FQ
         W0fwmuHWn+AWpwmgxqdE+qHSM4pyPVhQrZPQDkw8ZhJ5+B7BsvomV4zVI5KmXfdeLAZ7
         LnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8D4/O9BIeJDyx7UkKc8qSSrWGbYPXQcqw1HfHqLPa9c=;
        b=OUPEs2YR9YbypPrd7NW9E1MICyW26KMWr1rcuwi4cwMrQl4tuzLHYNotBxZKRTJ2ni
         ADxbWL0nsDmG7MphxXrwZ+9KV1BbINvQAY+CWxOFhCjL28qXQNAaRf4QasnEM4rmQ+GD
         GL7+wCjYV5BPgoR3ARM2Qjf6tyzNs8Gb1VMx7x9ObqKo7XVSEl8KQRy6Co13OD5AQLRm
         Qa3Fy0/aE4UzJVI01prxPO9KKWp7t4uAVRK5zHnurDke2iMMu4aiax6goIHkqtuE1IzT
         26gD69241iNeefO1bq4J9M4XRBDmTU1933BUe+Jmmna8gQdt0N3R50JXkz2RrdMbRTPu
         UctQ==
X-Gm-Message-State: AOAM533gOBPfmlpRlmG3DIXerH/DinJmkIlYIbqR+y2dX2xqE9PM0+zJ
        WLogPEI0pLvAT/sjwJsM+zdZolHGpIU=
X-Google-Smtp-Source: ABdhPJyX2BCCwTbI+iyUL7QRVzYc3FFuvJU8QIUtodpSvuqwRZbskmzdU1iAxDVIgESTsmRVqNKyBA==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr11833344wrm.406.1637363027926;
        Fri, 19 Nov 2021 15:03:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm977367wrt.58.2021.11.19.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:47 -0800 (PST)
Message-Id: <74cd64109319748e532339017b3b76a4823f9c86.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:30 +0000
Subject: [PATCH v8 03/17] scalar: start documenting the command
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

