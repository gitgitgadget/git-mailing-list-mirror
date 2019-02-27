Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532A120248
	for <e@80x24.org>; Wed, 27 Feb 2019 14:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfB0OAH (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 09:00:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36481 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbfB0OAG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 09:00:06 -0500
Received: by mail-io1-f65.google.com with SMTP id r136so13572647iod.3
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 06:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaeebInmE/x0lMO3YfZWeaOrUxTmqageNbAJ61xB1vk=;
        b=xHfGhQJeHsywXeAkFaDDbR6hAwpW5cRyn94MRrW+dtV9XCwRoN6uKEe3J96DXWtLgN
         +EN9XO65GL562k7K7bilFT6+Ec39aoCwcB3PYoG+eT31YzGFz+ScdVgjMppWQiZeHYa/
         dYdnmVWDkEmcw0HMdNIf3T9+ET94ADcoegFxg9lkJrSyzSMNiA7eGIO/l1zoRC6QuKlF
         47ISfBmtZG51+NXRrCHK/hTSf6KTk+AES5HpWGaUnqsLOVcBuMNbYIQD5o2WPN0Bdtcr
         hoAGRRgiVQj7ComB63NdOUuy+R32VwYGMBtmPqVvBGWOLD5q/4k8qQop5ZaWICxHcXFz
         3uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaeebInmE/x0lMO3YfZWeaOrUxTmqageNbAJ61xB1vk=;
        b=lHMlTs4DqjCeR3XksG3/XG04zUIFHwq0ucPqrZZxzQ9wr0bBf/vWj5V5/PCElFQV8i
         Elrz0BoSlguOHod99ibOLbDpTJu/q1r/r/6ytIdWf9Ll5U2NFgHUlRn0VEFUYCDv2SLa
         BV/GxeFv2d4lSMFd0nLEIhb/l8qgQ/8Q4UBWFXXQ+Nje/nXPDUbu+SWL5guwx/qBLbb3
         Hyt64W7Hy+PfyVjOYNAXEf0INQ24PtaC6WxDQ0xw5fTpT/fgqnowD4srnxlQz16gzd54
         qy1+q3iDip+yDXD7Xn67AIsNbHCNRb6WFROHHn4S9WNScOBI9A5d0fJoyp+Zau852AUz
         p2Iw==
X-Gm-Message-State: APjAAAViwYjatV5NpC/mbnYHPumOyWS1aPD+qNi+b7uAaOTm5FGEXDhW
        BJYOJiWBn+k7Hyi8N8XU9wYZsaUr7sDOLySbeavEOg==
X-Google-Smtp-Source: APXvYqwhpN247Wk+K22bTG00ULs3FR+TzAVyOq1J13Pr1kEEGXWVQBDtWIl6NkR89dyH8E5y6iqWxTYbDrdVBOyccDY=
X-Received: by 2002:a6b:7941:: with SMTP id j1mr1983597iop.262.1551276005107;
 Wed, 27 Feb 2019 06:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
 <20190226051804.10631-2-matheus.bernardino@usp.br> <CACsJy8DCpA3yvSjWiNDPtqMxSo9wNUobCkBHXOnJsG-+6C2Eew@mail.gmail.com>
In-Reply-To: <CACsJy8DCpA3yvSjWiNDPtqMxSo9wNUobCkBHXOnJsG-+6C2Eew@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 27 Feb 2019 10:59:53 -0300
Message-ID: <CAHd-oW6c6JMqH7czjpYkg7Z5NJgrnqWpcCmZq4Mf+pj4tjgYUw@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 1/5] dir-iterator: add flags parameter to dir_iterator_begin
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 9:02 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >  int dir_iterator_advance(struct dir_iterator *dir_iterator)
> >  {
> >         struct dir_iterator_int *iter =
> >                 (struct dir_iterator_int *)dir_iterator;
> > +       int ret;
> >
> >         while (1) {
> >                 struct dir_iterator_level *level =
> > @@ -71,6 +75,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
> >
> >                         level->dir = opendir(iter->base.path.buf);
> >                         if (!level->dir && errno != ENOENT) {
> > +                               if (iter->flags & DIR_ITERATOR_PEDANTIC)
> > +                                       goto error_out;
> >                                 warning("error opening directory %s: %s",
> >                                         iter->base.path.buf, strerror(errno));
> >                                 /* Popping the level is handled below */
> > @@ -122,6 +128,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
> >                         if (!de) {
> >                                 /* This level is exhausted; pop up a level. */
> >                                 if (errno) {
> > +                                       if (iter->flags & DIR_ITERATOR_PEDANTIC)
> > +                                               goto error_out;
> >                                         warning("error reading directory %s: %s",
> >                                                 iter->base.path.buf, strerror(errno));
> >                                 } else if (closedir(level->dir))
> > @@ -138,11 +146,20 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
> >                                 continue;
> >
> >                         strbuf_addstr(&iter->base.path, de->d_name);
> > -                       if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
> > -                               if (errno != ENOENT)
> > +
> > +                       if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
> > +                               ret = stat(iter->base.path.buf, &iter->base.st);
> > +                       else
> > +                               ret = lstat(iter->base.path.buf, &iter->base.st);
> > +
> > +                       if (ret < 0) {
> > +                               if (errno != ENOENT) {
> > +                                       if (iter->flags & DIR_ITERATOR_PEDANTIC)
> > +                                               goto error_out;
> >                                         warning("error reading path '%s': %s",
> >                                                 iter->base.path.buf,
> >                                                 strerror(errno));
> > +                               }
> >                                 continue;
> >                         }
> >
> > @@ -159,6 +176,10 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
> >                         return ITER_OK;
> >                 }
> >         }
> > +
> > +error_out:
> > +       dir_iterator_abort(dir_iterator);
>
> Should this function call this or leaveit to the caller? The
> description says "free resources" which to me sounds like something
> the caller should be aware of. Although if double dir_iterator_abort()
> has no bad side effects then I guess we can even leave it here.
>

The documentation at dir-iterator.h says that in case of errors (or
iteration exhaustion) at dir_iterator_advance(), the dir-iterator and
associated resources will be freed, so dir_iterator_abort() must be
called here, not left to the user. (Also, the use-case example at the
top of dir-iterator.h confirms this.)

> PS. files-backend.c does call dir_iterator_abort() unconditionally.
> Which sounds like this double-abort pattern should be dealt with even
> if that call site does not use the pedantic flag (it could later on,
> who knows; don't leave traps behind).
>

I have read the code at files-backend.c again but couldn't find where
it could call dir_iterator_abort() after dir_iterator_advance() have
already called it. Could you please point me out that?

A double-abort would certainly lead to 'double free or corruption'
error, so API users must only call it to abort iteration for some
reason when treating the iteration files, not because of iteration
errors. Also, this behaviour is not only for the pedantic flag. When
an iteration is complete, for example, a call to
dir_iterator_advance() will free the resources and return ITER_DONE.

> > +       return ITER_ERROR;
> >  }
> >
> > diff --git a/dir-iterator.h b/dir-iterator.h
> > index 970793d07a..fe9eb9a04b 100644
> > --- a/dir-iterator.h
> > +++ b/dir-iterator.h
> > @@ -6,9 +6,10 @@
> >  /*
> >   * Iterate over a directory tree.
> >   *
> > - * Iterate over a directory tree, recursively, including paths of all
> > - * types and hidden paths. Skip "." and ".." entries and don't follow
> > - * symlinks except for the original path.
> > + * With no flags to modify behaviour, iterate over a directory tree,
>
> Nit but I think we can just skip "With no flags to modify behavior". It's given.
>

Ok!

> > + * recursively, including paths of all types and hidden paths. Skip
> > + * "." and ".." entries and don't follow symlinks except for the
> > + * original path.
> >   *
> >   * Every time dir_iterator_advance() is called, update the members of
> >   * the dir_iterator structure to reflect the next path in the
> > @@ -19,7 +20,7 @@
> >   * A typical iteration looks like this:
> >   *
> >   *     int ok;
> > - *     struct iterator *iter = dir_iterator_begin(path);
> > + *     struct iterator *iter = dir_iterator_begin(path, 0);
> >   *
> >   *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
> >   *             if (want_to_stop_iteration()) {
> > @@ -40,6 +41,20 @@
> >   * dir_iterator_advance() again.
> >   */
> >
> > +/*
> > + * Flags for dir_iterator_begin:
> > + *
> > + * - DIR_ITERATOR_PEDANTIC: override dir-iterator's default behavior
> > + *   in case of an error while trying to fetch the next entry, which is
> > + *   to emit a warning and keep going. With this flag, resouces are
> > + *   freed and ITER_ERROR is return immediately.
> > + *
> > + * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks to
> > + *   directories, i.e., iterate over linked directories' contents.
>
> Do we really need this flag? If dir-iterator does not follow symlinks,
> the caller _can_ check stat data to detect symlinks and look inside
> anyway. So this flag is more about convenience (_if_ it has more than
> one call site, convenience for one call site is just not worth it).
>

I don't think is just a convenience. If the API user wants to follow
symlinks a simple check at stat data to detect symlinks, wouldn't be
enough, since the user would want to traverse through all contents of
a symlinked directory and its subdirectories, recursively. Without
this flag, the caller would need to manually detect symlinks to
directories and start a new iteration on them (probably using a new
dir-iterator?). As that could lead to a more unnecessarily complex
code, and being this flag implementation so simple, I think it is
worthy.

> Or is there something else I'm missing?
>
> > + */
> > +#define DIR_ITERATOR_PEDANTIC (1 << 0)
> > +#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
> > +
> --
> Duy
