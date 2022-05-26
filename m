Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A7C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349266AbiEZVuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349233AbiEZVtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566CDEAD2C
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k30so3653534wrd.5
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Q8NCwKBR4h76mmPvMVi3XVoVst203o7US4feb91EME=;
        b=nTdfHFqfBXA720HHh/7tIQDy5ZTAnT6ebI8pk6Bf/D2PVOiJXDDtGvgZYESt9GjF8E
         NkLf4/yubUrJ+evsGi5QFsXG6xxn6L7S9bxfbIh8ooz7ldnj7EThVKl7Oqa/PW4cr1Ma
         CSnB5nkaC/94FWbFpuFIt4T9ZjOgkeOowM+i6vcWWR3c8RVMztQ2a789efWr3S+DSEgW
         RfdpfBRgxNXjfbnq8sNQoCiy+G9yD2TYD8IHL6aaBblZ/p2GSbjnjW58bhDo+QLmt1tj
         hbFYduvXVZTi8BYy7PufbIiBh2Nr98kgiYiRcIMSkCSJuw50pcHOqxvL64XdkcdMPZmT
         dFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Q8NCwKBR4h76mmPvMVi3XVoVst203o7US4feb91EME=;
        b=bGx1w8xmaw6Se63QDy2VWdQZi83rlEDgDSW6BiBzaBO5JqXZL1ukvlczqS/KNqVUPo
         oDDkH6lpdqFL6sfoR4dFugyn54QD/GUg8qZTz12anMOzh+JtW5Fk70qVwum0ah8+2JFj
         UWdzJ+rYKSztaYcbnI3PVjt4iLsVLKIBpQx8akN/UCvkdEHrJfh4tCsnw5N8fibTyj0R
         etU1huXxv15VIqro2/tFCN8eOgCSDpqBrtNHdXUAqCrGxLVywB5Q75TsaFi5qyLmLDBK
         9uyXgd3xbaXQeZSBKk9TPXHbY2lrY97yh0/jxjXfCyxC5VNcMD+2fcyGDrxhhn17vN6S
         aSeA==
X-Gm-Message-State: AOAM5328zLB11M4t6biWt1VYY8HpRCn9ZLMJm1UGKCIqGMizafBFCiZg
        j6bkBtX4hhcI+fRfXjKRFQ6QdbxM78Q=
X-Google-Smtp-Source: ABdhPJwhi1Ayu2N5uSKLMee8fzeJlLFjyLV3PLuCOgOQdFgbfW4soPfT1SyM2dKCIM5M/QNqHMI6FA==
X-Received: by 2002:a5d:5181:0:b0:20f:fc49:6b88 with SMTP id k1-20020a5d5181000000b0020ffc496b88mr8711409wrv.596.1653601770631;
        Thu, 26 May 2022 14:49:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b003973e8a227dsm224705wmq.46.2022.05.26.14.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:30 -0700 (PDT)
Message-Id: <41f8cbc2ae45cb86e299eb230ad3cb0319256c37.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:18 +0000
Subject: [PATCH v9 24/30] t7527: test FSMonitor on case insensitive+preserving
 file system
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Test that FS events from the OS are received using the preserved,
on-disk spelling of files/directories rather than spelling used
to make the change.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index cf4fb72c3f0..fbb7d6aef6e 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -832,4 +832,40 @@ test_expect_success 'submodule always visited' '
 	my_match_and_clean
 '
 
+# On a case-insensitive file system, confirm that the daemon
+# notices when the .git directory is moved/renamed/deleted
+# regardless of how it is spelled in the the FS event.
+# That is, does the FS event receive the spelling of the
+# operation or does it receive the spelling preserved with
+# the file/directory.
+#
+test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
+#	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
+
+	git init test_insensitive &&
+
+	start_daemon -C test_insensitive --tf "$PWD/insensitive.trace" &&
+
+	mkdir -p test_insensitive/abc/def &&
+	echo xyz >test_insensitive/ABC/DEF/xyz &&
+
+	test_path_is_dir test_insensitive/.git &&
+	test_path_is_dir test_insensitive/.GIT &&
+
+	# Rename .git using an alternate spelling to verify that that
+	# daemon detects it and automatically shuts down.
+	mv test_insensitive/.GIT test_insensitive/.FOO &&
+	sleep 1 &&
+	mv test_insensitive/.FOO test_insensitive/.git &&
+	test_must_fail git -C test_insensitive fsmonitor--daemon status &&
+
+	# Verify that events were reported using on-disk spellings of the
+	# directories and files that we touched.  We may or may not get a
+	# trailing slash on modified directories.
+	#
+	egrep "^event: abc/?$"       ./insensitive.trace &&
+	egrep "^event: abc/def/?$"   ./insensitive.trace &&
+	egrep "^event: abc/def/xyz$" ./insensitive.trace
+'
+
 test_done
-- 
gitgitgadget

