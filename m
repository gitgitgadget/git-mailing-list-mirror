Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72171C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiCGVwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiCGVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700C75C1A
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j26so15096203wrb.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xlbCeNQWNBhbYdiaiIQr3UoMhNTyMmz1qIDgXuvHmzk=;
        b=D1/6d1e70WQiMcaUC5g2iIlw6GsLCzvSYreK7Y8DDEkefRkQJinmMYiF0Ie+HiRKoj
         M62mKh/P5Z7UAKXrw1MY94AcYFWanBNfiIzytQ8YB4vUinP0PhM/fLdnPM8/Lduwneua
         yws3eyZ6WP5oEk7qUo7cMGzoePD2YGmM5BElxLFTwaKj8Io5zMUMgvy20E2SBbQ4Tdcj
         0IKRLj4yVi4ACI/vXHkC17b2rfqkhunhBt3riGeRTCZ68/tB7xotwK6TTZmALkbaIYeb
         hOdJyLL+2WNPorov226CXEXCr/tMc/3m/3ulUaFwhiuC2MWLJimw+6mOxvL1uB9FaySH
         ljng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xlbCeNQWNBhbYdiaiIQr3UoMhNTyMmz1qIDgXuvHmzk=;
        b=LUllJ006mDPWFchVKMPGMZitDVzL73gFw7VGor022JglPx3Og8Rt4UgxZoaQCBFOCi
         xvVmXfnoEMoKMpHHxTxHXs712ALSrnVSvo+52gpr+VPmvMqxoK0HS/vrMmBBnnF7wYtw
         w9KmlGeQ+ZXfXDbIZHjUMbgwxjvKnnPVBy/icxZA26//CXndCZpssAD174hQxAZXppwR
         rhHdTyLNlYS3NAX0ifkHVSmNycQTqK4/faU2QYx3O8ybbfrpkz7mN9maJDJZPtN2nLMh
         RcP8b+gDXh0RtkosVLTRWT1+crtJK+B5fHNtIEroVjSuzB8Gg81UftA7LTyIGC5ZUVtw
         vMcQ==
X-Gm-Message-State: AOAM530f+Xl3dD9PohMkzbzru9gL252YclpYNsGyyx3YghxRt48YcxBD
        Fx+8ZmVlv18dv86iBkous7BwjS1N9cE=
X-Google-Smtp-Source: ABdhPJytRjw2zbapdgRvlUl6dxyMBRz47irB32NUuWT3gRFBz/gvrkQUO6t9VybmDWWkHMczLhWdhQ==
X-Received: by 2002:a5d:59a5:0:b0:1f0:bf:64c9 with SMTP id p5-20020a5d59a5000000b001f000bf64c9mr9785032wrr.352.1646689848412;
        Mon, 07 Mar 2022 13:50:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17-20020a5d4651000000b001f1f307d080sm4374530wrs.29.2022.03.07.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:48 -0800 (PST)
Message-Id: <19694d5b255227f2314456118c2c7fc986ae52a0.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:35 +0000
Subject: [PATCH v2 07/12] bundle: safely handle --objects option
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

Since 'git bundle' uses setup_revisions() to specify the object walk,
some options do not make sense to include during the pack-objects child
process. Further, these options are used for a call to
traverse_commit_list() which would then require a callback which is
currently NULL.

By populating the callback we prevent a segfault in the case of adding
the --objects flag. This is really a redundant statement because the
command is constructing a pack-file containing all objects in the
discovered commit range.

Adding --objects to a 'git bundle' command might cause a slower command,
but at least it will not have a hard failure when the user supplies this
option. We can also disable walking trees and blobs in advance of this
walk.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               | 10 +++++++++-
 t/t6020-bundle-misc.sh | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..dc56db9a50a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -451,6 +451,12 @@ struct bundle_prerequisites_info {
 	int fd;
 };
 
+
+static void ignore_object(struct object *obj, const char *v, void *data)
+{
+	/* Do nothing. */
+}
+
 static void write_bundle_prerequisites(struct commit *commit, void *data)
 {
 	struct bundle_prerequisites_info *bpi = data;
@@ -544,7 +550,9 @@ int create_bundle(struct repository *r, const char *path,
 		die("revision walk setup failed");
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
-	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
+
+	revs.blob_objects = revs.tree_objects = 0;
+	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
 
 	/* write bundle refs */
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index b13e8a52a93..6522401617d 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unfiltered bundle with --objects' '
+	git bundle create all-objects.bdl \
+		--all --objects &&
+	git bundle create all.bdl \
+		--all &&
+
+	# Compare the headers of these files.
+	head -11 all.bdl >expect &&
+	head -11 all-objects.bdl >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

