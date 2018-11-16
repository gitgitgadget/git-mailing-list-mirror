Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D82A1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 13:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeKPX3K (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 18:29:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbeKPX3K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 18:29:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so7973828wrb.2
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QZcIKQt8AiXdEtvlM6pdicuel1HOsdgfuIjYN0YDLQY=;
        b=AUq7be1liigIJTeTIkrTjku5vkBPqVbToGO36BKCIm5Xaf6o7yu6u5L3q0Cxtb+lHK
         PYak2CLd+aovJE54Tejbhvz+G3ySZmq357BCDHXIVVQ+8QnJDgy1p0phI5Sw4ojjyvci
         dcHSua/7TjISl7fyai2NmDVONtcQI/vVIgzuejikUw6kZ8h0bxK88Ir1QS/FV25Xxajc
         DCtF5Wy92wJ+BsJEVuJYLMYbhBA+j1REC7b7N8FiSRwnxkQCcvH175mycgVKWwP+a2v5
         xWdJAmzIIfj24zMM2dq1FY7jQq4qX/rDSxdSCf9FWLxVtbklpLwsEo3Ky6C7Lf7jyHEN
         AKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZcIKQt8AiXdEtvlM6pdicuel1HOsdgfuIjYN0YDLQY=;
        b=KVYh/bBVkNokB3wnqjtsL/YsQbUU6seF+JcFQFgUSqnS+9CjMdVqgPJ4BXvHP0yWJt
         aTYt/hiZR7agFoGc2NP1yufdtxxlz+F2JdjBovC8hXetWuVwQp2ltOFUK0KDzs6qxw2r
         nsND/ihBD9dH9zx0T1mTM3TfvIcQdYgnVSg4QRrnKLg11kxIl1jgThgwUOD0oOH49I8U
         2KBBA/w0g2o9OllUWBPXUsIfVA44+CGt/4BpzVmJyG6vNmBD2auM9LKX6q6C2nKejGkI
         7xCS4G3wWuuQAxcNVDCaVcmFplbdzwy4kJdFChL267M3Vq6916h7Nrx+dMlbUv9M3lgb
         gA6Q==
X-Gm-Message-State: AGRZ1gKfZh4BApPl7CowJg2h6EZOEn15BQfQIkS2AuYByhc3Lvo72+xS
        /mrnvhIXAZZ7pNq6zBHDpF0=
X-Google-Smtp-Source: AJdET5c9WuLyuJaioUNODIDr5nGtkizLD3L3zRNSPbpEY0XH8TSVlUqaLBUvutvnBrUx9g1xiz4xcQ==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr9399172wrp.242.1542374207395;
        Fri, 16 Nov 2018 05:16:47 -0800 (PST)
Received: from szeder.dev (x4db1f8e7.dyn.telefonica.de. [77.177.248.231])
        by smtp.gmail.com with ESMTPSA id j40-v6sm22594182wre.48.2018.11.16.05.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 05:16:46 -0800 (PST)
Date:   Fri, 16 Nov 2018 14:16:44 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a
 repository
Message-ID: <20181116131644.GM30222@szeder.dev>
References: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
 <20181114122725.18659-1-szeder.dev@gmail.com>
 <20181115093844.GA14218@sigill.intra.peff.net>
 <20181115094320.GA18790@sigill.intra.peff.net>
 <xmqq36s1libw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36s1libw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 02:09:07PM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Nov 15, 2018 at 04:38:44AM -0500, Jeff King wrote:
> >
> >> Is SOURCE_NONE a complete match for what we want?
> >> 
> >> I see problems in both directions:
> >> 
> >>  - sorting by "objectname" works now, but it's marked with SOURCE_OBJ,
> >>    and would be forbidden with your patch.  I'm actually not sure if
> >>    SOURCE_OBJ is accurate; we shouldn't need to access the object to
> >>    show it (and we are probably wasting effort loading the full contents
> >>    for tools like for-each-ref).
> >> 
> >>    However, that's not the full story. For objectname:short, it _does_ call
> >>    find_unique_abbrev(). So we expect to have an object directory.
> >
> > Oops, I'm apparently bad at reading. It is in fact SOURCE_OTHER, which
> > makes sense (outside of this whole "--sort outside a repo thing").
> >
> > But we'd ideally distinguish between "objectname" (which should be OK
> > outside a repo) and "objectname:short" (which currently segfaults).
> 
> Arguably, use of ref-filter machinery in ls-remote, whether it is
> given from inside or outside a repo, was a mistake in 1fb20dfd
> ("ls-remote: create '--sort' option", 2018-04-09), as the whole
> point of "ls-remote" is to peek the list of refs and it is perfectly
> normal that the objects listed are not available.

I hope that one day 'git ls-remote' will learn to '--format=...' its
output, and I think that (re)using the ref-filter machinery would be
the right way to go to achive that.  Sure, ref-filter supports a lot
of format specifiers that don't at all make sense in the context of
'ls-remote' (perhaps we should have a dedicated set of valid_atoms for
that), but I think it's perfectly reasonable to do something like:

  git ls-remote --format=%(refname:strip=2) remote

A concrete use case for that could be to eliminate the last remaining
shell loops from refs completion.

