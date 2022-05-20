Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FCEC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353096AbiETSmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353042AbiETSlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF1E3EA85
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n6so4996477wms.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PgDHTGjqvuAMjLeFxmVnpbHmwxtDC1ju8eSC7NyitIc=;
        b=Uc33bWQT3CuFlIlyY1f/29AxE3znEPdQEVd8/56oCE6MvT0EnhSfRWSR9WEHfNMQSc
         Tk1aTRQxQF+a0l2vaeVKkuhjoXQfJoEuC2/Xtkd0bykqoqSCrR0iMFGz7u0GyZ5PgTTz
         UVNjBTOlXHO8QT+DCaoYxjRmzW7x0PtpGEgwVYPpIq8M4+fEkm0nlF8ArfINyO1rTrab
         OpUXbsQixqvdRXzd/lGuNUE+ZvXTWTXf9tv+435EYMPxvB/3t6fFoUfd0x4AQkRPY0Ft
         7AZFdSsnI8mHBAxIRNB+JDfhDlaP6EBem6nDzPqQQ7dSuMAK2qJpyMrEhLp0m1etqyme
         KaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PgDHTGjqvuAMjLeFxmVnpbHmwxtDC1ju8eSC7NyitIc=;
        b=CfJz56j80qz82g3rG5RAY1dub3H8Zew9D6Yd9rUlgWWUr+LaKB/K7NRLuRdqJ+uBsA
         /GsSQuFIEt2COiVcrXrPfTvS5GhQKJouMCPZxwzLATcGD5hMrycxztZW6O5BtbP5XKA1
         JE4ApJSCWl70piALs3p6n/IFwrDpfYVORry/btnoH2+WQ1lfPrM8YTNmouU5ujSYTybs
         kbtfdM9D3UD7y1uA4PykYioAsAf3MtbNTakq4J11GHYbuj8aqsixFltLrrRMC2yEgyst
         CgjYn7OikjrGuhl+G1Es1ct9w65IRO0p4UbNe2RPu5EVOt7phn6gUwEPvwSFNZ6+4bER
         gc6Q==
X-Gm-Message-State: AOAM530PU7TW2CRrkiwqJIQgZjVgYSpjBvpG3bS0ji5nJGJUWXMMv09d
        TZHbHbyayR9PGl7pjkNBAMt+QREyqgY=
X-Google-Smtp-Source: ABdhPJzkmF7yS+pShFHpg3+wVWjxhhEVbuW2BPOf0MnNoKDK2TTBB1LQt7StDigqShtcLqSRDgG0wQ==
X-Received: by 2002:a7b:cd97:0:b0:38f:f785:ff8 with SMTP id y23-20020a7bcd97000000b0038ff7850ff8mr9657086wmj.44.1653072071499;
        Fri, 20 May 2022 11:41:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b0039453fe55a7sm2621388wms.35.2022.05.20.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:10 -0700 (PDT)
Message-Id: <de1a0ce0919d3a25c95db2fce060ded36982da4d.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:42 +0000
Subject: [PATCH 24/24] t5601: basic bundle URI tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This test demonstrates an end-to-end form of the bundle URI feature
given by an HTTP server advertising the 'features' capability with a
bundle URI that is a bundle file on that same HTTP server. We verify
that we unbundled a bundle, which could only have happened if we
successfully downloaded that file.

RFC-TODO: Create similar tests throughout the series that perform
similar tests, including examples with table of contents and partial
clones.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5601-clone.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4a61f2c901e..4ee9e231203 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -767,6 +767,65 @@ test_expect_success 'reject cloning shallow repository using HTTP' '
 	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
 '
 
+test_expect_success 'auto-discover bundle URI from HTTP clone' '
+	test_when_finished rm -rf trace.txt repo2 "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/everything.bundle" --all &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.list.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.list.mode all &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
+
+	GIT_TEST_BUNDLE_URI=1 \
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 clone \
+		$HTTPD_URL/smart/repo2.git repo2 &&
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","origin","$HTTPD_URL/everything.bundle"\]
+	EOF
+	grep -f pattern trace.txt
+'
+
+test_expect_success 'auto-discover multiple bundles from HTTP clone' '
+	test_when_finished rm -rf trace.txt repo3 "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" &&
+
+	test_commit -C src new &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/new.bundle" HEAD~1..HEAD &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.list.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.list.mode all &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
+		bundle.new.uri "$HTTPD_URL/new.bundle" &&
+
+	GIT_TEST_BUNDLE_URI=1 \
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 clone \
+		$HTTPD_URL/smart/repo3.git repo3 &&
+
+	# We should fetch _both_ bundles
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","origin","$HTTPD_URL/everything.bundle"\]
+	EOF
+	grep -f pattern trace.txt &&
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","origin","$HTTPD_URL/new.bundle"\]
+	EOF
+	grep -f pattern trace.txt
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
gitgitgadget
