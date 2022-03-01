Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA4DC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbiCASpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiCASoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4495965400
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b5so22003780wrr.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MEG3piFdmt+jIkWUnne4CEZ7uXu+O+UAM85s3uqrVgA=;
        b=Mh6t/WWtys/Q3w+gpeqxQEfwmwyA1i0lq6/BCStYKYIww3lnpBL3BS+9wIz2TTiL0j
         U1a+iXJxgr2OfnRrlAiCj33uuubVKLbPLGA7kcyPuS3ZUtYJQJmZTpPghn0Ze+XDLH5d
         lNGIi3yIG6By46oil36votHXf36VBsZJu8I63D3tob8LUVVR4ICHsTzE0DGZBOCCELUG
         dp2JAyNDj7OXsBJ+pi+79PKw0eWr3DaCq8qUr/TfUpk2N39QF4MB5y25jun2a0QtlVyW
         SoxlBGKwg9UfZTgV39lrk5pc4tUhzkpeYEoYHEzgXD57PkQToYlRoMpRzGM6HhgAfNdn
         D+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MEG3piFdmt+jIkWUnne4CEZ7uXu+O+UAM85s3uqrVgA=;
        b=U6jXcdUm7zc2JSjl5c70KvwA3IN0YTfwywz6sbQr7J1VG7Wwao9dMMWtUgjMMmhHDU
         lxv8wtOD3mBlWh2Bv2ehJ59ycuzlQFMcMxSLFuPzyHPB3coEfzM5ZFHWOcCcQM/+1A21
         0w/DzbpGNKMl/vN6JOOXEkp3YHU8E37iypyP250Wmr3Tb7jkCb/O+x0yzyhGbIVvcReC
         oInUITfZbhWxIcZkacif2pAiv+1o3jV6JtyOHtj+4omVp/az7XAtvEex3kVkEtwASEIE
         dAaS/Q1wIoPilvQOvJUn7QcPB7l9vjEdFgoLRoZGzWrrtwzPSOMAmeqsUZ6QhRGlXXhg
         3RpA==
X-Gm-Message-State: AOAM531hLB4v32SjFktcqY/zAMjOgoBDZ+9Wz3dRnVc1rSH3/4rWegcl
        esYZ/muBuuLIyLOyTbZ4jDr4Zob4Hps=
X-Google-Smtp-Source: ABdhPJw4vbp/k0CTgYo7Fj1vblrdHYXhpHP0GyY6GguN0M/KzmIA4rJE9taDpBn1/IYOxZBfC4lDkg==
X-Received: by 2002:a05:6000:178e:b0:1ef:b76e:f54 with SMTP id e14-20020a056000178e00b001efb76e0f54mr9426790wrg.324.1646160233633;
        Tue, 01 Mar 2022 10:43:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b001efd7eb7c37sm6418178wrp.34.2022.03.01.10.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:53 -0800 (PST)
Message-Id: <15bd5aaff366169a22ad3fb94b412a7be38d1737.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:24 +0000
Subject: [PATCH v6 22/30] t/perf: avoid copying builtin fsmonitor files into
 test repo
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

Do not copy any of the various fsmonitor--daemon files from the .git
directory of the (GIT_PREF_REPO or GIT_PERF_LARGE_REPO) source repo
into the test's trash directory.

When perf tests start, they copy the contents of the source repo into
the test's trash directory.  If fsmonitor is running in the source repo,
there may be control files, such as the IPC socket and/or fsmonitor
cookie files.  These should not be copied into the test repo.

Unix domain sockets cannot be copied in the manner used by the test
setup, so if present, the test setup fails.

Cookie files are harmless, but we should avoid them.

The builtin fsmonitor keeps all such control files/sockets in
.git/fsmonitor--daemon*, so it is simple to exclude them.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 407252bac70..932105cd12c 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -78,7 +78,7 @@ test_perf_copy_repo_contents () {
 	for stuff in "$1"/*
 	do
 		case "$stuff" in
-		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees)
+		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees|*/fsmonitor--daemon*)
 			;;
 		*)
 			cp -R "$stuff" "$repo/.git/" || exit 1
-- 
gitgitgadget

