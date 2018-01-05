Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1EC1F404
	for <e@80x24.org>; Fri,  5 Jan 2018 05:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeAEFJY (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 00:09:24 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:46277 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeAEFJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 00:09:23 -0500
Received: by mail-io0-f178.google.com with SMTP id z130so4540227ioe.13
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 21:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6lIhSqG4pqDr7GBVCbOU01SSQlVClN3J1r4V1CvdAE=;
        b=RMVnoV6mcgqAODiOgYdamSTc0NFJ5uQPTL+hmrqwGnFjSJGqOTwRbVn89M4jsGn+Ch
         xwilJ9zHMxamMZwI4rmOTQ0mAS3qcwPzf5CrcNpwE0sqhsEw3cwIFxRHM+eElx1hlXIe
         a6CIX8LCxWfsM59JPijrwhzCjvAnvERRDRejo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6lIhSqG4pqDr7GBVCbOU01SSQlVClN3J1r4V1CvdAE=;
        b=d/kSP6nFdvTQtGuyd8nRXxjOV47h3KBryC7Xf2xjBBhb30P5Y+EKsCzA4t0vOU50En
         VcRDJpup+hE+rN/jbo201qb4/NgUuKT0Mqo8pCG+AbdpixlWxb3IFLlfW9Ii7JllGy0O
         sEDrKXPIQy+K94ks1M9/vq6/e2Gt/DYKR6ao9EXeolhku1uRzpQ9vR3E6nf1BysRYnyU
         WtHnKfhQwBsdo/8m2TeJOpK3tD9y9tQOj3SYiNqjfO4T91EDLxHLPZawrHv03kd2Tlnw
         IxfAXGie0/3+nnLa/1RRxJakhpnUXgUEN/7vjWTeWwMGBvxYNZblCm/gJ3JsYTZ3UJiD
         evPg==
X-Gm-Message-State: AKGB3mK8tYiU6ccRpR1+hU831OwqFNIsxX7xeTpT/kehdHfqrs9zPTE2
        YfErufWfNvtPJH67ea9NR7BMrQ==
X-Google-Smtp-Source: ACJfBovvOaKsVvRr27l7w15seBLbHVA1DT7B5nu9WoRWARqOp+YemKWHTHzYAwTkDxk9eLOvgld9Pw==
X-Received: by 10.107.18.97 with SMTP id a94mr2057074ioj.70.1515128963057;
        Thu, 04 Jan 2018 21:09:23 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:f0d7:a5cd:e618:32a7])
        by smtp.gmail.com with ESMTPSA id 202sm2977360iti.6.2018.01.04.21.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 21:09:22 -0800 (PST)
Date:   Thu, 4 Jan 2018 22:09:20 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20180105050919.GA14525@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171226060229.GB18783@Carl-MBP.ecbaldwin.net>
 <CA+P7+xpvuCjdnjyQxQg3B5iMwbnx-CerQMAP+bDQHR_-ALJOkQ@mail.gmail.com>
 <2180514.YZ24uruNv3@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2180514.YZ24uruNv3@mfick-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 04, 2018 at 12:19:34PM -0700, Martin Fick wrote:
> On Tuesday, December 26, 2017 12:40:26 AM Jacob Keller 
> wrote:
> > On Mon, Dec 25, 2017 at 10:02 PM, Carl Baldwin 
> <carl@ecbaldwin.net> wrote:
> > >> On Mon, Dec 25, 2017 at 5:16 PM, Carl Baldwin 
> <carl@ecbaldwin.net> wrote:
> > >> A bit of a tangent here, but a thought I didn't wanna
> > >> lose: In the general case where a patch was rebased
> > >> and the original parent pointer was changed, it is
> > >> actually quite hard to show a diff of what changed
> > >> between versions.
> > 
> > My biggest gripes are that the gerrit web interface
> > doesn't itself do something like this (and jgit does not
> > appear to be able to generate combined diffs at all!)
> 
> I believe it now does, a presentation was given at the 
> Gerrit User summit in London describing this work.  It would 
> indeed be great if git could do this also!

This would be very cool. I've wanted to tackle this for a long time. I
think I even filed an issue with gerrit about this years ago.

Carl
