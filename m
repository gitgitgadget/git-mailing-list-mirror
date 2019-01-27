Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1291F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfA0X1A (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:00 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34656 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0X06 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:58 -0500
Received: by mail-ed1-f48.google.com with SMTP id b3so11653464ede.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RJiBb8F0ZIhkEzjeNE5PJ80Os/lj+Z9pFBzCKAm8HF8=;
        b=cpddnDVuJECZm7SqQttSe9vANpntyz1GbFEtkj0ZGKlMOLL7z40RF/dITdEme5sWed
         LTfe9CeSKuORAwNoN+nLURQghVb/HDtztJIGHabgwVAbhLQbGFexxuLWP3+lj80W37VL
         6N4dRR0KFbwWlRkMEvxD8BwIIYYbYEdH+i+Jbly4Z0+IaNDfQT6Gi6gy0irxQGJ13wml
         ps6BkorPPLe52w1Nv5TeUQ5OTup70Yui3NmmnjkB9yBeiAHzDSQ8PhURDjqW+iRtdsna
         vzOGP0uA8+FATjWjCXVu/ONkpellOV2WLqLmu+G92LHPToW0S0KnyAEFPjGk0uTE2HVF
         uaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RJiBb8F0ZIhkEzjeNE5PJ80Os/lj+Z9pFBzCKAm8HF8=;
        b=tbSZNDAR/YrBO7sp9Sg88I1G4nUlkZ60yG6UaPKDqZLpl49n1phxnesywuMMztvu+o
         UCsTR3WRE/61DibhZO2pH5njF7lq1Kg2fklvMiOBYkCs7BnwSfXBdUj1eJVmfy18+EW5
         Ek24I9FOxSmmaGOxazCID/Pzot9nq5M7OVeDdsaywPorhMAbpGqhsusaXd1tXsbddz0r
         evUlG5TBFvoTn28PoNWf+mqmCvOzuXPaMGK+sdZhrM/PfnBhNGXGSsEZYMVATt97Ab1G
         WcTonr7dIyUZynfAZ9vOVI6wdylNJ2XKm6FZzQqs8OdfoqrfNZkHdP5IK860+qZHv88q
         N1Bw==
X-Gm-Message-State: AJcUukcvX1brwehSO8ciX87evUkKVZs/GLOXJaJYys/dt2QNdArS7wrj
        1ugvduQlr4mlcBK/8SSx9IiIo3oe
X-Google-Smtp-Source: ALg8bN7kNXT/Nom0lcDHtKqxmtOyJccqzJTUUu7xxCgPuViPGEB+QkED/I5RJq4z2aB4utWdbdXEoQ==
X-Received: by 2002:aa7:d487:: with SMTP id b7mr18758395edr.256.1548631615922;
        Sun, 27 Jan 2019 15:26:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4sm13269290edb.21.2019.01.27.15.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:55 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:55 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:34 GMT
Message-Id: <47fe8aa84aa11b8da9c01c5e8e88b68909dcfdbd.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 08/21] ci/lib.sh: add support for Azure Pipelines
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

Because Azure Pipeline's macOS agents already have git-lfs and gettext
installed, we can leave `BREW_INSTALL_PACKAGES` empty (unlike in
Travis' case).

Note: this patch does not introduce an Azure Pipelines definition yet;
That is left for the next patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh                 | 25 +++++++++++++++++++++++++
 ci/print-test-failures.sh |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 32a28fd209..5505776876 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -102,6 +102,31 @@ then
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
 	export MAKEFLAGS="--jobs=2"
+elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
+then
+	CI_TYPE=azure-pipelines
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
+	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
+	export MAKEFLAGS="--jobs=10"
 else
 	echo "Could not identify CI type" >&2
 	exit 1
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index cf321b474d..e688a26f0d 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -41,6 +41,11 @@ do
 		case "$CI_TYPE" in
 		travis)
 			;;
+		azure-pipelines)
+			mkdir -p failed-test-artifacts
+			mv "$trash_dir" failed-test-artifacts
+			continue
+			;;
 		*)
 			echo "Unhandled CI type: $CI_TYPE" >&2
 			exit 1
-- 
gitgitgadget

