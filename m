Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208301F453
	for <e@80x24.org>; Mon,  4 Feb 2019 12:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfBDMNe (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 07:13:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40140 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfBDMNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 07:13:33 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so20412316ita.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 04:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpiA0D2D0CYFCcajaz4vrdWFqtzH4GK1eGSihnM1PgQ=;
        b=Q8zBmgL5FjMd1RxlA47JwpOWE75w93mM2rTIW1pYiEi9sPIma/ksa8evsbWX51toIy
         svRKp94hPK0OFz4gdmua74BrKqT7vG3H1dThDQl6R2Dd09U2oCWHfxiTBHwd0u8wXuM9
         VM9LIcHAcnf5D0RUjxyXYlTQ/3gF69TLCI0lOB8i6DsrkW8iweBdBpMYIE736k/lPn8n
         lV0Khp3L8DWDASjZkQS4rU1cg/eme6mDVY+6H0Tdkn0WZ5nDGJH6EvsDovbkKQor7l45
         g9bn2cFelun8AVrcODDNIvVL54yGE4FZCf8zu14AW6zKcRPxRlgOdVh8R4Mc8k63+emh
         rChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpiA0D2D0CYFCcajaz4vrdWFqtzH4GK1eGSihnM1PgQ=;
        b=IZkxBvqOO102w+9XMtOXdzeQxddSvU6OjvKU9qFBbVML21iJzUbg/xQzBfswP2f6SJ
         BPtSt92AgzCzBShiWDcTYFU49YytQFOnjeqr9jZou4OkpijVBthMo8BDdaphrBssylpL
         6gksfNLor/mGU8s/qBQp0DUCtNku+a4IUr6Y+zGRqbeuDCDmVk4lobDFI/xwvkAVhBMz
         YCjiW55v/sk82uStVNBZI1I4PUjjcnHu1ZfMYqdt/VAinp3rfjnn2ryVvJ/aD7Y6LOP6
         mhvwSG3PsU8oPoGQz28txDZao+0eqL2ak2zmp2rlezixlYthrgQVfacfrAMrxq0r3wLE
         ITlw==
X-Gm-Message-State: AJcUukfq1GU7XcZm65qivy87ThssOFCBGx9eizb8EF0L0dLQNI8FTMum
        yKzfOO/ouiGJBtcBBFaAguM22CLYOjrb242nwqA0XA==
X-Google-Smtp-Source: ALg8bN5Dg74HYRCuLhJJhJef+egGA6Gz4mWB3fBhTPR2kxufqsBJ7tjfFo4Z7E6PHcZKqHnwClZvTVZU5RY0bK8rWBI=
X-Received: by 2002:a02:8943:: with SMTP id u3mr30415052jaj.92.1549282412424;
 Mon, 04 Feb 2019 04:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20190201193004.88736-1-dan.mcgregor@usask.ca> <xmqqr2crxl7o.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B_=qbeimp5=RS-r2gwEjVV9rDE_2_tk_DDqz6rJazvFw@mail.gmail.com> <nycvar.QRO.7.76.6.1902041243220.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902041243220.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Feb 2019 19:13:06 +0700
Message-ID: <CACsJy8BtaxMRTG4-r3iJfUuR9k-=r=4QTRxCkFt3k3p7826Z9A@mail.gmail.com>
Subject: Re: [PATCH] http: cast result to FILE *
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dan McGregor <dan.mcgregor@usask.ca>,
        Git Mailing List <git@vger.kernel.org>,
        Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 6:44 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> On Sat, 2 Feb 2019, Duy Nguyen wrote:
>
> > On Sat, Feb 2, 2019 at 4:21 AM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Dan McGregor <dan.mcgregor@usask.ca> writes:
> > >
> > > > Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
> > > > 2019-01-10) introduced an implicit assumption that rewind, fileno, and
> > > > fflush are functions. At least on FreeBSD fileno is not, and as such
> > > > passing a void * failed.
> > >
> > > I am not strongly opposed to this patch,
> >
> > Even if this is needed, should it be done behind git-compat-util.h
> > instead? That way if fileno(void*) is used elsewhere, we don't have to
> > do the casting again.
>
> The disadvantage, of course, would be that other call sites would not
> benefit from a manual auditing whether the argument has side effects (and
> thus, whether a macro using the argument multiple times would result in
> very unexpected multiple side effects).

That's just a better reason to "fix" it in compat/. If you define a
git_fileno() function and map fileno to it, then you won't have to
deal with side effects of FreeBSD's fileno() macro. All evaluation
happens before git_fileno() is called.

> I'd rather not paper over this issue and thereby open even larger
> problems.
>
> Ciao,
> Dscho
>
> >
> > > but shouldn't you be filing
> > > a bug report against FreeBSD instead?  The implementation is free to
> > > define fileno(fh) as a macro, but it shouldn't force such a change
> > > to conformant programs.
> > >
> > > https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=206146
> > >
> > > > Explicitly cast result to a FILE * when using standard functions that
> > > > may ultimately be macros.
> > > >
> > > > Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
> > > > ---
> > > >  http.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/http.c b/http.c
> > > > index 954bebf684..8b9476b151 100644
> > > > --- a/http.c
> > > > +++ b/http.c
> > > > @@ -1996,12 +1996,12 @@ static int http_request_reauth(const char *url,
> > > >               strbuf_reset(result);
> > > >               break;
> > > >       case HTTP_REQUEST_FILE:
> > > > -             if (fflush(result)) {
> > > > +             if (fflush((FILE *)result)) {
> > > >                       error_errno("unable to flush a file");
> > > >                       return HTTP_START_FAILED;
> > > >               }
> > > > -             rewind(result);
> > > > -             if (ftruncate(fileno(result), 0) < 0) {
> > > > +             rewind((FILE *)result);
> > > > +             if (ftruncate(fileno((FILE *)result), 0) < 0) {
> > > >                       error_errno("unable to truncate a file");
> > > >                       return HTTP_START_FAILED;
> > > >               }
> >
> >
> >
> > --
> > Duy
> >



-- 
Duy
