Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9341F404
	for <e@80x24.org>; Wed, 15 Aug 2018 05:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeHOIIr (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 04:08:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37567 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeHOIIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 04:08:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so65403pll.4
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 22:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZymAW5vvGwO9+6MAFAV1RtXwowbNG98NM7iF55QtWA=;
        b=DdJWxuVQv1cnl1BgaLvOsFTxf8NSMpPzOfvmP5TlduIKFgim00SH2nFqHHjUQjFNBc
         lmoO38/FUJ+MDiAxiYWjjtrPdAAkKOOJjSMgqiQVUuSQBq8xg67XtlUcc6Lg605Y7X1o
         tmGkeDnTRP/oq/aYr9yrJ4/xNsgc+f6aXXEhaViXGJUsCXCv/PiMIyUk4GQtVDQE3W9Z
         efIUhTp2cq/Ys6ppWIWy/IRlGOHCIDyzGhIsZSwr94cRXhiCqWxCURB5TBaRVzuPbvWW
         1rKosN+FHN6JEwDd17OS5p3hVo+iq+uVOZFDdt4WwRl6HyMPtWjwjuK1h4QlVwxhjpza
         cgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZymAW5vvGwO9+6MAFAV1RtXwowbNG98NM7iF55QtWA=;
        b=qKBQbpLwrc8mgmYtO7g2mIA865naZIuwjaGfMJT/+NfsqWBFiSN2BgIqgPu4TkEMQv
         GS16XV6PPat//eHaW+v6iQjEKAgpXs8+MvqFhZt+QAD9krlw3bs2vW+sN6+kXxRwZ0oq
         SS6WmW4UyLsc4bI82HIHMQfVqpzJTpyoJUL2NGn130ccK3pSx+cxTHHk3Lcb1ZT4K2af
         h/ZSmWjG7kQeISLYAQEaDw6koCTbs3Gf6maV7JVI789QaqLLf5+xi19rzCueKeH3KuWl
         SzU7NT2V4tUVW3+Vv4WCjnc5aViRXsKOh96GV/CqBVvRi8YCtFbpFw2+DeSYFmuN4EzS
         D92A==
X-Gm-Message-State: AOUpUlFc11lHHrKQXq7iki2i46bPB9SqZ1V9TDhrrS/NMrbbmOWeRJCw
        0zizmLfNId32SYdsKodAnt4=
X-Google-Smtp-Source: AA+uWPzbA1stG4EYgUrrfTtl8K3VmSy+l+0cCKbNiUhrJC/oSR1CoX2K9/dAK3pn+zDixsVHmApB3w==
X-Received: by 2002:a17:902:904c:: with SMTP id w12-v6mr23184953plz.95.1534310291102;
        Tue, 14 Aug 2018 22:18:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p19-v6sm35083525pgh.60.2018.08.14.22.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 22:18:10 -0700 (PDT)
Date:   Tue, 14 Aug 2018 22:18:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 2/6] alloc: make allocate_alloc_state and
 clear_alloc_state more consistent
Message-ID: <20180815051808.GD32543@aiede.svl.corp.google.com>
References: <20180811205024.11291-1-newren@gmail.com>
 <20180813171749.10481-1-newren@gmail.com>
 <20180813171749.10481-3-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813171749.10481-3-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> Since both functions are using the same data type, they should either both
> refer to it as void *, or both use the real type (struct alloc_state *).
> Opt for the latter.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  alloc.c | 2 +-
>  alloc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This API comes from 14ba97f8 (alloc: allow arbitrary repositories for
alloc functions, 2018-05-15).  The pointer returned by
allocate_alloc_state points to an initialized, usable object so
returning a struct instead of a void pointer is the right thing to do.
Thanks for noticing and fixing it.

That commit in turn was probably inspired by v1.5.2-rc0~16^2 (Clean up
object creation to use more common code, 2007-04-16), which was
following the same convention (void * for raw memory, struct blob *
for initialized object).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
