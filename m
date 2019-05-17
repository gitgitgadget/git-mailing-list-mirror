Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93171F461
	for <e@80x24.org>; Fri, 17 May 2019 13:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfEQNIO (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 09:08:14 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:46802 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfEQNIN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 09:08:13 -0400
Received: by mail-qt1-f169.google.com with SMTP id z19so7786169qtz.13
        for <git@vger.kernel.org>; Fri, 17 May 2019 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+EZTuKwCuqFpl+N2o74DQUFtoQBuaLKhnQCt24g5emc=;
        b=mxTwHIyqe4u4L+cs9kPxUafci4ovQ8bf7gyuf9/66CAw8yrnoH1g+Z2gpaPdMjgW/+
         GLWdzaH1wqPkhkiUHOnVi/o1224X/NM/PbrzSV4gA5YJk1dyJz3FX5XzwhjzQHUG1m7z
         e6zEkQEAxkjGCCLJWObQ0YtqqRi35x8UEtYMlUK0/M6IPEnkgTgwZnOyhQjGZdnacaIz
         nXbGZ7DUkQTRLCWyGA5HmSd22QguBvnwkaRWDO/uxeg2hpGt9EfQznreNzlLMboKWlbG
         c7qFl3H2GIHNCmF9mAlCwgrs19B8SYHbAzYz1bqbhUSZcAXhnsf6p3O36LaaxT84TcCu
         tKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+EZTuKwCuqFpl+N2o74DQUFtoQBuaLKhnQCt24g5emc=;
        b=PgAljeUG3TIJq8Psm1/JGWNMssozpDEFLV3HQCRmfvWR3xwpEqi+/O/ZBd/5FF17mr
         bBxGXeTLc+n/Wfq9bNRGwKOZMt8CvIMcd5RW6MbLspLAUUSW7bqD4xZtLoUDn073EL6I
         blwIme8g6hKoq6LsuUfeKMszl6I+8r9ejlcxGQmAzPbI+XPzrgDg6u7djY9Tm7kKvceS
         Wd3akIYoZt98A0U4kaYPGnGU9NYys+Pjm0BNCvdk1HAXAwuzCYvIxV0GuOXvLC1rYo2b
         6iJI2z9ufA0ABtnR1dcCOEKIymqgYY9CxieFKAQcJ5v+3b4j0uJIAgfk5qYquPnqmFVy
         529A==
X-Gm-Message-State: APjAAAXWnqKScUiuYobsRMoCXN4xbGl144E3dgnoIGBlTVHPy6qtDZ5Z
        ael6KErVZGqOrFjrA7R1hnWDnTNs1Il2vDV7kgRXyYc7
X-Google-Smtp-Source: APXvYqzx03OCBSIDcgYrUlSZkTzMZsT3XvfnFhD9IE3t64BzsCRq7rpNjrcrmLSCOI/ecYR4tHeMMJ1b/z9W2ZuUfrY=
X-Received: by 2002:ac8:18aa:: with SMTP id s39mr46739063qtj.169.1558098492803;
 Fri, 17 May 2019 06:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
 <874l5vwxhw.fsf@evledraar.gmail.com> <CABPp-BGycoHEMN27Z9rAccT5yVRf3N50o4sc3wo8uE_HLR9QbA@mail.gmail.com>
 <CAA01Csqu6g0QPLNG5LOnkSzN=-De5X=KnqyDS3Bqb980+_FQ+A@mail.gmail.com>
In-Reply-To: <CAA01Csqu6g0QPLNG5LOnkSzN=-De5X=KnqyDS3Bqb980+_FQ+A@mail.gmail.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Fri, 17 May 2019 15:08:01 +0200
Message-ID: <CAA01Csq0eX2L5cKpjjySs+4e0Sm+vp=10C_SAkE6CLpCHBWZ8g@mail.gmail.com>
Subject: Re: Merging (joining/stiching/rewriting) history of "unrelated" git repositories
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 8:38 AM Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
>
> On Wed, May 15, 2019 at 10:34 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Wed, May 15, 2019 at 8:30 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> > >
> > > On Wed, May 15 2019, Piotr Krukowiecki wrote:
> > >
> > > > Hello,
> > > >
> > > > I'm migrating two repositories from svn. I already did svn->git
> > > > migration (git-svn clone) and now have two git repositories.
> > > >
> > > > I would like to merge them into 1 git repository, but to merge also
> > > > history - branches and tags.
[...]
> > > You might be able to use https://github.com/newren/git-filter-repo
> >
> > Splicing repos is an interesting case, but unless the history is
> > linear and the branch/tag names exactly match and you are simplify
> > weaving commits together based on timestamp within the same
> > branch/tag, then I don't know what algorithm should be used to weave
> > them together.  There are lots of choices, and "correct" may be very
> > usecase-specific.
> >
> > That said, filter-repo was designed to be usable as a library and has
> > a few simple examples of such usage, including one of splicing some
> > trivial repos together.  (See
> > https://github.com/newren/git-filter-repo/blob/master/t/t9391/splice_re=
pos.py
> > and https://github.com/newren/git-filter-repo/blob/master/t/t9391-filte=
r-repo-lib-usage.sh#L90-L121)

I'll try writing some script using the filter-repo. Looked at
splice_repos.py and fast-export/fast-import format and it looks
promising / relatively simple.


> > Somewhat interestingly, a search on others having tried to solve this
> > same problem turned up
> > https://github.com/j5int/jbosstools-gitmigration, which apparently is
> > based on git_fast_filter, which is the predecessor of filter-repo.
> > Perhaps that tool would be useful to you as-is, though they apparently
> > do ignore merges.

I tried using it but it didn't work. Don't remember what was the problem th=
ough.


> Maybe I should look for a way to first prepare "merged" svn repo
> projectAB. Maybe there's a tool which can do it. And then migrate it
> to svn.

I tried this - use svnadmin dump + svndumpfilter + svnadmin load to
remodel svn repository and "splice" the history (by replacing 2nd
project paths to appear to be added to the 1st project path). But it
didn't work. The resulting svn repository had incorrect history (from
my point of view).

I also looked at reposurgeon. Maybe it could do the splicing, but I
given up on learning it, documentation isn't very helpful and there's
not enough examples in the internet...


--=20
Piotr Krukowiecki
