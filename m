Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7751FC44
	for <e@80x24.org>; Tue,  9 May 2017 01:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbdEIBtW (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 21:49:22 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36410 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdEIBtV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 21:49:21 -0400
Received: by mail-pg0-f49.google.com with SMTP id 64so20002062pgb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ReURAF+lSr7fOetApxv7XqOvODgLcViyc/Fzgae0k9c=;
        b=h/pYsqH8Xn2QxWz0E448VMOQl+rEZ+c1P29kh5QdeM1AL8I5P+0v+HAL/sh8nsxIrt
         FACEWoW2qzHvBU6ieYxN+3u60QKcz2i5CKDH4THuDv1ZzgLkUIT3gaAXTGVTGDrDYCgf
         NeKCgKdUyHBVTfVePaKewigO/0DH/m+RhRWT3X+Yu32v9w493vHmJRcsWlYVQxX8fHim
         9rnFeat30+gD+PdRyZ2VPtHTcXjFe5kN+rJqth4O2uX8aacQLnfRfJuPJiRGyJg6EvNH
         RgnMJKOCNs2DdBZEVn5nyHjvc59IgKttJcYunMX6irWyl6A0CnRdTfHCkl7IlFYg6EtW
         TioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ReURAF+lSr7fOetApxv7XqOvODgLcViyc/Fzgae0k9c=;
        b=FEhuV014oVQnDfT/pSYMXjydHom+ZlLbqE6ZsKnL4tmDtswCSOjCk+kEgy7E+/UD1Z
         SajyIoDaWqrMwjcc6de3p2RzunSybTyrslrTy4CgG/seIDdwRjlGfUaiJPsGLEPQT63p
         Ny+rx8vP38YcvALcfHgs8ULxYR4N+3M0R0C3RQ4oqQ5mGx8txWf8N2wciYxqP5Ok0GnN
         z9KFiPVF/5wWzcEmcYRQAUAwKji6ucpDkAk3ODNDm89ZRbTFlzIyGupqkg+Ez/Z+mu0r
         d1yZo5XimnlQKmvMyRQSNPLZsPcwu30cpTG+vI2/E6/ECHH5f9rdzB5Ac37vcyAXB5+Z
         vsFA==
X-Gm-Message-State: AODbwcCStCywAJEDW3ewO3lYICm3xpOHu2fX1DdDkLBujM1khK+XafG4
        Omzr4cpw9lTOkw==
X-Received: by 10.99.123.21 with SMTP id w21mr7310445pgc.106.1494294560800;
        Mon, 08 May 2017 18:49:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id n8sm24437467pgd.31.2017.05.08.18.49.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 18:49:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Smith <whydoubt@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 02/10] Move textconv_object to be with other textconv methods
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170505052729.7576-3-whydoubt@gmail.com>
        <xmqqwp9v6vw2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ4k7qVKE7OpSEELorwSx5hUgJksLAeNgVGs0w1JC_Ffg@mail.gmail.com>
        <xmqq1ss0cg8t.fsf@gitster.mtv.corp.google.com>
        <20170508215525.gcyzzntqvm52mqcc@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 10:49:19 +0900
In-Reply-To: <20170508215525.gcyzzntqvm52mqcc@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 8 May 2017 17:55:25 -0400")
Message-ID: <xmqqziem6bq8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The specific helpers have less visibility, which is good. The public
> functions a() and b() were already public, so no change. But now the
> common helper is public, too, even though nobody except a() and b() care
> about it.
>
> So it's a tradeoff. And the important question is: is the bleed-over
> between a() and b() worse than the common bits being made public?

At this point you are saying the same thing as I said ;-) 

I haven't touched diff.c for a while, but my impression was that it
was already a smallest logical unit, especially since some bits like
diff-lib.c (the interface for the front-end programs to drive the
machinery via the three standard pairs of sources) and ws.c (diff
subsystem to deal with whitespace errors) are already split out (and
needless to say, the diffcore transformations are all in their own
separate files).  Over time people may have added what does not
belong there merely for convenience, which may want to get ejected,
but I do not think of many instances of them offhand.

    ... goes and looks ...

It appears that the textconv related helpers (which was where this
discussion thread started from) could be first restructured so that
they do not depend on diff_filespec and turned into a more generic
"I have this path and a blob object name, please run textconv to it
and..." interface and then moved out of the file into its own
textconv.[ch].  It does not need access to quite a few fields in
diff_filespec structure (e.g.  it shouldn't care what filemode the
thing has).  The diff machinery wants the result in a contiguous
piece of memory and that could be a good starting point, but I said
"and..." above because I am not sure if it is the best generic
thing the restructured interface can do to the result.





