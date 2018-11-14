Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26ED1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbeKOBfZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 20:35:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35706 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeKOBfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 20:35:25 -0500
Received: by mail-io1-f68.google.com with SMTP id u19so7750960ioc.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 07:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eN4k2PN/gZGzsFs3shRDmgJt792oCO+EE+dpBWVCrTg=;
        b=tFZTa6xqeqITvEdmdJPw6hUJuLfyvxAyLbjW3uS+DWciZzo4p9FIcQZl6b+kNOXVBe
         SCG+Ba037FQYm+7ALr3EdzGxGg0SKQ+CLV83XitMyukU2Y+OfGNWM12wWixSt9ll7FFW
         BouyfH1ayaCvJPAlvwXxwhgllTIo0Qi2fhqymLFG1txBYpxFS0i5cwoEHmiMd75eSa4A
         y2uifGCYXQ352JmC2pICL4ZJ7OwGOcvB5jGa6r35uwkAkB6QOVjBaTqeMJvveVmehmcW
         8a3m/rpzluZNOm1EcbwuMJ/Gfy+mTJU+zYrsabALjJHWbp9wsl9w6HCwhSt3dh6sJTpN
         kk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eN4k2PN/gZGzsFs3shRDmgJt792oCO+EE+dpBWVCrTg=;
        b=t2nf3JkMmsYKYHorbLy8H2jwGa4kIt9kJkJ4G6pofkb6c7y/qDpAS4+yQbp0a6u0WZ
         nzSiHhZaH9SkRSAqT+zmgyy0mfTNcDrbV/SepZrm6YnOCBzuaHeBxxAuSby2yYV8TAWP
         hYNRcb/B6dl+qbmLHXFQY8ZMF451ZPCPDoB+s3FL/S2w7iOg41OfQ/AMZgosNMdiqO8S
         Ri/JJnLEk+nK6KqwOLyH37wZzJ5KeFLOBRdXrQBOYPq8XVxvmRmW3qysrkYD91UkAtIj
         /EmOAXFjNZcxZaxOEgegKj3WNp+eporDO5vg5/5Je1dGWfAKZ7dfCklEwtjp+r59wHqu
         Cpug==
X-Gm-Message-State: AGRZ1gL+MAyYaKaZJEkG6bgD/u0UxImjICXhcYhvOSbiIiJHa3zVwIPB
        KhD6lyJ60s5HnlYbkK4hVTO+TVSnB+OnV6WBCkrhmA==
X-Google-Smtp-Source: AFSGD/Ub0zVZEfHXlJyrUNPyk1DaPfjxNeWthCRODjApmswFpOE5ZC1ggf40W9JomI6rrQn+F1d8NCffkXR7NbsEF+0=
X-Received: by 2002:a6b:6f18:: with SMTP id k24mr1222515ioc.236.1542209502116;
 Wed, 14 Nov 2018 07:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20181110133525.17538-1-pclouds@gmail.com> <20181113182800.26984-1-pclouds@gmail.com>
 <xmqqo9asm0hr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9asm0hr.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 14 Nov 2018 16:31:15 +0100
Message-ID: <CACsJy8C663xYVkb8TZVVe-Hwv_V4oO4mJP0UFv4+nfRTX5gzqA@mail.gmail.com>
Subject: Re: [PATCH v2] checkout: print something when checking out paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 11:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > One of the problems with "git checkout" is that it does so many
> > different things and could confuse people specially when we fail to
> > handle ambiguation correctly.
>
> You would have realized that this is way too noisy if you ran "make
> test", which may have spewed something like this on the screen.

Oh I realize it because it's part of my git build and I often use "git
co <paths>". I'm just telling (or kidding?) myself that I'm just so
used to the old behavior and may need some time to feel comfortable
with the new one.

> [19:09:19] t4120-apply-popt.sh ................................ ok     16=
24 ms ( 0.26 usr  0.21 sys +  5.31 cusr  3.51 csys =3D  9.29 CPU)
> [19:09:20] t9164-git-svn-dcommit-concurrent.sh ................ skipped: =
Perl SVN libraries not found or unusable
> [19:09:20] t1310-config-default.sh ............................ ok      1=
77 ms ( 0.07 usr  0.01 sys +  0.89 cusr  0.66 csys =3D  1.63 CPU)
> =3D=3D=3D(   20175;154  1297/?  155/?  6/?  3/3  2/?  4/?  4/?  3/?  5...=
 )=3D=3D=3DChecked out 1 path out of the index
> Checked out 1 path out of the index
> Checked out 1 path out of the index
> Checked out 1 path out of the index
> Checked out 1 path out of the index
> [19:09:20] t1408-packed-refs.sh ............................... ok      3=
10 ms ( 0.06 usr  0.00 sys +  0.69 cusr  0.52 csys =3D  1.27 CPU)
> [19:09:20] t0025-crlf-renormalize.sh .......................... ok      2=
46 ms ( 0.03 usr  0.01 sys +  0.34 cusr  0.22 csys =3D  0.60 CPU)
>
> I am very tempted to suggest to treat this as a training wheel and
> enable only when checkout.showpathcount is set to true, or something
> like that.

Maybe we just drop it then. I'm not adding a training wheel. I'm
trying to make this complex command safer somewhat. But maybe this is
a wrong direction. I'll give the idea "switch-branch / restore-path
alternative commands" a go some time. Then the new generation can just
stick to those and old timers stay with "git checkout".
--=20
Duy
