Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7AC1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeKMB2s (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:28:48 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:39500 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbeKMB2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:28:48 -0500
Received: by mail-ua1-f48.google.com with SMTP id k10so3177334ual.6
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EyVxNpmT/fqOtZ+CJ7/RYpPZn/5LXO72SH1n0XfzsPI=;
        b=Of4g5o3AqsuREYn6bB3z5klWXGiJCeHeXRgjpwRmTLcO2SVr+GMvcQMlnoCADamzh/
         u2P8LZQbnQONMUX8I0qVif9RYfjaVouztDwfoHWvOYPk/Akpvux5T4aPdf+xzonRZ05e
         csT6JAZlYBvCJa+Ss7ADEixk/W932b7ArVDn+tnlFn9Ly633+r3QyaJCMDPpNCiIHfw3
         RHmsh97GPSCK0DwjoAPcyXH7rTOV539Tc8TYXuxqadr7kvDlo2jZIhCozIDCyrQ+k6Fk
         nEhNK8d8GRStP5+SP0mUyR1USf+d+TfyDeCl3uPx4B/1LCAtPMucxWAC8/HK+b+8Vrsg
         BMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EyVxNpmT/fqOtZ+CJ7/RYpPZn/5LXO72SH1n0XfzsPI=;
        b=AFaQPD2B94+Sa23FzXemkgMaNcBVOmdSHR4sjxwnsf5PGwf1Bc320VT9rAYV4ilC4L
         JPog0d1T2sq+GjpJAbcZzYPlYQX2clUSE2gBOvXoFDFqkM9i+hpc+BgSI2cT57YLzhCx
         8CqIOHklnKDqqLARugPZGjE6xT+IqwGqeqJQPXZLA5sI+A6nSvpbMb+M4i5txKDBOimn
         hCUYx4NB8lmEN/M3bF6DNh7+7tz0DrmHJRe7GOgQcXQhn3i1F2w1mDKHlC8MwadWWUBb
         IjNZZppEqO5IasAglqea40rnv9ndzjw0yLy2z1gWq2zIKwKFoNlDDV8N0TnnYM9VjfOW
         jcHQ==
X-Gm-Message-State: AGRZ1gLBkKlEVryzXCEy4Jo4ITxa1BZ5NnA7wQUdJ+lAZgwDEOefiRNd
        xT9E70aPddSH5icxp4R4hLmdJpgnAUqbiib5CBQ=
X-Google-Smtp-Source: AJdET5drYRBjDb202NPdhRXs8+/Dq0MxCDSBXceWAKx/qbFK00TSyowyvfabAVGYt+UpM0IRdy6Ux1sk4vpgEr/rLig=
X-Received: by 2002:ab0:60da:: with SMTP id g26mr607723uam.104.1542036902150;
 Mon, 12 Nov 2018 07:35:02 -0800 (PST)
MIME-Version: 1.0
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
 <CABPp-BGL-3_nhZSpt0Bz0EVY-6-mcbgZMmx4YcXEfA_ZrTqFUw@mail.gmail.com>
 <91771D9B-166D-403F-BB20-7E574444BB3B@gmail.com> <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <87r2fq3b9t.fsf@evledraar.gmail.com>
In-Reply-To: <87r2fq3b9t.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Nov 2018 07:34:50 -0800
Message-ID: <CABPp-BGVhw6HeCb7wTUubEjqxfW3LopB8PXY1TdHrB9Gfd3_jw@mail.gmail.com>
Subject: Re: Import/Export as a fast way to purge files from Git?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 1:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Nov 01 2018, Elijah Newren wrote:
>
> > On Wed, Oct 31, 2018 at 12:16 PM Lars Schneider
> > <larsxschneider@gmail.com> wrote:
> >> > On Sep 24, 2018, at 7:24 PM, Elijah Newren <newren@gmail.com> wrote:
> >> > On Sun, Sep 23, 2018 at 6:08 AM Lars Schneider <larsxschneider@gmail=
.com> wrote:
> >> >>
> >> >> Hi,
> >> >>
> >> >> I recently had to purge files from large Git repos (many files, man=
y commits).
> >> >> The usual recommendation is to use `git filter-branch --index-filte=
r` to purge
> >> >> files. However, this is *very* slow for large repos (e.g. it takes =
45min to
> >> >> remove the `builtin` directory from git core). I realized that I ca=
n remove
> >> >> files *way* faster by exporting the repo, removing the file referen=
ces,
> >> >> and then importing the repo (see Perl script below, it takes ~30sec=
 to remove
> >> >> the `builtin` directory from git core). Do you see any problem with=
 this
> >> >> approach?
> >> >
> >> > It looks like others have pointed you at other tools, and you're
> >> > already shifting to that route.  But I think it's a useful question =
to
> >> > answer more generally, so for those that are really curious...
> >> >
> >> >
> >> > The basic approach is fine, though if you try to extend it much you
> >> > can run into a few possible edge/corner cases (more on that below).
> >> > I've been using this basic approach for years and even created a
> >> > mini-python library[1] designed specifically to allow people to crea=
te
> >> > "fast-filters", used as
> >> >   git fast-export <options> | your-fast-filter | git fast-import <op=
tions>
> >> >
> >> > But that library didn't really take off; even I have rarely used it,
> >> > often opting for filter-branch despite its horrible performance or a
> >> > simple fast-export | long-sed-command | fast-import (with some extra
> >> > pre-checking to make sure the sed wouldn't unintentionally munge oth=
er
> >> > data).  BFG is great, as long as you're only interested in removing =
a
> >> > few big items, but otherwise doesn't seem very useful (to be fair,
> >> > it's very upfront about only wanting to solve that problem).
> >> > Recently, due to continuing questions on filter-branch and folks sti=
ll
> >> > getting confused with it, I looked at existing tools, decided I didn=
't
> >> > think any quite fit, and started looking into converting
> >> > git_fast_filter into a filter-branch-like tool instead of just a
> >> > libary.  Found some bugs and missing features in fast-export along t=
he
> >> > way (and have some patches I still need to send in).  But I kind of
> >> > got stuck -- if the tool is in python, will that limit adoption too
> >> > much?  It'd be kind of nice to have this tool in core git.  But I ki=
nd
> >> > of like leaving open the possibility of using it as a tool _or_ as a
> >> > library, the latter for the special cases where case-specific
> >> > programmatic filtering is needed.  But a developer-convenience libra=
ry
> >> > makes almost no sense unless in a higher level language, such as
> >> > python.  I'm still trying to make up my mind about what I want (and
> >> > what others might want), and have been kind of blocking on that.  (I=
f
> >> > others have opinions, I'm all ears.)
> >>
> >> That library sounds like a very interesting idea. Unfortunately, the
> >> referenced repo seems not to be available anymore:
> >>     git://gitorious.org/git_fast_filter/mainline.git
> >
> > Yeah, gitorious went down at a time when I was busy with enough other
> > things that I never bothered moving my repos to a new hosting site.
> > Sorry about that.
> >
> > I've got a copy locally, but I've been editing it heavily, without the
> > testing I should have in place, so I hesitate to point you at it right
> > now.  (Also, the old version failed to handle things like --no-data
> > output, which is important.)  I'll post an updated copy soon; feel
> > free to ping me in a week if you haven't heard anything yet.
> >
> >> I very much like Python. However, more recently I started to
> >> write Git tools in Perl as they work out of the box on every
> >> machine with Git installed ... and I think Perl can be quite
> >> readable if no shortcuts are used :-).
> >
> > Yeah, when portability matters, perl makes sense.  I thought about
> > switching it over, but I'm not sure I want to rewrite 1-2k lines of
> > code.  Especially since repo-filtering tools are kind of one-shot by
> > nature, and only need to be done by one person of a team, on one
> > specific machine, and won't affect daily development thereafter.
> > (Also, since I don't depend on any libraries and use only stuff from
> > the default python library, it ought to be relatively portable
> > anyway.)
>
> FWIW I'd be very happy to have this tool itself included in git.git
> if/when it's stable / useful enough, and as you point out the language
> doesn't really matter as much as what features it exposes.

Well, I'm happy to propose it for inclusion once it gets to that
point.  I'll bring it up on the list to get wider feedback once I've
removed at least some of the sharp edges.  I suspect it'll be at least
a few weeks.
