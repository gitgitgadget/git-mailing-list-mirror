Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B2320248
	for <e@80x24.org>; Fri, 22 Feb 2019 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBVSTn (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 13:19:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33681 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfBVSTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 13:19:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so3406174wrw.0
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 10:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rc8pbOKIu20bob77isG55CoglVbaMD8vkBWZhTGT92I=;
        b=lPbqsTIHEtl6aHKJ0CqfSzKpbRu4JqzrFRvU7JNE99Thy3LJdZFiigT/rDLAizfwTs
         MYw8qxq5fThgJIP1OrlRtoO2aJ8HOt0gdBhhhFxAUXInHiIFxr+mMQ0PDZeQzWlSxJVK
         YJHR6UagpxLxsS6ef/DFj0d+RClMWU6HJi7nPSPzRFkaEv3oY+AxfrWkiXcQz/AdSVE3
         D6VnSKP3n5oAcOBhc0+LARICt+JgCrwJlJCGRJApB1FIXjNjqpFk49U1hbas//sps44C
         y9Mn79vU7RxdKv7obUWHIhSO/VsKze0CENx5dxtwy07sNfGXJzpDxDjHZ0pvmHqWex9G
         6brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rc8pbOKIu20bob77isG55CoglVbaMD8vkBWZhTGT92I=;
        b=d1s1YV5QERVNNopQ3LHOePYSc0zbzs3ZN4VOGAGL6RbyJXqfl16Of5NnezdvCpU0i1
         i4YwQtiVGqj/WgPLk8hBpcPxiGA/gXrytNhdVOFkiog+RnraCB/DKUlEqN43vrAzPR1T
         WHhx9vgy/9XszV8nw95jtR4RUYrOYzCP64rCGkEsj79VqAf6Hd63L8BWnV+CoO3XocCV
         Y7ql8kgpPnrNQLEblPUtaZIPguqPQ+6NdfrObI4tMXmALMjRdpXjkFWpcR5bmSR1RMgE
         9m6irVlQMe3X9RYl/VvbAUF/yBpiCA95X5l9Pdy5Pp75ytAZ4f/M2L7Z056cNa+19aR9
         sxKQ==
X-Gm-Message-State: AHQUAua/nbNdW9i18kg1CvXTRnZIssLpoPv+1I8nmIasa4BEuhU0c9Ml
        fjGcIBQXTxEuXTEkY4i1cDg=
X-Google-Smtp-Source: AHgI3IaGJOu0a/gTVAZLE4Tay4nRFJ/pfPYy/ea6bu7mKF1+wfYQvh7OYf9YZqUAdej97R4FLMprEg==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr3898887wre.215.1550859581043;
        Fri, 22 Feb 2019 10:19:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u134sm2341405wmf.21.2019.02.22.10.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:19:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Ideas for even more compact fetch.output=compact output
References: <20190125095122.28719-1-pclouds@gmail.com>
        <875ztc5evt.fsf@evledraar.gmail.com>
        <CACsJy8DJvxuhVJBpgTNiFHt+0ZOFqm4agvxrJfa2D1jvDojaRQ@mail.gmail.com>
Date:   Fri, 22 Feb 2019 10:19:39 -0800
In-Reply-To: <CACsJy8DJvxuhVJBpgTNiFHt+0ZOFqm4agvxrJfa2D1jvDojaRQ@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 22 Feb 2019 17:05:56 +0700")
Message-ID: <xmqqftsfr8hw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> If we had this:
>>
>>     From github.com:git/git
>>        a7da99ff1b..28d0017056  next                -> origin/*
>>      + e911e946c2...9cc6aca6e9 pu                  -> origin/*  (forced update)
>>        a7da99ff1b..28d0017056  refs/[pull/412/head]  -> origin/*
>>      + 1dbcd06490...6b1f08d3ef refs/[pull/412/merge] -> origin/*  (forced update)
>>      + e911e946c2...9cc6aca6e9 refs/[pull/444/head]  -> origin/*  (forced update)
>>      + 8131760e3b...ed5bbbbcec refs/[pull/444/merge] -> origin/*  (forced update)
>>
>> We could de-duplicate such output. I.e. used [] as "capture" delimiters
>> for the subsequent "*" since "[" and "]" aren't valid in ref names (but
>> "()" and "{}" are!).
>
> First impression, I think the square brackets makes it harder to read
> the left column.
>
> I was going to suggest coloring, which could be used to highlight the
> common parts. But I think that would mess it up even more because it
> kinda steals focus.
>
> Another option is simply display refspec on the right hand side, e.g.
>
>  refs/pull/412/merge -> refs/*:origin/*  (forced update)
>  refs/pull/444/head  -> refs/*:origin/*  (forced update)
>  refs/pull/444/merge -> refs/*:origin/*  (forced update)
>
> This keeps the right column boring and mostly the same without losing
> meaning, while the left column is left untouched. It does make you
> think a bit to find out what the actual ref on the right hand side is
> though.

None of the above, including the existing "origin/*" lets people cut
and paste the left-hand-side (which is what is available locally to
them) to a command line, e.g. after seeing

     From github.com:git/git
        a7da99ff1b..28d0017056  next                -> origin/*

you cannot append "origin/next" after "git log .." with a few
mouse-clicks.  As the actual object name after the update appear
with the double-dot, "git log ..28d0017056" is also hard to create
without dragging a7da99ff1b part from the output.

Having said that, I do not do pointy-and-clicky cut&paste myself, so
it would not bother me that much and any of these "compaction" ideas
may be OK.  Using the refmap notation would start bothering people
for perceived repetition of that right-hand-side, though.
