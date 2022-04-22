Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC9C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 11:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiDVL30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiDVL3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 07:29:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1881554FA6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:26:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e28so400915wra.8
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xRjyorg9NfvzTeGWDeDtwzxW4/YPLgEUnucXM2mv+Yg=;
        b=RfbFwsrlX2bdoAJ2hHlehOgxLsHGTZYgmWrQ7Otp9r30O9uCCKaCWt/CVhyA1TxaD3
         YxQxvg3kE5OxMcEhNB+PbklCXBWCLV0E1t9NtxaQ7+ArxOLjvQZmWnwabcgcHJ2z81W3
         Qa2Sq5pK9jyt0X4riafybCbpPlXhN1qX/+XmmkkJnpQUoLWrfqysOnxsohKNRunkVSh7
         uBmJq5/AKPgWohClA6s4HcJ2B3CnDpa7Y+nDGABmkO2jx71+j7/UgiD0TO0Q6bmrL1o6
         5/RGWZtKVbdw8rFh+gT3fQQU16TXQdUR7FaGtRdV8Re3aPClC2zQz2boUh3qnbx+60lS
         V1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xRjyorg9NfvzTeGWDeDtwzxW4/YPLgEUnucXM2mv+Yg=;
        b=lkHgMFt75lSzZb5j4e/QLSlENhlfvSS4hXBOzPPH1uPv2QO+55FJfCeeX8gww2YaUh
         YoOO6wRZSpHr9ghir5P4sYAdZM9OQTwQ3qNgE9oWKDUu1Rkx5tZd063nRWFr3pDYATzv
         t/vVSUSaauDI74MgOLfJQe3HDUFeysPtosz9Aeo9D5Z2sXEDy9AaHL3uj9MbEAaV9DoB
         m3mGbowWBDAdTG4R9WndEtYn1GoNUcQyQSB14r6aBqrx64ctjd8KQzx8gX3dqpAUpDNo
         35i0PB05LBPuIodHWx/RZd6Nmvg2Ep4RFuUqHSidpfGykpqsUThzm7lgwHCmpi8gWBKH
         N+HA==
X-Gm-Message-State: AOAM533BR+3yUxsnorXYfkGp9KnTkV8XHJruZXMPRpnYBe51KBjMyJ/A
        Mb0qFFVa3MNOU16991Z7mFEgDowEKz4=
X-Google-Smtp-Source: ABdhPJzwkPjoTg9y5/lTR8ImID8S4vdoetPQWwDERlW+DlKjVl332lndRCmj2AM+DrZ2KJfG+bpKpg==
X-Received: by 2002:a5d:6d04:0:b0:20a:7ea4:a0c8 with SMTP id e4-20020a5d6d04000000b0020a7ea4a0c8mr3502003wrq.120.1650626789063;
        Fri, 22 Apr 2022 04:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19-20020adfaa93000000b0020ac7c3b530sm1631748wrc.74.2022.04.22.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:26:28 -0700 (PDT)
Message-Id: <pull.1195.v2.git.1650626787628.gitgitgadget@gmail.com>
In-Reply-To: <pull.1195.git.1648676585765.gitgitgadget@gmail.com>
References: <pull.1195.git.1648676585765.gitgitgadget@gmail.com>
From:   "Labnan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 11:26:27 +0000
Subject: [PATCH v2] t3501: remove test -f and stop ignoring git <cmd> exit
 code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Labnan <khalid.masum.92@gmail.com>,
        Khalid Masum <khalid.masum.92@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Khalid Masum <khalid.masum.92@gmail.com>

In the test 'cherry-pick after renaming branch', stop checking for
the presence of a file (opos) because we are going to "grep" in it in
the same test and the lack of it will be noticed as a failure anyway.

In the test 'revert after renaming branch', instead of allowing any
random contents as long as a known phrase is not there in it, we can
expect the exact outcome---after the successful revert of "added", the
contents of file "spoo" should become identical to what was in file
"oops" in the "initial" commit. This test also contains 'test -f' that
verifies presence of a file, but we have a helper function to do the same
thing. Replace it with appropriate helper function 'test_path_is_file'
for better readability and better error messages.

