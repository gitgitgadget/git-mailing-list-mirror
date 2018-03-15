Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254AD1FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 08:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeCOIjk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 04:39:40 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54886 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCOIjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 04:39:33 -0400
Received: by mail-wm0-f47.google.com with SMTP id h76so8840079wme.4
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JftP5I/tCfvqs+VLns+BAQQxkoQUZIfpR4keoFzFvc0=;
        b=EpD12MFlHL/gECx4bPJckp6RC8pgE+BM89oQqwoYGRsBAwP9MYUPxwp/AiohA5u+VH
         +XVGJPApxwXFvzCR0YWm4CJOJsh020YGUP2vOwyeEF+X95bueyuL0zvHzGKiVEhdUYwh
         fW7d4ef1Hwsgrr9XN/iIJIZ/aEGWOwWbDB9687GNMqDymZu4nnl1Ms1LukSGaf8EY8WA
         +JOnspylbhdK7N97ZJmH5Vf7K2fB5KeLdCMosL3zx52ZxgDO4I473GEMiwODKtGztP0o
         Kvmr9c1hTTD7FhjCn5VXsEegT3CggGpVPT4XXrqXStELPpiTKF4icwHsAlH7KgWd6r5B
         Fkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JftP5I/tCfvqs+VLns+BAQQxkoQUZIfpR4keoFzFvc0=;
        b=SXNyn2esF4hVS3+bOdv6WlTj3PlH6uOGKbKTHbuTxcNpd2j/qwIobssYmpyhG3xZe3
         9fPd8J9uM9AvCo459U1v0sauEVkaIUf0bi7sN2YLqzl4XiGZ/LEmQl+7TPYY2I+mR1A8
         fdcAo0kzLRGiRAx/qE1lRZx/nVQBN9/EVvk1b8PBuOBnK2LWAJiIQYYbglRWl2Z9QXlG
         lyQokGC2q2mq2xZnGkgeEDII/KD6fP9W/DV5qs8HulaYx1/z+5LJcleWqunzaWqGo44/
         1FNSNJBpqQAM7gzXIRk1mt1qodYhpMI/qVD+MrSEDTpglBXsNBh9SkW7c6Od1NOMHRNh
         TwyA==
X-Gm-Message-State: AElRT7GjZxGBBvbpsm8P87mie8L2Kh2F4ChEkF1G+Nt73bdNHW8pRLkH
        DKrjATavSHA3q/okPIKh/AM=
X-Google-Smtp-Source: AG47ELuiwmplviK3itrjp8c+zIBKfBwzCin4zLkUXuF+6OxRrSh6Onqa2GQPloXyHZ+5rmsJA3UumQ==
X-Received: by 10.28.93.78 with SMTP id r75mr3641779wmb.110.1521103172312;
        Thu, 15 Mar 2018 01:39:32 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h20sm5218170wrf.65.2018.03.15.01.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 01:39:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michal Novotny <clime@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: allow "~" to be present in a tag name
References: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com> <873714qr7i.fsf@evledraar.gmail.com> <CANT8FXTT=5sGp9Wn4h5t=k4TiiADQrf--hDv5EmCx=KoGHgwXg@mail.gmail.com> <87zi3cp9rp.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <87zi3cp9rp.fsf@evledraar.gmail.com>
Date:   Thu, 15 Mar 2018 09:39:28 +0100
Message-ID: <87po45enr3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 13 2018, Ævar Arnfjörð Bjarmason jotted:

> On Tue, Mar 13 2018, Michal Novotny jotted:
>
>> On Tue, Mar 13, 2018 at 10:07 AM, Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> On Tue, Mar 13 2018, Michal Novotny jotted:
>>>
>>>> Hello,
>>>>
>>>> currently, if I try to create a tag that has tilde "~"  in name, an
>>>> error is raised. E.g.
>>>>
>>>> $ git tag rpkg-util-1.4~rc1
>>>> fatal: 'rpkg-util-1.4~rc1' is not a valid tag name.
>>>>
>>>> Now, actually it would be very cool if tilde was allowed in a tag name
>>>> because we would like to use it for tagging pre-releases of (not-only
>>>> rpm) packages.
>>>>
>>>> Is there some deep technical reason why tilde cannot be present in a
>>>> tag name? I tried that e.g.
>>>
>>> Yes, because a trailing tilde is part of git's rev syntax, see "man
>>> git-rev-parse", or try in any repo:
>>>
>>>     git show HEAD
>>>     git show HEAD~2
>>>     git show HEAD^~2
>>
>> Right, reading the man pages:
>>
>> <rev>~<n>, e.g. master~3
>>            A suffix ~<n> to a revision parameter means the commit
>> object that is the <n>th generation ancestor of the named commit
>> object, following only the first
>>            parents. I.e.  <rev>~3 is equivalent to <rev>^^^ which is
>> equivalent to <rev>^1^1^1. See below for an illustration of the usage
>> of this form.
>>
>> Would it be acceptable to disallow only ~<n> (<n> as [0-9]+) in a tag
>> name but allow ~[^0-9].*, i.e. if the immediately following symbol
>> after '~' is a letter, do not
>> interpret ~ as a special character. Could it work?
>
> We could make that work, with some caveats:
>
>  1) The syntax we've reserved for refnames is quite small, and my bias
>     at least would be to say you should just make a tag like
>     rpkg-util-1.4-rc1 instead (as e.g. git.git and linux.git do).
>
>     Carving out an exception like this also means we couldn't use
>     ~[^0-9].* for anything magical in the future.
>
>     But I think that's a rather small objection, we have other syntax
>     escape hatches, and we're unlikely to use ~[^0-9].* as some new
>     magic.
>
>  2) If we patch git to accept this, you'll be creating refs that aren't
>     inter-operable with previous versions of git.
>
>     This is a big deal. E.g. you'll happily create this special ref,
>     then try to push it to github, and they'll croak because that's an
>     invalid ref to them. Ditto some co-worker of yours who's using an
>     older version of git.
>
>     FWIW if you manually create such a tag e.g. for-each-ref will emit
>     'warning: ignoring ref with broken name' and just not show it.

Not to beat this dead horse, but just for the list archive: FWIW there's
other commands that'll just plain die if they find such a ref, e.g. git
gc:

    fatal: bad object refs/tags/foo~rc1
    error: failed to run repack

So if we ever expand the scope of allowed refs we'd need to first adjust
the setting and then wait a long time, least downgrading git hard break
some commands.

>>>
>>> etc.
>>>
>>> Although I guess git could learn to disambiguate that form from the tag
>>> you're trying to create.
>>>
>>>> git tag rpkg-util-1.4%rc1
>>>>
>>>> but percentage sign does not seem to be particular fitting for
>>>> pre-release marking.
>>>>
>>>> Thank you
>>>> clime
