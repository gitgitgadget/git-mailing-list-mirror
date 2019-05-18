Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACBA1F461
	for <e@80x24.org>; Sat, 18 May 2019 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfERShO (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 14:37:14 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37763 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfERShN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 14:37:13 -0400
Received: by mail-ed1-f49.google.com with SMTP id w37so16246933edw.4
        for <git@vger.kernel.org>; Sat, 18 May 2019 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=FlcOEz8wV69+Sbb5tEU2ewrcURpuCQH5tdVlISa5bcs=;
        b=EeMw/XEa0xeQM7pEJMS9V99hzG2OM8bhKItgKOdiiW4w9RHStbOCZTDtfmbTl269Gu
         Us/UwphXK40WVGOPtQgAFMY7cO1E6pyIfVOUdPju0HWTfD79vJwioFPGoG0R6NcULxih
         A6NgKgqbmMQ+arpTyGAMdgrOdD9csnBO8qJAxv4HJooKa0fMlS55e8ygygIWNuAFhEbJ
         MtkDUx7SDPbQ6dLG+DWLXM8aM6bVK9bRhg1e6OjaIi3sC0yvNBAKz65v83DpjPMMQSbS
         tJcFWPJ6FDklKEouBwA9b3inyEMUiO12tCfO4nHYt+zigY9FdA+vTsIleliWGIEjKk5+
         hXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=FlcOEz8wV69+Sbb5tEU2ewrcURpuCQH5tdVlISa5bcs=;
        b=Wrujc5HoNV9YrvbhznHDV3ba8JZliKMU37YTuefCLa4zWyTjZ3b1R08OC57ZIr1GyF
         DssigeP8vjNicnnu8fpjY1r7uJfm41kT/84E7mirWogQyx4QL7yHnW6Q5Uft7AvhOCl7
         ivcXJDZq7uaIbYclSoP/nW7DcQcjBG5FlWSxpH+6Qob6xYLlve0DZlqCbRWS4oH9TvOc
         s1DNUW5N9jziGjxZJLBPDG6ygWeVjQtqa4qftqeL3ISHdWV1ECd9ZHDqxxlJB1bg8rnU
         o+vTWIvZQIrWD4PBLEsi7B/5RV8L0fUcAbMcngje7otjbExQZFxG3k8nBSkg96XMmfvK
         nsSg==
X-Gm-Message-State: APjAAAVaIah//3UVt3sGKGx+Ag7t4KXlSbf2+FuspvOxa1vVBJ7Yl1AN
        PxVDBg5F6NjtqoMUjlgEPDk=
X-Google-Smtp-Source: APXvYqx7+QaVIVfThYijfK/tuNwwVkEfezdLYLHmQxcIXISbzZTAQwXn+ESW5+aYxhwlNR9rPhoKKg==
X-Received: by 2002:a17:906:843:: with SMTP id f3mr39917011ejd.70.1558204631924;
        Sat, 18 May 2019 11:37:11 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id w16sm1287633ejq.56.2019.05.18.11.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 11:37:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Command to list <pattern> Branches on a specific Remote (i.e. select from rtb's)
References: <dcdff07d-77c7-8cb8-fa06-82acda5fe9ec@iee.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <dcdff07d-77c7-8cb8-fa06-82acda5fe9ec@iee.org>
Date:   Sat, 18 May 2019 20:37:10 +0200
Message-ID: <87lfz3vcbt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 18 2019, Philip Oakley wrote:

> Hi,
> I'm unsure if there is a command for this.
>
> Currently I have 1600+ remote tracking branches (rtb) for my Git repo
> as it covers both git.git and git-for-windows and some other
> contributors.
>
> Finding a specific rtb for a particular remote looks like there ought
> to be a simple command ready to do the job, but I haven't found
> anything.
>
> Is there a command or simple simple invocation of branch, show-ref,
> for-each-ref, etc that can be give a branch pattern and remote name to
> quickly filter down the list of potential branches to just one or two
> 24-line screens?

That's:

    git for-each-ref 'refs/remotes/<remote>/<pattern>'
    git branch -a -l '<remote>/<pattern>'

The latter will conflate <remote> with any local branches you happen to
have prefixed with <remote>.

The reason this isn't some easy mode in some command is because there's
no hard notion that a given remote "owns" a given set of RTB's. It's
just convention, but they can and do overlap sometimes.

See the logic in 'git remote remove' that needs to decide if a deletion
of a remote should delete its remote tracking refs: 7ad2458fad ("Make
"git-remote rm" delete refs acccording to fetch specs", 2008-06-01)
