Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240661F453
	for <e@80x24.org>; Fri, 26 Apr 2019 02:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfDZCuG (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 22:50:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41945 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfDZCuG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 22:50:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id c12so2175376wrt.8
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 19:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=IJMWn/lIQsWotA+LWx+aMiUE5DLQzZvdV9/AAnqK0j0=;
        b=O3R7SK/l5kV8LYdqMXo1337i9qyhp6SH8TfhtBom3/F/6xDSX6PiqmLpbaWOy08SLu
         rE8X9B7ehHUPiWNzvPCrRwhVNMDoHLOfOJDPEXdXAZMRj9VkQhnNU+AGMqq6bleg4jmf
         sGAR3VZqOvcueC/mrzwInhv7kIeMOAtACZHKUaQi7qWoTXpD6jO6cahuBavtHGSfdQ6h
         R9/VBR5TK0/wgWA8YgdrGOfMVe5NmI0lnrtMChruurbCZGGactCcUp/33NTzQ1NTpOMm
         ILZvVdA4KvxctYXLYz9X7BgYG778pOS8WKYY8dMqMOzCZBbo9NE09FYDU7u+t6Fyuday
         OTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=IJMWn/lIQsWotA+LWx+aMiUE5DLQzZvdV9/AAnqK0j0=;
        b=DBA8KnP2Gy4WvgxuDRphZ0nN3ZPSwarUpHNg9tzh62tFIHknJhV/YGvag35HKZcLqo
         OYBYlniBrg90jHHd2KxjEV/d+qAQjJQ5WaNKzUUVxbAj+s+3UgvRLxO5nbJlzhpBDm17
         LUpUib7wvPcuSNyUURT+LolLQ/DUXCcEztLsWj1ccP8XbTxwHYLV0q7BshS8+/o98aHu
         BvnCoI5iBsaEHbr7jJHFYInkF6HdicamRi/eNm5w5cDrC2tWavwhd0oZJLI3QhlpLG6o
         olZQiD6gpBFQ8z9s89MEt54tVH8GXb8qIuKTBGYNcoVbuSE7dXDx5+kgBe/wHe4WNcZm
         l5cQ==
X-Gm-Message-State: APjAAAX1h4w+wTbqYyBJkgmFltWuddSaVK+N+3j1i/f2eErapFbjl0CC
        ILgeCgrInQrtTb1VwWFp+aU=
X-Google-Smtp-Source: APXvYqx9CN0sXhsn/x6sC8BXs5pqqdqQZghc0qqdLewqQswquMjP51EPwzeFZdEnJcaHN6KKfRb3NQ==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr5121530wrw.41.1556247004532;
        Thu, 25 Apr 2019 19:50:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id i17sm21378493wrs.44.2019.04.25.19.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 19:50:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t2018: cleanup in current test
In-Reply-To: <CAPig+cTdJv9-M+zmp+Jo2bjOrkO3NgsguJ2xM+aXhf38OjjEEw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 25 Apr 2019 18:34:07 -0400")
References: <cover.1556226502.git.liu.denton@gmail.com>
        <c0c7171e3d523e5d4a0ac01810378447a38854da.1556226502.git.liu.denton@gmail.com>
        <CAPig+cTdJv9-M+zmp+Jo2bjOrkO3NgsguJ2xM+aXhf38OjjEEw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 26 Apr 2019 11:50:03 +0900
Message-ID: <xmqqtvelv5t0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>  test_expect_success 'checkout -b to a new branch, set to HEAD' '
>> +       test_when_finished test_might_fail git branch -D branch2 &&
>> +       test_when_finished git checkout branch1 &&
>
> I'm aware that when-finished actions fire in reverse order but the
> inherent subtlety of ordering of these two invocations still caught me
> off-guard for a moment since they are reverse the order in which one
> logically thinks about the actions which need to be performed. I
> wonder if it would be easier to digest if written like this:
>
>     test_when_finished '
>         git checkout branch1 &&
>         test_might_fail git branch -D branch2
>     ' &&

Perhaps.  Be careful in choosing the quotes between sq and dq,
though.
