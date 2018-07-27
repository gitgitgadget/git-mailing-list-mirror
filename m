Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4FA1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbeG0TX6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 15:23:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36822 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389064AbeG0TX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 15:23:58 -0400
Received: by mail-io0-f193.google.com with SMTP id r15-v6so4817286ioa.3
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lktsVcOpPSPiG0M8HeQCQsiyuwvFfhKyuWDlegdbCI=;
        b=YRSd6EgYr7eIUtLP1IokS71eUjKcwtwJYW/k6asxc8/HJBGPnkcDizvU0SjAe7/fOU
         Cnlle/BCgyxmZnsw3cWG8kDeQTMnF0zKIMZOMGfTnCek2hUUSxuMQb23zKSfwGNkpnGU
         /oF2qC8WuiG2wwUm9mtRcDGsmc7w65uQoaYaG2pmooOR58NggWroYeYc/XN6vUxP3z3l
         3VqZfb0gZdO0moCpgftYUIO2jIRIF9AoAJVisBdhmgpmXM+zXGPEL4yOZQRYxIcwH6j4
         Q+czGjcJ1MCzJo1FPj6UIvaX5RBaZBS47PBPrImYNIDRSrqNk+9qBgm4nAgx11qLKGDM
         17IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lktsVcOpPSPiG0M8HeQCQsiyuwvFfhKyuWDlegdbCI=;
        b=G2xY2K5Su9f9iHPWqymvANWwcPBo0lz2htGwB/Y7o29tkqdun42M6kFt0vhaleKbe2
         y+vfcdJL+r+z4lIxAgbSPusSuhuThRGKwtjN1hDjMrzt38yKZQa44PhRoKMwyuAUlQLI
         IdI+2IdHzlLelrzgvdnPp/tT2tS+zyW7W23gyP75LVWWXbOdccKjA7QDGVjVTuVZaAnP
         diKq/+CcuQPAuUFaQcn+S9E8YO8PgCxVZV5cSkR1X9/oeVlUWCKyzUrjK47ci6aAdWB5
         XyhCz8S+W7yTJSc8TEmRrJzmN6zUn3SZTZw+ooFur+7Xum9ztZKYB5z46CWUEM8zAF55
         0iQQ==
X-Gm-Message-State: AOUpUlHwQAoo9RTwWEunOKM+ebmwYXeb44AWH7msnHv8u1D6j073iRQl
        fRNoV7zqJ6oTSfv0dtDZy7YE5Ysl4s4+6SNrJhA=
X-Google-Smtp-Source: AAOMgpfCHR6c12T9cWlHrGfYiUDun5poN8T9yxpuo72ntk8sQ/bjvJ2b4bnu5EMtjGRxEmR6OACw3KyxFDtwf8oan+o=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr5520421ioe.282.1532714458097;
 Fri, 27 Jul 2018 11:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180718213420.GA17291@sigill.intra.peff.net> <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com> <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
 <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com> <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
 <20180726163049.GA15572@duynguyen.home> <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
 <20180727154241.GA21288@duynguyen.home> <434074a8-1045-8c8f-da0c-873436acf40e@gmail.com>
In-Reply-To: <434074a8-1045-8c8f-da0c-873436acf40e@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 27 Jul 2018 20:00:31 +0200
Message-ID: <CACsJy8DOhfjMWAb4hP6aoBS6i6DyPuJqj7w2qC3hndo=gy5=zg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 6:22 PM Ben Peart <peartben@gmail.com> wrote:
>
>
>
> On 7/27/2018 11:42 AM, Duy Nguyen wrote:
> > On Thu, Jul 26, 2018 at 12:40:05PM -0700, Junio C Hamano wrote:
> >> Duy Nguyen <pclouds@gmail.com> writes:
> >>
> >>> I'm excited so I decided to try out anyway. This is what I've come up
> >>> with. Switching trees on git.git shows it could skip plenty entries,
> >>> so promising. It's ugly and it fails at t6020 though, there's still
> >>> work ahead. But I think it'll stop here.
> >>
> >> We are extremely shallow compared to projects like the kernel and
> >> stuff from java land, so that is quite an interesting find.
> >>
> >
> > Yeah. I've got a more or less complete patch now with full test suite
> > passed and even with linux.git, the numbers look pretty good.
> >
> > Ben, is it possible for you to try this one out? I don't suppose it
> > will be that good on a real big repo. But I'm curious how much faster
> > could this patch does.
> >
>
> Thanks Duy.  I'm super excited about this so did a quick and dirty
> manual perf test.
>
> I ran "git checkout" 5 times, discarded the first 2 runs and averaged
> the last 3 with and without this patch on top of VFSForGit in a large repo.
>
> Without this patch average times were 16.97
> With this patch average times were 10.55
>
> That is a significant improvement!

Meh! Junio cut down time to like 1/5th in b65982b608 (Optimize
"diff-index --cached" using cache-tree - 2009-05-20). This is not
enough!

OK i'm kidding :) I'd like to see you measure traverse_trees like in
your first mail though. Total checkout number is nice and all but I
still like to see exactly how much time is reduced in traverse_trees()
alone (or unpack_trees() to be precise). That would give me a much
better picture of this unpacking business.
-- 
Duy
