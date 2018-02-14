Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5EC81F404
	for <e@80x24.org>; Wed, 14 Feb 2018 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161293AbeBNRfG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 12:35:06 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:45937 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161214AbeBNRfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 12:35:04 -0500
Received: by mail-wr0-f169.google.com with SMTP id h9so738898wre.12
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HKFZEMF+N5EiFAetRrj1Bki9arJIEHT1elV6v8rhzNQ=;
        b=OoJzpW/QnWeC1SUdtnNTAsMmJTtqs2edXZdXI/6C/XGtUK3EXjgpB6Ns02Kz4AC0XZ
         DjZvr9L2EioM4tuT5+4h+3aAw4yOQQlqZzqEw0vYAMrU9OZNYyTXT8D/LDbjJOOFYX4Z
         dcKQAnrdDqh6i+FgmYlMwdEpMgR2Qm5gLmVxGhO/GmQJqbJ3Y8YzgWIhZmMHXy52vGj7
         8g53tVhufT5IE8cuAux/fvctETGzd6Nw9LTOavzgWdyvA9w7lCmBNaiJEnNqiuzAfaXi
         w5p1sof5CnAc6TQB+x22qz6tCQWkZAGtZUn4Q1Zn2XOtLlWi5eWhuKRiFJC2Q8G4iIPO
         ZJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HKFZEMF+N5EiFAetRrj1Bki9arJIEHT1elV6v8rhzNQ=;
        b=rKjEUb6yPgam0o8pq8Vcd1e1LGRz/e7gVreNqfkvDq33g+NfKDZIOJh+Y5DsdivGEi
         oAw/wt+XLB8lTymfKlhWoSqqAU8M5huHxftKs7jlNNbL8Jxcs9uC5lOjXyp2qm8QXHLr
         C5vRnRtBE6rrWo0IqYmN4WhboO7iqOiyYItKC+/CIW9aHA1A4vIls17bZEDVgMoWckmZ
         +3pxLB593mzRq5wI9SrwbOlYVPpvNlYYNq7igRHTr/ZnJMVXqMP1+QvBb9jalp/9hDf6
         MhrbwYeqr+jBAlW5ej4AfmKxyZ021uKu5dKNBIXRSSYgohEixmFnM20j9prbCLsE8JD9
         d8dA==
X-Gm-Message-State: APf1xPDQ72qK2jUhFqXH22fae7wsNFbrN1ZB2Z3m0IjecKQQXBZxwt/T
        +Gx3xTArisEyl/lo/1ko3w4=
X-Google-Smtp-Source: AH8x227byAh/bKL4cCzjZz45IFSVHjoQFfNircsVuQ52cWpce/F2rW5lA0wNC25p2lXPvAd18b6JrA==
X-Received: by 10.223.159.77 with SMTP id f13mr5182956wrg.196.1518629702543;
        Wed, 14 Feb 2018 09:35:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 30sm11622312wrz.85.2018.02.14.09.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 09:35:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
References: <20180124095357.19645-1-pclouds@gmail.com>
        <20180124095357.19645-4-pclouds@gmail.com>
        <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
        <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
        <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
        <20180206021313.GA26323@sigill.intra.peff.net>
        <CAN0heSofAfuXEUKcfF00ni_a7nAKJYySF_UEnNTL8+nHiBzw-A@mail.gmail.com>
        <CACsJy8BjFex==2UQV6-k4_rTnBijJOzBAOmtNmZopc87U19Jmg@mail.gmail.com>
        <CAN0heSpxcm1a9KN3etWAD5Vc_gkabQmEppa_1P4soZSZOnP8pg@mail.gmail.com>
        <20180213002758.GA9274@duynguyen.dek-tpc.internal>
        <20180214031614.GC25188@sigill.intra.peff.net>
        <CACsJy8B9dRshT2RUhnNLbnwTY0VdVdKP9A_YGxwiqqAyMN_OAg@mail.gmail.com>
Date:   Wed, 14 Feb 2018 09:35:01 -0800
In-Reply-To: <CACsJy8B9dRshT2RUhnNLbnwTY0VdVdKP9A_YGxwiqqAyMN_OAg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 14 Feb 2018 16:07:12 +0700")
Message-ID: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Feb 14, 2018 at 10:16 AM, Jeff King <peff@peff.net> wrote:
>> Hmm. That is not too bad, but somehow it feels funny to me to be
>> polluting each test script with these annotations. And to be driving it
>> from inside the test scripts.
>>
>> It seems like:
>>
>>   make SANITIZE=leak test GIT_SKIP_TESTS="$(cat known-leaky)"
>>
>> would be sufficient.
>
> And all new test files are considered leak-free by default? I like that!

Sounds good ;-)

>
>> And updating the list would just be:
>>
>>   # assume we're using prove, which will keep running after failure,
>>   # and will record the results for us to parse (using "--state=").
>>   # Otherwise use "make -k" and grep in t/test-results.
>>   make SANITIZE=leak test
>>   (cd t && prove --dry --state=failed) |
>>   perl -lne '/^(t[0-9]{4})-.*.sh$/ and print $1' |
>>   sort >known-leaky
>>
>> That would update both now-passing and now-failing tests. Presumably
>> we'd keep it checked in, so "git diff" would show you the changes.

Sounds good, too.
