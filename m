Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B4C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiCYT0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiCYT0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:26:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC013E7E05
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 11:58:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bq8so3176274ejb.10
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GBSYoKFMiXxL47tbCdtlqToK9/DpNmOfcvl8sunsaH4=;
        b=MdTUweNTxdVszcXzayefYqy9KQRo9uEkQ7yKpteQmj1GniDl/LT6fPBSbPUI6if2Oz
         OaolxhIqWNUl5aOaat7lLnH/WwLf+IaiCTXCRGrwIwBdbNN2oCcf35S1HSWjUwO8pwbA
         T/d1iGVCJYAX3hSUTzd9VFvD2fTGTBrxl5syA3U1vWuQzXSDSjmKMkaD/TZCyb8GaFx0
         rvmAK+1ny0qmwAEiatmQ5treljdSEWuhOhYPkPlATLc2fdxMp0EsuOKiM89CFdctnorj
         6VwPH1pWYUn51XwfZ3sMLNB0jKVSzyOfvn5XfBpG3//2LyCWF5AX0HHfZr0nvMsfJ/lk
         tTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GBSYoKFMiXxL47tbCdtlqToK9/DpNmOfcvl8sunsaH4=;
        b=71id213jAh42nr6htGB06Lry6P4bCLkViNcHptlnJ2X/a/J5ByRorZeIuLVLizQAiD
         Z2YOI7m2hkc+7xby7osU3dWViDR87Cs4kGbEKbARIC0Hn2pHKcX9ewF2n1L3YQMaVBiV
         mbEqTkjRv3XqzJT1eBermLkqV+CRRId5Q2mQhkGkrpCTsea55DfgxcYZ6eqdSimHy1oE
         kD4Fi0o6SFpXyK+dLfWoNKa1ai4fmo3irMQYr0wF//u/g690O4+86bwP25TKkMoWS5Pk
         Ak9aIC0kZxaJ8OsQt2SpsOwv6zSjV48Qt2Wz/ECveWwF4sxiBgOs5/+grPFMdxGwiuFy
         9XaQ==
X-Gm-Message-State: AOAM5331uIYJ+RdCf00WC6rtKcRqXoO0APTKYRbNyhA41JWgnc+G2wGj
        Swu5yIcTKLYsN1mm21vOIjg1VNbjluk=
X-Google-Smtp-Source: ABdhPJzVtoemCJYl7rqMIsnDJsW0mm6GtwHb2TijCqglnKOKFj5YXZqlr+smCasySs/0KKz1juPigA==
X-Received: by 2002:a5d:4ec7:0:b0:203:de83:6f44 with SMTP id s7-20020a5d4ec7000000b00203de836f44mr10193107wrv.56.1648231422559;
        Fri, 25 Mar 2022 11:03:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d6acb000000b002058148822bsm7914537wrw.63.2022.03.25.11.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:41 -0700 (PDT)
Message-Id: <50c2afaa49e20f2b19824acb2ff6a64439e9207c.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:08 +0000
Subject: [PATCH v9 25/30] t/perf/p7519: speed up test on Windows
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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
 t/perf/p7519-fsmonitor.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 5241eb6c4e5..a6c2a910e70 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -98,6 +98,13 @@ trace_stop () {
 	fi
 }
 
+touch_files () {
+	n=$1 &&
+	d="$n"_files &&
+
+	(cd $d && test_seq 1 $n | xargs touch )
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
 
@@ -199,15 +207,15 @@ test_fsmonitor_suite () {
 
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

