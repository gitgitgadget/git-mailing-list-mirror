Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11C720248
	for <e@80x24.org>; Mon,  1 Apr 2019 03:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfDAD7t (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 23:59:49 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55176 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfDAD7t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 23:59:49 -0400
Received: by mail-it1-f195.google.com with SMTP id n78so2129906itb.4
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 20:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q6ljYzk3S+xfogzKXKolR65SzMozEemWnkJemI+lY7c=;
        b=Qc+3Hq76oYzCnFM1avad6lMwHomjckiPj/q98nSTA1avhGNoCL+iGI+2PlcSZgRSxC
         UCY/ZHrk2YXefRepj9zOGNpDMdQIRzfblYdNh9owAwVIMQPCr/3X+InGVEXGnisOecnC
         p+fAKFpQYLs/7b7QPiv9fUAGi8GGTs7qpa3g0lUiWRxyIfIO+4hWav4daBKqMqyVVIFg
         XZ5wLcNC9Moxko0Q7OmaQbT+YeDVD6Kt5IqEkVhl2nskfjQ1Y8KeNowTGVbqNea8Z0ms
         K0RnE+QHU5ztJf/7IHT4Jxc87DpTzBgkb1+ROqA9BSBORHtVFE8GS+s8GBcDECMFKNjD
         pNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q6ljYzk3S+xfogzKXKolR65SzMozEemWnkJemI+lY7c=;
        b=FmMMD8HYEKkl9uC5L68mfPuLuwByrwHPjXJZ/cf23m0dvA91zpN9R0vW4Xrq48Xpkd
         L6TdH4YQiMdaBMJVy98dN66LEyHe7CEeDbUtmXcb0Ft0BN7pya3ei1tdsKBovnjg9c6O
         Ky9u6x+kaAoH5kj9zHr7aOiDG//R9XwE8FXSo7w+Yuhwu/XR6nDObRaOO0K6zo1dbY9X
         FAEoCo9jSCD/w3vzcG5EBz1pFicYgmKRSSIJuTjeewlHy2w9RfKz6GsURxQViw8Dglel
         2Nvaf+nHK20ggCNMHZmaz9qpFR3GsRVjwTe8iv25fwGMUGcTHB/9S1v+qwFlYkuIEbYr
         M9Xg==
X-Gm-Message-State: APjAAAVfR9wRMJCQN63Wd9iaIzfdUixHZid8anxv55337MX3qSuZl+3N
        CQrXcfrRTz2cbAh+MmOgjmvlxe4sGyNdFlhu984IOA==
X-Google-Smtp-Source: APXvYqzR5q+xnM70PJ0PN/yPFv6KGN+amK2ALnwnXk7MZBlktb4e2TEbmdPP3/eXzmQKj5FT3xyWkhDkuYwyelbNa/M=
X-Received: by 2002:a24:4682:: with SMTP id j124mr10312514itb.90.1554091188342;
 Sun, 31 Mar 2019 20:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br> <20190330224907.3277-3-matheus.bernardino@usp.br>
 <20190331174038.GS32487@hank.intra.tgummerer.com>
In-Reply-To: <20190331174038.GS32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 1 Apr 2019 00:59:36 -0300
Message-ID: <CAHd-oW5+GuSerJMD9XAdCNEFa1qXZFtD=Tov0EyRAn4Hckw9Fw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 2/7] clone: better handle symlinked files at .git/objects/
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 31, 2019 at 2:40 PM Thomas Gummerer <t.gummerer@gmail.com> wrot=
e:
>
> On 03/30, Matheus Tavares wrote:
> > There is currently an odd behaviour when locally cloning a repository
> > with symlinks at .git/objects: using --no-hardlinks all symlinks are
> > dereferenced but without it, Git will try to hardlink the files with th=
e
> > link() function, which has an OS-specific behaviour on symlinks. On OSX
> > and NetBSD, it creates a hardlink to the file pointed by the symlink
> > whilst on GNU/Linux, it creates a hardlink to the symlink itself.
> >
> > On Manjaro GNU/Linux:
> >     $ touch a
> >     $ ln -s a b
> >     $ link b c
> >     $ ls -li a b c
> >     155 [...] a
> >     156 [...] b -> a
> >     156 [...] c -> a
> >
> > But on NetBSD:
> >     $ ls -li a b c
> >     2609160 [...] a
> >     2609164 [...] b -> a
> >     2609160 [...] c
> >
> > It's not good to have the result of a local clone to be OS-dependent an=
d
> > besides that, the current behaviour on GNU/Linux may result in broken
> > symlinks. So let's standardize this by making the hardlinks always poin=
t
> > to dereferenced paths, instead of the symlinks themselves. Also, add
> > tests for symlinked files at .git/objects/.
> >
> > Note: Git won't create symlinks at .git/objects itself, but it's better
> > to handle this case and be friendly with users who manually create them=
.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> > Co-authored-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> > ---
> >  builtin/clone.c            |  5 ++++-
> >  t/t5604-clone-reference.sh | 27 ++++++++++++++++++++-------
> >  2 files changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 50bde99618..f975b509f1 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -443,7 +443,10 @@ static void copy_or_link_directory(struct strbuf *=
src, struct strbuf *dest,
> >               if (unlink(dest->buf) && errno !=3D ENOENT)
> >                       die_errno(_("failed to unlink '%s'"), dest->buf);
> >               if (!option_no_hardlinks) {
> > -                     if (!link(src->buf, dest->buf))
> > +                     char *resolved_path =3D real_pathdup(src->buf, 1)=
;
> > +                     int status =3D link(resolved_path, dest->buf);
> > +                     free(resolved_path);
> > +                     if (!status)
>
> Is there any reason why we can't use 'real_path()' here?  As I
> mentioned in [*1*], 'real_path()' doesn't require the callers to free
> any memory, so the above could become much simpler, and could just be
>
> +                       if (!link(real_path(src->buf), dest->buf))
>

Yes, you are right. I will change this! I sent this v5 before
carefully reading your previous email and studding strbuf functions
and real_path(), now that I did that, I see that real_path() is the
best option here. Thanks!

> *1*: <20190330192738.GQ32487@hank.intra.tgummerer.com>
>
> >                               continue;
> >                       if (option_local > 0)
> >                               die_errno(_("failed to create link '%s'")=
, dest->buf);
