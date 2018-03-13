Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14861FAE2
	for <e@80x24.org>; Tue, 13 Mar 2018 10:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeCMKJS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 06:09:18 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40342 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeCMKJR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 06:09:17 -0400
Received: by mail-wr0-f176.google.com with SMTP id m4so8063476wrb.7
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fmF+vA8StZzsoMmuCw0QT/3cjvQd59iUit5GQqH+TZg=;
        b=ol1kYrUKApVxCJYkfmfB/+xUyDGj7KG+x/AkBmg94FpmqoQUWd0wDvRYgh7M4tYGGG
         cq88A/XmRQ3qg/hBnmdcqLFU16asjkGcpCt+RErJG93ZrgTYSornttzfftf81iJSVKSE
         u341tuzPsj75qWhkaDlQ+KjfiS3DiDbJGdTImGGuXB+veXYmOXHCD2mhaFKEQIJB59C3
         DzezH5UhtFAx//9fEpNeaIs0JGbWyo2wITdEkRSuvzfGQ6+owHJZiBzsxlo31ntW9w0x
         gU+U7pcPj84kTQUxI015k7OZzeqZJBgnRIAfDAi3Er1K1NsLPwZZB0qUw/31Y9jjXXXw
         fRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=fmF+vA8StZzsoMmuCw0QT/3cjvQd59iUit5GQqH+TZg=;
        b=fErFD/C5MYVw4dgt2R8ykBuHlPBpJowJMwUSNASdbLb7pXdzd1Nl+p052Q3/oYS1xT
         3bGof1C/onHYINzryfOduqo8ZqbW6Or9B8JXzebP51rFK41lzhunXT+J1pe2QwtHX0Qy
         62QskTqT/s6vuyX3VHEa6+BGWcjkX7VSkzjDbxvxUdzmcmmU5zUgnUB6S46StrD+CdY6
         dFAYEPgbCw3GZlZKRK9bIGlDcPsS6n8o/j4IWbPhIIB3D8LUXOUPXA483bimw5dsTvBR
         mRBCVdlmonTa4wTWsFH7dWWxfXQqP3725dNa2mSmm30+Lqai71Q++K/kxD91D/l5JWjb
         6k4w==
X-Gm-Message-State: AElRT7EnXOwLFJI2yxP7/sbzXq+IK/Rg8Z+Sxmn+oybf2jreqoLDpo8M
        CPvN8Np9VAVqheeX68reugc=
X-Google-Smtp-Source: AG47ELutykxJFr10keon5FJnfAl2pL/qi+lqsVIR4m4iinxoD45lk/fJq6cUpez5A4IeUtLbd6TAkw==
X-Received: by 10.80.165.84 with SMTP id z20mr258618edb.300.1520935756618;
        Tue, 13 Mar 2018 03:09:16 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y14sm188977ede.18.2018.03.13.03.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 03:09:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michal Novotny <clime@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: allow "~" to be present in a tag name
References: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com> <873714qr7i.fsf@evledraar.gmail.com> <CANT8FXTT=5sGp9Wn4h5t=k4TiiADQrf--hDv5EmCx=KoGHgwXg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CANT8FXTT=5sGp9Wn4h5t=k4TiiADQrf--hDv5EmCx=KoGHgwXg@mail.gmail.com>
Date:   Tue, 13 Mar 2018 11:09:14 +0100
Message-ID: <87zi3cp9rp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 13 2018, Michal Novotny jotted:

> On Tue, Mar 13, 2018 at 10:07 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Tue, Mar 13 2018, Michal Novotny jotted:
>>
>>> Hello,
>>>
>>> currently, if I try to create a tag that has tilde "~"  in name, an
>>> error is raised. E.g.
>>>
>>> $ git tag rpkg-util-1.4~rc1
>>> fatal: 'rpkg-util-1.4~rc1' is not a valid tag name.
>>>
>>> Now, actually it would be very cool if tilde was allowed in a tag name
>>> because we would like to use it for tagging pre-releases of (not-only
>>> rpm) packages.
>>>
>>> Is there some deep technical reason why tilde cannot be present in a
>>> tag name? I tried that e.g.
>>
>> Yes, because a trailing tilde is part of git's rev syntax, see "man
>> git-rev-parse", or try in any repo:
>>
>>     git show HEAD
>>     git show HEAD~2
>>     git show HEAD^~2
>
> Right, reading the man pages:
>
> <rev>~<n>, e.g. master~3
>            A suffix ~<n> to a revision parameter means the commit
> object that is the <n>th generation ancestor of the named commit
> object, following only the first
>            parents. I.e.  <rev>~3 is equivalent to <rev>^^^ which is
> equivalent to <rev>^1^1^1. See below for an illustration of the usage
> of this form.
>
> Would it be acceptable to disallow only ~<n> (<n> as [0-9]+) in a tag
> name but allow ~[^0-9].*, i.e. if the immediately following symbol
> after '~' is a letter, do not
> interpret ~ as a special character. Could it work?

We could make that work, with some caveats:

 1) The syntax we've reserved for refnames is quite small, and my bias
    at least would be to say you should just make a tag like
    rpkg-util-1.4-rc1 instead (as e.g. git.git and linux.git do).

    Carving out an exception like this also means we couldn't use
    ~[^0-9].* for anything magical in the future.

    But I think that's a rather small objection, we have other syntax
    escape hatches, and we're unlikely to use ~[^0-9].* as some new
    magic.

 2) If we patch git to accept this, you'll be creating refs that aren't
    inter-operable with previous versions of git.

    This is a big deal. E.g. you'll happily create this special ref,
    then try to push it to github, and they'll croak because that's an
    invalid ref to them. Ditto some co-worker of yours who's using an
    older version of git.

    FWIW if you manually create such a tag e.g. for-each-ref will emit
    'warning: ignoring ref with broken name' and just not show it.

>>
>> etc.
>>
>> Although I guess git could learn to disambiguate that form from the tag
>> you're trying to create.
>>
>>> git tag rpkg-util-1.4%rc1
>>>
>>> but percentage sign does not seem to be particular fitting for
>>> pre-release marking.
>>>
>>> Thank you
>>> clime
