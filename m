Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF6A1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 07:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393471AbfIWH04 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 03:26:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50211 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393424AbfIWH0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 03:26:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so8601058wmg.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YGmu8q2q7cohNNGhkwWlr6U72TGTWiCcEh3fQtBUFGU=;
        b=CqmKtyttlFJxktvgCU2bI4Co3YDuR5z3c1DQpdkbAEh7U0Ee2/ie5oVJZg8JucdQbI
         GAZE8IzmNaKO7QLtCf0VAFccP75VTn6OBNFd0Ib8dtrlpfdb58GA4K+LXdZMpEr8bZpb
         MIQMdkVzAmRu264nkN9ED25MqevCaMBwmV4yhn3M8DrFqLPYzAVdr8D6d/IWMHdImS/C
         9PUPbfjlFxGkjPNWgXiIKhrYapGdiTpDP/KOTHSvpB0YVbqjNEYRpw4RPQcWzkvhPb8e
         RW8KOi1HnJNE2iXpp4JIpEcOvB1lF3RIM0cQYZzqd2KbcPa8Uab8nGS1I8t1h02ElJkN
         TAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YGmu8q2q7cohNNGhkwWlr6U72TGTWiCcEh3fQtBUFGU=;
        b=qB2JcaZ+Y8QHZYBhDZphMThcJZL1u7skE9t1gHl0OwSL8gMWlohnGpB0TFPB9E54Wd
         eyhB/UGjNIsdwVGLJOvPEWvPBj5pmJSyhAj8eiRUR4aMvyHinVQAopZ9izTuahNSV3eT
         Nq4/fF3IuofvUf0n0Y2+d62cyvCJBKzY+6+varGNStwbiY6AD9V9fpv5aslFjNR/Vh1c
         eY1AarSl83txh/W78VAvhz/RsNaKlpwHl5ck7hDE/knepAAyogFOIqloCL4TotYJW8V9
         vyZIv7X2cCYcRoIyakTmMQ02MFEjvXL0A/z+bZeJLH6x0Q2Oy044k6XpQZ9aqonuEXqn
         AjMQ==
X-Gm-Message-State: APjAAAUjII1B9jawP95nxwMXsAIl/gXvQl8nRyR5EnPULGCKntwFR3ep
        xNiguPvVuTITUvSvjSapmvXzeC9T
X-Google-Smtp-Source: APXvYqwMND+Y6co6JJsnMZEUORGtwOIfQW2WLmvRuRDyiPvacgcrIyfW5WRaGzxdbYBNXZojkLvysg==
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr12110896wme.146.1569223613994;
        Mon, 23 Sep 2019 00:26:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1sm17107841wmb.19.2019.09.23.00.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 00:26:53 -0700 (PDT)
Date:   Mon, 23 Sep 2019 00:26:53 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 07:26:51 GMT
Message-Id: <pull.349.git.gitgitgadget@gmail.com>
From:   "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git-add--interactive.perl: Add progress counter in the prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git contributors!

I'm Kunal Tyagi. While I was choosing the relevant patches for a commit
using the git add -p command, I found that there was no feedback regarding
how many hunks from the current file had been processed and how many were
left. So I decided to add a small change to the prompt which basically just
displays (${current-hunk-id} + 1/${total-hunks}) before displaying the
prompt during user interaction. This patch doesn't account for all total
hunks, only per file.

I don't know perl so even this one liner might have mistakes. I did test
this locally and hope this works for others. Personally, this change feels
helpful to me when I have to separate a long list of changes after an
erroneous commit.

On the #git-devel freenode channel, I was informed that @dscho is rewriting
git-add in C. If so, perhaps a similar change could be added in the rewrite.
I haven't seen his patches in detail so I can't comment if it'll be as
trivial as in perl.

Regards Kunal Tyagi

Kunal Tyagi (1):
  git-add--interactive.perl: Add progress counter in the prompt

 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-349%2Fkunaltyagi%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-349/kunaltyagi/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/349
-- 
gitgitgadget
