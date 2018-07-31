Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2951F597
	for <e@80x24.org>; Tue, 31 Jul 2018 12:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeGaNv3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 09:51:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53275 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbeGaNv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 09:51:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so2808167wmh.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+kF/N6hxz59yfNG0w3bc4X7yRjdcbPN6YEZo/YF674=;
        b=MbBPKMKUnfeRiutQG2q5ODxNpYTRwJCKc/eDoXG3XY9bH4PY4YtsBXPCdnEnfPkABV
         vb2SiElWrMcNhGge7nujoAJK5TNuKmQ1tEBGQo1uRqInyNv+iMu8iOonm8PC0QQjK60H
         bsAYrYZhuha2xIYcRTVBfpoWpHgbw0rrSNY6Wqzqj8F2uu8oOgEoLqKx5iAW1/YzbLcM
         2CYJvBxyxXCjbBRdN64bNHEl/ZFAjXfXvR8D3OVqUovtmkHLXYxNbbhFwHdR7CLna8PX
         4VY1tcrtx/4/Nxupbro0COBgZOqTtRwVCBpffu6MAlEUHvMAoYgTINPLy6l9SFvy/+nk
         P5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+kF/N6hxz59yfNG0w3bc4X7yRjdcbPN6YEZo/YF674=;
        b=VCMgEGFB+aJVX1YSZYb+SgpLMXB7QBODa60/j0egJgPMROt1WwCTyWik7SDUcgPrye
         I8G/eIQKoOC/wLU8W8fObMAiS4x7jTDebaq2yMXmWH0oDrgNn0vd82f7K53sEevaefXu
         Dwd5DdOg78CaX6bbFYmjxWaib9ZwKzfsu+HwroYYOsy0mFYeufREc4dMElCZ1K9SBsvG
         45gKq9rfZY8FxQQ7y3coSVbYuYoaSHIi+CLtveAh0jD9NQDQw/gnawqvGokE6fCrxKop
         ajlpeLBr/YS9xYZUgBUbue9pcGOKUQtgDxdV4XbVZGGZv4ljV0V/dw45N8UbkoodpPFH
         +3+g==
X-Gm-Message-State: AOUpUlGdISvlw3Sgd2HLLVG0SUHSZpnJHMsWA1sM+8NT4MqTmSJ3EAS7
        CxyjP8uzaoA3yJHxnM6R+/hE9RmN
X-Google-Smtp-Source: AAOMgpejjVgBlxGFyakGQZgXuAjcIXXcv+c3oALjBVzWHIewpxzktd7BIjo3GrPFZz6hdurxjrNsIg==
X-Received: by 2002:a1c:3605:: with SMTP id d5-v6mr1387908wma.95.1533039085500;
        Tue, 31 Jul 2018 05:11:25 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id t135-v6sm3958854wme.0.2018.07.31.05.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 05:11:24 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4] fixup! rebase -i: rewrite write_basic_state() in C
Date:   Tue, 31 Jul 2018 14:11:15 +0200
Message-Id: <20180731121115.12296-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730182516.32644-1-szeder.dev@gmail.com>
References: <20180730182516.32644-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As pointed out by SZEDER Gábor, git-rebase.sh wrote to to 'quiet' with
an `echo`:

    echo "$GIT_QUIET" > "$state_dir/quiet"

This mean that even if $GIT_QUIET is empty, a newline is written to
quiet.  The rewrite of write_basic_state() changed this behaviour, which
could lead to problems.  This patch changes the rewritten version to
behave like the shell version.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Hi Junio, could you apply this patch on top of ag/rebase-i-in-c, please?

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d257903db0..0d41e82953 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2332,7 +2332,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 	if (quiet)
 		write_file(rebase_path_quiet(), "%s\n", quiet);
 	else
-		write_file(rebase_path_quiet(), "");
+		write_file(rebase_path_quiet(), "\n");
 
 	if (opts->verbose)
 		write_file(rebase_path_verbose(), "");
-- 
2.18.0

