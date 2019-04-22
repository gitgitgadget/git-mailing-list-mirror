Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622571F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 19:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfDVTy0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 15:54:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44993 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbfDVTtn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 15:49:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so6183651pfm.11
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5nLRFR6dnkzvMKwYRY2WN3lUtID3OneXji/QulcMezw=;
        b=eyYe08jrQhvLXmEvPE1MueIlhua1Zm+oiXD90MU1z8u3oGr0OVM37kSqOCccXCaeJX
         zRLWrJd2Xx5qCldqLqZBSB9wwTsB4RGAh9Ga4vdRTnS35+UGGbKd//sx1RYuTzfL9ofk
         SPYRM1v2oD9Np4CKB0o+rIvNZZuKdjbNQDBaNHNHHLM6HDQyEVWpDudCNl3QnLVFvFZt
         d8rJ81eYPAwJUPS6oDflnlEzc4EGw/AgFeudpvPJReuMgzH0KLTNQby3YBeZbo8zf9Fc
         kAXJGMKoYcCWZgdO2e/gUwWrwS2vUJjQar4bNUPSXHqGviGvJ0uCp0lubU5w0xL1fXgC
         +a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nLRFR6dnkzvMKwYRY2WN3lUtID3OneXji/QulcMezw=;
        b=KvjPTVIaBcSgSYb/i9rkdlhq8chU5TYvzu7h87kj8aATmCOm60K0PS7XdwhJ+G4eSe
         0a8eQr6nwEVlZeym6sm60Lk5y5HkjWM2CBoJE9qj/gtzTUKJeenvxmTFFLeyeqPgMbWM
         /zObCpicW7sYZSVS8bA8a2ypHU7U8z3znXn0oycyv5uPVNe1Wc7cExP4ja/mGiOFmnp1
         Ukm+aNPym9KxPn41RrohMpLZGLluYh8YuGyyhYQwGlhvRMQvC4qCuE0y0CiuckRPItvp
         WSrUapXdlH4LnuVF2ZAKagopNffA4/PPI//cNjKFjFm/zk6BqFwGRYpI2A+TFU9o2IQC
         ZlNA==
X-Gm-Message-State: APjAAAXxVIUP2ljRgxACELXEtHzrSu6m9B/jBg4BlnKkd8qE18qtv2xD
        O4kGaPbw2Ms7xk1RFNR4FRzJFQvh
X-Google-Smtp-Source: APXvYqwN5pxX7YBbuVAyAWg/f+X3HF5b2DPGAKHyjhr5cYfa/4ARwdVcE2KZ9PNaE8M7js7mHwdsYw==
X-Received: by 2002:a62:5a42:: with SMTP id o63mr23359206pfb.170.1555962582737;
        Mon, 22 Apr 2019 12:49:42 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id b7sm23172588pfj.67.2019.04.22.12.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 12:49:42 -0700 (PDT)
Date:   Mon, 22 Apr 2019 12:49:40 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
Message-ID: <20190422194940.GA10592@dev-l>
References: <20190422000712.13584-1-phil.hord@gmail.com>
 <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
 <623d6ebd-60c4-916d-6295-4c648dbf3932@gmail.com>
 <CABURp0r9DBxoxLjjynNj-px7mFBA5--ZS7SoNniNu7MLPZkqwg@mail.gmail.com>
 <CABURp0pEB-3m=wbWsVc9C82d3Jf2UW4fXnsSZ+GnTHKWRJo0NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABURp0pEB-3m=wbWsVc9C82d3Jf2UW4fXnsSZ+GnTHKWRJo0NQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phil,

On Mon, Apr 22, 2019 at 12:20:29PM -0700, Phil Hord wrote:
> On Mon, Apr 22, 2019 at 12:16 PM Phil Hord <phil.hord@gmail.com> wrote:
> >
> > I have the same need.  I plan to have some switch that invokes this
> > "in-place rebase" behavior so that git can choose the upstream for me
> > as `mergebase $sequence-edits`.  In fact, I want to make that the
> > default for these switches, but that feels too surprising for the
> > rebase command. I plan to progress like this:
> >
> >     # --in-place switch is not supported; manual upstream is given by user
> >     git rebase --edit foo foo^
> >
> >      # --in-place switch is added; now we can say this
> >      git rebase --edit foo --in-place
> 
> I originally CC'ed Denton on this thread because he recently added
> --keep-base.  I initially hoped it would do something similar to
> --in-place, but on reading the patch discussion, I think it's for
> something different altogether.  :-\   It's similar, though, in the
> same way that --fork-point is; which may be another way to say "not
> very."

You're correct, --keep-base is a little more explicit than your proposed
--in-place switch in that the former requires an upstream revision be
specified whereas yours implicitly finds the base using the
$sequence-edits. I suppose until --in-place is implemented, users could
always use explicitly specify the upstream branch, such as:

	$ git rebase --edit foo --keep-base master

Anyway, I've been following along with the discussion and although there
are kinks to iron out, I like the general idea. Although I use fixup and
squash commits + rebase -i --keep-base for major branch polishing,
sometimes after the branch is mostly polished, there are a few
last-minute changes to be made. I think that your proposed solution
would also match my use-case nicely.

Thanks,

Denton
