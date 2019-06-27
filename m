Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBAB1F4B6
	for <e@80x24.org>; Thu, 27 Jun 2019 14:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfF0OMs (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 10:12:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39430 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0OMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 10:12:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so7223575edv.6
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZrDfHAl4D38TETnmB8ZBk+2croYABqJTXP3K21RuVqs=;
        b=F0EClCHkLCzeUU4UtOjxF8FkErZuAkmiCQak/y/L07U9O6uKuukCnlkEjUIechEZ0b
         5SdJglJI4t+GtKr8b1tOmk73/R3qsiNAhTQgBFQ7YOU23PSe8XbzOoYnyAaKyaKXQ0xV
         JCijeJ3SMFhte2Izf8sO832jXx7AacKupYiSwxRQWU9bofpsFnXMMRTDBjpAb+iY+2U+
         +btBz+d1Go0yW23KAeNC6Cnq+QxCWMw0JnxIpONjDfsn742lyzdCanyJZ98Z+bT7Vk96
         XY6+PKXJa/zmvP5XMt+qeYXtUTp79adEs7AM8eW1dOqfYhodLerswz5FrUCew1OmGmvr
         BN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZrDfHAl4D38TETnmB8ZBk+2croYABqJTXP3K21RuVqs=;
        b=GA86cJ/DC51DoA6PJJVxK2jWfFdDKbiVr5RgBofLPyv0UN9g71iLmMlpRJP9AuQdOK
         JqP3+x7ZtvVJnqdbzmtPAZ1iYusDyvLyrU3N/TkgoIh7v3xwbU1+CCLjL0z8m1sWerF0
         Tei9drglQNAtDunXaUqxhdL/YSXpYzMyuiiCkOtGZkOVOCe5M84jAoNgsq6QgbrfanG+
         YrBsGiRbI7DuGWfbSQmVphBNX7JPEzNumh+J5aDGpWlp3ZTKrvXfadTp8OiA+zCDnqEM
         UQp8h0Qu1SU8HWuoX+dHTqJBVd870v9zAy9ftwM5lgAMBdWFsa0GkqGDipEJ/iIJTnK2
         Oc9w==
X-Gm-Message-State: APjAAAXKFvzCcIH6xfsnZr7Ch8yX12aXtRvXZzekB/i3wiUspitIRZvo
        ICfSBJR6uRnsxdNcGY1ZOnPvZMNr
X-Google-Smtp-Source: APXvYqw1k59HuGnK3ioAB2Jr4zwglp+z2bBcEG71DhQ7/ISeL6wp4PeOw4jSDcu3gb2tt3n2QBtdgg==
X-Received: by 2002:a50:c28a:: with SMTP id o10mr4487784edf.182.1561644763725;
        Thu, 27 Jun 2019 07:12:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s47sm800844edd.40.2019.06.27.07.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 07:12:43 -0700 (PDT)
Date:   Thu, 27 Jun 2019 07:12:43 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 14:12:39 GMT
Message-Id: <pull.275.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.275.git.gitgitgadget@gmail.com>
References: <pull.275.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Quieter sequencer status parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments on v1. I've updated the commit message of the second
patch to try and explain why the new function is not a straight-forward copy
of the old code

If we cannot parse the oid in the sequencer todo file do not show an error
when running git status but instead report that a cherry-pick or revert is
in progress. This addresses a confusing error message reported in 
https://public-inbox.org/git/3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com/

These patches are based on maint

Cc: Johannes Schindelin Johannes.Schindelin@gmx.de
[Johannes.Schindelin@gmx.de]

Phillip Wood (3):
  sequencer: always allow tab after command name
  sequencer: factor out todo command name parsing
  status: do not report errors in sequencer/todo

 sequencer.c            | 43 +++++++++++++++++++++---------------------
 t/t7512-status-help.sh | 16 ++++++++++++++++
 2 files changed, 37 insertions(+), 22 deletions(-)


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-275%2Fphillipwood%2Fwip%2Fquieter%C2%A0sequencer%C2%A0status%C2%A0parsing-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-275/phillipwood/wip/quieter sequencer status parsing-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/275

Range-diff vs v1:

 1:  a5bede1cf9 = 1:  a5bede1cf9 sequencer: always allow tab after command name
 2:  ebe8a2b3a1 ! 2:  c3885c0b8f sequencer: factor out todo command name parsing
     @@ -3,9 +3,19 @@
          sequencer: factor out todo command name parsing
      
          Factor out the code that parses the name of the command at the start of
     -    each line in the todo file into it's own function so that it can be used
     +    each line in the todo file into its own function so that it can be used
          in the next commit.
      
     +    As I don't want to burden other callers with having to pass in a pointer
     +    to the end of the line the test for an abbreviated command is
     +    changed. This change should not affect the behavior. Instead of testing
     +    `eol == bol + 1` the new code checks for the end of the line by testing
     +    for '\n', '\r' or '\0' following the abbreviated name. To avoid reading
     +    past the end of an empty string it also checks that there is actually a
     +    single character abbreviation before testing if it matches. This
     +    prevents it from matching '\0' as the abbreviated name and then trying
     +    to read another character.
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       diff --git a/sequencer.c b/sequencer.c
 3:  af4b823caa = 3:  3e8fb61fb8 status: do not report errors in sequencer/todo

-- 
gitgitgadget
