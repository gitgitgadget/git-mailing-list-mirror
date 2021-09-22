Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75900C433FE
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8BE60F11
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhIVTs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbhIVTs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:48:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877F3C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:46:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m3so16598422lfu.2
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WIBQAJ0vZgBT9yKx1MLZ1kv6aW9xf3uzha+8GKOrU/A=;
        b=ZiornUuPBMqwQqKPZd9vcoT5nbJIBCAWv8TmkpVoOCHzKMSjkrpacjo2Q5PATlIId1
         Ro/OWHh4W6UCAYVy4my5O8f6fI0VEGpE31S0/oiSc6OuhOoDnpg+gZiqXD4OnThBZO1u
         INmDLMCTE/zr0rOKyPw7tkaCHAf+FCHFGXTLlHd3RvMSP70lQnG9lpMOnwCOR57L3Drw
         7nANXMhZUhd+7bONU6qJWr/lHtTa+7YM560U0Q6Em28toI/D1B5t5AAj+LewzL8VNp9h
         UqRol3zJ4VlHyrOTicGJUkn0kc0rQQ7J6PZBtTN+cthkrAtV9WQPaYGB56J0mYUMiQ/F
         HqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WIBQAJ0vZgBT9yKx1MLZ1kv6aW9xf3uzha+8GKOrU/A=;
        b=MdBOgna87a4OHl+DzlJWP0cVc51/01soXsaCqr6GgHWCmA4KgNitTXqo23vavDf/kb
         FeLfy5/TkR5QfmNkad5PAFmsr8MOvSKTYvMecj9YqheE0XgZb5HShLdTjJkIuyWoCbHD
         yjaGSzBQ/EqxbGlmBI8IDKFg+r5/vQ8K/V2BdUj/lTtksQfyXz4PA7TBcquP3DhBPd0q
         MfsajCUI/TgMxIfMyOCsOUvoH7JCPb7kAFlEVn3+6Hynzczk776US3SB0dfguAQ1A5vh
         +yehldPgVth6wDqQjHzJUcvWMPk9DtyKeqFZEX90m1M3MyUARnsYUReZEgvb9xRp3Apc
         e95g==
X-Gm-Message-State: AOAM531SLWoYhhOwj2gL8M5qQQ7BzuhAgl57c/6TdfLCQBtkcKOmLFCo
        exwboYSD53Uu9hH7wtGsUqAl3WZfWSFSL9t2NuCQY20caK8GaQ==
X-Google-Smtp-Source: ABdhPJz2LNCPByXt+FAvV1T+U3sjioCW/cXLvpUaubvCgcrWBactiX4USYJZ8EmV4jPLVVA85r+Dvw9Gk1tdZ7bcFQE=
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr640167lfe.241.1632340014325;
 Wed, 22 Sep 2021 12:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com> <12cad737635663ed596e52f89f0f4f22f58bfe38.1632176111.git.gitgitgadget@gmail.com>
 <87mto58pkc.fsf@evledraar.gmail.com> <CANQDOdc1bNwDYhJ8ck2cwUfKmr3064uBHFDACphW+cGZRd-6EQ@mail.gmail.com>
In-Reply-To: <CANQDOdc1bNwDYhJ8ck2cwUfKmr3064uBHFDACphW+cGZRd-6EQ@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 22 Sep 2021 12:46:43 -0700
Message-ID: <CANQDOddTQZz8+LjX2wB5j+tSO9kj6S9VJGTvxKKU8--NQt7PSw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] core.fsyncobjectfiles: batched disk flushes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 6:23 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Tue, Sep 21, 2021 at 4:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> >
> > On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:

> > > -             fsync_object_files =3D git_config_bool(var, value);
> > > +             if (value && !strcmp(value, "batch"))
> > > +                     fsync_object_files =3D FSYNC_OBJECT_FILES_BATCH=
;
> > > +             else if (git_config_bool(var, value))
> > > +                     fsync_object_files =3D FSYNC_OBJECT_FILES_ON;
> > > +             else
> > > +                     fsync_object_files =3D FSYNC_OBJECT_FILES_OFF;
> >
> > Since the point of this setting is safety, let's explicitly check
> > true/false here, use git_config_maybe_bool(), and perhaps issue a
> > warning on unknown values, but maybe that would get too verbose...
> >
> > If we have a future "supersafe" mode, it'll get mapped to "false" on
> > older versions of git, probably not a good idea...
> >
>
>  I took Junio's suggestion verbatim.  I'll try a warning if the value
> exists, and is not 'batch' or <maybe bool>.

An update on this.  I tested out some values:
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dbatch a=
dd ./
    fsync_object_files: 2
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3D0 add .=
/
    fsync_object_files: 0
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3D1 add .=
/
    fsync_object_files: 1
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3D2 add .=
/
    fsync_object_files: 1
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dbarf ad=
d ./
    fatal: bad boolean config value 'barf' for 'core.fsyncobjectfiles'
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dtrue ad=
d ./
    fsync_object_files: 1
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dfalse a=
dd ./
    fsync_object_files: 0
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dt add .=
/
    fatal: bad boolean config value 't' for 'core.fsyncobjectfiles'
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dy add .=
/
    fatal: bad boolean config value 'y' for 'core.fsyncobjectfiles'
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dyes add=
 ./
    fsync_object_files: 1
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dno add =
./
    fsync_object_files: 0
    nksingh@neerajsi-x1:~/src/git$ ./git -c core.fsyncobjectfiles=3Dnope ad=
d ./
    fatal: bad boolean config value 'nope' for 'core.fsyncobjectfiles'

So I think the code already works like you are suggesting (thanks Junio!).
