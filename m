Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0B71F453
	for <e@80x24.org>; Wed, 26 Sep 2018 20:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeI0C7V (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:59:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40201 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeI0C7V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:59:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id j62-v6so3090956edd.7
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SXYGFvGUH6AixMdg/J70xrTiAKhMfSO94h1zwv7WkTc=;
        b=d85R7H0cErxMReJe4uQ2e4uEuLTpjH/XxGDXPuGQ6YDAIJJo6swCUHP5VliCCMK11J
         ZcyZYEaY28PpRO6W6u+NBL1naqT6HwhBN9puA7Rw5y9thxllfyEmk3Xw5MTv7e7VyeIy
         dvFdos4DxT3P8ATIPr3Tqdk7w1Am4FX2RfG37aAOWmzZIJO9XMHaGMbsdqLXRddH+Em7
         Z59ILi730BTGNi4YcuRHHzf5JLd0lJFYWLOkzyqbe3FbZrqwrXU9S/DrVxkci4TKx5It
         OQf/Bf6F73MtCKrEGFQn3DHZV97jwPni22kvrj+QcIlf14EqnZgEsWOu6Dh4DddQ4fTQ
         /htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SXYGFvGUH6AixMdg/J70xrTiAKhMfSO94h1zwv7WkTc=;
        b=nr5Cv6oOhU2ty4CCcpeOS8wowfVFQVd34CW54h7cI78ooegbk1VKHfAztPdd3P6M0e
         RbtPAyf4L1Mj+LMj8IolSnSbTrrOwjXNw2OuZuqG8vD0Fvif/Fu01XVlhmX9e36ypYwQ
         hz8l6sg+iwdx+ktA0rOSAFB19JvDDIu03QoVLs9+agXw2lnNE7vE3ENiWvV6UCTrZHCF
         KAGCehC5bngCplaBDMxve/5SBVwOtUfEXkJwl6qCJmgG4Zu3Y1/Gi191P1K0q4VFuV4K
         Ugqe35oxEsz+MqqjBKewR3sJ5ToulPeDivkeNOnK8oPUl9R9tyyHYq2kzZ/9MYpILGRO
         GPGg==
X-Gm-Message-State: ABuFfojd8sqLd/1HgaWOuaDO92yF57RRgrOg8arRIGK6jnNSdSzhjcqf
        gz9kODTyoLf9jiWvuK30k5w=
X-Google-Smtp-Source: ACcGV60ND4sjAZ/3dJ+OcHwhLcmAhpPcGHsMYSBdszTD1bd7TApaIVdgh78xXl8GEy5bxwVZgMzYcA==
X-Received: by 2002:a50:9662:: with SMTP id y89-v6mr13135897eda.32.1537994674830;
        Wed, 26 Sep 2018 13:44:34 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id s7-v6sm187719eda.19.2018.09.26.13.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:44:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: On shipping more of our technical docs as manpages
References: <20180921223558.65055-1-sbeller@google.com>
        <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
        <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
        <87d0t0jghm.fsf@evledraar.gmail.com>
        <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
        <87a7o4je0t.fsf@evledraar.gmail.com>
        <20180926185812.GD30680@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180926185812.GD30680@sigill.intra.peff.net>
Date:   Wed, 26 Sep 2018 22:44:33 +0200
Message-ID: <878t3oj8em.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Changing subject because this stopped being about Stefan's patches a
while ago]

On Wed, Sep 26 2018, Jeff King wrote:

> On Wed, Sep 26, 2018 at 08:43:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> While we're on that subject, I'd much prefer if these technical docs and
>> other asciidoc-ish stuff we would be manpages build as part of our
>> normal "make doc" target. So e.g. this one would be readable via
>> something like "man 3 gitapi-oid-array".

[responding out of order]

> Now I'll admit it seems like make-work to me because I would not plan to
> ever look at the formatted output myself. But I guess I don't understand
> the audience for this formatted output. These are APIs internal to Git
> itself. We would not generally want to install gitapi-oid-array into
> /usr/share/man, because only people actually working on Git would be
> able to use it. So it sounds like a convenience for a handful of
> developers (who like to look at this manpage versus the source). It
> doesn't seem like the cost/benefit is there.
>
> And if we were going to generate something external, would it make more
> sense to write in a structured format like doxygen? I am not a big fan
> of it myself, but at least from there you can generate a more richly
> interconnected set of documentation.

