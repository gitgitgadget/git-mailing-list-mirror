Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0A4ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiIBQFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbiIBQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:05:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7BBB14E5
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 08:59:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w5so2831183wrn.12
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=RUyY7f8DvONxjrqO0y3le77xZJZhE1LdWC1cW2r7lK8=;
        b=mYLw6zbo7R0akf1LO98n9ArqXqWofoKtKGpGzXqeYcjIBrYRqEKuYX8TPMZcqrex6r
         Kx42/TEaFO7N5zF1jxxA6BDrJC9StS4nCiIHCkWoeRXcboqRQHVVF+Twpw26fw01P8UJ
         4Ra5dyrdgUhOWnX61U7Cml/42Q1s1XXvxuinMide5U+mfzcQD67kuwUn0iyPTp41pbGe
         qY8lonpMuU0pqedBSXvWzkUaz7r/2Lf+VOsg4i6V+UMTUVG2aNDoKdllcXaWW7W6f/KR
         o2UTGhIHVRY/ZhLI3XW/HknjKF1a+NVQ+qkkvWErSfBDOqe7vKBw4RK0yF6BW+EBCVKO
         ESlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RUyY7f8DvONxjrqO0y3le77xZJZhE1LdWC1cW2r7lK8=;
        b=DszUrDNin3uQejdXgs+2oDYawOxQe9/NEGNzmI9FYNizc9R3Rd/61jGZdbAB3tw4E9
         Nh5nY5aCFaHAjs24h5hAb0uTzeWKpWWTUxU15WnChnX37g1I8Q5WPnS6kte5927kyHmo
         U5c7/bZZkiOyTIuRvMVQv8qgRV741Eu6Iy9FFWAzgHo7STN8aRedQd8UIIxP5Sb4jHUg
         RiSGeImGSU0m3sEwHAC4byZO2paK5aUWZxLK0n7ZT1PnIPTjAOvyxhROnFInnaUP/YHf
         04ZA5h9tPva7KnYFGDI1LO1IIRWR48fEg5gQ6t3Dx/2w4g/Y/F3vFblCE2SVMVed2kA3
         C7Sw==
X-Gm-Message-State: ACgBeo1RkMHTC4BZ2RrzRtFUCjnJLBT7kin3bl2ILrP8dpiOvJ9cmae3
        nR667xKz2DBF8mF/YMKno21cwb7FdpI=
X-Google-Smtp-Source: AA6agR7C3uGLtaaqhOh2UOjLL9yN5MHZ0elOUh4sgohzen9nfy3a9XxzUQSvsuHGOSc1ndynADTHOQ==
X-Received: by 2002:adf:fe44:0:b0:226:da5d:990 with SMTP id m4-20020adffe44000000b00226da5d0990mr15308784wrs.334.1662134219521;
        Fri, 02 Sep 2022 08:56:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba10-20020a0560001c0a00b00226fa6cf1d3sm1777041wrb.7.2022.09.02.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:56:59 -0700 (PDT)
Message-Id: <d5b68c65163a384d86f08d371d4b1abc774b66db.1662134210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:48 +0000
Subject: [PATCH v2 7/9] t/perf: add Scalar performance tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create 'p9210-scalar.sh' for testing Scalar performance and comparing
performance of Git operations in Scalar registrations and standard
repositories. Example results:

Test                                                   this tree
------------------------------------------------------------------------
9210.2: scalar clone                                   14.82(18.00+3.63)
9210.3: git clone                                      26.15(36.67+6.90)
9210.4: git status (scalar)                            0.04(0.01+0.01)
9210.5: git status (non-scalar)                        0.10(0.02+0.11)
9210.6: test_commit --append --no-tag A (scalar)       0.08(0.02+0.03)
9210.7: test_commit --append --no-tag A (non-scalar)   0.13(0.03+0.11)

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p9210-scalar.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100755 t/perf/p9210-scalar.sh

diff --git a/t/perf/p9210-scalar.sh b/t/perf/p9210-scalar.sh
new file mode 100755
index 00000000000..265f7cd1fe2
--- /dev/null
+++ b/t/perf/p9210-scalar.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='test scalar performance'
+. ./perf-lib.sh
+
+test_perf_large_repo "$TRASH_DIRECTORY/to-clone"
+
+test_expect_success 'enable server-side partial clone' '
+	git -C to-clone config uploadpack.allowFilter true &&
+	git -C to-clone config uploadpack.allowAnySHA1InWant true
+'
+
+test_perf 'scalar clone' '
+	rm -rf scalar-clone &&
+	scalar clone "file://$(pwd)/to-clone" scalar-clone
+'
+
+test_perf 'git clone' '
+	rm -rf git-clone &&
+	git clone "file://$(pwd)/to-clone" git-clone
+'
+
+test_compare_perf () {
+	command=$1
+	shift
+	args=$*
+	test_perf "$command $args (scalar)" "
+		$command -C scalar-clone/src $args
+	"
+
+	test_perf "$command $args (non-scalar)" "
+		$command -C git-clone $args
+	"
+}
+
+test_compare_perf git status
+test_compare_perf test_commit --append --no-tag A
+
+test_done
-- 
gitgitgadget

