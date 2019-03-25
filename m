Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9263E20248
	for <e@80x24.org>; Mon, 25 Mar 2019 23:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfCYXVc (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 19:21:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43739 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCYXVc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 19:21:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id v32so12453996qtc.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tnb/nOTfqQQBxeMhPw973EDZ+o7K/dbjkfnmmHzUbwo=;
        b=EzDh1qMdJgWukiNzOF+GPd4ltS84NB8dvRp1Lk5pHLWqnoKRU4QN52Q+48/w8bzN/X
         gdpveLX2Sx54xCHFfvs5irh/VXA1cU6/wUCsQvfQWaINpebtN6WrU5W7oPbq0DLgEGM6
         DWlk/CVlDqxPipi+0jYsz19Bm4h5uVmwN8v+im8r+5yULk0T3o8JuDCYNQRFW4B2TTLd
         Qe7qS2nS4gGA/2ayWN9PeH4I8fvfUUcL/cZexpxIc9UyIujL1ZSP8ihjLupHe/Ywbsbb
         CWoyK+9Ov3s1cKa/YpPrhdsc6r12D0FIQa3GH6lEOgUPUw4wkMRGl57PafQQTjUZNqaa
         m1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tnb/nOTfqQQBxeMhPw973EDZ+o7K/dbjkfnmmHzUbwo=;
        b=m63gy1dLfah+kgJDDaT8emHShuYGW0hvrIHFXA6Hb3bImMFb1Jo5OZonlRmfaj5cxL
         6LA1JDKe0qkz/XRtk0MYQKWwvBoz8+1aK04auwduMJN6WQz7X3wv9NAyi08vXz+8MZ+K
         IkOFJvoe1UTLOK26Kh8c+clQPJL7UgXDVI4y7+9MOoue4JFBA3Saz98f+FD624B2eWs1
         gomxdbbrWfnAGp0/1ZmzgmP+dSwx49oheO/nhz+aaKQxJ8zW3KkcIrLkxo6qQ5xm4LfO
         s+d92QRkrTcqaCNJ2z/cH9mXFypjKjORzfiVdSzHz0O2RpY6zYXrdCCtMi6H4aYwFVT4
         un9A==
X-Gm-Message-State: APjAAAXbYqPO5qQ9tSGTBFb776VKhL8yk3KKozVQg8bAE5oEdQBS67xb
        aThRWoPfEXPKwo2Egyaln6uYGoE40VBQx3OdTGtGA+jN+JE=
X-Google-Smtp-Source: APXvYqw33phOWtKc9hKfQr1EcEX06df1KG6g7blbd1oc1kYGpCgbJxOIwd75rG1cZ54ZooJ0MeGBDg+sISIf4MNMDtk=
X-Received: by 2002:ac8:2297:: with SMTP id f23mr22372206qta.348.1553556091010;
 Mon, 25 Mar 2019 16:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190324235020.49706-1-michael@platin.gs> <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com> <b077afed-d143-506e-977e-6edf2492f75f@google.com>
In-Reply-To: <b077afed-d143-506e-977e-6edf2492f75f@google.com>
From:   Michael Platings <michael@platin.gs>
Date:   Mon, 25 Mar 2019 23:21:19 +0000
Message-ID: <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Barret Rhoden <brho@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Barret,

> I work on a project that needs a major reformatting, and one thing
> delaying me was the lack of an ability to ignore commits during blame.

I think we understand each other well then - I'm working on a plan to
change the variable naming rule in LLVM, and naturally other
developers aren't keen on making git blame less useful.

> One question I have is under which circumstances do you find that you
> cannot match a suspect/child line to a parent?  One obvious case is a
> commit that only adds lines - the parent's line set is the empty set.  I
> think you catch that earlier in your code (parent_chunk_length == 0),
> though I guess there are other cases where the parent has lines, but
> they are below a certain match threshold?

Yes, exactly. The threshold is currently 0 i.e. a single matching
bigram is all that's required for two lines to be considered matching,
but in future the threshold could be configurable in the same manner
as -M & -C options.
In the t8020-blame-fuzzy.sh test script in my patch, where it's
expected that a line will be attributed to the "ignored" commit you'll
see "Final". So far this is just "}" lines.

> Another question was whether or not you wanted this to apply per commit
> or for an entire blame session.  It looks like your current code applies
> it overall, and not for a specific commit.

This is a really interesting question for this feature. Initially I
just wanted to be able to say "Hey, Git, ignore this revision please."
But then Git says "OK, but how exactly? I can ignore whitespace and I
can detect moves & copies so do you want me to do those?" And then I'm
thinking, actually yes -M10 would be great because I know that this
revision also reordered a bunch of #includes and I still want people
to be able to see where they came from. However other sets of options
might work better for other changes.

On looking at the problem this way it seems that fuzzy matching
belongs in the same class as -w, -M & -C. As these options apply for
an entire blame session, it would be consistent to allow applying the
fuzzy matching likewise. As a bonus, having the ability to apply the
-F option for the entire blame session seems quite nice for other use
cases.

> I'd much prefer it to be per-commit

Yes, we definitely need a way to say "fuzzy match this commit only"
otherwise you lose the ability to detect small but significant changes
in other commits.
I haven't explored this fully, but I'm thinking that the revision
options file might look something like this:

# Just use the defaults, whatever they may be
6e8063eee1d30bc80c7802e94ed0caa8949c6323
# This commit changed loads of tabs to spaces
35ee755a8c43bcb3c2786522d423f006c23d32df -w
# This commit reordered lots of short lines
c5b679e14b761a7bfd6ae93cfffbf66e3c4e25a5 -M5
# This commit copied some stuff and changed CamelCase to snake_case
58b9cd43da695ee339b7679cf0c9f31e1f8ef67f -w -C15 -F

For the command-line, potentially we could make -w/-M/-C/-F specified
after --ignore-rev apply to only that revision e.g.:
git blame myfile --ignore-rev 35ee755a8c43bcb3c2786522d423f006c23d32df -M -F

But as I say, I haven't explored this fully.

> For those cases where you can't find a match, I could imagine marking
> them as unblamable.  The purpose of 'unblamable' in my patchset was to
> signal to not bother looking up further commit info for a final blame
> entry.  It was largely so that the user (me!) wouldn't see a commit
> blamed when I explicitly told git to not tell me about that commit.

I can see how the unblameable concept makes sense for the heuristic
you have right now. However, once you have a heuristic that can tell
you with a high degree of certainty that a line really did come from a
commit that you're merely not interested in, then I suggest that it's
better to just point at that commit.

> Both approaches sound fine though.

:)

> The first thing that comes to mind for me is to plug your fuzzy logic
> into my patch set.

Please do! It should be easy to pluck fuzzy_find_matching_lines() and
its dependencies out. Just to set your expectations, I have not yet
optimised it and it is highly wasteful right now both in terms of time
and memory.

> But maybe we need more info for your function.

The extra info needed is the parent & child file content, plus the
indices in the strings of where new lines start. This information is
already calculated in the course of doing the diff but it looks like a
fair amount of plumbing work will be needed to make the information
available to the chunk callback. That was my reason for initially
plonking the fuzzy matching in a separate pass.

Thanks,
-Michael
