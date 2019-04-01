Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE40820248
	for <e@80x24.org>; Mon,  1 Apr 2019 15:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDAPlX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 11:41:23 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35368 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPlX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 11:41:23 -0400
Received: by mail-vk1-f193.google.com with SMTP id g24so2205268vki.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=arqRLMyZNSrWDmd4d1cbjYjSQVZS79TgXFxTn6qj91Y=;
        b=kLBRTxYyxGkVgi7Ec7NPY++ZjrkQjmkw1hidE9sIpjt5+9zAk7SYctAPLqH7pNaTk1
         LfcLWKM4q0Vj3KTI3keUOyld2EYeAinXg9DB1ToAgdY3xPFBbY99gC9jRTLkspT496Fj
         v99N5URA0IuueJfMO+BSGV0HJqf2YDrYU2RSZaZau+pptVkLsTLXLeN2pJKIPVGmnjSw
         nc5Z2jviQjl3owTGNdMF6D0ttz+W1KfjhETpUP5dxIlwuzJHxLLgm+veyoYye/xagwLz
         i5aoDcsI2x8NhWLGsCFrPJHQvPF8ojCnZwBU1Xi7UrxRW96M3i+JkOUW8pioefYjtwpX
         Lttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=arqRLMyZNSrWDmd4d1cbjYjSQVZS79TgXFxTn6qj91Y=;
        b=sRG3SHX+Oyin7p2XzfjUpYhAuHnO+rCKaO26eVy2qzPjkIEngEy9FGkedC6S/6kopN
         lsA6TkGxOz5wfuVMW81mJPwi4H7EZ6vTB9UIuY10bQtwDSxpUt3a2XyRaP2xooAisfLu
         //jL8YiBgmutv4RruWto5T/H1Mx47p9RARGPGiWTReMveQHWgI+iBH3A7m1NQuqCDHpt
         IQCRLsT2Q2ZsMRvFXbd0SxdH2c9MN5TG13/WxWCTrdz06rFFPzuIovU92Ibnm6eKY6SL
         LREiDtP+Phf1THJfIxFMhseBqKR61yhU4TOBrlotD+2NW1FJmFFlkmws+dhMCiVPjfiN
         MOvA==
X-Gm-Message-State: APjAAAUsB5dTV3pgFIE5OSV/tRykBrIah49gRcHAYkWi/AwGV5enBPkx
        vIKefPOWYfz7xd/706jghXEDnyuSy8joxTMmdxg=
X-Google-Smtp-Source: APXvYqzAv0TEsOzv5qfOA2AdxShhuxihOyRKEHRKiQEQ6G+jyDY7mkjKQKYpY54bEGYEQX66kCJX5QtWDoQ9AxjVr/Q=
X-Received: by 2002:a1f:8d45:: with SMTP id p66mr1617669vkd.21.1554133282446;
 Mon, 01 Apr 2019 08:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190306002744.14418-1-newren@gmail.com> <20190330003336.21940-1-newren@gmail.com>
 <20190330003336.21940-16-newren@gmail.com> <87imw0afp4.fsf@evledraar.gmail.com>
In-Reply-To: <87imw0afp4.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Apr 2019 08:41:11 -0700
Message-ID: <CABPp-BEAMo-+mZcPTSyhts_-6eMcnRYc6bBojJSAtMTS2meHUg@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] merge-recursive: switch directory rename
 detection default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 2:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Mar 30 2019, Elijah Newren wrote:
>
> I may have more, just quickly skimming this for the first time...
>
> >  merge.renames::
> > -     Whether and how Git detects renames.  If set to "false",
> > -     rename detection is disabled. If set to "true", basic rename
> > -     detection is enabled.  Defaults to the value of diff.renames.
> > +     Whether Git detects renames.  If set to "false", rename detection
> > +     is disabled. If set to "true", basic rename detection is enabled.
> > +     Defaults to the value of diff.renames.
> > [...]
> > +     if (!git_config_get_string("merge.directoryrenames", &value)) {
> > +             if (!strcasecmp(value, "true"))
> > +                     opt->detect_directory_renames =3D 2;
> > +             else if (!strcasecmp(value, "false"))
> > +                     opt->detect_directory_renames =3D 0;
> > +             else if (!strcasecmp(value, "conflict"))
> > +                     opt->detect_directory_renames =3D 1;
> > +             else {
> > +                     error(_("Invalid value for merge.directoryRenames=
: %s"),
> > +                           value);
> > +                     opt->detect_directory_renames =3D 1;
> > +             }
> > +             free(value);
> > +     }
>
> Instead of making your own true/false parser you can use
> git_parse_maybe_bool(). See what we do for merge.ff:
>
>     builtin/merge.c-617-    else if (!strcmp(k, "merge.ff")) {
>     builtin/merge.c:618:            int boolval =3D git_parse_maybe_bool(=
v);
>     builtin/merge.c-619-            if (0 <=3D boolval) {
>     builtin/merge.c-620-                    fast_forward =3D boolval ? FF=
_ALLOW : FF_NO;
>     builtin/merge.c-621-            } else if (v && !strcmp(v, "only")) {
>     builtin/merge.c-622-                    fast_forward =3D FF_ONLY;
>     builtin/merge.c-623-            } /* do not barf on values from futur=
e versions of git */
>     builtin/merge.c-624-            return 0;
>
> Small nit, but allows us to document "this config takse bool or ..."
> without having different verions of "bool" in various places.
>
> Also, I don't care personally, but this also violates the "if one thing
> requires braces put it on all the if/else arms" in CodingGuidelines.

Thanks for taking a look.  I'll make the fix, and wait for other
feedback before resending.
