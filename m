Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FAFC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E52610A5
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhFINaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:30:55 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:42937 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhFINay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:30:54 -0400
Received: by mail-qt1-f178.google.com with SMTP id v6so9035983qta.9
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9YSxyAqNQh375wKX4xXNGAao7sxanjmSpa3kAA35TPE=;
        b=qU2k5jwCiKXCS36mMxSeffRzVgs0gCpwwEF1//2diKgptgsma7TczboBnMBuAXvqwC
         /lRvZ6UhkWKJL+kQm4ny+KrxJ8y2SccY8dOqs5PoaPNg7Xgmqfy1WcePkR51cJzdOIie
         PtUb65IDUJhg2pevXT7tDoEi2J33Od7ADCcmWKzCAQoHrWnJ2rcnfQpkO/IBkDcDV6lR
         XAp4dtew1i0hqFtspdThfGS/iDlhtRv6w4p5F+/hTP2yhwsnoqzxmGUEDW23XwddLvFm
         VggngK1DMfg0IcnYG0g7cp/QUZjWVQsZOhZOFQDQ0n+CG47/AY/fFm+1xVuN8vPJZ0s+
         I3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9YSxyAqNQh375wKX4xXNGAao7sxanjmSpa3kAA35TPE=;
        b=aVJ4jB5y7totEO7q093moVrty28iKtgyI9gMMOng5hJTxhm8QCUx4nBP+7ucA9LsCn
         7crZQNFOe+lSS34VtxVzq69G7GkqKWSF1bQAAImK4DPhKY8kh2dFURqWcIhLlPlNlMg2
         GeX+y8dDvQ2XIanWNV2sznbE2xt9XiwpFJpjoaN9PGDecQ0lAVH4lcT/1gQf1pED4PiK
         barfiU9D38WN/UQhpnL7Kd4vmMytNbfD+3KT5bI5HvLVqXovFhNzxxhyUjYfaIk2vx9f
         rqg6hMprp83SWBZ5t2epAiTbKbW8/6qXtiI0sYF/QH9mjpdIYU2BVtTRQDCtJ5WI2WGu
         NQzQ==
X-Gm-Message-State: AOAM533a3eOdQmRhN03pYJz4Kr1nw2IbYXaGcj7NXscuMRhXuNu0UwTH
        tPwf9Tr1efOrmoaqF2fdsY4=
X-Google-Smtp-Source: ABdhPJx4RODUArrphPNrkWkfWQHhJQCgfGwRN16k839LtMoMZT8Dqk+Y18HQJmorciI1piU1Zvppbg==
X-Received: by 2002:ac8:7412:: with SMTP id p18mr16077676qtq.273.1623245268233;
        Wed, 09 Jun 2021 06:27:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d80d:ae0e:3efe:ebc2? ([2600:1700:e72:80a0:d80d:ae0e:3efe:ebc2])
        by smtp.gmail.com with ESMTPSA id p21sm4604612qtq.92.2021.06.09.06.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:27:47 -0700 (PDT)
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <YL+rXqDMIPvA2a3+@google.com> <xmqqa6nzlk8y.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7419df4-38f3-70aa-ccae-12b42a80e422@gmail.com>
Date:   Wed, 9 Jun 2021 09:27:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6nzlk8y.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2021 12:44 AM, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
>> On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget wrote:
...
>>> +
>>> + When referring to an anonymous user, use singular "they/them" pronouns
>>> + as opposed to choosing between "he/him" and "she/her". Do not use more
>>> + complicated constructs such as "he or she" or "s/he". This recommendation
>>> + also applies to code comments and commit messages.
> 
> I am not sure if this "here is the rule and you will follow it" is
> helpful without hinting what the rule is trying to achieve.  It is
> more so that the four-bullet-point list in the proposed log message
> that says when not to blindly apply the singular they rule will not
> be seen by intended readers---we who are reviewing this change in
> the patch form may understand and embrace it, but the readers have
> less than we have to go with.

I went to far trying to be brief in CodingGuidelines in favor of a
long commit message (that can be blamed). But you're right. "Start
with why" is a good strategy.
 
> Perhaps start the whole paragraph a bit differently, like this?
> 
>     Refer to an anonymous user in a gender neutral way.  Use
>     singular "they/them" pronouns as opposed to ...
> 
> The added single phase will be a sufficient clue to readers that
> this is about inclusion, and will tell readers that singular they is
> not a hard and fast rule but one of the suggested ways to achieve
> that goal.  To be even clearer, we may probably want to add "One way
> to do so is to" before the second sentence.

That's a good idea.

The other thing I have added is to recommend changing the sentence
to use different nouns so that singular "you" or plural "they" are
appropriate.

Thanks,
-Stolee
