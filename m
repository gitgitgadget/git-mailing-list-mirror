Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF731F454
	for <e@80x24.org>; Mon,  4 Nov 2019 17:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfKDRur (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 12:50:47 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42029 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfKDRur (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 12:50:47 -0500
Received: by mail-wr1-f43.google.com with SMTP id a15so18133289wrf.9
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oQndWkuB7BeRnShkCh9hZVI0GILlGlbMhO7bOSFseuE=;
        b=Wa+y2cnNY5AOxg6wUHIP1CYZ91lWS4jhn6/J0ZfKNF+WxhMvpebLKhZPl2OjTbq4kS
         zjagA4EsrD7Oe6cW4/TBtHlE7PsiUUJv6MvKwFVpKtQ1luRgFUuCo/GhsAGufG76VWmh
         J1iQaksZHnobfDZfsW8RsiPCVxuajiE2iGPHREE31vNwuNcXzP07U8PyXyQxBBv0IKer
         +bAeqBaZJE5XoMOR35doBxagJrgHe0eC4dvGglQ2XuIxSZPHZCr4clSh/nszN4FUTUmc
         E7+WuM8b7qpPINipDFdlAyjmKjqKgsokd9O945hd9AxWRXuIq5K9CP0x4UyNUpU4PBth
         jyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oQndWkuB7BeRnShkCh9hZVI0GILlGlbMhO7bOSFseuE=;
        b=O37QdjLUjp5aF/STNlfi2/kXZk2cNq5hYvMb6O71KiDGX9uFGZzcPZPPc7ruNovZzb
         3s859HSrPGsPUdz+cwMVWYyiGHOz4bD7qyeUBjt8loRFIr1LZXD/eniLh/vMG/uH4Mom
         gQZxZY7fwK3PM4C21a8tci+AJOQk4aVlONoggukT5LIPeYKUTKZckbqLmdNjtua4+QlV
         nhhRjl+orZfn+sSUZFPfOyo/qgKv9lksHgVBEvBmgc4OsoaAnPSkqTs/Rh6H8Krc5YTv
         2tZPEb7LBLuzDVyCsfA1i3WhJlLZk4Yl/VK03bNSvZ9Dr8XVm+//ask9RWxGFwe3pn4F
         v7yQ==
X-Gm-Message-State: APjAAAUiPrp49wxV/sTUXpKDGZKjHOl6aDIswaK7lHHTqbEeozOWHp3/
        CvD5iQCGYz+xk21TAFnQVuz/a8Y2
X-Google-Smtp-Source: APXvYqytchrtKtGNtPZqkpubcOnSK2aHTQKXLeO9Pvy5Axn2HLUg86lula7fxTrKxl2MrPm1CZKFSw==
X-Received: by 2002:adf:da42:: with SMTP id r2mr1855572wrl.383.1572889843032;
        Mon, 04 Nov 2019 09:50:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w19sm7598788wmk.36.2019.11.04.09.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 09:50:42 -0800 (PST)
Message-Id: <52eaf20f405b53743e27935dfe89f62e6f824a33.1572889841.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.444.git.1572889841.gitgitgadget@gmail.com>
References: <pull.444.git.1572889841.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 17:50:41 +0000
Subject: [PATCH 1/1] fsmonitor: fix watchman integration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

When running Git commands quickly -- such as in a shell script or the
test suite -- the Git commands frequently complete and start again
during the same second. The example fsmonitor hooks to integrate with
Watchman truncate the nanosecond times to seconds. In principle, this is
fine, as Watchman claims to use inclusive comparisons [1]. The result
should only be an over-representation of the changed paths since the
last Git command.

However, Watchman's own documentation claims "Using a timestamp is prone
to race conditions in understanding the complete state of the file tree"
[2]. All of their documented examples use a "clockspec" that looks like
'c:123:234'. Git should eventually learn how to store this type of
string to provide a stronger integration, but that will be a more
invasive change.

When using GIT_TEST_FSMONITOR="$(pwd)/t7519/fsmonitor-watchman", scripts
such as t7519-wtstatus.sh fail due to these race conditions. In fact,
running any test script with GIT_TEST_FSMONITOR pointing at
t/t7519/fsmonitor-wathcman will cause failures in the test_commit
function. The 'git add "$indir$file"' command fails due to not enough
time between the creation of '$file' and the 'git add' command.

For now, subtract one second from the timestamp we pass to Watchman.
This will make our window large enough to avoid these race conditions.
Increasing the window causes tests like t7519-wtstatus.sh to pass.

When the integration was introduced in def437671 (fsmonitor: add a
sample integration script for Watchman, 2018-09-22), the query included
an expression that would ignore files created and deleted in that
window. The performance reason for this change was to ignore temporary
files created by a build between Git commands. However, this causes
failures in script scenarios where Git is creating or deleting files
quickly.

When using GIT_TEST_FSMONITOR as before, t2203-add-intent.sh fails
due to this add-and-delete race condition.

By removing the "expression" from the Watchman query, we remove this
race condition. It will lead to some performance degradation in the case
of users creating and deleting temporary files inside their working
directory between Git commands. However, that is a cost we need to pay
to be correct.

[1] https://github.com/facebook/watchman/blob/master/query/since.cpp#L35-L39
[2] https://facebook.github.io/watchman/docs/clockspec.html

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Kevin Willford <Kevin.Willford@microsoft.com>
---
 t/t7519/fsmonitor-watchman                 | 13 ++++---------
 templates/hooks--fsmonitor-watchman.sample | 13 ++++---------
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 5514edcf68..d8e7a1e5ba 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -23,7 +23,8 @@ my ($version, $time) = @ARGV;
 
 if ($version == 1) {
 	# convert nanoseconds to seconds
-	$time = int $time / 1000000000;
+	# subtract one second to make sure watchman will return all changes
+	$time = int ($time / 1000000000) - 1;
 } else {
 	die "Unsupported query-fsmonitor hook version '$version'.\n" .
 	    "Falling back to scanning...\n";
@@ -54,18 +55,12 @@ sub launch_watchman {
 	#
 	# To accomplish this, we're using the "since" generator to use the
 	# recency index to select candidate nodes and "fields" to limit the
-	# output to file names only. Then we're using the "expression" term to
-	# further constrain the results.
-	#
-	# The category of transient files that we want to ignore will have a
-	# creation clock (cclock) newer than $time_t value and will also not
-	# currently exist.
+	# output to file names only.
 
 	my $query = <<"	END";
 		["query", "$git_work_tree", {
 			"since": $time,
-			"fields": ["name"],
-			"expression": ["not", ["allof", ["since", $time, "cclock"], ["not", "exists"]]]
+			"fields": ["name"]
 		}]
 	END
 	
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index e673bb3980..ef94fa2938 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -22,7 +22,8 @@ my ($version, $time) = @ARGV;
 
 if ($version == 1) {
 	# convert nanoseconds to seconds
-	$time = int $time / 1000000000;
+	# subtract one second to make sure watchman will return all changes
+	$time = int ($time / 1000000000) - 1;
 } else {
 	die "Unsupported query-fsmonitor hook version '$version'.\n" .
 	    "Falling back to scanning...\n";
@@ -53,18 +54,12 @@ sub launch_watchman {
 	#
 	# To accomplish this, we're using the "since" generator to use the
 	# recency index to select candidate nodes and "fields" to limit the
-	# output to file names only. Then we're using the "expression" term to
-	# further constrain the results.
-	#
-	# The category of transient files that we want to ignore will have a
-	# creation clock (cclock) newer than $time_t value and will also not
-	# currently exist.
+	# output to file names only.
 
 	my $query = <<"	END";
 		["query", "$git_work_tree", {
 			"since": $time,
-			"fields": ["name"],
-			"expression": ["not", ["allof", ["since", $time, "cclock"], ["not", "exists"]]]
+			"fields": ["name"]
 		}]
 	END
 
-- 
gitgitgadget
