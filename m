Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFBF1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966865AbeFSQeT (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:34:19 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36077 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966649AbeFSQeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:34:18 -0400
Received: by mail-ot0-f195.google.com with SMTP id c15-v6so379704otl.3
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UiG89a9kG0Wzc9ygr2ElTJu4yGEAAdV1ue7Yr5LrfLI=;
        b=JTDv1p8/ywXGfCtfx3sIXvhnQzPNpzAQD83mRgToIZEVeQPDC5rRf+XEf7TBwkBW4S
         ag4BAg6dqyJe+RYwY8NklLV/BlmMTSDWOqkYyOEI1NK/IblYFlHiD1IxqMygyN235tvy
         YZHl7XMdn6xrI8rSY5AmOfDRAy2dVX3Z/UqNG6gHE9rc1IqVlX6GeCY+M1f5N3ad7dLZ
         W647iNtezw/toKDHCR43ssKzBllMnT20YJ1JZhb6DBHli9Woo7ODDP6pgu8Hjcgji1hm
         0NtZwJ667Qhxajc08cprcJMp+Uhk/qDgbvKeBq8NRYwsWnrs8db7MPmTUFlhLN8fZtfs
         VFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiG89a9kG0Wzc9ygr2ElTJu4yGEAAdV1ue7Yr5LrfLI=;
        b=fY85kcx5SuF3ETeq7zNEn37p6MdoMRmlke8oNcz5HOFuT8WKD2RyIYN9Iij8vkRM1X
         K94jsFk/9pLQ1MaBHxIYut2CRBO+0QKdvqPhuQapr/tJ/Y1nphkH7uiD0cUKjmMgAWvo
         /Z+aIeiUgeyfZVe4cwmyBA+82fKG4MQR0TP9As+lOa5WMavj5MG8pWlQhVm00ClM9+VM
         ExqFwJkXOpfIz/gTZQHTuLwhHGUsuMpuQGalJ+7EB3sXBYfRKOGJOCc0xL/GlJrrdrkW
         EMh5oD08B1yHyMrc/Ntr35TGdufEenUNdQ9EPyuqXJBg+MtpgiUdZxKzBFynlMsOMdkV
         1csA==
X-Gm-Message-State: APt69E0JnUfVR+dptCGetwSYpVhyaDSS6aXJtRRxDuZnx9VnX+UOs0lu
        lj7atuSiJFN//Fc6SJBdAMiqHw==
X-Google-Smtp-Source: ADUXVKLPU5DFjsm53HvZP4QeSc609V2Eas/Xdz3avNJ69JaNLSEniIR6e3U0MKoyvf+IP+TfHfOfow==
X-Received: by 2002:a9d:155a:: with SMTP id z26-v6mr11450850otz.355.1529426057746;
        Tue, 19 Jun 2018 09:34:17 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id q204-v6sm31797oih.54.2018.06.19.09.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 09:34:16 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 19 Jun 2018 11:34:14 -0500
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 4/7] grep.c: display column number of first match
Message-ID: <20180619163414.GA27246@syl.attlocal.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <df2d08efc1fb717a564157fb760ff71becb658dd.1529365072.git.me@ttaylorr.com>
 <20180619162825.GA22034@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619162825.GA22034@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 12:28:26PM -0400, Jeff King wrote:
> On Mon, Jun 18, 2018 at 06:43:14PM -0500, Taylor Blau wrote:
>
> >  static void show_line(struct grep_opt *opt, char *bol, char *eol,
> > -		      const char *name, unsigned lno, char sign)
> > +		      const char *name, unsigned lno, unsigned cno, char sign)
>
> Here "cno" is unsigned. But later...
>
> > +	if (opt->columnnum && cno) {
> > +		char buf[32];
> > +		xsnprintf(buf, sizeof(buf), "%d", cno);
>
> ...we print it with "%d". Should this be "%u"?

Thanks, that's certainly a mistake. I think (per the hunk of this
response below) that it should be "%zu" in the case that we change this
patch to take an ssize_t.

> But ultimately, the column number comes from this code:
>
> > @@ -1785,6 +1796,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
> >  	while (left) {
> >  		char *eol, ch;
> >  		int hit;
> > +		ssize_t cno;
> >  		ssize_t col = -1, icol = -1;
> >
> >  		/*
> > @@ -1850,7 +1862,15 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
> >  				show_pre_context(opt, gs, bol, eol, lno);
> >  			else if (opt->funcname)
> >  				show_funcname_line(opt, gs, bol, lno);
> > -			show_line(opt, bol, eol, gs->name, lno, ':');
> > +			cno = opt->invert ? icol : col;
> > +			if (cno < 0) {
> > +				/*
> > +				 * A negative cno means that there was no match.
> > +				 * Clamp to the beginning of the line.
> > +				 */
> > +				cno = 0;
> > +			}
>
> ...which is a ssize_t. Should we just be using ssize_t consistently?
>
> We do at least clamp the negative values here, but on 64-bit systems
> ssize_t is much larger than "unsigned".  I admit that it's probably
> ridiculous for any single line to overflow 32 bits, but it seems like we
> should consistently use size_t/ssize_t for buffer offsets, and then we
> don't have to think about it.

I agree that it's unlikely that a single line will overflow 32 bits, and
certainly at that point we might have other problems to worry about :-).

This was an unsigned in my original patch, and I left it this way in the
revised series for consistency with the other arguments to show_line().
But, I agree with your reasoning and think that this should be an
ssize_t, instead.


Thanks,
Taylor
