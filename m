Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B20C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiDMPfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiDMPe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:34:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681E137A2B
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:32:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r133-20020a1c448b000000b0038ccb70e239so4205982wma.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ji0NAditMXl5ctb46aPe6cOYJYjiihFfAaIH+FVMaQ=;
        b=llUta0KPIGOPM2eByHYhTEGsRJOdTgyCK/f5mg/4kvLFD3jxIXh+LKB08no3NPXLVT
         /7ANuOT9IenP2EjG5z2DPGY9RIrRGMll0EaUqZgLrJK7nhvqf6a4znrqJfMQiNARX1Hp
         mgEIe1DWEzpQXVgLai8sLLopUi9dKGDkVi4zUQeP/dgFIalDyUd/5PVMKFpx4ZmsTZcF
         RC8UaPZdDAs+7ckjX/4Q5LBDCX8QoDU8Kk5PKKZPW3thREGZCfNjjXGFC5lHImWmKGCy
         S78Y+j8mWZ5CHxO9pK/nnc5TdG4mwx5Wuc5s/Kxlip0tT4clapDIFpx0SGsDNLhFDOKD
         zugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ji0NAditMXl5ctb46aPe6cOYJYjiihFfAaIH+FVMaQ=;
        b=B/WkIujfjSmAjWlgSRqGBdyDLxrpW26ef/gDvsBMwjZ4aYx4GJHXOfgxcbYHueVAv2
         6+wrFV7K8hoTizYEat44yn+r5G0f1ymDlxCfP8PsxAGihKfOhRdf8uxBU6B5BBaSVUw7
         9gf+fqe1iIfURK19z6ur4LBfjqYXkiBKmGzw9VTmP8IrXId97/yvhMVKLSWQkSo8380q
         mzQBvElQ7rqp0zLHa1h0tXlf/tCso1ftup7V8ME96RmwiXz5Ypt8bE17Co+m4ms8/Tgv
         /wB5wxOizQsw9r5BtrSiBpJ5ppjRelC+LZ0Arl//rb8VjerxsQ94YzbkEwuVIz55bDKh
         U8/A==
X-Gm-Message-State: AOAM530jVmEhEc5D2of2aw1qmWQtatMDl8ha2pTyHJf+YmsroSc2n1X1
        dBfsUV4wbkPcO/aNpV32KLXHm5HoF10=
X-Google-Smtp-Source: ABdhPJw1AviMMeSSy77rE142PA4lE2g/Q6vFB2K4eG9CdsXFHnJJUT5G7zER2E32ZnI+sfWdWXWEoA==
X-Received: by 2002:a05:600c:3c8d:b0:38e:4bc6:abde with SMTP id bg13-20020a05600c3c8d00b0038e4bc6abdemr8884801wmb.13.1649863955763;
        Wed, 13 Apr 2022 08:32:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f186-20020a1c38c3000000b0038ea84ab7desm2745064wma.45.2022.04.13.08.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:32:35 -0700 (PDT)
Message-Id: <8a06688c121195f21472e3e49efd2b034b1537fc.1649863951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
From:   "Matheus Valadares via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 15:32:30 +0000
Subject: [PATCH 2/3] setup: fix safe.directory key not being checked
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Matheus Valadares <me@m28.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Valadares <me@m28.io>

It seems that nothing is ever checking to make sure the safe directories
in the configs actually have the key safe.directory, so some unrelated
config that has a value with a certain directory would also make it a
safe directory.

Signed-off-by: Matheus Valadares <me@m28.io>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 setup.c                   | 3 +++
 t/t0033-safe-directory.sh | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/setup.c b/setup.c
index f54f449008a..a995c359c32 100644
--- a/setup.c
+++ b/setup.c
@@ -1100,6 +1100,9 @@ static int safe_directory_cb(const char *key, const char *value, void *d)
 {
 	struct safe_directory_data *data = d;
 
+	if (strcmp(key, "safe.directory"))
+		return 0;
+
 	if (!value || !*value)
 		data->is_safe = 0;
 	else {
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 9380ff3d017..6f33c0dfefa 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -21,6 +21,11 @@ test_expect_success 'safe.directory does not match' '
 	expect_rejected_dir
 '
 
+test_expect_success 'path exist as different key' '
+	git config --global foo.bar "$(pwd)" &&
+	expect_rejected_dir
+'
+
 test_expect_success 'safe.directory matches' '
 	git config --global --add safe.directory "$(pwd)" &&
 	git status
-- 
gitgitgadget

