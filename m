Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEAC1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 23:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeJOGji (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 02:39:38 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36481 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOGji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 02:39:38 -0400
Received: by mail-wm1-f49.google.com with SMTP id a8-v6so17683520wmf.1
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lBKsx9BWmY4y79V61udr6IHq4x5YUX70f54XXhWM51w=;
        b=Un/g0saurZnEBcn8ZQxrGgfY+MJ0TjF6H7NJIGyjMGmbGqzdd6IY/mDwFL9BqtFBGf
         a9uHMPtWm2HESxdncSr5w/LvMmAVE+C/ICEuPHxwwCtaI7yRWysUBNoe4DphMrFaIlsS
         zy1mLJpUVD/UjfUh+Q125LklOvMaKT5sDXRU4FTh1siyFFRjEeAM1vsq0bWMC30PSddb
         aZHFn1+bInNAR2u3yZEN48txrQ7TlPn3nY0kT+7iJ7nj9SYVCGpUWnstxwgB22WDYEi+
         G8gjpTnjqwIxp4iKLu+AEIvX+ayxSlEoz1dDZVuV7P0DMco9qZDXK64ERQhlaDKzW2po
         zlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lBKsx9BWmY4y79V61udr6IHq4x5YUX70f54XXhWM51w=;
        b=D7Iz8QaIH/bfhZODPBbovavqnVqFfItnWHneaHpkvnkJzHDiofT1jJEvB0PHmeTzYL
         octo7NNb/8sxAQyfTBLEaDFgF/OLW+fETiYaV+CbRyd15dFTFAxQwzTMS3fkHjnazQny
         Bj46y3GK3tYUDuqbVLMrLft/7B1+HB1ERCRC3/gwM+/KXnFnMq+CA90fn5CKnnIgDs/I
         xZF99UVmvJgntkAr30ZEX7/DlMeQ4ko9ZxjMZsADSJw5xBR6QuEpLpawAACRgrmXq7AS
         j4MwdilI1Ig1rdoTFgCX4OfVYesShkF03ZGZC2L7X0jrDXNSIYcluo6xy2x9OZ5cKnhx
         wWsg==
X-Gm-Message-State: ABuFfohe8kKEC0LlE6gIeF6IpGJ6gABXZ+A97pXuQ6pr5mA33m8lgbTc
        Lp4DfWw881WKLXDtLCgCnAc=
X-Google-Smtp-Source: ACcGV61hbz7s1uvVliLJhfY1TdIWm3blmTAg3tlGHKgbrGIMjWM9iRJTvNJtjm273DTKr+Rn0M8Wjw==
X-Received: by 2002:a1c:8d83:: with SMTP id p125-v6mr11652513wmd.61.1539557822956;
        Sun, 14 Oct 2018 15:57:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o81-v6sm5929913wmo.38.2018.10.14.15.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 15:57:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        dana@dana.is, Git Mailing List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
        <87bm80eo6h.fsf@evledraar.gmail.com>
        <CACsJy8DVSu2Sh34UG4P9aqqEMsY5zOGc61tEizo=0sG4BoSgkw@mail.gmail.com>
Date:   Mon, 15 Oct 2018 07:56:59 +0900
In-Reply-To: <CACsJy8DVSu2Sh34UG4P9aqqEMsY5zOGc61tEizo=0sG4BoSgkw@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 14 Oct 2018 14:15:31 +0200")
Message-ID: <xmqqk1mk87d0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Our matching function comes from rsync originally, whose manpage says:
>>
>>     use ’**’ to match anything, including slashes.
>>
>> I believe this is accurate as far as the implementation goes.
>
> No. "**" semantics is not the same as from rsync. The three cases
> "**/", "/**/" and "/**" were requested by Junio if I remember
> correctly. You can search the mail archive for more information.

Perhaps spelling the rules out would be more benefitial for the
purpose of this thread?  I do not recall what I requested, but let
me throw out my guesses (i.e. what I would have wished if I were
making a request to implement something) to keep the thread alive,
you can correct me, and people can take it from there to update the
docs ;-)

    A double-asterisk, both of whose ends are adjacent to a
    directory boundary (i.e. the beginning of the pattern, the end
    of the pattern or a slash) macthes 0 or more levels of
    directories.  e.g. **/a/b would match a/b, x/a/b, x/y/a/b, but
    not z-a/b.  a/**/b would match a/b, a/x/b, but not a/z-b or
    a-z-b.

What a double-asterisk that does not sit on a directory boundary,
e.g. "a**b", "a**/b", "a/**b", or "**a/b", matches, as far as I am
concerned, is undefined, meaning that (1) I do not care all that
much what the code actually do when a pattern like that is given as
long as it does not segfault, and (2) I do not think I would mind
changing the behaviour as a "bugfix", if their current behaviour
does not make sense and we can come up with a saner alternative.

But the documentation probably should describe what these currently
match as the starting point.

Thanks.
