Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8B9C19F2A
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 20:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiG3UCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiG3UCv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 16:02:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC168140E1
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:02:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u3so9003598lfl.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=5wyU93s/WHKoXGNIlGnjwNiPmbMQXlGF0qQH8wyhEmM=;
        b=Gs9fkdmNvhybPGHAz/r4XpliX2AoYW7V2s+O8tZcM3kKGgrfNSGNlWqAG39RcT5af7
         P/QdoECcEY8TtNGX01sNPsw8l5NLnOneipA00XjC56smItUILsCwrHrAhkpSRhbEBqzf
         owmwyO3kQCItQeXdR0rXM+ry8SfVrC958vZ9JVPP4yLReqv5OCeszg/QJJruAbh+v55F
         Q1QkgxKCp4U1gpdnZ8IUwVLZev9Bx2SBgJSCK30IySaMyepDaeap/AwBOJYtLa1e9ZJ5
         NPXkDw9Ls7IGFA0QfVaAaqmxNI5zZXGFK5dydr1wbmHPx1XMP+IymL1++zciasMOONZo
         ZrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=5wyU93s/WHKoXGNIlGnjwNiPmbMQXlGF0qQH8wyhEmM=;
        b=7xULt67nV+7WGySUbnHZKtnDCkg/dXzBRuKDzfzfuZ3WUjMwyGkAa95fn/4c/jaovc
         rXDCsh84tubGZkZmpluA2VUVG9v1KwqNAZdD8zu9mV0/vOjzrH84qfxJrHiW3o9OqnwL
         TNY+YwsYm69PQ5t4bp9ujt+kQ6a0awMzzyyACMNE7Rd5Jt//b/cXcWXOl8AO7xAwzUE/
         +Fbj/EbQMUSW8E+6AfvEJKfa8iF4n/pt6l536akUpz0qJUkx/wBq00A/4UcZke9f98YA
         e3tT1QPuj0GquAH0WDIAdZYeCxqZEknK3LU7jUdUbXuV0+6ViqEeSj120Dc8AzH/dIgB
         jw2Q==
X-Gm-Message-State: AJIora/cGspyMChYcm9ZAthcluObYZN9jtmFpGahWZAgsAEEmDelydXz
        DZetF1229SPH/oEs4Y1uF8qTpmhx6tk2Gs8sv3gojUAEgMsEuA==
X-Google-Smtp-Source: AGRyM1sRJkPQ5373MkTxWK3izXcV1aWTjMMOw6xdyT+myiK67NifVjj5nI+NH5eguazKqeYvBZH9BFdujsHis3vxak4=
X-Received: by 2002:a05:6512:3503:b0:481:4470:4134 with SMTP id
 h3-20020a056512350300b0048144704134mr3152435lfs.42.1659211365058; Sat, 30 Jul
 2022 13:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <patch-v2-5.9-1b6c8c75df7-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <patch-v2-5.9-1b6c8c75df7-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 17:02:34 -0300
Message-ID: <CAHd-oW7s6Hu24uTjCW9ROBbJkA5+7TCu32a4L_BXVLhcvw5kSw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] notes docs: de-duplicate configuration sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 5:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.=
txt
> index aeef56d49ae..c7c4811734b 100644
> --- a/Documentation/config/notes.txt
> +++ b/Documentation/config/notes.txt
> [...]
>  notes.displayRef::
> -       The (fully qualified) refname from which to show notes when
> -       showing commit messages.  The value of this variable can be set
> -       to a glob, in which case notes from all matching refs will be
> -       shown.  You may also specify this configuration variable
> -       several times.  A warning will be issued for refs that do not
> -       exist, but a glob that does not match any refs is silently
> -       ignored.
> +       Which ref (or refs, if a glob or specified more than once), in
> +       addition to the default set by `core.notesRef` or
> +       `GIT_NOTES_REF`, to read notes from when showing commit
> +       messages with the 'git log' family of commands.
>  +
>  This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
>  environment variable, which must be a colon separated list of refs or
>  globs.
>  +
> +A warning will be issued for refs that do not exist,
> +but a glob that does not match any refs is silently ignored.
> ++
> +This setting can be disabled by the `--no-notes` option to the 'git
> +log' family of commands, or by the `--notes=3D<ref>` option accepted by
> +those commands.
> ++
>  The effective value of "core.notesRef" (possibly overridden by
>  GIT_NOTES_REF) is also implicitly added to the list of refs to be
>  displayed.

This change is a bit complex since it agglutinates the definition of
notes.displayRef from three different places with different wordings
each. Perhaps it would be helpful to acknowledge it in the commit
message and/or justify the chosen parts?

> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 0a4200674c4..68d547e2474 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -44,7 +44,7 @@ using the `--notes` option. Such notes are added as a p=
atch commentary
>  after a three dash separator line.
>
>  To change which notes are shown by 'git log', see the
> -"notes.displayRef" configuration in linkgit:git-log[1].
> +"notes.displayRef" configuration in linkgit:git-config[1].

Since notes.displayRef now comes from config/notes.txt which will be
included here, I think we could replace this reference to
git-config(1) with "in the CONFIGURATION section below".
