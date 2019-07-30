Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1289C1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 00:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfG3AJH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 20:09:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45162 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfG3AJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 20:09:07 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so124082731ioc.12
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DmXtj+PjdPOKVwpPFCuAivHLTGziJaDpoksQQnkD2WA=;
        b=Kl/XcBbe7Q+OA3BcdoLwBRL0BxUAmC8VxZfF+SnoVSG9fCCvdK0pInSN/FrssJJBB3
         JHBJD/ZepvWDM3ZQe2HE0DtmefVa9FNEU+73YBdxvJYDjEJWGGJjpZ6tTj+/WtEOgDEf
         4keL9yf7sdZiUTiuogk9gxz3dyz4AcMXZfP7+iqqegVzHlMD6wCwLTbB09NRTZYUZ2Ii
         pf8JSdBSPCPG90KZpuxFjg4il3U6RwG8nXz5gHDUj+Z8KtT2dxfkfMOG/KqCDftmgVLk
         9Rb2HDu5I30eYk99CiE55TtjP8+Sq9dOYqhL0eGP7nZ93rNAC3sr/JoH7KkuoUIw7mxg
         Q4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DmXtj+PjdPOKVwpPFCuAivHLTGziJaDpoksQQnkD2WA=;
        b=S+hVfQ596/bQm9S1/6RvvV2V/oNxSu+QnCJXzKx3FAYXv2fDWfC9URgbATXEKx3MO7
         rXjsoJBO7zTcSFLD4+YC2kWYcBHRmrTUa6vwolCs64Mvzfwa1avtqXnizKIJsjKthjfi
         SXU1/z5GzzHraNxrV8AmORpG0yUFpW6pjbMS/3FrqdiN6DtA9jUwlCq55q8Q3rN5MqKP
         r0K0Ri0qjlOYh6uLTqYhNmJJ1K95LTjbTSMaHCx9TLweTE//TbhRhtpHe0Suwe1vCM+c
         x+veC3T09YBq59M/VG5XgBJT4uxeeAc+MAmLcRJbkWtDSnFOED6RbIINKgZ33W9jcsmQ
         WD7g==
X-Gm-Message-State: APjAAAWTQjVHg53jhgpIGeBj+SvTe9Z3bRQdTvQT8MuM/yKlxiT/pfTw
        MMrBPPSaGMEZDnahRkfaxp2gS94ZlQEbhf0ydqE=
X-Google-Smtp-Source: APXvYqzQlIzT+LCJOQPB9LtqdCD4vFF60b3tYZh3/K/V5+1IVkju/IqzmFwKG8AiI9CVaT+pOG5879G4irrsyUoqXFY=
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr32400531ioh.70.1564445346541;
 Mon, 29 Jul 2019 17:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190727202759.22310-1-carenas@gmail.com> <20190727202759.22310-4-carenas@gmail.com>
 <874l376nud.fsf@evledraar.gmail.com> <CAPUEspgowrhj56SzW8cPKjZL28nPTkX-RScKrSAai8i0YkwFaA@mail.gmail.com>
 <7ec60d57-9940-35f2-f7b5-c87d4dc7cdd5@web.de>
In-Reply-To: <7ec60d57-9940-35f2-f7b5-c87d4dc7cdd5@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 29 Jul 2019 17:08:55 -0700
Message-ID: <CAPUEspgRUymY0Tm0zvfoSsYm0dKh8fy=fW-jN4Roid6oZVY86Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] grep: plug leak of pcre chartables in PCRE2
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 1:35 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 28.07.19 um 03:41 schrieb Carlo Arenas:
> > On Sat, Jul 27, 2019 at 4:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>> +     free((void *)p->pcre_tables);
> >>
> >> Is the cast really needed? I'm rusty on the rules, removing it from th=
e
> >> pcre_free() you might have copied this from produces a warning for me,
> >> but not for free() itself. This is on GCC 8.3.0. How about for you &
> >> what compiler(s)?
> >
> > both will trigger warnings for the same reason
> > (-Wincompatible-pointer-types-discards-qualifiers)
> > with Apple LLVM version 10.0.1 (clang-1001.0.46.4)
> >
> > gcc-9 in macOS triggers 2 "warnings"; one for discarding the const
> > qualifier (-Wdiscarded-qualifiers)
> > and another for mismatching parameter to free():
> >
> > note: expected 'void *' but argument is of type 'const uint8_t *' {aka
> > 'const unsigned char *'}
>
> Right: pcre_maketables() returns a const pointer, and you have to cast
> away this const'ness at some point if you want to free(3) that memory.
> Returning a non-const pointer would be more fitting, but I guess the
> idea is that users of the library are not supposed to change the
> contents of the table.

note that this pointer was generated by pcre2_maketables() instead
which is actually "const uint8_t *", but yes these tables are meant to
be inmutable and that is why they are "cost".

there is even a compile time generated table for the C locale that is
used internally and obviously shouldn't be free().

> But wouldn't it be more correct to use pcre_free()?  As long as we keep
> pcre_malloc() and pcre_free() at their default values it doesn't matter
> in practice, but using free(3) directly is a layering violation, no?

yes, but that is the only option PCRE2 gives when not using a global
context which is what the comment in the commit refers to.

FWIW pcre_free() doesn't exist anymore in PCRE2.

> Perhaps just UNLEAK that thing?  There is only a single way to build it
> and we can reuse it throughout the lifetime of the program, so there is
> no real need to clean it up before the OS does.

That would be a better fit if it would be created once in cmd_grep and
then shared with all worker threads (which I thought would be nice to
do in the future anyway), but this change was trying to be conservative
and just to the minimum to close the leak.

Carlo
