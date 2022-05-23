Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF42C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 08:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiEWIgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiEWIgG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 04:36:06 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD2039B
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:36:04 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j3so11667373qvn.0
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gsi/N1gY3insHVL5klXmGQ6WWzbufYW+soGYu/pvpXQ=;
        b=T+WsoW8akNshpSng46NAYM1KQ+kHKdULgV6T652cFpQUqSAppT/KoStqMIH8y5fbha
         3JJi66dbeH+1CeT8cZzuk/aMNRP4lEQhlOVwjJ0d60sadNG25Vzjp6YbUkriwpL9QHQY
         BE6N16WnKuO9CH1oKZDW+1vHi2YWkQVpkkhQz/4yC9dVTaEDBki5CRoEuAfv26khIrKp
         z4VWI7eYV+D9opA5Ttl1b80i4/MRxq4m04vOAEFTgE9Gb4+IXjCwBXsLp1bt+zkt1anI
         C50cDIE+iOWLnNVWIC44XPLVXVF//2ABHBd9yhC7CSyn6EzYiqWoq78m1N5OlLPFgm8V
         karg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gsi/N1gY3insHVL5klXmGQ6WWzbufYW+soGYu/pvpXQ=;
        b=zv0z9mDcw5n1rKUClXoNSNfI7Ayu39EHWl9afx9Y8UxjeI1zKsKXpRe0QL8YBypeQH
         Ued6HG+PdQjbMUpB4ect6GPsW1LJww4MXLRktmLzdN1qTiikNSxHMnXxayybObfB3Hsx
         KtMM/uJBHH3yAU7fatP0S3lOVpNpo8VR/KUJweICWaJR/cTf6LCSCLSzjetUP4H7GkPh
         vAcmo6Q56Us+x6aKVRsgC6piB14+neEHi5o+eTWYcwMm2SWPt9lI0YnlbdxWAnj28N+G
         +SasbhQwE0SeCvSFgjSY3Y6JU+GedEhzfEedkbjRgVy4jXgr2QMOfH6oi/EoBamYRH4i
         /07w==
X-Gm-Message-State: AOAM531qsUwsVKq/T5VZDfl66bg8WkEWBsrB9fi9zFmrbD+VbVAgPeKS
        aNbb6/hr9Zl80ILCQlh9bmXaZuH7BftjyC26l0U=
X-Google-Smtp-Source: ABdhPJwuDTLuICajytmfKUd/Xr9JPZhFYv8x1WvpOK61djlghVDcxPh9iBd9jD1K00zV6T0zjvm5y/YeocfDhB867a4=
X-Received: by 2002:ad4:5c64:0:b0:462:47e4:ad5 with SMTP id
 i4-20020ad45c64000000b0046247e40ad5mr793835qvh.28.1653294963137; Mon, 23 May
 2022 01:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-7-worldhello.net@gmail.com> <220523.86r14kzp2t.gmgdl@evledraar.gmail.com>
 <CANYiYbG6qLvBDHUkQ+6JRL22obLA14nrdcgpqB77TN4Bxqmybg@mail.gmail.com>
In-Reply-To: <CANYiYbG6qLvBDHUkQ+6JRL22obLA14nrdcgpqB77TN4Bxqmybg@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 16:35:51 +0800
Message-ID: <CANYiYbHMv39HxVTTP7aB9o+Xw=jyGQTKm95mmS6-1LPdWwn1CQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] po/git.pot: don't check in result of "make pot"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 23, 2022 at 4:30 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> On Mon, May 23, 2022 at 3:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> >
> > On Mon, May 23 2022, Jiang Xin wrote:
> >
> > >  .PHONY: pot
> > >  pot: po/git.pot
> > > @@ -3319,6 +3319,7 @@ dist-doc: git$X
> > >
> > >  distclean: clean
> > >       $(RM) configure
> > > +     $(RM) po/git.pot
> >
> > I think I noted "why not add this to clean?" in an earlier round, but
> > didn't think it through.
> >
> > On second thought we should do that, but the reason is that "distclean"
> > should only clean things that you get if you do "make dist".
> >
> > I.e. we add "configure" to a generated tarball, but not po/git.pot, so
> > this should just be under regular "clean", not "distclean".
>
> Will remove "po/git.pot" under regular "clean" rule in next reroll. I
> copied it from your original patch without thinking carefully.

Like this:

-- snip --
diff --git a/Makefile b/Makefile
index 3122672263..161ebf4ff3 100644
--- a/Makefile
+++ b/Makefile
@@ -3319,7 +3319,6 @@ dist-doc: git$X

 distclean: clean
        $(RM) configure
-       $(RM) po/git.pot
        $(RM) config.log config.status config.cache
        $(RM) config.mak.autogen config.mak.append
        $(RM) -r autom4te.cache
@@ -3333,6 +3332,7 @@ cocciclean:

 clean: profile-clean coverage-clean cocciclean
        $(RM) -r .build
+       $(RM) po/git.pot
        $(RM) *.res
        $(RM) $(OBJECTS)
        $(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
-- snap --
