Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E699EC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376647AbhLBSnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376635AbhLBSng (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:43:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41EC061759
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 10:40:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o29so515224wms.2
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f9F7TJyomLrMSKcIkZcwHRa0eTQ9RZcolol+/4rLphg=;
        b=eL1/3Wh5C0XcyhraE7LvRwSywnoOO8huF/yjQAA+FvzGGb4VAR0j2iP6xcKQx2BAQt
         H9j9uqrw1E/kW5GmwTUCNFV8i5hTa0iJ7S2Jr3P4LtFBPzhAkt7GGjaaeqmPAQ/uxvXN
         IGWHatELgF9dKH1fbg5PgBuQhNhuaJjj9kg3KOl1oFV3xZwm9JNgM264FtS04UztE1Rb
         CayhPKZCs9KJtrpLJ8UtdfbfoR0uy0FKCpQJAdOlNuzrfzS31EHtHZICglegZX4RM3vq
         35O8Zp5KsgIoLf5CI7xnl4xfV91g238i/QvINXiqQFy3TzfN81our0itJIX8DX5LsUZy
         cTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f9F7TJyomLrMSKcIkZcwHRa0eTQ9RZcolol+/4rLphg=;
        b=BZFvBUb7Z0+IkhzGQiSxPKXG/Ix8SVzDUvkaAqtRf5Z1axLA1NvzAnNUgHZQ7rdYq8
         uiydtXzSzHkhZkYcbUuWZWDZf5fpfgK6ZIZN4tVz0EozeYhzq5fwBdRoFOhbW92ChCu5
         jlxB60xBAVC4wErAf5apHOUkMKQo5qOzD8JWZAgzwqklx2FW/Sr5XrHmPLFIX7zi43Co
         CVR43Vd0zjK3X3Vo0WVCpSOd7nvSo4vuzmPu4r3wIxbWoClCYymgnJVDV8KWGiS6c8j8
         4FK3FgfP3twBxE2lq2INxZtCLHg/by0jzquTjTbA4FUUw/lKSVwdmi/4hD97PrNip3iO
         R+Mg==
X-Gm-Message-State: AOAM531zgUMXmoflgU6Qy3VseU0ONUD01qhSxaTd1BBuWqJTMhQ5OTcw
        DHkep6y0/VxxhcB/PqacwH90vf9yTdE=
X-Google-Smtp-Source: ABdhPJzPxtYwjGZm2o9TimrOcNOLnCpVCIjZCJgBC93Y8icS8VcHNoN6Ika8gMraGHNu6MDnBm/Bvw==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr8459874wmh.140.1638470410413;
        Thu, 02 Dec 2021 10:40:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm518037wmq.46.2021.12.02.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 10:40:10 -0800 (PST)
Message-Id: <ca7f8aea3d9423bb3e572618920e4ca3b3f26492.1638470403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 18:40:02 +0000
Subject: [PATCH v3 8/8] t1430: create valid symrefs using test-helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This still leaves some other direct filesystem access. Currently, the files
backend does not allow invalidly named symrefs. Fixes for this are currently in
the 'seen' branch

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1430-bad-ref-name.sh | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 84e912777c5..ff1c967d550 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -153,7 +153,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch shadow one &&
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
+	test-tool ref-store main create-symref refs/tags/shadow refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
@@ -203,7 +203,7 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -213,9 +213,8 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 
 test_expect_success 'branch -d can delete symref to broken name' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
-
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -224,7 +223,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -233,7 +232,7 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref to brok
 '
 
 test_expect_success 'branch -d can delete dangling symref to broken name' '
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -243,9 +242,8 @@ test_expect_success 'branch -d can delete dangling symref to broken name' '
 
 test_expect_success 'update-ref -d can delete broken name through symref' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
-
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...ref &&
-- 
gitgitgadget
