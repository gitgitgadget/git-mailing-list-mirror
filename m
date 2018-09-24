Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A8D1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeIYCYI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 22:24:08 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55401 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeIYCYI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 22:24:08 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so4251557itd.5
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UZUuIEl6l0g9haOZRNe+UMOXDT2SXTnNjIqbkZXhtIg=;
        b=DRgcy6O9aF0oqQPK1hRusUlH+gDTW+MJiSqzxdRc/L6QXUzb22Zo8R5+ExvVnh88nZ
         h4SBHiujSUtoTmZdt/hhpuKjLL7vfztH42qe4f967KQ+QKlFOfSHyekfIJxh6y7Vs2/O
         lIaDX9M5kqyhqttwfVYBhs96KDEZj2phH9aIBxtXtFFh9uEDqN9/1L6j0ciTCOaBwZBR
         zCoWcpWi6LcUF38YLJyLnYlaJSz04nV2cloHdVQjx3tbp74kOzDmaj7RSq0py82B3+lY
         FtpO+q7kp8RSNOoNjggXeuhs6atqGPnneqyEntp0HCUfC66TH/n+jGpyTOYlVA8WDE+q
         74Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UZUuIEl6l0g9haOZRNe+UMOXDT2SXTnNjIqbkZXhtIg=;
        b=pUE3b5PJ2NKoEtVY8QTyQxQ/iP90aIMuEBfdPc2rrcikwo4KX2+1owj2EsKMa15Ko5
         pOlUkJQHx4eYd2Cc32OzJhPfD5RFNDI7cuVY4rDa9UqwzJZFI7qMXj/PCYlcm8uOsX17
         loMVmxt3j1uAui4OQ8avjSw3gKiZgzwRSJ/YAATfsSpLM5/WI/tfVgw3BNRzIYI9s6YV
         np7ooe54yeQ4HeV7F03Spw+TDWR1KAHRrgJPIPUCUDZAli+MSZAtNBjDrkglU4RFjSaC
         WmnYhzPO04osI0HyG9pr6n+7kIkf8dRYhiZMuvq8Hv2vC1EkKdrj/rT5wTboiGThLDr/
         x3GQ==
X-Gm-Message-State: ABuFfoiTXv1YQNJaT8JyM0w0G2kgi/gl4PvrxtlnxHBKFbFTUq3M3CeJ
        pbSRdm3QcpPkxxVaesZoj5Y47/IoGomMwg==
X-Google-Smtp-Source: ACcGV63nmFHN86quG09Z2DxZb9oWmqKUyK/II2Rfi/gPRInh8qdUpjU+BV/A5ateH7Qegtpj6bgOZg==
X-Received: by 2002:a24:ce41:: with SMTP id v62-v6mr90551itg.52.1537820411899;
        Mon, 24 Sep 2018 13:20:11 -0700 (PDT)
Received: from localhost ([75.104.69.134])
        by smtp.gmail.com with ESMTPSA id z2-v6sm101927iom.25.2018.09.24.13.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:20:10 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 24 Sep 2018 15:20:00 -0500
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git help: promote 'git help -av'
Message-ID: <20180924202000.GA88744@syl>
References: <20180922174707.16498-1-pclouds@gmail.com>
 <20180924181927.GB25341@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924181927.GB25341@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 02:19:28PM -0400, Jeff King wrote:
> On Sat, Sep 22, 2018 at 07:47:07PM +0200, Nguyễn Thái Ngọc Duy wrote:
>
> > When you type "git help" (or just "git") you are greeted with a list
> > with commonly used commands and their short description and are
> > suggested to use "git help -a" or "git help -g" for more details.
> >
> > "git help -av" would be more friendly and inline with what is shown
> > with "git help" since it shows list of commands with description as
> > well, and commands are properly grouped.
>
> I agree that "help -av" is likely to be more friendly. I kind of wonder
> if it should just be the default for "-a". Do we have any obligation not
> to change the format of that output?

I agree, though I'd like to clarify what you said before doing so
wholeheartedly.

Did you mean that all existing uses of 'git help -a' should instead mean
'git help -av' (i.e., that '-a' after your proposed patch means the same
as '-av' in revisions prior to this one?)

If so, I agree. I can't imagine a case where I'd like to provide '-a'
and _not_ '-v', so certainly the later should come as a two-for-one
deal. Less, more well-intentioned knobs seems a positive trend to me, so
I am for this idea.

Thanks,
Taylor
