Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F07C20281
	for <e@80x24.org>; Fri, 29 Sep 2017 16:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbdI2QIa (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 12:08:30 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:54080 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbdI2QI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 12:08:29 -0400
Received: by mail-qk0-f169.google.com with SMTP id w63so84560qkd.10
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lKrd8xIQOffLP51lnujhKxWIN9oB40aSwJMJKkXxTR8=;
        b=nW859wUsbOxQEkSYClMWeWUf0gv5NIkW4VJRjsTwYh6PCtelkMOMsO8BB7pEvBacQ4
         ayA+qzPur0Bcu0h6keftHQWhM1yW8dPruN1tDGqsEX86ZKuaFg97VfkQk9o0cd5fRbtd
         hVbvl7WcbNHVZ25dSYiki5SCuraWw9wqwIodgbHpWxi8p/tsw29y4lZjhLHj+nYmXp10
         XnWZU8dSX0MZrg0xG3kfV/8QbEZSCP5QadXg547UYf3b8hUjeH+yAGwszlbxQ6RDmQaw
         23azdzLcxXButHPP4Xt7P6qxs9hHe9BMGjtimH5JMo89Nk2MNvxjDahUkMjthPgdQCY5
         t/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lKrd8xIQOffLP51lnujhKxWIN9oB40aSwJMJKkXxTR8=;
        b=GZtxvDNY8V6YsudzZJIv2eq912rhtw3PAbDjkQByiTVKl4FSPpJ06s8rrHaU0RirMc
         3zBw52ZVr/2yvi7k+vP5AhObNJxHqevwcmoj619/kTTHWSxuIJeMg/YMZJaoqzqF99Zu
         I0Z0K96yofQWJ5r9eucTEhSPuOYxMlhxSi4Vfv7x2RnDd9hJJmW+r8lSHxLk9DMp99FC
         n4CLp7YgLrXK6c9Lt05Y+KBw+bTJwn/5n1ZjfyP3tE5fTW3Nr6+FMhX7MfqinKN6dQkC
         dVQpALSwuux6V4cTnPHUWVcuz154VQxlKK7/Mgr2viLdbsDrot42n7l/N27jUuIzw2xO
         PcYQ==
X-Gm-Message-State: AMCzsaW9s8dsqJLiL1w2BixhRxt8aCRZdV8Cijw7GXpqDCgzjLwz3FfO
        qd1Apvl5jVAgKW08fp7y/+trce2EskrC9iCoR5o=
X-Google-Smtp-Source: AOwi7QBTq8NoNgh1nWkgLcXQ5JpzMpDlf2KA9FZ1FRvY8EeCx675hy40NtR59PROP3uudg9UVGOVAi3hT6UiFV/ixUY=
X-Received: by 10.55.112.65 with SMTP id l62mr674617qkc.357.1506701309000;
 Fri, 29 Sep 2017 09:08:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.20.23 with HTTP; Fri, 29 Sep 2017 09:08:28 -0700 (PDT)
In-Reply-To: <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net> <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
 <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net> <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 29 Sep 2017 19:08:28 +0300
Message-ID: <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
To:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, gitster@pobox.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
Many thanks to all of you, I am interested in every opinion. Sorry
that I wasn't in the discussion, unfortunately I got sick, that's why
I skipped all the process.
I want to reply to the main moments and also ask some questions.

>> Simplify mru.c, mru.h and related code by reusing the double-linked list implementation from list.h instead of a custom one.
> An overlong line (I can locally wrap it, so the patch does not have
> to be re-sent only to fix this alone).
I've read only about 50 characters max in commit head (and
highlighting repeats it), but there's nothing about max length of line
in commit message. Sorry, next time I will make it shorter.

About many different opinions how to improve the code: I agree with
the idea that my commit is a middle step to get rid of MRU at all. If
we really need to add initializer/mru_for_each/smth_else - it's
absolutely not a problem, but as it was said, not sure that we need
it.
It really looks that using list implementation from list.h directly
won't be worse.

> I had envisioned leaving mru_mark() as a wrapper for "move to the front"
> that could operate on any list. But seeing how Olga's patch takes it
> down to two trivial lines, I'd also be fine with an endgame that just
> eliminates it.
Let's add needed function to list.h directly? I also wanted to add
list_for_each_entry function to list.h as it's in Linux kernel.
https://www.kernel.org/doc/htmldocs/kernel-api/API-list-for-each-entry.html
It will simplify the code even more, guess that not only in MRU
related code. Maybe we need to do that in separate patch.

About minor issues ( "tmp" vs "p2", variable scope, space indentation)
- fully agree, I will fix it.

So finally I think that I need to fix that minor issues and that's
all. I have plans to rewrite (with --amend) my current commit (I think
so because I will add no new features, so it's better to have single
commit for all changes).
As I understand, Submitgit will send an update in a new thread. And I
need to say there [PATCH v2].
Please correct me if I am wrong in any of the moments mentioned earlier.

By the way, other contributors write smth like "[PATCH v6 0/3]". What
does mean "0/3"? It's about editing separate commits in a single
patch, am I right?

Thank you one more time!
Olga
