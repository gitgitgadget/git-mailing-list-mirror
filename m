Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5DAC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiCKWym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiCKWyd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:54:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264E9270149
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:28:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c192so5904053wma.4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GfKL4YvejmmejdQwVMUsL9M5M/X2KW1AxArZg67NjVc=;
        b=nxjp6PiSZaP99Mfj4PQ8gUncemjbPHqzG9LL8MTyazFp5ckc03munL1mkGbh18I2VJ
         0islgJ6SPzM544uaiEE6lXE7Gbbgpqpqmt/nBK+lghmcF2vpdO4BftP6Rc6Z08eHoEQh
         sfp2Nu+eDLLXp1K3MCsWwyRssMOpvhoE3TQMpxugJtXrSlDDS1H1ZYMl+zStBzh07bml
         vXu8XdYigmbQsyyqjh+zRDjzeS9adi+Xvr7zipxFpliuH7X+LBB1PENwX890NDkn1EFQ
         IjJDrRXjNx9959/40n+fvXDm5HKI5C2fslsKJU2Qk4RPgQ9Ny5nQlMDOV3mrIGp+FNEC
         0DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GfKL4YvejmmejdQwVMUsL9M5M/X2KW1AxArZg67NjVc=;
        b=8DdyNisPxlqZIwEonIhgmaxgBFlrwqqAskRNCWomc8fi99Tj9so1WFzwi+QCASFA26
         y8pqWZE/2re51er9/bTlGbN42XDtYyrU0kDMTNDh8q66/cn/SEXCVm+lFBcHUlATzwWw
         KBSvAd/EbXI56KlfdDISFw6o1gkKWCARVN0O5Wii3e6iLUiuLO4klZoe/Gpdbwna46eS
         toJN41YCh9sgtzpCv4PcTvNwDYHYOwNV/kkvBcM4odo0HWAuDkvaxg1G83nqpgIhKtre
         5YjC1BZslRiBkVvxXfCrSH/InpEyBxWJZICsEL5ArmOmATzhWmODs2gJVRdJzXiK3WiR
         XSKw==
X-Gm-Message-State: AOAM530awbpwnqOs7Fm7E2yJN1L+Bn/dTPgpfByajPK/93YQT09aa7pG
        LHxIUnZY76md9fwGClkoNK3R6LaFldY=
X-Google-Smtp-Source: ABdhPJzrE8QrmtGFyHDEAXcgbt4wGyBRVWgm+rQd3Uemb9ocK3syWzF4M8O4f9obSdMynFvOpVAOew==
X-Received: by 2002:a7b:c19a:0:b0:381:8495:9dd with SMTP id y26-20020a7bc19a000000b00381849509ddmr17406400wmi.33.1647033315568;
        Fri, 11 Mar 2022 13:15:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b00389f368cf1esm2014059wmq.40.2022.03.11.13.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:15 -0800 (PST)
Message-Id: <378c5ca510ce4029df6caf83740c582a93008612.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:15:01 +0000
Subject: [PATCH 14/16] fsmonitor--daemon: add _() to calls to die()
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

fixup! fsmonitor--daemon: implement 'run' command

Fix translation marking on die().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 02a99ce98a2..b3687a200ef 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1326,7 +1326,7 @@ static int try_to_run_foreground_daemon(int detach_console)
 	 * common error case.
 	 */
 	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
-		die("fsmonitor--daemon is already running '%s'",
+		die(_("fsmonitor--daemon is already running '%s'"),
 		    the_repository->worktree);
 
 	if (fsmonitor__announce_startup) {
-- 
gitgitgadget

