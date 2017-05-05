Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D303D207B3
	for <e@80x24.org>; Fri,  5 May 2017 17:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdEERaA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:30:00 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34085 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdEER37 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:29:59 -0400
Received: by mail-pf0-f180.google.com with SMTP id e64so5670700pfd.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yOZFOrpKzYU9VJmtDllx+/ZmG78xkzqWxZbBA6Etb1c=;
        b=CAyxNcli0lyig1sgULya5DXq3Pa0B3ntQE6VYY/NBW5LhiDWPU0aU7UaETy49PyYy/
         vFNjVo9QLhfu2oLb1Fuvogj1Oftb7dxMTgyVqOc7AKc1Ejd30eZnLwgv8xmpKAdcWb6U
         GktiMhkXhWL6KjQcomb4UxY9okXypjnb7SQEj0jawD2dN52FXGDHO9BXbQkuKkBTFFzu
         ZpF+NWGtl7boeEWqv1KP6mkuosLp6O67ii+UeB8SZyD5orO2891E1FHRgW20/qnTPWCp
         AGr0BD/gW8+VgOJwgzwWz4exC8zXmNqf/1kmkj6uiAh7jF1Lohyi5yPMmjaNN/51jEVn
         1BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yOZFOrpKzYU9VJmtDllx+/ZmG78xkzqWxZbBA6Etb1c=;
        b=pcEkRcKcMUu4RYRKI93/zaGZfKwzK9GDaq/cLUzAkUfy6p3JIH2UyJpUWFjVzk8lb3
         b6IYSGYEWIi1Go8lrCpQXYSS7DU343fOXU+gIOLaguQsNRY0/ODvHoKUH+0vKvko13m1
         hTHPmEB98hTJyYcvYRQi/TXtlOCuLGpraZv1cfXFO1jAGIZgFlJm3XtT4xGclCms8dg0
         MiXA2EqRZG5NPAp3I1xxXMYlATIj/Nj21xyzw3rEZTckRxSgaNP4UnMynIL1pElwDbXO
         Yby/dcLpNtNGkZm4c4v8LEQh+KPfUDbcJLUQb0pdbVt/m0eLGUGf4tjs1AiSSHAy3IIj
         ePCA==
X-Gm-Message-State: AN3rC/5w6jNYvf4sE50zv6ohG6Fx3HwFTlbVZfn+zpZeA45/5Kmd74lP
        RL1Vwn7O4GTZfnJL
X-Received: by 10.84.175.67 with SMTP id s61mr66094248plb.43.1494005398674;
        Fri, 05 May 2017 10:29:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d18:25e6:8c0f:28a2])
        by smtp.gmail.com with ESMTPSA id q64sm14677374pfi.69.2017.05.05.10.29.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 10:29:57 -0700 (PDT)
Date:   Fri, 5 May 2017 10:29:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Start of a journey: drop
 NO_THE_INDEX_COMPATIBILITY_MACROS
Message-ID: <20170505172956.GB55152@google.com>
References: <20170501190719.10669-1-sbeller@google.com>
 <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
 <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
 <20170504191927.GB15203@aiede.svl.corp.google.com>
 <xmqq8tmb8bhu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tmb8bhu.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > That is, one way to do what this series attempts would be the
> > following:
> >
> >  1. rename variables that shadow the_index.
> 
> No question about this one.  It is a good thing to do.
> 
> >  2. add coccinelle patches (or one coccinelle patch) to
> >     contrib/coccinelle implementing *_cache -> *_index migration.
> >     Is there a way to do this without making it fail "make coccicheck"?
> 
> Quite honestly, I do not see much value in this, but take it merely
> as my knee-jerk reaction.  The only scenario I can think of in which
> dropping *_cache() macros is an improvement as the end result is
> when our goal is to completely drop the singleton index_state
> instance, aka "the_index".  I actually think that it may be a
> worthwhile goal to eradicate "the_index".
> 
> I wonder if somebody can take a small example codepath and make it
> not to rely on the existence of "the_index" from start to end?  Have
> an instance of index_state on the stack of cmd_foo(), have it call
> read_index() into it where it currently calls read_cache(), update
> the support functions it calls so that it can pass the pointer to
> its index_info throughout the callchain, and see how involved the
> necessary changes of all of the above are.  Start from something
> simple and small, e.g. "ls-files".  The infrastructure code updated
> for such an experiment may be NO_THE_INDEX_COMPATIBILITY_MACROS
> clean.

I've mentioned elsewhere but I've been working on this for 'ls-files'.
There's quite a few "gotchas" but its given me a good idea of which
sections of code need to be converted to taking in a
'struct index_state'.  I'll send some of this conversion out later today
as a RFC and see what people think about it and if its worth while to
continue.

-- 
Brandon Williams
