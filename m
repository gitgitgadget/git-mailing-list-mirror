Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16E21F453
	for <e@80x24.org>; Sat,  2 Feb 2019 11:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfBBLVi (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 06:21:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34067 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfBBLVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 06:21:38 -0500
Received: by mail-io1-f68.google.com with SMTP id b16so8057181ior.1
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 03:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUKLr+U3BePlfKezhahV5YjRrQ9GHLnB0T9wdlqzCBs=;
        b=kBXXRdp36vjo9Lh1aqrpjTkzeC+azAzg0oBv8G/FnQ/MV/6FRo6l8tG38XQoofvQ54
         UIJpwrN/yk1za1ILclUL8KqJAEGUvOZa7O9wAl7g/FSlvMrcmKMBzEJNoxiqI6aBfSXL
         Wl3JQ1kEbCQyPvWs1yevuF7eRZL6CxiD8mAd8T8t1rcd7BDpQ7FRiVhU0FtOZh8h4ejW
         Wy8DysR63oS7GENLQffPomN22d3I2oFXAHn+C2JNzDosC6fzRjeRMZRvOJvxpSceboiy
         pxhH/ZTNuOdHGIvt8FKiX5IkMzK8pPc+mDDgv8KzTMRECwcJd8JptNFZrK8OQLtsImm0
         CQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUKLr+U3BePlfKezhahV5YjRrQ9GHLnB0T9wdlqzCBs=;
        b=eR5zE2iGrnqO+snGYsQV/S78pV2YCR8Aub6omboklK8WxlLa45iuo23sCzmIRjBs/Z
         VUZGcpg9PWwCYjbR/ZR60Y+JSDX1qORxUSm0xkp5fKEVSG4hKF4LQGyH0eF+fWe69nuC
         ThFEG/igv/U5rsG32+KjZEX5WEQCiNte6HO2c/162RRdxebQhW6CqaFW0fDj/hbYuJGc
         1gmW7gzTN2XKn0lkLzWUbChKTYNz9vfIsMG224G+65rHbEhz4SWEKAMpekcVYTqWvhEH
         Wvj9yP0EgWlt1GUU0fB9BPfhcS9Pgi+x693H9Ggz5HtELR5ZkSdhiNQnTKNdcbZt2/PF
         qDAw==
X-Gm-Message-State: AHQUAuYXSjm30YaqTJLmAIn64YYgl5wolLA7KftRNDnIGEgCQDU1aRSm
        ox4u3aaywd/b35eSyygazVreV4NBPpAxzidN+BA=
X-Google-Smtp-Source: AHgI3Ia8GpptbqdCKcIP8/J6AMinhKB/FiUHicDfe3gFH2YkT4m38Vu8KutD9dw+KV4SEAIYODorW1vDcWuA/ZAPyWg=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr18622286iof.118.1549106497263;
 Sat, 02 Feb 2019 03:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20190201193004.88736-1-dan.mcgregor@usask.ca> <xmqqr2crxl7o.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2crxl7o.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Feb 2019 18:21:10 +0700
Message-ID: <CACsJy8B_=qbeimp5=RS-r2gwEjVV9rDE_2_tk_DDqz6rJazvFw@mail.gmail.com>
Subject: Re: [PATCH] http: cast result to FILE *
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dan McGregor <dan.mcgregor@usask.ca>,
        Git Mailing List <git@vger.kernel.org>,
        Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 2, 2019 at 4:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Dan McGregor <dan.mcgregor@usask.ca> writes:
>
> > Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
> > 2019-01-10) introduced an implicit assumption that rewind, fileno, and
> > fflush are functions. At least on FreeBSD fileno is not, and as such
> > passing a void * failed.
>
> I am not strongly opposed to this patch,

Even if this is needed, should it be done behind git-compat-util.h
instead? That way if fileno(void*) is used elsewhere, we don't have to
do the casting again.

> but shouldn't you be filing
> a bug report against FreeBSD instead?  The implementation is free to
> define fileno(fh) as a macro, but it shouldn't force such a change
> to conformant programs.
>
> https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=206146
>
> > Explicitly cast result to a FILE * when using standard functions that
> > may ultimately be macros.
> >
> > Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
> > ---
> >  http.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/http.c b/http.c
> > index 954bebf684..8b9476b151 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -1996,12 +1996,12 @@ static int http_request_reauth(const char *url,
> >               strbuf_reset(result);
> >               break;
> >       case HTTP_REQUEST_FILE:
> > -             if (fflush(result)) {
> > +             if (fflush((FILE *)result)) {
> >                       error_errno("unable to flush a file");
> >                       return HTTP_START_FAILED;
> >               }
> > -             rewind(result);
> > -             if (ftruncate(fileno(result), 0) < 0) {
> > +             rewind((FILE *)result);
> > +             if (ftruncate(fileno((FILE *)result), 0) < 0) {
> >                       error_errno("unable to truncate a file");
> >                       return HTTP_START_FAILED;
> >               }



-- 
Duy
