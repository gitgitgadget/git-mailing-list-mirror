Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 279A01F453
	for <e@80x24.org>; Wed, 19 Sep 2018 02:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbeISHrO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 03:47:14 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42991 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbeISHrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 03:47:14 -0400
Received: by mail-oi0-f67.google.com with SMTP id v198-v6so3658715oif.9
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyE3HyGMclPKQ4iethDwfbM2EnKDoG+IQPm89FtYtIc=;
        b=q2G6gNcinwWhEnoW6ImNeznbNjtKXVw0KepvVmjOj96btz9WQBGS23KS1UBw59ppo2
         /DVwH564e3KI8w1vJa2ATvh4fzyVkmxkLf+qKW/sWmRvMIrizuIdVqprp6/NRWoGutnU
         rF1gIWaw6dHoUK0Rh9HEGjL0nQfQ2WZm3v9ETb7C/4AFBxuE/VQM45MoZVGWDtT//4eh
         qxrKNUiFRd0zd9thgi6orEg84NnDy+SIaxfonL3Sz1wko1jyTQpOIYMIIrq0QlGCSE6Q
         XFRdyAtYxewba2vTG/sYOS4b0IVbTpkl/4WN9s+z5Z81bZpiLNkxpsipUiEJRTAe9zss
         FOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyE3HyGMclPKQ4iethDwfbM2EnKDoG+IQPm89FtYtIc=;
        b=VcwKx526THSoqFC9k5qqlUfvz9jcygsnFA/6os8Eho38wPd8m1qMHzihe6RCvE5vw5
         z2HUCXbdVAOu9aaSS72OMUo+BFTgPIn6ZE+0qFsGnIeK8tOgIKq/EOOyhxzedtFXqbId
         +ReHTxZUwCs2j6AwTjwhvbXlaPVBaR4tabe0oez6+lamFcvX0wGaGNgowkomFF6VDqRU
         qoSe8WFNJ8QgphubHHw+P801SZS4QrPtwmGAEfO8zO8J4YL0A3A3F4nZVX2nR8ZOvUIx
         06biZ6tT638rbg/yu8UzhtJU1Xzt9tms+W9Y9XWfQv4SdT3cuBQQCdXNoV2PFhBox0Sx
         A7Vg==
X-Gm-Message-State: APzg51CnxDsA4y/8cBVqAJ3mjWb+GaYGsgZiTxRYa9dWkViXHZXLG2R8
        VN6fdb7saG6KhWu6ojkYjgYrHqgu1pNPrtyvGs6K
X-Google-Smtp-Source: ANB0VdZurAcr0mXJdheGY8YaC9xzdKJP+XG/k7r3tvTY085unJswiKZ/nZH8okRlhgI+03ZUfvM9lG+lpO/DwHjZzlY=
X-Received: by 2002:aca:c74d:: with SMTP id x74-v6mr301920oif.97.1537323106436;
 Tue, 18 Sep 2018 19:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <c625bfe2205d51b3158ef71e4bf472708642c146.1537223021.git.matvore@google.com> <CAPig+cSzddcS+8mx=GMbJ5BP+=fPtza+7UdA5ugN+83NuOHyiw@mail.gmail.com>
In-Reply-To: <CAPig+cSzddcS+8mx=GMbJ5BP+=fPtza+7UdA5ugN+83NuOHyiw@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 18 Sep 2018 19:11:34 -0700
Message-ID: <CAMfpvhKejvbgzwtTv93iqLG8fMxqZW_MRTAU0q9bDArqJU2zUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] CodingGuidelines: add shell piping guidelines
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 5:16 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Sep 17, 2018 at 6:24 PM Matthew DeVore <matvore@google.com> wrote:
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > @@ -163,6 +163,35 @@ For shell scripts specifically (not exhaustive):
> > + - In a piped sequence which spans multiple lines, put each statement
> > +   on a separate line and put pipes on the end of each line, rather
> > +   than the start. This means you don't need to use \ to join lines,
> > +   since | implies a join already. Also, do not indent subsequent
> > +   lines; if you need a sequence to visually stand apart from the
> > +   surrounding code, use a blank line before and/or after the piped
> > +   sequence.
> > +
> > +       (incorrect)
> > +       [...]
> > +       (correct)
> > +       echo '...' > expected
>
> Existing tests seem to favor the name "expect" over "expected", so
> perhaps use that instead.
>
>     $ git grep '>expect\b' -- t | wc -l
>     2674
>     $ git grep '>expected\b' -- t | wc -l
>     1406
Thank you for clarifying that out for me, but I'm not longer using
that example, so it's moot.

>
> > +       git ls-files -s file.1 file.2 file.3 file.4 file.5 |
> > +       awk '{print $1}' |
> > +       sort >observed
>
> This is not a great example since it flatly contradicts the very next
> bit of advice added by this patch about not placing a Git command
> upstream in a pipe. Perhaps come up with an example which doesn't
> suffer this shortcoming.
Done.

>
> I've seen the advice earlier in the thread of not indenting the
> sub-commands in a pipe, but I find that the result makes it far more
> difficult to see which commands are part of the pipe sequence than
> with them indented, so I'm not convinced that this advice should be in
> the guidelines. (But that just my opinion.)
I'm not totally sure either way, nor do I have a strong opinion. I
agree it's probably better to not codify this in the documentation
until there's a great reason to.

>
> > + - In a pipe, any non-zero exit codes returned by processes besides
> > +   the last will be ignored. If there is any possibility some
> > +   non-final command in the pipe will raise an error, prefer writing
> > +   the output of that command to a temporary file with '>' rather than
> > +   pipe it.
>
> It's not so much that we care about losing a non-zero exit code (which
> might be perfectly acceptable depending upon the context) but that we
> care about missing a Git command which outright crashes. So, it might
> make sense to make this text more specific by saying that ("exit code
> indicating a crash" and "Git command") rather than being generic in
> saying only "exit code" and "command".
Fixed.

>
> Also, what about expression like $(git foo) by which a crash of a Git
> command can also be lost? Do we want to talk about that, as well?
Yes, it's probably better to add a point about that. Here is the new
documentation after applying your suggestions:

 - If a piped sequence which spans multiple lines, put each statement
   on a separate line and put pipes on the end of each line, rather
   than the start. This means you don't need to use \ to join lines,
   since | implies a join already.

        (incorrect)
        grep blob verify_pack_result \
        | awk -f print_1.awk \
        | sort >actual &&
        ...

        (correct)
        grep blob verify_pack_result |
        awk -f print_1.awk |
        sort >actual &&
        ...

 - In a pipe, any exit codes returned by processes besides the last
   are ignored. This means that if git crashes at the beginning or
   middle of a pipe, it may go undetected. Prefer writing the output
   of that command to a temporary file with '>' rather than pipe it.

 - The $(git ...) construct also discards git's exit code, so if the
   goal is to test that particular command, redirect its output to a
   temporary file rather than wrap it with $( ).
