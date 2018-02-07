Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897561F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeBGSNB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:13:01 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:44572 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753859AbeBGSNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:13:00 -0500
Received: by mail-vk0-f44.google.com with SMTP id q62so1126081vkb.11
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 10:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yw7Z+UzsjXAcH3APrNIqJftiOPn2PibhZlGf92pPEGk=;
        b=SHnHgum+PlS8AvVewhoLyLG4fM/tFBt1UP1BHxqMYVPywPZgQ5uQEmPgD5t1oGFjpo
         MD7O0MN0GGCvZ9goJPyTSqKneGyWkL2cGHtGCYoL6BMV1TMT56KimFBRw6YpBded4VY8
         XgitntptGJlN41J5itdn11oV4Cx1PwteIm9qIYwmVg/657KTaR+bwaQyqJv6jrosS+G4
         o9XVF7IBSZHnXU0cxZNkTyviopkhuHQUWAbSKBwt5JOEui14Yn1brXx4aCneCL4WS3Xn
         1B5RWI9cV8cGnh7C9exurU6fEJYIYDCFkVshAPe8/2JldDTEqreuj4NrgzJjv/SGk1Xf
         fvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yw7Z+UzsjXAcH3APrNIqJftiOPn2PibhZlGf92pPEGk=;
        b=YwKPPPkLobD4+AKj+DlJtC6u/fj8JQXvx+ayJa7oC7GMPnD/nFilNbsZ9iYtmJeerY
         3/lUFJf0a9zB7UOBW1yDkFkJvVUIeVeFOkWac0yp8HwrB3eOLMxipyHAwIJKhS3owISw
         MbHA706fF+DoB8FHsl6Unh1WMFtoAPIcEOOPxSB0olZeOsfdMVwJxSWkr75byngMqWFI
         YaE+N016STYT33H1cqDj2EpJJFNlXTTLCKFfcrq6HfDdZV+BmYdjoqLl7eaWkpP7PF1I
         izaVu7ScLDKfj5h6ow78ut8phR2J0+3NZiRtVFzx1Can74XcAIp3njYHuJ8LzI1YZdW7
         MsPw==
X-Gm-Message-State: APf1xPDsVjzT9E3HYTkqJu8bMzr/JiKsQHzi3mhWf89SjVVGyGz9MPys
        hZ8eLLo7YgTkH50fyqrQFsw+OEpEByBJVhmT4YI=
X-Google-Smtp-Source: AH8x224ZwsFi4BnbDt8hnDLHi7obITtjBwR38sEqr5gE9nl53NI/nGUoAWCszcZjI5oeXPNCsSE+KnjLIYcE/o4+Xfw=
X-Received: by 10.31.33.86 with SMTP id h83mr5650933vkh.183.1518027179773;
 Wed, 07 Feb 2018 10:12:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Wed, 7 Feb 2018 10:12:59 -0800 (PST)
In-Reply-To: <CACsJy8CUgmyw6Ug6wQEFaj9Ze45mZfRoE4J16zVv5usT791Kmw@mail.gmail.com>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
 <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
 <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com> <CACsJy8CUgmyw6Ug6wQEFaj9Ze45mZfRoE4J16zVv5usT791Kmw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 7 Feb 2018 10:12:59 -0800
Message-ID: <CABPp-BGuTGf1A_WW_znsKKLD-2xDf+7-X1HxdvXx27oCXx8puA@mail.gmail.com>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 3:08 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Feb 7, 2018 at 7:00 AM, Elijah Newren <newren@gmail.com> wrote:
>> and knew they had been using it, then I might have guessed that "HEAD"
>> meant "not your actual HEAD but the HEAD of the vestige of some other
>> worktree").
>>
>> Does anyone have pointers about what might be doable in terms of
>> providing a more useful error message to allow users to recover?
>
> I noticed this too. I was working on improving this message a bit but
> got side tracked and since I figured this did not happen often
> anymore, this fix got lower priority than others. I'll resume that
> work.

Sweet, that'd be great.  Let me know if I can help.

>> And/or ideas of what steps could cause corruption so I can send out a
>> PSA to help users avoid it?
>
> There is another thing we could do. One bad HEAD should not abort the
> entire operation (at least if it's not the current worktree's HEAD).
> We could still give a warning and move on, or don't warn at all and
> let "git worktree prune" collect it (which I see from your message
> that it also fails to do).
>
> I guess that's two more items on my todo list :)

Cool, if you're taking a look at those, I'll take a look at the other
one mentioned by Peff in this thread -- "make fsck pay attention to
other worktree HEADs"  :-)

> Sorry for all the trouble because of this bug of mine.

Let me apologize if my tone came across too harshly in the report; I
sometimes accidentally do that.  Anyway, bugs happen.  People were
able to get back up and running with "just reclone somewhere else"
pretty quickly, and no one lost any important data here, it was just
jarring or perplexing enough that I felt the need to dig and figure
out an improvement before more reports come in.

Besides, you've made git a lot better.  Thanks for that.
