Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4E71F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 23:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeK1Kqt (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 05:46:49 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45473 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeK1Kqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 05:46:49 -0500
Received: by mail-ed1-f44.google.com with SMTP id d39so20520603edb.12
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 15:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=O1MEQdFobvR1thBo+RxsvvDBzRve3ansEa6JxOGcoZI=;
        b=JJp06H3klJYQzaI7rrUiuftQtOWQDZyOMe025TxYDBxna9O3uKEmW51xuHGNf7xxIu
         bd2Dk6tvJjie7Y6SMnz/ThwhZkQ6EVu8KwTgYF+/3MMfRWy5IT/WfewQQahY1tZSTvjp
         5CXebqU2MMWjXv9vMiVajKSmApKV4DAaAjhdkH0fcHUPQr4bh/ibsGm7K9dKq6Rgh7c9
         hrT4utS1fJywuuPJG6tr8r9xPBlvPaGZ0fpcGH5NkqHwAPASCbbpX8d7THBryIvkqLiK
         fOB6uy3Rpd5fCp4hZZefpJYj2OHLmVFVTqBbTeRHcCuqGpNI8yhf6AMyUbnIT4NhIkwY
         Co8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=O1MEQdFobvR1thBo+RxsvvDBzRve3ansEa6JxOGcoZI=;
        b=XH1rd5NxOfc8PPKKq6FuJIvlghEQwfxhNowapnG++2E7Bk+Gv1081lFB+upuaNrVyX
         hWNuwOAcsVSmUklAuwepiuydLWRYTIhrg5M0nK5zwsQ625QmeGfK50YCQNb8GJYj5OzD
         hKrKOAnlyeQBrcgbEuqKs5ssukNMLhk0uvCfh3Zc2CN7aI3pBZ6ki1KXE4xEy4oMMIcu
         nI8OtENm2Fu8ajIwDGDwJ4BkKJg3OE+6kDBW5H3esVZ9bI2lWPkbmDmSpv4qMIJprDXR
         3Bu+W5FgMhRCNDz4VgnSjE/NoxKL5ptZHOm0ZyfgJcLmWpfXw3pHaooBaSpCC5KEKgix
         Be6Q==
X-Gm-Message-State: AA+aEWbjEwDyWgGo5NitQFIX2q7u/ZFOQg0VvyuYxZ4oghaR5uXOux7k
        cDvdiUopMA01Zq3rQLPZ2RXWC8Z0
X-Google-Smtp-Source: AFSGD/XAKvJGkOmchMFKB9y36FPl5yMe9MASa2p5zpCgPd/apMysOumdVOniQCbYXRq5RnkcaBAmyg==
X-Received: by 2002:a50:a974:: with SMTP id m49mr11240881edc.220.1543362435243;
        Tue, 27 Nov 2018 15:47:15 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id w13sm1396727edl.54.2018.11.27.15.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:47:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Forcing GC to always fail
References: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com>
Date:   Wed, 28 Nov 2018 00:47:12 +0100
Message-ID: <87efb6ytfj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 27 2018, Bryan Turner wrote:

> Something of an odd question, but is there something I can do in the
> configuration for a repository that forces any "git gc" run in that
> repository to always fail without doing anything? (Ideally I'd like to
> make "git reflog expire" _also_ fail.)
>
> Background: For Bitbucket Server, we have a fairly recurrent issue
> where administrators decide they know how to manage garbage collection
> for our repositories better than we do, so they jump on the server and
> start running things like this:
>
> git reflog expire --expire=now –all
> git gc --prune=now
> git repack -adf --window=200 --depth=200
>
> They then come running to us with their corrupted repository expecting
> and/or hoping that we can fix it (often without proper backups).
>
> Bitbucket Server itself never runs "git gc" (or "git reflog expire").
> We've configured how reflog expiry should be handled, but of course
> that's overridden by explicit command line options like
> "--expire=now". We _do_ run "git pack-refs", "git repack" and "git
> prune" (with various options), so those commands need to continue to
> work.
>
> Is there anything I can set, perhaps some invalid configuration
> option/value, that will make "git gc" (most important) and "git
> reflog" (ideal, but less important) fail when they're run in our
> repositories? Hopefully at that point customers will reach out to us
> for help _before_ they corrupt their repositories.

You could fix this and so many other issues by just hanging up a "Is
This Good For The Company?" banner up in Atlassian offices .

But more seriously:
    
    $ stahp='Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc' && git -c gc.pruneExpire=$stahp gc; git -c gc.reflogExpire=$stahp reflog expire
    error: Invalid gc.pruneexpire: 'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc'
    fatal: unable to parse 'gc.pruneexpire' from command-line config
    error: 'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc' for 'gc.reflogexpire' is not a valid timestamp
    fatal: unable to parse 'gc.reflogexpire' from command-line config
