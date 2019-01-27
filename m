Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AD81F453
	for <e@80x24.org>; Sun, 27 Jan 2019 07:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfA0HUV (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 02:20:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35373 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfA0HUV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 02:20:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so9685787lfc.2
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 23:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iucjSvizLK1p86F1q7Y8I5X/sBOY8H8rSIxCfbaw+JA=;
        b=nKOrKxnnxdYROzv4p8ngUd2jh7YpI7XVQNhlIrd19PeOY2khdlOXCVia1qYibOXI0I
         4Z2uY2ZiSgglxbsmk8NV9VV+UgmsZTBblKOY3ZxO1+PhweREmc8OIKI0SkMFWYokldD8
         i5QCKtiKT7v60OQVxcDaKB6f2S37bjoyU4r6+aTds/xaK1CzkajPwNPdqPDJJVkC+Va9
         6A0O4R/A0DxGBceD0nqqTQUrHFTX8c5HhewCCKU0HAQ4yYVW+15hXFQdi0avdRyBOaDB
         l98MGNNq2cTAzd/QSX8VMAfRb1D+MYH6jB991vN7TalvVZaJEG3mXtbNdSb2sKJavNdY
         M+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iucjSvizLK1p86F1q7Y8I5X/sBOY8H8rSIxCfbaw+JA=;
        b=WJg/+fT8YshlluLA55qbicPEeHy9yymR/xGz6UAiRrRzpdh6TFCOfwVsJFB5DfmJai
         w6yVIHmYFn2H481Wy5+URjDZ2DtBj22QJiTWcEv8nNkTNll3RbFXvnA2va70HM8jgQ07
         x80mcpw2WpB88RbB6EiosEPtmQbIZV8LLc4GPBF9Ei70VkHOuXHx4/UrDogMmOS+Gu+W
         w+8WqaUaFJzDFnlX2pWArblE+ArF4FCxym56m0O1y/HeJ3IGml/RnHCKrPgm0NJVZDiT
         PVhvYoRFS9wYzS5enxfoH/IXyxMj9xmhKzOQ+AbHTOc2uWTTOLV1OfJMwfbuOnIj6fNf
         F9cw==
X-Gm-Message-State: AJcUukduUp+Xt00vsHBcbHL2lCE+1EgifZR7cr1MbwI3u6pwT01N/oxs
        j/pab4J4Qbj24kFh5NYlNMBM6GmIHkq8qCVLzOQ=
X-Google-Smtp-Source: ALg8bN6N0nt2zaEA4SvOFYB8BK42ug/WlRt66HzCpMyqMEgtAwsmfdVS/Or+ic2OWiSWV5DQYqBRDSr+JYnR23lDuiI=
X-Received: by 2002:a19:280f:: with SMTP id o15mr13848117lfo.0.1548573619168;
 Sat, 26 Jan 2019 23:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20190126204951.42455-1-koraktor@gmail.com> <20190126204951.42455-2-koraktor@gmail.com>
 <CACsJy8A+QsSDfL_RX2ctNsV35VpBaSp4M7hR00nSObmmULUmvg@mail.gmail.com>
In-Reply-To: <CACsJy8A+QsSDfL_RX2ctNsV35VpBaSp4M7hR00nSObmmULUmvg@mail.gmail.com>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Sun, 27 Jan 2019 08:19:42 +0100
Message-ID: <CA+xP2SYk-NtvQf3c6ahwdO-W5zfV6D+h-oQOmkuqee=ZsEHHTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Setup working tree in describe
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am So., 27. Jan. 2019 um 01:22 Uhr schrieb Duy Nguyen <pclouds@gmail.com>:
>
> On Sun, Jan 27, 2019 at 3:51 AM Sebastian Staudt <koraktor@gmail.com> wro=
te:
> >
> > This ensures the given working tree is used for --dirty.
> >
> > The implementation of --broken uses diff-index which calls
> > setup_work_tree() itself.
>
> It would be nice to have a test case covering --broken even if no fix
> is needed (so that somebody else will not accidentally break it
> later). I did a quick test and thought it was broken, but it turns out
> I tested it wrong :P
>

There=E2=80=98s only one test ("describe ignoring a broken submodule") whic=
h
effectively tests --broken.
I could reuse this.

BTW, is "describe ignoring a broken submodule" the right description here?
In fact, this should probably be named "describe detects a broken submodule=
".

> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> >  builtin/describe.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/builtin/describe.c b/builtin/describe.c
> > index cc118448ee..b5b7abdc8f 100644
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -629,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
> >                         struct argv_array args =3D ARGV_ARRAY_INIT;
> >                         int fd, result;
> >
> > +                       setup_work_tree();
> >                         read_cache();
> >                         refresh_index(&the_index, REFRESH_QUIET|REFRESH=
_UNMERGED,
> >                                       NULL, NULL, NULL);
> > --
> > 2.20.1
> >
>
>
> --
> Duy
