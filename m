Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4ABC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 22:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707B461058
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 22:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhJDWa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbhJDWa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 18:30:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D1C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 15:29:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r18so6219696wrg.6
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ziv1KkkO0XOiHO+S1aR+RSF4l/LYA9W6WWF0AaoThh8=;
        b=GQL750fpA0uhUJd+2+nk/CXiezMApVvIXg/yk37uLicbkbxq8N3gp8p+4vJxh9x9qi
         hDUKF9jsJjm0n98tTDOVtloYGeZ2EccyV6E36+0FoELehICMBjqjr/4IofzRl4888znS
         1we1rwyl37S8V2YlzLulkBbG72obUBLpajqzXZtEgtlA2T0mE3wGue0PPSppN/+M5YcE
         silivNJOYirJC/1+7vitx/DS+jUJcAb3ysR0IrBvLujyOEyV57i6B2tIB7BEUfIk8goG
         GrNpJ+E7unX077wtFNEvLt8bgyM0SZeWOoYl6mouMfjZFX7BN3ijDWj1zAbS8HZJIAbl
         5rCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ziv1KkkO0XOiHO+S1aR+RSF4l/LYA9W6WWF0AaoThh8=;
        b=6VZqTj1GkwhMlEh4CS+yKPQlTFpGRSOOa5A9WCLMD/RFgmUYrQGtMhv+idE1h+Dent
         XnfqUVPqogYitZOmka04wkR4t5yTUTJKiI7C/Uhvc7VVoZpVi1chVEe+vsFd+iHavJ7l
         dkV5EAYVc92S2HEUfXeL4MxZNLSaIXZGokVKwj6CBqgnLVGW8w/TOvDTbAU+ICo6xeiw
         9EpuKaX9INHeX9PDMe1TgNtp3M+s4H9RuJEQ41bZB62UUYC5+DKPfWL/E/RKXzQzQEFT
         9S3lLfLBjBOLfeW8HX4aiBqJK1+EJ1Emgqg7QX5W6F0hETOM9mFWkoAEGBkeEuEIl11E
         NIeQ==
X-Gm-Message-State: AOAM532nRKUN0rxfvm0GXYMryFkQmuilw7mSAQjbmVJIYMlf+IGj9Fj0
        xDLQtGdxltuA1PW2zKVMvH6GhgiccH8=
X-Google-Smtp-Source: ABdhPJyMPEvgqnZ5KBPpLaKGV/xzhhdRjSdEO+8/Dvsad9s0YqfCyoLaN0P+9EGQaBvsfOeUo3r08A==
X-Received: by 2002:adf:a347:: with SMTP id d7mr17794976wrb.139.1633386545389;
        Mon, 04 Oct 2021 15:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i92sm15290443wri.28.2021.10.04.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 15:29:04 -0700 (PDT)
Message-Id: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 22:29:03 +0000
Subject: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach test_perf_() to remove the temporary test_times.* files
at the end of each test.

test_perf_() runs a particular GIT_PERF_REPEAT_COUNT times and creates
./test_times.[123...].  It then uses a perl script to find the minimum
over "./test_times.*" (note the wildcard) and writes that time to
"test-results/<testname>.<testnumber>.result".

If the repeat count is changed during the pXXXX test script, stale
test_times.* files (from previous steps) may be included in the min()
computation.  For example:

...
GIT_PERF_REPEAT_COUNT=3 \
test_perf "status" "
	git status
"

GIT_PERF_REPEAT_COUNT=1 \
test_perf "checkout other" "
	git checkout other
"
...

The time reported in the summary for "XXXX.2 checkout other" would
be "min( checkout[1], status[2], status[3] )".

We prevent that error by removing the test_times.* files at the end of
each test.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
    t/perf/perf-lib.sh: remove test_times.* at the end test_perf_()
    
    Teach test_perf_() to remove the temporary test_times.* files at the end
    of each test.
    
    test_perf_() runs a particular GIT_PERF_REPEAT_COUNT times and creates
    ./test_times.[123...]. It then uses a perl script to find the minimum
    over "./test_times.*" (note the wildcard) and writes that time to
    "test-results/..result".
    
    If the repeat count is changed during the pXXXX test script, stale
    test_times.* files (from previous steps) may be included in the min()
    computation. For example:
    
    ... GIT_PERF_REPEAT_COUNT=3
    test_perf "status" " git status "
    
    GIT_PERF_REPEAT_COUNT=1
    test_perf "checkout other" " git checkout other " ...
    
    The time reported in the summary for "XXXX.2 checkout other" would be
    "min( checkout[1], status[2], status[3] )".
    
    We prevent that error by removing the test_times.* files at the end of
    each test.
    
    Signed-off-by: Jeff Hostetler jeffhost@microsoft.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1051%2Fjeffhostetler%2Fperf-test-remove-test-times-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1051/jeffhostetler/perf-test-remove-test-times-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1051

 t/perf/perf-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index f5ed092ee59..a1b5d2804dc 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -230,6 +230,7 @@ test_perf_ () {
 		test_ok_ "$1"
 	fi
 	"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".result
+	rm test_time.*
 }
 
 test_perf () {

base-commit: 0785eb769886ae81e346df10e88bc49ffc0ac64e
-- 
gitgitgadget
