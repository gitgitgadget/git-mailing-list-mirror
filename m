Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8227EC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJTXRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJTXRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:17:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA3B22EE16
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:17:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t4so1073171wmj.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svkfji1k6LDFCJZwMooHOIrNztlzZv+3J9+p90ODSFo=;
        b=nbjzNdPX/xxWrbtT1sPmbVpyHw3O5t+5/AhWEfJ6HqDSuPXRlx9dkOFLqV2efVmPRB
         tT0p56E3zTAhmhaJ+ksZe228NOeOY+RaAaLXffRz46XCGZLaJekB65W7cAzgjPXwa5dB
         gqLbSxzVZ9/BPLFLTcAHP8vJHFV7IcN0+doBttzCjAX1BR2iWyN7iEJ/X7/s956J4g30
         c0wfof/NhQVjx0aMwtsGBPgbAkPRrgy0qqLlZa1kNbtoCH0CaOcrPpXozZrSO80aF8kx
         MxNz+h3vQz/C6eWL7wIO0sIB6dgYOcrnWCVpoXTayrpIrXnS3ZXeMr+XzL6kYFl74OZN
         pNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svkfji1k6LDFCJZwMooHOIrNztlzZv+3J9+p90ODSFo=;
        b=YxIMTIUVl9gJLognXUYowYRkefnD+XulkVXhYBbcLDHcfUU3bTpuEtlg/uq6/alkmw
         ZOloIsS2yQOH4tbKbWXiy0Np9kSO21P1OVWTVcZG2EutKBi9vlFgdkFPSsTbiXhdckxb
         fyeqmJFh0I3+a+YK527bYSwMzuNVmQoOMYYaEEkQKwxMf/5FpjAgF/tcHDEBXyaguzJO
         kaG2w02kU18GOnd9LeGKIZIKIQ5r3fmlrpnEUwBpWQycesUH4GIqphti6BqCHZ+NVrym
         0qemA4Va1Mvlw+2/ewaqEjIPLtxJMDXBVljGTRioMmjAJkIho+/D7Ga+cz1o+vg+Lr1n
         SdcA==
X-Gm-Message-State: ACrzQf31njg6wC5UaSSjXHVdiSEM4jy9Xx+/HAN66OfEpTxJ4WRx02F3
        Ss5BSz+aXluzZ/n/B4z0iK2pzlMLypo=
X-Google-Smtp-Source: AMsMyM7Lwgev2J2hWl6WX0dAY0K0yhCNZvdAtiPj3j0wdA2Xq8CbhGTFtazM/mZ9y+THYYfcGacA9Q==
X-Received: by 2002:a05:600c:1549:b0:3b4:8fd7:af4 with SMTP id f9-20020a05600c154900b003b48fd70af4mr10642752wmg.100.1666307824037;
        Thu, 20 Oct 2022 16:17:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c4602000000b003c5490ed8a6sm990916wma.8.2022.10.20.16.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:17:03 -0700 (PDT)
Message-Id: <dcdfac7a1539103926dd46e8c3d5c10fe640c0f3.1666307815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
References: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 23:16:55 +0000
Subject: [PATCH v4 6/6] builtin: patch-id: remove unused diff-tree prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <Jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <Jerry@skydio.com>

From a "git grep" of the repo, no command, including diff-tree itself,
produces diff output with "diff-tree " prefixed in the header.

Thus remove its handling in "patch-id".

Signed-off-by: Jerry Zhang <Jerry@skydio.com>
---
 builtin/patch-id.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index afdd472369f..f840fbf1c7e 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -74,8 +74,8 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		const char *p = line;
 		int len;
 
-		if (!skip_prefix(line, "diff-tree ", &p) &&
-		    !skip_prefix(line, "commit ", &p) &&
+		/* Possibly skip over the prefix added by "log" or "format-patch" */
+		if (!skip_prefix(line, "commit ", &p) &&
 		    !skip_prefix(line, "From ", &p) &&
 		    starts_with(line, "\\ ") && 12 < strlen(line)) {
 			if (verbatim)
-- 
gitgitgadget
