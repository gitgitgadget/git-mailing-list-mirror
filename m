Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F2420248
	for <e@80x24.org>; Sun, 24 Feb 2019 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfBXVGL (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 16:06:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34157 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfBXVGK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 16:06:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so7774275wrg.1
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 13:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NyIFgMWV5BxuvOlcE82uNUhbZTkHLrHh5R752xbRvqg=;
        b=RLsVxglGJ5yKEVlmekc4nakcJqOkBGK5//0bYNl0lVaBQzIg6GkTVZbzOCQVysJOVG
         iHp8o5sGqgGfMLN/s5IrJCc61PfdyK+mw50NZccpGuwMcLvjoIqUJisF2S9JPKTyMBcw
         VoSVLv7YdNB/UK22GjjbTpH/7/5h46ovcvGtoaU6uVFOmYzTjJRwS7Lbk9ztPEjvf9Gw
         aQ8PVYsq5Pntdaho3AIfRuNLFH/2ClGedMHrUCnfEL8g8WEuS1Hcliqhxlk0QrSiAMUU
         u5ZqgQqTdLUQ0EyRy/0OvxD+5l/CAzhitMnS7Qa7NQd03Jaih9cieSClpZKZ3fayLbCV
         aFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NyIFgMWV5BxuvOlcE82uNUhbZTkHLrHh5R752xbRvqg=;
        b=MmU4eD2hw8IbVxUgglLUZRdweKyaqrMAY2ANNiIPhVivjXKiENbia9/CbAn4x/OWEh
         SxgZy+SF2oEKVNWR72kkh5W/XqPwuCmWWVFMZmM3XUZgy2tVcZnu2bdjKzbl1iV8YO1Z
         bFv6jMNvlmKNfxQbpQoAvPpv0te/0FMPU7YFuHnePkuwdI5BNSdL9etpQGvIoqGyAU6/
         yAcaAGDsz1CGQ3aqY4vSwlAHBMbpl9uwb0gFDeuioLhB7cRRzXLSWtf7EkXuH/gn2XU0
         bBjU4YvExl8DtCMG/iJcjMGA1CBfvx0JYBYNQB7FMq+a3M9WValYEY+INC4vssM3Y+lk
         haQw==
X-Gm-Message-State: AHQUAubmF1oXob13Ekt+DRF/OsfPubRMPdVbRxHuAXQdrjyHqjc+65yH
        +18ILTcT8KqKaaSFYiCf++w=
X-Google-Smtp-Source: AHgI3IayNqQzsEI40N7CAp0wQiTPXTZLv1ov/f8F3adbgoTqZpzoWsbfvdFi/SzQwa6xGGPcIReIjQ==
X-Received: by 2002:adf:ecd2:: with SMTP id s18mr10056058wro.293.1551042368279;
        Sun, 24 Feb 2019 13:06:08 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id k6sm10210090wrq.82.2019.02.24.13.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 13:06:06 -0800 (PST)
Date:   Sun, 24 Feb 2019 21:06:05 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [GSoC][PATCH 1/3] dir-iterator: add pedantic option to
 dir_iterator_begin
Message-ID: <20190224210605.GA27711@hank.intra.tgummerer.com>
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-2-matheus.bernardino@usp.br>
 <20190223213527.GP6085@hank.intra.tgummerer.com>
 <CAP8UFD0uZbzG7pjqLAQ5374_0vBTbaQ89u-rhiY7c7GXSKb8tw@mail.gmail.com>
 <CAHd-oW78Sj_qyFZgUfYgJcB5w5_BC_F-wbiLOU7VzJhFt9919A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW78Sj_qyFZgUfYgJcB5w5_BC_F-wbiLOU7VzJhFt9919A@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/24, Matheus Tavares Bernardino wrote:
> On Sun, Feb 24, 2019 at 5:35 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Sat, Feb 23, 2019 at 10:37 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > >  int dir_iterator_advance(struct dir_iterator *dir_iterator)
> > > > @@ -71,6 +78,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
> > > >
> > > >                       level->dir = opendir(iter->base.path.buf);
> > > >                       if (!level->dir && errno != ENOENT) {
> > > > +                             if (iter->pedantic)
> > > > +                                     goto error_out;
> > >
> > > I think we should also print an error here.  The caller doesn't have
> > > any context on what went wrong, and will probably just 'die()' if an
> > > error is encountered.
> 
> To correctly handle the error, I assumed that the caller wouldn't need
> to know which exact function returned an error, as long as it knew it
> was a "failure to fetch the next entry" kind of error, which is the
> "category" of errors caught with the 'pedantic' option. (currently, it
> includes errors on lstat, opendir and readdir). Is this assumption
> valid?
>
> > > I think it would make sense to call
> > > 'error(...)' here before 'goto error_out;' to give a useful error
> > > message here.
> >
> > If we start to give error messages, then we might as well give error
> > messages all the times when we error out. This will avoid the callers
> > wondering if they need to give an error message or not.
> >
> > I am not sure it's necessary here though. And I think if it's useful,
> > it can be added in another patch or another patch series.
> >
>
> I could just copy the warning messages bellow each 'goto error_out'
> and use then at an 'error(...)' call before the goto. But as Christian
> pointed out, I think this would confuse callers wether they should
> print error messages or not. On the other side, it may just be
> different 'layers' of errors... I don't have any strong opinion about
> this.

Right, I think it just comes down to which amount of detail we want to
communicate back to the user.  I thought a bit more detail could be
helpful, but just giving a more generic error should also be okay.

> > > >                               warning("error opening directory %s: %s",
> > > >                                       iter->base.path.buf, strerror(errno));
> > > >                               /* Popping the level is handled below */
> >
> > > > -struct dir_iterator *dir_iterator_begin(const char *path)
> > > > +struct dir_iterator *dir_iterator_begin(const char *path, int pedantic)
> > >
> > > Thinking about the future evolution of this interface, it might make
> > > more sense to have that second parameter be a "struct
> > > dir_iterator_opts".  For now it would just have one member "pedantic",
> > > but in the future we could add additional options there instead of
> > > adding additional parameters.
> >
> > I think it's ok with `int pedantic` for now as improvements can be
> > done when they are really needed. And we will perhaps find out that
> > it's better to just change `int pedantic` to `unsigned flags` instead
> > of `struct dir_iterator_opts`.
> >
> 
> I did thought about using `unsigned flags` instead of `int pedantic`
> for the same reasons Thomas pointed out, but as there would be just
> one flag for now, it seemed to me that `int pedantic` would make more
> sense (following the 'YAGNI' principle). But if it is already known
> that more flags (or options) are coming in a very near future, I may
> change this to `unsigned flags` or `struct dir_iterator_opts` in v3 if
> you think it is needed. Just let me know, please.

Looking at the potential improvements that were suggested in the
initial commit adding dir-iterator, 'unsigned flags' would not be
enough to be able to pass all those options.  That's where my
suggestion for 'struct dir_iterator_opts' comes in.

But I don't feel too strongly about it, and am okay with just an 'int
pedantic' option for now, until we see different usages, if others
feel like that's the better option for now.

> > Thanks,
> > Christian.
