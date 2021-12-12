Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA68FC433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 08:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhLLIzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 03:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhLLIze (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 03:55:34 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8B7C061714
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 00:55:34 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c32so25668831lfv.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 00:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OrGEpASIataGyCTXlOwWYdz7ATqn+O/ybkPK2SAeeq8=;
        b=ZQKIt2+fjjD64SN6lDxVeSR5xPZWGtmcjC+Os9IfCvOtw3cAuls/jzCX+gBGzeMt5E
         kkAzEGSo+tQpbNhqhbWXc1J3rQcVmi100KdcKJiFboAXZqZ62h5XKxewbL57HFtBencF
         3UYnsIIW5vHyRkXlLl9EK3uYbhBx9lctyzd3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OrGEpASIataGyCTXlOwWYdz7ATqn+O/ybkPK2SAeeq8=;
        b=gq2xmuwHpd2weCPDhLNGJ/6aoW/wPQMXkDoxZ94gTNsGgTFYULe/8CKU9y1ct0pTCE
         FHfZF8bIQHvwUS5Km/Yr/fgy0PicL0ySPwyb3fx146BQyff6L5L/e3oXgjdHkeDsMnxH
         BZWfO5Vi9JJ5vPxKwpfuej8Od503HIPG7Gqmyjp1kI8HJawt665+L9XKI3UtNJJyCVY7
         hfKb+VIv45Fp5o934K99rXre/HH4T2gQ+q6t0LR3OcaspMYg8YY7wvXkMPQElGpoHDEV
         fjDGWmqEI1OdiVNPOZxSwqM35QvBKCYMpLvPrmNe9Rqt6JFuy/DzcnsGPS0rpFXwkrA0
         0qdA==
X-Gm-Message-State: AOAM530O9zZvjkSlHAHNbH/zIlA/1Xw682cD0ISulHAJ4zhgDMEE/tPb
        MWMm09KoZXiKjgk0jo0URQXNg+Vc5bHu8EFoKyDJkA==
X-Google-Smtp-Source: ABdhPJxiJK7e9PaMSOsbCbVSFzR5gk9r25jItECxlA+2D4FEVP3SAm4sHBXDgTQqbo8OxnEq5fQw2CAfcEgZO7aUUrc=
X-Received: by 2002:ac2:4e15:: with SMTP id e21mr21582599lfr.113.1639299332105;
 Sun, 12 Dec 2021 00:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <211210.86r1ale0o0.gmgdl@evledraar.gmail.com> <xmqqsfv0m9f5.fsf@gitster.g> <CABPp-BHjc1i4o-Oe2U2fV8_TRgRPfve_mYt=kveTYMy-3BdpCA@mail.gmail.com>
In-Reply-To: <CABPp-BHjc1i4o-Oe2U2fV8_TRgRPfve_mYt=kveTYMy-3BdpCA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 12 Dec 2021 08:55:20 +0000
Message-ID: <CAE5ih7-7eH_ezsvZ6TWjZoHg0PZ2nh7C0rKrWSzCnNe44bR2zw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Transition git-p4.py to support Python 3 only
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joel Holdsworth <jholdsworth@nvidia.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 11 Dec 2021 at 21:00, Elijah Newren <newren@gmail.com> wrote:
>
> Hi,
>
> On Fri, Dec 10, 2021 at 10:07 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> > > On Thu, Dec 09 2021, Joel Holdsworth wrote:
> > >
> > >> Python 2 was discontinued in 2020, and there is no longer any offici=
ally
> > >> supported interpreter. Further development of git-p4.py will require
> > >> would-be developers to test their changes with all supported dialect=
s of
> > >> the language. However, if there is no longer any supported runtime
> > >> environment available, this places an unreasonable burden on the Git
> > >> project to maintain support for an obselete dialect of the language.
> > >
> > > Does it? I can still install Python 2.7 on Debian, presumably other O=
S's
> > > have similar ways to easily test it.
> >
> > Yes, that is a good point to make against "we cannot maintain the
> > half meant to cater to Python2 of the script".  Developers should be
> > able to keep and test Python2 support, if it is necessary.
>
> I also disagree with the reason Joel gave in the quoted paragraph for
> dropping Python2 support, but I think there are other good reasons to
> drop it.
>
> > So the more important question is if there are end-users that have
> > no choice but sticking to Python2.  Is there distributions and
> > systems that do not offer Python3, on which end-users have happily
> > been using Python2?  If some users with vendor supported Python2 do
> > not have access to Python3, cutting them off may be premature.
>
> These are good questions, though I think there's more to it than this,
> as I'll mention in just a minute...
>
> > As the general direction, I do not mind deprecating support for
> > Python2, and then eventually removing it.  I just do not know if 2
> > years is long enough for the latter (IIRC, the sunset happened at
> > the beginning of 2020, and we are about to end 2021).
>
> Python2 was deprecated by the python project in 2008, with announced
> plans to stop all support (including security fixes) in 2015.  They
> pushed the sunset date back to Jan 1, 2020.  So it has only been
> end-of-life for just under 2 years, but it's been deprecated for over
> 13 years.
>
> In regards to your good questions about Python3 availability on some
> platforms: If such platforms exist, they have had over a decade's
> heads up...so let's ask a few extra questions.  If these platforms
> still haven't made python3 available, would newer versions of Git even
> be available on these platforms?  Even if newer Git versions are
> available, would users on such platforms have any qualms with using an
> older Git version given the platform insistence of only providing an
> old Python version lacking any support (even security fixes)?
>
>
> Some of my personal python2/python3 experience, if it's useful in
> weighing decisions:
>
> * There are python projects for which I still continue to support
> simultaneous python2 and python3 usage, though for projects that are
> smaller then git-p4.py (e.g. 1/2 to 1/3 the size).  Such multi-version
> support is painful, and it causes occasional bugs that hit users that
> wouldn't arise if there was only one supported python version.
>
> * I initially wanted to also do the multi-version support for
> git-filter-repo (which is approximately the same size as git-p4.py,
> and obviously also interfaces with git somewhat deeply).  I gave up on
> it, and didn't consider it justified, especially with the
> then-soon-impending End-Of-Life for python2.  I instead just switched
> from python2 -> python3 (in 2019; yes, I'm a straggler.)  Granted, I
> did benefit from the fact that git-filter-repo is a
> once-in-a-blue-moon usage tool (and only by one member on the team),
> rather than a daily usage tool, but I may have come to the same
> decision anyway even back then.
>
> * (Slight tangent) I tried to use unicode strings everywhere in
> git-filter-repo a few times, but invariably found it to be buggy and
> slow.  It was a mistake, and I eventually switched over to bytestrings
> everywhere, only converting to unicode (when possible) when printing
> messages for the user on the console.  bytestrings are ugly to use
> (IMO), but they're a better data model when dealing with file
> contents, process output, filenames, etc.  I think git-p4's decision
> to attempt to use unicode strings everywhere is a mistake that'll
> probably result in bugs based on that experience of mine; it's not an
> appropriate model of the relevant data.  It'll also make things
> slower.

+1

When using python2, git-p4 just ignores all the encoding issues, and I
think this is actually exactly what we want. This means that in some
ways, the Python2 version is currently more correct than the Python3
one.

With Python3, as you say, it attempts to convert to/from unicode
strings, and probably this is the root of the problems.

Perforce has a mode where it works in unicode internally. This gets
configured in the server, and clients then do The Right Thing.

https://www.perforce.com/manuals/p4sag/Content/P4SAG/superuser.unicode.clie=
nts.html

However, many P4 shops don't bother to set this (I know we don't) so
you end up with BIG5 and CP1252 just being dumped raw into Perforce,
and then coming back out again. This causes problems for Perforce
clients just as much as for git-p4 clients.

When git-p4 is used with python2, provided your client has the same
character encoding as the author of the code you are looking at, it
will appear to work. Otherwise you get character encoding errors.

To fix this with python3, we need to make a choice:

- either work out the character encoding that Perforce is sending us
which it doesn't know and can't tell us and then convert that to/from
unicode. There was a patch series a while ago which tried to let you
configure a default encoding.
- or to just preserve everything that Perforce sends us and let the
client figure it out.

The current patch series is (I think) tending towards the first of
those options. But we're trying to recreate information that just
doesn't exist.

Here's the patch that Andrew Oakley sent a while back which attempts
to get git-p4 to just preserve what it gets:

https://lore.kernel.org/git/20210412085251.51475-1-andrew@adoakley.name/

Luke


>
> [I actually think the unicode vs. bytestring thing might be more
> important for bug fixing than limiting to python3.  Though I think
> both are worthwhile.]

+1
