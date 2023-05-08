Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA8C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjEHTHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEHTHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:07:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B34C0C
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:07:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9dcfade347so9213732276.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683572836; x=1686164836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ0qP5rWHt49q3sDI66rmMQGsB1IOy1emSvOBxJDA3c=;
        b=lZkhRp9B7R2ma0+jU+c1nd9PL0hCb4n70LyLJ6FXnqEhZrMVrt+LMvAM5BPzsulkuc
         NWsY6tOYRNoJqtfEx4BKWlcOy/QV/Y4/1BqCgK60eVovPLwge5k+vJOFnhLvCU+MW4LO
         DpBc5KtcxhIZS0fgjCEzGuj/AX1FZ6DuyvntHnEEKtJqk6kcwVFdpETMLdKmDHRhXyPI
         B6FpMODodG+U7cAxKMZbkrOAZ+XU0DwjIVhV71YdpUjCptwuuqw38xlC3eTDJnXylppq
         FYoCm2/TxhQAMxptBs5B9ivrFhuo7/gHjFdiC/gaGcPEjgzWeetXouX+3ss3ivPeS9Fo
         dmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572836; x=1686164836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ0qP5rWHt49q3sDI66rmMQGsB1IOy1emSvOBxJDA3c=;
        b=M104zwKvG8skiz/CbPyF+FqCwSsU4HCa8SLeneNwukDanoouYa5MTkYL/LUWuzUjNc
         agR41q6B3rkdOhvfVIR9k3ymaU4CsAGIFMGobrtToUGyzrIsgu0k85QMJxUxVt9MUmSB
         zj2YTNDWlRqdKaemcSAZQp3hSlWDC1Bzv/rqj8YKWQY5b5dHdcTBWW+ihAF3c6afiBtl
         hVKz0lw6g4GvPkI9dbTGLrziYUkWQubZtN7Dukm+u+BLDKfaG2RDj5E4F4FJlQXcTQGF
         IcI+ztr4Z7ofXOZ1hBIdcIXQSRnX7DcZSbd4oehncO8l1gU0sO4u0AIk1wROodrhkqMn
         pHUA==
X-Gm-Message-State: AC+VfDysXiv0nAhMgP9ojBZBa7EVTQjS/qWAei9oGZR4nQJ7ya8iplLm
        hQC5yKxEoqkGcT7uaTJYZIUMeDW+pn8=
X-Google-Smtp-Source: ACHHUZ45bTZ6d6rvC8L1TnnfEZ5GKdX6ZHwJN0NmmPqoL4z4+v8Y+9caX1OKvPuWvbbI8J1fVfl3BeYRTTc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:161a:b0:b8f:485d:9fcc with SMTP id
 bw26-20020a056902161a00b00b8f485d9fccmr5128982ybb.4.1683572836721; Mon, 08
 May 2023 12:07:16 -0700 (PDT)
Date:   Mon, 08 May 2023 12:07:15 -0700
In-Reply-To: <xmqqy1lypvb4.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com> <xmqqy1lypvb4.fsf@gitster.g>
Message-ID: <owlysfc6myl8.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 00/11] docs: interpret-trailers: reword and add examples
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> [jc: making sure that the area expert is aware of the topic]

Thanks for the assist, Junio! (I will run git-blame next time, sorry
about that.)

But also, what does the `jc: ` in your message stand for?


> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> This series makes some small improvements to the docs for
>> git-interpret-trailers. The intent is to make it easier to read for
>> beginners who have never used this command before.

>> Linus Arver (11):
>>    doc: trailer: fix grammar
>>    doc: trailer: swap verb order
>>    doc: trailer: --no-divider: more precise language
>>    doc: trailer: explain "commit mesage part" on first usage
>>    doc: trailer: remove redundant phrasing
>>    doc: trailer: trailer.<token>.cmd: add missing verb phrase
>>    doc: trailer: use angle brackets for <token> and <value>
>>    doc: trailer.<token>.command: refer to existing example
>>    doc: trailer.<token>.command: emphasize deprecation
>>    doc: trailer: mention 'key' in DESCRIPTION
>>    doc: trailer: add more examples in DESCRIPTION

>>   Documentation/git-interpret-trailers.txt | 62 +++++++++++++++---------
>>   1 file changed, 40 insertions(+), 22 deletions(-)


>> base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
>> Published-As:  
>> https://github.com/gitgitgadget/git/releases/tag/pr-git-1506%2Flistx%2Fdoc-trailer-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git  
>> pr-git-1506/listx/doc-trailer-v1
>> Pull-Request: https://github.com/git/git/pull/1506
