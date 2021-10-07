Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E90EC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FC760F58
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhJGLBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbhJGLBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE02C061764
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v17so17761779wrv.9
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dZbBihr8P478PPKLNmEh1kp6VSl3WRtsE74oahy/YaE=;
        b=GHzdJeWw48r2sl1XZ6GQeWxxMT536PAWHLXhWJh1mRFkAscxRO9YLz9NeTSO/mwSxo
         AvM1YnpIGrih//aVcSvSbClZu+Snua5JgkMXjLAJWHaAzZzYeN0rL0L8ZEpieAZidoo2
         u0mlW1wrjL9XU8+B0/hNNd7KnC+dBES4V/iTOeP1nTQhN2lP8qsw6tvdQXCQF+iC3NSb
         DS0sWd39Ax+EY20D7AbX1Jemu67zAr8oNka5cYpV34cWuoK9mLJ2RE2hZc53515AfEHn
         bFMEeIzXF1QyWshXqP0WUSInpjQrYOwvopzmFmPhQE9So9Frsbug3CJkqAmeTsAgkkLW
         TlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dZbBihr8P478PPKLNmEh1kp6VSl3WRtsE74oahy/YaE=;
        b=EZvZ3SKXNiXf75anlJVJy9YXYHVmuk8Am2G2/fjcaipUO4ibDTOejo7TgzvoAlPsWK
         MnYbmkfi37gfs4X8DZ/VeouOoy9TkI1ktaVDyunJmWYLMBx6pfvGYtkyoWvFFgsi9dcF
         ICDXgxiBInYJVpXMnPCgI7LhmUyCM5acvlmQYg69VdjpdLj67qLC8uJ1aPj5/OhxhvIt
         kKXRZa8saoTflBKIyMnAHsIVK51Gk10OjuXd1rIN0jpJFDSEAva6ktgUQ5nShz0Iofu1
         G3PSvXXWURxbEnyY5pLoN+j+ddg+aBMDlQ1s+52foFomo2g5LXGJfDmm+K+w+5N/g/q0
         myrw==
X-Gm-Message-State: AOAM533Z2BiPXrRkJtauuC16JfbbIQFT8bxf0b3sUQZM8D4A8ZXdwv6l
        6aWz5JX1Ou2OrmuEHrv7p4HM+snJSMI=
X-Google-Smtp-Source: ABdhPJx+vJPkgPfvWgIBAglYwXi1j442sOgr6ajyu3VXL5Zp3y++CnX01s3k4LCWJRXzfwTBso6JfQ==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr9138490wmj.120.1633604354860;
        Thu, 07 Oct 2021 03:59:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r205sm4551710wma.3.2021.10.07.03.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:14 -0700 (PDT)
Message-Id: <0041477374edb0a6f32d15cab18d99075e5ac60c.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:00 +0000
Subject: [PATCH v5 06/15] scalar: let 'unregister' handle a deleted enlistment
 directory gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a user deleted an enlistment manually, let's be generous and
_still_ unregister it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 46 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh | 15 +++++++++++
 2 files changed, 61 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index fc55404230d..dc84ce0d5b2 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -268,6 +268,24 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int remove_deleted_enlistment(struct strbuf *path)
+{
+	int res = 0;
+	strbuf_realpath_forgiving(path, path->buf, 1);
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "scalar.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "maintenance.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	return res;
+}
+
 static int cmd_unregister(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -281,6 +299,34 @@ static int cmd_unregister(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
+	/*
+	 * Be forgiving when the enlistment or worktree does not even exist any
+	 * longer; This can be the case if a user deleted the worktree by
+	 * mistake and _still_ wants to unregister the thing.
+	 */
+	if (argc == 1) {
+		struct strbuf src_path = STRBUF_INIT, workdir_path = STRBUF_INIT;
+
+		strbuf_addf(&src_path, "%s/src/.git", argv[0]);
+		strbuf_addf(&workdir_path, "%s/.git", argv[0]);
+		if (!is_directory(src_path.buf) && !is_directory(workdir_path.buf)) {
+			/* remove possible matching registrations */
+			int res = -1;
+
+			strbuf_strip_suffix(&src_path, "/.git");
+			res = remove_deleted_enlistment(&src_path) && res;
+
+			strbuf_strip_suffix(&workdir_path, "/.git");
+			res = remove_deleted_enlistment(&workdir_path) && res;
+
+			strbuf_release(&src_path);
+			strbuf_release(&workdir_path);
+			return res;
+		}
+		strbuf_release(&src_path);
+		strbuf_release(&workdir_path);
+	}
+
 	setup_enlistment_directory(argc, argv, usage, options, NULL);
 
 	return unregister_dir();
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 16f2b72b126..ef0e8d680d5 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -14,4 +14,19 @@ test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
 
+test_expect_success 'scalar unregister' '
+	git init vanish/src &&
+	scalar register vanish/src &&
+	git config --get --global --fixed-value \
+		maintenance.repo "$(pwd)/vanish/src" &&
+	scalar list >scalar.repos &&
+	grep -F "$(pwd)/vanish/src" scalar.repos &&
+	rm -rf vanish/src/.git &&
+	scalar unregister vanish &&
+	test_must_fail git config --get --global --fixed-value \
+		maintenance.repo "$(pwd)/vanish/src" &&
+	scalar list >scalar.repos &&
+	! grep -F "$(pwd)/vanish/src" scalar.repos
+'
+
 test_done
-- 
gitgitgadget

