Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1777420248
	for <e@80x24.org>; Sun, 17 Mar 2019 14:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCQOMI (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 10:12:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41911 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfCQOMH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 10:12:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so4118953edc.8
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XW1lK54hNIcQCCkHobR0kBEkhTq79laOKyfThfdXOz8=;
        b=YPVbpv4T/HVg115JZ55SlvAUSRcQ4y2VLBdcCVe77co16QBhHYrqQeCGa5lHRu0GdV
         Ed117OvO+EiT7cNYk3hAsScbU9OwqMFCQ+Fs8qPgHBN0w3t4sixKngJk6Cz4nlOyrSuH
         m89pNJiJKEHPqctL08mG9FVeMmEtm/ZeZ2S8Dn18OuzRFPEkMGq2fyrykV7SBA/P1u6Y
         j6wRWmrw9/en3SFrxkOsXQNTKjbMqkjxgTFg1lJTc3eSJQP90naU9zHa4AAGyW+XOYwh
         lehdP373cqc792Q1/5gQjfoiCmnf4WZdWfhAQiEu52FdebD1eoZd7RMNiDP08+6cQHUA
         2CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XW1lK54hNIcQCCkHobR0kBEkhTq79laOKyfThfdXOz8=;
        b=Jk6c/TsjAA4OHtU5Eebcxqjv+jmzbp80q2LgRuUgv7jKkabuQJ2+xMa4Y8GvT6mJ5U
         i+AD0B0uR5o2S+TbhkB1J8VOz3np/WgtKqoqTR8kV9ypzQO93MqhyN/SbUCmsDfmmRnH
         hj7kbyHJLnxTHT6ukBPvSNtTy8NrURmEqES+V4zy9F+iH5pCUrvIXtkl49JXNDg72n5m
         zfXRahWdtQWoila5o+You0JrC/4fLiD419dd+5emZnH9RkLS/cZjheCnQRRoJK1Vkz39
         P8pZHoCIG8laLwgqeQzoYij0j6HtROvnsIXfw5vSgm+/JIOUSZ1sF5F6j650Dl+sJ7He
         w4nw==
X-Gm-Message-State: APjAAAU9ocGiS9juap7TxIgzbIUtqAeDOrHe44qTNUx3EDg2qUjJGgM9
        g2u3IVdRjDTRZPlu7t69eIZRg1LA
X-Google-Smtp-Source: APXvYqwuHjENHDOhtuqMtFi/bz81UlFGlPaKTUmjhRAU9vhe2pia3OUxMKO9zXYme4V2n7ji1FQOKQ==
X-Received: by 2002:a05:6402:617:: with SMTP id n23mr9446615edv.187.1552831925319;
        Sun, 17 Mar 2019 07:12:05 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id a51sm2594703edd.57.2019.03.17.07.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 07:12:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com> <87multaaac.fsf@evledraar.gmail.com> <CACsJy8C3P93896fP8BStmYd1WMNukYV6u8gB0zgC3rKLqxgzyQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8C3P93896fP8BStmYd1WMNukYV6u8gB0zgC3rKLqxgzyQ@mail.gmail.com>
Date:   Sun, 17 Mar 2019 15:12:04 +0100
Message-ID: <87lg1da8uj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 17 2019, Duy Nguyen wrote:

> On Sun, Mar 17, 2019 at 8:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Sun, Mar 17 2019, Denton Liu wrote:
>>
>> > The documentation used to consider
>> >
>> >       git diff <commit> <commit>
>> >
>> > and
>> >
>> >       git diff <commit>..<commit>
>> >
>> > to be equal counterparts. However, rev-list-ish commands also use the
>> > <commit>..<commit> notation, but in a logically conflicting manner whi=
ch
>> > was confusing for some users (including me!).
>> >
>> > Deprecating the notation entirely is not really an option because it
>> > would be an arduous process without much end-value. In addition, there
>> > are some valid use-cases that we don't want to break.
>> >
>> > Document the preference of the first form so that future confusion can
>> > be minimised.
>> >
>> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> > ---
>> >
>> > Thanks all on your feedback on the discussion thread[1]! I opted for
>> > just the documentation-only route so we don't break any valid use-case=
s.
>> >
>> > [1]: https://public-inbox.org/git/20190311093751.GA31092@archbookpro.l=
ocaldomain/
>> >
>> >  Documentation/git-diff.txt | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
>> > index 72179d993c..10c7a2220c 100644
>> > --- a/Documentation/git-diff.txt
>> > +++ b/Documentation/git-diff.txt
>> > @@ -63,7 +63,11 @@ two blob objects, or changes between two files on d=
isk.
>> >
>> >  'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
>> >
>> > -     This is synonymous to the previous form.  If <commit> on
>> > +     This is synonymous to the previous form.  However,
>> > +     users should prefer the previous form over this form
>> > +     as this form may be more confusing due to the same
>> > +     notation having a logically conflicting meaning in
>> > +     linkgit:git-rev-list[1]-ish commands.  If <commit> on
>> >       one side is omitted, it will have the same effect as
>> >       using HEAD instead.
>>
>> I think we're better off just consistently recommending "A..B" instead
>> of "A B" and "fixing" any occurrence of the latter to the
>> former. I.e. not taking this patch & going in the other direction.
>>
>> As noted in the thread you linked we'll always need ".." when one side
>> is "HEAD" implicitly, and that's a really common case.
>
> You could just type " @" instead of "..". And that one is easier to expla=
in.

Sure, and if we're going to change our docs to consistently use @ at
either side of such ranges instead of the empty string for "HEAD" I
think that's worth discussing if the goal is to get rid of ".." for
"diff".

I'm commenting on the in-between state being more confusing to users,
which is as far as this patch gets us.

>> So as confusing as the whole ".." v.s. "..." is in diff v.s. log I think
>> we're worse off with "A B", since we'll *still* need to document the
>> likes of "A.." and how that differs from log "A.." or "A...".
>>
>> So sometimes using the whitespace form for two revs and then the ".."
>> when we just have one side makes things more confusing, not less. The
>> reader will be left having to juggle more complexity in their head, not
>> less.
