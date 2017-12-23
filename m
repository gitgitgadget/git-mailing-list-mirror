Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91881F404
	for <e@80x24.org>; Sat, 23 Dec 2017 13:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbdLWNeK (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 08:34:10 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:42778 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdLWNeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 08:34:09 -0500
Received: by mail-wm0-f51.google.com with SMTP id b199so26253800wme.1
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 05:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xo/Q8T53C4AL/wuFOj/GpD4LLjUSsbGQmQeGJp2S358=;
        b=stoNtTXAvkJGICTwt6vp8jRlJAkmGZeIqHCeT3V3oNvn/HinKCGjGzzlVQZxOEp6f2
         zIwSVeNTN6VedkBCs4Y5OT1lmW53BsdOReBWYhCZyR1k4RwP1ZJGTmwleWcxlhENan7z
         LSy47RI7EvX7bjGs7RJetraPsQUXWjb/ckbXsk6ZyUo4hBO8hXWwdnaCogqF0KC69Ky9
         6fi4D0LkxGLbhwybAUR0w8Q0JCly6pW9NDxHqxhyysyczOkfe16MuYZNrmOCzxr/oq1s
         C99jZiqh2uwZHvCaElv7WdQioE2W0ZA6meKIfUmP926yIXkiVF2iC2/lRKcPIyv0wH6A
         hHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xo/Q8T53C4AL/wuFOj/GpD4LLjUSsbGQmQeGJp2S358=;
        b=W4by/cRQsOlNBDnVHW4OXdNezgdSX32mIcgOhj7ryibZGmgO+5+eN3IACfNn08Q7GY
         1RflRhTqN8uiTlTOcyqLwkp3Mw/MXSZoHj3f5WoW5NkBdInroy19AbB/W9A8+4O+uvvW
         gqVmjjLDT1xKv+6Fik4b3XC+ngCVhaGK0+HGdhC5KdC4DMoM4RzWj6CT5UpnHy98+gMO
         PuNDCIRel2aRCdDsb7jJAfGf0ulRfZCytRIn48GsTV66Aa+Tf1Ka4wfwiJcsbaS1Hx22
         0t16GWlUNwa7q/oBncWP7vGSWSQfOc0CuqLhSpHW6q55yNQxqPa9/WvLBid9fLxsnz0R
         IqiQ==
X-Gm-Message-State: AKGB3mJZy4GRR91/kOAjFqi+j+P71jcJ3J3HN3RTsEuDkukUJ60kNuQ2
        3bENhm001wKVL6MJ9niiSgQRL7cTie9P0zAztyI=
X-Google-Smtp-Source: ACJfBotSqeYYqnWJLPuisuJFXEXYN3D4pkyAAUmlSQTIJbUE0orX9VDLhJ8kToPSyMfDHSe4UTr8np6FTGU2ZqENiVw=
X-Received: by 10.28.196.194 with SMTP id u185mr16220187wmf.133.1514036048833;
 Sat, 23 Dec 2017 05:34:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.151.203 with HTTP; Sat, 23 Dec 2017 05:33:48 -0800 (PST)
In-Reply-To: <xmqqh8u1efh5.fsf@gitster.mtv.corp.google.com>
References: <CAPkN8x+MELCnttE+xptKzYXsYPWqbiE59LABrwNBhFroayc+wQ@mail.gmail.com>
 <ec4be1c2-a0cc-cec8-a566-06c11c8abe06@gmail.com> <xmqqh8u1efh5.fsf@gitster.mtv.corp.google.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Sat, 23 Dec 2017 16:33:48 +0300
Message-ID: <CAPkN8x+tFDSum1jqgm6Q+Z2YS9BdGttyruc4rAywqinzbP033g@mail.gmail.com>
Subject: Re: Unify annotated and non-annotated tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>
>> If you would like to mimic output of "git show-ref", repeating
>> commits for each tag pointing to it and showing full tag name as
>> well, you could do something like this, for example:
>>
>>       for tag in $(git for-each-ref --format="%(refname)" refs/tags)
>>       do
>>               printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>>       done
>>
>>
>> Hope that helps a bit.
>
> If you use for-each-ref's --format option, you could do something
> like (pardon a long line):
>
> git for-each-ref --format='%(if)%(*objectname)%(then)%(*objectname)%(else)%(objectname)%(end) %(refname)' refs/tags
>
> without any loop, I would think.

This doesn't work with git 1.9.1
https://github.com/rtfd/readthedocs.org/pull/3441#issuecomment-353567756
When it was added? I searched through GitHub and docs, but can't find any
historical records.

-- 
anatoly t.
