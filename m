Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1EBC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352567AbhLCNiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352570AbhLCNiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4434C061757
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4893484wml.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8D4/O9BIeJDyx7UkKc8qSSrWGbYPXQcqw1HfHqLPa9c=;
        b=fUV1ZZi7NaASypORHB1ciBBsriOeZH41S2aQ4v/372holRIpSrSyXIx5C+1uhTypjh
         EqOeFNJzwagAJHJsQGLx3xhWXDONKlytxlwPcPHoKd2mXJ9x59E9C7BD78vBHTgnVdim
         vANlO+yg8SgEe5tC7Ryzcb4TQbsn2X/g1eCMvbSVZ3rPIs9AWNgAThms3ndZOWQHVdIT
         X1RTkpXUvHfAIYPRDS1FaqikDvAJ5UjPFP/AHUWZumvrFjgSwSUbiNIHoCSNgnDPemY5
         BNvuXh4NAhoMMf2tGLbB1TKFh7dducztIFeghX5XTpk0RAdNoooDHRwd6sVHq+skW/Au
         jZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8D4/O9BIeJDyx7UkKc8qSSrWGbYPXQcqw1HfHqLPa9c=;
        b=dAR5yWNzPK0RZL5tLLYFJnOVu5ueAMhblfoGE06naamSXvrnJAKOYU/Rl4WlOR60Ts
         auxKtRcDqlV0mStBYmvK1WCNys55XiW2NGJCJ1A8/Il+vogOP/9CDwjz2Vl8Nt/JjHoI
         OSFgVbjLXIeWC0uT1OchAp2JcexftB4Msz20QIwz8ktepM/vFBTR9kfgBgPDv6JJ65ON
         kL3znHnzxlDNir+kiN1d1iMdU8lxUy7PTkb+dl/PUS6b62uCaFuK6q+zBosLzODtKgYA
         u9GjI8d4DEc7SDvix3lSqt9hlJXJ3ET5kDdPzvaQzVWBTSK95oKgs7v+LZx3ojf/b0Tu
         0PzA==
X-Gm-Message-State: AOAM53303aoTI33dD5LVjRyAdBXoheyGYMVyOJfc6H0a/VGTjHMOkKfB
        CF799ckuz3oZ5hdAz5+0N+IQYZsqfjs=
X-Google-Smtp-Source: ABdhPJw81e8lSXvvEwzHNhtepjeQRJ6kndOjMZHDhWgFFLyuQL+PIabPl7CU29Qc6isMnGMC2ISCCA==
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr14866467wmq.112.1638538474379;
        Fri, 03 Dec 2021 05:34:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm2254602wmq.13.2021.12.03.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:33 -0800 (PST)
Message-Id: <74cd64109319748e532339017b3b76a4823f9c86.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:17 +0000
Subject: [PATCH v10 03/15] scalar: start documenting the command
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

