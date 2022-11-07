Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47610C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiKGShv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiKGShG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083A28723
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w14so17542885wru.8
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38oRreVhhfsA7kisxxjdPWw3Yc606kjdNdKLEY0xtR4=;
        b=bd+kMAQN4Ejso+PiQj1q/30Em+aXgSF681IImzOAWWu+6Uz6T5Js61NMHdSpmTKUxI
         S1XyNcvOil+Ev+ExM/sy8pY0pqQ8rBj3iIy+00shvD/TKY11gghqB8jiLHpBZM+ktuyr
         /Ze9RtWDLsSnjkwXCArQbHn/mJAPRWD4o1zqPg9KpDrAG4QK7OP8dO1YVQHRkxXxiLaH
         AXMAbRwGae9RCVNyKaYR1ekTfiVkWcXq30FgyWvIOdkIVmmwfyNBpCPBEJZXRx3NUKCn
         Qh29UsL/2Bm74eSFY9OwFgnYo6qbCIUYyDO9PBfUKsfLJS2W0H8HdvwHOqH1+vbp5K4W
         +faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38oRreVhhfsA7kisxxjdPWw3Yc606kjdNdKLEY0xtR4=;
        b=s6q9SDzRXFX8YNVr3VtM4YIe4YcvYSsB0rJ6dUvbX1mcnSgllMjBANr1FKMbpf+ZmH
         UqCjFArCi+TY048t2z2P4YbFNBmqSNV0NZ9mKDfQ6UYOPt3W7EotDT6Yzcq/SqbX33jj
         MSPeqA+zV26jYvMoLHmhoP8mkyMmViUoBp7qUPOW11SSITCNI3sJJI9We62vscr43A7O
         dW+dj8jSQyGx7HsK9O7ilopVSSnubRHfjgbIvVpR279ME+Ch+B4fAM9mIiXKCYAxcGUN
         vbII5dtWPz8rLwl9VPIyuoD30S9CmiKubA0LYoZLwpBMgnSEpJfN1B4Tli6FgTfgnV3s
         vYEA==
X-Gm-Message-State: ACrzQf3ZQzqZ4nrH3Ss3eJ6ssNEppueCwODF/v5QLEjC+ebqnkyoZPg5
        YurUlh3bdxRRxnOi9ADDn4UoLo1SqNk=
X-Google-Smtp-Source: AMsMyM7RkTE/ymmav7p43E5GX2TpNL5+fh/hbrMq9qCJ9ht+/zF6ZNzLfC4xiaLlWhMeVBs7RgiWUA==
X-Received: by 2002:adf:e90d:0:b0:236:7129:d7e6 with SMTP id f13-20020adfe90d000000b002367129d7e6mr33248312wrm.398.1667846192125;
        Mon, 07 Nov 2022 10:36:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17-20020adfed11000000b00236863c02f5sm7842128wro.96.2022.11.07.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:31 -0800 (PST)
Message-Id: <e6ed6e7607c4ce81876f281152c675fc14f0498c.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:36:00 +0000
Subject: [PATCH 26/30] t3210: require packed-refs v1 for some tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Three tests in t3210-pack-refs.sh corrupt a packed-refs file to test
that Git properly discovers and handles those failures. These tests
assume that the file is in the v1 format, so add the PACKED_REFS_V1
prereq to skip these tests when GIT_TEST_PACKED_REFS_VERSION=2.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t3210-pack-refs.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index fe6c97d9087..76251dfe05a 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -197,7 +197,7 @@ test_expect_success 'notice d/f conflict with existing ref' '
 	test_must_fail git branch foo/bar/baz/lots/of/extra/components
 '
 
-test_expect_success 'reject packed-refs with unterminated line' '
+test_expect_success PACKED_REFS_V1 'reject packed-refs with unterminated line' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%s" "$HEAD refs/zzzzz" >>.git/packed-refs &&
@@ -206,7 +206,7 @@ test_expect_success 'reject packed-refs with unterminated line' '
 	test_cmp expected_err err
 '
 
-test_expect_success 'reject packed-refs containing junk' '
+test_expect_success PACKED_REFS_V1 'reject packed-refs containing junk' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%s\n" "bogus content" >>.git/packed-refs &&
@@ -215,7 +215,7 @@ test_expect_success 'reject packed-refs containing junk' '
 	test_cmp expected_err err
 '
 
-test_expect_success 'reject packed-refs with a short SHA-1' '
+test_expect_success PACKED_REFS_V1 'reject packed-refs with a short SHA-1' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%.7s %s\n" $HEAD refs/zzzzz >>.git/packed-refs &&
-- 
gitgitgadget

