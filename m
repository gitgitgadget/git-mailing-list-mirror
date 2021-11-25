Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A93C4332F
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356458AbhKYQM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353833AbhKYQKz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:10:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0ADC0619E3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so12586277wrw.10
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=I77iRFddyKGP1wP1RsadIJW2tiScWP33mdv8ENEa8iY=;
        b=GznWbohT/iu6V7YX0OPcvx0SvsYzR42GHi6PoYGyKCLTNQ3m17wNlZHrCpgeM9FiCE
         9B3yqlARHcHb6nasrMNAy153JDLjKUVVvyQCBhTivLbQzPAikjiIKKSkKgpFkHmHIygN
         KFUXLn3tmg3MI07rHZpjAfyIHpWE4NXGOrNhLVEtDgtOPtEI5EnpGyjnZTsaQEHgi3dR
         sKFv003TSg79vuhIPPqwQchq+1PKRrbYukyRszU2FEMxhb2Z0j8W0yrY9dolocH+oz/d
         4w2loshmJ5Dm5gwR69/kyV8evTXAeRF8m8I2SlSNblFyVp5ZiSqW4h49kD1EDQiW6zfq
         p+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I77iRFddyKGP1wP1RsadIJW2tiScWP33mdv8ENEa8iY=;
        b=MVtwyk/ikDHbZTpW/e0hHNeqOsoRmja41v0lQ/MmSpmasusPVGAx2Sxq4+yiAGMnxz
         acLRe2hy7/H+4Kq6drSSZk8/9tNDUiPKmOQoM0vmvSyt1tTiOA8eioYuN+CJodrKQmtI
         1r6GS0GOyLuzEqj07GuvOpmDfDimSEdUtwE2oemLsZoQpiZJgpWZ4/cTws6g0HN2WA09
         0zdeh2OZQDBSIJV/8QWAL3LXzGY8rWuZjQu710G+za4sNq5q9aDPpAQIL8GbOirp8O7k
         hI4GcR8Y03MjQhCjyZNECSwqz2kpA5ZemSt832b5J1iiV6qAehNIMFqoCDDKXOCFzh9l
         acDg==
X-Gm-Message-State: AOAM533Kv3IFS+NwXTgAQBrzetuWUj8956CEqvAsHdg/IB1pxcVlKoJC
        QfewqGTDOOX1s6YrZzae1AbXHO298ak=
X-Google-Smtp-Source: ABdhPJyHWMwiuPNSQrWLsc2HujyJWnkDT7zp1PY96/nt1RmSX3sTa7m+MQwkH22WmXXj2lWDIYed9g==
X-Received: by 2002:a05:6000:1788:: with SMTP id e8mr8133962wrg.45.1637855829916;
        Thu, 25 Nov 2021 07:57:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y142sm3382499wmc.40.2021.11.25.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:57:09 -0800 (PST)
Message-Id: <pull.1148.git.git.1637855828856.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:57:08 +0000
Subject: [PATCH] t1404: mark directory/file conflict tests with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The files backend uses file system locking on individual refs, which means a
directory/file conflict can prevent locks being taken. For example, in a repo
with just the ref "foo", an update

    (DELETE "foo") + (ADD "foo/bar")

cannot be executed in the files backend, as one cannot take a lock on foo/bar.

The result is a repo with just "foo/bar", which has no directory/file conflict,
and this is a valid transaction in reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    t1404: mark directory/file conflict tests with REFFILES
    
    The files backend uses file system locking on individual refs, which
    means a directory/file conflict can prevent locks being taken. For
    example, in a repo with just the ref "foo", an update
    
    (DELETE "foo") + (ADD "foo/bar")
    
    
    cannot be executed in the files backend, as one cannot take a lock on
    foo/bar.
    
    The result is a repo with just "foo/bar", which has no directory/file
    conflict, and this is a valid transaction in reftable.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1148%2Fhanwen%2Ft1404-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1148/hanwen/t1404-v1
Pull-Request: https://github.com/git/git/pull/1148

 t/t1404-update-ref-errors.sh | 40 +++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index b729c1f4803..fe7b6447cae 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -261,69 +261,77 @@ test_expect_success REFFILES 'empty directory should not fool 1-arg delete' '
 	git update-ref --stdin
 '
 
-test_expect_success 'D/F conflict prevents add long + delete short' '
+test_expect_success REFFILES  'D/F conflict prevents add long + delete short' '
 	df_test refs/df-al-ds --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents add short + delete long' '
+test_expect_success REFFILES 'D/F conflict prevents add short + delete long' '
 	df_test refs/df-as-dl --add-del foo foo/bar
 '
 
-test_expect_success 'D/F conflict prevents delete long + add short' '
+test_expect_success REFFILES  'D/F conflict prevents delete long + add short' '
 	df_test refs/df-dl-as --del-add foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents delete short + add long' '
+test_expect_success REFFILES 'D/F conflict prevents delete short + add long' '
 	df_test refs/df-ds-al --del-add foo foo/bar
 '
 
-test_expect_success 'D/F conflict prevents add long + delete short packed' '
+test_expect_success REFFILES 'D/F conflict prevents add long + delete short packed' '
 	df_test refs/df-al-dsp --pack --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents add short + delete long packed' '
+test_expect_success REFFILES 'D/F conflict prevents add short + delete long packed' '
 	df_test refs/df-as-dlp --pack --add-del foo foo/bar
 '
 
-test_expect_success 'D/F conflict prevents delete long packed + add short' '
+test_expect_success REFFILES 'D/F conflict prevents delete long packed + add short' '
 	df_test refs/df-dlp-as --pack --del-add foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents delete short packed + add long' '
+test_expect_success REFFILES 'D/F conflict prevents delete short packed + add long' '
 	df_test refs/df-dsp-al --pack --del-add foo foo/bar
 '
 
 # Try some combinations involving symbolic refs...
 
-test_expect_success 'D/F conflict prevents indirect add long + delete short' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short' '
 	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect add long + indirect delete short' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short' '
+	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
+'
+
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short' '
+	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
+'
+
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short' '
 	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect add short + indirect delete long' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add short + indirect delete long' '
 	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
 '
 
-test_expect_success 'D/F conflict prevents indirect delete long + indirect add short' '
+test_expect_success REFFILES 'D/F conflict prevents indirect delete long + indirect add short' '
 	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect add long + delete short packed' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short packed' '
 	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect add long + indirect delete short packed' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short packed' '
 	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents add long + indirect delete short packed' '
+test_expect_success REFFILES 'D/F conflict prevents add long + indirect delete short packed' '
 	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect delete long packed + indirect add short' '
+test_expect_success REFFILES 'D/F conflict prevents indirect delete long packed + indirect add short' '
 	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
 '
 

base-commit: 35151cf0720460a897cde9b8039af364743240e7
-- 
gitgitgadget
