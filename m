Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D46208E9
	for <e@80x24.org>; Sat, 28 Jul 2018 12:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeG1OH2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 10:07:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52078 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbeG1OH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 10:07:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so8108171wma.1
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=x1GQASeiCAC7HISX70cdDvD8MXyBHF9g4s2/OENne2k=;
        b=LnpqYOHOtc4rYu/7tD/W9MGyPRkllLfx86Zan6zNDqpgeqy3RrbJb+bHJ5DOndDn8I
         n+tjR71g3rZ0DsJpjGt+Qb5xsZuVlxmgN4bOlFLRzBGbluTDqbgxz235z/TeGuof3P7s
         IGwFJgLaI8cV7QObjMQrIEk4gt1Ntx8bOhLUmqFsjp6mVZjg2NZ/Q6pJjYRjjrqPhJv5
         SlUs9n5MCkDZieKgUqDAHADHtHVMrgMgjpz+iUqsBlig7v4FZ4tvE4YLw9BoeF9/LzOe
         E2Rf2cmfd/GT9QUHWbk9IH6lzAb82pGzVZvkW6mN1oz+KqFA6sK1OWgPNWW0MMrGZk/Q
         ZEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=x1GQASeiCAC7HISX70cdDvD8MXyBHF9g4s2/OENne2k=;
        b=I+nnc7O+w6U/W/uJ2MyY0Xcp5p20JDxf4neC5oue7kxNz6lz4BTHlUtULyZctqsdkk
         hmeaMH/1nwZTM/PfiLqfDBrHRow5NFmOGJ6O1WmCAcNH4WibJ0Vj5CS25U7vJkmnGLKc
         RsYE8UD847LD2IYlVJFTvsjQbI28PqIzq9n4eS9M6XASLB6rY/5uSvYOjYFsODt5j2mp
         YLIz9483l2jHL945ufLOJqcEH7c7lBsuTk0P5AwhTwBzV/8abCTv7Kpud1tkRxsidwEH
         w84tUzoytiWGX+w7NzNfUJ07HW08FAkEjU0x7w0XhAPutQ/DMr35czj5h5gPCcvEaC8F
         Zy5Q==
X-Gm-Message-State: AOUpUlHVtBtSXo4nbtKTfW3B+oHzP3XhI2eO+eVNSIFMCZ4ZIUbNLkcp
        fd1nTGlCmsbo9195aG4neBI=
X-Google-Smtp-Source: AAOMgpeR0TAXtK1okJK09YRjnGw1P+7I42xzKV+yqtcjU1WFtPjobA7mfqp89T8tHFHWmsZYwmGatQ==
X-Received: by 2002:a1c:1bc8:: with SMTP id b191-v6mr8101647wmb.10.1532781661605;
        Sat, 28 Jul 2018 05:41:01 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id m13-v6sm9449303wru.93.2018.07.28.05.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 05:41:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v5 0/4] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net> <20180726155854.20832-1-phillip.wood@talktalk.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180726155854.20832-1-phillip.wood@talktalk.net>
Date:   Sat, 28 Jul 2018 14:40:59 +0200
Message-ID: <874lgjv8h0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 26 2018, Phillip Wood wrote:

