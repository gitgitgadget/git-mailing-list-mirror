Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1A71F51C
	for <e@80x24.org>; Fri, 18 May 2018 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeERROd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 13:14:33 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:33123 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeERROd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 13:14:33 -0400
Received: by mail-pl0-f43.google.com with SMTP id n10-v6so4948311plp.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jddPsW3qb26kghTQwHEl/INhO9YxGeoHE2ZxDm1aeho=;
        b=u4ZVYL6o6l7SxyKbKqbllLiMZIag9vACzTrFDRjPgRWNP1MD9F7RrUuGwlG2iIHlCi
         EuRKsYB//Zf6GQd39k+dWS2sEMLPh8U5WazmJO5oJ0qkE8UdPSpbqjj/+vJVgAkq6bRC
         qTgKBp1k332XPI1XIyIPupQTRt0hHscPhDIwxLYE5zBxBkDSYec4HSGWIwECmwxPJSdG
         B14JSv8Db6f2O8H0ierO8r2ENabru+lkKmi13zR//Q9BOJh6rN5MNAXwzwld8oJ6N6TP
         F1G4d+07Jm3Q2haHvdmLjkG+P6UclDhbvChgJL8kM8hdSGd9HW92Fx0jnCo3yiTDDoOx
         AYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jddPsW3qb26kghTQwHEl/INhO9YxGeoHE2ZxDm1aeho=;
        b=dhi+euCO3vsvBGyuzNwgnAYqLm/y8wqAyQClieGAACmmHZMxSBJ/QRWLn1OyCyPzg3
         8zQRzcrT2BDs8MQytsIhrm4Nt7BIzRPJf92Gr3WLXOaUFUR0zIz7OG1/deZkqU+HjCPX
         0nlkYUR9e6qaPTvNvVQfCLfEXPwPnb+W/023+90eyavrUsz5CtOIu1+ol+fLcb56oCmw
         ezJIAHHa3rg9xz279+/x04mXbY6AlZT+8SBWr6li3p8uWDvzj3bcFtBOddYr7dAUq+nT
         J9wmGPjuzCQFQbd7thLl53kmDFivH/sv5auZFuE4z7n9Ia75x96ZmX1i9ZnZ60M01yXU
         /Fgg==
X-Gm-Message-State: ALKqPwe4EZqlwOjynEj3ggJy7b6sK4mRUaUJT+FNGh+mNRHqWzFfTVqW
        JjihBP8JMJVgYr3hnDWZSijt2ZHGs1l9QWe2qfXz/yoYvKo=
X-Google-Smtp-Source: AB8JxZpToNLAN8i4BcAYHC/5o8UVtXzDzEzlmOourkEfEf/zRmJYlAIUC13xYFHpGc6rxSEMlkAtA11CPJnBdPiZuAo=
X-Received: by 2002:a17:902:b94a:: with SMTP id h10-v6mr10575630pls.321.1526663672476;
 Fri, 18 May 2018 10:14:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 18 May 2018 10:14:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805181141030.10462@localhost.localdomain>
References: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain>
 <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com>
 <alpine.LFD.2.21.1805180648020.10270@localhost.localdomain>
 <CAN0heSpVKd=-Dpdk09LVtTd0vC2dLUwg0=hbxhKskM3RencsYA@mail.gmail.com>
 <96486abe-cf13-ef10-7513-2d6c20a9dc1e@gmx.de> <alpine.LFD.2.21.1805181141030.10462@localhost.localdomain>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 18 May 2018 19:14:31 +0200
Message-ID: <CAN0heSq6YLarECVtHiPFNyUMNb-XwLQqTULpB_pSW+JZsCMw0Q@mail.gmail.com>
Subject: Re: error(?) in "man git-stash" regarding "--keep-index"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Sybille Peters <sypets@gmx.de>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 May 2018 at 17:43, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Fri, 18 May 2018, Sybille Peters wrote:
>
>> My 2c on this:
>>
>> 1) "If the --keep-index option is used, all changes already added to
>>    the index are left intact" (manpage git stash)
>>
>> That appears to be correct and clear
>
>   yup, that's not the issue.
>
>> 2) "$ git stash push --keep-index # save *all other* changes to the
>>    stash"  (manpage git stash)
>>
>> That is either not correct or misleading. "All other" implies in my
>> opinion all changes except the ones that were already added. *"All
>> changes including already staged changes"* might be a better choice.

Thank you Sybille for formulating these two points.

>   yup, that is *exactly* the point i was trying to make.

Ah, this is about saving to the stash vs stashing away. The latter is
what `git stash` is all about -- stashing changes *away*. At least
according to my mental model and the top of the man-page.

But testing this -- not only from the point of view of the example, by
pushing and popping, but by actually investigating what is in the stash
-- finally makes me see what you mean. Yes, the whole lot gets saved to
the stash.

So there is a difference between what gets saved to the stash and what
gets removed from the working directory. The comment in the example
places itself somewhere in the middle by using the word "save" but
really talking about what gets dropped from the working tree.

The proposed wording does not really address that. It could be taken to
mean "all changes are saved to the stash; none are removed from the
working tree".

The work flow in the example is about temporarily stashing a few changes
(changes B) to test a couple of others (changes A). Whether the stash
entry contains changes A or not is practically irrelevant to the use
case. At pop-time, auto-merging will do the correct thing.

So how about "All changes are saved to the stash. Those that have been
added to the index are left intact in the working tree, all others are
removed from the working tree."? That's quite a lot of text. Maybe
"save all changes to the stash, make the working tree match the index"?

Or more to the point: "make the working directory match the index" or
"keep only what is in the index"?

Martin
