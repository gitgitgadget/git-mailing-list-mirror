Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CEC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiCYT1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiCYT1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:27:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9032B5ADC
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:00:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a1so12054626wrh.10
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MEG3piFdmt+jIkWUnne4CEZ7uXu+O+UAM85s3uqrVgA=;
        b=OEapDRwuPMWfK7CzBIMeZ8xhlRkfwKkJlXswvtJaIuvPVzXz8DkKqq2NOsJzR5RouH
         /04DTPEmqUHyUZD9xb9WSZ0o4M+n4MmAHD2JkjYR7/aZKT7tU3vTtZEKbO1fG/4f8RaW
         FBwgkiM/f3bArCN6bafkHH7AlETRWlWHWRuz0ZtD4ZBxnWl1DRdUt5Z48gtrdUV65O4c
         Y1XGWis6ihXkGk7uFTgXNC7HcM99or/r5zAB8dhqFrGbpwiawkWC0oOTqvVd9XO4Af02
         ZgTP5p4MoL16zgfTXn6iBtuAOOehx74Gtd352fraSWWILtKWQmDcMn8AFikFhB7dDn6Q
         GJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MEG3piFdmt+jIkWUnne4CEZ7uXu+O+UAM85s3uqrVgA=;
        b=L6d0ADygSHCzpxXIAMOqTxqFn5a6+Lb5xTiQmyUo/RJ98SG+NqqulsqsKP5Zh9qQeR
         IPsO7X4TYh7hx6eoR9vxIXpti7Hxer4esRJAfDHH/4q5whlb0xEZhtl55NLa1t+t0c2c
         EnWnmnRt2zMcpEUXJir3pNVudl6IA2Wf1DiDjB1KoKCSmQPhIpqO8gqY5ybjxd8r5j41
         PS2u4syUu50PA5D3eDPLdHokUDaBkOWFJA1fuyzAuDhlebmqEK2ACrhUcAEk006IXrj1
         WusyBUkjN/qBujlcv/iB+WhegJD00e5ITAy1zAE5qMXbiMldmo9MUG9nq2GA6qVVvhmc
         iVog==
X-Gm-Message-State: AOAM531CBji4iRJiwRCNO08Yo5jEoFbqm+fMh3pcAUOvBJ6TqbI5oq41
        3+KrZfeQWmZQMPhkupxheIUy0f4CvXk=
X-Google-Smtp-Source: ABdhPJz8ESI+Io36sQXiQ/DSPiz/Qjq6JZ5Ea37pbjGtMcpCZ4/+7Mt5QuLUPDQX+F0Yuourc6TdAg==
X-Received: by 2002:adf:e744:0:b0:204:213:ae40 with SMTP id c4-20020adfe744000000b002040213ae40mr10445974wrn.344.1648231419303;
        Fri, 25 Mar 2022 11:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm9115215wmj.5.2022.03.25.11.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:38 -0700 (PDT)
Message-Id: <06d56d3a733f4fc5ae7fdfa90a667ae99bda1a0e.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:05 +0000
Subject: [PATCH v9 22/30] t/perf: avoid copying builtin fsmonitor files into
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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

