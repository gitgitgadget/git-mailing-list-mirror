Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E831C77B6C
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjDFIfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjDFIfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:35:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FEF133
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:35:11 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p15so45356873ybl.9
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680770110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFJnq3szbAAj85jaa/BcUeywFmbbuJhgfRHR+oBi1T4=;
        b=iOsTfaSxEoytqlFEAP27uNlKPTuvJCGz55cq+mwQNCA4AHIquWxt+Ef3DrOMWOZtsT
         UBaSGoObLOTD6K07dQvisI8utKLOKf93BNccOyrLUsKltkBSjpsr/k5IXf/bZ7+52ySG
         JjqDVz4WN9RCEmKIXIyE0NiZZe2XRYmvLep1nCTZbVYURtz8dc4FEoaZQXcti6C22X6X
         DJLbv/GAfLCKI82udWawGx8/jF9zNyllvl6B5F5iFl9tCHTIUaAC0Vr5WLilagcUkzkF
         GrdmI2Kk83igr9H2Y5TMmKh9YniAbdqmYf6EnVlrIigcnky2rc8eoo7J5rjokvP+fLVs
         vEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFJnq3szbAAj85jaa/BcUeywFmbbuJhgfRHR+oBi1T4=;
        b=xuTP2iB0GZCYo3vpKsxqYgS+wogyjRt1a8c5Xv5wFlOyYekPD1/1HcY3mHlMGVCp8J
         yfA+KCWNPhixT0ynguKcW4MisCZD2ApzCUyxpiYldZhvCg5CP7IKe9eNRjZ8Hd7jmefJ
         rxZdax3RpQyY0SnCm55ehQdEFBUCljcgMuoDHKOlZC5VCMPF1wd9rYr97+B/exNAQIEb
         POK8GY3plB1uCGQ1YGzwBy2QX1AbqMHzGozcu0Ok2XYEsht96lAua29i2CMDC8K42CaL
         9XOAmXjEt9MJVrCjnDJvN2UmJCO8eEkDDID7lobXzkSlvSkNIX7uhGdxXehU8uDeT7vO
         dXog==
X-Gm-Message-State: AAQBX9fbuHYEvhaiIR/++J4K0N76cUeP02HNspul69vRPp7JVRTf1aiq
        Om5yFcMZSflytvg7WPsRDeLT//mfAT/dP4JK9Xk=
X-Google-Smtp-Source: AKy350ZuRG+Zk5HTXfRpV6cTQTk0PdsQMNgXznl0hC8yJnerwT8dKUw2C483WZ3r2WrYIUAJBCwQJTAL6isYJIqiTWY=
X-Received: by 2002:a25:d28b:0:b0:b45:5cbe:48b3 with SMTP id
 j133-20020a25d28b000000b00b455cbe48b3mr1613518ybg.0.1680770110391; Thu, 06
 Apr 2023 01:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230323221523.52472-1-felipe.contreras@gmail.com>
 <20230406035729.GA2092667@coredump.intra.peff.net> <xmqq8rf5r66s.fsf@gitster.g>
In-Reply-To: <xmqq8rf5r66s.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 6 Apr 2023 03:34:59 -0500
Message-ID: <CAMP44s0DbALdFGsS=+NT6tTze=qK+z8EG0UuBVagPvsq9nby_g@mail.gmail.com>
Subject: Re: [PATCH] doc: asciidoc: remove custom header macro
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 11:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Thu, Mar 23, 2023 at 04:15:23PM -0600, Felipe Contreras wrote:
> >
> >> In 2007 we added a custom header macro to provide version information
> >> 7ef195ba3e (Documentation: Add version information to man pages,
> >> 2007-03-25),
> >>
> >> However, in 2008 asciidoc added the attributes to do this properly [1]=
.
> >>
> >> This was not implemented in Git until 2019: 226daba280 (Doc/Makefile:
> >> give mansource/-version/-manual attributes, 2019-09-16).
> >>
> >> But in 2023 we are doing it properly, so there's no need for the custo=
m
> >> macro.
> >>
> >> [1] https://github.com/asciidoc-py/asciidoc-py/commit/ad78a3c
> >
> > This should be OK to do, as it is just touching the python asciidoc
> > side. When we discussed those attributes in 2019:
> >
> >   https://lore.kernel.org/git/20190320183229.GK31362@pobox.com/
> >
> > asciidoctor support was new and incomplete. It needed v1.5.7 (from
> > 2018), and even today still does not seem to handle manversion. But
> > since this patch leaves in place the equivalent hack in
> > asciidoctor-extensions.rb, it will continue working.
>
> Sounds like the proposed log message can use a bit more polishing to
> help future readers of "git log", then.

Yes, *if* what Jeff King was saying were true, which is not. At least
not completely.

> But I think it is not required to be explicit about us leaving the
> asciidoctor side untouched to keep it working (in other words, we do
> not talk about things that we are not doing in our log message, unless
> it is so unnatural not to do them at the same time to warrant such an
> explanation).

I did explain that we could fix all the issues of this particular
problem for both asciidoc and asciidoctor as far back as 2021 [1].
This fix did not materialize in subsequent patches: [2][3][4][5][6].

But the fix exists, and it's explicitly explained (multiple times).

Basically: instead of trying to make docbook-xsl understand "$version"
in order to join it as "$source $version". We can just say
`source=3D"$source $version"` and forget about $version.

I don't know how I can say it more clearly: we can fix all the
problems for all the tools and all their backends with one simple
patch.

So after 6 attempts I'm trying to change the strategy and only clarify
the problem for asciidoc.py, which hopefully is clear now. But it can
be fixed for asciidoctor as well...*today*.

Cheers.

[1] https://lore.kernel.org/git/20210514121435.504423-7-felipe.contreras@gm=
ail.com/
[2] https://lore.kernel.org/git/20210515115653.922902-4-felipe.contreras@gm=
ail.com
[3] https://lore.kernel.org/git/20210521223701.526547-4-felip01e.contreras@=
gmail.com/
[4] https://lore.kernel.org/git/20210608090026.1737348-4-felipe.contreras@g=
mail.com/
[5] https://lore.kernel.org/git/20210618215231.796592-420-felipe.contreras@=
gmail.com/
[6] https://lore.kernel.org/git/20210621163110.1074145-4-felipe.contreras@g=
mail.com/

--=20
Felipe Contreras
