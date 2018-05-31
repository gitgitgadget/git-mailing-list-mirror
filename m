Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1DC1F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeEaFxQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:53:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44980 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753790AbeEaFxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:53:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id h12-v6so274013pfk.11
        for <git@vger.kernel.org>; Wed, 30 May 2018 22:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iu7cbt9IOnv9bwXBUzP2cZvuQ11cns/x0N6w+aN/KUs=;
        b=EQNXHlAJCs1pybHNNO7YC+VzdI7T6VbL3PPUZAwlJhoZ+2KhKj856QL70qoP1fnPaZ
         IPSeoIXeN2UKAQ5Va3f4z8IVWAVI2DhSoRaEjTHdKQZBGKoZ2B4DH+LVhVwDH2pm9Y5x
         zRD9gYTjqUA6wTrdKq6zY01zbGQbMrI8oCqHTI5ODV0FcvcjYCD68QWiBDU1eZ1tnYAO
         O1lky9Eev4hX9+1LjgbJ4/MWswTQMP+krc73gss1XNr+kpVZ7O3ghde7bdnGJ1IOyr6W
         jI6ZnRzegwaXpJQ9fTvHVRqhCJGASz6e6fPIUxoACUGFo6IRsxGMv1vC+88jeeuJLzlS
         UL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iu7cbt9IOnv9bwXBUzP2cZvuQ11cns/x0N6w+aN/KUs=;
        b=I40+ovRJWDy7XpYY3mCikiCWEsa4XiN9NefBYRHLZuZ4RZQG2vs2ZsZtPqVX83t9mR
         Kr1FhKdg2qDrUiphuQ8oIRQe+luq61b4hSPxbxtfo3m27WuulIyzVBmu2Qa4m9RnrJlB
         KXgeHF8MrqBAjuk4KcxfBSW1vkyEw1W0qfzT/I2jS09r0WhQjVotjtsAmujaK1W18rd7
         K2x1zMSTycmgTMJuVRbC0bpaZ+3H+scmePN2JSK2u+Kr2lKXGUdvAk2ejAO6ef+ZLMPp
         ZA9E/v0VJLOjw57Sm8TGXoqpceDFe/yF5AByE2CZvlkfVbxavRwYAfFyh4f8vZN+08eW
         P0Nw==
X-Gm-Message-State: ALKqPwdqKDx2tni/Ocv+xG+NHREARa2dCS1FPPNhAmkTRxyzjhxMakWU
        t5rlosgGDBgBdK15s/6LPKmd8Cou
X-Google-Smtp-Source: ADUXVKLx713R1eeLFfr127vKXb8JFqi2bi1ATdp0EPkmn1r/5Cg79rpRV5zZ/FJ+1EdOoo9i1uaghw==
X-Received: by 2002:a63:93:: with SMTP id 141-v6mr4524468pga.322.1527745994990;
        Wed, 30 May 2018 22:53:14 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.210.250])
        by smtp.gmail.com with ESMTPSA id e68-v6sm1646026pfl.65.2018.05.30.22.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 22:53:13 -0700 (PDT)
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
 <ae75f388-edbc-8f00-e98c-825027a58c1c@gmail.com>
 <20180529211523.GA7964@sigill.intra.peff.net>
 <xmqqzi0hety4.fsf@gitster-ct.c.googlers.com>
From:   "Kaartic.Sivaraam" <kaartic.sivaraam@gmail.com>
Message-ID: <2d9c365e-4a04-6a25-b942-c7d1db960002@gmail.com>
Date:   Thu, 31 May 2018 11:22:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi0hety4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 30 May 2018 08:22 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Right, what I meant by "gentler" is that we continue to perform the same
>> behavior as the old version, alongside the warning. It's arguable here
>> because running "git branch -l" has _always_ been wrong. It's just wrong
>> in a way that happens to do what the user wants. ;)
>> ...
>>> Anyways, if you think it mustn't turn into an error now and only in the
>>> next stage, a suggestion follows in another thread.
>>
>> I don't think "mustn't", but I have a slight preference for what I
>> posted, as I think it is a little friendlier during the transition (at
>> the risk of somebody missing the warning, but then step 2 turns it into
>> a hard error anyway, so they'll certainly find out then).
> 
> Well, we could keep treating '-l' given in contexts where we have
> silently ignored the option and did "list" instead as before during
> the transition, until the very end where it becomes an explicit
> "list" command, no?  Then there is no need to even warn against '-l'
> that is ignored because we are listing in the earliest step.  The
> only usage that requires a warning then becomes '-l' used for its
> original meaning to create a reflog, right?  That sounds gentler to
> me.
> 

That sounds interesting. I guess that would avoid the confusion I was 
speaking of from the beginning of this thread as the warning message 
would not be shown at all for "git branch -l". Of course, it would then 
confuse people who discover that "git branch -l" lists and "git branch 
-l $prefix" creates a branch with name "$prefix" (if it's valid) instead 
of listing branch names with prefix "$prefix". So, it might be worth 
considering.

BTW, I suspect this would make the deprecation of "-l" a little unsual 
as the no. of people who see the deprecation warning would be less as 
the warning is shown only for "git branch -l $branch" and I also suspect 
the no. of users of that command would be very less as previously 
pointed by someone elsewhere.

--
Sivaraam
