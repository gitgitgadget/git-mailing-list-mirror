Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9A0C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiCASpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbiCASo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119796620A
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p4so8030356wmg.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dYHB6VIcuLCvVwPHVF7aas3tdD7U9a/DUdka7zL2q6U=;
        b=N3RtWKRlbknpRwq0p4DUOmsWRJ3E2U5kDmsKkXezqtYAXLXPBX5Rk2JIRA+2vYggsS
         ICXnrXtZXDyOgyJhd7ah1h7lIk7EhnOqCBfQflGbjv+HziLnuRgm4RhUTVOXzV32LNxX
         gynlWO2RQKRa/r0I9CB1RSx/ZZuivyuqs3LokbtZ3pPf/HK1gpyylBDQOHGuwqEqdBYm
         eFXMsIE4ZXOiiScEA86yuuHnjGhQilcU/e1nfzfHFh1ldYxLSu8xlXvcgpRAWgSG9yuM
         Kbarkj+Q/YHePrzWow0nE2M2ttZJSSPa0eCjI8IIcvUqpOLypxeSzTKsJia4y2mChBga
         MjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dYHB6VIcuLCvVwPHVF7aas3tdD7U9a/DUdka7zL2q6U=;
        b=5rmMO4ui1Nj59HWUCM6jRfP37HpXajCkG9xbhRXNwcrx0RUuvRMJc76Y++1NWXDGMw
         2yAcSJ8FguWLAAjSdWwJlMtjEbWwul3PuXfslPUYzCJay3/sd4lEECQk4jXkVBJq3fPE
         MtDGdOqIqzQg4h9v2HcL5Zkhb4g1cGZ4iQ8i51ea0HKwDWy/f8GPI5ygDcH/5gG8lj+4
         /IgegqBoNzFLqfUR668zw2qrYFbcJUAvIab4uTdFViC1GOQQ4AfTXKwLTMKnIAR11J8b
         Dynay6Gqazh8XiSfmgj3YqTSoOrbzTeb5szLkw/+Gx+VRaziOuJPd8WtpuHZren6t+dD
         JLww==
X-Gm-Message-State: AOAM5306IjFgr7mLxdQcghrMQF9PhJ8LIyXbv+v+3O/lfKbOyh2PVW/4
        YToSoOXo/esdpM8OdNhTyf1HvV4/K1w=
X-Google-Smtp-Source: ABdhPJzRcYIR4I3ef9O/OgFnkK2XezWVMwEYuwmeHbrvI6YXJyP0MfXns/6NLRpgEveiFlOr8uUaew==
X-Received: by 2002:a1c:2644:0:b0:381:10f:503 with SMTP id m65-20020a1c2644000000b00381010f0503mr17956995wmm.188.1646160235452;
        Tue, 01 Mar 2022 10:43:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6-20020a056000120600b001ea9414f2c3sm14486443wrx.12.2022.03.01.10.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:55 -0800 (PST)
Message-Id: <a70748b4640e673de32e24a77080c27da580a1df.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:26 +0000
Subject: [PATCH v6 24/30] t/perf/p7519: speed up test on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Change p7519 to use `test_seq` and `xargs` rather than a `for` loop
to touch thousands of files.  This takes minutes off of test runs
on Windows because of process creation overhead.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/perf/p7519-fsmonitor.sh | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index c8be58f3c76..aed7b1146b0 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -72,7 +72,7 @@ then
 	fi
 fi
 
-trace_start() {
+trace_start () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
 		name="$1"
@@ -91,13 +91,20 @@ trace_start() {
 	fi
 }
 
-trace_stop() {
+trace_stop () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
 		unset GIT_TRACE2_PERF
 	fi
 }
 
+touch_files () {
+	n=$1
+	d="$n"_files
+
+	(cd $d ; test_seq 1 $n | xargs touch )
+}
+
 test_expect_success "one time repo setup" '
 	# set untrackedCache depending on the environment
 	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
@@ -119,10 +126,11 @@ test_expect_success "one time repo setup" '
 	fi &&
 
 	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-	for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &&
-	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
-	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
-	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
+	: 1_file directory should be left empty &&
+	touch_files 10 &&
+	touch_files 100 &&
+	touch_files 1000 &&
+	touch_files 10000 &&
 	git add 1_file 10_files 100_files 1000_files 10000_files &&
 	git commit -qm "Add files" &&
 
@@ -133,7 +141,7 @@ test_expect_success "one time repo setup" '
 	fi
 '
 
-setup_for_fsmonitor() {
+setup_for_fsmonitor () {
 	# set INTEGRATION_SCRIPT depending on the environment
 	if test -n "$INTEGRATION_PATH"
 	then
@@ -173,7 +181,7 @@ test_perf_w_drop_caches () {
 	test_perf "$@"
 }
 
-test_fsmonitor_suite() {
+test_fsmonitor_suite () {
 	if test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
@@ -199,15 +207,15 @@ test_fsmonitor_suite() {
 
 	# Update the mtimes on upto 100k files to make status think
 	# that they are dirty.  For simplicity, omit any files with
-	# LFs (i.e. anything that ls-files thinks it needs to dquote).
-	# Then fully backslash-quote the paths to capture any
-	# whitespace so that they pass thru xargs properly.
+	# LFs (i.e. anything that ls-files thinks it needs to dquote)
+	# and any files with whitespace so that they pass thru xargs
+	# properly.
 	#
 	test_perf_w_drop_caches "status (dirty) ($DESC)" '
 		git ls-files | \
 			head -100000 | \
 			grep -v \" | \
-			sed '\''s/\(.\)/\\\1/g'\'' | \
+			egrep -v " ." | \
 			xargs test-tool chmtime -300 &&
 		git status
 	'
-- 
gitgitgadget

