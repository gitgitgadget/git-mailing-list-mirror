Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E5C433FE
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350609AbiBKU5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353600AbiBKU4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA91D7C
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so8022509wml.0
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h+Ll16drRrZ0MQ3JZUEyAlGPlME6mRvqakNQhG3XdjE=;
        b=AcmwlRm2Y0BqJwU3/4yCUmU6gYI0+sC5mgwXQf7jVRvatllpuELt2z9okpZPH5oWLi
         EmF+h6/Er1BEFov6lxN+lXC6d7rqcuB6+tyyl2MviBkLLyNg2/VLbsFASKPyyzSWHLc9
         5mh8rJ++viKSjOJqLqyfm/4hP3fYMruwMB3Z4Igg4O5P5LzDqeluEacFev/L8VCqL+f9
         4AZTyer4qaaNnZdJmO74LNvzJFnLRZc2jBMPbTecDxG1p/OSf1oBMI5OrlVmWDJCyXaq
         mZbdrsygJPSjCvnPDDjPKp8USaTrQmLRNlAvOeC2Ni/hmsg4cNg18epXt1HVgCWh0Vjk
         VkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h+Ll16drRrZ0MQ3JZUEyAlGPlME6mRvqakNQhG3XdjE=;
        b=xADIfzMfZMUEZ3jmWPJtoaA7D189R1+ChEePHDwuPIK/Hsspzjy+8YBi2diy5uU/11
         Tqh/b0dsEskmZFREo7ycOIPHhVIzdemEAslcI3TIfq24iIpehyGZAnse2NSIjpqcw7xp
         giGKMDaPwwkAOiwoJcJGQU1hrB+ojykQKFkeF4Myw5En525PafFWCGa0sJA3fowE3ATd
         nMAf64ozOljnzAFOQassgJP1gN44TdEGQdYxJOXaKc8sy1zsF0TUzNuCajt2LZHjHZPp
         bCCg2mbNLPQcW08D9wIBooq9NlERWbmYOb6r9UoVpeoAhcJGYRcZnmWWml8N42oksm1L
         Aaww==
X-Gm-Message-State: AOAM530g+vjMFSnvyzZWSU2hZcdje9zzdUPV6sGx6gLNxzeFdjNiMxDa
        wkQBIZ1a/6AkLW6ePEGl9bazYKtUlYU=
X-Google-Smtp-Source: ABdhPJy8DMrOpgwU8kyvu9Gvy6rYNjw6Q1CskcBk26HH58jikeO3VJTG8uN1tqNJs4W3NFPwLEKnXg==
X-Received: by 2002:a05:600c:511e:: with SMTP id o30mr1778252wms.36.1644613000103;
        Fri, 11 Feb 2022 12:56:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm4680571wmd.44.2022.02.11.12.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:39 -0800 (PST)
Message-Id: <6cba1d950b013410ecc6ffc15bfcba02c51d6de2.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:12 +0000
Subject: [PATCH v5 23/30] t/helper/test-chmtime: skip directories on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `test-tool.exe chmtime` to ignore errors when setting the mtime
on a directory on Windows.

NEEDSWORK: The Windows version of `utime()` (aka `mingw_utime()`) does
not properly handle directories because it uses `_wopen()`.  It should
be converted to using `CreateFileW()` and backup semantics at a minimum.
Since I'm already in the middle of a large patch series, I did not want
to destabilize other callers of `utime()` right now.  The problem has
only been observed in the t/perf/p7519 test when the test repo contains
an empty directory on disk.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-chmtime.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index 524b55ca496..dc28890a183 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -134,6 +134,21 @@ int cmd__chmtime(int argc, const char **argv)
 		}
 
 		if (utb.modtime != sb.st_mtime && utime(argv[i], &utb) < 0) {
+#ifdef GIT_WINDOWS_NATIVE
+			if (S_ISDIR(sb.st_mode)) {
+				/*
+				 * NEEDSWORK: The Windows version of `utime()`
+				 * (aka `mingw_utime()`) does not correctly
+				 * handle directory arguments, since it uses
+				 * `_wopen()`.  Ignore it for now since this
+				 * is just a test.
+				 */
+				fprintf(stderr,
+					("Failed to modify time on directory %s. "
+					 "Skipping\n"), argv[i]);
+				continue;
+			}
+#endif
 			fprintf(stderr, "Failed to modify time on %s: %s\n",
 			        argv[i], strerror(errno));
 			return 1;
-- 
gitgitgadget

