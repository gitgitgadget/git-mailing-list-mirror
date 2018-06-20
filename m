Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0623A1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 14:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeFTOyU (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 10:54:20 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36952 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeFTOyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 10:54:19 -0400
Received: by mail-oi0-f66.google.com with SMTP id l22-v6so3281479oib.4
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDNSB7y2OA59HC6ydqfoeNg7KbK8hZUg2Z+aP0uqBYs=;
        b=j29lgbIiYKNWO2TfP+sOjBmWA2nr5akKu01+KHS93Srh3Z5v8lSxiZBaur3wmgiBg5
         Exwu51qErPbZ/jYUUDAQfdoHI5Xa0xJAcMfAV5zHxBWDz45J6ibGIzCjs0RIh7wVsjfR
         2IppYrWreW9NGOBLeJpaZYU46yEimPx8VH/cYVUJTPs8dO+Juh1t/avs39Y4mLbZlILG
         ORc3HqznWtv3TVcLe3lhoW5kDpJsJ4P1sTmQEfyqtC+GGYSXYdOA1BOybou1Yepx860r
         TD10JT2yyIVyznEWxAMSsXr2A/nKhqoJFrChoUgd1Qx4/XtBzYCsHtbpsiRRpwr4v3O5
         RZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDNSB7y2OA59HC6ydqfoeNg7KbK8hZUg2Z+aP0uqBYs=;
        b=fKdqMh9DaXdStLw/o0e/LIBFyK8nlwtOhkzV6MvCSq6iRZr9RGyNMlVdq5HNWjPWVr
         6V+Tp8tyCLGXCIDUYM7UTc9I8nHfILbljupIo058AXhUgpq3LMNFwy6mQw8TkQHkfBLI
         b9Qyt7NdgO5em69/h/zdJiCibGsWqJIyQLIlzAMOOVJS5WN3N9kSaMU7QZMluolClBRv
         +dCCMf2PDa8JRGdKSYe+ZqDO/C/cl62jB3Dg/QOhfEvUqtYiHZyvvoQ88pLQXxxj6VP+
         /Hv7u48IP3+lTlofMDoBCwhHBuMW5ZDpJDk5ms8Rx+gBVsFXjTAHzV7ScmojIVSe5bhM
         8FnQ==
X-Gm-Message-State: APt69E2ukDXeYYRa8sRb22LAWIq1Yv+kvVQwhvK/nFnEBR4McnJcQwMm
        wfFT18cMYXYSDjkdLb6hk7vL0mtG9CqLZPQQWyY=
X-Google-Smtp-Source: ADUXVKIaIvNJQI9+vN8KvAuoZZ9DRynqnUeEfmXOSD2XbQPaOomSq+DrnNQcjrPyOynOXSy9pKUi/bA21AK7nw9m1Ak=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr12398434oie.30.1529506458303;
 Wed, 20 Jun 2018 07:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <wesfwyupgrg.fsf@kanis.fr> <AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
 <87ocdhlgbl.fsf@kanis.fr> <AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
 <AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
 <87hbj74pve.fsf@kanis.fr> <AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
 <wesy6cgm6wd.fsf_-_@kanis.fr>
In-Reply-To: <wesy6cgm6wd.fsf_-_@kanis.fr>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Jun 2018 16:53:51 +0200
Message-ID: <CACsJy8AeFfi_k9vMm71BTTF-3GQMFPOTXMhfwqKWT-7RFVjoNw@mail.gmail.com>
Subject: Re: Excessive mmap [was Git server eats all memory]
To:     Ivan Kanis <expire-by-2010-08-14@kanis.fr>
Cc:     Dmitry Potapov <dpotapov@gmail.com>,
        Ivan Kanis <expire-by-2010-08-11@kanis.fr>,
        Jared Hance <jaredhance@gmail.com>,
        Avery Pennarun <apenwarr@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 10:27 PM Ivan Kanis
<expire-by-2010-08-14@kanis.fr> wrote:
>
> Dmitry Potapov <dpotapov@gmail.com> wrote:
>
> > On Fri, Aug 06, 2010 at 07:23:17PM +0200, Ivan Kanis wrote:
> >>
> >> I expected the malloc to take 4G but was surprised it didn't. It seems
> >> to be mmap taking all the memory. I am not familiar with that function,
> >> it looks like it's mapping memory to a file... Is it reasonable to mmap
> >> so much memory?
> >
> > AFAIK, Git does not need to mmap the whole pack to memory, but it
> > is more efficient to mmap the whole pack wherever possible, because
> > it has a completely random access, so if you store only one sliding
> > window, you will have to re-read it many times. Besides, mmap size
> > does not mean that so much physical memory is used. Pages should
> > be loaded when they are necessary, and if you have more than one
> > client cloning the same repo, this memory should be shared by them.
>
> I have clone identical repositories and the system starts to swap. I
> think it shows that cloning two repository doesn't share mmap.

I doubt it (assuming you're on linux). If you suspect this, configure
core.packedGitWindowSize to reduce the mmap size. There are lots of
other things in a cloning process that do not share (is this client or
server btw?) and things could add up.
--
Duy
