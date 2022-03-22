Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CD9C433FE
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiCVSDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiCVSC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5A266CB1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v22so10643190wra.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ytZGPKQBsgePTFk8nBNZCqEs9yPPwA8MYf3sa3pnTvQ=;
        b=i0SZD1OhbdEh3+27tjVaOzK5MVViJoIQ+hl3v4rZFh3vk0KfvXKsEPdlGEmn52XUzw
         Tm9DpzZ+6UClQVFv+FPT0hJK7xz8Vfik6ZF9KkJDj4yNYQpCZ3HIQ2xlLIuGRHKdzX/Y
         jUbROkJlI4ly1s3MeLIQ0fG25ptVx0RophAlEGaekdylxJGSP6ppeuXKHGzZI3Bnr7TI
         JsrS05a9IZVOVwGp4LKJJlsYo/3QwB/2DoFIDuCmPd6HW+N4BxDGgz4TX/Vy/ecA8Xiq
         GykmfY1iSDkdDYbS7QgYTsmsMxTyI6lmuTvw70wq0sUoDqqZxk13KLX2LsEm36KaEMlG
         d+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ytZGPKQBsgePTFk8nBNZCqEs9yPPwA8MYf3sa3pnTvQ=;
        b=JEEhglkBNHt08n12n6WPoYazMWfavGCelY0TYMCbkkLSNNJNYa9Hn+wwYRPZobrs8O
         UwDo6ka+Nzm3BJKlVFANH/0r4VVmCpI4wlnHT1MjjQA3wF80X+dZ9I3qidCUkMVEILqO
         XwN2oMkgK1rZrMZgP7ZbwVWufg864kfSuw2pMRb8lxUmoWaRSzfYF95LE1w8Vn/BLPsD
         MGnCC9ktWoeChoFNwAgd4lEJQNe6kNwAK628zepqZf+I1duTAKGdqikVou4qLIKEFKTc
         FXtS6SiJjUg1XnpNxXDeTraECS+uCDvdWRrcBqy07DI7dWfBJB2yEa4rVDAGTJBf9rOD
         Bvww==
X-Gm-Message-State: AOAM533G9e8BBXSV6l/YRwU8+ATf3b5g1dM+vuS0DaM7s7QqO/XxoEkl
        dJtDBcSvjQvlOgWGqZ+xeVdR+U5zMCY=
X-Google-Smtp-Source: ABdhPJwxmD9+kSx0oyAgcTsfkZIMxUtFa8/8jqbQCc0DFD+p02RfN1uMjfXk1W7jaDOkAyCSFrhLQw==
X-Received: by 2002:a5d:588a:0:b0:204:1f46:cf08 with SMTP id n10-20020a5d588a000000b002041f46cf08mr5665129wrf.133.1647972050515;
        Tue, 22 Mar 2022 11:00:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c224600b0038cbfb9cfbcsm410054wmm.47.2022.03.22.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:50 -0700 (PDT)
Message-Id: <5b3381c223e272ee939cba7b1be8617b6eb597f8.1647972011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:00:04 +0000
Subject: [PATCH v7 23/29] t/helper/test-chmtime: skip directories on Windows
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

