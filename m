Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB191F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 01:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeK1Mzo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 07:55:44 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:38321 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeK1Mzo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 07:55:44 -0500
Received: by mail-vs1-f41.google.com with SMTP id x64so15087258vsa.5
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 17:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hA0kSDHP1TDrk7GMODBM5gd1MgDbwzDk/hZlg7pwOdU=;
        b=OBejoV7NsR8oyLWEpTUthhIbLiY9XHz6s1yeHa5BRb/WGstr8H6L3s56V32EA4sCHt
         TVGorsr3B+3FFca5cNx/qeS2ta10O+/djD5x6FM9CyyBHXXS1Ve9ZvcNOg9cPNcg7llL
         Cxd7tI8fSGOj47oqEWnK23QyPJgQCT8yPwNUP9DgNoQ3unoEqHZSPLp4jdCzxliAugbv
         Yv8lqutX/41+HMwY47mJCCTeGYMcv6DHqFlEdshgn4w8gFQlotmEvZKbcip/iexJWyXy
         fBImRqy2J47Hq4UU+L5n/WSsTf2+mpcnn1a5SV0gFCmN92hYieK7VnEsn2HfaV69Ij40
         RMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hA0kSDHP1TDrk7GMODBM5gd1MgDbwzDk/hZlg7pwOdU=;
        b=joXUkBkfBjTW0dflPFofiHEJksIgIFrZBGAlOECv08nKEEOLrKIs2Ycrgs8eD+lKYa
         s1/LHbbm/bTyNDLoKsNJ4tkvwW7lAVld4oeIJMtL3NDfhLpEdRCXEnGo+7zZXpTfxuMv
         tCRGQpGPnnMj+WRDB+oFoQO6Wf/96wSTcmpKoNhzKzlAh5myeSzbeRdiIuSmh0SL3YpJ
         AdMNfTqfuYMjFOoGWcyMpNdJct04Hxpds6yv0hnq6Had0EbCjzUpzLpthUMWtieJiNbp
         1eJbqsopD3A27p5lQEAakJ8XPib7WQV9nDixBmZKZry4asjUxW1JHGKSBUAijB/7pRCJ
         ys4w==
X-Gm-Message-State: AGRZ1gKZ+tVuV8NZSNvven758vzCOKo32+yi4KAs/1jxujc0eHNmiC43
        ksNs2laFpwIoyNnAaKhws76nZXJYze+9ZtVNpdY=
X-Google-Smtp-Source: AJdET5cJJjgBqagt7yunoqRhjyBU4W0gYDPR3DkzKxvJAj8cie9jUym9xBWnlGVC3MyxUFyjfnugUAvFpvk5WKiRcWM=
X-Received: by 2002:a67:f696:: with SMTP id n22mr15228667vso.175.1543370151848;
 Tue, 27 Nov 2018 17:55:51 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com>
 <87efb6ytfj.fsf@evledraar.gmail.com> <CAGyf7-F-zs9Xyx623HizpOrv80y3PydReFYw-64w3T7Xfr3CNg@mail.gmail.com>
 <87d0qqysay.fsf@evledraar.gmail.com>
In-Reply-To: <87d0qqysay.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 27 Nov 2018 17:55:38 -0800
Message-ID: <CABPp-BFBLKU5jnpr7scXJdj==qNtHJZ8R+LLMRE7qXT47eXXDg@mail.gmail.com>
Subject: Re: Forcing GC to always fail
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 4:16 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Nov 28 2018, Bryan Turner wrote:
>
> > On Tue, Nov 27, 2018 at 3:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Tue, Nov 27 2018, Bryan Turner wrote:
> >>
> >> >
> >> > Is there anything I can set, perhaps some invalid configuration
> >> > option/value, that will make "git gc" (most important) and "git
> >> > reflog" (ideal, but less important) fail when they're run in our
> >> > repositories? Hopefully at that point customers will reach out to us
> >> > for help _before_ they corrupt their repositories.
> >>
> >>     $ stahp=3D'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc'=
 && git -c gc.pruneExpire=3D$stahp gc; git -c gc.reflogExpire=3D$stahp refl=
og expire
> >>     error: Invalid gc.pruneexpire: 'Bryan.Turner.will.hunt.you.down.if=
.you.manually.run.gc'
> >>     fatal: unable to parse 'gc.pruneexpire' from command-line config
> >>     error: 'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc' fo=
r 'gc.reflogexpire' is not a valid timestamp
> >>     fatal: unable to parse 'gc.reflogexpire' from command-line config
> >
> > Thanks for that! It looks like that does block both "git gc" and "git
> > reflog expire" without blocking "git pack-refs", "git repack" or "git
> > prune". Fantastic! The fact that it shows the invalid value means it
> > might also be possible to at least provide a useful hint that manual
> > GC is not safe.
> >
> > I appreciate your help, =C3=86var.
>
> No problem. I was going to add that you can set
> e.g. pack.windowMemory=3D'some.message' to make this go for git-repack
> too, but it sounds like you don't want that.
>
> Is there a reason for why BitBucket isn't using 'git-gc'? Some other
> hosting providers use it, and if you don't run it with "expire now" or
> similarly aggressive non-default values on an active repository it won't
> corrupt anything.

...assuming no other repo has this one as an alternate, which I
suspect is the issue at play.  (I wrote an alternate-aware gc script
years ago when using Atlassian Stash to try to workaround this issue,
but think I only used it for a couple repos and never got around to
deploying it in prod for continuous use, probably worried I had missed
a corner case.  Had meant to, but at some point the powers that be
decided to push us toward a different repository manager tool, and
I've long since forgotten most details.)
