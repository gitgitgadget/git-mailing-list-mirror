Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348221F461
	for <e@80x24.org>; Mon,  8 Jul 2019 22:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbfGHWVz (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 18:21:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38760 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730462AbfGHWVz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 18:21:55 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so38895110ioa.5
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=75GBEHHw66QZCvI6/llOr4tiiA47z1S7IhgXNiHz33g=;
        b=R0VlQc4OvFrKUt/g4crC1RHuvhtg6TccyRDHbY6faHggFNRwYev5/84N/EuNOcQZUP
         pTCajwAFvVDZWsm6NL+syhv4oJT7UrWXkZSI4ez5KzeNMGGAVf5z7o1/tIUrcugoJzjr
         cpuNOmU3KvnLcAMSaSWPLjn00pR2AT7fdgooDr8ZZ3Q4/RVX5JP/ReZ+mAxoH7j+SlhC
         99VyIGcKIjbWV0XLuHfoxBP9MwRlvUfkTh4N91eZ86sZhCYHVUg6D4L57n5SfSjeV6IP
         XOBqokY3w6oSr8ESdOK8YPsRcFqcDc9xXYmJkwhFVGsDbBIxkTGOT8EgGqbncumxIym5
         hKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=75GBEHHw66QZCvI6/llOr4tiiA47z1S7IhgXNiHz33g=;
        b=gJrKQ39hT30DyV51udKLTkFbUMk2TwRKmhp3kScfsOZ/Wlxii3KA9oGRINjzKn9Jbm
         xSP6jqua0n9I4G8noE6Xus6fB6YNnjGMnjEnfAj/OG96nc/fCU3EHWg8ay+carf/j7cO
         FOrN2420H78mLSCMmI+Xf4SU0/lNugcp4bcaPp1Y9DI4fRMfd8z4ai30Gi+3oW9/lHFD
         51ouvlqP0R63be0sq2n1rkDcnauvDnYVac++4IWzeRPrgAj7VOsz3qjRjWp8Fe06UA4k
         YiF7VSDz/EUNr4SxL1m3WL4Weq81MhfFruEWGZL/9rfcAYWADXAF/i2P8jAQgScqq3Ys
         tRQA==
X-Gm-Message-State: APjAAAUiSDvKiL2fluTceIVKxvY3gquP1ajTqKapvsRKJyGzoA7jSEU3
        YKCNMzKN3eq/hpaSqgwEG4lwApBbyimlqCYduPa5Ww==
X-Google-Smtp-Source: APXvYqx0zdD6DHmNxSQDtBOUGZk9SeM3DAGa9Q7TFqcgIGzRBTROLOZaSujB4mU96J+lDtvHQo7/3DyqUwTpf1auTaE=
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr2555790ioe.86.1562624513611;
 Mon, 08 Jul 2019 15:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560898723.git.matheus.bernardino@usp.br>
 <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
 <20190703085726.GN21574@szeder.dev>
In-Reply-To: <20190703085726.GN21574@szeder.dev>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 8 Jul 2019 19:21:42 -0300
Message-ID: <CAHd-oW4kFtCaogk17r4r1+b3Z_j75+_vcMfunRr5M1XE0VKU8Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to dir_iterator_begin
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review. I'll address those issues in v8.

Best,
Matheus


On Wed, Jul 3, 2019 at 5:57 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> > diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> > index c739ed7911..8f996a31fa 100755
> > --- a/t/t0066-dir-iterator.sh
> > +++ b/t/t0066-dir-iterator.sh
> > @@ -65,4 +65,99 @@ test_expect_success 'begin should fail upon non dire=
ctory paths' '
> >       test_cmp expected-non-dir-output actual-non-dir-output
> >  '
> >
> > +test_expect_success POSIXPERM,SANITY 'advance should not fail on error=
s by default' '
> > +     cat >expected-no-permissions-output <<-EOF &&
> > +     [d] (a) [a] ./dir3/a
> > +     EOF
> > +
> > +     mkdir -p dir3/a &&
> > +     > dir3/a/b &&
>
> Style nit: space between redirection op and pathname.
>
> > +     chmod 0 dir3/a &&
> > +
> > +     test-tool dir-iterator ./dir3 >actual-no-permissions-output &&
> > +     test_cmp expected-no-permissions-output actual-no-permissions-out=
put &&
> > +     chmod 755 dir3/a &&
> > +     rm -rf dir3
> > +'
> > +
> > +test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w=
/ pedantic flag' '
> > +     cat >expected-no-permissions-pedantic-output <<-EOF &&
> > +     [d] (a) [a] ./dir3/a
> > +     dir_iterator_advance failure
> > +     EOF
> > +
> > +     mkdir -p dir3/a &&
> > +     > dir3/a/b &&
>
> Likewise.
>
> > +     chmod 0 dir3/a &&
> > +
> > +     test_must_fail test-tool dir-iterator --pedantic ./dir3 \
> > +             >actual-no-permissions-pedantic-output &&
> > +     test_cmp expected-no-permissions-pedantic-output \
> > +             actual-no-permissions-pedantic-output &&
> > +     chmod 755 dir3/a &&
> > +     rm -rf dir3
> > +'
> > +
> > +test_expect_success SYMLINKS 'setup dirs with symlinks' '
> > +     mkdir -p dir4/a &&
> > +     mkdir -p dir4/b/c &&
> > +     >dir4/a/d &&
> > +     ln -s d dir4/a/e &&
> > +     ln -s ../b dir4/a/f &&
> > +
> > +     mkdir -p dir5/a/b &&
> > +     mkdir -p dir5/a/c &&
> > +     ln -s ../c dir5/a/b/d &&
> > +     ln -s ../ dir5/a/b/e &&
> > +     ln -s ../../ dir5/a/b/f
> > +'
> > +
> > +test_expect_success SYMLINKS 'dir-iterator should not follow symlinks =
by default' '
> > +     cat >expected-no-follow-sorted-output <<-EOF &&
> > +     [d] (a) [a] ./dir4/a
> > +     [d] (b) [b] ./dir4/b
> > +     [d] (b/c) [c] ./dir4/b/c
> > +     [f] (a/d) [d] ./dir4/a/d
> > +     [s] (a/e) [e] ./dir4/a/e
> > +     [s] (a/f) [f] ./dir4/a/f
> > +     EOF
> > +
> > +     test-tool dir-iterator ./dir4 >out &&
> > +     sort <out >actual-no-follow-sorted-output &&
>
> Unnecessary redirection, 'sort' is capable to open the file on its
> own.
>
> > +
> > +     test_cmp expected-no-follow-sorted-output actual-no-follow-sorted=
-output
> > +'
> > +
> > +test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ f=
ollow flag' '
> > +     cat >expected-follow-sorted-output <<-EOF &&
> > +     [d] (a) [a] ./dir4/a
> > +     [d] (a/f) [f] ./dir4/a/f
> > +     [d] (a/f/c) [c] ./dir4/a/f/c
> > +     [d] (b) [b] ./dir4/b
> > +     [d] (b/c) [c] ./dir4/b/c
> > +     [f] (a/d) [d] ./dir4/a/d
> > +     [f] (a/e) [e] ./dir4/a/e
> > +     EOF
> > +
> > +     test-tool dir-iterator --follow-symlinks ./dir4 >out &&
> > +     sort <out >actual-follow-sorted-output &&
>
> Likewise.
>
> > +     test_cmp expected-follow-sorted-output actual-follow-sorted-outpu=
t
> > +'
> > +
> > +
> > +test_expect_success SYMLINKS 'dir-iterator should ignore recursive sym=
links w/ follow flag' '
> > +     cat >expected-rec-symlinks-sorted-output <<-EOF &&
> > +     [d] (a) [a] ./dir5/a
> > +     [d] (a/b) [b] ./dir5/a/b
> > +     [d] (a/b/d) [d] ./dir5/a/b/d
> > +     [d] (a/c) [c] ./dir5/a/c
> > +     EOF
> > +
> > +     test-tool dir-iterator --follow-symlinks ./dir5 >out &&
> > +     sort <out >actual-rec-symlinks-sorted-output &&
>
> Likewise.
>
> > +     test_cmp expected-rec-symlinks-sorted-output actual-rec-symlinks-=
sorted-output
> > +'
> > +
> >  test_done
> > --
> > 2.22.0
> >
