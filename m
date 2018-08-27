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
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D071F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH1AcQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 20:32:16 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37051 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbeH1AcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 20:32:16 -0400
Received: by mail-wr1-f44.google.com with SMTP id u12-v6so259519wrr.4
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hBMfn8mtJ1zNzxfuxhlLIL4Zl3nP2wuNM3TWu06XLMI=;
        b=ZzRVWb0ug5l29BGPhdnr2o292ZV1mstjc+hLg4U2P5JBJMMdenXK4hVjmscO135Yfc
         oQ1CZDrcqyiHWQJrcWjtKJAHp5DZh/jrj5lSg9aYBohVmdosFoi018kWPdDA/KR32F5a
         0LZxgU3/AN7wW9HscfFGjWDzTn130YVwjeO1sEmBGtMPI0T/+d33k6oFhT0xtAS6zh9y
         U52YMYx8jVmGePDRp/k5CkCRTa5g7lGjIwL3pxOxRJ1jeG81ruaNxcwyw9nhKit5oFgS
         Qrmiipdm4wMtCwCg7w2UwODwxwGiI9b7ThCSaFookik5V/Pgg6hdJXZkn7YNSRbYP3bU
         CvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hBMfn8mtJ1zNzxfuxhlLIL4Zl3nP2wuNM3TWu06XLMI=;
        b=fNJVXRoYjdUdpyV4K8AEPhOnBEIA/LKah1CXbTGxZTXdpvVudn6cbYL8IoSl0PTs0/
         egmWwhM7ah3adv9Z83ZBFqpIqGU8VgalsRSiHyaOALfyIGbzh2wlp4BayiieQ7ZgMRLO
         L4CQBPG80vzhVM8v3baXj4IB8fbxgYcbAxyLG0W3tbYB8a7lIvEQFVWLgRY+jX/kHcX3
         djBHRzBUTOurCMXGSjQIKDq96wQvCgG7rBM1DGGWQinrCwpjm6bvQMIQdI84BSo8N52J
         Hc/AiSVheSh0oykLNvekKWkQKUarX+p3d+qXS269sY7RiENOYgNrTiQ037XMPMq2ExK7
         2tXQ==
X-Gm-Message-State: APzg51By1Y+9KfIAx0QezR3EoroRtg6nCmh6g7400CCq14AsJpfL05b9
        yHoPiyYVQcDON/JMVajCgno=
X-Google-Smtp-Source: ANB0VdaRKqhWJnNAHrZyNqfCX3bOytt01qM+yYOPkRrBNn1zSf1psUOCTxkGxOXMwfbNVMTBDwQbbA==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr10093667wrq.156.1535402641640;
        Mon, 27 Aug 2018 13:44:01 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id c8-v6sm179422wrp.33.2018.08.27.13.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 13:44:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Cons?= =?utf-8?Q?tantin_Wei=C3=9Fer?= <i7c@posteo.de>
Subject: Re: Would a config var for --force-with-lease be useful?
References: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
        <xmqqin3vk3yv.fsf@gitster-ct.c.googlers.com>
        <87o9dnegxi.fsf@evledraar.gmail.com>
        <xmqqlg8rinbz.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqlg8rinbz.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 27 Aug 2018 22:44:00 +0200
Message-ID: <87k1obee0f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 27 2018, Junio C Hamano wrote:

[Scott, I hope you're still with us despite your recent attempt to
unsubscribe from git@ :)]

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> This was after/during a long discussion starting with:
>> https://public-inbox.org/git/CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com/
>>
>> It appears the only patch that got in from that discussion was my
>> f17d642d3b ("push: document & test --force-with-lease with multiple
>> remotes", 2017-04-19) (https://github.com/git/git/commit/f17d642d3b)
>
> Thanks for pointing at the old thread.
>
> As far as our documentation is concerned, the invitation to improve
> the situation, offered in "git push --help", is still valid:
>
>     Note that all forms other than `--force-with-lease=<refname>:<expect>`
>     that specifies the expected current value of the ref explicitly are
>     still experimental and their semantics may change as we gain experience
>     with this feature.
>
> But I do not think (and I did not think back then) there is a magic
> bullet to make the lazy force-with-lease automatically safe for
> everybody, so it may be time to declare that the lazy force-with-lease
> was a failed experiment and move on, with a patch like the one
> suggested last year in the message:
>
>    https://public-inbox.org/git/xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com/

With the benefit of hindsight I still agree with my counter-argument to
that in https://public-inbox.org/git/8760f4bmig.fsf@gmail.com/

I.e. making plain --force-with-lease harder to use by hiding it behind a
config option gives the user fewer options than with --force to recover.

So I think we should still recommend the longer and even safer variants
of --force-with-lease, but being guaranteed to have the SHA-1 you just
clobbered locally is *better*, and allows us to e.g. do this:

    $ git push --force-with-lease
    hint: You just clobbered <X> on <remote with <Y>. If you regret
    hint: this you can (until the object gets pruned) do:
    hint:     git push <remote> --force-with-lease=<refname>:<Y>

Or, doing the same with --force with some config option to use the
marginally safer (because at least you have a local copy)
--force-with-lease automatically.
