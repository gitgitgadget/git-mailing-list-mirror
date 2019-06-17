Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBBC61F462
	for <e@80x24.org>; Mon, 17 Jun 2019 22:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFQWdn (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 18:33:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43610 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfFQWdn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 18:33:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so18414107edr.10
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kFTjmAOoWY95P3s4nl+plhF5ZbjlT2iNjiVAM66DN60=;
        b=jfNcyct19/08VzRQD7p4B6rGRM24WwtBmHJ8R33YeifQaDIWUv7/se2GLHcJyEXmKL
         +zypNDRNXg3seqsrh64DXBDP/wOzltafSZnU0Y3iuya8lRqK6Rb64KGoYYbEK6vwC318
         Gsl1A72eijseGWagqlZNA9lkxhZYeOnp6vRcwkH32fYHWwmZYlNp7NhPFJP9YGb03hTd
         /Pn2ILJQJTjqzsCAaRO2f3Yy/nVTBz5jc3TDs6sED43k4gfImdv3px6mvljj9DSXbFdy
         zBN6KW+EW+dt35W6bgbVfatyjgEDWQdNa6QgSN9nSGaJy9gB08A19882PTWpWFihOqJ2
         enrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=kFTjmAOoWY95P3s4nl+plhF5ZbjlT2iNjiVAM66DN60=;
        b=eiz6xNZ8CcKolT+lpwIrcnTHpxhYrbVctuNZGfKHUwwPpfOBImrSkxiYhNjrwHLKGa
         qcuFAIPK1mU4ncK0nerbxaZcmIpfSnS3htWCtameWsimfsUJenahxViUaZ+VmysMImNn
         Xn/XKQxZRwWKdHj0H8sVydDbYmWfXYy3hvPHkqcnQwoIV1kwXKnLGRfUhln17iGhS2+o
         lEjIi9S1Ej2rWy3kT97Em8L+F4Wjb26sh61FFs0L/uegW0spUGA/mM5z5uymgB+eBj7J
         ATicQ49EW+nxWIPTjDtYAEYCSqd138DyK2QGUi/66r6BnPc0EgxiNaeKNSV8yswpkijm
         7S3w==
X-Gm-Message-State: APjAAAVsb8I/Gtb0MDoxWlndmtutt0ovFb7Owk3zEfk1xNC+2BaR9cKC
        rrnCYcP9ujVoPrpfZSKV5mQ=
X-Google-Smtp-Source: APXvYqx7hpThK/+AmNG2I/XdW88YkZG2CqrvMPsq/CRJI6Ld9o9GmhNAVQGkIqHnfQT7si1gbo/pMw==
X-Received: by 2002:a05:6402:1459:: with SMTP id d25mr7557692edx.235.1560810821095;
        Mon, 17 Jun 2019 15:33:41 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id s5sm452405ejk.36.2019.06.17.15.33.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:33:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
        CB Bailey <cb@hashpling.org>
Subject: Re: Deadname rewriting
References: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com> <87sgsb8dmx.fsf@evledraar.gmail.com> <95cde058-37b3-a168-ff45-97f9501305a0@iee.org>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <95cde058-37b3-a168-ff45-97f9501305a0@iee.org>
Date:   Tue, 18 Jun 2019 00:33:39 +0200
Message-ID: <87pnnb970c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 17 2019, Philip Oakley wrote:

> On 15/06/2019 09:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sat, Jun 15 2019, Phil Hord wrote:
>>
>>> I know name-scrubbing is already covered in filter-branch and other
>>> places. But we have a scenario becoming more common that makes it a
>>> more sensitive topic.
>>>
>>> At $work we have a long time employee who has changed their name from
>>> Alice to Bob.  Bob doesn't want anyone to call him "Alice" anymore and
>>> is prone to be offended if they do.  This is called "deadnaming".
>>>
>>> We are able to convince most of our work tools to expunge the deadname
>>> from usage anywhere, but git stubbornly calls Bob "Alice" whenever
>>> someone asks for "git blame" or checks in "git log".
>>>
>>> We could rewrite history with filter-branch, but that's quite
>>> disruptive.  I found some alternatives.
>>>
>>> .mailmap seems perfect for this task, but it doesn't work everywhere
>>> (blame, log, etc.).  Also, it requires the deadname to be forever
>>> proclaimed in the .mailmap file itself.
>>>
>>> `git replace` works rather nicely, except all of Bob's old commits
>>> show "replaced" in the decorator list. Also, it doesn't propagate well
>>> from the central server since `refs/replaces` namespace isn't fetched
>>> normally.  But in case anyone wants it, here's what I did:
>>>
>>> git log --author=3Dalice.smith --format=3D"%h" --all |
>>>     while read hash ; do
>>>        GIT_EDITOR=3D'sed -i -e s/Alice Smith/Bob Smith/g' -e
>>> 's/alice.smith/bob.smith/' \
>>>        git replace --edit $hash
>>>     done
>>> git push origin 'refs/replace/*:refs/replace/*'
>>>
>>> I'd quite like the .mailmap solution to work, and I might flesh that
>>> out that some day.
>>>
>>> It feels like `.git/info/grafts` would work the best if it could be
>>> distributed with the project, but I'm pretty sure that's a non-starter
>>> for many reasons.
>>>
>>> Any other ideas?  Has anyone here encountered this already?
>> What should be done is to extend the .mailmap support to other
>> cases. I.e. make tools like blame, shortlog etc. show the equivalent of
>> %aN and %aE by default.
>>
>> This topic was discussed at the last git contributor summit (brought up
>> by CB Bailey) resulting in this patch, which I see didn't make it in &
>> needs to be resurrected again:
>> https://public-inbox.org/git/20181212171052.13415-1-cb@hashpling.org/
>>
>> So, patches welcome :)
>>
>> What's not going to be supported is some notion of 100% forgetting that
>> there was ever an Alice that's now called Bob. They did in fact create
>> commit objects with "Alice" in them, and low-level plumbing like
>> "cat-file -p <commit>" is always going to show that, and there's going
>> to be the mapping in .mailmap.
>>
>> But as far as porcelain UI things that would show the mailmapped value
>> goes those can be made to always show "Bob".
>>
>> Unless of course your $work is willing to completely rewrite the repo...
> This may become a bigger issue for corporates that prevents Git from
> being used because it doesn't handle the _legal requirements_ for
> proper current `known-by:` naming.
>
> I found this [1] on the UK Parliament website that also covers
> 'deadnaming', and the potential misunderstandings about what is (and
> is not) a (unnecessary) 'legal name'.
>
> It may be an option for the SHA1 transition to also include, as an
> independent step, the appropriate mailmap conversion for dead-names
> (which is a private document owned by the hosting repo owner - see
> GDPR Data Controller responsibilities).
>
> If author/committer renaming is done as part of a full hash conversion
> (with a golden repo providing hash mapping) then it is less of a
> problem for a one-shot conversion, but still an issue for everyday
> name changes (including those from divorce, adoption, etc). Maybe even
> convert (swap) the ascii/utf-8 names for unique hashes (in the repo)
> for reverse look up of the latest known-by name (getting a bit
> complicated here)
>
> The distributed nature of the classic Git open source usage may have
> similar issues to that of gmane, where it pulled the hosting of email
> lists. A legal case is likely needed before any level of clarification
> is obtained (which will still have overlaps!)
>
> The mailmap is probably not the right place for holding deadname
> conversions as they should not be public, but it may be a partial
> workaround to reduce visibility of deadnames.
>
> [1]
> https://publications.parliament.uk/pa/cm201516/cmselect/cmwomeq/390/39009=
.htm

I don't see how tacking this onto the SHA-1->SHA-256 hash transition
could ever work.

Ignoring the issues with how it wouldn't work with the current plan as
designed, you'd have a mostly 1=3D1 mapping between the two hashes, except
in cases where commits from "Alice" wouldn't 1=3D1 map, because they'd
been subject to some mailmap munging you didn't have access to to map
them to "Bob".

I'd think that in the context of a non-public work repository you'd just
leak the same information anyway. People wanting to deadname themselves
is relatively rare, so it wouldn't be hard in most cases to infer the
missing data, and you'd be back at square 1.

That, and even if it somehow worked the hash transition is a one-off
thing, and you'd presumably want this on an ongoing basis, so you'd need
some other mechanism.

I think there's certainly a place for better support for gracefully
handling complete history rewriting in a centralized workflow better
within git.

That sort of thing is useful for other things, e.g. you might want to
rewrite out some old big blob in your history, or erase any record that
you used to use an indenting style that's not in fashion.

So basically an improvement to the refs/replaces facility where clients
would opt-in to eagerly forget the old history, and since it your $work
you'd have a central server you could enforce the eventual full
transition, and clients wouldn't get upset about the non-fast-forward.
