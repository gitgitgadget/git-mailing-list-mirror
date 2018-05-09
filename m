Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7E51F424
	for <e@80x24.org>; Wed,  9 May 2018 23:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965984AbeEIXw4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 19:52:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37823 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965309AbeEIXwz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 19:52:55 -0400
Received: by mail-pg0-f65.google.com with SMTP id a13-v6so130799pgu.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 16:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LKtz83GaE+fbMv53UiJrMFvmgS8O4ox0xXcIbfaUABg=;
        b=neNpuD7vyKS2+7d3l+EJU3ZOW4tYrGDfbfQ7j0TbKwURJCYkdt6vtYOeog7x7/KY+R
         /rstmJRGsDvowbXC3YLnncS7ICrkQpn2zKraf9hZ/3f1re+S71avAdPZzbCAL2rFJ70x
         W4r3VlNncXNTv0OnB140IDyJ3gEJZS85LELo28I0VH5XYaXg+d1CgvalfNAJrHRv8O+Q
         3f4+ehQl25bjLFYziFOccqKLcqWQxWkdsHuoM42/LWg2+DDD9raD5atfa/YQp/UFOZdB
         I1ZtuGLULs5kmu95TChbWPuDuevwtExrh16cso0etwaK+ZSC0BaP488ktBajRbugSwgj
         7AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LKtz83GaE+fbMv53UiJrMFvmgS8O4ox0xXcIbfaUABg=;
        b=Ms3K3RPgBVri1ASlZ/7nR4vTEYbO1X0Rwsy1dhSciW8BTNxlEGQ/c3VXaIK06OWfh/
         w1bXsUOQR+XujK2Jq9gW1LzYhlaFpYDYqsNgkDrxQRQtyWDEtY/o7AM/TYK6jZUKwkPf
         9IAmR1CvRIN5eKkZBplN4nGDbsj0kaHifufRn66ELT3wL6m9CIx7804tEQ7J562CwwZ/
         SuzODnOjhBxG/qseXtjwMG1USWktOBbmcIeV7RLoEvbq7Nr+l+N6m0aQcaBr/UN8LdQl
         APrImASeSdHERSr6b3MWE6nLW9zM2CAj0efW3y9OfXbMqf9GNgkrKESBwmbuXMVgWKkO
         b/0A==
X-Gm-Message-State: ALKqPweouFyX4nTXSi37qcd6DaTAlJWAOHkDhfKyoZryppOC2gVIKMwM
        3YxQF6ecDDrp/uBn/Jv3MwJZ1mjCenHN2w==
X-Google-Smtp-Source: AB8JxZpGOU/x2Y7nCjslWUMMGmZMhPgW6Q0jNzst0+pAWaFQPSycIeFBuWd2izpFlCQb+Rn6zyFiQA==
X-Received: by 2002:a63:715a:: with SMTP id b26-v6mr3109187pgn.440.1525909974660;
        Wed, 09 May 2018 16:52:54 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:eccb:c00:cd8f:fd73])
        by smtp.gmail.com with ESMTPSA id v16sm96786345pfj.123.2018.05.09.16.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 16:52:53 -0700 (PDT)
Date:   Wed, 9 May 2018 16:52:51 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180509235251.GC68889@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
 <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
 <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 07:26:57PM +0200, Martin Ågren wrote:
> On 9 May 2018 at 12:41, Phillip Wood <phillip.wood@talktalk.net> wrote:
> > On 09/05/18 03:13, Taylor Blau wrote:
> >>
> >>   +--column::
> >> +       Prefix the 1-indexed byte-offset of the first match on non-context
> >> lines. This
> >> +       option is incompatible with '--invert-match', and extended
> >> expressions.
> >> +
> >
> >
> > Sorry to be fussy, but while this is clearer I think to could be improved to
> > make it clear that it is the offset from the start of the matching line.
> > Also the mention of 'extended expressions' made me think of 'grep -E' but I
> > think (correct me if I'm wrong) you mean the boolean options '--and',
> > '--not' and '--or'. The man page only uses the word extended when talking
> > about extended regexes. I think something like
> >
> > Print the 1-indexed byte-offset of the first match from the start of the
> > matching line. This option is incompatible with '--invert-match', '--and',
> > '--not' and '--or'.
> >
> > would be clearer
>
> >> +       if (opt->columnnum && opt->extended)
> >> +               die(_("--column and extended expressions cannot be combined"));
> >> +
>
> Just so it doesn't get missed: Phillip's comment (which I agree with)
> about "extended" would apply here as well. This would work fine, no?

This check we should retain and change the wording to mention '--and',
'--or', and '--not' specifically.

> One thing to notice is that dying for `--column --not` in combination
> with patch 7/7 makes git-jump unable to handle `--not` (and friends).
> That would be a regression? I suppose git-jump could use a special
> `--maybe-column` which would be "please use --column, unless I give you
> something that won't play well with it". Or --column could do that kind
> of falling back on its own. Or, git-jump could scan the arguments to
> decide whether to use `--column` or not. Hmm... Tricky. :-/

Agree that this is tricky. I don't think that --maybe-column is a
direction that we should take for the reasons I outlined in the cover
letter. Like I said, there are cases under an extended grammar where we
can and cannot display meaningful column offsets.

With regards to regressing 'git-jump', I feel as if 'git-jump --not' is
an uncommon-enough case that I would be comfortable with the tradeoff.
If a caller _is_ using '--not' in 'git-jump', they can reconfigure
'jump.grepCmd' to work around this issue.

Perhaps this is worth warning about in 'git-jump'? Peff, what do you
think?


Thanks,
Taylor
