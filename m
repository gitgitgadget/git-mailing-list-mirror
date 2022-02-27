Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1FFC433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 21:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiB0V5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiB0V5m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 16:57:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6706E4E4
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 13:57:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s1so12561473wrg.10
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EdSnZjga/5cIlJUUS7B6LIsEUkSZAyJoyTL/7IWFXpQ=;
        b=R+mEYaVyYNgpOsbPI+lJTTMyY0/JRL1Hsg4EQAvhSK0a/oHqvvid36DJP2j/ooHSyt
         p9tvNSrsnaGy5AvlyRWIj9Z+YF4DoyEP7J9mRqx3Oq/Knjv6PiS4NNjc51D4gvV8UfSH
         /l0SuL0iHlSidEZkycz5hisX2ers80A2GqFncCzwHCCMlZl8S2VtYXeZbytsID21gAZ3
         XYTmcRCUA023+yzqBdBRDkuLzX6efS2Id16UQ0QINO31D+NFv24VX86CMeshzF/fPbmF
         YFn2TnSbz1cxKSUBD5a7Wu03km0gxN76YHZKQD19p93Oy06/syuQFQU+aTqL+WHhF526
         1MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EdSnZjga/5cIlJUUS7B6LIsEUkSZAyJoyTL/7IWFXpQ=;
        b=Kh6ajwTJ5i7KRMDN309FiOMLyoK7WUrax9iutTNXN2bvOoaRHHWDdoJFHkQMCSe/BR
         aSBga4StWaMUnazDeraUTuERIUvoxSehqBI8zys9N7ZtDCJL/HXAObhHde58GHpJdreo
         P/pctKB67fEgVi5jZccRS/D4VaTw4iKe/FR0Jcalf2Va88rXb4yJ4J0N7fCzef9VUgNq
         /DfS2ASoIooeCtzeOywbBaVPdOOAlQAg9KVuVbR+TpP4p7h2a2KRIFba0utlvXA4guCq
         6B/7VCVSszxITHVbAdDZ3xELcWIYr2Dutfvxk/09Ux8YmMRWa7n9yr5+6ZAErAgFu0rX
         iMMA==
X-Gm-Message-State: AOAM533CO6Qm54gIwzPfFCW4KIRlR8FdcCJAGaE30zgKOxyh9khFnAbJ
        Eoz6PkK2kdC4WAcnIdo4A0VXNxceblc=
X-Google-Smtp-Source: ABdhPJxN32cdyISB++9SYEUVSGBbrNaIatrrrgV3fLW4RiLwlbHL3vNid1hf5Ap1PS5VJ3ZvXBNsrQ==
X-Received: by 2002:adf:a2d5:0:b0:1ed:bf30:40e1 with SMTP id t21-20020adfa2d5000000b001edbf3040e1mr13113455wra.388.1645999023854;
        Sun, 27 Feb 2022 13:57:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm8494956wru.101.2022.02.27.13.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 13:57:03 -0800 (PST)
Message-Id: <8b1f89c259e46f5b09f24e1e94614136365e4f69.1645999021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.v3.git.1645999021.gitgitgadget@gmail.com>
References: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
        <pull.986.v3.git.1645999021.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 21:56:59 +0000
Subject: [PATCH v3 1/3] t7519: avoid file to index mtime race for untracked
 cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In t7519 there is a test that writes files to disk, and immediately
writes the index with the untracked cache. Because of
mtime-comparison logic that uses a 1-second resolution, this means
the cached entries are not trusted/used under some circumstances
(see read-cache.c#is_racy_stat()).

Untracked cache tests in t7063 use a 1-second delay to avoid this
issue, but we don't want to introduce arbitrary slowdowns, so instead
use test-tool chmtime to backdate the files slightly. The t7063
delays are a #leftoverbit, to be worked on in a separate series.

This change doesn't actually affect the outcome of the test, but does
enhance its validity, and becomes relevant after later changes.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7519-status-fsmonitor.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index a6308acf006..3f984136ea9 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -324,13 +324,19 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		cd dot-git &&
 		mkdir -p .git/hooks &&
 		: >tracked &&
+		test-tool chmtime =-60 tracked &&
 		: >modified &&
+		test-tool chmtime =-60 modified &&
 		mkdir dir1 &&
 		: >dir1/tracked &&
+		test-tool chmtime =-60 dir1/tracked &&
 		: >dir1/modified &&
+		test-tool chmtime =-60 dir1/modified &&
 		mkdir dir2 &&
 		: >dir2/tracked &&
+		test-tool chmtime =-60 dir2/tracked &&
 		: >dir2/modified &&
+		test-tool chmtime =-60 dir2/modified &&
 		write_integration_script &&
 		git config core.fsmonitor .git/hooks/fsmonitor-test &&
 		git update-index --untracked-cache &&
-- 
gitgitgadget

