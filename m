Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8FD1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 10:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeHWNip (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 09:38:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34011 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHWNip (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 09:38:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id m199-v6so1471752wma.1
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1SCVWamnBmiK/BXjf99Be91+K1bFcyF7DGdZeUtBSU=;
        b=suxpvMxFSDRmnRuT6aVoR3h6siweBoSpBZXAUieB6119Zs7jF1aquac0CnX1sukh6l
         CLa0DxPcLlRcAHACb+8+6UOTnQD9JFGrmsILmmc6T6nkqvWEYipqkhZi5Hv72g7DJK83
         17RmORuRz4ZMPNzUGaA2Z/guU3DbbwV2NJy8mg2ZtS1XPTfHLGxaK20jnzFSGhNB3grJ
         y8Wsu0G7x3Vte+BVJcQYaityMu8h4Cj3hmMG1ZxM6JZcYlFcMNR49NYqFeupqxHQkjPI
         +BchFfiAql4bbnC+1wq6xOwIk0LOEvEos/+LZT2B+ZpZefol4Ofx/ISwCSs03Mvb7XJ9
         Yd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1SCVWamnBmiK/BXjf99Be91+K1bFcyF7DGdZeUtBSU=;
        b=buDsbjzqfdKqNuIaKaUDaBg2MQeJZ0HC2+Tpjj+Ggagtp8ZFx1n8212rGs2L+wSlfC
         iJQfxC3da0iUTwamR5eZqMYHlnGYKpv7b3vVboKFrHzW85GvEKGS0vEB7IlyZNMNrjj5
         jQdtFITz2I2aL1rBbO26QtY1r7PgE1k5ykJrS5XqP/A7LFBpMvj7XjQmN+YvGxRmOHGg
         W9jwUhnwnV6CMGZ5ZCz6gZAPlVEmXMI23p39xcDZOXkrzM0PlWidfwDayfsmGAe5+Hdw
         MjXzpEWeVaJFpPHIq0rVZQuvS3/fheBEtaG4lp4AHgaScvyiTQSddIoRwGlHmFjx/v3U
         l1pg==
X-Gm-Message-State: APzg51BPyI4RziLGZfxBbUb1YAew1QzxtiVYwkQUGjTJUxQpLyZleqdn
        EAHI/F1166/9ss0vAajWeZ0=
X-Google-Smtp-Source: ANB0Vda+FZQ/bvIyVZfVIWKPPZteCYYXasVD5w/743U+1FGpHWKlB+Y4V4/0/7iQ33vuZhmYF+ILcw==
X-Received: by 2002:a1c:ec06:: with SMTP id k6-v6mr4945959wmh.39.1535018985883;
        Thu, 23 Aug 2018 03:09:45 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id x65-v6sm1483491wmg.39.2018.08.23.03.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Aug 2018 03:09:44 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t/lib-rebase.sh: support explicit 'pick' commands in 'fake_editor.sh'
Date:   Thu, 23 Aug 2018 12:09:15 +0200
Message-Id: <20180823100915.22855-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.136.gd2dd172e64
In-Reply-To: <20180619124651.17425-1-phillip.wood@talktalk.net>
References: <20180619124651.17425-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verbose output of the test 'reword without issues functions as
intended' in 't3423-rebase-reword.sh', added in a9279c6785 (sequencer:
do not squash 'reword' commits when we hit conflicts, 2018-06-19),
contains the following error output:

  sed: -e expression #1, char 2: extra characters after command

This error comes from within the 'fake-editor.sh' script created by
'lib-rebase.sh's set_fake_editor() function, and the root cause is the
FAKE_LINES="pick 1 reword 2" variable in the test in question, in
particular the "pick" word.  'fake-editor.sh' assumes 'pick' to be the
default rebase command and doesn't support an explicit 'pick' command
in FAKE_LINES.  As a result, 'pick' will be used instead of a line
number when assembling the following 'sed' script:

  sed -n picks/^pick/pick/p

which triggers the aforementioned error.

Luckily, this didn't affect the test's correctness: the erroring 'sed'
command doesn't write anything to the todo script, and processing the
rest of FAKE_LINES generates the desired todo script, as if that
'pick' command were not there at all.

The minimal fix would be to remove the 'pick' word from FAKE_LINES,
but that would leave us susceptible to similar issues in the future.

Instead, teach the fake-editor script to recognize an explicit 'pick'
command, which is still a fairly trivial change.

In the future we might want to consider reinforcing this fake editor
script with an &&-chain and stricter parsing of the FAKE_LINES
variable (e.g. to error out when encountering unknown rebase commands
or commands and line numbers in the wrong order).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 25a77ee5cb..592865d019 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -47,7 +47,7 @@ set_fake_editor () {
 	action=pick
 	for line in $FAKE_LINES; do
 		case $line in
-		squash|fixup|edit|reword|drop)
+		pick|squash|fixup|edit|reword|drop)
 			action="$line";;
 		exec*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
-- 
2.19.0.rc0.136.gd2dd172e64

