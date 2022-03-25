Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB9C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiCYT3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiCYT26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:28:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989021F778
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:02:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so10959961wrc.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HWcYd7OiwrwoD9+q/gpkzK4ZOE5lCSHquCeonyF4YVc=;
        b=b1CXxZ+YxEi2ySiNpzd/nCDJIVaWpu6ReJV0856oKiiF9uulo4XBr4TgdYodBMEmx7
         gufqxVOZ4jHTiRjLI9II1g0s6a+45//Vm6iNV12KXrwDCoBtSMBXv4k9sKP/7XcJGNH9
         KL5PgHk/kcO7RqUf1AC2X/rbIFd/SVPoASoL+la7xyujiMXuq+2KIKLJKuK2vuUxmNbM
         cYH43UCIX0jMY1Xv6pTWn1cD8IoPRnuGDB54z/HNgBwIQqa7roImhK1o3ByVz99V5qT1
         YgVafYplSgxnSzBBVWHQefHPjSshv1p5lKD+MI8dB4Fg9d6X8toqTVeHkkb8ksCxjet7
         oBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HWcYd7OiwrwoD9+q/gpkzK4ZOE5lCSHquCeonyF4YVc=;
        b=G+ne5u8g1nbdXlE4IzmxqM7IY4cImGgQ1amJc9+59/Pj99D57Fx+fkJQX/XBGmpsQg
         11eIXJKvj0UqSTtW/eXZ/QIo1EQZXplTHb1z79k8pj2oQFjQU9CcqwsHPGfXv0IB7Im9
         /iNBQtyzG5/YgmRnoZdWWZIcCCQkMeOi8k6NrokuLL99UFinx0uO9lFyD2qQiw8N9X20
         Eh3foshkZSjvZuf2n8E6mt6Q3yK9ftXWjcEtOzkuI9+zkafCP4po48DS/oS+orXoRoMP
         1G9IjvMVcz6Z9skTllgJTTFZoKhbTDtaWoJAhvDsMFEAzKPiuFRwQCaDsyz8PCnK+rt5
         lqug==
X-Gm-Message-State: AOAM530P/QJj51Z1KcZamPA57vymWOtHI7ngstjZWpQKGWQgcKk5m0VT
        vwcEvQ8t24RRgOfJ2bdWsQsMs3BVYKQ=
X-Google-Smtp-Source: ABdhPJxG88sT2bzL0XY5BdnpcUnzxhz6TgJkQmoaDGbdkUQhNDNS7mazxjyZ1maDMOpy85QkW0Jf2g==
X-Received: by 2002:a5d:584a:0:b0:205:86cb:dd0e with SMTP id i10-20020a5d584a000000b0020586cbdd0emr10172941wrf.578.1648234970786;
        Fri, 25 Mar 2022 12:02:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d63c5000000b002040822b680sm8352495wrw.81.2022.03.25.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:02:50 -0700 (PDT)
Message-Id: <f5a96a121a56b7d04cbd8fa20ab9d79e8d811115.1648234967.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.1648234967.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
        <pull.1185.v3.git.1648234967.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 19:02:47 +0000
Subject: [PATCH v3 2/2] test-lib-functions: remove test_subcommand_inexact
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The implementation of test_subcommand_inexact() was originally
introduced in e4d0c11c0 (repack: respect kept objects with '--write-midx
-b', 2021-12-20) with the intention to allow finding a subcommand based
on an initial set of arguments. The inexactness was intended as a way to
allow flexible options beyond that initial set, as opposed to
test_subcommand() which requires that the full list of options is
provided in its entirety.

The implementation began by copying test_subcommand() and replaced the
repeated argument 'printf' statement to append ".*" instead of "," to
each argument. This caused it to be more flexible than initially
intended.

The previous change deleted the only use of test_subcommand_inexact, so
instead of editing the helper, delete it.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/test-lib-functions.sh | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0f439c99d61..2501fc5706f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1788,40 +1788,6 @@ test_subcommand () {
 	fi
 }
 
-# Check that the given command was invoked as part of the
-# trace2-format trace on stdin, but without an exact set of
-# arguments.
-#
-#	test_subcommand [!] <command> <args>... < <trace>
-#
-# For example, to look for an invocation of "git pack-objects"
-# with the "--honor-pack-keep" argument, use
-#
-#	GIT_TRACE2_EVENT=event.log git repack ... &&
-#	test_subcommand git pack-objects --honor-pack-keep <event.log
-#
-# If the first parameter passed is !, this instead checks that
-# the given command was not called.
-#
-test_subcommand_inexact () {
-	local negate=
-	if test "$1" = "!"
-	then
-		negate=t
-		shift
-	fi
-
-	local expr=$(printf '"%s".*' "$@")
-	expr="${expr%,}"
-
-	if test -n "$negate"
-	then
-		! grep "\"event\":\"child_start\".*\[$expr\]"
-	else
-		grep "\"event\":\"child_start\".*\[$expr\]"
-	fi
-}
-
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
gitgitgadget
