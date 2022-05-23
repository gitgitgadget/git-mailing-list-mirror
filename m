Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E996C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiEWIbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 04:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiEWIaw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 04:30:52 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331B2189
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:30:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ej7so11599050qvb.13
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=57sJStMHSURhiXUn/GEWzbyw3XcAtvvouA142j9nAd0=;
        b=osEKvYqCvvuqasssYEDN2RZp2eIH9Q6QJ3hIjsenjhNTvWUFoL/X8hV1Ps+wTKstix
         4xwnoc9X25POI0EmpzgXnUfkG36gpD50AG6M2jH+QEIUKhOkpWOou63lNJDO7uADuPUk
         zUOPFz8vDqa4whDoIfSHEm/4Dg51C/120duQ+Z/Vdqkxbr38uMNJ7buiAGhbr/eYcz+G
         LPLQTdeBVnebbGJmJtRkxhZFrTUUtTGR9IGIjZdzTTDNkxD5MSbI9CIPT/ftsTcx46iR
         n5Ag/5aQA2VdunY3rIZncHaRZEam09bE2vRrCcfw0VONZsUkwQqRunZCvn8ia1bVHoV8
         GUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57sJStMHSURhiXUn/GEWzbyw3XcAtvvouA142j9nAd0=;
        b=tl1ofpIr2oKW/YgeQQz8WDpo2puUIUct9jIYspcqkd5hhkaLGBqb72rn5gIP+hHRr7
         3VeHozGhGLWBld23CX819no526oo3N/Zn7sC94TTlaX+6lCmT3TO3vlU//WcHRzkVJf0
         yabytPVZZUQTENtAkROI3+BcvrsKrPDNPUHAr6vzm41Tq+tGKyRb+LmKS33cJvGAmRm0
         YZ8YXAju1GsdPzb4mUQGMvODCS+bGC0RhyKFQzQV+cTIJfKZx8NRetdj8ExI8LCnPoIF
         zhjoeLcUTS0vvgSgXZaoAFtgoo2JFB2XFjnqNqKSny5T+NP3J6o8uPbMxh/d1Hj8/lTM
         8ELw==
X-Gm-Message-State: AOAM532PqMe8ZoYE0/934W9WKLPEDFjbmt8+xdZApYtvk46GgX3esOaf
        4dBA7SMlEX7PIB7H6I0lyBxBYB9W3Ixm1kNoebY=
X-Google-Smtp-Source: ABdhPJzjaljZqXAnSBf0u13edfBjJC1q/Dvrd9embVVq405hZfZ+MI8008dbFj3SLglqzfRpkd5JZtJy+mdwRxoppXw=
X-Received: by 2002:ad4:5ce4:0:b0:461:c2b3:636a with SMTP id
 iv4-20020ad45ce4000000b00461c2b3636amr15976395qvb.18.1653294650513; Mon, 23
 May 2022 01:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-7-worldhello.net@gmail.com> <220523.86r14kzp2t.gmgdl@evledraar.gmail.com>
In-Reply-To: <220523.86r14kzp2t.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 16:30:38 +0800
Message-ID: <CANYiYbG6qLvBDHUkQ+6JRL22obLA14nrdcgpqB77TN4Bxqmybg@mail.gmail.com>
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

On Mon, May 23, 2022 at 3:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, May 23 2022, Jiang Xin wrote:
>
> >  .PHONY: pot
> >  pot: po/git.pot
> > @@ -3319,6 +3319,7 @@ dist-doc: git$X
> >
> >  distclean: clean
> >       $(RM) configure
> > +     $(RM) po/git.pot
>
> I think I noted "why not add this to clean?" in an earlier round, but
> didn't think it through.
>
> On second thought we should do that, but the reason is that "distclean"
> should only clean things that you get if you do "make dist".
>
> I.e. we add "configure" to a generated tarball, but not po/git.pot, so
> this should just be under regular "clean", not "distclean".

Will remove "po/git.pot" under regular "clean" rule in next reroll. I
copied it from your original patch without thinking carefully.
