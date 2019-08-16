Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2871F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 00:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHPAaQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 20:30:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44086 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHPAaP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 20:30:15 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so2889173iop.11
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mno8F9xQRgD08/Q12QdPc+38D/6pJ//6dn58UXm+75Y=;
        b=wFANF1dkwIVFxM7Yv7YaOeeA6VrvsD2xHrNcvE3XFcUeDiBhQ6xjbM33sbd2QRQSf0
         jtkOE8vEX/2oFOOa6v7+vnBAf25cvc1o/71dh8vgLuHDXahf5lUZcGhQs87tf6X4VEL5
         LSUTo99dMqB6jjuQhQ0PU6ckArq7qbpKzheqLCJ9knoE04ALH+05vKLzzwtERzwiOVfo
         XzBqy0NRRoutpkw3Oxc4ulECNtHHH0ip8BXKNYCdKU0hFM2+gRGq/oo62Bm+AFT5ipQP
         827f/ELB49tHgJBAHoNsf2SUMhtfcdBvPDwtWxf687NK9Lq4IG7XflLW/y1VST2ADnBW
         4bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mno8F9xQRgD08/Q12QdPc+38D/6pJ//6dn58UXm+75Y=;
        b=rVFQ32ESmE3A5tWBWVq/77BrJeN+HMNoXXJiEcYW2Hb3dpBhBRjz3MXQE49fty4w72
         sDKdBBBOhSJ9E2on70RQvlshEzURTborJ4sn5YMdLaqTVIHpsbFp3bWgYrgZegHga9Za
         2nSGgJ6+b7rebr6xb+zraKtfS3mTQI8Ml2EgolfbVNHGFSx4JLtCRikuHGtLlI/3BaaN
         UGt3ATqCXyBQbgkdQ8dFb5F5z6gaJrNee2MtoQitjnGtr2eNuZ+cTxT1m+D/k/8ik6g7
         FYPyLIOK/xAhhdEIy3Ctxb/jJDJQUFbB4clTWdj6ASrINHvvBhiszD4+m8ufY/0W6Wq6
         haoQ==
X-Gm-Message-State: APjAAAUTSDs+4TXpPkRlpl8nnAd3VALIsGIp1eHXyAvqpweLxfI3kZ2L
        dZuviPvp4F3wT3zue4nl935ijk/OK9SUQi9DBc4gAg==
X-Google-Smtp-Source: APXvYqyAhMDHmmQDA0nrqh7MG0CxThWIvFEmJsKzNcP1JmfvL0G4clt/jLcEM8JRHdEo5G7NcfD7wxHFT1eBh/fFHuc=
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr1886705ioe.86.1565915414797;
 Thu, 15 Aug 2019 17:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36i35tfv.fsf@gitster-ct.c.googlers.com> <CAHd-oW4kMr+Q1GhNQ7B7RW2hafqokvUoxg9qkXXyt98L53=Ahw@mail.gmail.com>
 <CAPUEspjWbHC2md3kFu8O88275pYSzpFmu9kjHEn4_0_hjxZ8MA@mail.gmail.com> <xmqqef1m4baf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef1m4baf.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 15 Aug 2019 21:30:03 -0300
Message-ID: <CAHd-oW4qo=aTrA90RmWsLeW44WKUiL2x9rzdToFRMq=ebKYksQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2019, #04; Wed, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 1:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > On Wed, Aug 14, 2019 at 4:58 PM Matheus Tavares Bernardino
> > <matheus.bernardino@usp.br> wrote:
> >>
> >> On Wed, Aug 14, 2019 at 6:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> >
> >> [...]
> >> > * mt/grep-submodules-working-tree (2019-07-30) 1 commit
> >> >   (merged to 'next' on 2019-08-02 at e1a46a195f)
> >> >  + grep: fix worktree case in submodules
> >>
> >> There is a new version of this patch here[1], addressing the comments
> >> you and Christian made.
> >
> > since it is already in next, would be better to submit a patch on top
> > of the current topic instead (more details in
> > Documentation/SubmittingPatches).
>
> Thanks.  Or we could just go the lazier route.  A new stable release
> would happen within a day or two, and then in a week or so after that,
> the tip of 'next' gets rewound and rebuilt on top of it.  We can
> discard the older copy and replace with the newer one when it happens.

OK. I'm working on a v2 of mt/threaded-grep-in-object-store which
might depend on this patch. I can then send the newer version of this
patch as part of the series. Is that OK?
