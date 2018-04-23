Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A241F424
	for <e@80x24.org>; Mon, 23 Apr 2018 18:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbeDWSzE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 14:55:04 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:45086 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932172AbeDWSzA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 14:55:00 -0400
Received: by mail-wr0-f175.google.com with SMTP id p5-v6so16292976wre.12
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KilsQscApD/Gxi8+7Rna8mqgWsRAnGPEY62GQjSmkv8=;
        b=nofK5OxznEBBQGYyFe9wS21SriFFx5sz39DpPQjmMGa1fQAApOxO7UJE/vGmVOqDy+
         oisbdrgvZDObNC5XCK/GwjLljnHAl2d6V7Nq0aeQrhENTy6wFDF+8FjsnA9FNs8sbYfp
         vZEreo4DuyAvfkGO7VMn7reIElTmtauyhDZaOZtrIxeQx+aGjIQC27OjJkrmjMug9dTg
         N0pW9Q18QOs0Rw4jbC190O4YbmG+CYL0vW9fLo/JcFABThZvCd7dxtOoRK/razQRvUW3
         7zBBr4V0y+zHEVUZcAAzRJXQmjYhWxKO54lPjgdQrDW7j0DYm6RgicLIVsZ8KnXejHcP
         Un4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KilsQscApD/Gxi8+7Rna8mqgWsRAnGPEY62GQjSmkv8=;
        b=RgP/w+XSFMudikNqyL387AAehIJvIzAZtTJxCdo9w8xCJXgXZ13LSxwhf8RcN0h+FO
         TwZdKzYXBRARiuwqkSaQmk5WzKiNBXxKlfmoYBJ/T/na4Ag6xU2Sid7ONGGKwqxYQ4JC
         2Df1NSW8xN3T+E5Vb+jCD5dZY39YxHk2LQLYhZH2J6rT0JTT+vPuan/mT1Pb+PMBbybH
         Kk9T/XxC7lfpbojYe8enyOpsKZtGVgx5JT34dYKiqTLIIkwhIWlrb/3MetVFkEVxg5wi
         3GLISgvlrgznj+e/JlhePSw23jSu5qhKG8KbR57UxypYEOQjHABqMr4MN8BAxbl7gp+p
         r+tg==
X-Gm-Message-State: ALQs6tCiyHQGGs+UOLBO2icH9pMqWkTaoMqjRNN4kTxuXIDHbNj16jKI
        q2SlIssvbbh5hdKTSNQhV68=
X-Google-Smtp-Source: AIpwx4+5NEgBbchRj7GhvnKOuMcLFNpuxgeSkbwXHtnTAr1j+nvxbCCdpdVtVyfZLUNTVVsau1xuMg==
X-Received: by 10.28.91.65 with SMTP id p62mr10979142wmb.140.1524509699283;
        Mon, 23 Apr 2018 11:54:59 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c141sm12763111wmh.21.2018.04.23.11.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 11:54:58 -0700 (PDT)
Date:   Mon, 23 Apr 2018 19:55:06 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 2/4] worktree: improve message when creating a new
 worktree
Message-ID: <20180423185506.GC25294@hank>
References: <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180415202917.4360-1-t.gummerer@gmail.com>
 <20180415202917.4360-3-t.gummerer@gmail.com>
 <xmqq604rzytx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq604rzytx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/16, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Currently 'git worktree add' produces output like the following:
> >
> >     Preparing ../foo (identifier foo)
> >     HEAD is now at 26da330922 <title>
> >
> > The '../foo' is the path where the worktree is created, which the user
> > has just given on the command line.  The identifier is an internal
> > implementation detail, which is not particularly relevant for the user
> > and indeed isn't mentioned explicitly anywhere in the man page.
> 
> OK.  Maybe there once was a place or two that took the identifier as
> an input to name a specific worktree to work on (perhaps "prune"?),
> but if we no longer do that (which makes sense, as we should be able
> to uniquely identify a worktree by the path to it), then it makes
> perfect sense to prevent it from appearing in the UI.
> 
> > Instead of this message, print a message that gives the user a bit more
> > detail of what exactly 'git worktree' is doing.  There are various dwim
> > modes which are perform some magic under the hood, which should be
> 
> s/are perform/perform/, I think (no need to reroll, only to fix this).

Now that I'm re-rolling anyway, I'll fix this as well, thanks.

> > Additionally currently the "Preparing ..." line is printed to stderr,
> > while the "HEAD is now at ..." line is printed to stdout by 'git reset
> > --hard', which is used internally by 'git worktree add'.  Fix this
> > inconsistency by printing the "Preparing ..." message to stdout as
> > well.  As "Preparing ..." is not an error, stdout also seems like the
> > more appropriate output stream.
> 
> I think it is a bug for reset to give this kind of informational
> message to the standard output stream.  A rule of thumb I use is "is
> this something that a user who wants quiet operation would wish to
> squelch with --quiet option?" and if the answer is yes, it should go
> to the standard error output, so info and progress should go to the
> standard output in general.

I assume you meant "standard error output" just above?

> But I am OK to unify to the standard output with this patch.  We may
> want to come back and correct _both_ this new message and what reset
> says, but that is outside the scope of this topic.

Cool, I'd rather not add more moving pieces to this series, as it's
already at v7 (v8 soon), but I'm happy to have a look at this and fix
it on top once the dust settled on this series.

> Thanks.
