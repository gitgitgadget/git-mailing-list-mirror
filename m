Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7721F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbeACVQX (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:16:23 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:41292 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeACVQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:16:22 -0500
Received: by mail-qk0-f173.google.com with SMTP id a8so3223896qkb.8
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 13:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3p5QeiN7oSjuKY4C2phkBgenVQxS1okYeqUsY56PhPw=;
        b=BqXIm6ky8ctFeRgDOJBz47wNHVTQEvpDNA3tumxamD7f+1+kb1BZAvro7Q36zKREyB
         7EYodHyONvi5TE07K3kIaelICx0yMIyGvIfrJeU4ZtynytpAxVuo64A1vL/xA3VafiaF
         6KGy1yqO6fWUl5t2w/37pt3ri44I/IQZrAHIY8p6pVi/3AgTyCP/78GiXhkZqq18W0R0
         qYucmlFuzlui3zalOvLGcGp/JCGiuvrnPtankSmcmKDLMi5x3K3mB1K4bNmMrw8x6e3s
         5ljd9hI90jBkVRGWOEbYrZvAiInIt5+rIEI8zXWheTXOa9nz6ze8PLfjirw3p4jLcStR
         ZC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3p5QeiN7oSjuKY4C2phkBgenVQxS1okYeqUsY56PhPw=;
        b=lZzxUQEATo39JY20rprBgamrKjKACoTiX+KNMfeR1gGgiPKEn4Q9esiqOyoD1dNa5L
         XOQRbL3kkUT5nn01N9lbzvRh2g/S6xhneKgtryfuGwfUI9sZA9TCKYz9j242A70duGM8
         m3uIqdi7Foa/tXwLdhPfzfb7wBGeQMLf4KPk8O8sWAk21kl6AtBZl579Uia2faAI89g9
         hbabm16UC1UXnbjtKxFLtyGKj/3iK5oCVFN8XwSBSdUHThXxpghxaeN7EYcWSX8XWNXd
         mNjGSVVM/IOpU6VvjfVSxH5ZRhwc925xE9VE88m+7YXjnn5tY9ZHx9NaDYzQo7x6g8Kj
         vJNA==
X-Gm-Message-State: AKGB3mLifJXiRISqHIMCHoktkKeu79dov8ri3UfKteCcori17OKViCv0
        wZdKGUv8bW8BBxGZURLRp7e50UpJJRZ4YjBu1KhP5w==
X-Google-Smtp-Source: ACJfBosLQOfhV+pPH21DN2XIYvXvlTDP6RIEbRO21fog7BiRhlDtdjbBGXfHVSoSJEIkA03+ST6eZuhY7Ez/IWmGNiE=
X-Received: by 10.55.107.129 with SMTP id g123mr3554089qkc.353.1515014181139;
 Wed, 03 Jan 2018 13:16:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 3 Jan 2018 13:16:20 -0800 (PST)
In-Reply-To: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
References: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com> <20180103011226.160185-1-sbeller@google.com>
 <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Jan 2018 13:16:20 -0800
Message-ID: <CAGZ79kbC5tsL8R-tUBxHoZzxYiqiWwYS61F7cLfTZeb0Wu1LGA@mail.gmail.com>
Subject: Re: [PATCHv3 0/5] Fix --recurse-submodules for submodule worktree changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 3, 2018 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Thanks Junio for review of this series!
>> The only change in this version of the series is
>>
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -2140,7 +2140,7 @@ int oneway_merge(const struct cache_entry * const *src,
>>                                 update |= CE_UPDATE;
>>                 }
>>                 if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
>> -                   !verify_uptodate(old, o))
>> +                   o->update && !verify_uptodate(old, o))
>>                         update |= CE_UPDATE;
>>                 add_entry(o, old, update, 0);
>>
>
> Sounds OK.
>
> I wonder why o->update is not at the very beginning of the &&-chain,
> though.  After all, the one above this addition begins with o->reset
> && o->update *not* because of the performance concern, but primarily
> due to logic flow.  I.e. "if we are resetting and updating the
> working tree, then..." comes first before saying "we may need to
> flip CE_UPDATE bit in update variable if the file in the working
> tree is not up to date and it is within a narrow checkout area".

It shows that I work too much with submodules. ;)
"If we have a submodule and ..." seemed to be the important
part when writing the patch.

> Of course, because verify_uptodate() is rather expensive, checking
> o->update before that makes sense from micro-optimization's point of
> view, too.

I would think S_ISGITLINK, should_update_submodules as well
as o->update are all on the same order of magnitude of costs
(some couple number of operations)  when
compared to verify_uptodate (spawning processes),
so as long as verify_uptodate goes last we'd be fine.

>
> So after thinking aloud like the above, I am reasonably sure that
> you want to check o->update as the very first thing in this new if
> statement.

Thanks for double checking and thinking about the code base with
a less submodule centric point of view.

Mind to squash it locally or want me to resend?
For a resend I'll wait a couple of days to see if there are more
comments needing to be addressed.


>
>> v2:
>> I dropped the patch to `same()` as I realized we only need to fix the
>> oneway_merge function, the others (two, three way merge) are fine as
>> they have the checks already in place.
>
> This is a bit flawed argument, no?  Checking working tree paths
> unconditionally in same(), which does not even know if we are
> touching the working tree paths, is broken.  Unless "they have the
> checks already in place" refers to checks that bypasses calls to
> same() when we are not touching working tree paths, that is, but
> obviously that is not what is going on.
>
> Will queue.  Thanks for working on this.
>
>
