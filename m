Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1510120248
	for <e@80x24.org>; Thu, 11 Apr 2019 19:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDKTOz (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 15:14:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33375 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDKTOz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 15:14:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so3880820plo.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LE6vNdM3y3+mQHjkLqsqpLhdwp4pcj4zFThnGzJHmQk=;
        b=opMOFNmqKGOSzhq0iymBOalkJiQiwF1oA1TAZ9H4gss42FLpv6OqMWS+gIXEwBXwKO
         HlEyQzdejU0EUCHqlsrZZe20gG9yqp4jF4CSVem7Bnzns+9Y3VIiuZ1UwO0gLJX10tyf
         71IHaZ/QrN4L7sRsMcBk6LyjgqpxkqswD3HbUR1qjsQBmrJ2lxLpWLKS4FV3mFKAQ8Bt
         cvlr4T2b95crZdZ3ktHCOfOa+lQHXSEzRL9eB8mQ6Yr4Nq0fBvSrw8UX6hI+GqqFlO6Q
         ENWe1NZHBULdL3s23TnuhIh/mr4QQw1TKMEUHKBifRgfOIWB41BgHi2sYFX1CsOXDzhb
         5BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LE6vNdM3y3+mQHjkLqsqpLhdwp4pcj4zFThnGzJHmQk=;
        b=U5MSZFq4CFk3/LCI9zFTz/ry+QRBZRRaBr88ulP+z1L1v3FHNeyFzi4Gs91/Gv7bVf
         ptHmROi43RKuv7YlqBZRLXXZ1Q4wU8dvN4I9n37QhG/zOdPyxeHS2C848gRAdKgJErLY
         cqxfZzDF9UsmK+rBAurZghrmvmoYbwFDXvEetUKuzA1LZNXwLTw9WbSUQ8dk4OA6eGjI
         dTAYxRIlM/jchcG+KQib4tBemH4//g1/nypF8cgA0idqhp7Jn+mDUFM0lgAa/rDWLxPK
         STyMatG0d+DPZZeU+l+V5av+08zc2Ti7tpk613ngT+H6RQYuCbHT0wAhHq8UlSZPRTv6
         0wUw==
X-Gm-Message-State: APjAAAVEM3a1EVLwQKWQjYxtD1OX4nd8TSThTVUK30VvgZJCZFITWpWv
        aW+549bSNAjl1SgcFj0CatzCpdzMZcqG3w==
X-Google-Smtp-Source: APXvYqz1vuXazvv8AdkZM1Bvs6+jxFL2fyg53hMZQ+GBaWeyYugWPftIduBfuU1tEdXI7RVsRkZOMA==
X-Received: by 2002:a17:902:b597:: with SMTP id a23mr3343384pls.284.1555010094048;
        Thu, 11 Apr 2019 12:14:54 -0700 (PDT)
Received: from localhost ([205.175.106.70])
        by smtp.gmail.com with ESMTPSA id t82sm105816183pfa.153.2019.04.11.12.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 12:14:53 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 11 Apr 2019 12:14:52 -0700
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: Re: [PATCH 0/4] use xmalloc in more places
Message-ID: <20190411191452.GA21290@D-10-18-172-132.dhcp4.washington.edu>
References: <20190411134736.GA28543@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411134736.GA28543@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, Apr 11, 2019 at 09:47:36AM -0400, Jeff King wrote:
> It was reported on the Git security list that there are a few spots
> which use a bare malloc() but don't check the return value, which could
> dereference NULL. I don't think any of these are exploitable in an
> interesting way, beyond Git just segfaulting more or less immediately.

Good; at least none of these seem to be exploitable for nefarious
purposes. Thanks for posting some patches on the public list.

> But we should still be handling failures, and I think it makes sense to
> be consistent about how we do it (and the other rules which come with
> using xmalloc, like GIT_ALLOC_LIMIT).
>
> This series cleans up most of the bare calls found by:
>
>   git grep -E '[^a-z_](m|c|re)alloc\(' '*.c' :^compat :^contrib :^wrapper.c

This (admittedly pretty awesome) 'git grep' invocation reminds me of a
series I was pretty sure you wrote to ban functions like 'strcpy' and
other obviously bad things.

Some quick searching turned up [1], which landed as f225611d1c
(automatically ban strcpy(), 2018-07-26). Do we want something similar
here? Of course, the locations below would have to be exempt, but it
seems worthwhile (and would save a review cycle in the case that someone
added a 'malloc' in a patch sent here).

FWIW, there isn't any mention of 'malloc' anywhere in that original
thread [1], so I _think_ this would be the first time discussing banning
malloc in this fashion.

> The calls I've left are:
>
>   - wrapper.c obviously needs to call the real functions :)

Yep -- this one needs to stay ;-).

>   - compat/ has functions emulating libc and system calls, and which are
>     expected to return ENOMEM as appropriate
>
>   - diff-delta will gracefully return NULL when trying to delta
>     something too large, and pack-objects will skip past trying to find
>     a delta. I've never seen this happen in practice, but then I
>     primarily use Linux which is more than happy to overcommit on
>     malloc(). I've left it unchanged, though possibly we could have an
>     xmalloc_gently() if we want to enforce things like GIT_ALLOC_LIMIT
>     but still do the graceful fallback thing.
>
>   - test-hash tries to probe malloc() to see how big a buffer it can
>     allocate. I doubt this even does anything useful on systems like
>     Linux that overcommit. We also don't seem to ever invoke this with a
>     buffer larger than 8k in the first place. So it could maybe go away
>     entirely, but I left it here.
>
>   [1/4]: test-prio-queue: use xmalloc
>   [2/4]: xdiff: use git-compat-util
>   [3/4]: xdiff: use xmalloc/xrealloc
>   [4/4]: progress: use xmalloc/xcalloc
>
>  progress.c                 | 18 +++++-------------
>  t/helper/test-prio-queue.c |  2 +-
>  xdiff/xdiff.h              |  4 ++--
>  xdiff/xinclude.h           |  8 +-------
>  4 files changed, 9 insertions(+), 23 deletions(-)
>
Thanks,
Taylor

[1]: https://public-inbox.org/git/20180719203901.GA8079@sigill.intra.peff.net/
