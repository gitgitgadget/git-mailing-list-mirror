Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85427C04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiHXVV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiHXVV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:21:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF648165BC
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n7so22275002wrv.4
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=I3Ojpviz0Kfb3I0CUQKssWArPb+HJXPRsrZsL/QUGG0=;
        b=P9au5XwTDO0N2i1W20hdkVcP6aTu+hEk56PMEeJxc9LmIAE7OW92cdsc9NYBROkrdj
         4vh9bhgGQEDJD3Lg6baGd+umzn2JG9oiargMyq2xSSI63+LbBnjcFydQgfenp/v3ZQYB
         E1sC1SwLsYp6uROqm3BVDeGz2wEnvIcQDeOnUDhcANKVy9suL6o8Doydk9+0O82f88Cg
         VnVY1yDaigsP/pZkhAdZvo9S2OCty8f8Yv8OXkiQ5ttJIjINiVM8XX10+8d6XSAdkrEC
         eErcVy86+Lvx2bFRkZQkUEVU5AlRLvYegpYvjv4NQKL8LhSUxPQDHvzrCHZj4mi/gXlJ
         5i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=I3Ojpviz0Kfb3I0CUQKssWArPb+HJXPRsrZsL/QUGG0=;
        b=MMdHhu7XWl3+Kl0VY5nrnjQPHkJwm+LxyrHG5BDzftwB21R3kbSZ9sDbAZLZBV+BUC
         hXIVy8zpId8GQ9LvyOOrv/ypaV9msD7WOfhBjh4OdICWyqUjNKjgYq15HZDVHsXquzRa
         wP7KqrvUThWp3kgakOFDzooN/Y8PsP0YFimzR3Q1Ia2f5wjG670mdakhRLAby7nM24I2
         3NmpB/64dCgndjUS5fJVnAcXloXFQ6qmDFVJQ8tKkOLaA4Lk4lHEjhMVQuyZtn8eid9R
         GxroJL6wxKa5nm2104z1x/R7/hJuVnQU1A6S6/HnXMnSjTyVw2AlyZ/oNEaCt/U1jU36
         78bg==
X-Gm-Message-State: ACgBeo0XSmh6heeIRiBVGM+02kwO0XD5hTxFViC7fShwLRSI8th/ouBI
        8k55KcSviIRQcqvjJmtsfgaT2VH+37g=
X-Google-Smtp-Source: AA6agR6PdLjSpK4I5OGsr50MwY+v0i1zZ3b1V4dGjKKVy/iDgi7bM3a6cQ8H+2aYRjlGjXlsIlmZ5w==
X-Received: by 2002:a5d:50c8:0:b0:225:75f6:2bf8 with SMTP id f8-20020a5d50c8000000b0022575f62bf8mr531088wrt.673.1661376114056;
        Wed, 24 Aug 2022 14:21:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b00225221fd286sm17917907wri.114.2022.08.24.14.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:21:53 -0700 (PDT)
Message-Id: <74ab50eeb1c6debd2f371e548cf6c782479f69af.1661376112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 21:21:48 +0000
Subject: [PATCH v2 1/4] t3701: redefine what is "bogus" output of a diff
 filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When parsing the colored version of a diff, the interactive `add`
command really relies on the colored version having the same number of
lines as the non-colored version. That is an invariant.

However, in the 'detect bogus diffFilter output' test case in t3701, we
essentially required a hunk header that contains parseable `@@ ... @@`
hunk headers, and called all colored diffs without such hunks bogus.

The reason for this is that we would like to show the users the adjusted
hunk headers _including_ the extra part after the `@@ ... @@`
information, which usually contains things like the function name or
soms such.

Now, there is a _very_ popular diff colorizer called `diff-so-fancy`
that does not produce such colored diffs as the built-in `add` command
expects. Nevertheless, the Perl variant of the `add` command handles
those nicely, essentially by ignoring the hunk header and saying "there
is nothing else we can show except the original hunk header, even if we
had to adjust the line range and the original hunk header might get that
wrong".

In preparation for teaching the built-in interactive `add` to be a bit
more lenient, let's change the 'detect bogus diffFilter output' test
case so that it verifies that a mismatched number of lines causes the
command to error out, but not an unparseable hunk header.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b354fb39de8..b40d1c94d99 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -761,7 +761,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	git reset --hard &&
 
 	echo content >test &&
-	test_config interactive.diffFilter "sed 1d" &&
+	test_config interactive.diffFilter "sed q" &&
 	printf y >y &&
 	force_color test_must_fail git add -p <y
 '
-- 
gitgitgadget

