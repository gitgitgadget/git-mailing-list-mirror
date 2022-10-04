Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3502C4167B
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJDQUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJDQUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6371315FDA
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u10so22013391wrq.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=+1rAY0GN/bT2z9a1WjLDfsxiqq2/WV2ktnylJJE6aWE=;
        b=TPbO9CKzMaTcpbxOYKYA9shhLESe3tPmx+aNq1O6lvPlTkTj3pfuxau9mceycMQEz3
         9MwDN6btzLqEJugS8ZRqsHqvDxo3Yt8lwV5K0d6FVU2EkBDAFaa5oo5AUWLeJMcBiww4
         Lqi2WUEMnFmiWY/WWlhvkMhrC7yuFkcPZBuaZugd60USyiBbylqzrEnpHXKJMXnXDMHp
         CQjx5aiGLurZwkrtBM/JT8946O5GmKANmx8VLsUZn6Ja3GgVSZeLz7tiXbdr9e5RANVs
         eNBFkWPSraloEXoP0TpUmpnU/XgAaxvgA/4xEsbgBsFjb/5+IB0imMxHz0mgB89EtFbi
         nXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+1rAY0GN/bT2z9a1WjLDfsxiqq2/WV2ktnylJJE6aWE=;
        b=mV1XPdrb01pUuDj94hfWNMGwHUN5drb9bnMUnf5xeimQfbj5PHqt9/l/3hDasO5eAb
         Ktm8EYRk/IWux2y1Q/cBfGKz64g/q+T87i23vew3fsDLF047CwYi/ip+Onc9JjKCTY8o
         Y81gX3Es5CVunM6o6HBQ9krFZRiVtSQHkNS636oSJCL5KlNNlI3Tn3By2Yyfh4AKfBhv
         xEKxqsNDa6zTwp/HdmLu6Br9f+jecIF3x5rPlnExcPmb7KDm2GlIEt21V16C01iHKPDR
         VMocsICKnsx3L88pOI+Cmc9ps7lTi5fgrhyoVk0VxA2durqTZ5pYRa0HcaDrVE1zRBeL
         ZVaA==
X-Gm-Message-State: ACrzQf2WyhwNYANsjVTMQNrJ8ZCrlhp+fBTvRTrFGXIFYGU3T+yGCr8k
        0sAKMyJl4WGHAMYVZV3cqA4ADurYvPE=
X-Google-Smtp-Source: AMsMyM7BW3jwvM5eNh+VDCLsrIN1xDFpfAW0V/Bdebyg64/csYS09dsyF4rCP1sSvVV1wJqLeLNKRw==
X-Received: by 2002:a5d:44c4:0:b0:22e:31cd:afe7 with SMTP id z4-20020a5d44c4000000b0022e31cdafe7mr9824137wrr.246.1664900409696;
        Tue, 04 Oct 2022 09:20:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d424f000000b0022afe4fb459sm2261742wrr.51.2022.10.04.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:09 -0700 (PDT)
Message-Id: <870f29166ea5d5c73bd724c862a59d9702a6fe26.1664900407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:19:59 +0000
Subject: [PATCH 1/9] builtin/merge-file: fix compiler warning on MacOS with
 clang 11.0.0
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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/merge-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c923bbf2abb..607c3d3f9e1 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -26,9 +26,9 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
 	const char *names[3] = { 0 };
-	mmfile_t mmfs[3] = { 0 };
+	mmfile_t mmfs[3] = { { 0 } };
 	mmbuffer_t result = { 0 };
-	xmparam_t xmp = { 0 };
+	xmparam_t xmp = { { 0 } };
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
 	struct option options[] = {
-- 
gitgitgadget

