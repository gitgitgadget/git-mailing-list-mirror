Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6705220248
	for <e@80x24.org>; Tue, 12 Mar 2019 02:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCLCUJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 22:20:09 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:35950 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCLCUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 22:20:09 -0400
Received: by mail-it1-f176.google.com with SMTP id v83so2016494itf.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OFCNgbLENKp/f26x2g535/siQiNav/BxZYGnacglq+8=;
        b=RZ93c0Giaj1Iqf2srOsj8OBC6WxMv0Bj7p2O0PkE33mxCg2IhyWuyU4hrnVlqZVNwe
         psXAGIvweJ324qZ/fM+EuD/yEaJXKiHP6zqIXs6AwxeagTRL69isDkcHSLxnFQKSQEZi
         OPRYoJetTASEdzwdGMTckUeuhhIKYV7zrIfG8Bs8IudoPoD+0poOh9/VDp4aTQfpVyl9
         5YUjN1Rp5UI7Xcu0uixJ9MGPBIteT4muDLCvo5FCGEOF/E/og3E/UOAdixIJPs85nqRS
         b7FcjbgIs58Kc9Y4Vn42jwNrJ8ZnzhGLXHwanjoYP/8/OJC0LRUrYUTM5Kd7O6lUDMfz
         KcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OFCNgbLENKp/f26x2g535/siQiNav/BxZYGnacglq+8=;
        b=f8OclXzG3hV7Ka+TcoX7wO9YwMMExLno7cxQrcczmeENiaNgHogFuEZEzwZYJzjxCu
         iHJq7ugWGXS5B2gFU7c01HCgIzseSZz3PU7FEyMINughSmTq0+vJjzytUumJl46OyAob
         AmYSdjyfz1H4PiEr4IlNWnVXoU86SXs/JmM6+oJiwTuCddZdwsDL1yrrd1p/P9hEKA1G
         /HMWN281iQJaJ6OH28kufuY0pNr3LO1kadmegdd3hwoGhTgXBV1QMgef2EIGlY8UVDZb
         uJQvNq61PJG9eiZU8Jl/BlRby0Fi+bOwOt/TcaGdlEmJQo7c+j79igZFLCSBdoPnLLTh
         3UYg==
X-Gm-Message-State: APjAAAUSeD17IPXKm7vLqvEzHGY7gxLp6jdcc6kX543I9ZInYtg+rpqH
        0Up52Yh/xp8AEQqrMnI5TQCR9dFUaad/CuUnmXixVdi6
X-Google-Smtp-Source: APXvYqwjv/xpp05MpPRNnOgAupM84kEB8lKs7ucWxoze3I+1FFf6e0qtF/I8oFE2P2i1A6EYT8QailkgLrIa1FddMd0=
X-Received: by 2002:a24:7cc4:: with SMTP id a187mr777854itd.171.1552357208152;
 Mon, 11 Mar 2019 19:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
 <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com>
 <20190311222805.GA6215@flurp.local> <CAH8yC8kHhhWA+ONv17LdLpvy6ubH3CTvJ6=ehP5MQLi_=n1=bQ@mail.gmail.com>
 <CAH8yC8=PKro1_WW=wJQoVHC88cziJPfgkHh6jNKOUxeFn3KVsQ@mail.gmail.com> <CAH8yC8kD3XkYP2o6k3ioCcNB_+wwQ=H2=V03z7Han1K8t2aUsg@mail.gmail.com>
In-Reply-To: <CAH8yC8kD3XkYP2o6k3ioCcNB_+wwQ=H2=V03z7Han1K8t2aUsg@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 22:19:37 -0400
Message-ID: <CAH8yC8k8Y96K6qL4DU5QFuXLYpe+xOGoAA98Ahg6M9Ys0ERD9A@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 10:11 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 9:55 PM Jeffrey Walton <noloader@gmail.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 9:07 PM Jeffrey Walton <noloader@gmail.com> wrote:
> > >
> > > On Mon, Mar 11, 2019 at 6:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > >
> > > > On Mon, Mar 11, 2019 at 05:43:55PM -0400, Jeffrey Walton wrote:
> > > > > On Mon, Mar 11, 2019 at 5:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > > > > On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote:
> > > > > > > I enabled self tests for Solaris. Solaris has some anemic utilities so
> > > > > > > I put /usr/gnu/bin first on-path.
> > > > > >
> > > > > > The first question is if you are really running GNU 'sed'? My guess is
> > > > > > "no, it's still picking up Solaris's 'sed'".
> > > > >
> > > > > I believe so. After modifying PATH, command -v returns:
> > > > >
> > > > >     Solaris tools:
> > > > >          sed: /usr/gnu/bin/sed
> > > > >          awk: /usr/gnu/bin/awk
> > > > >         grep: /usr/gnu/bin/grep
> > > > >
> > > > > (This was added to my scripts to confirm).
> > > > ...
> > > >
> > > > > Maybe Git would benefit from SED, AWK and GREP variables like PERL.
> > > >
> > > > Very possibly.
> > >
> > > Another potential workaround is to use Perl. Perl is already a
> > > prerequisite, it get passed to the test gear through PERL_PATH, and it
> > > avoids Solaris' anemic tools.
> > >
> > > Sadly my Perl sucks. You would be disappointed if I tried to whip up a patch.
> >
> > Oh man, you're using GNU make. I thought Git was using that anemic
> > Posix Make. See attached.
> >
> > I think Solaris provides an older gawk. Is this an easier problem:
> >
> >     awk: chainlint.sed:88: :squash
> >     awk: chainlint.sed:88: ^ syntax error
> >     awk: chainlint.sed:91:  s/\\\n//
> >     awk: chainlint.sed:91:    ^ backslash not last character on line
> >     Usage: awk [POSIX or GNU style options] -f progfile [--] file ...
> >     Usage: awk [POSIX or GNU style options] [--] 'program' file ...
>
> My bad , there was a typo... 'awk' got assigned to SED variable.
>
> This patch works as expected.

https://github.com/git/git/pull/582
