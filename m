Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E3EC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiCKWu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiCKWur (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:50:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE69428A1F5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:24:56 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so6144148wmp.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VTRoXHcmJRiv+R6PaQ+KLr6RWweIZ2q+9od6IDw28Js=;
        b=UlJ6QgV+98oudrkehN0suKyfrJ0mSMkHJ2bBTZ6bNJg3Z4hRqQdm2R8AT6xX/j91Ty
         XUAKj/kZqxmoYn1xMOKhTnlInpmj7PjVIysGovmGrgWol9yLhmQELwBy2iVh57cyW+Xm
         lcvqI8CMbB8slrlGk1CyWHehxgIK37HsjIheQUbrj+1eQVfyXQeVsw9gBJMtCQI81MQY
         BIS0RBtxV5QvM5tkmBzeEJ9uCCqQv4tM+A6zTayza8n7NBklnRYpLrsL7lvsRy85LBDq
         3xZHtb87tQriYQ5uf98GYXaBKtIVxsJex15XOIBwh7AGuZxYfr58uqlY5tK1CB0HvxAn
         UZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VTRoXHcmJRiv+R6PaQ+KLr6RWweIZ2q+9od6IDw28Js=;
        b=QYQwEvFQLGc0i+NcqPhG70A6Fl1n/YQAJ+6uRtDCZzKmXnXaSnEmH771FqgQXFk5pM
         YzqxFYdYp8ZSSo6NT7GCdx7J0KjehSglkhXirVJwXLn/OozeyksfjWpvsBN/MORZX3e1
         NXcnXUR1Y4xSZ/pY6oe7Bz6HSVnna8wZdocJR9Mg2Z8ExDSId+yQRSpETqkEoIEtKOiG
         CDdERSvNgVuKQFoebcoq3uJb7TYgIIzk8N9hVhBpfWMmiE2g/B1W9QCbgTbiy73O9I0Z
         wKfc+4x0Q6iri7aporQw2eM1n3qeDeXTkS+LOqG+ZXBdWHn/6d3OkWMB21/iHlJef+u2
         JbOA==
X-Gm-Message-State: AOAM531DnIbujkuIwTFRIFVOTjKz3fFNILJJzEpqrdj6zd52AaWH7xus
        akBYrCQqjiVQC1LigFRVSQwVA52/saU=
X-Google-Smtp-Source: ABdhPJx6jT9nMs2P6fpCIwBufSLm40AxjdDBH8qEcbLNAS3+R2Mt0NpfERiMe/TsXqDkEO581lWu8w==
X-Received: by 2002:a05:600c:4e8f:b0:389:f440:512f with SMTP id f15-20020a05600c4e8f00b00389f440512fmr2881863wmq.134.1647033314112;
        Fri, 11 Mar 2022 13:15:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18-20020adfdbd2000000b001e4bbbe5b92sm8263723wrj.76.2022.03.11.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:13 -0800 (PST)
Message-Id: <25fc4c993422cfcc1fcf7d4432828a8df1bb25bd.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:59 +0000
Subject: [PATCH 12/16] compat/fsmonitor/fsm-listen-darwin: add _() to calls to
 error()
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

fixup! compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener \
on MacOS

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 9a73fb607d5..d9d0d0fa0e9 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -335,7 +335,7 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 	return 0;
 
 failed:
-	error("Unable to create FSEventStream.");
+	error(_("Unable to create FSEventStream."));
 
 	FREE_AND_NULL(state->backend_data);
 	return -1;
@@ -383,7 +383,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	data->stream_scheduled = 1;
 
 	if (!FSEventStreamStart(data->stream)) {
-		error("Failed to start the FSEventStream");
+		error(_("Failed to start the FSEventStream"));
 		goto force_error_stop_without_loop;
 	}
 	data->stream_started = 1;
-- 
gitgitgadget

