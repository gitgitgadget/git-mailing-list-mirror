Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9414620248
	for <e@80x24.org>; Thu, 28 Feb 2019 07:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfB1HN2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 02:13:28 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39377 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730965AbfB1HN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 02:13:28 -0500
Received: by mail-io1-f65.google.com with SMTP id x3so15792882ior.6
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 23:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1FejOl//HnvxUdplaRD5yX5aejtlYOIv9TUlMHVngg=;
        b=e2OY7ur3ftrdpuFgrcElJ8lQZnSTW7DEFYyh1iqcMd/telrvXHo6vKv8A3MuuZbD/t
         KquJSGAgzBZ0gTU7bgq3+oUEp92VSpaQ5J4Wp4dxRD6eXWIAt3PTxB6Uc+c4Qufb5n6j
         QVV0ZcbkgD4bC2zDwPdIN20qvSMwdSNwhky6edpZXv17chVlocYJ+xcWlwOhLCxJbE38
         rKhG1f5mmQF7KzfBwKA3G/C7iCXiC+DYmCGQ8hd91siLAvdxGWsRWV3aKsTzbPBNh5I1
         MCwI1o1isjsA9ycZBGYwOYod3eNhGEPiXCB5L8EOa3RxDGOsJvx8PFj8yI8J4ubfqV30
         Ds4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1FejOl//HnvxUdplaRD5yX5aejtlYOIv9TUlMHVngg=;
        b=cD7eGVHMjPk1o7GQAO0LNKbaUr5zpe76FB8OwOul7bwokBL3YH7ze0rUakX2VylpPM
         YzsjqZH4dWjDeX1F+mNKzSXDcYMUx02rKasgU9VRyvI5CtlLisnLU/UnOOhQqrg6mhYO
         ZC7ShRu0pSADvfeIBQx0rVtj+hU20JpIv5drhKtYfpUUD0HyFNkDBMyC1U/P4OIaV4Nu
         9dvs/nz+MQMq5QWoUtxPMD9J3SbJF6iDAic5Z0HOby0GRjGznKeXnCYxCfv/hgs3GLE+
         1ZMOiTpSMs/deCO1jUilM9aK5Tp63UdcSawxood6YN50+QISQsJkICfV4QGrMhXLvaQ/
         dCqg==
X-Gm-Message-State: APjAAAWz9DxlMNjFkvkqkJyP9LgCtm86TLA7aWIOXJvR6/DGsR92ZacD
        EQxot5rB3ZkA245LRJgScNYD9jlb2aFUO08R+gU=
X-Google-Smtp-Source: APXvYqxh919LS9dc3BGxy0R5Yeo48sgKWZXrcLe2oGWgTNYWRzg8N51qVPvZENiUj+11rhT1AegTtyQvmXhwT41VKvk=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr3787693ioc.282.1551338007586;
 Wed, 27 Feb 2019 23:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
 <20190226051804.10631-6-matheus.bernardino@usp.br> <CACsJy8B1asF3i+G-C1aZRw7QTW7jS+a4VkCbg-17YOTyYHuw5w@mail.gmail.com>
 <CAHd-oW6WJ5JSRAbcy+5kcEA4V8qKEUc9B=6WQZvdqaHz4XHBTA@mail.gmail.com>
In-Reply-To: <CAHd-oW6WJ5JSRAbcy+5kcEA4V8qKEUc9B=6WQZvdqaHz4XHBTA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 28 Feb 2019 14:13:01 +0700
Message-ID: <CACsJy8BV8CHOnbfDysgdo-md0pXLg05rKpMP5a8TUkUcWw0G8g@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 5/5] clone: use dir-iterator to avoid explicit
 dir traversal
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 28, 2019 at 12:40 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
> > > @@ -463,7 +460,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> > >                 if (copy_file_with_time(dest->buf, src->buf, 0666))
> > >                         die_errno(_("failed to copy file to '%s'"), dest->buf);
> > >         }
> > > -       closedir(dir);
> > > +
> > > +       if (iter_status != ITER_DONE) {
> > > +               strbuf_setlen(src, src_len);
> > > +               die(_("failed to iterate over '%s'"), src->buf);
> > > +       }
> >
> > I think you need to abort the iterator even when it returns ITER_DONE.
> > At least that's how the first caller in files-backend.c does it.
> >
>
> Hm, I don't think so, since dir_iterator_advance() already frees the
> resources before returning ITER_DONE. Also, I may be wrong, but it
> doesn't seem to me, that files-backend.c does it. The function
> files_reflog_iterator_advance() that calls dir_iterator_advance() even
> sets the dir-iterator pointer to NULL as soon as ITER_DONE is
> returned.

Arghhh.. I read the ref_iterator_abort and thought it was
dir_iterator_abort! Sorry for the noise, too many iterators.
-- 
Duy
