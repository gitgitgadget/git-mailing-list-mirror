Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43792C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D4D61406
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbhI2EY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240872AbhI2EYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 00:24:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F118C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 21:22:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so1321950otj.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 21:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Frq2fXFBY6SGYC5e/X0rbP+sF7kkMFD7uL6njgLtWJY=;
        b=c5a8ztbEOmUSp15LtxakltsS6RjyGgwZN4JporZjqWjYiUJK5EcCyhhC6qePtA45+C
         YnJW6DgU08UfutRze8PYyfVeimgoGuu/ddbwrvni8lamacqnXSEcEb7mwxvDCOcSFCvD
         Hw/Y90KOgZWgou61whzbHdH4cWJptKXpDADUKrBzgxPHDfa/vLsxjEW7cI0lmcgS+55Z
         /Kix6PGdLShXy/sVfG+7MLLu6EVeO+rYvZH8++UbxxpNMrCNcyNK3tXdd1GyfZsywYpJ
         g3aU80V5luBjZoSpp4wdeTm88aVvynIUKLSc/0DiMyWDNerHxsMOT9/mzkovXa6BcE++
         EBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Frq2fXFBY6SGYC5e/X0rbP+sF7kkMFD7uL6njgLtWJY=;
        b=aXTcp9Io2KuPQnqzM6SlOGLz8Iv1aIGUHjJ51Gq9Z3yX470o+tTy41knxa7wsekIYN
         7iSvmw+AAN8DoIYz0NBKTaOu/0O5aQ2Xj8K6hfWaQmoHYJ1g0MXxtRWBuuFe1R3kdkvR
         BssHL8hHSVyWFkKDvjOF0jFR1F3i+btfvyQjjVSI81/VMip/ACExa5MKEvCEesRQ7P28
         9o1poruDIL9BZq7mfRIFy45t5BbIs14POwDUl/zrHA/Uc+CslHN+CzTFFx5e9chNRxF9
         eOO4eiZJU+KJzSSXrzeKt1iiQC8O6FAr1jZ5D+T/gZDBUsffno2sn5Xx+UV3GOaPC809
         eW8A==
X-Gm-Message-State: AOAM533yhT2pzFrMhMAkWqesJEGoZFIgCpfb/l378YoW06dVGuMq0SPq
        pqLayL39Atu6XKuTrmMXMPDmTu+19MioP71y/1LswbBJnm0=
X-Google-Smtp-Source: ABdhPJwRCDgAm1d19bjv8a0k7h3wEJDZKu3jMKmhBZWfy6RBhHFhabNNDhOoQkVCh8yYfbVm6UvZ4CX+MRyz8aiB1CM=
X-Received: by 2002:a05:6830:24ac:: with SMTP id v12mr8394521ots.174.1632889364749;
 Tue, 28 Sep 2021 21:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <87r1d9xh71.fsf@evledraar.gmail.com>
In-Reply-To: <87r1d9xh71.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Sep 2021 21:22:32 -0700
Message-ID: <CABPp-BG_qigBoirMGR-Yk9Niyxt0UmYCEqojsYxbSEarLAmraA@mail.gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 1:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Aug 31 2021, Elijah Newren via GitGitGadget wrote:
>
> I commented just now on how this API is duplicated between here &
> another in-flight series in
> https://lore.kernel.org/git/87v92lxhh4.fsf@evledraar.gmail.com/; Just
> comments on this patch here:
>
> > diff --git a/tmp-objdir.c b/tmp-objdir.c
> > index b8d880e3626..9f75a75d1c0 100644
> > --- a/tmp-objdir.c
> > +++ b/tmp-objdir.c
> > @@ -288,7 +288,36 @@ const char **tmp_objdir_env(const struct tmp_objdi=
r *t)
> >       return t->env.v;
> >  }
> >
> > +const char *tmp_objdir_path(struct tmp_objdir *t)
> > +{
> > +     return t->path.buf;
> > +}
>
> Not your fault & this pre-dates your patch, but FWIW I prefer our APIs
> that don't have these "hidden struct" shenanigans (like say "struct
> string_list") so a caller could just access this, we can just declare it
> "const" appropriately.
>
> We're also all in-tree friends here, so having various accessors for no
> reason other than to access struct members seems a bit too much.

That's a fair point, but just to play counterpoint for a minute...

FWIW, I dislike when our public facing APIs are polluted with all
kinds of internal details.  merge-recursive being a case in point.
When writing merge-ort, although I had a struct with public fields,
that struct also contained an opaque struct (pointer) within it to
hide several private fields.  (I would have liked to hide or remove a
few more fields, but couldn't do so while the merge_recursive_options
struct was shared between both merge-ort and merge-recursive.)

That said, I agree it can certainly be overdone, and tmp_objdir is
pretty simple.  However, sometimes even in simple cases I like when
folks make use of an opaque struct because it means folks put some
effort into thinking more about the API that should be exposed.
That's something we as a project have often overlooked in the past, as
evidenced both by our one-shot usage mentality, and the existence of
external projects like libgit2 attempting to correct this design
shortcoming.  I'd like git to move more towards being structured as a
reusable library as well as a useful command-line tool.

> All of which is to say if you + Neeraj come up with some common API I
> for one wouldn't mind moving the struct deceleration to tmp-objdir.h,
> but it looks like in his version it can stay "private" more easily.

Peff's ideas to just delete and recreate the temporary object store
after every merge would let me reduce the API extensions and keep
things more private.  So I think our ideas are converging a bit.  :-)

> In this particular case I hadn't understood on a previous reading of
> tmp-objdir.c why this "path" isn't a statically allocated "char
> path[PATH_MAX]", or a least we that hardcoded "1024" should be a
> PATH_MAX, as it is in some other cases.

Actually, PATH_MAX shouldn't be used:

https://lore.kernel.org/git/7d1237c7-5a83-d766-7d93-5f0d59166067@web.de/
https://lore.kernel.org/git/20180720180427.GE22486@sigill.intra.peff.net/
