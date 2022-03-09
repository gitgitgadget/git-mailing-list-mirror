Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815AEC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiCIQD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiCIQCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:54 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D7A17F699
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1748655wms.4
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7/Vet349YwWXOD88+eWNxKjf9Jhn0cuBQkzK8diKGoU=;
        b=q4hpUf0Q47d1OmEAvIkW8tVQ15X+I7Sj3u2DURYD5Q6kT9GGFDiOPWBq8PiTkitvn7
         6n7UGDJEm3l68bf05mjSX6wRKZJlkfoF/KSAOtpGIJT4+CdDWRwa1bSo8Sn5EmfPtOd0
         rGgSPWk8i4yhU50/1BQ1JuQWyxJCpe8ZcZo2pbMMzmruwcpu6KEv7B278Y2FfeMWE99T
         /hWrnNDcZQ4waaqISyM2tFqyFkanCpE0s2Ll2IJ4o8oBTfK2FrS7jC1mclVP+bvNh7Bl
         dG4ERmRhzxMjrYOa7+IKrXAbPxgoNo4gc1IHSQy5rBU6dM+5CGU566Cy1KB1mkZ8WI0Y
         CGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7/Vet349YwWXOD88+eWNxKjf9Jhn0cuBQkzK8diKGoU=;
        b=IFFkA7rctMetKCBT2cAfaCAh0bRXumVoorL4hwENmhhY3YVObof0kwQhYw4T2qzyae
         CiAIPUG1r8VRX0YG2A6y4cVFuJa6aB8TrB2bIUFJ961juVWkprwC9hLGs7JvdrSLgWGd
         1oafF6oZOignpkEa0C82ASnrIWk9GIHAF7V8Wyg7VAZT9HJGKYZyrPj5dJ7w8WB3V6Dk
         yasVOnwuExEP/s/+eZTVecj33WHal7SYhfm7QZPR3uox5XgYbVBcpKffDK2c3+K7I5Qn
         GwFgmnzI2TF+6QsxITOoRAfXRiikxv4HpvI3PP+YIl7kqrSe6RAgtGVvbA1RYWPp1yDY
         q7Pg==
X-Gm-Message-State: AOAM532mF2mvrYmQvFmn+ySF+pfDFlgqKAsfBmCVzJoPplRto+qy8bSI
        SD3P9Oe2cjcM5QNtGlYqfepsamtY1cM=
X-Google-Smtp-Source: ABdhPJzdPfSodIppS9fant2JbYMG+912kU4KDPnrsZGNIe2J3vZ/AEFPP40MJNknu46FOLelzOfu4Q==
X-Received: by 2002:a7b:c253:0:b0:389:bbf4:f431 with SMTP id b19-20020a7bc253000000b00389bbf4f431mr8108679wmj.65.1646841706911;
        Wed, 09 Mar 2022 08:01:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm2121056wrg.62.2022.03.09.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:46 -0800 (PST)
Message-Id: <a1eb4dceb0b1444427c0358948c57bafc513918f.1646841703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:31 +0000
Subject: [PATCH v4 01/13] index-pack: document and test the --promisor option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The --promisor option of 'git index-pack' was created in 88e2f9e
(introduce fetch-object: fetch one promisor object, 2017-12-05) but was
untested. It is currently unused within the Git codebase, but that will
change in an upcoming change to 'git bundle unbundle' when there is a
filter capability.

For now, add documentation about the option and add a test to ensure it
is working as expected.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-index-pack.txt | 8 ++++++++
 t/t5300-pack-object.sh           | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 1f1e3592251..4e71c256ecb 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -122,6 +122,14 @@ This option cannot be used with --stdin.
 +
 include::object-format-disclaimer.txt[]
 
+--promisor[=<message>]::
+	Before committing the pack-index, create a .promisor file for this
+	pack. Particularly helpful when writing a promisor pack with --fix-thin
+	since the name of the pack is not final until the pack has been fully
+	written. If a `<message>` is provided, then that content will be
+	written to the .promisor file for future reference. See
+	link:technical/partial-clone.html[partial clone] for more information.
+
 NOTES
 -----
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 2fd845187e7..a11d61206ad 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -315,8 +315,10 @@ test_expect_success \
      git index-pack -o tmp.idx test-3.pack &&
      cmp tmp.idx test-1-${packname_1}.idx &&
 
-     git index-pack test-3.pack &&
+     git index-pack --promisor=message test-3.pack &&
      cmp test-3.idx test-1-${packname_1}.idx &&
+     echo message >expect &&
+     test_cmp expect test-3.promisor &&
 
      cat test-2-${packname_2}.pack >test-3.pack &&
      git index-pack -o tmp.idx test-2-${packname_2}.pack &&
-- 
gitgitgadget

