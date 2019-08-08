Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137401F731
	for <e@80x24.org>; Thu,  8 Aug 2019 12:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfHHMiZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 08:38:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35445 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfHHMiY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 08:38:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so41232922otq.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QLHOpFyQvNTXcyj9pDYnR0nx8BiE0gltvl46OaZNs1Q=;
        b=E85f42z59UlGsxdEXWnxhcndhmxqTaCZiTHE636aNYdWLFU49dNt7+kViwkuB7xzjH
         qLz6y4Q8fVHHX1oCQYkkoungWgjH6OJXnyeaRXTxP4CCEDACLpu5ZETOkOMbmJKxSyH4
         RrTkY6v+YcvwPqdtv0mdxwSTeMzpUIjVZaY9xfrbX+FYlIH70jxrO6hCHkGVIa4dA1TM
         KcnrcvNek5FAZtLHI2g2sTlqieyCgwoM0nAzT0mC/rtp/HFCtCGv8cfXP9F4IxmWTGJr
         sPHg+fgjxrN6DBW75MN3ZEJTl1ji3CyVNtsL8r2oVPAYRRvjCABfs4rwfGnUniU0W3kS
         DVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QLHOpFyQvNTXcyj9pDYnR0nx8BiE0gltvl46OaZNs1Q=;
        b=rckXiA/nNNbhkyRjduKHM+OooaxzVytNlMMdpz1LFy9O3rnKXTaVUVGfJcXhgrXV21
         BvEf7gySnmuyiJ55MmTnFNduEM7yjFrpcHDN0EZZM+2FDRAyf711uJ9oMvLs6xcCXZN8
         0gspVzcMJrStqL52QLm2g4T6ldnFq+frsXJvuXoaIvjwk2tKgd5NMQkk+zNs1EFGw2cF
         CUf+JBsYraoyw0fnqs7H4jSwtKC01OIJqr4RGW8Z3klZMcrHLb1p47nFtLhZoYYP+9mE
         kXP+mm59AKcacfFOrc0t9H/tqfHCAzJQY1vCDGK0Ou3kSaDIcvO24KA5mRQ9zXuyqeP1
         n8pw==
X-Gm-Message-State: APjAAAX8HyY/F1XLgftJDDXdsUOQ8MSTHs6n4U12WiyykrQ9nqG7yd2j
        XltOfsCMxOYT53NJgsg2xmWzwmag1bHiWowuxqc=
X-Google-Smtp-Source: APXvYqyNmHDAFJmHwjpnnAIOYd6WWY57WOozxE+E4ljYHhNSJpXrZFnfOaIrsIBsKVIDuBA+uzgRLF4xmpPmw3NRbhE=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr14975098iof.162.1565267903106;
 Thu, 08 Aug 2019 05:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190806085014.47776-1-carenas@gmail.com> <20190806163658.66932-1-carenas@gmail.com>
 <20190806163658.66932-3-carenas@gmail.com> <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
 <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
 <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de> <CAPUEspj4CrEk6u4+8a5UBisxWsXcwOrOPQ5s9TktA6dZx5s+uQ@mail.gmail.com>
 <f6056e0c-fe7f-30b3-c2d7-bba2b44d6888@web.de>
In-Reply-To: <f6056e0c-fe7f-30b3-c2d7-bba2b44d6888@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 8 Aug 2019 05:38:11 -0700
Message-ID: <CAPUEspi2vu=7uLU19c-wcW+ji63gyeO7poAwS5_7ZhTiBWSxjg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 12:07 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 08.08.19 um 04:35 schrieb Carlo Arenas:
> > On Wed, Aug 7, 2019 at 6:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> >>
> >> Am 07.08.19 um 11:49 schrieb Carlo Arenas:
> >>> was hoping will perform better but it seems that testing can be done
> >>> only in windows
> >>
> >> nedmalloc works on other platforms as well.
> >
> > I meant[1] it works reliably enough to be useful for performance testin=
g.
>
> You mentioned being concerned about performance several times and I
> wondered why each time.  I'd expect no measurable difference between
> using a custom global context and the internal one of PCRE2 -- setting
> two function pointers surely can't take very long, can it?  But
> measuring is better than guessing, of course.

setting the allocator is not a concern, but using it; it requires an
extra indirect function call which is usually not very friendly to
caches in our speculative execution CPU world.  our implementation
also adds the wrapper call overhead, but in this case it is just the
"cost of doing business" with PCRE2.

compilers had gotten a lot better since (mainly because of C++ and the
need for it with virtual methods) but I would rather measure.

> > goes without saying that the fact that I am using a virtualbox with 2
> > CPUs running Debian 10 on top of macOS (a macbook pro with 4 cores)
> > and the test uses by default 8 threads, doesn't help,
>
> nedmalloc is supposed to run on macOS as well.

the last version has some "fix miscompilations in macOS" fixes that
might be relevant, and the version we have in tree says it works in
the 32-bit version which latest macOS versions are working hard to
deprecate (can't even build for it anymore), eitherway trying to run
with a nedmalloc enabled git in macOS is not fun.

> > with the only relevant line (for my code) being 7820.19 where it would
> > seem it performs almost the same (eventhough just adding NED made it
> > initially worst)
> >
> > note though that the fact there are 20% swings in parts of the code
> > that hasn't changed
> > or that where explicitly #ifdef out of my code changes doesn't give me
> > much confidence, but since the windows guys seem to be using NED by
> > default, I am hoping it works better there.
>
> These measurement results are quite noisy, so I wouldn't trust them too
> much.  nedmalloc being slower than the one from a recent glibc version
> is not very surprising given this statement from its home page,
> https://www.nedprod.com/programs/portable/nedmalloc/:
>
>    "Windows 7, Linux 3.x, FreeBSD 8, Mac OS X 10.6 all contain
>     state-of-the-art allocators and no third party allocator is
>     likely to significantly improve on them in real world results"
>
> In particular I don't think that these results justify coupling the use
> of nedmalloc to the choice of using a custom global context for PCRE2.

neither did I either, the only reason I am holding on fully enabling
NED with PCRE2 in my series is just because I wan't to make sure we
have identified the bug correctly and we are fixing it (specially
since I can't reproduce it, and therefore neither debug it)

sorry for not making that clear enough, and as I said before, if we
keep seeing segfaults even after v4 then we will have to do that or I
might need to do a quick run to the nearest microsoft store hoping for
a distracted rep, instead.

> I'd expect:
> - Without USE_NED_ALLOCATOR: xmalloc() should be used for all
>   allocations, including for PCRE2.  Some special exceptions use
>   malloc(3) directly, but for most uses we want the consistent
>   out-of-memory handling that xmalloc() brings.

that is already in v4 and would expect to carry it forward.  this is
also what I had in mind when I said we will need some fixes on top of
Dscho version if we give up with these.

> - With USE_NED_ALLOCATOR: malloc() and xmalloc() use nedmalloc
>   behind the scenes and free() is similarly overridden, so all
>   allocations are affected.
> - If USE_NED_ALLOCATOR performs worse than the system allocator on
>   some system then it's the problem of those that turn on that flag.
>
> Makes sense?

completely, but note also that Dscho version would make the
performance impacts of using a custom allocator (if any) affect
everyone using PCRE2.

Carlo
