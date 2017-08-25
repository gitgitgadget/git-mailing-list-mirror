Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F62B208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 18:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756371AbdHYSuP (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 14:50:15 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33140 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756445AbdHYSuO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 14:50:14 -0400
Received: by mail-pg0-f53.google.com with SMTP id t3so3422475pgt.0
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CrXzr0U/UCG48oVmtVGFrpfm+MNet7TVlFX8LByZalU=;
        b=GCu+h9ik+afyvVo7OAPdZLYWijuBQ22H6zErXfNVTCQWzgHiSFCTNfK6RX4F3xL5Yc
         h7i/S6Zqm3LwAz2S9lO7bI5Qohv5lcCuuVDwmVHU23lJSgspYMyKpE1iIu9CpjH8h0hv
         GB/iEVaa/N3R9d/x1TUmtDZIZJdyo6tlmDeJm+Zz9NfmtEg0iMH0utFkZBg4bmqXg4Ls
         ig7L5gVxIYPLyPooPfk6KHqjObhWBCNqHSlxivL/ROP2VE4KuqAMBfYfRpLgQCAriGJU
         8U6662Gy2Zxx2m4pVhrLINqJ6o53uRcW8P9D7qWL4SEL/hFTTwZkQE6aXIYAfRi1tt7v
         5Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CrXzr0U/UCG48oVmtVGFrpfm+MNet7TVlFX8LByZalU=;
        b=mL0kWrGdV3RKYH/MkX8Yxlr9O1VuZpeAFF0Z3gIqhoOVkc5yCMcS3GpGj9At9QMROg
         xdhYZNOQ/56B1p75o9+sS53qqX1hDgG2/2dOKnezv1p7ertbG4ioNC17MKTgSSFJm2jv
         0Dq5wRea6MxokflTj3AhZ/XiWEPL4S7lhVQb6446kFep6nYJ/maHtMcB7P17uXLVKK9a
         3oHu1+90KCpgrWVi9uo1mgjsEXzvBtwwxKEqh9x4HAW0hmuAxDg0XuLWD+W+INCqrxp+
         2QYLFTmD1aB92BL4iG3r77KSBHQvMKaIVPLOaxTclYNwD2h6NJOcgwiMAB30h2k63+nG
         yHYQ==
X-Gm-Message-State: AHYfb5g+rBg+KuUBlg4Vi2p5dEyla+JgScs7L7C1bBe/8r0bjWCJdKDY
        rOry6WjoYER1UEBZTKOj4A==
X-Google-Smtp-Source: ADKCNb7oxO8+Sh/viP7cg4ZP7YSv1hrgkuMcgY9yjzzhr7P2SoJKiE7EHlpuK1VyZSanmbkw11QMig==
X-Received: by 10.84.215.204 with SMTP id g12mr11780708plj.410.1503687013459;
        Fri, 25 Aug 2017 11:50:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:f5e9:c606:d78a:b54a])
        by smtp.gmail.com with ESMTPSA id p2sm11703581pgr.4.2017.08.25.11.50.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 11:50:12 -0700 (PDT)
Date:   Fri, 25 Aug 2017 11:50:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170825185010.GA103659@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <20170825173550.GJ13924@aiede.mtv.corp.google.com>
 <20170825174145.x6oa7btkpy5yii54@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825174145.x6oa7btkpy5yii54@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/25, Jeff King wrote:
> On Fri, Aug 25, 2017 at 10:35:50AM -0700, Jonathan Nieder wrote:
> 
> > > Sadly, while splitting these things apart makes the protocol
> > > conceptually cleaner, I'm not sure if we can consider them separately
> > > and avoid adding an extra round-trip to the protocol.
> > 
> > How about the idea of using this mechanism to implement a protocol
> > "v1"?
> > 
> > The reply would be the same as today, except that it has a "protocol
> > v1" pkt-line at the beginning.  So this doesn't change the number of
> > round-trips --- it just validates the protocol migration approach.
> 
> I'm not that worried about validating the ideas here to shoe-horn a
> version field. I'm worried about what "step 2" is going to look like,
> and whether "we shoe-horned a version field" can be extended to "we
> shoe-horned arbitrary data".

I know that this initial RFC didn't mention adding arbitrary data in the
initial request but I fully intend that the final version will allow
such a thing.  One such idea (via the envvar, though the same can be
done with git-daemon) would be to have GIT_PROTOCOL hold colon
delimited values, versions could be indicated by "v1", "v2", etc while
arbitrary key/values as "key=value" such that the envvar would look
like: 'v1:v2:key1=value1:key2=value2'.  This would mean that the client
understands protocol version 1 and 2 (so either are acceptable for the
server to select since there is a change the server doesn't understand
v2 or some other higher version number) and that if supported it wants
key1 to have value 'value1' and key2 to have value 'value2'.

As you said the initial request to git-daemon is limited in length (I
think envvars have a length limit too?) so we would still be limited in
how much data we can send in that initial request and so we should
design a new protocol in such a way that doesn't hinge on adding extra
data in that first request (aside from a version number) but that can
use it to speed things up if at all possible.

> > Can we do that by making it a patch / letting it cook for a while in
> > 'next'? :)
> 
> If people actually ran 'next', that would help. I was hoping that we
> could get it out to the masses behind a feature flag, and dangle it in
> front of them with "this will improve fetch performance if you turn it
> on". But that carrot implies going all the way through the follow-on
> steps of designing the performance-improving v2 extensions and getting
> them implemented on the server side.

We run 'next' here so we will be able to get at least a little bit of
feedback from a small subset of users.

-- 
Brandon Williams
