Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7211C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbiF1N23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346455AbiF1N13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7C3336C
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so6745848wmp.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/DTqwhRJC4KoqsbcyLMTYmiluX61VWs/BXv0a2z1TMA=;
        b=oOogTZUSsbblhQSEYYDfZ7oLb3AcfR247Yu9DNh7sqcdC6cCemzBHQ26lbV15JYnYW
         5FOs8RAydIc3gBjoZmtOmDfuCDaBiZa97PArllksCommIDYVqNKj/y8ee+qiM7bYGwu2
         EBKvk4G1YyIYvqvGWVbMUbeN1E0qsg6bDCMbnrk9e5ww6ANc1kJn5WBfHBcXwqnrJnqy
         rSyoc5CGKu2bEwPyHTXhS478l0VllspVt3bkcHYG4/YYZg1fOIDQYusU9bPbY7T/pZzy
         0XXqTxFHYHJji7HTdld7ofujpuZhPkpnnWjFImFcm7yn0SmX7E7+CNUZyX4mNIv77bHD
         SMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/DTqwhRJC4KoqsbcyLMTYmiluX61VWs/BXv0a2z1TMA=;
        b=oG3If93bbQPawqC+8dU810xZ4gGpPC/JChC4niVNgmGhobtSbtNeryBu9h9iZAFPm6
         9FSiSU/u02/+LZ7/GnRGNA2J+CgGMK6y/ovvjFIJoixXelV0FAY9BnNrXvyyVXdrHfx5
         mZBnIfgANvJM/c80jDpEnx93lQOIKQFjucfwVhiFky7V/wjYtlbQaFkuXIfzcH/41GeM
         xO4gC9+cmwE9n3adHVRGV99ISiAw6XHTWyd0zxEJP3oIG55YCGfKsbjkev6pGbvYx3Ub
         EHOnvCee59lcw70j1qO6SR+nDAffwmWpsxjNrnaHWMxyDzReeG0CkoHpyO3lFXAlj7Zo
         IGwA==
X-Gm-Message-State: AJIora+2O/m4PXE8p0MzpewGPwtdLgiNyxqZK2WEf0kOVY0uCanDsbej
        jANBD53Li1yKe8Bn+Yep6KeqbryKJHqFlA==
X-Google-Smtp-Source: AGRyM1uG+OLZLxAv9He2xhrUbqrlOT0qDWUPrdnjRVJeMdzLNtkBopge+iPQqMe67oWPiK5moP5Gew==
X-Received: by 2002:a05:600c:3c83:b0:39c:9039:852c with SMTP id bg3-20020a05600c3c8300b0039c9039852cmr21965884wmb.187.1656422763943;
        Tue, 28 Jun 2022 06:26:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ib3-20020a05600ca14300b003a04e6410e0sm4723498wmb.33.2022.06.28.06.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:26:03 -0700 (PDT)
Message-Id: <669f4abd59e7dbb13281e85144d085180934fd15.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:25:54 +0000
Subject: [PATCH v3 3/8] rebase-interactive: update 'merge' description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'merge' command description for the todo list documentation in an
interactive rebase has multiple lines. The lines other than the first
one start with dots ('.') while the similar multi-line documentation for
'fixup' does not.

The 'merge' command was documented when interactive rebase was first
ported to C in 145e05ac44b (rebase -i: rewrite append_todo_help() in C,
2018-08-10). These dots might have been carried over from the previous
shell implementation.

The 'fixup' command was documented more recently in 9e3cebd97cb (rebase
-i: add fixup [-C | -c] command, 2021-01-29).

Looking at the output in an editor, my personal opinion is that the dots
are unnecessary and noisy. Remove them now before adding more commands
with multi-line documentation.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 rebase-interactive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 87649d0c016..22394224faa 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -54,9 +54,9 @@ void append_todo_help(int command_count,
 "l, label <label> = label current HEAD with a name\n"
 "t, reset <label> = reset HEAD to a label\n"
 "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
-".       create a merge commit using the original merge commit's\n"
-".       message (or the oneline, if no original merge commit was\n"
-".       specified); use -c <commit> to reword the commit message\n"
+"        create a merge commit using the original merge commit's\n"
+"        message (or the oneline, if no original merge commit was\n"
+"        specified); use -c <commit> to reword the commit message\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
-- 
gitgitgadget

