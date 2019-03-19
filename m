Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F9620248
	for <e@80x24.org>; Tue, 19 Mar 2019 00:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCSAnu (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 20:43:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41459 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCSAnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 20:43:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so19081311wrs.8
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GOnj+HYKu1YTCmYnifA1FW3S40Nr2rS6rvG7B+ERDoI=;
        b=hd30IiUaMF9AEuKzW47SjT5fCHcI91XJUSrqB9QPE7+oTb1KiI00nxUG7UlaR5tZeH
         QVWsAOR52j9o7mriJWvG/KHQP3mQWOypAm4ryWy9lTwqRvVecsooQXnXGNPwh52vvZOd
         fXAa3+LeskeU+wNHrvOLNpNn5JIdFeZS59hHYfXeLle6GBFkS7z6iVl+GzjWtqmYP8Xs
         3wsjoQ7x7Zl5PHqRCZtagkTYOo6BDIjeVF6F7UUveoTMPQVBN7SAdyxSjVl8bFb4bjCu
         mnz39eyLgOnp3krR9GkRBsm6Ly/jwj6V/1OXKJ/iko4r+NCT74pisPjpZ9kTWuP5plT3
         w1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GOnj+HYKu1YTCmYnifA1FW3S40Nr2rS6rvG7B+ERDoI=;
        b=rrwBG0hYN+6WsQGg62xrMSrgqTJhSSMCxEKQ8+EaKF/6r7OVuHLCCoUpsGsKFWT5Jb
         I5hvzxC94On4OEiZAFYCbKNE1AZhi8sDknOTWWBnWzFp4+3HkNk69ZT6GMho6hhq1/MC
         SbOTtQQX0laJCprrlqa9Kal4SvPhY2iY6PMkAt8zI8UdPNMpze2GtLuns1asEcHkH9jD
         QRbQFOND7RiYGJ3IMJu8dIGjmzCs0jTieptOq6sDKgZYOgcZYRqX5kR89KaVVdAZRgDc
         KTRayvHDwXWApeai+b+0MHcyzZughbEuDQ7mrh448YkIDenQaMS3TqguK4J/hBdUMhM5
         PDTA==
X-Gm-Message-State: APjAAAXKufz5T4VuLuq7J74L611D5MAO4Sy8Hp1AwG7rh8v+D5RFzka6
        h6AK474r03lmOTr9+JKUwpk=
X-Google-Smtp-Source: APXvYqx1uI3S37C5WbtUK5c73aLVPSkkTQCPl1+SzCQMDEllXN1TqdJ/N6OPloEOgWPsqFVNuavQ3w==
X-Received: by 2002:adf:eecb:: with SMTP id a11mr7276403wrp.23.1552956227657;
        Mon, 18 Mar 2019 17:43:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z12sm10867119wrt.10.2019.03.18.17.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 17:43:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eckhard =?utf-8?Q?Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v4 00/26] Add new command 'switch'
References: <20190308095752.8574-1-pclouds@gmail.com>
        <20190317124926.17137-1-pclouds@gmail.com>
        <CACsJy8BevFGXt-RL_1G263ntXYee69N055TY8_GQL1unvJNPnw@mail.gmail.com>
        <xmqq4l806avp.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B+VmwygpxWQ9Ug=L8bQXDVX7h6MjJwVU1cR2sbuHo6qQ@mail.gmail.com>
Date:   Tue, 19 Mar 2019 09:43:46 +0900
In-Reply-To: <CACsJy8B+VmwygpxWQ9Ug=L8bQXDVX7h6MjJwVU1cR2sbuHo6qQ@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 18 Mar 2019 19:13:11 +0700")
Message-ID: <xmqq4l7zzoal.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Mar 18, 2019 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>> I often find "git reset --hard <some other starting point>" after a
>
> It still bugs me that I need to use this to abort some in-progress
> operation.

Note that my comment was *NOT* about aborting the in-progress "am".
What happens in that "I often find" situation is that I identify the
problem's origin, prepare a branch to apply a fix forking from an
old release point that includes the origin, and "am" tells me the
code diverged too much and it cannot be applied, or "am -3" tells me
that the author sent the patch based on some unknown base.  At that
point, I "git reset --hard" to some plausible place the author would
have based the patch (e.g. "master" pushed out last night) and then
say "am" or ("am --no-3") to retry.

So your response is unrelated to what I said, but having said that,
it still deserves a comment.

> ... There's "git X --abort" but I would need to find out what X
> is first. I would like "git abort" or something (and "git continue")
> but haven't really thought that through yet. That direction may also
> lead to "git undo" which is another can of worms.

I rarely had "what was I doing" problem; doesn't the command line
prompt tell you?  It is debatable (and I am pessimistic) if a
general blanket "git abort" makes sense, but the info on the current
status (i.e. "what was the user doing?") it must gather should be
a strict superset as what is needed to give useful info in the
command line prompt, so a good place to start may be to think about
what's missing (not shown) in the prompt and if that is deliberate
omission (avoiding overly verbose prompt) or is coming from lack of
enough information.  Then we may need to do something about the latter
by teaching these commands with state to leave more clue of what we
were in the middle of and what the next step would be.

After thinking about that, the answer might turn out to be to unify
the backend of these commands with state to a single one, or at
least fewer ones, so that we can have better grasp and control over
how these backend engines record state when they give control back
to the user.


