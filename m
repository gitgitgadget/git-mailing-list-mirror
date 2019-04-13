Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB42120248
	for <e@80x24.org>; Sat, 13 Apr 2019 10:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfDMKUO (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 06:20:14 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38989 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfDMKUO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 06:20:14 -0400
Received: by mail-it1-f194.google.com with SMTP id 139so19820082ita.4
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=69kc6lzmXV38hq0x6S0dlX+/IvyVEeOkpOYVkrqlQog=;
        b=QZz3VTAfcAjCa2z4Qz3yGfjTWIvtoB4YhypbYieWAcfmV8X/SQ4fapmdLFgQL2dwZM
         +2CvVBMFAgfJ/7tPV33jX71ywrFbIgArW8ggbWnI9xbJtQtQ2UwV9QgSMkQyFJN+DZJa
         PlKQn+Heu/k/qTqXFpwXNOeJwCF1kwm7AfuV9GX1d3TVQGuyEde1rcSDwR+mqwpQ8FLo
         kqhwsBWffkkiikwZR7Igml8qKI6fobPq1doT4G8EyX4qbJwLs6JTAvQEWzhIpp/HYXIL
         Epr9p9KjGrXFMrnvwsUG6CVO9WI7hNc/64JuoHarReGoqBPcjTOHC8cLqUvsZ8er/I1s
         2yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=69kc6lzmXV38hq0x6S0dlX+/IvyVEeOkpOYVkrqlQog=;
        b=iq/fNrLnXnBWwxn4pvXgFusYM8PXkBAr0IwMHxSSoP9L8ygVUR5lQJtPLJb6zokncU
         uoXl+Mof9vPGcgRqqnRValdavcPYr+EabihdWz+y7SKtTOJfIp+PcQRtf5S6HG0xnadE
         xneyJCGYMsqnfzw3s8iFrd6p8/pjC7kF1k7Y30p9i6ShsR5ayTp1qRpfA7BFs7MdP0AR
         ilxiUCf7BUUr2y0uY8KjxsP2YUkCkDqWMkp6fTwUsi1xU8t1ROC6iCPmSxaRIoDSPae6
         oTVQNfxETRc5sndfCqWCpJ5rsvYlrX5g0FBeb/q9HLFgeNSZvXVPWAe+wDPEFzHnuzpZ
         IT2A==
X-Gm-Message-State: APjAAAWAM09/mtJOyQ5J4CCv4FFQ6xlJJGc9Pi/OqgliWr8zRfluC/L1
        JRJmumgrLY58knblJAXgRO5t9P3Xmn7imUJDyqg=
X-Google-Smtp-Source: APXvYqz6RLXnY2OPnZguFT929p+3hHoLhyNq8N0pMVyyeXLqzhQIK8YUM+RvOdPBzz1gZAJcyM0vZtgFG8j9IlMhixU=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr15578340itb.107.1555150813113;
 Sat, 13 Apr 2019 03:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com> <20190409102649.22115-1-pclouds@gmail.com>
 <875zriga8f.fsf@evledraar.gmail.com>
In-Reply-To: <875zriga8f.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 13 Apr 2019 17:19:47 +0700
Message-ID: <CACsJy8AEZ-Lz6zgEsuNukvphB9TTa9FAC1gK05fhnie2xtfc9w@mail.gmail.com>
Subject: Re: [PATCH] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've had enough. Please drop this nd/precious. I'm not updating it anymore.

On Sat, Apr 13, 2019 at 4:54 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Apr 09 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> >  Here's the replacement patch that keeps "git clean" behavior the same
> >  as before and only checks 'precious' attribute when --keep-precous is
> >  specified.
>
> Cool to have the expected interaction with -x. Thanks.
>
> > -'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pa=
th>...
> > +'git clean' [<options>] [-d] [-f] [-i] [-n] [-x | -X] [--] <path>...
>
> For e.g. git-status(1) we just say:
>
>     git status [<options>...] [--] [<pathspec>...]
>
> And for git-add(1) we do:
>
>      git add [--verbose | -v] <very long exhaustive list of options
>                               spanning 4 lines omitted>
>
>
> Seems we should do one or the other here, i.e. either just add
> --keep-precious to the list, or leave it at just:
>
>     git clean [<options>...] [--] [<pathspec>...]
>
> > +This attribute is set on files to indicate that their content is
> > +valuable. Some commands will behave slightly different on precious
> > +files. linkgit:git-clean[1] may leave precious files alone.
>
> As noted upthread I think it's better to start with "clean" and
> "--keep-noclean", we can always alias it to "precious" later without
> squatting on that more general term when we (IMO) don't have the full
> picture yet & know if we even want that...
>
> But anyway, with that out of the way and assuming this is kept-as is
> seems we could document this better if we're going to keep "precious",
> e.g. maybe:
>
>     This attribute is set on files to indicate that they're important
>     while not being tracked. This attribute is experimental and subject
>     to future change as more commands are changed to support it.
>
>     Now it's only supported by linkgit:git-clean[1] which'll skip
>     cleaning files marked ith `precious` when given the
>     `--keep-precious` option. This can be useful in combination with
>     linkgit:gitignore[5] to e.g. mark `*.o` build assets as both ignored
>     and precious.
>
> I.e. say it's still early days, that it's "experimental" (not insisting
> on that phrasing, but somehow signaling to users that if they set this
> now it may do new/unexpected things in the future), and briefly describe
> how it works with "clean" and what the main intended use-case is.
>
> > +test_expect_success 'git clean -xd --keep-precious leaves precious fil=
es alone' '
> > +     git init precious &&
> > +     (
> > +             cd precious &&
> > +             test_commit one &&
> > +             cat >.gitignore <<-\EOF &&
> > +             *.o
> > +             *.mak
> > +             EOF
> > +             cat >.gitattributes <<-\EOF &&
> > +             *.mak precious
> > +             .gitattributes precious
> > +             *.precious precious
> > +             EOF
> > +             mkdir sub &&
> > +             touch one.o sub/two.o one.mak sub/two.mak &&
> > +             touch one.untracked two.precious sub/also.precious &&
> > +             git clean -fdx --keep-precious &&
> > +             test_path_is_missing one.o &&
> > +             test_path_is_missing sub/two.o &&
> > +             test_path_is_missing one.untracked &&
> > +             test_path_is_file .gitattributes &&
> > +             test_path_is_file one.mak &&
> > +             test_path_is_file sub/two.mak &&
> > +             test_path_is_file two.precious &&
> > +             test_path_is_file sub/also.precious
> > +     )
> > +'
>
> AFAICT this is the first attribute intended purely to be set on files
> that aren't tracked. I wonder if we should test for setting it on files
> that are tracked, and whether we should e.g. warn about that? Maybe not,
> but just raising it since I don't think it was discussed already...



--=20
Duy
