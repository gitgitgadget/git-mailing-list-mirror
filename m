Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2291F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeDJVqP (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:46:15 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34474 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDJVqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:46:14 -0400
Received: by mail-wm0-f49.google.com with SMTP id w2so23274549wmw.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VwCBwKSS4ehptfwT28tH3BcMZ2qETfXdeBGRNtAxn+A=;
        b=iv5xAZACI8stOp8gNANxuc3aEEubPzVU4BFeWUySs+JLxIg0GD0amB73SbncJBBZDf
         TeiE9HNMbEZoGhZhlZQZyOIjzVExy4VomOL9uER9SwQSimnO3qpPbvvt+elWDtkDO8R+
         ALZoJRpFk/e7jeZdSyk+c+LbO7Zn9S42DWS61dzlOi0ZgamwFm1Sev23hSnE92MVYyBX
         IvR+yw3Z8ddhLS4g4YbSKykxmq7dXkXdsXrKbAN9MS1DrpFDWtOGKUx4/XNU9UhO+z29
         fs6zlJE5YQLASUL8I6HfzwRQIqqyg7VhhH5YahLUBfTPiNJnlLy3LN4j/YheLCmGK7j7
         lZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VwCBwKSS4ehptfwT28tH3BcMZ2qETfXdeBGRNtAxn+A=;
        b=b+eBuUeflIjxxl7wOSmmRfxFgPf8dYKxyprmh0gdYDAhMM9vLjIrNOBIKF93ovKgsS
         e5ETD3KADs8zgMMh97JWjbl6jpXVD+EaPrbVNkT+It5mW56JlqjsSBiv+V9/utCx9vqy
         r3IjxYtqJZ2pUNxgvqBF7JQIlagOBsvhskLL2GBqAjQCZLc2n6NR+Pwf7/In0w3nreTN
         SN9xXD2iWCcAfQKcbz/9JKbfMSkc7yu+O0A+okMV4wOF2MdeKAXdA+9/mJRRxHGKxKFk
         7B48FSUJCLVLLmBzGGx5U3ZJ9hRi/IE+Jfvjfpnps27sur/JlryXSjhq62TBduXHhbgT
         sl2A==
X-Gm-Message-State: ALQs6tCGv9/Hy9poEZZjWPOhI3mdzLdDGpTRlWT4Vm23aNCOaouYeRoj
        mEztNYWV68bQ7vVpdgV02go=
X-Google-Smtp-Source: AIpwx4/fYCrO3RfFRrAyJvUa4lOkp3bXaD3gX8T24BDk6hGM2cYsJLDShvxduw91aQEPcxx9En3sCQ==
X-Received: by 10.28.150.71 with SMTP id y68mr759589wmd.139.1523396773418;
        Tue, 10 Apr 2018 14:46:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q127sm25543841wmd.3.2018.04.10.14.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:46:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
        <98394864-ece6-5112-0274-b2399087f207@gmail.com>
        <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
        <xmqq4lkk58y0.fsf@gitster-ct.c.googlers.com>
        <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com>
Date:   Wed, 11 Apr 2018 06:46:12 +0900
In-Reply-To: <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com> (Derrick
        Stolee's message of "Tue, 10 Apr 2018 08:57:54 -0400")
Message-ID: <xmqqlgdu20rf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/9/2018 6:08 PM, Junio C Hamano wrote:
>>
>> I guess we'd want a final cleaned-up round after all ;-)  Thanks.
>
> v8 sent [1]. Thanks.

Thanks, will take a look and queue.
