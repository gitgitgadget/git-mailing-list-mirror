Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACCAD1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 15:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeKTB5t (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 20:57:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51528 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeKTB5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 20:57:49 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so8864229itl.1
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dCzY8mPNYcaTq5Wm6WE+prVxAB6wqjyICgIguutrlfU=;
        b=Z2hS4m6CpyL3UKv1t/43gkkE2p9mfzRmYC83FvWB1AG+yCg7dz+q4emOPMcR4IZjcZ
         eyATbLj/uSNgIUrK31sDH72DdR2MZfzJkBFVgnAwRnlWq76zZKwDTL5SVhmtTACBtzCt
         3nfaaCCehOH2gPV6UbXEuqh2g2AY4DW958wWHkB3wVO2tkp5LXvwZcQ+aBnKbyWuI3NX
         5b9XTsW+yVhRgzm6jhmnjCyyN19rKxd8LoxXw1EguSFB0y2DjmT4uRsBukvVnjsBYiIA
         SoIMJM3ZYzLsBytssxGGgbbJxOMC1IIyOJW3Zg/HH5eFOEPilgTbKlQyObKK9hI0X9VU
         sAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dCzY8mPNYcaTq5Wm6WE+prVxAB6wqjyICgIguutrlfU=;
        b=OkV/JknQQd0TuGARosxCxXhJnGvJk/UBhOkrQ9qrzoM0GgXTLe3KfJyoCN/rN608Ef
         UlBdwnEOynXks/c+M5wsclBP+Ci9mMNBzD69VSTsDRot7KxmCseHpwXm3rfOm5Ud8ySo
         +QAMqPt4pvixpPx9+M1BmlDA5gcFOZrrwWAsbtqCuTiIyMJzjWpbPbj1XEveX6lG61pl
         YkE7QTEPdEDVLa1+c7vm9AN8HyBA2dhWnnMnGtIrVboStGIcaOIE1Tjhe3DmE5TGwND5
         tj26PF7mcWGLYeL0xiXw9eo69tgkktd2RByMvreonOS/ML6+BSxj/JvRS+2TKRgDImon
         ii+w==
X-Gm-Message-State: AA+aEWZ0Xvsr00PWJcNOhTq2oQWwnGBJqmsS8fpG6Ou7fPIBNzFmrLqG
        0R+THHdIFdknyGKjJHM5KrtrJnLAORVGbQPR7bY=
X-Google-Smtp-Source: AFSGD/WdhxYNgoubUkQx7SiVo1kd/LIfwC3T8inCbzSD5+6NDiGcmx2rJT+Lx+H4wVPTGQiD5uAR0az7I7UelJduuuM=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr4577274itk.70.1542641632166;
 Mon, 19 Nov 2018 07:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20181118164800.32759-1-pclouds@gmail.com> <20181118164800.32759-6-pclouds@gmail.com>
 <87bm6m17kt.fsf@evledraar.gmail.com>
In-Reply-To: <87bm6m17kt.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 16:33:25 +0100
Message-ID: <CACsJy8BNs=0qyaHnce7-ey3vd8bMh=ObBpCdF=Z+6NT2C_fuAw@mail.gmail.com>
Subject: Re: [PATCH 5/5] tree-walk: support :(attr) matching
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 8:58 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Nov 18 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> As noted in
> https://public-inbox.org/git/87d0r217vr.fsf@evledraar.gmail.com/ I'm
> happy to see this implemented. I have not read this patch in much
> detail...
>
> > [...]
> >  Documentation/glossary-content.txt |  2 +
> > [...]
> > diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
> > index 0d2aa48c63..023ca95e7c 100644
> > --- a/Documentation/glossary-content.txt
> > +++ b/Documentation/glossary-content.txt
> > @@ -404,6 +404,8 @@ these forms:
> >  - "`!ATTR`" requires that the attribute `ATTR` be
> >    unspecified.
> >  +
> > +Note that when matching against a tree object, attributes are still
> > +obtained from working tree, not from the given tree object.
> >
> >  exclude;;
> >       After a path matches any non-exclude pathspec, it will be run
>
> Just a poke again about what I brought up in the thread you replied to
> in
> https://public-inbox.org/git/CACsJy8CLHQ0mKhKXvTDAqy9TLwEFBSvHEu5UbPxHX4i=
s2mK+Cg@mail.gmail.com/
>
> I.e. the documentation of these various wildmatch() / attributes
> patterns we support is all over the place. Some in gitignore(5), some
> not documented at all, and some in gitglossary(7) (which really should
> not be serving as primary documentation for anything).

Poking me is not going help, I'm afraid. Except bugs, which have
highest priority to me, I do other stuff first either because I need
it or it's fun to do, and this wildmatch documentation is neither (and
I have a long backlog).
--=20
Duy
