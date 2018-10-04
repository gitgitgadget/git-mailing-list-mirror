Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CA41F453
	for <e@80x24.org>; Thu,  4 Oct 2018 02:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeJDJJC (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 05:09:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40575 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJDJJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 05:09:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id 1-v6so4364278plv.7
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 19:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s17rBY0yMj+OdCgx8s59uXgcZlaPl5VYq/kVs1J0Llo=;
        b=iDK/HW4c/KcfVuflsXYH+Rvwobu97o6VV7ZA+mZOlDhqD7gJv0a/sCGFZUtVscia7f
         pG1u2iGzKi3kBN3pjBzfCrq3kbfJiPAsn0v8dFNZX1wg0DErrmZbcnXGr2VwPY5zFzSY
         YKmeqJ/W5K+epBtqer6S6q/4nCmxdQAvn5TekYxdccX42My/KJ1TaiEizGaX+CVcAnEk
         az3YBu90LznbnUOn1kgFIOXvy82urgu9qp6BOzTF7rJw8YOtOdWJ7G2TQDRTv5jIAgwJ
         1k3+nlET3pvWejrrN22s/B4CQC6e9PGRRfAd2FVYSKqZrpY8VgL48/XIYK5gvbIbVnzB
         IWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s17rBY0yMj+OdCgx8s59uXgcZlaPl5VYq/kVs1J0Llo=;
        b=MPI48j6TD14XB2MjUWkPhiCChmZF6rhqFVJWCIWfGjVKqBUx2DTA6OI/z5VoxRRHMg
         gZqj0GJbVvKkahuYDAQ6lziYA02/FwQ0lwcqe1A44xbrnS7/AQHq53U7zAl+5tEilK8/
         wZ9XxEZvRgdnqAxcOeMFt+P9j6Hbge5B/gyRT6TNXb/AXyX6F+dCMiD0Hdi/ckvYZXw9
         OSriySWYvYl+a5c0k2oAJe97+nowsVxXCxV+engZyyA4Haj98f1f1R0bjQpRV553/C64
         uLve26cPjiVDQjhWW65MNIs3CQWu43Drk6ZkoLquCc+rnt+I4aLRJTQfTJcoSPpSeahq
         CX+Q==
X-Gm-Message-State: ABuFfojHxHoJp1zfa2tnh9Ui2rr7kG17AgY3yNdh9DmPeqqU+dS7lBMh
        XMb5j9gHY1UZWUiLZ3HNFAwYtw==
X-Google-Smtp-Source: ACcGV62Z2UYvrcVPN7I7hnMnJ+ABpfS2esmitopNWfHVQn1JAUsNpYzuX3JmHiprVYAdcpGDmhSnaA==
X-Received: by 2002:a17:902:22a:: with SMTP id 39-v6mr4349073plc.267.1538619480710;
        Wed, 03 Oct 2018 19:18:00 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:a0df:6572:743a:8136])
        by smtp.gmail.com with ESMTPSA id c24-v6sm8871322pgn.60.2018.10.03.19.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 19:17:59 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 3 Oct 2018 19:17:57 -0700
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v4 3/4] transport.c: introduce core.alternateRefsCommand
Message-ID: <20181004021757.GA67785@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538446826.git.me@ttaylorr.com>
 <aadb27c0106d8f1a49dd35e7a040131aecaef2c1.1538446827.git.me@ttaylorr.com>
 <20181002234056.GA18516@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002234056.GA18516@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 07:40:56PM -0400, Jeff King wrote:
> On Mon, Oct 01, 2018 at 07:23:58PM -0700, Taylor Blau wrote:
>
> > +core.alternateRefsCommand::
> > +	When advertising tips of available history from an alternate, use the shell to
> > +	execute the specified command instead of linkgit:git-for-each-ref[1]. The
> > +	first argument is the absolute path of the alternate. Output must contain one
> > +	hex object id per line (i.e., the same as produce by `git for-each-ref
> > +	--format='%(objectname)'`).
> > ++
> > +This is useful when a repository only wishes to advertise some of its
> > +alternate's references as `.have`'s. For example, to only advertise branch
> > +heads, configure `core.alternateRefsCommand` to the path of a script which runs
> > +`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
> > ++
> > +Note that the configured value is executed in a shell, and thus
> > +linkgit:git-for-each-ref[1] by itself does not work, as scripts have to handle
> > +the path argument specially.
>
> This last paragraph is trying to fix the wrong-impression that we
> discussed in the last round. But I'm not sure it doesn't make things
> more confusing. ;)

Heh, point taken. I suppose that I won't try to ignore your feedback
here!

> Specifically, the problem isn't the shell. The issue is that we pass the
> repo path as an argument to the command. So either:
>
>   - it's a real command that we run, in which case git-for-each-ref does
>     not take a repo path argument and so doesn't work; or
>
>   - it's a shell snippet, in which case the argument is appended to the
>     snippet (and here's where you can get into a rabbit hole of
>     explaining how our shell invocation works, and we should avoid that)
>
> Can we just say:
>
>   Note that you cannot generally put `git for-each-ref` directly into
>   the config value, as it does not take a repository path as an argument
>   (but you can wrap the command above in a shell script).
>
> > [...]

Yeah, I think that this is certainly the way to go. I took your
suggestion as-is, which I think is much clearer than what I wrote.
Thanks!

> The rest of the patch looks good to me, along with the other three
> (modulo the "expect" fixup you already sent).

Thanks for your review, as always :-). I certainly appreciate your
patience with the word-smithing and whatnot.

Junio, I applied Peff's suggestion directly into my local copy, so I'm
happy to do either of a couple things, depending on which would be
easiest for you to pick up. I could either:

  1. Re-send this patch (in addition to 4/4), or

  2. Re-roll the entire series (with this and 4/4 amended to reflect the
     two bits of feedback I've gotten since sending v4).

I imagine that the later will be easier for you to deal with, instead of
manually picking up patch amendments, but if you'd like fewer email,
that works too :-).

Thanks,
Taylor
