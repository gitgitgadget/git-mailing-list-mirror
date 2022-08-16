Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6531C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiHPSJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiHPSIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:08:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A31C844E4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:07:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so5769817wms.5
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=5NfArMo4x7yHb2I3UqeHo9Ettgx14i9sSnw051ncdaA=;
        b=pWoE1oz+LCm/7PF/yR72wkkrZdxGMX4yfF2F2eQmUsrEetyv36qRhCrzCc/TZYx7Zm
         KwoqKUjSka3+9Q20CEDd6zVLz4g4r9V7mRgAye454cRLDfSqzRQ2GrvrZTJi6TWX2BYP
         u+s6FrP/iJyVpXI2HXqRH/aB91sajM3GImidnUW4e3DlJ/SjLv4tygliJ3f87MVYDLAO
         tQRpBWA646cVw/3YkouOz2hVz0Hex0gpgTt58H1Cf61ZePXBPPQoLWDQyjFgPOOBtwnV
         m+3HMNXtTZSuoyXNalb9NZztljxbkTJYV2bNQnvlpAHnEOFA4cBy4x5h6dLWHwvlVHp4
         s/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=5NfArMo4x7yHb2I3UqeHo9Ettgx14i9sSnw051ncdaA=;
        b=no3Pkg6xX32h8zMlmRcUdtyvqApzt7o2zA/AvPfForySWLqb84RXzPE/Htepnl3t1g
         84S8UxJtQdHt/R2zVPWs/F5V8SRQsCQQ7hlMucYav4mbdN7qa8bhp8iVmg7V88NrroFd
         ucHNcEb3Cy809RDT26zG8vIIyUqlZSRjj5kbPIjdoyKezq1KXBN9MYvtiycaD/WpiZQf
         Xw2ce/Wrn/BZC52m0BJGcN9YzZ6oMAPJCr4brAZ+spR6l+SeiT2zWCumQNQUIfVlchF4
         audBXQam8NU1u53GgkKNlPuedou+NPgHS9qZ38Sekax5r1yy9xyWVRh5KAVUsA/V8e0M
         PXbA==
X-Gm-Message-State: ACgBeo2Sx65bQDWLLJLZ2TpJrfvducyEzaOj9GiGEf0iXy5915j5FpQY
        vrMlX5nf8YRd/JMFd6oSPxQhA7vk0j4=
X-Google-Smtp-Source: AA6agR7XRH/S7co1v6rrBHWg82qxEK0uv6vE+KWds6pQYWVHdvsoIpk+5vxgW1jMXk2PYjdPPaQxeA==
X-Received: by 2002:a05:600c:384c:b0:3a4:a146:2a04 with SMTP id s12-20020a05600c384c00b003a4a1462a04mr13645170wmr.176.1660673272527;
        Tue, 16 Aug 2022 11:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5-20020adff845000000b00225206dd595sm988672wrq.86.2022.08.16.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:07:52 -0700 (PDT)
Message-Id: <78a7f0b1be052bb8c1c2525b3464d7d3ba506bea.1660673269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 18:07:48 +0000
Subject: [PATCH 2/3] scalar unregister: stop FSMonitor daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Especially on Windows, we will need to stop that daemon, just in case
that the directory needs to be removed (the daemon would otherwise hold
a handle to that directory, preventing it from being deleted).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 219e414ab4e..b774eb044ec 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -272,6 +272,33 @@ static int start_fsmonitor_daemon(void)
 	return res;
 }
 
+static int stop_fsmonitor_daemon(void)
+{
+	int res = 0;
+	if (fsmonitor_ipc__is_supported()) {
+		struct strbuf err = STRBUF_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		/* Try to stop the FSMonitor daemon */
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "fsmonitor--daemon", "stop", NULL);
+		if (!pipe_command(&cp, NULL, 0, NULL, 0, &err, 0)) {
+			/* Successfully stopped FSMonitor */
+			strbuf_release(&err);
+			return 0;
+		}
+
+		/* If FSMonitor really hasn't stopped, emit error */
+		if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+			res = error(_("could not stop the FSMonitor daemon: %s"),
+				    err.buf);
+
+		strbuf_release(&err);
+	}
+
+	return res;
+}
+
 static int register_dir(void)
 {
 	int res = add_or_remove_enlistment(1);
@@ -298,6 +325,9 @@ static int unregister_dir(void)
 	if (add_or_remove_enlistment(0) < 0)
 		res = -1;
 
+	if (stop_fsmonitor_daemon() < 0)
+		res = -1;
+
 	return res;
 }
 
-- 
gitgitgadget

