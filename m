Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F70C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiCVSDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbiCVSC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC9568304
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j18so14920059wrd.6
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wukjy/IgKIdk18zB6iNukNft1Jqq3QyRvxJE5oCBOjE=;
        b=pSSSqxkQ1xCXOXA4MKwy4nOR28ZKJFV31MO4wC/goAq19cwuehrbx/IJFkUuNO1SNz
         EG0nVMhIyZhdUkRiFJT5x/xM4543q4iiXrMo5ag8lRDnU10Bd/pIyWQ7DJrlXSe7iJZh
         pNr9T+/VcNu0N5eXpqV0cmBKsLqfwP9uxlrbwGjezlffVcuH1XvCbKBTElGV2HzerfZh
         OHguN+nzSMUxUXIln1hzGntclDusynkbMCNyeAP7tRK+2tpV888denvavD6daGtwwaWk
         xLvt/lkvK4z7Ndfa9A8neNlX+7svVDxIePRgprUrOTdaqnuoz/zCo7EcXGhgNL+Q7q3R
         JDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wukjy/IgKIdk18zB6iNukNft1Jqq3QyRvxJE5oCBOjE=;
        b=FElMo5QWXFZA805iSl0IV/v7Cerc2BTcF1QIIJny0rQpC/HfYbsuvAEgy3m41qVECS
         0F2SKOc7W8SGGW12/SXlD5lFOkLfaxzBC4fc8pWIBAuHIa7Or2PuZ+GA3YwpJXjsEfUp
         OHcD6Uhdnz9Lt/uHW8QDiJgLXXw2FyztoQ/Wdn+IGiRuz2uJyOVooZ2VHvHpQSEm6jeJ
         Vj43mmcNajuwYNdFTGk6c8dwm8KD853vDBqaJhqaMLZh3aGW0fQlmS1zoFm6jE82plHK
         G3FzZs7LSiHUlTtSp74zvt9A6I1TLkSas+V8rOtWHrTNasGyZpSEgQFkcX/6IpOfXIEQ
         1MEw==
X-Gm-Message-State: AOAM5322OHSILHHuFA359nbEqoC2fT+SGtkdd1ImjFyxGXqShtSMj/GF
        Qfh0cRnSpk/qql2gqGcIrm6/zIx8/nc=
X-Google-Smtp-Source: ABdhPJyVf9s05YflwKGN2K6+/WUS2HZmwIpXXMQ8QNYIvpZYlvbuCNlQ9u3xzKsqIst2nTst9XBYtQ==
X-Received: by 2002:adf:ed50:0:b0:203:da73:e0fd with SMTP id u16-20020adfed50000000b00203da73e0fdmr23374291wro.516.1647972051451;
        Tue, 22 Mar 2022 11:00:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm2283071wms.16.2022.03.22.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:50 -0700 (PDT)
Message-Id: <803a540cc0022e893a75eae8815b3275a7fac3af.1647972011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:00:05 +0000
Subject: [PATCH v7 24/29] t/perf/p7519: speed up test on Windows
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
index c8be58f3c76..0611e533951 100755
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
+			grep -v " ." | \
 			xargs test-tool chmtime -300 &&
 		git status
 	'
-- 
gitgitgadget

