Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB5B1F42D
	for <e@80x24.org>; Fri, 11 May 2018 08:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbeEKIoR (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 04:44:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35266 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeEKIoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 04:44:16 -0400
Received: by mail-oi0-f67.google.com with SMTP id a6-v6so4111856oia.2
        for <git@vger.kernel.org>; Fri, 11 May 2018 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Rz2qIee7fY4bRWFcERwI7WQ/B2mpEemb/on7h19IHo=;
        b=XdTqjL3ULcbKvBURGGDsDOjUxU7TECD5tvYtjfWOyGppiiK2NKaRw9VhL9x9cL6KdN
         dpDaFdghFrGdKxvgGxpECSeNgG8RpRx1if8xhbWZVUkNfIXP5aTPViKXMaiCcWkLQVnt
         2qzlTkyiCRmS3aleEyS6xaNuY6G/Ws9nQEONam/mcFnJa4YAt5O/j8+IrI2jKkXSLg4+
         EhSB+IxK3nLTVRTVDEr45+Mn+ywz9ArRpwvCu211TLWL8FUAowNGXyOjcRESqhZ8IooP
         kCgGrom1Aloj4m0w/UcKZnfhnDozqXLRAwo1qQQI2TFiNU82kufyY6eoFLVfIDVOKehu
         3XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Rz2qIee7fY4bRWFcERwI7WQ/B2mpEemb/on7h19IHo=;
        b=rSdmzxaJILiMsrLsburQY1a31Lv12KZtz47WWByoFlhV0ysNWdezuO1KRmU2qq0lJC
         hgGgs/RBxuotU33lvaR8rA1E0B5jv4KC5pdXzMsothx68pDFM/E7O9sXD0Fht+22fcl4
         rtf0r6i1+eQikm3QosRkSmNrqWoYLnqOQqFtErKcdiRJwbuUb22Bi1aZZXQ7+PWoLsgw
         xTlj8Y2sdbQnAzjAVnkKxzQKbQssn9iJ1rpB/Nm7uw5dcTR+78vrV92QpDGHxxnY+9go
         pdRf6s6cxcSMvhsXipttdfYMu8Mv2Mp36MZebvrGeES5vQmsruR2BXOqCmWQoIQCD8Ww
         fKLw==
X-Gm-Message-State: ALKqPwewf59zIiY2iNWpp5kLjj6LBRzvN6NuPDaQQPovMXrFvAnww9sl
        ClXBYHcWGNPm08nl/Bwi5ViVW6Q49e+T2I3s/XY=
X-Google-Smtp-Source: AB8JxZoRjvjNYpPU3L2VXy0P1tX+H2ebse4N2Orze13V580ovh5bYNWdEKJjTJUOVpyMoNfK0omFVyWPyMuCem1f5x0=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr2894987oig.34.1526028256068;
 Fri, 11 May 2018 01:44:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 11 May 2018 01:43:45 -0700 (PDT)
In-Reply-To: <20180511082840.GA22086@sigill.intra.peff.net>
References: <20180511075602.9182-1-pclouds@gmail.com> <20180511082840.GA22086@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 May 2018 10:43:45 +0200
Message-ID: <CACsJy8CE2tnhH6eds6ZePyMxFXGnnyHDkWjSBbJz97BmYFr-gg@mail.gmail.com>
Subject: Re: [PATCH] tag: fix column output not using all terminal space
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 10:28 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 11, 2018 at 09:56:02AM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> git-tag runs a separate git-column command via run_column_filter().
>> This makes the new 'git-column' process fail to pick up the terminal
>> width for some reason and fall back to default width. Just explicitly
>> pass terminal width and avoid this terminal width detection business
>> in subprocesses.
>
> I think "some reason" is that we start the pager before running "git
> column". Running "git --no-pager tag --column=3Drow" seems to fix it.
>
> It doesn't seem to have anything to do with the pager program itself.
> Doing:
>
>   # use sh to avoid optimizing out pager invocation
>   GIT_PAGER=3D'sh -c cat' git tag --column=3Drow
>
> shows the same problem. It looks like we force term_columns() to run
> before invoking the pager in order to cache the value. That makes sense,
> since TIOCGWINSZ on stdout is not going to be valid after we start
> piping it to the pager. But of course our git-column sub-process won't
> see that; the value is cached only in memory.
>
> So I think the approach of communicating the width to the sub-process is
> the right one. But I think we'd probably want to do so through the
> $COLUMNS variable, rather than passing a command-line option. That would
> fix the same bug for other cases where we might have multiple layers of
> sub-processes (e.g., if we pipe to the pager and then run a hook which
> columnizes output).
>
> Something like this seems to make it work for me:
>
> diff --git a/pager.c b/pager.c
> index 92b23e6cd1..c4f3412a84 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -162,8 +162,12 @@ int term_columns(void)
>  #ifdef TIOCGWINSZ
>         else {
>                 struct winsize ws;
> -               if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col)
> +               if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col) {
> +                       char buf[64];
>                         term_columns_at_startup =3D ws.ws_col;
> +                       xsnprintf(buf, sizeof(buf), "%d", ws.ws_col);
> +                       setenv("COLUMNS", buf, 0);
> +               }
>         }
>  #endif
>
>
> though perhaps that should go into setup_pager(), which is what is
> actually making stdout inaccessible.
>
> As an aside, I was confused while looking into this because I _thought_
> I had COLUMNS set:
>
>   $ echo $COLUMNS
>   119
>
> But it turns out that bash sets that by default (if you have the
> checkwinsize option on) but does not export it. ;)

Yep. This confused me too and I was "f*ck it I don't want to deal with
this tty crap again". I'll leave the term_columns() fix to you then,
and limit this patch to the "while at there" part which should be
fixed anyway.
--=20
Duy
