Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3901F404
	for <e@80x24.org>; Tue, 27 Feb 2018 00:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeB0ACh (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 19:02:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38803 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeB0ACg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 19:02:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id z9so20386656wmb.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 16:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DNrKbXnanIiAdau+Simv9R3ENFCiHLPgTs5XkVQSg3g=;
        b=EoHsGhkIqX7NjZJr3IjXSWm3Mc02/8Ix2Si+sjg4OJyK/cNEBZ0V5FsrehQPkGsM98
         MvHX98ZvxAGtvRiBIOpmhIhnrTjCNcI53ys589Jp14sSMawOADYhNbIEE9vOrey7zCvm
         gokwKC4HP+qNTVYl7JHhsBfyFDhpQfshfnATpeV1gynZeQaQ9ewetBumVFy/L72n7eju
         lRYrlgH9UzTMMd85Hkn6RZDiqdeqmNYxstkQUhWErTr4Goqnv4pZXhHbV6lN8JKqlmFv
         fRL9MQaUUe4XF/132qEWwbbK7XDVFrgGNXUpQNuTVIT9QNZcJchnPtdm+88IIYaDYQzY
         lOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DNrKbXnanIiAdau+Simv9R3ENFCiHLPgTs5XkVQSg3g=;
        b=CS8a7DlH3j3BOvazOEZw44yrALimfeIHkAyKGaIo+YIvRq+4iWjTcShEkCl+nqXJJ/
         L4PS89BvSVc0QOoYc7wAH51kBst3hpOnk0fBEIYz+oEH0n8zld4oQPXTSStTQt5GZTtk
         pHLDI+JYU18GTeHozKlpIRnJBzO34cnaXxh8yujKKOpdzWG8FktbqOlnijZNbvSsVZOk
         AOyqd/fkhqHEN1jE3NsXuR/wKl71J/Cxz7c9F6YVNNy8O0N5x+kA7GcLiH70iBOCyHNm
         C5Lvii9DcDiHEvuxmPZn+4aEFIvLrBtLLUcEfNN9ePKSeuqlG/Tfnczvivp/WDxj533K
         AyHQ==
X-Gm-Message-State: APf1xPD5H9FWcgsSXOXxHGqmO92IxXP38ngr5KIfA8dDazY/S3HeFr8X
        22o6GuCFoEIQGPQwNZ1Yg/g=
X-Google-Smtp-Source: AH8x227jVPBGGQHVUdMrvN9vgYsxmPE57Px+66lvpvK5gWeROktBcnhKXbinAzeFtUk6/KiWC3Vr/w==
X-Received: by 10.80.142.27 with SMTP id 27mr16979024edw.127.1519689754943;
        Mon, 26 Feb 2018 16:02:34 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id n2sm8697761edl.74.2018.02.26.16.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 16:02:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        stolee@gmail.com, git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-14-bmwill@google.com>
        <20180222094831.GB12442@sigill.intra.peff.net>
        <20180223004514.GP185096@google.com>
        <20180224040149.GA16743@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180224040149.GA16743@sigill.intra.peff.net>
Date:   Tue, 27 Feb 2018 01:02:32 +0100
Message-ID: <87inaje1uv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 24 2018, Jeff King jotted:

> On Thu, Feb 22, 2018 at 04:45:14PM -0800, Brandon Williams wrote:
>> > Does the client have to be aware that we're using wildmatch? I think
>> > they'd need "refs/heads/**" to actually implement what we usually
>> > specify in refspecs as "refs/heads/*". Or does the lack of WM_PATHNAME
>> > make this work with just "*"?
>> >
>> > Do we anticipate that the client would left-anchor the refspec like
>> > "/refs/heads/*" so that in theory the server could avoid looking outside
>> > of /refs/heads/?
>>
>> Yeah we may want to anchor it by providing the leading '/' instead of
>> just "refs/<blah>".
>
> I actually wonder if we should just specify that the patterns must
> _always_ be fully-qualified, but may end with a single "/*" to iterate
> over wildcards. Or even simpler, that "refs/heads/foo" would find that
> ref itself, and anything under it.

I agree that this is a very good trade-off for now, but I think having
an escape hatch makes sense. It looks like the protocol is implicitly
extendible since another parameter could be added, but maybe having such
a parameter from the get-go would make sense:

    pattern-type [simple|wildmatch|pcre|...]
    ref-pattern <pattern>

E.g.:

    pattern-type simple
    ref-pattern refs/tags/*
    ref-pattern refs/pull/*
    pattern-type wildmatch
    ref-pattern refs/**/2018
    pattern-type pcre
    ref-pattern ^refs/release/v-201[56789]-\d+$

I.e. each ref-pattern is typed by the pattern-type in play, with just
"simple" (with the behavior being discussed here) for now, anything else
(wildmatch, pcre etc.) would be an error.

But it allows for adding more patterns down the line, and in
e.g. in-house setups of git where you control both the server & clients
to make the trade-off that we'd like a bit more work on the server
(e.g. to match dated tags created in the last 3 months) by setting some
config option.

The discussion upthread about:

> The other problem with tail-matching is that it's inefficient on the
> server[...]

Is also something that's only true in the current implementation, but
doesn't need to be, so it would be unfortunate to not work in an escape
hatch for that limtiation.

E.g. if the refs were stored indexed using the method described at
https://swtch.com/~rsc/regexp/regexp4.html tail matching becomes no less
efficient than prefix matching, but a function of how many trigrams in
your index match the pattern given.
