Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D04A1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbeGTQ6N (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 12:58:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40297 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeGTQ6N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 12:58:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so11797743wrn.7
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=w2aEl/2J7vm7WxqSJRrij1jryul7FLUAcn86l/YWjy4=;
        b=plZK2DIxXFSDKTgwXniduya7WCiukCyaDA0DPrl/ck2ynkUfEWdJ38eZqrmuFEz3Cq
         hfnFPU9PkYGJAVFJ9WarcyYJDeqZEaE3O7a+h/nZQ+gyMKqr+mthkA1MmyXJ7q3qUa8Q
         IEhRdBwNQVFb9gLtTKx4jE0ACoiMPOKdePSHeeN2Wlqlp6N61LMvqrVCdMqaatvh3I9k
         iss9wCB1hj2OA4bdLc0rE1KAU6/yAfVgXyaWFp57tfihfhWS72q3BBacCuqDR0HH2sWK
         UUcx07dqNH7PkW56Z6JDwvhYaaX+TMw/rhTo+llixxONDh1Z0NbaI7mEZKTlifB5cS3d
         psGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=w2aEl/2J7vm7WxqSJRrij1jryul7FLUAcn86l/YWjy4=;
        b=WPj9HWHAfMnTvADRiFndnrk9IM9/xtcddlUAAdbR3yz4UR5teNj+hID4y5PsABOTvY
         dsdtIO9339xfAtFP29Dv1dPtwtHlRPQS/adB6fFZSl0vTkkNu5Xa25ntNqkOX69nKHpg
         V1JyHQW/+XEFPEk6f2tvwm5j7GR0lnr4x7mdGxXqK2lQwP457pDihwUB4KjD+MRig9Xu
         IC8nCNoowPkNpH0z79Uu1zuPov0Wf24h3kLmVJQYlUjuyJ9f63QAjYKM1C/AZ1/Tgp1m
         ZSvp2F9ErVMvGFB4IJ/fm0dC0O1gNhjUzkL19aS/lmBq1p8LfolSqerf2uXNN/pxwuF2
         3xUQ==
X-Gm-Message-State: AOUpUlHh8aT/OFijpOh7mD99MeMBuAIhjLN1Sd6U4vrZVk485IgssHLU
        vkrC6hqtWYH3q5HfiQFqvq2gxCZH
X-Google-Smtp-Source: AAOMgpedJhLMevsBrKd9JR6XF+Ldr7VSJVrNnHfP0mRWNS4sd3teCJ5nQj8KJliRlgNldjalRvAQVA==
X-Received: by 2002:adf:e24d:: with SMTP id n13-v6mr1953766wri.205.1532102955391;
        Fri, 20 Jul 2018 09:09:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 64-v6sm2708412wrj.50.2018.07.20.09.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:09:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, "avarab\@gmail.com" <avarab@gmail.com>
Subject: Re: ds/multi-pack-index (was Re: What's cooking in git.git (Jul 2018, #02; Wed, 18))
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
        <c1a697ed-a060-1901-073f-7c8d5d5d0f10@gmail.com>
Date:   Fri, 20 Jul 2018 09:09:10 -0700
In-Reply-To: <c1a697ed-a060-1901-073f-7c8d5d5d0f10@gmail.com> (Derrick
        Stolee's message of "Fri, 20 Jul 2018 09:42:13 -0400")
Message-ID: <xmqqzhylc2jd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>   What's the doneness of this one?  I vaguely recall that there was
>>   an objection against the concept as a whole (i.e. there is a way
>>   with less damage to gain the same object-abbrev performance); has
>>   it (and if anything else, they) been resolved in satisfactory
>>   fashion?
>
> I believe you're talking about Ævar's patch series [1] on
> unconditional abbreviation lengths.

Yes, this is a total tangent, but what happened to that one?  I did
not queue because I was led to expect v2 to follow soonish [*1*].

> Lookup speeds improve in a multi-pack environment.

True.  I recall that years ago there was a discussion, but nobody
came up with patches, to do the consolidated .idx for exactly that
reason (not the "abbrev" reason).

> That's the best I can do to sell the feature as it stands now (plus
> the 'fsck' integration that would follow after this series is
> accepted).

Heh, 'fsck' intergration is not a 'feature' to sell anything, I
would think.  Nobody wants to run fsck for the sake of running
it---it is just having one extra file that must not go corrupt
_requires_ one to have a way to check its integrity and fsck is the
logical place to do so X-<.

In any case, we've had this for about a week in 'pu' after 4
iterations, and review comments seem to have quieted down [*2*], so
let's consider merging it down to 'next'.  I think at least I need
to "commit --amend" (or something like that) 16/23.


[Footnotes]

*1* <87a7s4471y.fsf@evledraar.gmail.com>

*2* That does not indicate either of these two:

    - nobody is interested in the topic
    - the topic is now without any flaw

    It only means that keeping it in 'pu' as a dormant topic would
    not do anybody any good.
