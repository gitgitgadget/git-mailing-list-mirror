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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C74720248
	for <e@80x24.org>; Tue, 19 Mar 2019 09:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfCSJaV (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 05:30:21 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39498 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCSJaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 05:30:21 -0400
Received: by mail-ed1-f49.google.com with SMTP id p27so15947480edc.6
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/8cf63QLEIMIzNudnR7/kSAVW7Q12nTInGmOkTzoZPQ=;
        b=XkwqnzbutLLp1gQzMFm0sj00zcJpPPD0cTbTEesDzijZeGWqaw5uphiNN4OF5imcGW
         BvHPox+7cGYRFYjPhOskQUKkG6Fxk2gStCO2LuA/rs2Lx/nEFnz6mnMNnLU+7psq6lmw
         swc5N3VIBjtr3t1CQNXKHnLH5sx11bwphOAlaIlRRZ6T7H57hHJdwkZSakapxWAU2yQa
         iR8DvgkUpQZZYqupGQ2x5Uq/n04t2yEYUX0ieAnlxevXelOuPctQ+0b5iRQIg+/n4Vin
         QKQacNTo9t3DU29Yx03NZLCPvY/ogrv4N6AT3EApBsLnKypmi50HcnYaxxEUeNfb+CU9
         0gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/8cf63QLEIMIzNudnR7/kSAVW7Q12nTInGmOkTzoZPQ=;
        b=gP3Urd+sNaa5uvaFZ4UtYEdJHAXBzWgFR9phfa2t5hrv8ce6pAxwfjuJhgKv92kSF7
         Q/68lNj9gIfXHlZr7FqUnpgrFobZfjStHpjqoDA+q5uoyVWYhNsm1da+dYNGZju03EYp
         kbFnBDjYgftFWHkjoxdKh/B2n4U4rXDdoxMPUu8h1ODHUkzYJtaNZUSxZJ6nIdYZ0w+O
         gZrIy7Cd3cKbuhdIis07/syrB01yD4yNQEOvkFFbnQshggbRHeVBoY2QrZCbQkBOfk0x
         I8N8ZZV0hOT0JeTKNdWFOhs+Kyrcebexjn5cKeceP/Fz1vRS65vG95Dwi2Lt8luKQaIf
         /1vQ==
X-Gm-Message-State: APjAAAXEJN4PaPfuV+soyG9uTHIIiwVdb977xR3eFKBCovxpfQyhw2mB
        j5O2WSuysjxwOifZ1l49D2uAFZUUaBY=
X-Google-Smtp-Source: APXvYqxV1N/exi9I2Vu2T7ZrRnag6QyL7pNYX9wW0BzAEFZsNlPHZvQXHMe/mnm9CguGvSTvSuXohQ==
X-Received: by 2002:a50:86e8:: with SMTP id 37mr10134743edu.192.1552987819354;
        Tue, 19 Mar 2019 02:30:19 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id x45sm4218262edb.42.2019.03.19.02.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 02:30:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mikko Rantalainen <mikko.rantalainen@peda.net>
Cc:     git@vger.kernel.org
Subject: Re: Improve support for 'git config gc.reflogExpire never'
References: <39a0796a-7220-1e81-e7fe-3bf7329ed7de@peda.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <39a0796a-7220-1e81-e7fe-3bf7329ed7de@peda.net>
Date:   Tue, 19 Mar 2019 10:30:17 +0100
Message-ID: <87a7hrdxee.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 08 2019, Mikko Rantalainen wrote:

> If I configure bare repo with
>
> git config gc.pruneExpire never
> git config gc.reflogExpire never
>
> then git will never garbage collect any commit ever stored in the repo.
> This is what I want.
>
> However, all commits referenced only via reflog are kept as loose
> objects and will not be included in packs. In long run this will cause
>
> warning: There are too many unreachable loose objects; run 'git prune'
> to remove them.
>
> and the performance of the repository will slowly decrease.
>
>
> If I have understood correctly, git should notice that reflog will keep
> referenced commits forever and include all those commits in packs
> instead of keeping those as loose forever.
>
> A more generic behavior might be to always compress all loose commits in
> (one?) special pack so the performance would stay good even if
> gc.reflogExpire is very long instead of "never".
>
>
> Discussion about this case:
> https://stackoverflow.com/questions/28092485/how-to-prevent-garbage-collection-in-git
> https://stackoverflow.com/questions/55043693/is-it-possible-to-get-git-gc-to-pack-reflog-objects

Just to add to Jeff's E-Mail, the case he's describing is something I
wrote a stand-alone test case for here:
https://public-inbox.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/

Try to run it, it's probably the same behavior you're seeing, and it has
nothing per-se to do with reflogs.
