Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5EA1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbeGKV4F (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:56:05 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46092 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732452AbeGKV4E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:56:04 -0400
Received: by mail-io0-f193.google.com with SMTP id i18-v6so10087005ioj.13
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nVinoVHc9ZTuIIAkchXoaLA1zMRXSmS/VtRTis4w9j0=;
        b=c6j3MPLlNVOZgCicavz7Ikw5prKDl+UH1sINXjazCivComWhye30vPXKK5YmyOoIk2
         pkuj43t1n/dG7RLVjnniBKm8ut7kCDtpLLUYI/YIxB9m0bajeNu5/b70fVKd0+JZ5ENv
         9S+Md09dKfq6gxM+VPqmeUPKCqh36Se+n10xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nVinoVHc9ZTuIIAkchXoaLA1zMRXSmS/VtRTis4w9j0=;
        b=MbTnjKn8kZKUyNQwA10hfHzNJRgtsYy/vgDIA2DlgXZGwPlg/XkzxUOR7wB4blekJL
         JqKkrdAN+6zAH1elWKY/b541Wq2rWdiF0EJ+9dLfjlfRM7CLgsQBrTWTwcSKUbke66f4
         CoJp36SznahWIscV6+LDE2SBkiZJVsNhL+GoHJTGZk+T/LTLL/aRKd8ug7CocNvW32dj
         ALpVCeHZbC5qwqgPz4K9vqP1HePH7Mc+NCSNKoRxUNT48b6NI4p+xu3iitdlp2DUFlCR
         2290mzspwMuI7F+XjSjWOP4W+F+XFE2chwMKSfx6ywlKvuBqS/UnfLVnphsO3AGyolQi
         Gv9g==
X-Gm-Message-State: AOUpUlF/Z4BsOdqhfyqOCwd9G8nUZMSKcXcMg/Z8qTRphxhZu2Aq8bdG
        D0K7cwZBa5rmkGZvghMiQ1mnhDh1xv8TNiN7pe7mmonT
X-Google-Smtp-Source: AAOMgpeqUSBCa4zvNQL88TIgJYi5R7d1xpWeuSmlBqeKsQM7OlOX/44Vhjv7guoM+4LXHwVKzdHnQ0JcD6BLu2P6GEE=
X-Received: by 2002:a6b:380b:: with SMTP id f11-v6mr678327ioa.560.1531345783103;
 Wed, 11 Jul 2018 14:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
 <alpine.LFD.2.21.999.1807071502260.18818@i7.lan> <87h8l5cvp3.fsf@evledraar.gmail.com>
In-Reply-To: <87h8l5cvp3.fsf@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Jul 2018 14:49:32 -0700
Message-ID: <CA+55aFw2srtqU2B60wWo9h38pTTwT4zCDHZDwb+WMpMAbc0wOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Add 'human' date format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 2:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I think that's true for the likes of linux.git & git.git, but a lot of
> users of git say work in some corporate setting entirely or mostly in
> the same timezone.
>
> In that case, knowing if some commit whose sole message was "fix"[1] was
> made at 3am or in the afternoon, even if it's really old, is really
> useful information, even years later.

Heh.

Maybe. But if  you care about that kind of information, would you
actually want to use the "human" date? Wouldn't you want to use the
strftime thing instead, which gets you whatever field you care about,
and gets it consistently regardless of how old the data is?

That said, I do acknowledge that the "human" format may be a bit
inflexible and ad-hoc. Of course some more generic way that allowed
arbitrary rules might be better for some uses.

I'll just explain the cases that made me zero in on what that last patch di=
d:

 (a) I do like the "relative" date for recent stuff.

Quite often, I look at how recent the commits are, for example, and
then I really like seeing "2 hours ago" rather than a time with a
timezone (which is a lot harder for me to mentally parse)

This was the primary impetus for my original "auto" patch many years
ago, that was (rightly) not merged. It really boiled down to just
"default or relative, depending on how recent it was".

 (b) I noticed that I was distracted by dates that were *too* terse.

My first patch had _just_ the time when it was today and the same
timezone (but older than two hours, so the original relative logic
didn't trigger).

That initially sounded great to me, which is why it was that first time.

But after _using_ it for a while, I actually found that it didn't have
enough context for me (visually) to really trigger my date parsing at
all.

So "five hours ago" actually parsed better than just "9:48" to me. I
didn't think it would do that, but it did. Which was why I changed the
"relative" time to trigger every time if it was the exact same date
(and in the past) - just to avoid the really terse model.

 (c) when I played around with other commands than just "git log", I
also noticed that a consistent length mattered.,

Again, my first version was more along the lines of "if it's long ago,
just use the full format, exactly like the default date". It wasn't
*quite* that, because it would always skip the seconds, but it was
close.

And with "git log", that worked fine, because dates were fairly
uniformly increasing, so the date format would slowly get longer, and
that was fine.

But then when I played with "git blame -C --date=3Dhuman", I noticed
that not only did the human date actually make sense there too, it
actually made it easier for me to read - and that in particular, the
"extra" info was just annoying.

So now I find that shortened "only show the date" format to be really
good _particularly_ for "git blame". You can see very clearly whether
it's something recent or something old.

Maybe my use of "git blame" is unusual, but I don't think so. I tend
to do "git blame -C" when I'm looking for a bug, and then seeing
something like this:

        ...
          Apr 16 2005       437)
          Apr 16 2005       438)
          Jan 14 2016       439)
          Apr 16 2005       440)
          Apr 16 2005       441)
          Apr 16 2005       442)
          Thu Jun 14 15:26  443)
          Thu Jun 14 15:26  444)
          Thu Jun 14 15:26  445)
          Thu Jun 14 15:26  446)
          Thu Jun 14 15:26  447)
          Thu Jun 14 15:26  448)
          Thu Jun 14 15:26  449)
          Thu Jun 14 15:26  450)
          Apr 16 2005       451)
          Jul 30 2012       452)
          Jul 30 2012       453)
          Feb 13 2012       454)
          Apr 16 2005       455)
          Apr 16 2005       456)
        ....

in that date field (yeah. that happens to be "kernel/fork.c" in the
current kernel - I just edited out all the other stuff than time and
line number) is actually very visually easy to see what parts are old,
and which ones are recent, because it changes the format pretty
clearly and unambiguously, without changing the size of that field
_dramatically_.

(Sure, the size changes, but it's not a radical difference, it's a
fairly small variation, and the variation only highlights the
different time range, without making it compltely unbalanced).

Anyway, enough excuses. I'l just trying to explain some of the things
that I noticed simply _while_ making some of the decisions I made.

Are they the "right" decisions? I don't know. But I've been running with th=
at

        git config --add log.date auto

in my kernel repo since I posted the patches, and so far I'm still liking i=
t.

                 Linus
