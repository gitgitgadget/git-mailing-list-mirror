Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E79320248
	for <e@80x24.org>; Wed, 20 Mar 2019 09:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCTJ33 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 05:29:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33877 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTJ32 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 05:29:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so1922365wrq.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qNPzb55PSJk58xzVNVN7ial/NeOc+HfBlMSEYVoB0NI=;
        b=KYTxNW9zN+6L68+/N4gkpWBqJeSi/xc9d3lTpCkGnl6mDuksbZMHY22FzJmZtZK5pQ
         GJEPZRrLuGmxtlxwecQ1OoWUoxxsYt04tWKe7mhm2DBywQclI4QB7wT7ZUqFxog6XWru
         +Cw6Nlv5HdsoNeb4ygB/6JP4NcaWq3JNYwbXWJMUGPnoFV0tFwKyoQbd+Ppjmesxobs9
         BHwtCYHqMX8twrQ4P4eo6h30WbhUAuNx4d/LJrrOKOHuVf4VhKPUYTCXQLcpk+qeszSU
         rQ4Ht/KmTe3o1WqNXfZ5zpw9iPRTObj6dIDE6tud747gdip8YOOXTP0AjeQ4+j1lIsJO
         Ai6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qNPzb55PSJk58xzVNVN7ial/NeOc+HfBlMSEYVoB0NI=;
        b=B6yRnGE1mR10pvw93JzO+ux3XHvQWx3fyF6/P1+XBgFBayPtPhylh7EEJqKzM3dCsN
         +3Mjp+iKC+Ytp1poqh6hd9oHfejmncB22WSk1XAIxqXkyrlu5ZfJnHlF1MXR5j472+sj
         dUMA/D4P5gzcZi9C3/EFns6XueHWRQVyWGJhf4VgDfrTBnvC+kZk+TPjsqKCHiL5XPc/
         LwIaaZaXAHWPccC0Bbdtd6GBEOFXVxT/d1+UbU55yuqFK0SvqehKV/nmJn9qT24j0mkK
         ihm7Ik+Y9FSgpnF4sri3mpZQJ4muXeEar0r46tBP3uwd8Kl6HyfFU/L/UrBKFZMcalzM
         qdZg==
X-Gm-Message-State: APjAAAXYGyBpQmaBwTSXZ8Yb4ZGQuKh/u+gH4a024VLfSz9SJji1ACgb
        ZQIKA8XayH6SOyQGh/R9x2M=
X-Google-Smtp-Source: APXvYqyNfO6nw8ad/YMx8P2GrIqTJ2fnz447JJxAeM5aIpoagFdIBrtVMhTpzrqHJIt9alqFs6/OwQ==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr21721554wrv.187.1553074166796;
        Wed, 20 Mar 2019 02:29:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h131sm10378131wmh.1.2019.03.20.02.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 02:29:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/13] more unused parameter cleanups
References: <20190320081258.GA5621@sigill.intra.peff.net>
Date:   Wed, 20 Mar 2019 18:29:23 +0900
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 20 Mar 2019 04:12:58 -0400")
Message-ID: <xmqqr2b1vqq4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's another round of -Wunused-parameter cleanups. Previous rounds
> were at [1] and [2]. As before, these are mostly just removals, so it's
> easy to see there's no behavior change (there are a couple of cleanups
> that ride along, though, so watch for those).
>
> There are two minor conflicts when merging with pu:
>
>   - jt/fetch-cdn-offload tweaked the "pack_lockfile" parameter to
>     fetch_pack(). A few other parameters are dropped in this series.
>     The textual resolution is pretty straightforward.
>
>   - ps/stash-in-c (et al) added a new call to report_path_error() in
>     builtin/stash.c, which here loses its redundant "prefix" parameter.
>     There's no textual conflict, but the new call needs to drop its
>     final NULL parameter in order to compile.
>
> [1] https://public-inbox.org/git/20190214054736.GA20091@sigill.intra.peff.net/
> [2] https://public-inbox.org/git/20190124131104.GA24017@sigill.intra.peff.net/
>
> The patches are:
>
>   [01/13]: revision: drop some unused "revs" parameters
>   [02/13]: log: drop unused rev_info from early output
>   [03/13]: log: drop unused "len" from show_tagger()
>   [04/13]: update-index: drop unused prefix_length parameter from do_reupdate()
>   [05/13]: test-date: drop unused "now" parameter from parse_dates()
>   [06/13]: unpack-trees: drop name_entry from traverse_by_cache_tree()
>   [07/13]: unpack-trees: drop unused error_type parameters
>   [08/13]: report_path_error(): drop unused prefix parameter
>   [09/13]: fetch_pack(): drop unused parameters
>   [10/13]: parse-options: drop unused ctx parameter from show_gitcomp()
>   [11/13]: pretty: drop unused "type" parameter in needs_rfc2047_encoding()
>   [12/13]: pretty: drop unused strbuf from parse_padding_placeholder()
>   [13/13]: parse_opt_ref_sorting: always use with NONEG flag

Nicely written.  Thanks.

>  builtin/branch.c            |  3 +--
>  builtin/checkout.c          |  2 +-
>  builtin/commit.c            |  6 +++---
>  builtin/fetch-pack.c        |  2 +-
>  builtin/for-each-ref.c      |  3 +--
>  builtin/log.c               | 18 +++++++++---------
>  builtin/ls-files.c          |  2 +-
>  builtin/ls-remote.c         |  3 +--
>  builtin/submodule--helper.c |  2 +-
>  builtin/tag.c               |  3 +--
>  builtin/update-index.c      |  5 ++---
>  dir.c                       |  3 +--
>  dir.h                       |  2 +-
>  fetch-pack.c                |  3 +--
>  fetch-pack.h                |  3 +--
>  parse-options.c             |  5 ++---
>  pretty.c                    | 12 +++++-------
>  ref-filter.c                |  9 +++++++--
>  ref-filter.h                |  5 +++++
>  revision.c                  | 12 ++++++------
>  t/helper/test-date.c        |  4 ++--
>  transport.c                 | 10 ++++------
>  unpack-trees.c              |  9 +++------
>  23 files changed, 60 insertions(+), 66 deletions(-)
>
> -Peff
