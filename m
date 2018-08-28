Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473BB1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeH1RmH (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 13:42:07 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53781 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeH1RmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 13:42:07 -0400
Received: by mail-wm0-f54.google.com with SMTP id b19-v6so2016746wme.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/sd2nsFGPtFR6d/QaHLlTDnS5ntkJojNdEQ3pTShV/c=;
        b=Fj6skKpUBgV194ojbUzkNTB4fF0kbDsucY89xEb/v5Hr5hJ7BgFOgSy5jVlWX4E7dJ
         fI4Dj/PjL2gkQfW855wvdqAfqWaUowbKPCpJOIegRnAUJNwFzuGcm+2AbqjYpeAJz2cA
         DDIaaPuFfBSQlCbVMXd0JktBXpQ4YZzy0BQr4S4EhNv5HNvkLRZkS9r0q2mpuaHV+wxj
         MaqSoVgOM05QEsyDgYGL7nPLoGMhIdC3nR4YcL/1XtOfW9jjQww+ApcKvM9Tbu4iaIS+
         NUK7i8rreKnUMyqYa/HDlXmvUZaZ7xV9j2kku+syG/+DbDs7Y1b8wF6XgT6yLC2b0U8l
         7Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/sd2nsFGPtFR6d/QaHLlTDnS5ntkJojNdEQ3pTShV/c=;
        b=EdzoSOGNGkhTtNpCLiSVpgx0GligRZCok2cWfyQVgMYX82W4eEy+s4DNvdwhlqmzR9
         jaW0S9SsBqt8ulZCLdPJQm63ZV8WRWIgt0itZUVtaI7++VOVrWFKtRgizpLc15Rkdr+v
         OtyabtQTlgAzBoiJX51jNfF4Xa2J0BzKgyQCjeepvCHddp/5ocEKJFlgAsRkMb/6UYuP
         83yXvLGqN88uRmsoJmjdK+zbt5e8WG+K5amJJb8UMoO68KpkvD9m74Tkf43OPrpOAwZI
         sU1Y9RtuWY8XDzfXpIfETnMowIawwAbr2EM8uyj+Q8ZIjypbG2aFzPyF875C0SRa8PVO
         Hd5Q==
X-Gm-Message-State: APzg51CECslIqs2wmQ3Kxptjev1MposiJXrarqDG1aPqvYu0cTAwJel2
        m4swn+LaS1w+2AEgYEhQPqaoxluhuHs=
X-Google-Smtp-Source: ANB0VdahNc4wpfmsSKY3fHxkqhTjWm+xangMy82Iu7kCK1Gl/YJs4RJA9hxAX2S8FNtVZUgFRFxa9w==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr1473150wmd.92.1535464219141;
        Tue, 28 Aug 2018 06:50:19 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id z3-v6sm897086wmf.12.2018.08.28.06.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:50:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
References: <878t4xfaes.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <878t4xfaes.fsf@evledraar.gmail.com>
Date:   Tue, 28 Aug 2018 15:50:17 +0200
Message-ID: <87h8jeeh2e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 23 2018, Ævar Arnfjörð Bjarmason wrote:

>> Transition plan
>> ---------------
>
> One thing that's not covered in this document at all, which I feel is
> missing, is how we're going to handle references to old commit IDs in
> commit messages, bug trackers etc. once we go through the whole
> migration process.
>
> I.e. are users who expect to be able to read old history and "git show
> <sha1 I found>" expected to maintain a repository that has a live
> sha1<->sha256 mapping forever, or could we be smarter about this and
> support some sort of marker in the repository saying "maintain the
> mapping up until this point".
>
> Then, along with some v2 protocol extension to transfer such a
> historical mapping (and perhaps a default user option to request it)
> we'd be guaranteed to be able to read old log messages and "git show"
> them, and servers could avoid breaking past URLs without maintaining the
> mapping going forward.
>
> One example of this on the server is that on GitLab (I don't know how
> GitHub does this) when you reference a commit from e.g a bug, a
> refs/keep-around/<sha1> is created, to make sure it doesn't get GC'd.
>
> Those sorts of hosting providers would like to not break *existing*
> links, without needing to forever maintain a bidirectional mapping.

Considering this a bit more, I think this would nicely fall under what I
suggested in
https://public-inbox.org/git/874ll3yd75.fsf@evledraar.gmail.com/

I.e. the interface that's now proposed / documented is fairly
inelastic. I.e.:

    [extensions]
        objectFormat = sha256
        compatObjectFormat = sha1

If we instead had something like clean/smudge filters:

    [extensions]
        objectFilter = sha256-to-sha1
        compatObjectFormat = sha1
    [objectFilter "sha256-to-sha1"]
        clean  = ...
        smudge = ...

We could apply arbitrary transformations on objects through filters
which would accept/return some simple format requesting them to
translate such-and-such objects, and would either return object
names/types under which to store them, or "nothing to do".

So we could also have filters that would munge the contents of objects
between local & remote (for e.g. this "use a public remote host for
storing an encrypted repo" that'll fsck on their end) use-case, but also
e.g. be able to pass arguments to the filters saying that only commits
older than so-and-so are to have a reverse mapping (for looking up old
commits), or just ones on some branch etc.

It wouldn't be any slower than the current proposal, since some subset
of it would be picked up and implemented in C directly via some fast
path, similar to the proposal that e.g. some encoding filters be
implemented as built-ins.

But by having it be more extendable it'll be easy to e.g. pass options,
or implement custom transformations.

We're still far away from reviewing patches to implement this, but in
anticipation of that I'd like to see what people think about
future-proofing this objectFilter syntax.
