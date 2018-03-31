Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB571F404
	for <e@80x24.org>; Sat, 31 Mar 2018 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeCaTUN (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 15:20:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54574 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeCaTUM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 15:20:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id h76so19874689wme.4
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=NWPEL2n8dSZdRItqzPZAe8s8OOWBmyGph4bl9v3/Vrw=;
        b=Bkpve6gaxUy/HEugSMB2HaLlnMujoSf6k96xjx+rJ+soETbqKUEpLM6E3qIDUEmw8s
         kIT4Jjxr+o3yxMx7J52kDa37eQ4x5g5HhsXqMNrDcu6Iw0k6pRXK7N4XKpUqIs2xZ76N
         7GUQH0MJT1Ze3OrKvWHBf0ih4GP3WGQEblHQcIedtHCfCXkvT4VqM7pkH6tSk9YpTArJ
         F9R84BpCEX3Rdc5liv3cHgETKsgm1hBoa6CiQsl+o0OTJ69IeHFqGADFIsbAqf+WY968
         2+hMk6GyI75eMjb3JyGnk5bM95XiG4yqq++n+9dea+DljJbOwgRkoKDP1cJTG6aHLtMA
         SRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=NWPEL2n8dSZdRItqzPZAe8s8OOWBmyGph4bl9v3/Vrw=;
        b=O9k/7gqe7vpJ60ktFrO8S1HMlvYgorWSiuyIdrEQ9xqVvcQivi8dylzEIilwRqo37a
         EyTKSiyyK+puKD/UHKB8ec3VdOBJM3ElRi+L15F++WuKZJKE2Y3RTnSSOfiLsFKoWwhn
         elw2NBDHVAxBtYEreC5GMrUPnOOcSVgGpHchGNXZQPzLNWSEbaEAnsIImZT/GoPV/U0g
         kHRNkvsEJL4t0VSXbQTTWwxG05Dtp9dxGHOS2gtsCqq9vTVVI26JhI0IohIqh0beBhLN
         QQGWgIyLPyV2PcAOa3C0FVYXYVWFeA9GsWOXXeekWOmx9icmmyjSDvAOzdtxK/YXYzUm
         CNbQ==
X-Gm-Message-State: AElRT7Gb3smR8bFJN1QuXfzhoPYUTQ4HD+beZQarzzYnRz2ZNb0eCdBh
        6iLHSl8jY6FTrBYgEqfslek=
X-Google-Smtp-Source: AIpwx4+ZyyO2SUArYXmhZLqsKAiZQq7USB0R7/dn5ozXcdlDPmEtxqR+CnAiMuKeobsHOk+68t0TYQ==
X-Received: by 10.80.230.12 with SMTP id y12mr7164633edm.278.1522524011155;
        Sat, 31 Mar 2018 12:20:11 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id g24sm7509360edj.87.2018.03.31.12.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 12:20:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Fernando Vezzosi <fv@repnz.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180316101346.7137-1-phillip.wood@talktalk.net>
        <xmqq1sg27mwf.fsf@gitster-ct.c.googlers.com>
        <a8dd262b-8b0c-8632-bf28-e03f9405317f@talktalk.net>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <a8dd262b-8b0c-8632-bf28-e03f9405317f@talktalk.net>
Date:   Sat, 31 Mar 2018 21:20:09 +0200
Message-ID: <878ta8vyqe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 30 2018, Phillip Wood wrote:

> On 29/03/18 19:32, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Since v2 I've updated the patches to use '-' instead of '^' to invert
>>> the selection to match the rest of add -i and clean -i.
>>>
>>> These patches build on top of the recount fixes in [1]. The commit
>>> message for the first patch describes the motivation:
>>>
>>> "When I end up editing hunks it is almost always because I want to
>>> stage a subset of the lines in the hunk. Doing this by editing the
>>> hunk is inconvenient and error prone (especially so if the patch is
>>> going to be reversed before being applied). Instead offer an option
>>> for add -p to stage individual lines. When the user presses 'l' the
>>> hunk is redrawn with labels by the insertions and deletions and they
>>> are prompted to enter a list of the lines they wish to stage. Ranges
>>> of lines may be specified using 'a-b' where either 'a' or 'b' may be
>>> omitted to mean all lines from 'a' to the end of the hunk or all lines
>>> from 1 upto and including 'b'."
>>
>> I haven't seen any review comments on this round, and as I am not a
>> heavy user of "add -i" interface (even though I admit that I
>> originally wrote it), I haven't had a chance to exercise the code
>> myself in the two weeks since the patches have been queued in my
>> tree.
>>
>> I am inclihned to merge them to 'next' soonish, but please stop me
>> if anybody (including the original author) has further comments.
>>
>> Thanks.
>>
> Hi Junio, if no one else has any comments, then I think it's ready for
> next. I've not used this latest incarnation much but I've used the
> previous versions quite a bit.

First of all thinks for working on this. Something like this is a
feature I've long wanted to have and have just been manually using edit.

As for the code, one comment: For reasons of avoiding something like the
2.17.0-rc* bug I just sent a patch for, I think you should change your
use of the implicit $_ to something where you explicitly create lexical
variables instead.

It's bad style in Perl to use $_ for anything except a one-liner, and
similar to the $1 bug with your other patch, you'll get buggy code
(regardless of your use of local $_) if one of the functions you're
calling in these >10 line for-loops starts doing something to set $_
itself, as demonstrated by:

    $ perl -wE 'sub foo { local $_; for (1..3) { bar(); say } } sub bar { $_ = $_ ** 2; } foo()'
    1
    4
    9

Let's just name these variables, even if it wasn't for that caveat it
would still be a good idea, since for any non-trivial use of $_ you've
got to mentally keep track of what set $_ where, so it's hard to read.

As for the implementation, I *want* to love this, but it seems the way
it works is just fatally flawed, consider. *The* use-case I've had for
something like this (maybe yours differs?) is something where I do e.g.:

    $ perl -pi -e 's/git/Git/g' README.md

Which gives me (among other things):

    -See [Documentation/gittutorial.txt][] to get started, then see
    -[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
    -Documentation/git-<commandname>.txt for documentation of each command.
    -If git has been correctly installed, then the tutorial can also be
    -read with `man gittutorial` or `git help tutorial`, and the
    -documentation of each command with `man git-<commandname>` or `git help
    +See [Documentation/Gittutorial.txt][] to get started, then see
    +[Documentation/Giteveryday.txt][] for a useful minimum set of commands, and
    +Documentation/Git-<commandname>.txt for documentation of each command.
    +If Git has been correctly installed, then the tutorial can also be
    +read with `man Gittutorial` or `Git help tutorial`, and the
    +documentation of each command with `man Git-<commandname>` or `Git help

Which to me, is a perfect use-case for this feature. Here I
hypothetically want to change "git" to "Git" in prose, so I only want to
change that "If git has been" line, the rest are all references to
filenames or command names.

So I would manually edit the hunk via "e" to:

     See [Documentation/gittutorial.txt][] to get started, then see
     [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
     Documentation/git-<commandname>.txt for documentation of each command.
    -If git has been correctly installed, then the tutorial can also be
    +If Git has been correctly installed, then the tutorial can also be
     read with `man gittutorial` or `git help tutorial`, and the
     documentation of each command with `man git-<commandname>` or `git help
     <commandname>`.

Yay, but very tedious. Now let's use your feature to do this:

     1 -See [Documentation/gittutorial.txt][] to get started, then see
     2 -[Documentation/giteveryday.txt][] for a useful minimum set of commands, and
     3 -Documentation/git-<commandname>.txt for documentation of each command.
     4 -If git has been correctly installed, then the tutorial can also be
     5 -read with `man gittutorial` or `git help tutorial`, and the
     6 -documentation of each command with `man git-<commandname>` or `git help
     7 +See [Documentation/Gittutorial.txt][] to get started, then see
     8 +[Documentation/Giteveryday.txt][] for a useful minimum set of commands, and
     9 +Documentation/Git-<commandname>.txt for documentation of each command.
    10 +If Git has been correctly installed, then the tutorial can also be
    11 +read with `man Gittutorial` or `Git help tutorial`, and the
    12 +documentation of each command with `man Git-<commandname>` or `Git help
        <commandname>`.

    select lines? 4,10

So what I was expecting this to do was some automagic where it would
pair up the 4 line, and based on the removed/added count figure out
which line I'm also adding corresponds to that. I.e. both selected lines
are the 4th line removed/added, so it should transpose the 10th to the
4th, but instead I get a patch that looks like this:

    diff --git a/README.md b/README.md
    index f17af66a97..7234756e64 100644
    --- a/README.md
    +++ b/README.md
    @@ -18,9 +18,9 @@ including full documentation and Git related tools.
     See [Documentation/gittutorial.txt][] to get started, then see
     [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
     Documentation/git-<commandname>.txt for documentation of each command.
    -If git has been correctly installed, then the tutorial can also be
     read with `man gittutorial` or `git help tutorial`, and the
     documentation of each command with `man git-<commandname>` or `git help
    +If Git has been correctly installed, then the tutorial can also be
     <commandname>`.

I.e. it just grepped out the removed line from the removed chunk, and
the same for the added bit, which of course means that now the added
line doesn't get injected into the correct place, but added to the end.

I can see *why* that happens, but I can't imagine a case where this
behavior isn't useless.

What this seems useful for now is for chunks that only consist of lines
that are added or removed, maybe there's similar edge cases with those,
but I can't think of any, there I think we should do the obvious and
intuitive thing.

But I think that as this stands we really should at least disable this
where we present the user with a hunk that consists of both removed &
added lines, since I think the desired behavior I've described above
should be the default, and once we pick one we're going to have to
support it forever, so it's important to get it right to begin with.
