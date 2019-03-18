Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527B120248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCRVsq (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:48:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38162 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfCRVsp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:48:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so18790810wrm.5
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezhBMMa7C9HyOqS9TkMjdBpCnFlkOWxTO3hz7E1ohPg=;
        b=GpJKynmRnbaj9FQZZzdvidSqfZ2MSEVGNk8eKCLkIsO6ScIKKJFeAeiD8GWPzAI1OZ
         yAoQcS+Yssu2IQck1ga5ySVmqdPPFpfNLNkvaL9X55uMiQmm7WYg/L2s4panVmrUAvGS
         dqPChRyzjAOXpzj1ow6DdKFbnp7czDgvW8Mle0wNU8nIXjwWHrQO1DaNaRTPOrWS845x
         SiLye2jjY5bhTKPSSyhbPI+7DlzojUr4jamEdZfUgeWUNgymrHcw5wLQr91Q+udvSg0X
         w1nqP3VQP0fkqOLyGpSuLFZgtujvB94ndsgVvzF1VKJy6kMILCf8o10cp2Mn0lZ/8pL6
         6MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezhBMMa7C9HyOqS9TkMjdBpCnFlkOWxTO3hz7E1ohPg=;
        b=t6iQ1r8lphlYEiII00gUUBbFAa7DjS7bZqB4L+wYT/Fg4kVstECP+g5dPAuK8g/VLN
         pFEIkNwLHhfRGgzpJd1jMeibwj4/E9XRNdQQfgzEQ+8iJMDbZvZVi002hwyC3pqGx2y2
         99UOZamik0VLwNfJT1puUqXgBV72bcoqZOdhQojh3Psoukkwk3MyOhDxpTd8/v7W2hGE
         QD97KKgS0wBUmmX/YZ/9I3R23cJ3dDvlKrXi0kXlbfkTK2oHkz0t/Rt7BDiVamzBFT4G
         OhFP0kEaTvcrkgcuKur3vAQQhelDbzXi77eiLEnHxGsdQAErUKP2eMPU+srbhmm8tnic
         zDYg==
X-Gm-Message-State: APjAAAVsS/s+9ciHv5qRr0ytMQ7fURfihCL9KYjKcsmROJC7xO1mTEMv
        zCS5jkckY8C8sLtRe+xonQI=
X-Google-Smtp-Source: APXvYqxQkFoNGoapn0bfma19eQ5LvgzrSEhPjV4FQljaryoekHjn4im9EU3OLKqhme/k7WzhBhoDyw==
X-Received: by 2002:a5d:6b4c:: with SMTP id x12mr14060199wrw.14.1552945724230;
        Mon, 18 Mar 2019 14:48:44 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id a14sm9822421wrx.96.2019.03.18.14.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 14:48:42 -0700 (PDT)
Date:   Mon, 18 Mar 2019 21:48:42 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190318214842.GA32487@hank.intra.tgummerer.com>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
 <20190313193909.GB3400@sigill.intra.peff.net>
 <20190313201854.GA5530@sigill.intra.peff.net>
 <xmqqzhps6ghl.fsf@gitster-ct.c.googlers.com>
 <20190318211215.GB29661@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318211215.GB29661@sigill.intra.peff.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/18, Jeff King wrote:
> On Mon, Mar 18, 2019 at 11:52:54AM +0900, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > Hmm. I guess it is still an issue in GGG. This thread has identical
> > > timestamps on patches 1 and 2 (and my server received them out of order
> > > by 2 seconds, so mutt orders them wrong):
> > >
> > >   https://public-inbox.org/git/pull.163.git.gitgitgadget@gmail.com/
> > >
> > > I do still think GGG has a more feasible path forward on this particular
> > > bug, though.
> > 
> > If the MSA is rewriting the timestamp (but why?  Is the original
> > date "Wed, 13 Mar 2019 19:20:12 GMT" malformed or perhaps in the
> > future or something?), then there isn't much the sending program
> > can---'git send-email' would suffer from the same symptom.
> 
> I think this statement from me is mid-way through my discovery of the
> actual issue. Yes, if the mail server is rewriting, the best we can do
> is put in an artificial sleep.
> 
> It looks like GitGitGadget just uses normal SMTP to submit the messages.
> I wonder if normal people using gmail as their SMTP server for
> send-email also suffer from this. I've not ever noticed it, but I
> don't know how common that setup is.

I am using gmail as my SMTP server with 'git send-email', and it
doesn't look like gmail is rewriting anything there, see [*1*] for
example.  The date header looks like this:

    Date: Mon, 25 Feb 2019 23:16:04 +0000

Note the +0000 there, compared to the GMT that GitGitGadget uses.
Looking at RFC2822, that's the new version of specifying the timezone,
while GMT is only defined in the obsolete time and date section.  I
guess gmail might just not like that anymore and rewrite it.

So fixing this might not be that hard, and might not involve sleeping
while sending the patch series at all.  Changing how the date is
calculated in [*2*] might be all that's needed.

*1*: https://public-inbox.org/git/20190225231631.30507-1-t.gummerer@gmail.com/raw
*2*: https://github.com/gitgitgadget/gitgitgadget/blob/c37d58cc1581b479892a1f7d29bd16e261676c7d/lib/patch-series.ts#L427
