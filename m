Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14259208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 15:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbdHJP6k (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 11:58:40 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33439 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdHJP6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 11:58:39 -0400
Received: by mail-qt0-f174.google.com with SMTP id a18so6968210qta.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CP+/ClB/LlYwmVWYzjuOfPOAW30V4bD2OP3PzBktDOM=;
        b=r46sI8iSlAB45M1mEM2aLFfRu4hTJVmawjyM244pdTe5jzQS5EhC1q8QeTLrRNepjo
         0uXfFyKMgA32HU2VzKl/Y8tBLPg6e77gpg/X9JfoLHiUjlCMeMjtbDh1LiJI55j9nj1l
         l8O8Nu7zRrKuxOGn0LY1MouTt3dNTAgoR0mdYOhVCsSuLUZFHIV0lUMHSJEwGEkhBlBy
         EgHvKMBF+5zySmfqS5OHZIyWA+e6sJsnVhNaWyApbNCvyKqJ8ti07damLJrts3KKz1AO
         crDHBMCNnboBCU7NbNK4cDkHMkQF6Ze28bANjjeO0CCtlLWGALQplARbmB2rzMdoEH7k
         x0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CP+/ClB/LlYwmVWYzjuOfPOAW30V4bD2OP3PzBktDOM=;
        b=fCHKcuA22jduUTgeWxMLmGgddWNT0Cpl629eXtFMeOu7qIgXUDoaOO/Z7a6weY3hFu
         LqxG/y9OcmWZ0iOXZi9wiS7YYdUMKaKrjEnLXAGQjQg4waujkX90WZFDoXJzZIvMPVR2
         hNIhzRIunjJQzA/FabsI9TGlUfHKOoezMnsxZFurzOjI+RSaHTVFs8nkIUTLvsb163Co
         JQk0wouDUW4E10Zlk+R1fRCBH6XVqZ+1AMchF+fGbsyojw/MNJLtioj8tIABH/Uo45tf
         fCU3AUYhElSYt7ZhEvpFFYSPktbbIJWDW/36UBIY5kxBO/nMT/rAwvk3oIZ9GO/HOYPQ
         RuvQ==
X-Gm-Message-State: AHYfb5gcj2HPQj7KQQ6yRN+MZnGBzVD477x8hgMArBFckLuDuwx28Vst
        ypC9dEmLWYd/EoZVYQ3f6OJlzmZUBw==
X-Received: by 10.237.49.194 with SMTP id 60mr16128905qth.73.1502380718949;
 Thu, 10 Aug 2017 08:58:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 10 Aug 2017 08:58:38 -0700 (PDT)
In-Reply-To: <24fb9d9c-0b1c-4aaa-7d89-12d322066cff@web.de>
References: <24fb9d9c-0b1c-4aaa-7d89-12d322066cff@web.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 10 Aug 2017 17:58:38 +0200
Message-ID: <CAP8UFD1W5DnXe8a3VUREhzdAOFCExQrudpP4z4CYNuS==rN0eQ@mail.gmail.com>
Subject: Re: [PATCH] apply: remove prefix_length member from apply_state
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 5:54 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Use a NULL-and-NUL check to see if we have a prefix and consistently use
> C string functions on it instead of storing its length in a member of
> struct apply_state.  This avoids strlen() calls and simplifies the code.

This looks like a good idea.

> @@ -2088,10 +2087,9 @@ static int use_patch(struct apply_state *state, st=
ruct patch *p)
>         int i;
>
>         /* Paths outside are not touched regardless of "--include" */
> -       if (0 < state->prefix_length) {
> -               int pathlen =3D strlen(pathname);
> -               if (pathlen <=3D state->prefix_length ||
> -                   memcmp(state->prefix, pathname, state->prefix_length)=
)
> +       if (state->prefix && *state->prefix) {
> +               const char *rest;
> +               if (!skip_prefix(pathname, state->prefix, &rest) || !*res=
t)
>                         return 0;
>         }

Yeah, or maybe declare "const char *rest;" just after "int i;" and then use=
:

       if (state->prefix && *state->prefix &&
          (!skip_prefix(pathname, state->prefix, &rest) || !*rest))
               return 0;
