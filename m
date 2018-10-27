Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163D91F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeJ1BtN (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 21:49:13 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:32786 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbeJ1BtN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 21:49:13 -0400
Received: by mail-it1-f193.google.com with SMTP id h6-v6so6941715ith.0
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KDolGtAadKx/Aa4wfis30ewogP5U+iu8vIZY2h1XgOg=;
        b=gMqVgugS5qek6VTynTQVdhTb5Ajw86fQU0Ctn2u27dJlwoPATUUD7SU1oza5mHyEiR
         84cylBn475hGevhuQkvNhxFbPzXRnswXuirSH4FS+OMKxxu0sC1fFr1gS6ANovJCMX2/
         WxaK93ID3z865ZQQKmRGKVpVrMEtWpXUU/qkNSdKhBunGE+IO1umkF2PJ/Rds0BegrIo
         E1/PcAhKRLzxe5BMPMl1eJr7YkE6gnPY0bgLsjaPmzgucybaszR6gMT0NA4EzjwIOuIu
         JzgHvHkV084VQJpHN6Jg3gJ69yNH3EzZCqwviN3Vu0nq3Edy+IG/QZ9HB7ZMKcjXqnZd
         B/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KDolGtAadKx/Aa4wfis30ewogP5U+iu8vIZY2h1XgOg=;
        b=rKge8kaZr2AHQ4mrw9indb5/LcrpD4l22vMHMufWuCbjjankcs0nX7AA+AOTzPNXLu
         AAAH+M8jFjYfRhJZa4MoqPmT5MzGKLhXEyp2Dh6gXff6k/2Aa4UzLo65SfbqX91wlJx3
         a42vMEP+CfdK1q0+S4Xj7QyiRukxBibvcybUV8DF9VA5Wfas+2F2sRtQrHOR1JH0T/x/
         mt+vqZnBJTIGuqQeeYycYiHpnDj+IJq7aeDfCLDtZPt6anNUqL58g5apZ2P7hQCgYZrB
         WIgUr6eCpJ5y5CBFCY+8C2EpdXw/l3vzIA/SMnlCLVePeniG9qhoKNgZl5+XYjAIjK9h
         ltHQ==
X-Gm-Message-State: AGRZ1gJpNSwpOaZ7rlR0PT1WyT/oDYYE0x/66J/ySQjBFi6MrKGtcvSD
        S+OcP0TIaci4xUh7g+UOUvgueGlt/B+ZoO6I/To=
X-Google-Smtp-Source: AJdET5dFBeACP8qovTdPV4qtITHBQzrfzYS4I2Lqd/pYrK8vD5T5T+ZfBtZhEl2qXG0JsfG3aUOEYIkR/g49rrCdM4E=
X-Received: by 2002:a24:a343:: with SMTP id p64-v6mr5697270ite.10.1540660055995;
 Sat, 27 Oct 2018 10:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181027071003.1347-1-pclouds@gmail.com> <20181027081328.GF26685@sigill.intra.peff.net>
In-Reply-To: <20181027081328.GF26685@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Oct 2018 19:07:09 +0200
Message-ID: <CACsJy8Ao2oJoEp8GpSU2DosQ1kf880uvZ0YKWveaehZsNdZhbQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Reduce #ifdef NO_PTHREADS
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 10:13 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Oct 27, 2018 at 09:09:53AM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
> > People seemed to support the idea of removing these #ifdef NO_PTHREADS =
[1]
> > so this is a complete series. I left the #ifdef in run-command.c and
> > transport-helper.c because those code looked complicated so perhaps we
> > could clean them up later. Even these updated files could be updated
> > more, I think, to reduce some code duplication, but I tried to keep
> > the change here minimal.
> >
> > [1] https://public-inbox.org/git/20181018180522.17642-1-pclouds@gmail.c=
om/
> >
> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
> >   thread-utils: macros to unconditionally compile pthreads API
> >   index-pack: remove #ifdef NO_PTHREADS
> >   name-hash.c: remove #ifdef NO_PTHREADS
> >   attr.c: remove #ifdef NO_PTHREADS
> >   send-pack.c: remove #ifdef NO_PTHREADS
> >   grep: remove #ifdef NO_PTHREADS
> >   preload-index.c: remove #ifdef NO_PTHREADS
> >   pack-objects: remove #ifdef NO_PTHREADS
> >   read-cache.c: remove #ifdef NO_PTHREADS
> >   Clean up pthread_create() error handling
>
> Compiling with NO_PTHREADS=3D1, I get (with gcc 8.2.0):
>
> read-cache.c: In function =E2=80=98do_read_index=E2=80=99:
> read-cache.c:1820:4: error: =E2=80=98copy_len=E2=80=99 may be used uninit=
ialized in this function [-Werror=3Dmaybe-uninitialized]
>     memcpy(ce->name, previous_ce->name, copy_len);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> read-cache.c:1749:9: note: =E2=80=98copy_len=E2=80=99 was declared here
>   size_t copy_len;
>
> which seems wrong to me. It's always tied to expand_name_field being
> true. And curiously an earlier use doesn't trigger the warning. I wonder
> if some kind of tricky pointer aliasing in the intervening code makes it
> think that expand_name_field could change, but I sure don't see it.

I couldn't reproduce it with gcc 8.2.0 on gentoo (I tried all
optimization levels just in case). I agree the warning is wrong. But I
will initialize copy_len anyway to avoid this.
--=20
Duy
