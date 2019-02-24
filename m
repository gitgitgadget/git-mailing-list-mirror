Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1947C20248
	for <e@80x24.org>; Sun, 24 Feb 2019 17:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfBXRoD (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 12:44:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35129 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfBXRoD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 12:44:03 -0500
Received: by mail-io1-f67.google.com with SMTP id x4so5739731ion.2
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 09:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8rE+T5kQvgp39eduk0qqBt/WasntzBHFZf6HT2Ut08=;
        b=nGsLOhzHuAJYJux7I8dctprZOPk1BA4Ux7SFii8UYAdDgw+uKOLBxkKwXXUiiJN8BT
         RB1hsxb3YRyWYooCBK9svRzzDQfvL95RehilZz75aEOva0H3+9qjQ9Fkvy4hDfD8Gdy4
         c4dNbyW7LLM3b3MT+cfWcU/HwQ4H8niY4zmfYBkhPaOxaqzmi9uGS7pINnIcKqyrRicm
         570qZspzq6HmKa6OdQVzVGfFELVs+f//60gklucw1BPIFbyqb0ZD/HrbLc6nU6sCOelp
         /RWkXVsrRzUxriPLLSte6nyG64D1+qIugjpb25AXyIDdDzFBX5T0cJP1hTvzqltMqjOq
         IY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8rE+T5kQvgp39eduk0qqBt/WasntzBHFZf6HT2Ut08=;
        b=mxdIbSZEoekuiAb3WJY5DBsaNvAKNGulqwVcyVk9jrRTshBviEPIDdQaduHlqBhj5m
         UcDJAbinqs0tMoZSTitgsd8LNbmzYolHpOa62P5jnMy25PwNhMhGNK9NhcEnxNnjnYxi
         farDHNuOwywKrG7fTa8CSqP2YDTqbmNRdDHF4U7Ld9eDRIxwZ0nFZRUcZjUQNlJkYu+U
         K2uj4TTjqyhpAbEisl8m09FIvqBPaV5ocgy3sGsVM3/ZpbNJM8dpkkb4G0ZnviuX136N
         owhY+mquHmCC2ipQtZC5hiPC051ZWbd7PtteLbmh+w0emnRRL9AGniEnCRQrURsDUyKZ
         0rYQ==
X-Gm-Message-State: AHQUAubnC8YaxdH2qL1S3qz9hV1ujXnckW/h59/PbAIRdbsMuNLypqM7
        hUq0vjShSLCymXyG5AYuPzyt2k+iw/aCekIptaapnA==
X-Google-Smtp-Source: AHgI3IbGb8pMabNZq1Y/bIsfkZ5o8eDfwtRqQMyafHPrxvXWcfvqH/n+fF8c4eGghr6EpzKAsH1oi78Dly51ByfdkG8=
X-Received: by 2002:a6b:1447:: with SMTP id 68mr7509893iou.293.1551030241986;
 Sun, 24 Feb 2019 09:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-2-matheus.bernardino@usp.br> <20190223213527.GP6085@hank.intra.tgummerer.com>
 <CAP8UFD0uZbzG7pjqLAQ5374_0vBTbaQ89u-rhiY7c7GXSKb8tw@mail.gmail.com>
In-Reply-To: <CAP8UFD0uZbzG7pjqLAQ5374_0vBTbaQ89u-rhiY7c7GXSKb8tw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 24 Feb 2019 14:43:50 -0300
Message-ID: <CAHd-oW78Sj_qyFZgUfYgJcB5w5_BC_F-wbiLOU7VzJhFt9919A@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/3] dir-iterator: add pedantic option to dir_iterator_begin
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 24, 2019 at 5:35 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Feb 23, 2019 at 10:37 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 02/23, Matheus Tavares wrote:
> > > Add the pedantic option to dir-iterator's initialization function,
> > > dir_iterator_begin. When this option is set to true,
> > > dir_iterator_advance will immediately return ITER_ERROR when failing to
> > > fetch the next entry. When set to false, dir_iterator_advance will emit
> > > a warning and keep looking for the next entry.
> > >
> > > Also adjust refs/files-backend.c to the new dir_iterator_begin
> > > signature.
> >
> > Thanks, this makes sense to me.  This commit message describes what we
> > are doing in this patch, but not why we are doing it.  From previously
> > reviewing this series, I know this is going to be used in a subsequent
> > patch, but it is nice to give reviewers and future readers of this
> > patch that context as well.  Just something like "This behaviour is
> > going to be used in a subsequent patch." should be enough here.
>
> I agree that it's a good idea to add just that.
>

Indeed! Thank you Thomas and Christian. I will be adding this in v3.

> > >  int dir_iterator_advance(struct dir_iterator *dir_iterator)
> > > @@ -71,6 +78,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
> > >
> > >                       level->dir = opendir(iter->base.path.buf);
> > >                       if (!level->dir && errno != ENOENT) {
> > > +                             if (iter->pedantic)
> > > +                                     goto error_out;
> >
> > I think we should also print an error here.  The caller doesn't have
> > any context on what went wrong, and will probably just 'die()' if an
> > error is encountered.

To correctly handle the error, I assumed that the caller wouldn't need
to know which exact function returned an error, as long as it knew it
was a "failure to fetch the next entry" kind of error, which is the
"category" of errors caught with the 'pedantic' option. (currently, it
includes errors on lstat, opendir and readdir). Is this assumption
valid?

> > I think it would make sense to call
> > 'error(...)' here before 'goto error_out;' to give a useful error
> > message here.
>
> If we start to give error messages, then we might as well give error
> messages all the times when we error out. This will avoid the callers
> wondering if they need to give an error message or not.
>
> I am not sure it's necessary here though. And I think if it's useful,
> it can be added in another patch or another patch series.
>

I could just copy the warning messages bellow each 'goto error_out'
and use then at an 'error(...)' call before the goto. But as Christian
pointed out, I think this would confuse callers wether they should
print error messages or not. On the other side, it may just be
different 'layers' of errors... I don't have any strong opinion about
this.

> > >                               warning("error opening directory %s: %s",
> > >                                       iter->base.path.buf, strerror(errno));
> > >                               /* Popping the level is handled below */
>
> > > -struct dir_iterator *dir_iterator_begin(const char *path)
> > > +struct dir_iterator *dir_iterator_begin(const char *path, int pedantic)
> >
> > Thinking about the future evolution of this interface, it might make
> > more sense to have that second parameter be a "struct
> > dir_iterator_opts".  For now it would just have one member "pedantic",
> > but in the future we could add additional options there instead of
> > adding additional parameters.
>
> I think it's ok with `int pedantic` for now as improvements can be
> done when they are really needed. And we will perhaps find out that
> it's better to just change `int pedantic` to `unsigned flags` instead
> of `struct dir_iterator_opts`.
>

I did thought about using `unsigned flags` instead of `int pedantic`
for the same reasons Thomas pointed out, but as there would be just
one flag for now, it seemed to me that `int pedantic` would make more
sense (following the 'YAGNI' principle). But if it is already known
that more flags (or options) are coming in a very near future, I may
change this to `unsigned flags` or `struct dir_iterator_opts` in v3 if
you think it is needed. Just let me know, please.

> Thanks,
> Christian.
