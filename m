Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B071F424
	for <e@80x24.org>; Wed,  9 May 2018 23:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966011AbeEIXti (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 19:49:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40884 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965990AbeEIXti (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 19:49:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so175565plo.7
        for <git@vger.kernel.org>; Wed, 09 May 2018 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Y/JGu1gwH6oeD0Qx/HISTHDUoB8DmfYBudJ/jEPWKg=;
        b=EmBYK7c32pjBrd3dyAo1PIAhEV9lx1rLdlrWiHvm769DGr2ZFvUp6KmiR8doVF/l+S
         jHUo3TXBPn/k2oiR9HiD+ZIkLQY3P7ceYx5dd5Ea/bqizdKKgmSCHWnXlBmLymdOpHuG
         AFuyyOG+EieOV6PMtgqZ0ubvm7G3JSlq6sdA87dmFw4Zr59GQWuc66Lle5/Ms0d6/s0r
         22w+BUWDxWqDTwUX5ilzwoB3QDclnlAYN36JsuKPSR5FobGKDjGAnukvLW2DI12ikNjH
         XFOMQEydNR0MRkfUol3TZUKnRJGoptUomcof4AowzTZmKCZFKZvQe0Ea4h4KmnNBqGKO
         5NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Y/JGu1gwH6oeD0Qx/HISTHDUoB8DmfYBudJ/jEPWKg=;
        b=ijbMYp9+PHIn5pSIzvVXEkk2sE2zxy7k4dyL2Yn5Cn+TpS+O0EalrGaG986ANJilZf
         nhQ2K640V0py28YiAk3iXzpBk03uOnSZAzw/LX76Al0l6BhcWrJGIoE7vPjUYIIKlqgA
         IzsHt3mrcTxkVIswNsv6MEzRAvpIZ4OLwwm0CvkBJYQPZMMjq8deZ9bfqUnTP1olWF8S
         /kbKAJpZd0YwBYo4FeE9yZK6jCpABdNvgfcXkf7/eakivNX1NCtrXWf50kPkR5TDiHfu
         Lizp9rXucFgRndKkfaUw+iS4M45hyPE3vUYOIrp76sTwaPjiE0TJmjioQ2hDhcryJ3vz
         3Enw==
X-Gm-Message-State: ALQs6tBoSmix1qceSTcNFBCT6WV4nVUBgvVVxVntlpBvZBMRHNQQk779
        jevWg32b3ii+7y+hzig+KHb2pg==
X-Google-Smtp-Source: AB8JxZrJj1ljSfs23KCadvR4njD8XhaCM5RBR8ZnQAod2zE3qHIboqA2DKTlyrmZ1belrZp/l+AEHg==
X-Received: by 2002:a17:902:bcc9:: with SMTP id o9-v6mr15513019pls.56.1525909777428;
        Wed, 09 May 2018 16:49:37 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:eccb:c00:cd8f:fd73])
        by smtp.gmail.com with ESMTPSA id h1sm54875586pfg.135.2018.05.09.16.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 16:49:36 -0700 (PDT)
Date:   Wed, 9 May 2018 16:49:35 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180509234935.GB68889@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
 <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 11:41:02AM +0100, Phillip Wood wrote:
> Hi Taylor
>
> On 09/05/18 03:13, Taylor Blau wrote:
> > Teach 'git-grep(1)' a new option, '--column', to show the column
> > number of the first match on a non-context line. This makes it possible
> > to teach 'contrib/git-jump/git-jump' how to seek to the first matching
> > position of a grep match in your editor, and allows similar additional
> > scripting capabilities.
> >
> > For example:
> >
> >    $ git grep -n --column foo | head -n3
> >    .clang-format:51:14:# myFunction(foo, bar, baz);
> >    .clang-format:64:7:# int foo();
> >    .clang-format:75:8:# void foo()
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >   Documentation/git-grep.txt |  6 +++++-
> >   builtin/grep.c             |  4 ++++
> >   grep.c                     |  3 +++
> >   t/t7810-grep.sh            | 32 ++++++++++++++++++++++++++++++++
> >   4 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> > index 18b494731f..75f1561112 100644
> > --- a/Documentation/git-grep.txt
> > +++ b/Documentation/git-grep.txt
> > @@ -13,7 +13,7 @@ SYNOPSIS
> >   	   [-v | --invert-match] [-h|-H] [--full-name]
> >   	   [-E | --extended-regexp] [-G | --basic-regexp]
> >   	   [-P | --perl-regexp]
> > -	   [-F | --fixed-strings] [-n | --line-number]
> > +	   [-F | --fixed-strings] [-n | --line-number] [--column]
> >   	   [-l | --files-with-matches] [-L | --files-without-match]
> >   	   [(-O | --open-files-in-pager) [<pager>]]
> >   	   [-z | --null]
> > @@ -169,6 +169,10 @@ providing this option will cause it to die.
> >   --line-number::
> >   	Prefix the line number to matching lines.
> > +--column::
> > +	Prefix the 1-indexed byte-offset of the first match on non-context lines. This
> > +	option is incompatible with '--invert-match', and extended expressions.
> > +
>
> Sorry to be fussy, but while this is clearer I think to could be improved to
> make it clear that it is the offset from the start of the matching line.
> Also the mention of 'extended expressions' made me think of 'grep -E' but I
> think (correct me if I'm wrong) you mean the boolean options '--and',
> '--not' and '--or'. The man page only uses the word extended when talking
> about extended regexes. I think something like
>
> Print the 1-indexed byte-offset of the first match from the start of the
> matching line. This option is incompatible with '--invert-match', '--and',
> '--not' and '--or'.
>
> would be clearer

I agree, and would be happy to change it as-such. I think that there is
some pending discussion about regressing 'git-jump' no longer supporting
'--not', so I'll wait for that to resolve before resending this patch.

Thanks,
Taylor
