Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C3F1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbeKFAro (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 19:47:44 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52495 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbeKFArn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:43 -0500
Received: by mail-it1-f196.google.com with SMTP id t190-v6so7448564itb.2
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 07:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fX3CDRZsVO945R5db+OUbdoWL6D1Xgg/lCm3k2uDMLw=;
        b=aKXr/2RcUB0kJVak2gEN0nx+00GfLd5QOPM7Ei50+yPqDxW1yK5+CeGBPm5/ji0nwb
         Dc8aS+BHe8HaWsDvKOi98Z0JXAclELCkjGAIMtkEqk5GOsJewJXQh4jeUNovjt/Bprkb
         Pm1Ou3abOp7E3R7vPDMIaKiodfPO20xb23SXNQUo0Y+0N9BuuF8bilJTBJy70fFWSVHG
         sAZX+JDDMQGv1cDHycDId/fT6Dbgv4sIy84PRAJJ+uI4DbHTwoTp4fuVgC9MGeyUnGdw
         BknKg1/Qj4c4M+BTYGFOM+RO/STi7ByHy3ZObMSo6qBpPgUUdEWs0DDx4+nyW3SY6Fcd
         2Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fX3CDRZsVO945R5db+OUbdoWL6D1Xgg/lCm3k2uDMLw=;
        b=owaMra/vibvqExbiGfFcZtj6wP+LDdn3lIMtr1FRfwLqXFICpEW1Xvz1mz5SPUcUaR
         ETvSDnHtL7fvKHU022eDwSymD6PLeERqnVc3726KIUDRKrfLsdhD3CDRpycmGsJ2xzzf
         HMvBYwOepSqkhd03mym5U98O1qHQPWiVWAyHgkl/oBOxijJqaxO5BBABoEiDiyhKqFeP
         tMnYykTMD+pAFt9yvpHkbndI1xap/B5JRRTJuKDLRtg9Ge0ObdA+riIIOGdc6gSsthzX
         71T2lFWWZh1IqDJCrLIXj6yVvHN1ljQarGmDkDvulcU3CYZTGa1b3awjC+27NW5ZJ9mm
         xt2A==
X-Gm-Message-State: AGRZ1gIC0vWpIDiEQnJ/Uo0poDyxl6AccchOQA/AQCJXZuj1ZDGOu9iH
        TBK+W03xNYks/2wTeKx8+47w6Qa//cPEyp1Koug=
X-Google-Smtp-Source: AJdET5d7+r7wV5FwjKWGpQbWHzorKLC/boApBnBWXVq1Ud3Hge8WxmIOJER+AEQUwy943/b2ZhMPh8KqhE28RN7L9Dc=
X-Received: by 2002:a24:ac5c:: with SMTP id m28-v6mr1461741iti.123.1541431649984;
 Mon, 05 Nov 2018 07:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20181030191608.18716-1-peartben@gmail.com> <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
 <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com> <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
 <87ftwf7nwa.fsf@evledraar.gmail.com>
In-Reply-To: <87ftwf7nwa.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 16:26:55 +0100
Message-ID: <CACsJy8Coyw-yiumAfTeASSPdzWXeRgtrS8Ta-VtYph4QnPunVQ@mail.gmail.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 12:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Nov 04 2018, Duy Nguyen wrote:
>
> > On Wed, Oct 31, 2018 at 9:53 PM Ben Peart <peartben@gmail.com> wrote:
> >> >> +core.virtualFilesystem::
> >> >> +       If set, the value of this variable is used as a command whi=
ch
> >> >> +       will identify all files and directories that are present in
> >> >> +       the working directory.  Git will only track and update file=
s
> >> >> +       listed in the virtual file system.  Using the virtual file =
system
> >> >> +       will supersede the sparse-checkout settings which will be i=
gnored.
> >> >> +       See the "virtual file system" section of linkgit:githooks[6=
].
> >> >
> >> > It sounds like "virtual file system" is just one of the use cases fo=
r
> >> > this feature, which is more about a dynamic source of sparse-checkou=
t
> >> > bits. Perhaps name the config key with something along sparse checko=
ut
> >> > instead of naming it after a use case.
> >>
> >> It's more than a dynamic sparse-checkout because the same list is also
> >> used to exclude any file/folder not listed.  That means any file not
> >> listed won't ever be updated by git (like in 'checkout' for example) s=
o
> >> 'stale' files could be left in the working directory.  It also means g=
it
> >> won't find new/untracked files unless they are specifically added to t=
he
> >> list.
> >
> > OK. I'm not at all interested in carrying maintenance burden for some
> > software behind closed doors. I could see values in having a more
> > flexible sparse checkout but this now seems like very tightly designed
> > for GVFS. So unless there's another use case (preferably open source)
> >  for this, I don't think this should be added in git.git.
>
> I haven't looked at the patch in any detail beyond skimming it, and
> you're more familiar with this area...
>
> But in principle I'm very interested in getting something like this in
> git.git, even if we were to assume GVFS was a 100% proprietary
> implementation.

I have nothing against building a GVFS-like solution. If what's
submitted can be the building blocks for that, great! But if it was
just for GVFS (and it was not available to everybody) then no thank
you.
--=20
Duy
