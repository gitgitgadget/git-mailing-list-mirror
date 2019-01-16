Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF99211B4
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393216AbfAPNgW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:22 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43518 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390514AbfAPNgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:21 -0500
Received: by mail-ed1-f47.google.com with SMTP id f9so5395474eds.10
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d8mn0sQqmpMCyJw+G3k+5UZvKwi59kYYKD0XNAi7wSI=;
        b=GpCkGpRmWchQwcYjbXmvkF8db0mfNw91XwLc1xGCLN6uTgsuhahkgN9WVh//UOjCPX
         9nLkKCOQpGqTEkBYcXEFMWtJmYR+D5yYeQN2mOY7bfn4DfjyClnWR7YhxC07slSf62HR
         Jr1nSibA1Vpc+iybfq9h8180LSmS5Xb2C32KTG+dUdVqNNSRc4O8gt1vyFQw6+tvOFzj
         8jSb24ITa3tdSIDKZxdSsJKl06dMXO2jMx5jtiULMDPsU57BZY4C1Ddh3yGwMu0xLWZG
         cmi8fytDFohMGPR/ghOkoifCSkh+kVkVUNvOQtoBFpH9PuxjQ3L2yzQaLpePtOadtQnN
         iS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d8mn0sQqmpMCyJw+G3k+5UZvKwi59kYYKD0XNAi7wSI=;
        b=PqjXAZ8BC0LE9g/eJHCkAUG+3StkwDlgygY13BUQlCWD6EjG3PxZ4Ee82J0Csf0F1r
         D1coVD2sKw7iz1gM+FWJnIA0HgnAP4evS0FL7qufk5oQ40IUzhDs1Hfm3RYngO/zCiYo
         dmhRDW8oLdv2XjZrL7pquzb6PKxdZhboZ/jWk7TI1rUfGNtzoghAHcMmsaXJNNEILvKe
         JodG/m6tX2b6z2/mDMDtt59pjB9srfogiiPQFAtpdKVXHQK52OKbfcItjtjEpS08xVSl
         3VKyS6bhMk7IuUO0PRM2rIKNdb7pE5/ChoICbBQUaDCv8jBzPpg87RfA+pcKf1EuRjue
         90hw==
X-Gm-Message-State: AJcUukfBK0v/Li7GOAFH/fX1CbnQhUELV9LpQyZFpiR0zQ0tuuCJcS9y
        TdbPDOgCuxYVAfKEI34sqbv7ljGg
X-Google-Smtp-Source: ALg8bN7hlqNb0tj3yKZI+j61/2flaOwDeK4pTGQgdeviBu49Z25/HA87Yx1QhcwbCfcPT6Sx0khYhg==
X-Received: by 2002:a50:ae64:: with SMTP id c91mr7481700edd.222.1547645779014;
        Wed, 16 Jan 2019 05:36:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g40sm5504591edg.39.2019.01.16.05.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:18 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:18 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:56 GMT
Message-Id: <fefab79d4634f302e1b3b5f3e2c48e689f148265.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 08/21] ci/lib.sh: add support for Azure Pipelines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch introduces a conditional arm that defines some environment
variables and a function that displays the URL given the job id (to
identify previous runs for known-good trees).

For example, we do not have to install the git-lfs and gettext packages
on Azure Pipelines' macOS agents: they are already installed, and trying
to install them again would result in an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index bfc406a63b..e560fae3aa 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -20,6 +20,29 @@ then
 	BREW_INSTALL_PACKAGES="git-lfs gettext"
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
+elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
+then
+	# We are running in Azure Pipelines
+	CI_BRANCH="$BUILD_SOURCEBRANCH"
+	CI_COMMIT="$BUILD_SOURCEVERSION"
+	CI_JOB_ID="$BUILD_BUILDID"
+	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
+	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
+	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
+	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
+	CC="${CC:-gcc}"
+
+	# use a subdirectory of the cache dir (because the file share is shared
+	# among *all* phases)
+	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
+
+	url_for_job_id () {
+		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
+	}
+
+	BREW_INSTALL_PACKAGES=
+	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
+	export GIT_TEST_OPTS="--quiet --write-junit-xml"
 fi
 
 skip_branch_tip_with_tag () {
-- 
gitgitgadget

