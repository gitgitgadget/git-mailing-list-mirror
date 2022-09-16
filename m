Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641DAECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiIPTyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 15:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIPTxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 15:53:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E9B81FC
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:53:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n10so7073165wrw.12
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=025X2g9D0LRmHIXCb4ajLdQRUPyvqsq2+nEHj3JaJps=;
        b=kdv0URdQqcazDbmr66/oUnicHUmHWIhER3B7WIZIHTMpaqT0hw9eXite81YXad4gMY
         wXyLxXuN/MnEt7V9vste1wQBRXZ8YsuURj+lBUTRHnkgoomq7HRfb1lnXns++mMXdzrY
         UI1sPZqbaXxHgnK3/8iznz9dmfzkB/HQNPeuuBISqBwzeyvrfa149ubEw530vHBQAN1n
         +EWih40agcd18YBkt/HK01AM6Q4UP5QaiqB1RrEWn23MYZzgdS8vL/4rNtTY/p9xefnU
         UwmmpAvbHAgbJQdzV6etIQN46BTI8iTLIXH31TGFW8ikZ2V0aRZciDYSetvkDGKUVezr
         rhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=025X2g9D0LRmHIXCb4ajLdQRUPyvqsq2+nEHj3JaJps=;
        b=6wUbQSe/Bm+SLToJRKxls89C732pCaneF1sxfEI6tRDmH2O5QDc4/N8iBcd5UddtLU
         lUQtFVislYAoZYYtmiLpTNtWAxieguJ9lQ92PR9M++hJcUfvQtAxrlVNG0RK0I8Oh22W
         C7TL51b3fwC33oN6GhRdorC6YvrQAFCtFKY6/HiBV4sDAN9VZwLFDKB1RtEngNFfVzo8
         p5/6cO5bpn6AmFUjRaql39hByi1tNyAkUgvIKPA9eKQGNyxAk1JjNQnAV4SZ+skyJ3ro
         vPoZxwumZcGqluXI8sg59YAo1maCp39NslIPhMzE5HK0FE+yKStHFz8AijAxvDqw6W8X
         iysQ==
X-Gm-Message-State: ACrzQf2LPs8f0P81OTmBQsB/0KyWkGG/hRWmwgz1LTdsrr9Zj6Wi4sil
        3mdUV0Ve+C/rt2qVLrQ2FqOn4Cguufk=
X-Google-Smtp-Source: AMsMyM5WAMb2IIlvn2ZWDlDh+XUwXLVP8JmYL5AJ902D1Mu257FjsgXPc2ciqo7zola7HqjwXYkTVQ==
X-Received: by 2002:a5d:47a1:0:b0:22a:2979:4899 with SMTP id 1-20020a5d47a1000000b0022a29794899mr3665098wrb.349.1663358022375;
        Fri, 16 Sep 2022 12:53:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003b477532e66sm9441611wmg.2.2022.09.16.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:53:42 -0700 (PDT)
Message-Id: <260591f58202c2a771f59beb09f11b63e853a1f9.1663358014.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 19:53:34 +0000
Subject: [PATCH v7 6/6] fsmonitor: add documentation for allowRemote and
 socketDir options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Add documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'.
Call-out experimental nature of 'fsmonitor.allowRemote' and limited file
system support for 'fsmonitor.socketDir'.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Documentation/git-fsmonitor--daemon.txt | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index cc142fb8612..0adccd0eced 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -70,6 +70,41 @@ the change (as happening against the super repo).  However, the client
 will properly ignore these extra events, so performance may be affected
 but it will not cause an incorrect result.
 
+By default, the fsmonitor daemon refuses to work against network-mounted
+repositories; this my be overridden by setting `fsmonitor.allowRemote` to
+`true`. Note, however, that the fsmonitor daemon is not guaranteed to work
+correctly with all network-mounted repositores and such use is considered
+experimental.
+
+On Mac OS, the inter-process communication (IPC) between various Git
+commands and the fsmonitor daemon is done via a Unix domain socket (UDS).
+Usage of UDS requires the creation of a file which, by default, is created
+in the .git directory.  If the fsmonitor daemon detects that the .git directory
+is on a network-mounted file system, it will create the UDS file in $HOME.  If
+$HOME itself is on a network-mounted file system or if $HOME is not the desired
+location for the UDS file, 'fsmonitor.socketDir' may be set to any valid, local
+directory on a file system with proper support.  Mac OS native file systems have
+the required support.  File systems known to lack support include FAT32 and
+NTFS.  Other file systems may or many not have the needed support; the fsmonitor
+daemon is not guaranteed to work with these file systems and such use is
+considered experimental.
+
+CONFIGURATION
+-------------
+When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
+the fsmonitor daemon will pay attention to the following configuration
+variables:
+
+fsmonitor.allowRemote::
+	By default, the daemon refuses to work against network-mounted
+	repositories. Setting `fsmonitor.allowRemote` to `true` overrides
+	this behavior.
+
+fsmonitor.socketDir::
+	This option is only used by the Mac OS implementation of the fsmonitor
+	daemon.	If set, 'fsmonitor.socketDir' must be set to a valid, local
+	directory on a file system that can support Unix domain sockets (UDS).
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
