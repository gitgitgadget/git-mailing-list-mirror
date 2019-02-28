Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F4720248
	for <e@80x24.org>; Thu, 28 Feb 2019 19:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfB1Td4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 14:33:56 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36357 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfB1Tdz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 14:33:55 -0500
Received: by mail-ed1-f46.google.com with SMTP id g9so18007636eds.3
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UdARZiSbGh68UyvLBInBommArPS2hOjFvTFndEogq5o=;
        b=qZDnZVmvqzlCTN7eJqqs2gY5B8jJzoCpVIGYa3VLn4SoquJ4UgIlUibw40IjiTUhoR
         PlJ45v0TbU4WxRINs9UIm9RnVy5oNFeI8P9XUu1EiIFFtgqbY18i5/Gf9YsilG0KXU7j
         zZDoawFcVkzW5Vqo9+bwJhr6yHH1HUXwMEDY5tBT0S5U2BhDzpXWm0kq18Lxm22rAuSM
         U5jNzsSGGjrnyO8KMmBsprJjxUdO24VsSBznYb9jKm0WIoITw218diO5RkQYLJVi6lyO
         KhgiW6tuEXA6gGZ3RhrM8jLnnVBfVSE3vtFU6fGzAyO4NG7iHWF1jDVXzNKO3Y6jxPDs
         /O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UdARZiSbGh68UyvLBInBommArPS2hOjFvTFndEogq5o=;
        b=PBogti33fxyOfMV+ZpxUXz7lTq/Iq4cUd2qM3GMZsGomgIzlw0zLH6e5X60XfcXtgE
         dQEKOuLXnB1Dmaf4V/F+WL47Ey03F14utMAPLhNSUkPuJbSJJgSikMS+B84ulg2ik7ig
         DHaqP2E8YdxKA9Pzx3benrBklnR65q14eFzuY1IrNijSAIFTZUCdaYnjS7xdf8dpFqmH
         xCLk/KWri/WeifPiUK1lJCFkUCsVrlj+Ngtmq2vpzrseWFekLktn5smcIKTvyRPeQPSd
         DX1ozaX0ddBX0wI2B+6D1cuKcQqIh0Yr6APsx/XK/pLgf66t3pALVqAxyj9KJM248L0k
         OiKQ==
X-Gm-Message-State: APjAAAXeMqngxd1bskldwtsZ3w89wi9f8Q/Ji4q8+t9K1LV/zh7S/LIs
        1/5/8OQT3NmU8e/3V9jepAGOeyxf
X-Google-Smtp-Source: APXvYqx1ZTr8yjSj9voRBh+iFO9SEtWOyh2LBucSBnuJT+MuRITg5FpjNwjzBRAnu4lzoDIOia2d9w==
X-Received: by 2002:aa7:d396:: with SMTP id x22mr1018502edq.182.1551382433148;
        Thu, 28 Feb 2019 11:33:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q25sm3366212ejx.47.2019.02.28.11.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 11:33:52 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:33:52 -0800 (PST)
X-Google-Original-Date: Thu, 28 Feb 2019 19:33:51 GMT
Message-Id: <4c14991d0672617460638b1bb445686da09c4889.1551382431.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.154.git.gitgitgadget@gmail.com>
References: <pull.154.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] travis: remove the hack to build the Windows job on Azure
 Pipelines
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

Since Travis did not support Windows (and now only supports very limited
Windows jobs, too limited for our use, the test suite would time out
*all* the time), we added a hack where a Travis job would trigger an
Azure Pipeline (which back then was still called VSTS Build), wait for
it to finish (or time out), and download the log (if available).

Needless to say that it was a horrible hack, necessitated by a bad
situation.

Nowadays, however, we have Azure Pipelines support, and do not need that
hack anymore. So let's retire it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .travis.yml             |  10 ----
 ci/run-windows-build.sh | 103 ----------------------------------------
 2 files changed, 113 deletions(-)
 delete mode 100755 ci/run-windows-build.sh

diff --git a/.travis.yml b/.travis.yml
index 36cbdea7f4..ffb1bc46f2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -21,16 +21,6 @@ matrix:
       compiler:
       addons:
       before_install:
