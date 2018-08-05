Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA011F597
	for <e@80x24.org>; Sun,  5 Aug 2018 01:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeHEDhH (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 23:37:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42558 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeHEDhH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 23:37:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id g6-v6so587015plq.9
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4cQOAWrfg0UW+Qq/zsM8ULNo+L/a8gaCWvBJtidEtos=;
        b=A39+Dlnyds6hyj6BgbUSg6ixb6NdHtl2TmMoy3rCLbyxmFIjB0Qr0h+nT2R0z4JJoe
         WR75a1uixRB72IEmjg1vcZefiQvtSFRXkg0hvH5Rr7UXplAMK48wOyUPTfAIq/hVtOvo
         MojTFNYalUMdC3UZU73UonDFUd4Dn/6rLtjd9J4ZTvWsqUxhtwEjZfpWqdCg8EWpCrwH
         MarzF+aeNQsidToZjBffF9/s7FM/8AzyFYLGJhqch165Cyw1PhH92Rv0VzjhU03MnxXl
         ojKZHEEk14jEbIbIFVMdhbJnCjkMJaDARNxs+pyenGCJda1DzKWi+a0kpAide3RSst5A
         H2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4cQOAWrfg0UW+Qq/zsM8ULNo+L/a8gaCWvBJtidEtos=;
        b=ghYMUkQuKOrffLpDwvDgsojcZNmJn4uch0gneLgXEdQOSkU4hGT6RNWSCB9ud4ev6P
         zIATs3XvwEvpOjjsjnt/ajhAUajFVc0aWP5/0eEBKSut4AwlnJohFLLueEGJuuvdKeCd
         H2aKMfNCJFJg6de4ecXyQAj0exPmC+Ht3VJpuUBkP6ssiiiQDoBA7USVpMP9QcdApa8D
         czO5kKRKOeFHloU6/zOrYHuCXgyobc+r7E3saRM7hw7Vr7zKbG6vmzKsYSNqq6eY3nNn
         08G78W77hZdDC/eSIqF7kHI6OqZkjxq1UTHzGoN5l82VYfq9TjeIl1R6Len2LfvvaCfv
         3Dpg==
X-Gm-Message-State: AOUpUlE4fMxdxY4UrhhDgp2vdNCzCNmqTnQOqfUGki88MPk01Qn3Ha7R
        TnPRzqrTFk2cxvtSoQJj+AxHUuPV
X-Google-Smtp-Source: AAOMgpdfSmm+pvU07MT7M/MOugxenJqGqGtfkRbHJjTC7CjmAUvSOiXcEPLmIcdzGQWks5hTUJIcXg==
X-Received: by 2002:a17:902:988c:: with SMTP id s12-v6mr8934962plp.199.1533432864312;
        Sat, 04 Aug 2018 18:34:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h10-v6sm17324636pfj.78.2018.08.04.18.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 18:34:23 -0700 (PDT)
Date:   Sat, 4 Aug 2018 18:34:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Introduce git-recover
Message-ID: <20180805013422.GC258270@aiede.svl.corp.google.com>
References: <20180804142247.GA7@e3c0ce5ceb57>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804142247.GA7@e3c0ce5ceb57>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Edward Thomson wrote:

> I created a simple shell script a while back to help people recover
> files that they deleted from their working directory (but had been added
> to the repository), which looks for unreachable blobs in the object
> database and places them in the working directory (either en masse,
> interactively, or via command-line arguments).

Cool!  Most of this belongs in the commit message, which is part of why
I always discourage having a separate cover letter in single-patch
series.

> This has been available at https://github.com/ethomson/git-recover for
> about a year, and in that time, someone has suggested that I propose
> this as part of git itself.  So I thought I'd see if there's any
> interest in this.
>
> If there is, I'd like to get a sense of the amount of work required to
> make this suitable for inclusion.  There are some larger pieces of work
> required -- at a minimum, I think this requires:
>
> - Tests -- there are none, which is fine with me but probably less fine
>   for inclusion here.
> - Documentation -- the current README is below but it will need proper
>   documentation that can be rendered into manpages, etc, by the tools.
> - Remove bashisms -- there are many.

One possible path in that direction would be to "stage" the code in
contrib/ first, while documenting the intention of graduating to a
command in git itself.  Then the list can pitch in with those tasks.
There are good reasons for a tool to exist outside of Git, so I
wouldn't recommend this unless we have a clear plan for its graduation
that we've agreed upon as a project, but thought I should mention it
as a mechanism in case we decide to do that.

The trend these days for Git commands has been to prefer to have them
in C.  Portable shell is a perfectly fine stopping point on the way
there, though.

My more fundamental main thought is separate from those logistics: how
does this relate to "git fsck --lost-found"?  What would your ideal
interface to solve this problem look like?  Can we make Git's commands
complement each other in a good way to solve it well?

Thanks,
Jonathan
