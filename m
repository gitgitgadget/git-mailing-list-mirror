Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6B41F453
	for <e@80x24.org>; Mon, 29 Apr 2019 08:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfD2Iaq (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 04:30:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39556 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfD2Iaq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 04:30:46 -0400
Received: by mail-io1-f68.google.com with SMTP id c3so8225384iok.6
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dKWovgJq/CgT10/FJKn2MuRu7yoHbeVXLQgA7h8Pth0=;
        b=bIfi0hwxQwo/+tYRcRq2/3tl1t+jA1yfhkUdpsGIY3azp96oe1h/iIQJvtfNQtuEzq
         B9LYtN7b5WxvqPVlA1DMGhcksm+EccElHGSWCVPzLIprsluwnBbdp0GTYd5T1M13kfO5
         Ys78WcBAL3Vkjcgwh00HBcab8BfuGmzABk7h4SxHwjrFBoYlnbvVjYeIYkOQ+fOqTVHE
         9a3EysSTfxylIhRH6NqNGs6QjeGEWFl+ETdVsDazw9U7YLnAj15fuFRg2Msd3a6YmlRq
         dnjgF3G3aGsdXCNZ4K+UqRnLRdyJ2DZoDmkqOlY/vguQKDbQ/dZiM1nfpNmZfVPIPJOS
         GPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dKWovgJq/CgT10/FJKn2MuRu7yoHbeVXLQgA7h8Pth0=;
        b=lcoHCUZzi0ZNGFJiD2FcrwkKIitTuk5fjm9ihDsvbK8xkvNgRS0BhM+WUnTE66UGh9
         j4MLKfoSHHHJXIXchvUpNW7YQa0qz7YnLl7towmD7hqTdZ5OTPtkaq4LNJZxX60eqEv+
         dus7XCY4AsF7XHUClr9m0mcaPDWIOe8TwqpYz671k1WHTDodbPsMxweBtE2E1GwP7G4P
         ghlouEW/pE4MdEJw4mLJ/C0u9iKIrOIRIhnQ5AXjfouKdalR7dePabhnc65cGGHnUF6c
         QYdJ2SPVtKDY9P7zyLceE9CooPUxJCJ8pBL4kLLpuwdBBJZwwcPub/IZjleB/x7AIXlT
         mkSg==
X-Gm-Message-State: APjAAAXMXiIZbyuHKi9q3njiNf/6SJwOoDEEf/qK90bP2Z6OPTsHF4QR
        7A1qW8qBEP9gGEThsUPyPCmXtWnE
X-Google-Smtp-Source: APXvYqwRXLMGUGmpW8wDefTieeCkP2oityuCdH+KZmtY5QsU75rI47qWKlk83HQQc/PbXPLTrpUwmw==
X-Received: by 2002:a05:6602:8f:: with SMTP id h15mr623006iob.117.1556526645019;
        Mon, 29 Apr 2019 01:30:45 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id w2sm11397551iob.7.2019.04.29.01.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 01:30:44 -0700 (PDT)
Date:   Mon, 29 Apr 2019 04:30:42 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 0/3] *** SUBJECT HERE ***
Message-ID: <20190429083042.GA22366@archbookpro.localdomain>
References: <cover.1556062365.git.liu.denton@gmail.com>
 <cover.1556526308.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556526308.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: [PATCH v5 0/3] *** SUBJECT HERE ***

I forgot to change the subject... Embarassing.

