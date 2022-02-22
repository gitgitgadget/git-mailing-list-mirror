Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691A6C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiBVQbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiBVQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:06 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79412167F9D
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az13-20020a05600c600d00b003808a3380faso2359302wmb.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k6msMRouowcPy1JbPOTM76KbYM5kdF+S736MfpKzJK4=;
        b=kHDgvGXACEnGE0uo9U+wVx4xJL1cCdBFSiFm9WL6+kICahlNeKKyMiyJXgl9LHd7E4
         fWzC41+cz/Ihs1ceP4SRyWWqut1co3XHjNDf9sD7GDpnT6oCIgGEjdbTZJ50gaqOX8bL
         emSCDGemwBsOxNqSvVACmbcbAh8UZN+B4mKVg633s8QwgptBVBhE61YaV+LvMTyOFnCF
         eaCYDsaJsaQydQdptTooCMe1p/zvM2LU09B4A5SnYrI0e2u7n2Ff4Uv+R139wqIgP9jy
         i3oaDW+c7anHN2yUvjRBTDkM0l+0xUnVka122DOUHlB7A0ITqDHNyHf9iHAh7BqCCKHr
         WyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k6msMRouowcPy1JbPOTM76KbYM5kdF+S736MfpKzJK4=;
        b=nq45eaNGmPNf2A6fpG1S1qnpeR4T3TWkVBy+YurOdpwDvKb8vF4/6avoXJvsZC2++K
         bAixmoDhIR46jnIDWlh8ue+wA8sUXq62DJAbP7PyZOXiOD19ouWkHCkgirGNpjIkNQ1J
         6vKt38ve2m9yooMIM5mvxND86qgxf9afcnRcJ/reTmf44Zdwq7crTfSyFzUetiuyUtEm
         rUkRI73ua+uhcaJmGCBZf2V3zzv8iO98yokOv9Oy0M9cTbCO//dA3qC9xHwAmsXUm+5x
         0jdvhhhsca9oAuI8NGe87+BWLTV9Ijn5wZuXJ6bh5u/b4DDfLiF6kn9aLn+ssAnfskir
         SqnQ==
X-Gm-Message-State: AOAM531E5UCaoAnPWn8QlBTNIsZkBaM8i7xFHc6+xdmJdNghjHSEONSh
        ToPI5z2uVf77M3oCEg8H/On0doWznm4=
X-Google-Smtp-Source: ABdhPJz7BeKcKri0w9cEW/YbRF+DkHvbaBkjal5YR23/zRbmYYBZf68lySSGQ4821/W9jLpYfJA4xQ==
X-Received: by 2002:a05:600c:3aca:b0:37c:533d:d296 with SMTP id d10-20020a05600c3aca00b0037c533dd296mr3980004wms.147.1645547435905;
        Tue, 22 Feb 2022 08:30:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm46998645wrz.40.2022.02.22.08.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:35 -0800 (PST)
Message-Id: <0611d16f772597f160bbc32ad9275ddbaec251a0.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:22 +0000
Subject: [PATCH v2 13/14] bisect: remove Cogito-related code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Once upon a time, there was this idea that Git would not actually be a
single coherent program, but rather a set of low-level programs that
users cobble together via shell scripts, or develop high-level user
interfaces for Git, or both.

Cogito was such a high-level user interface, incidentally implemented
via shell scripts that cobble together Git calls.

It did turn out relatively quickly that Git would much rather provide a
useful high-level user interface itself.

As of April 19th, 2007, Cogito was therefore discontinued (see
https://lore.kernel.org/git/20070419124648.GL4489@pasky.or.cz/).

Nevertheless, for almost 15 years after that announcement, Git carried
special code in `git bisect` to accommodate Cogito.

Since it is beyond doubt that there are no more Cogito users, let's
remove the last remnant of Cogito-accommodating code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 1493d7d1d96..e8a346fa516 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -15,7 +15,6 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
@@ -756,13 +755,6 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
 		} else if (!get_oid(head, &head_oid) &&
 			   skip_prefix(head, "refs/heads/", &head)) {
-			/*
-			 * This error message should only be triggered by
-			 * cogito usage, and cogito users should understand
-			 * it relates to cg-seek.
-			 */
-			if (!is_empty_or_missing_file(git_path_head_name()))
-				return error(_("won't bisect on cg-seek'ed tree"));
 			strbuf_addstr(&start_head, head);
 		} else {
 			return error(_("bad HEAD - strange symbolic ref"));
-- 
gitgitgadget

