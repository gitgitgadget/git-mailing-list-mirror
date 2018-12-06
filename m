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
	by dcvr.yhbt.net (Postfix) with ESMTP id 68BA8211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 09:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeLFJR3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 04:17:29 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33397 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFJR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 04:17:28 -0500
Received: by mail-wm1-f53.google.com with SMTP id r24so13658288wmh.0
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 01:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+jXU7ITAUise+AQyS7xRsg2aXvi738J/5m0lkEs6FGY=;
        b=Ia2VdFQze8ukoRXVQjV47gLnJhhX3QadW/qSo8UkFxydZR52UEWMh3/KbUeHiUbrpn
         km7xwZqRHdesHQkRjo0LpdSrywwYMtjmVwFwvFbPJmbaILq/SyssDGqnZZ1iDYkW/lu5
         538dCJVu3u916xnK2cNubdFcxnYcnWVwoPnG5kdsT5BcoyD5o+TXQVUsfrkmT50+/RMQ
         H6cGke3+u7XkhjVsQwccLTdi9jtXuqxTL9dkyL4q3QaifXmbF7zfmdandI92sI70a/j9
         upDauLbLAsuHtkOfy1DPVpUM9B13qYa/Rn0nEQQqUagsoo3emFZ8qy9hRDlGfg5shQnO
         1xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+jXU7ITAUise+AQyS7xRsg2aXvi738J/5m0lkEs6FGY=;
        b=DWtyc4g9AOw7fju+GcQq4MLHF/o42j/U5gYypigjHv4l8pXkioi8kKYOu+Smr+8eNX
         keOjwKuGTQAy+4cRCQwW5yoHU8RDyRxU6CSud9jHC3u12zAE35WJ83oZdGCslM4AiGhm
         6zZEatpHy9XyAj4os/14lLJ/Rx+O+dAdM69eLSZGQFb79kvSJ+FbJAfeqPI5r46DxnL0
         av+8kRtfk/TvwG+yZYckfp0isiV35UJ8hALQFD4i0BmuayR9EBwtHkyeGhvV4quXzIb8
         QUMf/dSLq69iysy3mltYdRTnT66d0QEuGaFaU59Hmv+xCyJRF1DjUmVUszIfwjNtoOne
         J4WA==
X-Gm-Message-State: AA+aEWZILSL4Lf38/pEU4SUCGHDcUbaX6nkTxf4CORuE2GhJVfg/QQE6
        5QJdbvV2ow9gYhI55svCxtM=
X-Google-Smtp-Source: AFSGD/XoXkgIk9YyW13UdaTuTqH+LSfGuxsgqo0u62CHePVnwK2VLfFQQ5UcxTH5aL8laT4SJQBO5w==
X-Received: by 2002:a1c:384:: with SMTP id 126mr19001962wmd.26.1544087846441;
        Thu, 06 Dec 2018 01:17:26 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id b7sm21150062wrs.47.2018.12.06.01.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 01:17:25 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Coiner\, John" <John.Coiner@amd.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
        <20181205210104.GC19936@sigill.intra.peff.net>
        <xmqqwoona2c6.fsf@gitster-ct.c.googlers.com>
        <20181206072002.GA29787@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181206072002.GA29787@sigill.intra.peff.net>
Date:   Thu, 06 Dec 2018 10:17:24 +0100
Message-ID: <8736rbypy3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 06 2018, Jeff King wrote:

> On Thu, Dec 06, 2018 at 10:08:57AM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > In my opinion this feature is so contrary to Git's general assumptions
>> > that it's likely to create a ton of information leaks of the supposedly
>> > protected data.
>> > ...
>>
>> Yup, with s/implemented/designed/, I agree all you said here
>> (snipped).
>
> Heh, yeah, I actually scratched my head over what word to use. I think
> Git _could_ be written in a way that is both compatible with existing
> repositories (i.e., is still recognizably Git) and is careful about
> object access control. But either way, what we have now is not close to
> that.
>
>> > Sorry I don't have a more positive response. What you want to do is
>> > perfectly reasonable, but I just think it's a mismatch with how Git
>> > works (and because of the security impact, one missed corner case
>> > renders the whole thing useless).
>>
>> Yup, again.
>>
>> Storing source files encrypted and decrypting with smudge filter
>> upon checkout (and those without the access won't get keys and will
>> likely to use sparse checkout to exclude these priviledged sources)
>> is probably the only workaround that does not involve submodules.
>> Viewing "diff" and "log -p" would still be a challenge, which
>> probably could use the same filter as smudge for textconv.
>
> I suspect there are going to be some funny corner cases there. I use:
>
>   [diff "gpg"]
>   textconv = gpg -qd --no-tty
>
> which works pretty well, but it's for files which are _never_ decrypted
> by Git. So they're encrypted in the working tree too, and I don't use
> clean/smudge filters.
>
> If the files are already decrypted in the working tree, then running
> them through gpg again would be the wrong thing. I guess for a diff
> against the working tree, we would always do a "clean" operation to
> produce the encrypted text, and then decrypt the result using textconv.
> Which would work, but is rather slow.
>
>> I wonder (and this is the primary reason why I am responding to you)
>> if it is common enough wish to use the same filter for smudge and
>> textconv?  So far, our stance (which can be judged from the way the
>> clean/smudge filters are named) has been that the in-repo
>> representation is the canonical, and the representation used in the
>> checkout is ephemeral, and that is why we run "diff", "grep",
>> etc. over the in-repo representation, but the "encrypted in repo,
>> decrypted in checkout" abuse would be helped by an option to do the
>> reverse---find changes and look substrings in the representation
>> used in the checkout.  I am not sure if there are other use cases
>> that is helped by such an option.
>
> Hmm. Yeah, I agree with your line of reasoning here. I'm not sure how
> common it is. This is the first I can recall it. And personally, I have
> never really used clean/smudge filters myself, beyond some toy
> experiments.
>
> The other major user of that feature I can think of is LFS. There Git
> ends up diffing the LFS pointers, not the big files. Which arguably is
> the wrong thing (you'd prefer to see the actual file contents diffed),
> but I think nobody cares in practice because large files generally don't
> have readable diffs anyway.

I don't use this either, but I can imagine people who use binary files
via clean/smudge would be well served by dumping out textual metadata of
the file for diffing instead of showing nothing.

E.g. for a video file I might imagine having lines like:

    duration-seconds: 123
    camera-model: Shiny Thingamabob

Then when you check in a new file your "git diff" will show (using
normal diff view) that:

   - duration-seconds: 123
   + duration-seconds: 321
    camera-model: Shiny Thingamabob

etc.
