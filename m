Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEEC31F461
	for <e@80x24.org>; Tue, 25 Jun 2019 03:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFYDc7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 23:32:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33690 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfFYDc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 23:32:59 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so640897iop.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 20:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DC/A5opLBbkttG7ZK4qGD6P81SGz9epBjG8njueAIJA=;
        b=Rtwp1QTvZVg8cGCKmOf2PH+XM62IWXf7alWcUGrLMqt8+dQbd876FRPoUlOO08mU44
         SE5c7vyRiMYEJq+lAIXA6HC+gb1Lv57WBZ1LJp+tzO4EuUrmwcU1RaW75fyjuAzcx19c
         odgYsQWonZHcGt3jydvqT/pvPSVc1MOUByPM20ejO2ocIKC6RKCAw7P3cR/6EqA9jmD0
         BMN3O2aqvu2M4/F30O8wpCD5CqjmoF7G7X9AM3VxCXVanOVE7NCnpQFV1XfU4Yb2Txcu
         iy+/Y4/pEF7egRd0JVr1xPlAxjN0x/vkFdc1lpigOUfhc3ATdspc5RPBQ19egEKswKnr
         qHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DC/A5opLBbkttG7ZK4qGD6P81SGz9epBjG8njueAIJA=;
        b=F7917PSKvkcw/Yl8TUY8xgjfk5y08DyfLplEdmORTEbf6lHrDGtAxOwKWJgF1QYORr
         4+ADKAZIuffN67mji3ioHvyu9IeQMmrQ8IVlQ36RxOCNDa9yEH2pzx5Zl5Ud8WE5U5gn
         S5qcwh0gyDOzxVdCB8DvaCO/qVemWm+HJM3SM6B+yDQtEeT5iB/urxU2aolLsAyJNYjl
         MEDr+qVVLTssSEpE60t+Yzlu+4Qj/pjfKjjtU2H/EAQFke0NPYyg5lnZLfMiLVJ4ksl8
         9UD7cRDeXlw1ocJWKYgePEjh77Zs1HQwSNuiPuGP630Rj7Xz0g2Y3KmkczFky4dc+r6t
         JVoA==
X-Gm-Message-State: APjAAAUC0khUvlCQrCvvZkGUF8WjM2esHkH1X9M5wwi7u3G/eNpAyWyz
        sSfC79rGnMB1a7IEHWxMhvk8l12CqgptyMRrCVM=
X-Google-Smtp-Source: APXvYqyrQ6ATMLANnpUGuXb9eWgWhN1ZWaT/YoqrHE3EbTCtdqn4oGNIxCuis91MxLk5/Xjl7fWRawNJWifOI3prW7Q=
X-Received: by 2002:a6b:7312:: with SMTP id e18mr16142508ioh.156.1561433578837;
 Mon, 24 Jun 2019 20:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <20190621223107.8022-14-felipe.contreras@gmail.com> <CACsJy8AATA-7Z+HsA80NQ2j4Z9JeuSYXiBZLi=7FopzfLY1R+w@mail.gmail.com>
 <xmqqa7e6j3u1.fsf@gitster-ct.c.googlers.com> <CAMP44s1hJZs3z=6aHJPzrbW05S=hmVE4RrcRBETzz7iCCqEPPg@mail.gmail.com>
In-Reply-To: <CAMP44s1hJZs3z=6aHJPzrbW05S=hmVE4RrcRBETzz7iCCqEPPg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Jun 2019 10:32:32 +0700
Message-ID: <CACsJy8CLSPdS56O=hJM2FkVa5Qk4V2V_f-dSPMaBYARJLN1oNQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] completion: add default options
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 8:38 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Mon, Jun 24, 2019 at 12:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Duy Nguyen <pclouds@gmail.com> writes:
> >
> > > On Sat, Jun 22, 2019 at 5:31 AM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > >>
> > >> Versions of Git older than v2.17 don't know about
> > >> --git-completion-helper, so provide some defaults for them.
> > > ...
> > >> +__gitcomp_builtin_add_default=" --dry-run --verbose --interactive --patch --edit --force --update --renormalize --intent-to-add --all --ignore-
> > > removal --refresh --ignore-errors --ignore-missing --chmod=
> > > --no-dry-run -- --no-verbose --no-interactive --no-patch --no-edit
> > > --no-force --no-update --no-renormalize --no-intent-to-add --no-all
> > > --no-ignore-removal --no-refresh --no-ignore-errors
> > > --no-ignore-missing --no-chmod"
> > >
> > > And who's going to keep these uptodate? If you do this, might as well
> > > delete --git-completion-helper
> > >
> > > A more acceptable option might be regenerate git-completion.bash and
> > > run --git-completion-helper to generate these, or make
> > > git-completion.bash source a generated file.
> >
> > Nicely analysed and summarized.  What kind of target audience are we
> > talking about?
>
> The people that install their completion independently of their
> distribution. A quick search in Stack Overflow shows hundreds of
> questions, many related to Homebrew and Cygwin.

Which could be answered with installing the right completion version.
I don't think we make any promise of supporting "old" versions anyway
even if used to work.

I could see we add support to source/preload some generated shell
script, so that it works without --git-completion-helper [1]. But
that's about it, the generated scripts that contain all these
__gitcomp_ variables can be packaged and maintained separately. Then
you could even have multiple completion packages for different git
versions if you want. But I'd rather we (git.git devs) do not maintain
these generated variables by ourselves.

[1] which may even gain interest from Windows crowd because there are
fewer processes to run.
-- 
Duy
