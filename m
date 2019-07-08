Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509F91F461
	for <e@80x24.org>; Mon,  8 Jul 2019 11:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfGHLpu (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 07:45:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39239 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfGHLpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 07:45:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so16078240wma.4
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XVbLYv1Eayse/PfFF0v/LNgAHcsaGOeO2W5x5fVhlw0=;
        b=tD7mdvq3A94kho9xhYc1dRW405Vqi5gyzbBDpwiFvktDNTnDgbp/G73FxKRCVFZplS
         8MbNUhu7BCzrEtE/mKfs1nRylK3KygUrCjZQU7Q3I465cqqKjgpppV8wB7oCs4pqRX0S
         pddKs29fEpp8BA825V11z7Q2SDnJtY98EbUPEJ181ABJRG0EyaIFG+wGzuA9/mrQlzEr
         t5FHZNSnrTCjvf+XbHrrRYQZA1sPOoCO8SIQue9lXOvPwdHu37MGcLsjOdEblf2CHfxd
         nRRsTqaVEEwe5M69Ym0jIyoJrJ5+bBuXC+BnjM3pMl5gesYt1bDc2mYYqxflGm75tL0b
         dI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XVbLYv1Eayse/PfFF0v/LNgAHcsaGOeO2W5x5fVhlw0=;
        b=e2oWZVtUzwNVKZRCAz4tslAhj/YtO2Qtl46A1w7J4cgylFuN0E/i/NRjQw0tXTN8h4
         71h0j/N9scsGlNDlP7eXcC7Aa0RKU0wgla1K+BU573Uz5hRD6PwWkHjKpu42rbbX3d88
         oRBj30BkRZG3plXq8kg1DgW+COKagp/gt21l7vbt+9DtdF68g88+H3xqRRldmYBz6OBI
         mem9tRDm1yR9KvMcAHHr9FwElhckAwE5aV16Nq1HlUBbGsplMIAvoPJdjesELIY6hWyc
         xcsAFi/lPKnNVA7lUqohHENrdYKwPGGHQioHB0/mfgKIMUwzWWFCYlCmvbCDZzjU4iw9
         Liig==
X-Gm-Message-State: APjAAAXhJhHpGeQ7b00J08Nbv7xAKiWzr2e7b7RfRbCp+z0JY2SYnOFj
        2mT+8HXprKhWLyq+q51IBT0=
X-Google-Smtp-Source: APXvYqx6X0Wm9BRv2Fm+nZEj7dxB6xxaWYUA5WkbspRpE9LLX6uJb1TFIdCh1azjCqoosBig/02rtA==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr16782597wmc.133.1562586348361;
        Mon, 08 Jul 2019 04:45:48 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id s10sm13644232wrt.49.2019.07.08.04.45.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 04:45:47 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:45:46 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/14] output improvements for git range-diff
Message-ID: <20190708114546.GD16825@hank.intra.tgummerer.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
 <nycvar.QRO.7.76.6.1907052138370.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907052138370.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Fri, 5 Jul 2019, Thomas Gummerer wrote:
> 
> > It's been quite a while since I sent the RFC [1] (thanks all for the
> > comments on that), and the series changed shapes quite a bit since the
> > last round.
> >
> > Since it's been such a long time, just to remind everyone, the goal of
> > this series is to make the range-diff output clearer, by showing
> > information about the filenames to which the current diff belongs.
> 
> Thank you for that reminder ;-)
> 
> > In the previous round, we did this using "section headers" that
> > include information about the current file and adding that to the
> > outer diff's hunk headers.
> >
> > In this round we still keep the section headers (with slightly more
> > information), but in addition we also add the filename to the inner
> > diff hunk headers.  In the outer diff hunk headers we then display
> > either the section header or the inner diff hunk header using a
> > userdiff pattern.
> 
> 
> I like this idea!
> 
> > In terms of code changes the biggest change is that we're now re-using
> > the 'parse_git_header' function from the apply code to parse the diff
> > headers, instead of trying to parse them with some hacky parsing code
> > in range-diff.c.  This way we are sure that the diff headers are
> > properly parsed.
> 
> Yep, very good.
> 
> > I had also considered just outputting the section headers directly
> > from 'git log', but then decided against that.  Parsing the headers
> > allows a future enhancement of range-diff, where we would allow
> > parsing an mbox file [2].
> 
> Thanks you for your consideration; I still would like to have the option
> at some stage to compare a patch series from public-inbox.org/git to the
> commits in `pu`, without having to fiddle with finding a valid base commit
> to apply the patches on.

Yeah, I would like that as well ;)

> > I split the "only pass required data" commits up, in the hopes of
> > making them easier to review, but I'm also happy to squash them if
> > people feel like that makes it easier to review them.
> 
> I found it very easy to review in the current form, thank you for putting
> in the extra effort.
> 
> > An added advantage of this is that we're also getting rid of things
> > like the similarity index, which are not important in the range-diff,
> > and are thus not represented in the "section header".
> >
> > One thing that did not change is that the new/deleted strings are not
> > translated in this version either.  This is similar to the regular
> > diff output, where we also don't translate these.  We can still
> > consider translating them in the future though.
> >
> > [1]: https://public-inbox.org/git/20190414210933.20875-1-t.gummerer@gmail.com/
> > [2]: https://github.com/gitgitgadget/git/issues/207
> >
> > I'm including the range-diff between this version of the series and
> > the RFC, and a diff between the range diff and the range-diff without
> > these changes below.  Probably not useful in reviewing the code, but
> > good to show off the changes made in this series.
> 
> Indeed!
> 
> I very much like the idea, and the current iteration. I offered a couple
> of minor suggestions, in the hope that you find them helpful.

Thanks for your review!  I did find the suggestions very helpful
indeed :)
