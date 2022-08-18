Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E38C28B2B
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347124AbiHRVl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346097AbiHRVlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:41:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66078BD74C
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u14so3131384wrq.9
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=mVZa75vdeexj9hvzw+Wn4JTLrvo13EP5x/B/OGDiGZ4=;
        b=NKzDvsR1ipZ4CUr+hVTgl+YpbBJP5++GPEbx4NZv2iDqDAzmv/beObECzIpZsTLHnq
         nDU2eWOKrucDwCgXPZK1BJGBVU6ZOQ26sGDickxJ7y9nzhH2NEIMD5Bw56tLA0UFA6kQ
         WMCB58H0STi3jYjS8+D91i+g/jpJF+d94aYOyLVlfemvokcca3Yqoi0M56DYF7kA/ssp
         Zpk8DpWyGhsGrHBbcWGaHak/4Hs9MLAvlQ4Dl0PX53MYdDyZAxZtjjyXQ55o0IcT8bmP
         YoonVNMrjB7deusKlpU7Te+0IB1mEilOBn6gh279xdRv+RswacqLrE5OPZ1+VtFETQft
         bbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=mVZa75vdeexj9hvzw+Wn4JTLrvo13EP5x/B/OGDiGZ4=;
        b=k2PYbF1JkpOLvXznJwM9lo2f1yoaRRm/woCEVbHHmcnUuSsZtvbrOhYJxDwcm3xd4G
         AqvrS3XkJngcbpaJlWL5DAmYcSLr6UlV8uLLk99+ZYctZ8q2B7C6tUAGAVG+cUbDW1E/
         f+yUi2Uxm2kXOLvf7RRXV1Hu73LcFhWt3/VkqsRztnxHeOGMtS/byx6jDAhkeIJyt9ag
         9l/xFydNyKVUqWiIwtAIRSdp1Wedej80yqTITI04MRyggPWV7FgCQmdwIR8HE9AwsyaI
         PrQL6HGz54Ini8kk5g3d/yKzeldJVLbIK8kjsYSCLYg1P5XIIBj3rNmomf29VQz68+NV
         73Yg==
X-Gm-Message-State: ACgBeo0NaTJqlIsJuety7m904+ADwJU+g1/kZy7s+fCZio1jnA0TWDGW
        oWqIlCsxWubtxkcCzSelafiIjC+Q/f8=
X-Google-Smtp-Source: AA6agR5lp5zgT37FIN+mwRhS94AAURKRPkIoK7A6EjTQNOHG4B4fd4kVtoqBtNbujgdgtsEMUCCFDg==
X-Received: by 2002:a5d:47c4:0:b0:21f:e92:7ba1 with SMTP id o4-20020a5d47c4000000b0021f0e927ba1mr2523096wrc.408.1660858861799;
        Thu, 18 Aug 2022 14:41:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14-20020adfed0e000000b0022511d35d5bsm2446418wro.12.2022.08.18.14.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:41:01 -0700 (PDT)
Message-Id: <bb58a78fdb2d8416ded6b00898d52d5658841197.1660858853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:52 +0000
Subject: [PATCH v3 7/8] scalar unregister: stop FSMonitor daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Especially on Windows, we will need to stop that daemon, just in case
that the directory needs to be removed (the daemon would otherwise hold
a handle to that directory, preventing it from being deleted).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 73cd5b1fd0c..07c3f7dd6b6 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -244,6 +244,16 @@ static int start_fsmonitor_daemon(void)
 	return 0;
 }
 
+static int stop_fsmonitor_daemon(void)
+{
+	assert(have_fsmonitor_support());
+
+	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		return run_git("fsmonitor--daemon", "stop", NULL);
+
+	return 0;
+}
+
 static int register_dir(void)
 {
 	if (add_or_remove_enlistment(1))
@@ -468,6 +478,9 @@ static int delete_enlistment(struct strbuf *enlistment)
 	strbuf_release(&parent);
 #endif
 
+	if (have_fsmonitor_support() && stop_fsmonitor_daemon())
+		return error(_("failed to stop the FSMonitor daemon"));
+
 	if (remove_dir_recursively(enlistment, 0))
 		return error(_("failed to delete enlistment directory"));
 
-- 
gitgitgadget

