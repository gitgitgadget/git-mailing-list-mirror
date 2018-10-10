Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3A21F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 13:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJJUlh (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:41:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37278 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUlg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:41:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id y11-v6so5712045wrd.4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jvBnijs8DWQjTJ/Cs/c9lNG1lFJOuYYCWoh+/r8RY4Y=;
        b=eH5VOMdS0Zk3C7URt6lxgHTzTjOuGkMutfQfdnoNsmXU2E5mUhSuBplPnuRCC1pKAT
         pNRZc/1L0oCb9Ge52hMZmaJMxk/ouZ6hVW47fsPt4UsMKKGwTRNNJTYEnso4ut51YKdD
         w+sOw0MQJYVKibghe25kyEtPZZ8/F6US5vFi58gpN8mnrwihZDdlB/ulop6Xum8UQIRg
         FcXhyIlBEONVXDDPjxHRanftzl+hSi8G1CxsWXxpBL5w82QXUK8yKoLYPtIRR7lf5iHo
         bHTx7W0rOmi4Ng5X/wFEFyfeCT+mkACQpxe1KlDpqnaWCplHNYm+zeoTJ0ayUU07jY5+
         TO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jvBnijs8DWQjTJ/Cs/c9lNG1lFJOuYYCWoh+/r8RY4Y=;
        b=BBpT3nAv4lGtedf4YbnQSEsTzfVrsn0iTl9EurKM9IEQDXEHsyH+h4OT5pzevoBaeJ
         eq3u0tN7XnEaLnI+GaLdZfJ6N3PNNLfk7mt7itVb8ImQv+jYK8+9l6UFpBcSmW9zKAXX
         RdfKQCM4HfCfH+GLbfNkRqLlpaaKMlRGtYjmJ+L/5r8VmvQoJbK094zcUb1JtqHpUmdO
         pZ+rgquIGX+CgDzEReDn31bYuDCfcaoiFhaLd3iS4IAOqbASrsjvcfg5q5YWqiouKPmh
         i6R/kfLWjIix2qSmhdsW4FJtugKrrYZapEdwQJfZfGbtu92lOzga88GHvk4zLIVjgvuZ
         YN9g==
X-Gm-Message-State: ABuFfognPjEFHX9sI00veT736z1oM5wnV9hnnsGebI9R+E2/7C2y4jgQ
        VxhccUp2hXKbxBN+FxNBM+s=
X-Google-Smtp-Source: ACcGV60LSte1wRDIs5ml3REYZOXeg3Qb6vVdnWnXn1g07DEXnqRJdnjbAe7IidF5Tt5eyAcP3LBvng==
X-Received: by 2002:adf:f2d0:: with SMTP id d16-v6mr24870136wrp.258.1539177566027;
        Wed, 10 Oct 2018 06:19:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d16-v6sm15366174wru.88.2018.10.10.06.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 06:19:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: builtin stash/rebase, was Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810101203571.2034@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Oct 2018 22:19:24 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810101203571.2034@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 10 Oct 2018 14:57:35 +0200
        (DST)")
Message-ID: <xmqqmurmkkgz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Speaking about the two `rebase` ones: they are simple fixup! commits,
> could I trouble you to fetch and cherry-pick them into `pu`, or would you
> prefer if I sent another iteration of `rebase-in-c-4-opts`?

If it were only about me, then the former if I can do my own pace is
easier.  If you promise that you won't complain if a few commits
lose the amlog notes by accident when such tree mangling is done,
that would be even better, but I'd be careful anyway.

I'd rather limit number of changes not seen on the list that come
into my tree, so it is likely that I'd parrot these fixup commits or
result of "commit --amend" to the list if we take that route.

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 10 Oct 2018, Junio C Hamano wrote:
>
>> We haven't seen much complaints and breakages reported against the
>> two big "rewrite in C" topics around "rebase"; perhaps it is a good
>> time to merge them to 'next' soonish to cook them for a few weeks
>> before moving them to 'master'?
>
> I would be in favor, as long as the fixup patches I have in Git for
> Windows made it in:
>
> https://github.com/git-for-windows/git/commit/6bc7024aecdb1aeb2760c519f7b26e6e5ef21051
>     fixup! builtin rebase: support `-C` and `--whitespace=<type>`
>
> https://github.com/git-for-windows/git/commit/1e6a1c510ffeae5bb0a4bda7f0528a8213728837
>     fixup! builtin rebase: support `--gpg-sign` option
>
> https://github.com/git-for-windows/git/commit/ddb6e5ca19d5cdd318bc4bcbb7f7f3fb0892c8cc
>     fixup! rebase -i: implement the main part of interactive rebase as a builtin
>
> https://github.com/git-for-windows/git/commit/2af24038a95a3879aa0c29d91a43180b9465247e
>     fixup! stash: convert apply to builtin
>
> It seems that Alban picked up the `rebase -i` one, but the other three
> have not made it into `pu` yet (the two `rebase` ones are really my fault,
> I did not yet find time).
>
> Speaking about the two `rebase` ones: they are simple fixup! commits,
> could I trouble you to fetch and cherry-pick them into `pu`, or would you
> prefer if I sent another iteration of `rebase-in-c-4-opts`?
>
> Ciao,
> Dscho
