Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E261F453
	for <e@80x24.org>; Fri,  5 Oct 2018 10:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeJERUo (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 13:20:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40275 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeJERUn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 13:20:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id r83-v6so11124962ljr.7
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WZw7oAlZOkVNv8rCvbYrNr5Zz6qKpd3dW2983IwQqkU=;
        b=Ho3JDeXVAl8lSDB9SDi+cSxyvju+ELkumwTokh+ZJV+cadUDVvr4eZ4T3frGD3fpAj
         NgoiapZS979L4Hi/q0CN/yfwTmLwn1FIEz+9YzicoXeWIBX+uDBlBmskfTX2Q+oGAxgL
         bT/UgoJa2jECsjDSScOAHrjCzvJGvFzD4pnoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZw7oAlZOkVNv8rCvbYrNr5Zz6qKpd3dW2983IwQqkU=;
        b=mQky4PVMMpn5A0XtFYBCMfSBaPLGZhhZac4a7Vk0/lBavw3vLM0JRCv3lTOC7sOvh4
         VZplDqgKzEPva7wOBZ3jw7gYRXsFh6bqdWyxuyM+4m9M3WoENiXq6V7ZCoPGxThinJRm
         uoEmu29xR5jvyTOWcQEgi0TIfJBYr00gzXxQdvbejS+EC4wD0GO7d+t8EMpGW0L3di2U
         8mmJrOylQvDIVaPV73LfbSh7KrNjWgP6+Bezn6xJFzUJkTrUzmOPVWohNs2C0qNreGLI
         53ZOjLvVWVA/wlpsStLvJKwHOTXh42hxYoNZTDMVtOMxC3bwW1pCE732PL8lcIZAHfg3
         j6qA==
X-Gm-Message-State: ABuFfoi5VG4PYFRLngOZ6kMX0k4gZNSlHbMqUBQsTLXPQ/cU9RN319FE
        FmvU4hVdG5d96P/zamqXF3ez7w==
X-Google-Smtp-Source: ACcGV62kGkwZxHRgTj+iOv6/L51pgVwJkouqVRqXl3EBonUPolUMOBXR3FOY7WuVK+QMJAHRyFi6Bw==
X-Received: by 2002:a2e:9247:: with SMTP id v7-v6mr5951381ljg.24.1538734953913;
        Fri, 05 Oct 2018 03:22:33 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o19-v6sm1678430lff.36.2018.10.05.03.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 03:22:33 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] help: redirect to aliased commands for "git cmd
 --help"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181003114242.9858-1-rv@rasmusvillemoes.dk>
 <20181003114242.9858-2-rv@rasmusvillemoes.dk>
 <xmqq8t3czty3.fsf@gitster-ct.c.googlers.com>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <5e79944d-e82f-f4c1-00ec-445121769f42@rasmusvillemoes.dk>
Date:   Fri, 5 Oct 2018 12:22:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq8t3czty3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-05 10:19, Junio C Hamano wrote:
> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
> 
>>
>> I believe that printing the "is aliased to" message also in case (2) has
>> value: Depending on pager setup, or if the user has help.format=web, the
>> message is still present immediately above the prompt when the user
>> quits the pager/returns to the terminal. That serves as an explanation
>> for why one was redirected to "man git-cherry-pick" from "git cp
>> --help", and if cp is actually 'cherry-pick -n', it reminds the user
>> that using cp has some flag implicitly set before firing off the next
>> command.
>>
>> It also provides some useful info in case we end up erroring out, either
>> in the "bad alias string" check, or in the "No manual entry for gitbar"
>> case.
> 
> These two paragraphs were misleading, because they sounded as if you
> were lamenting that you were somehow forbidden from doing so even
> though you believe doing it is the right thing.
> 
> But that is not what is happening.  I think we should update the (2)
> above to mention what you actually do in the code, perhaps like so:

Yes, what I wrote was probably better placed below ---.

>         and hopefully remain visible when help.format=web is used,
>        "git bar --help" errors out, or the manpage of "git bar" is
>        short enough. It may not help if the help shows manpage on

or, as in my case, the pager does not clear the terminal. I even think
that's the default behaviour (due to X in $LESS) - at least, I don't
have any magic in the environment or .gitconfig to achieve this. So it's
not visible while the man page is shown in the pager, but upon exit from
the pager.

> It also is strange to count from (0); if the patchset is rerolled
> again, I'd prefer to see these start counting from (1), in which
> case this item will become (3).

If you prefer, I can send a v4.

Rasmus