In both tests, we will not notice when "git rev-parse" starts segfaulting
without emitting any output.  The 'test' command will end up being just
"test =", which yields success. Use the 'test_cmp_rev' helper to make
sure we will notice such a breakage.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
    t3501: remove redundant test -f and use of git rev-parse
    
    Two test -f are present in t3501. They can be replaced with appropriate
    helper function: test_path_is_file. Which makes the script more readable
    and gives better error messages.
    
    Signed-off-by: Labnann khalid.masum.92@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1195%2FLabnann%2Ft3501-helper-functions-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1195/Labnann/t3501-helper-functions-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1195

Range-diff vs v1:

 1:  8b7d38a66f8 ! 1:  1090429b865 t3501: use test_path_is_* functions
     @@
       ## Metadata ##
     -Author: Labnann <khalid.masum.92@gmail.com>
     +Author: Khalid Masum <khalid.masum.92@gmail.com>
      
       ## Commit message ##
     -    t3501: use test_path_is_* functions
     +    t3501: remove test -f and stop ignoring git <cmd> exit code
      
     -    Two test -f are present in t3501. They can be replaced with appropriate
     -    helper function: test_path_is_file
     +    In the test 'cherry-pick after renaming branch', stop checking for
     +    the presence of a file (opos) because we are going to "grep" in it in
     +    the same test and the lack of it will be noticed as a failure anyway.
      
     -    Signed-off-by: Labnann <khalid.masum.92@gmail.com>
     +    In the test 'revert after renaming branch', instead of allowing any
     +    random contents as long as a known phrase is not there in it, we can
     +    expect the exact outcome---after the successful revert of "added", the
     +    contents of file "spoo" should become identical to what was in file
     +    "oops" in the "initial" commit. This test also contains 'test -f' that
     +    verifies presence of a file, but we have a helper function to do the same
     +    thing. Replace it with appropriate helper function 'test_path_is_file'
     +    for better readability and better error messages.
     +
     +    In both tests, we will not notice when "git rev-parse" starts segfaulting
     +    without emitting any output.  The 'test' command will end up being just
     +    "test =", which yields success. Use the 'test_cmp_rev' helper to make
     +    sure we will notice such a breakage.
     +
     +    Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
      
       ## t/t3501-revert-cherry-pick.sh ##
      @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick after renaming branch' '
     + 
       	git checkout rename2 &&
       	git cherry-pick added &&
     - 	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
     +-	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
      -	test -f opos &&
     -+	test_path_is_file opos &&
     ++	test_cmp_rev rename2 HEAD^ &&
       	grep "Add extra line at the end" opos &&
       	git reflog -1 | grep cherry-pick
       
      @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'revert after renaming branch' '
     + 
       	git checkout rename1 &&
       	git revert added &&
     - 	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
     +-	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
      -	test -f spoo &&
     +-	! grep "Add extra line at the end" spoo &&
     ++	test_cmp_rev rename1 HEAD^ &&
      +	test_path_is_file spoo &&
     - 	! grep "Add extra line at the end" spoo &&
     ++	test_cmp_rev initial:oops HEAD:spoo &&
       	git reflog -1 | grep revert
       
     + '


 t/t3501-revert-cherry-pick.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8617efaaf1e..9eb19204ac7 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -66,8 +66,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
 	git cherry-pick added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
-	test -f opos &&
+	test_cmp_rev rename2 HEAD^ &&
 	grep "Add extra line at the end" opos &&
 	git reflog -1 | grep cherry-pick
 
@@ -77,9 +76,9 @@ test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
 	git revert added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
-	test -f spoo &&
-	! grep "Add extra line at the end" spoo &&
+	test_cmp_rev rename1 HEAD^ &&
+	test_path_is_file spoo &&
+	test_cmp_rev initial:oops HEAD:spoo &&
 	git reflog -1 | grep revert
 
 '

base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
-- 
gitgitgadget
