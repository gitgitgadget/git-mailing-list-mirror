Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC36C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiCXQwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351895AbiCXQwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:52:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6AB0A66
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2926050wmb.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MEG3piFdmt+jIkWUnne4CEZ7uXu+O+UAM85s3uqrVgA=;
        b=Q5012fd9k2aAuhit0SgAosIxILxwFV1Fjqlw3YHOlqjCYBQ374Sq2a7thqSYOSUDsd
         hwm11jtyUwgsBuLll1xS6Xn6VunapCH2X7fSlyYNxHpaUBE8TIkM9lZ8KapjSiVKH9bO
         Jdt4G2d+30F0B3e1Y6X6Ud6gqKpzhKObBjc7qnwFR+I98leQONK0BI4kxZFOUG5ieosv
         OqohVInILb1x1/htkP1riM9t7LdXSxKpZhKTtXDQWd9FBKvIxdnnjnHOmMQGW/U5MM6a
         +Lmx22FYS7ylvCivxu+2P0kFGBwWYwtROkGOCzzdnM0VRrfX3VtZ2euIjtJ0SiPLdQsx
         01mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MEG3piFdmt+jIkWUnne4CEZ7uXu+O+UAM85s3uqrVgA=;
        b=MobDs1LWHgF/+Y5HDXMXuoevdw+q/AMZsWwsKdx8tS21b+InObMQvM0igS2AHiMaEJ
         SbM0sgYBCU0IuVy+44LvB6HPYCNAGkoJAwHctgkSL4bpHOiZ7WNh7clCiw53KbAJ2CQt
         GYEgGXrdA6lq37ml9c/OVKQghl8TOxkC31LUgYEF2MrIWiisVJmQ9GPLDfJj7qel9MeV
         GJ6sLZsu2WkDSxHU+isjS2MrtfixplO6WuICYh/rzaaqEmTRM2zV2mnUhid5h5baROtT
         EaGkkE6UkHk4VjPGdNqpf7YOOX9wnnGrw3xwi2bGAmKy84CCsErU3W+I+t8TY5YhhA2z
         gGNQ==
X-Gm-Message-State: AOAM533fvPGg0/FsRJWbAfDV7lMMGCo4sbQMTCOm9flELusOPiQY5D9M
        LI23FIfQ+pgIZRLoaYM1vyT433KmNs8=
X-Google-Smtp-Source: ABdhPJzpdsdR4SZYvkI+aNTKrSrLfR75YUb1tv/bqy2agPTHgZb/VcAmVHh3mvRjbuzwLz4se35/Bg==
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr14754408wmc.146.1648140616699;
        Thu, 24 Mar 2022 09:50:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p30-20020a05600c1d9e00b0038cc9d6ff0bsm3333506wms.33.2022.03.24.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:16 -0700 (PDT)
Message-Id: <cc39ecf10ae4026fed608682f6c0cdc99cff705c.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:38 +0000
Subject: [PATCH v8 22/30] t/perf: avoid copying builtin fsmonitor files into
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