On Mon, Apr 29, 2019 at 04:28:09AM -0400, Denton Liu wrote:
> Hi Junio,
> 
> Since you mentioned you prefer wholesale replacement patches, here's a
> reroll.
> 
> I dropped the trailing '\' in the log messages and we also drop the 4th
> patch since Szeder reported that it was causing problems for the CI.
> 
> ---
> 
> Changes since v1:
> 
> * Used spatch with sed instead of sed alone
> * Fixed sed expression to ignore function variables
> 
> Changes since v2:
> 
> * Rebased on latest master (since last patchset hasn't been picked up
>   yet)
> * Manually aligned parameter lists that were mangled by the tools
> 
> Changes since v3:
> 
> * Excluded compat/ from cleanup
> 
> Changes since v4:
> 
> * Dropped trailing '\' from log messages
> * Dropped "cocci: prevent extern function declarations"
> 
> Denton Liu (3):
>   *.[ch]: remove extern from function declarations using spatch
>   *.[ch]: remove extern from function declarations using sed
>   *.[ch]: manually align parameter lists
> 
>  advice.h                 |   2 +-
>  archive.h                |  24 +--
>  bisect.h                 |  26 +--
>  blame.h                  |   2 +-
>  branch.h                 |  14 +-
>  builtin.h                | 254 +++++++++++++-------------
>  bulk-checkin.h           |  10 +-
>  cache.h                  | 386 +++++++++++++++++++--------------------
>  checkout.h               |   6 +-
>  column.h                 |  16 +-
>  commit.h                 | 116 ++++++------
>  config.h                 | 226 +++++++++++------------
>  connect.h                |  22 +--
>  csum-file.h              |  20 +-
>  decorate.h               |   4 +-
>  delta.h                  |  14 +-
>  dir.h                    | 144 +++++++--------
>  exec-cmd.h               |  16 +-
>  fmt-merge-msg.h          |   2 +-
>  fsmonitor.h              |  14 +-
>  gettext.h                |   8 +-
>  git-compat-util.h        | 132 ++++++-------
>  grep.h                   |  22 +--
>  hashmap.h                |  30 +--
>  help.h                   |  36 ++--
>  http.h                   |  62 +++----
>  khash.h                  |  16 +-
>  kwset.h                  |  10 +-
>  line-log.h               |  16 +-
>  lockfile.h               |  12 +-
>  ls-refs.h                |   4 +-
>  mailinfo.h               |   6 +-
>  merge-blobs.h            |   6 +-
>  object-store.h           |  32 ++--
>  object.h                 |  12 +-
>  oidmap.h                 |  12 +-
>  pack.h                   |  26 +--
>  packfile.h               |  82 ++++-----
>  path.h                   |  42 ++---
>  pkt-line.h               |  10 +-
>  ppc/sha1.c               |   4 +-
>  prio-queue.h             |  10 +-
>  protocol.h               |   6 +-
>  quote.h                  |  34 ++--
>  reachable.h              |   8 +-
>  reflog-walk.h            |  28 +--
>  refs.h                   |   2 +-
>  remote.h                 |  24 +--
>  replace-object.h         |   4 +-
>  resolve-undo.h           |  14 +-
>  run-command.h            |   8 +-
>  serve.h                  |   6 +-
>  sha1-lookup.h            |   8 +-
>  streaming.h              |   8 +-
>  string-list.h            |   4 +-
>  sub-process.h            |   8 +-
>  submodule-config.h       |  22 +--
>  tag.h                    |  16 +-
>  tempfile.h               |  30 +--
>  trace.h                  |  44 ++---
>  transport.h              |   4 +-
>  tree-walk.h              |   4 +-
>  upload-pack.h            |   8 +-
>  url.h                    |  16 +-
>  urlmatch.h               |   4 +-
>  utf8.h                   |   2 +-
>  varint.h                 |   4 +-
>  vcs-svn/sliding_window.h |   2 +-
>  vcs-svn/svndiff.h        |   4 +-
>  worktree.h               |  36 ++--
>  xdiff-interface.h        |  12 +-
>  71 files changed, 1139 insertions(+), 1139 deletions(-)
> 
> Range-diff against v4:
> 1:  6c27c8b17c ! 1:  200c556b7d *.[ch]: remove extern from function declarations using spatch
>     @@ -19,8 +19,8 @@
>      
>          and it was run with:
>      
>     -            $ git ls-files \*.{c,h} | \
>     -                    grep -v ^compat/ | \
>     +            $ git ls-files \*.{c,h} |
>     +                    grep -v ^compat/ |
>                          xargs spatch --sp-file contrib/coccinelle/noextern.cocci --in-place
>      
>          Files under `compat/` are intentionally excluded as some are directly
> 2:  a996466d3b ! 2:  6fe5c773ea *.[ch]: remove extern from function declarations using sed
>     @@ -8,8 +8,8 @@
>      
>          This was done by running the following on my system with sed 4.2.2:
>      
>     -        $ git ls-files \*.{c,h} | \
>     -            grep -v ^compat/ | \
>     +        $ git ls-files \*.{c,h} |
>     +            grep -v ^compat/ |
>                  xargs sed -i'' -e 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/'
>      
>          Files under `compat/` are intentionally excluded as some are directly
> 3:  6c8489b26b = 3:  98c743b19d *.[ch]: manually align parameter lists
> 4:  ec08af884c < -:  ---------- cocci: prevent extern function declarations
> -- 
> 2.21.0.1033.g0e8cc1100c
> 
