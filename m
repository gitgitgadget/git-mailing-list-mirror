Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE7C1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeCUT6i (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:58:38 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:46627 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbeCUT6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:58:37 -0400
Received: by mail-qt0-f174.google.com with SMTP id h4so6589305qtn.13
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ngHGIPwZSM5iUuQn14ybg1m+DzJ0a2Mro0WGzLJixHE=;
        b=g9TtN2JmF3miLSgp/QPEJw8M3dRN3tCvcvzCuWmEv/wycZR6UVUwRYetLF1xrJ2gfB
         EvunrTyT1lqGH6Qjr10l5y9hQia9etPRKQp2E0ES22erLyhyMvwLIlRgzWOl3Dqwmtnb
         It37O63CJQDbHnHBfJ3ViuYyEJIWyDra1i9bB9XJRWW1JlnyfzxgcEUjtbrvR87qkR7M
         Rd2j3j786y+gHDSDJDF+oUgjgfpyG7tQMzJcFHazx6I7WCWmTSfXcGdkJqXqy08vjREI
         G0oER2/H9hxFmkTtKtP2T7VsTBt2HXYUK7qbpAjONHD3myjB4JsQNLykmHMDCEXn/inN
         k5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ngHGIPwZSM5iUuQn14ybg1m+DzJ0a2Mro0WGzLJixHE=;
        b=N1bXXmBxWRTvyrQRlOCjhITyeAK1PsuhGa04nnOYHgtMcK6tgdB6LsUXTLz7MKi2an
         0LQxuesyJ5LIrFoA4bd3ImHpObbhua1y6hcV9DTPJY8sLx3+3JR5B7C4xDfp4hxnIMGm
         bFgSFB8ub9Z4h7fvxp0siO4o8OdX1YzvGltgLYpmTlvxCDN/OxvmLxdPQdw+4ChSTJSS
         gdXVsIfyICBfBgGIAMnBX14vrP4hvQ2/EEpJO9SLM/C+wWUaP+gHBlCjiNs2LO4UO2LK
         nuXJwL4ZRRzbA7SG7caVvxlHe3XFpZukfo5m1ZsIM02lx92U09JcEFEGjqu+7Xy+i3MV
         +KyQ==
X-Gm-Message-State: AElRT7FUAnoohoPjqyLQf6xQQ+3b4HkYGunmfFCDiOsZHK2ZbdmRkEEl
        yIT5037Vro9kNLuQ+nomfVjGgoTQfZWR4ybb1pAioA==
X-Google-Smtp-Source: AG47ELuz9m3KvChI4ZFOnkQ5BZY73TBrxK+P7v6R9TZqSid7m9cBzFlnv0ksKAQOg8E2t9ehe54jptrYAKEkJ4is7Bk=
X-Received: by 10.200.42.37 with SMTP id k34mr16045869qtk.101.1521662316648;
 Wed, 21 Mar 2018 12:58:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Wed, 21 Mar 2018 12:58:36 -0700 (PDT)
In-Reply-To: <xmqq4ll9p6oq.fsf@gitster-ct.c.googlers.com>
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
 <010201624428199f-b4b3d8ce-222f-4966-9171-7fcf932ca220-000000@eu-west-1.amazonses.com>
 <CAPig+cSxGgG=1k95j+n4DZHBdtN++7F6_U5fu0gOcjwwPQ5GZw@mail.gmail.com>
 <xmqqh8paqt0f.fsf@gitster-ct.c.googlers.com> <CAPig+cQ0cq9-cYuw8AJpk6maeT-T25SJDhWpb4TyN8rQJmP=xg@mail.gmail.com>
 <xmqq4ll9p6oq.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Mar 2018 15:58:36 -0400
X-Google-Sender-Auth: Ht_z52UM3JVwM0UMrC-SX95-WUk
Message-ID: <CAPig+cQZOjFuAHXqj6c8oP8JJaboLf3kL9heMA=jkXssr+gQ_Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] ref-filter: get_ref_atom_value() error handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> strbuf_error() was a possibility proposed in [1], and it does take a
>> strbuf. Failure to pass in a strbuf here is just a typo.
>
> I've seen it; I just thought it was a joke and not a serious
> suggestion.
> A macro or helper function that is local to the file might be OK,

My thought all along was that this convenience helper (in whatever
form) should start life local to ref-filter.c, and only be published
more widely if found to be generally useful. Unfortunately, I forgot
to state so explicitly when writing the review. Suggesting the name
strbuf_error() didn't help to convey that thought either. My bad.

> but I do not think "strbuf_error()" is a useful abstraction that is
> generic enough in the first place (the questions to ask yourself to
> think about it are: Why should it be limited to return -1?  Why
> should it be limited to always do the addf() to a strbuf?).

There is some precedent in the existing error() function. As with
error(), as a _convenience_ function, it does not necessarily have to
be universally general. That it simplifies a reasonably large body of
code may be justification enough, despite it shortcomings. I don't
feel strongly about it, though, and, as noted above, agree that it can
be local to ref-filter.c.
