Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3551F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965019AbeAITb6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:31:58 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:41177 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964998AbeAITb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:31:57 -0500
Received: by mail-qk0-f182.google.com with SMTP id a8so19985967qkb.8
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9WD4hr7HmyRvu1BkymcGbasnemz316ddGDWWzu12qR4=;
        b=iqn4Xc3MCiRmszj6VrSpNFC9WFe5Qn2QzBrnv5SHFxMTaEqO9A4YUOKe0DKqADdty/
         HLj12l9XlOVpfZ5cFJxzc/UL6k23Zs+rpMk5vcYT6BEQKl8i1Dlfv7PUvOis7i2mUkSX
         tJA4WSQh+IonxQsQpsKSCif24dgJyVQDY6JVYWHOS/9RaUQs/er0AWie2wz6BD4yOqhW
         l/WZ24J6nGN3MZfM2AyEZLdW4yhBomiUYUu0Pvxwv2pDULJkHRjvglJW4IpHNpc2V96P
         Vg69/0TYRTlJBZBtdakK3nZL/ZHrSxr8vXITEbHfqS4V+YDEqPQkGKBRKiRhcGB89Z1Z
         J0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9WD4hr7HmyRvu1BkymcGbasnemz316ddGDWWzu12qR4=;
        b=WarNrk0TeKZsvmL+tBsaD+0eljPgzuGhtHhjGsVg0ZGKZxqSvpQOf+zjkzYWzmLTn2
         VwYHMDr2FfzU1B+mrE9utchMubZaBNQunakGkujgQ/3NQDuLEJh7s+AIV1pOj+BRRy4a
         05SgSsEhACoRlIyKY5zlDiPIb+A8iGTJmTCoa9By0yvzlM6N+A+7pSWQC7CXmViPUyrG
         vbPBdto0OxJWG6WnxzEnpozbWtbqbR4+AZLYV5MRSYL8TCxPLC9Yp+s3wUIH9Y+ME3b9
         UiEZNE84tSrVtfSkbC+ceXuioLtMyxcyHcMEAVzRd7ZQQdgpyGkV6HzOusrWLkYjc52s
         hvzg==
X-Gm-Message-State: AKwxytcNiNKBQAXiIytS0dyX2mbkPuSP05MExm5m86icmVyyQQmRFUOe
        lGyBTS1nW2ydxxhmQvmuOq4mOpPzbGCc2Gt9+7vcjBuP
X-Google-Smtp-Source: ACJfBosMhME4n8CW08OkrEQJL/++l7BJ/dhw6KfFwwFWkPlSP8t2TSXiQLAF1C42bIuGKpzCxBk/5HStK7F05mtKhq4=
X-Received: by 10.55.162.150 with SMTP id l144mr12528552qke.336.1515526316649;
 Tue, 09 Jan 2018 11:31:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 9 Jan 2018 11:31:56 -0800 (PST)
In-Reply-To: <f82949ed-5dbd-eab4-d917-8fe675b1c517@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-7-kaartic.sivaraam@gmail.com> <CAGZ79kYPcx39VqWLAxRCQgO16=Yegq6XeCVUmX7shYomF6sz=g@mail.gmail.com>
 <f82949ed-5dbd-eab4-d917-8fe675b1c517@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Jan 2018 11:31:56 -0800
Message-ID: <CAGZ79kbQoLCodgR+JGXf_K1kS2Orjzp3W+7ZQBM0gX9je6d3Rg@mail.gmail.com>
Subject: Re: [PATCH 6/8] Doc/gitsubmodules: improve readability of certain lines
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>  The submodule's `$GIT_DIR/config` file would come into play when running
>>>  `git push --recurse-submodules=check` in the superproject, as this would
>>> @@ -107,13 +108,13 @@ If the submodule is not yet initialized, then the configuration
>>>  inside the submodule does not exist yet, so configuration where to
>>>  obtain the submodule from is configured here for example.
>>>
>
> I caught this in the context while replying. "so configuration where to
> obtain the submodule from is configured here for example." doesn't seem
> to read well. Maybe removing configuration from the sentence will make
> it sound better?
>
>
>>> - * the `.gitmodules` file inside the superproject. Additionally to the
>>> -   required mapping between submodule's name and path, a project usually
>>> + * The `.gitmodules` file inside the superproject. Additionally, if mapping
>>> +   is required between a submodule's name and its path, a project usually
>>
>> This changes meaning, originally it tries to say:
>>
>> * it requires mapping path <-> names.
>
> I get this ...
>
>> * but there can be more.
>
> ... but not this. Did the previous version really try to say this?
> Anyways how does this sound?

Well that was me being very sloppy trying to say that there might be
submodule.<name>.{url, ignored, shallow} settings which just happen to
be there.

>   * The `.gitmodules` file inside the superproject. A project usually
>     uses this file to suggest defaults for the upstream collection
>     of repositories for the mapping that is required between a
>     submodule's name and its path.
>
> I think it conveys the "it requires mapping path <-> names." correctly
> but doesn't convey the "but there can be more." part. I'm not sure how
> to get that into the sentence, correctly.

I did not consider that part the important part, hence my sloppiness.
Sorry for the confusion.

My main point was to say that the mapping is the important part and
must be found in the .gitmodules file, otherwise we do not consider
it a submodule (for whatever "it" is, maybe a gitlink at a path=name).

Stefan
