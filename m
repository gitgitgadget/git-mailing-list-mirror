Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A65620248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfDNVMT (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:12:19 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46110 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDNVMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:12:18 -0400
Received: by mail-wr1-f43.google.com with SMTP id t17so19120732wrw.13
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9v6ugNwmxqnqHOvRHezbDciPth40pgVZTVs1ysrMd6s=;
        b=sSJ86vckoUoAYH4jk5RyDAdnqmAHHoZ7VJJfRSAPXWOQfz5NeZF0kCfOht587QOqr+
         s0SxJmMONaW9H2ZE5Fsgh41xiU60yEQuJhAjt6Y3nRwhVfpBCNXgsJJnSWPE6jmLEdHd
         XcRnZFrP2eotxP/36OePyjb58ZyeoWTFldm/rbDh/z4Lp3nkddFRVWSY2uHgzEQaGd4j
         bfj0s0vcGWpxWEISsyyGpW/H7bp8xt5MVlFwbHb+boYoQijN4sZUUkOSRzWpm4WFPDyt
         B01B32oet+qJ98ntZefOrwDEt3iSEB1GNw5yH3IJP8smBaRBYZvOLe7gR8K592VpJ6/X
         6dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9v6ugNwmxqnqHOvRHezbDciPth40pgVZTVs1ysrMd6s=;
        b=eQkfgjLdCxwNzehgHDGYxR6LfBwjr9QNHOAXJRWImjLyXPwOYYsVuVhAukfPQ/IfJ3
         s9kRcwNkZcYfer4PNQFdjWjm+gYJi9UJg5wsHh2gUDNHHV6uikIhIICvq/5udoT0xb7O
         Ie/LRqe153/+nfErc+d25JKAT0TNa7q3WrNd3o8azJ5Z9GNkiNgGk2NxDLGVpg2pL11I
         qQxBJr1JBOz8WS+d+uaIS0P0WIODau1GubA2rioyyL9Pj5X/gQr5/sIe4xwBn7bliEiM
         nkn9BJQCxDWHjXd112WqjqL72sZg7XNjOFqCYXP1EEWdtTG2Odl5GerWJW3vxxVXkATG
         RHtg==
X-Gm-Message-State: APjAAAUOELEuRCT7Q0x2Vje1Kp/0u6XV5KgYEitIMWTDdfVW0z2UGDt0
        EsDB6wlBvfovrTL5GyJXlYQ=
X-Google-Smtp-Source: APXvYqz7JHaFiKRk4FmKsDdS/0VC6cfz8M98o7zqXPPZ54t1kcKGH65iADtOUJjPlrCuztB6fO0c2Q==
X-Received: by 2002:adf:c10e:: with SMTP id r14mr43249745wre.168.1555276336964;
        Sun, 14 Apr 2019 14:12:16 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id f11sm65084466wrm.30.2019.04.14.14.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 14:12:15 -0700 (PDT)
Date:   Sun, 14 Apr 2019 22:12:14 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: incorrect range-diff output?
Message-ID: <20190414211214.GH32487@hank.intra.tgummerer.com>
References: <20190411111729.GB5620@ash>
 <20190411220532.GG32487@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1904121038540.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904121038540.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/12, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Thu, 11 Apr 2019, Thomas Gummerer wrote:
> 
> > On 04/11, Duy Nguyen wrote:
> > > Try
> > >
> > >     git range-diff from...to
> > >
> > > with those two branches from https://gitlab.com/pclouds/git.git. The
> > > interesting part is this
> > >
> > >       diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> > >       --- a/Documentation/gitcli.txt
> > >     @@ -120,10 +111,11 @@
> > >         * linkgit:git-commit[1] to advance the current branch.
> > >
> > >      -  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
> > >     -+  * linkgit:git-reset[1] and linkgit:git-restore[1] (with
> > >     -     pathname parameters) to undo changes.
> > >     +-    pathname parameters) to undo changes.
> > >     ++  * linkgit:git-restore[1] to undo changes.
> > >
> > >         * linkgit:git-merge[1] to merge between local branches.
> > >     +
> > >
> > > This particular hunk comes from giteveryday.txt, not gitcli.txt. And
> > > the b/Documentation/gitcli.txt line is also missing.
> >
> > I think the output here is technically correct, even though it is very
> > misleading.  range-diff doesn't currently show the filenames of the
> > diff that changed, which makes this a bit hard to read.
> 
> True. In the spirit of the "funcname" feature of our `git diff` command,
> we could add some (abbreviated) form of the corresponding `diff` lines
> (maybe just the `a/` filename? Or maybe the `a/` file name, prefixed by
> `-` or `+`, and if the `b/` filename is different, `old->new`? With
> `/dev/null` substituted by `(new)` or `(deleted)`?).

Yeah something like this is what I ended up doing.  Except I was a bit
more verbose, so the filename would be prefixed with "modified file",
"new file", "deleted file" or "renamed file".  Since this doesn't need
to be machine readable in any way, I felt like that might be easiest
to consume for humans. 
