Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EC8D1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 02:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJBIl0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 04:41:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37391 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeJBIl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 04:41:26 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so476435iob.4
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 19:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+nQXapX+xzuH6IkycVF8Ajyw2oG+VAd7ik3vWWF1DhA=;
        b=Nnqwd0GYJz3VSnWL0sxD5p04jp8QXyDfDxgZajBM9YomR18j13l5sSsuGVIqdr9Gmo
         Ufmlf3GfZhTPLI9eDUxQcw4PoRmU7Ph6JfCf3WVP4WtBQAKhZi+cGp70VwuQUG6dwFxU
         nG2E1WN+8M2aMHs4ZP3OEOf8Ms2nwgXSyFWL6iwVpoU5oAt8mGwWu5EKltVMlvzg0+zY
         j0MIS68B2dhjAND9NxNtEs4oCStLbFdU+fTJej7j8J8J04+0DF4FQ5EhcI6XTo/JA9xC
         SYIssH27uBk/AeWTlRsjOIp4VvjAWYgaYZ95C5CMFQh0K/Wce29CmuHn4i6DtMxgSq41
         GUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+nQXapX+xzuH6IkycVF8Ajyw2oG+VAd7ik3vWWF1DhA=;
        b=BTw8zYAlHsbtB9B1Z1wK3M3CRYbpBVJu9H3wC8uMnbSE/YdE2V3KHDphF/FAg846SN
         w7LhyPpxfAB/5TqCrL51SMxBa2M9s9F8j6qyjM9U9txAM9zl3pQb2U7R/kSui/1SBRJ6
         8SCdQQ9EvLDbY6CRW1XXQUqGmAylnF3rf/gOGUsRCgO2n2ogquvAV4xpEOkgQHFGV5fk
         cmz4cpUuDs1qzNSkurhL9QvJLJo7w2bfU6s7Hq1us6ngtftSpt1ZopTiD/Rj8LGt7C7d
         OMaKnM4XWpe91khXIbOJZ7VCnFGe9JbF/7PR/HNGkVjAm0jBN9+3tjFaeTkVQyuZc2Bp
         W+NA==
X-Gm-Message-State: ABuFfojmY0jQJMK9uqJHSoSN3sgtpPDv+gvC/sA0yEgIQRhwBz85kyWe
        L48Vbhi0p8eV3EZKcfgl8NZZbA==
X-Google-Smtp-Source: ACcGV61jpwLxBWe+F29LgmaVVCXRuhsjxBhVxrLFOrwIXbIzqYu0IdlEYYgejSBeT4bla0fbgTOSTg==
X-Received: by 2002:a17:902:8347:: with SMTP id z7-v6mr14169909pln.147.1538445639051;
        Mon, 01 Oct 2018 19:00:39 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id y24-v6sm2603347pfi.24.2018.10.01.19.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:00:37 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 1 Oct 2018 19:00:36 -0700
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v3 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20181002020036.GA62117@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <48eb774c9e36f468549a278fd8cf703d8a34af28.1538108385.git.me@ttaylorr.com>
 <20180928053057.GD25850@sigill.intra.peff.net>
 <20180928220557.GB45367@syl>
 <20180929073426.GC2174@sigill.intra.peff.net>
 <20181002015737.GF96979@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002015737.GF96979@syl>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 06:57:37PM -0700, Taylor Blau wrote:
> On Sat, Sep 29, 2018 at 03:34:26AM -0400, Jeff King wrote:
> > On Fri, Sep 28, 2018 at 03:05:57PM -0700, Taylor Blau wrote:
> >
> > > > > For example, to advertise only tags, a caller using
> > > > > 'core.alternateRefsCommand' would have to do:
> > > > >
> > > > >   $ git config core.alternateRefsCommand ' \
> > > > >       git -C "$1" for-each-ref refs/tags --format="%(objectname)"'
> > > >
> > > > This has the same "$@" issue as the previous one, I think (which only
> > > > makes your point about it being cumbersome more true!).
> > >
> > > Hmm. I'll be curious to how you respond to my other message about the
> > > same topic. I feel that whatever the outcome there is will affect both
> > > locations in the same way.
> >
> > I think they're separate issues, right? I was just confused on the
> > earlier patch, but the "git config" command you show above is the actual
> > broken case isn't it?
>
> Ah, I certainly had these mixed up on Saturday when I wrote what is
> quoted here. As I understand it now, you were talking about the
> difference between $@ and "$@", which I did fix (by rewriting the former
> to the later).

Double "ah!". You were talking about getting the path to the repository
stuck on the end, which _is_ a problem here. I'll fix that.

> > I'm not overly concerned since this isn't recommending the technique to
> > end users (and in fact the whole point is to give an alternative), but
> > it may be worth showing a working command in case anybody runs across
> > it.
>
> Completely agree, and thanks for your review.

Thanks,
Taylor