It's useful to have a single authoritative source for all documentation
that's easy to search through.

I don't really care where that text actually lives, i.e. whether it's
all in *.txt to begin with, or in *.c or *.h and pulled together by some
"make" step, or much how it's formatted, beyond it being easy to work
with. I'm not a big fan of asciidoc, but it's what we've got if we want
formatting, inter-linking etc.

My bias here is that I've also contributed actively to the perl project
in the past, and with that project you can get an overview of *all* of
the docs by typing:

    man perl

That includes stuff like perl585delta(1) which we'd stick in
Documentation/RelNotes, and "Internals and C Language Interface". Most
of what we'd put in Documentation/technical/api-* & headers is in
perlapi(1).

I spent an embarrassingly long time submitting patches to git before
discovering that Documentation/technical/api-*.txt even existed, I think
something like 1-2 years ago.

We have very well documented stuff like strbuf.h (mostly thanks to you),
but how is such documentation supposed to be discovered? Something like:

    git grep -A20 '^/\*$' -- *.h
    <hold in page down>

?

In terms of getting an overview it's indistinguishable from
comments. I.e. there's nothing like an index of:

    man git-api-strbuf     ==> working with strings
    man git-api-sha1-array ==> list, iterate and binary lookup SHA1s

etc.

Sometimes it's obvious where to look, but as someone who uses most of
these APIs very occasionally (because I contribute less) I keep
(re-)discovering various internal APIs.

I'm also not in the habit of opening the *.h file for something, I
usually just start reading the *.c and only later discover there's some
API docs in the relevant *.h (or not).

So in terms of implementation I'm a big fan of the perl.git approach of
having these docs as comments before the function implementation in the
*.c file.

It means you can't avoid seeing it or updating it when source
spelunking, and it leaves header files short, which is useful when you'd
like to get a general API overview without all the docs. Our documented
headers are quite fat, e.g. strbuf.h is 60% of the size of strbuf.c, but
less than 20% when you strip the docs.

> I'm mildly negative on this, just because it introduces extra work on
> people writing the documentation. Now it has to follow special
> formatting rules, and sometimes the source is uglier (e.g., the horrible
> +-continuation in lists). Are authors now responsible for formatting any
> changes they make to make sure they look good in asciidoc? Or are people
> who care about the formatted output going to come along afterwards and
> submit fixup patches? Either way it seems like make-work.

This part I'm slightly confused by. If you're just saying "let's
document stuff in *.h files in free-flowing text", fine. But if we're
talking about the difference between Documentation/technical/api-*.txt
and having the same stuff in manpages, then the stuff in api-*.txt *is*
already asciidoc, and we have a target to format it all up and ship it
with git, and distros ship that.

E.g. on Debian you can "apt install git-doc" and browse stuff like
file:///usr/share/doc/git-doc/technical/api-argv-array.html which is the
HTML formatted version, same for all the other api-*.txt docs.

We just don't have some central index of those, and they're not a
default target which means the likes of our own https://git-scm.com
don't build them, so they're harder to find.

Every perl installation also ships perlapi and a MB or so of obscure
internal docs to everyone, which makes it easier to find via Google et
al, which I find useful. So I guess I'm more on the side fence of
dropping a hypothetical gitapi-oid-array into /usr/share/man than you
are.

ANYWAY

This E-mail is much longer than I intended, sorry about that. I didn't
just mean to bitch about how we ship docs, but I was wondering if there
was a desire to move to something like what I've outlined above, or
whether the status quo was mostly by design and intended.

I just thought I'd write this rather lengthy E-Mails because this is one
of the rare areas where you can fully describe an idea in E-Mail without
writing any patches.

If the consensus is that something like the exhaustive index "perldoc
perl" provides wouldn't be useful for git I can just drop this, but if
people are enthusiastic about having that it would be useful to work on
it...
