Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E748C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 20:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiKSUGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 15:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSUGv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 15:06:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6D19C01
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 12:06:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p16so5930856wmc.3
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mG5fibYC0M5R5ywo9rwDBRcW9yB3BiJ3QO/ZEQyXI98=;
        b=KezHJm5qw0W1h1gqkHLCJQRIxymrBJy4y0VvkO5oU6KY+up3VjdornkD254gQHxY+5
         m74mNQaUxGfMgkLnxVBcxE3XeqFQu+lqKdQHdsrwiImgc6NvL3WDSGBj9vAkyccrpqfA
         h0IHxqQHcrTWuHVqPOBkjOH7i83AkkWQ7UmljsJ/V8n4kmrbV4FXMADk6HrLLhfxbGAD
         V9j4651jAnl1xULHruDIeAGxJLO+d0xIXBVwCIir32eBKH+gWrf4k7rfgf7zlxgprgQ+
         cGEYBZNMXU86166sM4+EnFgPi8YSGOtcZakutSDbC+v6ee/k9yGDIHrLVdNzEKYlguUm
         9HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mG5fibYC0M5R5ywo9rwDBRcW9yB3BiJ3QO/ZEQyXI98=;
        b=kLHbcg9vi2q4JCbdBwFaepnOFNXnOpN4T4lUcRnI7aX7kaokCdVG91GW6gkiMZ+q+2
         RlFl2Ol+lmcZ86N3h0/Gr81CbSbdypTHkF98F69/i+6fJlaEzqFQ2qJHBWYu+gSrJ85n
         Rk5HYYTki5CBQjJaoISoj9J34SR/5Xaplvb1KqYjIN7qKIdL+aueIogiu63JCmxP7DAu
         5TzysQb3PNUDejm7cUQRx1COi8LtEAOA1oxax+LJ5Uy6umyGAEoGnZHYG5o0lzrDQ951
         lsjw8l0snEjhPE7VnYeei81W05DbJGf0RG18jP5yjO7BZCRHB9FM5+8YczL5PmqGEG4q
         QC1w==
X-Gm-Message-State: ANoB5pkz8IWVmMI4DDRKuSi2NIDA75+mREPgal3LuE+hPxIN4mQrBCvk
        q13i/eyDpy7wRAtzOWaq1bjqatSmY7U=
X-Google-Smtp-Source: AA0mqf5wEoNthBV8pbX/FWM38PssRYExJJmKXjWPjgqpu2V2rsK38hPoCToNrnH9u57kccBa2XONFQ==
X-Received: by 2002:a05:600c:3507:b0:3cf:8e62:f907 with SMTP id h7-20020a05600c350700b003cf8e62f907mr8524453wmq.7.1668888408542;
        Sat, 19 Nov 2022 12:06:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t65-20020a1c4644000000b003cfa622a18asm12818926wma.3.2022.11.19.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 12:06:48 -0800 (PST)
Message-Id: <pull.1422.git.1668888407433.gitgitgadget@gmail.com>
From:   "Stefan Sundin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Nov 2022 20:06:47 +0000
Subject: [PATCH] Makefile: suppress macOS deprecation warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Sundin <git@stefansundin.com>,
        Stefan Sundin <git@stefansundin.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Sundin <git@stefansundin.com>

Compiling git on macOS 13 emits the following deprecation warning:

        CC compat/fsmonitor/fsm-listen-darwin.o
    compat/fsmonitor/fsm-listen-darwin.c:495:2: warning: 'FSEventStreamScheduleWithRunLoop' is deprecated: first deprecated in macOS 13.0 - Use FSEventStreamSetDispatchQueue instead. [-Wdeprecated-declarations]
            FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
            ^
    /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/FSEvents.framework/Headers/FSEvents.h:1138:1: note: 'FSEventStreamScheduleWithRunLoop' has been explicitly marked deprecated here
    FSEventStreamScheduleWithRunLoop(
    ^
    1 warning generated.

Setting a minimum macOS version will suppress this deprecation warning.
Using a version lower than 10.13 will cause other warning messages to
be emitted.

Signed-off-by: Stefan Sundin <git@stefansundin.com>
---
    Makefile: suppress macOS deprecation warning

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1422%2Fstefansundin%2Fmacosx-version-min-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1422/stefansundin/macosx-version-min-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1422

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 4927379184c..8a729efd2d1 100644
--- a/Makefile
+++ b/Makefile
@@ -1430,6 +1430,7 @@ ifneq (,$(SOCKLEN_T))
 endif
 
 ifeq ($(uname_S),Darwin)
+	BASIC_CFLAGS += -mmacosx-version-min=10.13
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
 			BASIC_CFLAGS += -I/sw/include

base-commit: eea7033409a0ed713c78437fc76486983d211e25
-- 
gitgitgadget