-    - env: jobname=Windows
-      os: linux
-      compiler:
-      addons:
-      before_install:
-      script:
-        - >
-          test "$TRAVIS_REPO_SLUG" != "git/git" ||
-          ci/run-windows-build.sh $TRAVIS_BRANCH $(git rev-parse HEAD)
-      after_failure:
     - env: jobname=Linux32
       os: linux
       compiler:
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
deleted file mode 100755
index a73a4eca0a..0000000000
--- a/ci/run-windows-build.sh
+++ /dev/null
@@ -1,103 +0,0 @@
-#!/usr/bin/env bash
-#
-# Script to trigger the Git for Windows build and test run.
-# Set the $GFW_CI_TOKEN as environment variable.
-# Pass the branch (only branches on https://github.com/git/git are
-# supported) and a commit hash.
-#
-
-. ${0%/*}/lib.sh
-
-test $# -ne 2 && echo "Unexpected number of parameters" && exit 1
-test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not defined" && exit
-
-BRANCH=$1
-COMMIT=$2
-
-gfwci () {
-	local CURL_ERROR_CODE HTTP_CODE
-	CONTENT_FILE=$(mktemp -t "git-windows-ci-XXXXXX")
-	while test -z $HTTP_CODE
-	do
-	HTTP_CODE=$(curl \
-		-H "Authentication: Bearer $GFW_CI_TOKEN" \
-		--silent --retry 5 --write-out '%{HTTP_CODE}' \
-		--output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >$CONTENT_FILE) \
-		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" \
-	)
-	CURL_ERROR_CODE=$?
-		# The GfW CI web app sometimes returns HTTP errors of
-		# "502 bad gateway" or "503 service unavailable".
-		# We also need to check the HTTP content because the GfW web
-		# app seems to pass through (error) results from other Azure
-		# calls with HTTP code 200.
-		# Wait a little and retry if we detect this error. More info:
-		# https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-troubleshoot-http-502-http-503
-		if test $HTTP_CODE -eq 502 ||
-		   test $HTTP_CODE -eq 503 ||
-		   grep "502 - Web server received an invalid response" $CONTENT_FILE >/dev/null
-		then
-			sleep 10
-			HTTP_CODE=
-		fi
-	done
-	cat $CONTENT_FILE
-	rm $CONTENT_FILE
-	if test $CURL_ERROR_CODE -ne 0
-	then
-		return $CURL_ERROR_CODE
-	fi
-	if test "$HTTP_CODE" -ge 400 && test "$HTTP_CODE" -lt 600
-	then
-		return 127
-	fi
-}
-
-# Trigger build job
-BUILD_ID=$(gfwci "action=trigger&branch=$BRANCH&commit=$COMMIT&skipTests=false")
-if test $? -ne 0
-then
-	echo "Unable to trigger Visual Studio Team Services Build"
-	echo "$BUILD_ID"
-	exit 1
-fi
-
-# Check if the $BUILD_ID contains a number
-case $BUILD_ID in
-''|*[!0-9]*) echo "Unexpected build number: $BUILD_ID" && exit 1
-esac
-
-echo "Visual Studio Team Services Build #${BUILD_ID}"
-
-# Tracing execued commands would produce too much noise in the waiting
-# loop below.
-set +x
-
-# Wait until build job finished
-STATUS=
-RESULT=
-while true
-do
-	LAST_STATUS=$STATUS
-	STATUS=$(gfwci "action=status&buildId=$BUILD_ID")
-	test "$STATUS" = "$LAST_STATUS" || printf "\nStatus: %s " "$STATUS"
-	printf "."
-
-	case "$STATUS" in
-	inProgress|postponed|notStarted) sleep 10               ;; # continue
-		 "completed: succeeded") RESULT="success"; break;; # success
-		    "completed: failed")                   break;; # failure
-	*) echo "Unhandled status: $STATUS";               break;; # unknown
-	esac
-done
-
-# Print log
-echo ""
-echo ""
-set -x
-gfwci "action=log&buildId=$BUILD_ID" | cut -c 30-
-
-# Set exit code for TravisCI
-test "$RESULT" = "success"
-
-save_good_tree
-- 
gitgitgadget
