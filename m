Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDF620248
	for <e@80x24.org>; Sun,  7 Apr 2019 23:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDGXIG (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 19:08:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35353 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDGXIG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 19:08:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id s39so10004469edb.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JwqgzDsh5+XBg8ycfNY/KCWEcFEj3YdyphqQd3sEzA=;
        b=QjhhM6c4DDmgFqltytSf6FlSOCwKx8y5KG8QoqPDPgNQT7jgG22/0fGTTHBTlg8LbX
         TeFdY1Jhe2HeCC3e36wPnuYB3+09DRfx7qoZdIchGCBXkLbx9V7Cj/9PBVcfXI6lLXCy
         la2Kor3rKOELPl3R5MvL3d5e5AsXiff8pMEXaQYufXSru0nGSdJdtNp1YIWfLPPJD3yD
         jrR8QiSS8sxQlVUj0yH8exEZEJuNBkuqKtDYZkMdy2kMKKbAsTt/VkOtm+wA8CbN1vq9
         rVWNHi3ijLS1iKGEqv4+1IXHWWbbw0KBQbotXYXaWOWeYD7rrYHA5SVanlU5N40yUZvQ
         KhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JwqgzDsh5+XBg8ycfNY/KCWEcFEj3YdyphqQd3sEzA=;
        b=oFZA7XNidvHPGx/g/8iPtkQWYhT7uZA9ZTIAFgd3vFUmHx49A7mhR+sncbuml0+owq
         bfcsXoBdQ9cOVb5maQjbgwo78bPbKgsqdllfzbaIXOGZAfHLEcr3HBTM09OhnnvW+NwU
         5fOX5yy4+G+ZXpmLt03vgyn2oDoIE+nL56MzlOToQfX77nvwwJJ0aqACuxy2QtjU/onr
         4/KLnf1nwa6u0xl1PgfCMNduBegrLr7pBT/UAK4NZBoQFVHCP2S5x7iQHsvUlJb956bD
         TEyIA14DbxW66w43/YJId/upizmFY/z+tueYlTLmRyaHRttPoSfRb156If6wkUUfbN5n
         c7bg==
X-Gm-Message-State: APjAAAVhwJDootqGk4TsP2mbQWdN+U8wWOOVzROR+pXtg3ecTyCxvChg
        ioYXOzttYkLEiV3S7PeD8k7XmhdsMs8I613LtsE=
X-Google-Smtp-Source: APXvYqz9HyzkC7vvdND71F7dGEQLxc3Fv/wINPOQGukm8rczoT2a6+i+pTrCW0V9jPd7ROTDDllwgsTuRg/dUD3GFqc=
X-Received: by 2002:aa7:d3d8:: with SMTP id o24mr16904080edr.53.1554678484779;
 Sun, 07 Apr 2019 16:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD12GXV80SVi5UR=mpBox9DFWw0Fp2wrf+1FEXbUdX1ReA@mail.gmail.com>
 <20190407121640.3737-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190407121640.3737-1-rohit.ashiwal265@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Apr 2019 01:07:53 +0200
Message-ID: <CAP8UFD05JDsh2v15GgP+LpPKVAK-Dg4k0aicScY5p=za4gsTGw@mail.gmail.com>
Subject: Re: [GSoC][RFC v3] Proposal: Improve consistency of sequencer commands
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        rafa.almas@gmail.com, Stephan Beyer <s-beyer@gmx.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Sun, Apr 7, 2019 at 2:17 PM Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
>
> On Sun, 7 Apr 2019 09:15:30 +0200 Christian Couder <christian.couder@gmail.com> wrote:
>
> > As we are close to the deadline (April 9th) for proposal submissions,
> > I think it's a good idea to already upload your draft proposal on the
> > GSoC site. I think you will be able to upload newer versions until the
> > deadline, but uploading soon avoid possible last minute issues and
> > mistakes.
>
> Sure, I'll upload my proposal as soon as possible.

Great!

> > It looks like you copy pasted the Git Rev News article without
> > updating the content. The improvement has been released a long time
> > ago.
>
> The intention was to document how the project started and *major* milestones or
> turning points of the project. Here they are.

Yeah, the intention is good, though it would be nice if the details
were a bit more polished.

> > Maybe s/rebases/rebase/
>
> Yes, :P
>
> > It seems to me that there has been more recent work than this and also
> > perhaps interesting suggestions and discussions about possible
> > sequencer related  improvements on the mailing list.
>
> Again the idea was to document earlier stages of project, "recent" discussions
> have been on the optimizations which are not exactly relevant.

I think there were ideas (from Elijah) about using the sequencer in
the regular (non interactive) rebase too.

> Should I write more about recent developments?

I think Alban's GSoC project was relevant too.

So yeah, if you have time after uploading your proposal to the GSoC
web site, it would be nice if you can update it with a bit more
information about what happened recently.

Thanks,
Christian.
