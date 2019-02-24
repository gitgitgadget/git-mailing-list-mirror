Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C728120248
	for <e@80x24.org>; Sun, 24 Feb 2019 08:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfBXIgA (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 03:36:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33160 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfBXIgA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 03:36:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id c55so5152641edb.0
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 00:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4W/on94kO6cMZhUbKmQlTTfsqfBw1wKMMDbZLVWr1AE=;
        b=oi7sNZKGx7mvfuPMGYGmTrXYVnz1rZ3mhxTXXxAIMrNzPalz4AWcfSa0X4PZF9Ips2
         QST7K2lUzrsrIZ/oOlLnW1bm4KDEEdL3lLx7XOP1uLY6nu0sW7IRTJIZYEWkbeMrH7vX
         ++hywX3MRJ4YeNhG6UfGjvmGOwqbiLBg8/qHwZl42p93O8dpAv3rcmywCrWrHQx+FGNp
         9lvwrbUR5LIYDL+5IFzPhM/ETjSG2HSYlDBdKo4XWZp4ImNIOzfJ/rfWDBDrbV0sFcAt
         dSblc/LSOj4FX+Fe5fFT7SRX8zPEwfMr2LBq+p9kup2H/4CoUAm0TOJVdOxrF40N0WxY
         +A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4W/on94kO6cMZhUbKmQlTTfsqfBw1wKMMDbZLVWr1AE=;
        b=nCeBEB/MO4517Ya0ISzwm/4mtMA0lVxWOpbvjXpVACcYpYo7cqlWHVNCfPH6WGsVVm
         YVDWA0om4vOSGcDE4l29B+Bmh4+5nAgnY6zMLGoxya2inkuHaYDZ1jtjPTHf2tGkJ/OX
         M5T08QNyEsJemR0tPFTnN9KQ1S1wl0HmheuJxF+ieIJmdRuTlWB1OtBdOIxFamWG9SVJ
         acR4T4PhsXF1nWQBuG3v3UgNseAUevgwNqF3ZzhKd+Tww46G2nQLZAkV5Onpc+s1VOfl
         E4VCea8FfO32RkRP7mlC6XamtVTWs3CPvJu7fQjQ6EgSHcxfPtheheFhC3QAXVy16WZ3
         MlpQ==
X-Gm-Message-State: AHQUAuauqJxXsEUXo6Pe3K1jFhaxmg55HxlbZX+RzdMAobbq5S5oWdAQ
        7HPD/yelBwoSvE3OODUmK6KDah+mYLOTwDZIaMo=
X-Google-Smtp-Source: AHgI3IagBEDXwMTrMpeHZdAK/tX2iboGCC0ck3g2/qiSRb8QkNCGk5FNmXJFwEI9J5PJR5n5e7uv0c/QTeNo0stkJf8=
X-Received: by 2002:a50:8f86:: with SMTP id y6mr10265263edy.131.1550997357997;
 Sun, 24 Feb 2019 00:35:57 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-2-matheus.bernardino@usp.br> <20190223213527.GP6085@hank.intra.tgummerer.com>
In-Reply-To: <20190223213527.GP6085@hank.intra.tgummerer.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 24 Feb 2019 09:35:46 +0100
Message-ID: <CAP8UFD0uZbzG7pjqLAQ5374_0vBTbaQ89u-rhiY7c7GXSKb8tw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/3] dir-iterator: add pedantic option to dir_iterator_begin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 23, 2019 at 10:37 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/23, Matheus Tavares wrote:
> > Add the pedantic option to dir-iterator's initialization function,
> > dir_iterator_begin. When this option is set to true,
> > dir_iterator_advance will immediately return ITER_ERROR when failing to
> > fetch the next entry. When set to false, dir_iterator_advance will emit
> > a warning and keep looking for the next entry.
> >
> > Also adjust refs/files-backend.c to the new dir_iterator_begin
> > signature.
>
> Thanks, this makes sense to me.  This commit message describes what we
> are doing in this patch, but not why we are doing it.  From previously
> reviewing this series, I know this is going to be used in a subsequent
> patch, but it is nice to give reviewers and future readers of this
> patch that context as well.  Just something like "This behaviour is
> going to be used in a subsequent patch." should be enough here.

I agree that it's a good idea to add just that.

> >  int dir_iterator_advance(struct dir_iterator *dir_iterator)
> > @@ -71,6 +78,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
> >
> >                       level->dir = opendir(iter->base.path.buf);
> >                       if (!level->dir && errno != ENOENT) {
> > +                             if (iter->pedantic)
> > +                                     goto error_out;
>
> I think we should also print an error here.  The caller doesn't have
> any context on what went wrong, and will probably just 'die()' if an
> error is encountered.  I think it would make sense to call
> 'error(...)' here before 'goto error_out;' to give a useful error
> message here.

If we start to give error messages, then we might as well give error
messages all the times when we error out. This will avoid the callers
wondering if they need to give an error message or not.

I am not sure it's necessary here though. And I think if it's useful,
it can be added in another patch or another patch series.

> >                               warning("error opening directory %s: %s",
> >                                       iter->base.path.buf, strerror(errno));
> >                               /* Popping the level is handled below */

> > -struct dir_iterator *dir_iterator_begin(const char *path)
> > +struct dir_iterator *dir_iterator_begin(const char *path, int pedantic)
>
> Thinking about the future evolution of this interface, it might make
> more sense to have that second parameter be a "struct
> dir_iterator_opts".  For now it would just have one member "pedantic",
> but in the future we could add additional options there instead of
> adding additional parameters.

I think it's ok with `int pedantic` for now as improvements can be
done when they are really needed. And we will perhaps find out that
it's better to just change `int pedantic` to `unsigned flags` instead
of `struct dir_iterator_opts`.

Thanks,
Christian.
