Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD13520365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbdGMUqX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:46:23 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33398 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbdGMUqW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:46:22 -0400
Received: by mail-pf0-f169.google.com with SMTP id e7so34887852pfk.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nPDrK2zAZI2gIp3sQuns6NZ/9wYQn88BkNps5nTzfqQ=;
        b=fao6GwS+Z9GkMpaFMJ+RYxHwO4Wm6azxgv/bQeuDUG2WK5kVX0B/n+byy7JO9/xPLI
         67fmOzexqT9w0yKIjzFj1TB9Yf3+jKOWZpyEND+Vo1oAEg6i86GYDS8k/nPelXttr/aN
         1pft0F4QV3GWj90YR8c+p5Hgtx5k/PJGwxCRyE9tx/Todu6a3dMjMPBHSN9nm6qh2VrY
         SaXT7N1GVhkQNZWhkH5TvdUFej74iiBfIhdQkugmAYxZTLy5Sr8qvMhRVErsTNo22lJ8
         /2RSHGH5wlREvsbnv9c9oixiREE3E6MmMF7prUYKyUb6O3m3FNgVqFLATHl++MN6TPkU
         xKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nPDrK2zAZI2gIp3sQuns6NZ/9wYQn88BkNps5nTzfqQ=;
        b=D7FURjTnMyOloCUWv9QhyQyISWJ5G6024FF1qzhSwhdTuO0frO8Xy5rZC2WQqpm9iP
         r0is1ClyFTwrbXUln7BZyd7hL04cA4UTzGmFQ3C+hnqoxriqFxvkeQfVhz1ubbDFnzs1
         pwAD1tPJW+dXaHL+sYOj3zA7lmC3PnMNB+oDpSslyI6/XvXnN7nhlSwdw1X2ABLER0+O
         LF3Hmy7ju9ke1HaBg67+OJjPlUMY1fsVqyhHUcHmBmvDDaO7UYIV8lanLnWQm+Cj4B/Z
         oymsqr5Z4U8T5TwFQFEXURuPzt6X0Owv9Qp9IlxPosVwboR0cHoo2RO6vZaM1lq24eYk
         bcVw==
X-Gm-Message-State: AIVw111R5I0aUTGP+CSpiRHunxv8pinkTRuwzwvY0o1zcjJp5GFoFOBi
        bUIpNmFMHh0nkQ==
X-Received: by 10.84.214.22 with SMTP id h22mr11862555pli.277.1499978781601;
        Thu, 13 Jul 2017 13:46:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id w125sm13576600pfb.117.2017.07.13.13.46.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:46:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/15] making user-format colors conditional on config/tty
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 13:46:19 -0700
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 10:55:53 -0400")
Message-ID: <xmqqd194uktg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This version also takes into account feedback from the original thread.
> And as I added tests, it surfaced a few corner cases around color config
> that I've dealt with here.  The last two patches are the most
> interesting bits.
>
>   [01/15]: check return value of verify_ref_format()
>   [02/15]: docs/for-each-ref: update pointer to color syntax
>   [03/15]: t: use test_decode_color rather than literal ANSI codes
>   [04/15]: ref-filter: simplify automatic color reset
>   [05/15]: ref-filter: abstract ref format into its own struct
>   [06/15]: ref-filter: move need_color_reset_at_eol into ref_format
>   [07/15]: ref-filter: provide a function for parsing sort options
>   [08/15]: ref-filter: make parse_ref_filter_atom a private function
>   [09/15]: ref-filter: factor out the parsing of sorting atoms
>   [10/15]: ref-filter: pass ref_format struct to atom parsers
>   [11/15]: color: check color.ui in git_default_config()
>   [12/15]: for-each-ref: load config earlier
>   [13/15]: rev-list: pass diffopt->use_colors through to pretty-print
>   [14/15]: pretty: respect color settings for %C placeholders
>   [15/15]: ref-filter: consult want_color() before emitting colors

Overall I think the endgame is what we want to have in the future
(rather, what I wish we had from the beginning).  I'd have to think
about 11, 14 and 15 a bit more before saying anything that would be
remotely useful.

Thanks.

>
>  Documentation/git-for-each-ref.txt |   6 +-
>  Documentation/pretty-formats.txt   |  18 ++++--
>  builtin/branch.c                   |  21 +++---
>  builtin/clean.c                    |   3 +-
>  builtin/for-each-ref.c             |  27 ++++----
>  builtin/grep.c                     |   2 +-
>  builtin/rev-list.c                 |   1 +
>  builtin/show-branch.c              |   2 +-
>  builtin/tag.c                      |  61 ++++++------------
>  builtin/verify-tag.c               |  14 ++--
>  color.c                            |   8 ---
>  config.c                           |   4 ++
>  diff.c                             |   3 -
>  pretty.c                           |  27 ++++++--
>  ref-filter.c                       | 108 ++++++++++++++++++-------------
>  ref-filter.h                       |  30 +++++++--
>  t/t3203-branch-output.sh           |  31 +++++++++
>  t/t4207-log-decoration-colors.sh   |  22 +++----
>  t/t6006-rev-list-format.sh         | 129 ++++++++++++++++++++++++-------------
>  t/t6300-for-each-ref.sh            |  39 +++++++----
>  t/t7004-tag.sh                     |  25 +++++++
>  t/test-lib-functions.sh            |   1 +
>  22 files changed, 362 insertions(+), 220 deletions(-)
>
> -Peff