> Unfortuantely v4 had test failures due to a suprious brace from a last
> minute edit to a comment that I forgot to test. This version fixes
> that, my applogies for the patch churn.
>
> I've updated this series based on Ævar's feedback on v3 (to paraphrase
> stop using '$_' so much and fix staging modified lines.). The first
> patch is functionally equivalent to the previous version but with a
> reworked implementation. Patch 2 is new, it implements correctly
> staging modified lines with a couple of limitations - see the commit
> message for more details, I'm keen to get some feedback on it. Patches
> 3 and 4 are essentially rebased and tweaked versions of patches 2 and
> 3 from the previous version.
>
> This series is based on pw/add-p-recount (f4d35a6b49 "add -p: fix
> counting empty context lines in edited patches")
>
> The motivation for this series is summed up in the first commit
> message:
>
> "When I end up editing hunks it is almost always because I want to
> stage a subset of the lines in the hunk. Doing this by editing the
> hunk is inconvenient and error prone (especially so if the patch is
> going to be reversed before being applied). Instead offer an option
> for add -p to stage individual lines. When the user presses 'l' the
> hunk is redrawn with labels by the insertions and deletions and they
> are prompted to enter a list of the lines they wish to stage. Ranges
> of lines may be specified using 'a-b' where either 'a' or 'b' may be
> omitted to mean all lines from 'a' to the end of the hunk or all lines
> from 1 upto and including 'b'."

I tested this with an eye towards what I pointed out in
https://public-inbox.org/git/878ta8vyqe.fsf@evledraar.gmail.com/

Using the same workflow (search for "So what I was expecting" in that
E-Mail) this now does the right thing in that example:

    select lines? 4,10
    [...]
    $ git diff --staged -U1
    diff --git a/README.md b/README.md
    index ff990622a3..6d16f7e52b 100644
    --- a/README.md
    +++ b/README.md
    @@ -20,3 +20,3 @@ See [Documentation/gittutorial.txt][] to get started, then see
     Documentation/git-<commandname>.txt for documentation of each command.
    -If git has been correctly installed, then the tutorial can also be
    +If Git has been correctly installed, then the tutorial can also be
     read with `man gittutorial` or `git help tutorial`, and the
    u git ((49703a4754...) $) $

Some other comments on this:

1) It needs to be more obvious how to exit this sub-mode, i.e. consider
this confused user:

    Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,l,?]? l
    select lines? ?
    invalid hunk line '?'
    select lines? q
    invalid hunk line 'q'
    select lines? exit
    invalid hunk line 'exit'
    select lines? quit
    invalid hunk line 'quit'
    select lines? :wq
    invalid hunk line ':wq'
    select lines? help
    invalid hunk line 'help'

Just doing Ctrl+D or RET exits it. Instead "?" should print some help
related to this sub-mode showing what the syntax is, and how to exit the
sub-mode. I think it would make sense for "q" to by synonymous with
"RET", i.e. you'd need "q<RET>q<RET>" to fully exit, but I don't know...

2) I think it's confusing UI that selecting some of the lines won't
re-present the hunk to you again in line mode, but I see this is
consistent with how e.g. "e" works, it won't re-present the hunk to you
if there's still something to do, you need to exit and run "git add -p"
again.

I think it makes sense to change that and you'd either "e" or "l" and
then "n" to proceed, or continue, but that's per-se unrelated to this
feature. Just something I ran into...

3) I don't see any way around this, but we need to carefully explain
that selecting a list of things in one session is *not* the same thing
as selecting them incrementally in multiple sessions. I.e. consider this
diff:

    @@ -1,3 +1,3 @@
    -a
    -b
    -c
    +1
    +2
    +3

If I select 1,4 I get, as expected:

    @@ -1,3 +1,3 @@
    -a
    +1
     b
     c

And then in the next session:

      @@ -1,3 +1,3 @@
       1
    1 -b
    2 -c
    3 +2
    4 +3
    select lines? 1,3

Yields, as expected:

    @@ -1,3 +1,3 @@
    -a
    -b
    +1
    +2
     c

But this is not the same as redoing the whole thing as:

    select lines? 1,4
    select lines? 1
    select lines? 3

Which instead yields:

    @@ -1,3 +1,3 @@
    -a
    -b
    +1
     c
    +3

Now, rummaging through my wetware and that E-Mail from back in March I
don't see how it could work differently, and you *also* want to be able
to select one line at a time like that.

Just something that's not very intuative / hard to explain, and maybe
there should be a different syntax (e.g. 1:4) for this "swap 1 for 4"
operation, as opposed to selecting lines 1 and 4 as they appear in the
diff.

4) With that abc 123 diff noted above, why am I in two sessions allowed
to do:

    @@ -1,3 +1,3 @@
    1 -a
    2 -b
    3 -c
    4 +1
    5 +2
    6 +3
    select lines? 1,4
    select lines? 1,4

To end up with this staged:

    @@ -1,3 +1,3 @@
    -a
    -b
    +1
    +3
     c

But not allowed to do the same thing in one operation via:

      @@ -1,3 +1,3 @@
    1 -a
    2 -b
    3 -c
    4 +1
    5 +2
    6 +3
    select lines? 1,4,2,6
    unable to pair up insertions and deletions

But I am allowed to do e.g.:

    select lines? 1,4,2,5

To end up with:

    @@ -1,3 +1,3 @@
    -a
    -b
    +1
    +2
     c

I can do this in two steps.
