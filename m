Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF601F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeFUVpy (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:45:54 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46492 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeFUVpx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:45:53 -0400
Received: by mail-ua0-f196.google.com with SMTP id d7-v6so3003348uam.13
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VtuzuFxYkJZbtywEC0cV0JqBPhzRErX32o5JiIZo47c=;
        b=ziREg2bfgc/krcQCuA2o3OA3ESkbOX3Ta/t7BkrF9UQUNgqx4l8BEhqNPrEfH+71tR
         ItoO9FUTJNnv1PCQkGlFGOQI1ODY7IdRCmtr0ZVbmMysJYBONEQasnrcgeeIS4MXepK5
         YfSoDudyTq2PgznSsEC1Mh8dbL663ZMfculAFIj96BrEaV/nCFlWKERgYZgWUYXy0Jm2
         5woFRjEGg0MlWXp9TH9zLRi3EQpHT/tGH8bxQO15rNkv6z09l3/t6abBOBP0GCokpAg1
         XRpl5o136CulrkfQ24UMFCyxlBq5Se57d/OZXScK6ohk7X1uoc3n7tv1AZfuPdKccdfY
         MJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VtuzuFxYkJZbtywEC0cV0JqBPhzRErX32o5JiIZo47c=;
        b=LKCX82j0689vo7LfO3dMimvs4LXKEoG3ZXxQ23TIc1Ur57sR3rWfz99zX/lsIR4Lvn
         2Lpt6nMsobGaZPduHGak2Goy7VYsjpDFXMwyL5sAt5GR9tsyERmQOLFV23MgMvj5bVsQ
         +Nfyy7mKb0WJw1wUbZyVSdxriPXh57aV35WicdEvz2EsKvvEwsf/nVEThh1+jy/N8FZv
         M3Huuxlfhu9cmNbeen8fhZjIYErZMusay4zjcdE/3Jkreo6BJbUHxgvlRJ10GYsesr3N
         U9vZMH9guXhKXA25bwE3NOTrk3IqRfFO9UNS50hf9yEcdzHhFMKg9v9TgBLjdGSeThYy
         b8xQ==
X-Gm-Message-State: APt69E1c770MGK0UqYX9P1wFdwKFFg7Zmg+DC4Yq6BZg+9pvO+aL+Yt1
        780UxDQ1YKzZLlraQMGe8F3iNA==
X-Google-Smtp-Source: ADUXVKJDo5v+EFslatXJ6dagecb4fRQKuFi/TrAQU7/XfLCQPQ4UXQltLwA1mN92PW1OvCmGhjwDpA==
X-Received: by 2002:a9f:2786:: with SMTP id b6-v6mr17497317uab.174.1529617552400;
        Thu, 21 Jun 2018 14:45:52 -0700 (PDT)
Received: from localhost (net-216-37-85-226.in-addr.worldspice.net. [216.37.85.226])
        by smtp.gmail.com with ESMTPSA id y64-v6sm1446022vkd.22.2018.06.21.14.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 14:45:50 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 21 Jun 2018 16:45:49 -0500
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180621214549.GA47197@syl.local>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
 <20180621115302.GB15293@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621115302.GB15293@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 07:53:02AM -0400, Jeff King wrote:
> On Wed, Jun 20, 2018 at 03:05:30PM -0500, Taylor Blau wrote:
>
> > Hi,
> >
> > Here is a re-roll of my series to add --column to 'git-grep(1)'. Since
> > last time, not much has changed other than the following:
> >
> >   - Fix a typo where 'col', 'icol' were spelled as 'match', 'imatch'
> >     [1].
> >
> >   - Disable short-circuiting OR when --column is given [2].
>
> If we're going to do this, should we be short-circuiting AND, too?
>
> Handling just OR makes this work:
>
>   $ ./git grep --column -e scalable --or -e fast -- README.md
>   README.md:7:Git - fast, scalable, distributed revision control system
>   README.md:10:Git is a fast, scalable, distributed revision control system with an
>
> but not this:
>
>   $ ./git grep --column -v --not -e scalable --and --not -e fast -- README.md
>   README.md:13:Git - fast, scalable, distributed revision control system
>   README.md:16:Git is a fast, scalable, distributed revision control system with an
>
> I wasn't sure where we landed in the discussion on "how much crazy stuff
> to support". But AFAIK, the code in this iteration handles every crazy
> case already except this one. If we're going to care about OR, maybe we
> should just cover all cases.

Good catch. As I understand it, we need to short-circuit AND because an
--invert or a --not above it in the expression tree would cause it to be
turned into an OR by de Morgan's Law, and therefore be susceptible to
the same reasoning that caused me to remove short-circuiting on OR.

> > @@ -1429,7 +1447,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
> >  	 */
> >  	if (opt->columnnum && cno) {
> >  		char buf[32];
> > -		xsnprintf(buf, sizeof(buf), "%d", cno);
> > +		xsnprintf(buf, sizeof(buf), "%zu", cno);
>
> Unfortunately %z isn't portable. You have to use:
>
>   xsnprintf(buf, sizeof(buf), "%"PRIuMAX, (uintmax_t)cno);

I see. Per your next note, I've changed this to "%"PRIuMAX (and the
appropriate cast into uintmax_t), and will send another patch out in the
future changing it _back_ to "%zu" and figure out how folks feel about
it.

I published these changes on my fork at [1], and will let this thread
sit overnight again to see if anyone has any more feedback. Thank you!

> -Peff
Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/compare/tb/grep-colno
