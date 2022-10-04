Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E55AC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJDQUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJDQUN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF7537F85
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y23-20020a1c4b17000000b003bd336914f9so1125594wma.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Q470/AW/fzJLALcfpXWcJESIG0LEmZ5xOneOpJj2PFw=;
        b=bYTJGzIUw9tXFBBGxGIaB88Vl2asNXVjFP6edy3XY5ymWi/QNP/xlskUBYB05MUD7M
         LzTiRzaomIKZSGLYBjsChxA9B5E/chGutz7P8SXIOp9Y+XQMn/cPTaSA8tVAwAm9MYBZ
         qkE34sLTAWSI2eZSrNn2P/W0Co1Y5m01yYyaUZD3lFM3o+x90wxp8pxUT0rhhNZguJLI
         pPIXABQakvXkfIog1tLZSn132dHQSD3c1AFyyjv0kbTS96ke+sbTz3D7fV98nGqNFTPe
         JscZbbEr6twABm8f3P6PlCA6nHZ/Z7fjWwrwpd2CrfXebEzQ+C3xxykFISi7YTieflTN
         Bfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q470/AW/fzJLALcfpXWcJESIG0LEmZ5xOneOpJj2PFw=;
        b=NVfKdUy9rCwj9ca0rkXdW043Fw/W3wpatPd271P2dc6pilwTjwkC3W3sjYBvrhLEvL
         /z8tI81kWjDcOm7soJ+Pm3C6tC8Jc2ky7E0nYOqX55vJuLlqTov0b67uQ4/6EslPXDqJ
         25vo2fTO55KsBDcSi52J2Ug26k23RdkOXCuHW5QViqPFiwtUQxKyG2bAlPMX3Cedm/0D
         xyM60GGP7P6tDesvXFxYrRgVMFd4eW4lUWjRtYjc1WlK0hbDNA0RhiIs06ztC/NVMZgq
         JD+CJjrXPioDRl4E4GABwMeAqNjzLb+rGYWyy+/HnnFNissG9AHUr5XTv2TIZd7CECUh
         3Uag==
X-Gm-Message-State: ACrzQf0D6tafgyqLbhZ0plTdk8yqDju0XZnZKAT1zKFcQDeRfsrot7g3
        xQHYYb955eTzaS3LQMOJrMmf8jwzWnE=
X-Google-Smtp-Source: AMsMyM7P1XgbO3ektuOo+HC7homgkN4oTc68USXJ09sirktuAd+aUQFIyruFPLs9Debf+6GhEj3xTQ==
X-Received: by 2002:a7b:c845:0:b0:3b5:5e45:b266 with SMTP id c5-20020a7bc845000000b003b55e45b266mr409172wml.82.1664900410542;
        Tue, 04 Oct 2022 09:20:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003b339438733sm14722702wmi.19.2022.10.04.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:10 -0700 (PDT)
Message-Id: <43c41f7035d6f5d1f34d847da833ba8f5a6a13be.1664900407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:20:00 +0000
Subject: [PATCH 2/9] builtin/unpack-objects.c: fix compiler warning on MacOS
 with clang 11.0.0
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
 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef29..4b16f1592ba 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -385,7 +385,7 @@ static const void *feed_input_zstream(struct input_stream *in_stream,
 
 static void stream_blob(unsigned long size, unsigned nr)
 {
-	git_zstream zstream = { 0 };
+	git_zstream zstream = { { 0 } };
 	struct input_zstream_data data = { 0 };
 	struct input_stream in_stream = {
 		.read = feed_input_zstream,
-- 
gitgitgadget

