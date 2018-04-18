Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139901F404
	for <e@80x24.org>; Wed, 18 Apr 2018 19:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDRTry (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 15:47:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43535 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeDRTrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 15:47:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id u4-v6so7882511wrg.10
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CRuWkY5VTFJf16GcbUO6XTjseMVnrHTKaASmhWyHupY=;
        b=nLS9BWltpu2QPmsNhau5XnwX2IPhYeh4nQJuO1/hb1nox7R8SzbfZdc9d+ZAey23gU
         WJuYi9Bqo2IsvFRSjP2LS/oKi1Kdhy48rNOvSSYUkjug5U7z3KeHwIlf/fMdPS0urBy2
         YOiEZMMgVb7npwogR6p+D18Ah5WteB7tP2MDBnmimPphYOgz6MpTP2USXNUoRL50fSkG
         gk5B5ydRFcO6+L1y4bPjwj2S9hFKsOmuVdmm3TP/XdndkGOf0PikR3CmCc+yfjDumL12
         TCnXOHUm5QpB7VxItPqRvFU6lZWkWhGoKLY6MeswfOUtWbFym5LPLbjVuhmRZcKBHyfD
         bzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=CRuWkY5VTFJf16GcbUO6XTjseMVnrHTKaASmhWyHupY=;
        b=RsMf42AoHgJnopjGIqouBhQv6qtdQScB9jEODBXlOXDTfdOGu134pDmrEBX3JUxrfT
         U6GCNeDtTJbCSrQ6htfFOwGSNt12KALl/sx2JCXGSg//LPL0UCFZNmtA29DVfC6LbNSa
         YCRvcy0yHsRzyASIMtgRPo82I+I3eGO8WDStMEzQ1QyrTF8OOf8I7/PLDY+xXC+WtLo2
         /CPJI9l6KBz0hnpC+GOx4O3Yz+UPVvewF3Ki82jiq42FQZpIz5u7NF3v+diG7bThPn/2
         O2K+K2pG01UZjI06ZZqkQMn5IHz7Rn4s+1Wlzkzdm9w6F8o0zeEbce9IWqcYRo5+pNu6
         Rj2A==
X-Gm-Message-State: ALQs6tD7C0GCuwGpgY4kH3rR5Efsc0H977t6o4slx5xvqITJlwMJUwus
        0dCCIGSvJ/N57ZSA1rRtXfU=
X-Google-Smtp-Source: AIpwx4/A4CjhddJ3x6YXGo9yz+YvQ9esNtkshzc0xs7NnCkUYdNbmtag6kjlC/5kjbFwx+xaAsc4wQ==
X-Received: by 2002:adf:9a54:: with SMTP id z78-v6mr2520758wrb.235.1524080871795;
        Wed, 18 Apr 2018 12:47:51 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id 55-v6sm3331208wrw.52.2018.04.18.12.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 12:47:50 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "peff\@peff.net" <peff@peff.net>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v3 4/9] commit-graph.txt: update design document
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-5-dstolee@microsoft.com>
Date:   Wed, 18 Apr 2018 21:47:48 +0200
In-Reply-To: <20180417170001.138464-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 17:00:24 +0000")
Message-ID: <86y3hkguu3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> We now calculate generation numbers in the commit-graph file and use
> them in paint_down_to_common().

All right.

>
> Expand the section on generation numbers to discuss how the three
> special generation numbers GENERATION_NUMBER_INFINITY, _ZERO, and
> _MAX interact with other generation numbers.

Very good.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 30 +++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index 0550c6d0dc..d9f2713efa 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -77,6 +77,29 @@ in the commit graph. We can treat these commits as having "infinite"
>  generation number and walk until reaching commits with known generation
>  number.
>
> +We use the macro GENERATION_NUMBER_INFINITY = 0xFFFFFFFF to mark commits not
> +in the commit-graph file. If a commit-graph file was written by a version
> +of Git that did not compute generation numbers, then those commits will
> +have generation number represented by the macro GENERATION_NUMBER_ZERO = 0.

I have to wonder if there would be any relesed Git that do not compute
generation numbers...

On the other hand in case the user-visible view of the project history
changes, be it because shallow clone is shortened or deepened, or grafts
file is edited, or a commit object is replaced with another with
different parents - we can still use "commit-graph" data, just pretend
that generation numbers (which are invalid in altered history) are all
zero.  (I'll write about this idea in comments to later series.)

On the other hand with GENERATION_NUMBER_ZERO these series of patches
are self-contained and bisectable.

> +
> +Since the commit-graph file is closed under reachability, we can guarantee
> +the following weaker condition on all commits:

I have had to look up the contents of the whole file, but it turns out
that it is all right: "weaker condition" refers to earlier "N <= M".

Minor sidenote: if one would be extremly pedantic, one could say that
previous condition is incorrect, because it doesn't state explicitely
that commit A != commit B. ;-)

> +
> +    If A and B are commits with generation numbers N amd M, respectively,
> +    and N < M, then A cannot reach B.
> +
> +Note how the strict inequality differs from the inequality when we have
> +fully-computed generation numbers. Using strict inequality may result in
> +walking a few extra commits, but the simplicity in dealing with commits
> +with generation number *_INFINITY or *_ZERO is valuable.
> +
> +We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
> +generation numbers are computed to be at least this value. We limit at
> +this value since it is the largest value that can be stored in the
> +commit-graph file using the 30 bits available to generation numbers. This
> +presents another case where a commit can have generation number equal to
> +that of a parent.

I wonder if something like the table I have proposed in v2 version of
this patch [1] would make it easier or harder to understand.

[1]: https://public-inbox.org/git/86a7u7mnzi.fsf@gmail.com/

Something like the following:

             |                      gen(B)
             |
gen(A)       | _INFINITY | _MAX     | larger   | smaller  | _ZERO
-------------+-----------+----------+----------+----------+--------
_INFINITY    | =         | >        | >        | >        | >
_MAX         | < N       | =        | >        | >        | >
larger       | < N       | < N      | = n      | >        | >
smaller      | < N       | < N      | < N      | = n      | >
_ZERO        | < N       | < N      | < N      | < N      | =

Here "n" and "N" denotes stronger condition, and "N" denotes weaker
condition.  We have _INFINITY > _MAX > larger > smaller > _ZERO.

> +
>  Design Details
>  --------------
>
> @@ -98,17 +121,12 @@ Future Work
>  - The 'commit-graph' subcommand does not have a "verify" mode that is
>    necessary for integration with fsck.
>
> -- The file format includes room for precomputed generation numbers. These
> -  are not currently computed, so all generation numbers will be marked as
> -  0 (or "uncomputed"). A later patch will include this calculation.
> -
>  - After computing and storing generation numbers, we must make graph
>    walks aware of generation numbers to gain the performance benefits they
>    enable. This will mostly be accomplished by swapping a commit-date-ordered
>    priority queue with one ordered by generation number. The following
> -  operations are important candidates:
> +  operation is an important candidate:
>
> -    - paint_down_to_common()
>      - 'log --topo-order'
>
>  - Currently, parse_commit_gently() requires filling in the root tree

Looks good.
