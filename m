Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A6C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhLUXPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbhLUXPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:15:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E46C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:15:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so2473760edc.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5SxpUVwq0j52J8MMaypwb1bExztDF+7jJ4QHXuT2sNo=;
        b=X0oeMOE7Vi9X4rgSRDjOEAj+cpZ0AO3XU1C3oAoAdjkRmhs/lrt+kIoaMGytNeWOMT
         KvGgC7qRQBQ9B2Rqk/OZmQfDOcnPBWSob2JVhsSPShY5DHjsbDr6e5Men7H0lRNyVmD5
         z1FrNyoCEQkoRqlBIvI5g0Au9nAs84gfAsTrc/qK3HlRE8eGklEzt1x/m4+WlJ5pHRnH
         h3CHjqQYoKkbyfjrf3zONeuTw546NI8ms9v3+GgWUAgzxvQyCbE2kPJu2DVU0u363kyf
         91hGLMNsKj7NwyqmGzwiQM+zXDXD1MoDF5txRLpGn3sM0Ufca2HDoevwv7RXxdv6xDeM
         Qi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5SxpUVwq0j52J8MMaypwb1bExztDF+7jJ4QHXuT2sNo=;
        b=jVadxx34KcL5bOsZbFet8mB3OVfHNKCBC4YvCxtczt/AjTJvlK7nzp+EYMMoCz9Ldz
         9BmHDKn5ahgwpifrYtsfELrq4aiYmBV02jf/YkG7CAw+A75MWk/Ui8aQZfvxBU+y2/TQ
         bt+kHtoa8WyOprggb/CKfAB7oI3uKlwxFYj20S+Gj/0De7SOjGdtGhTQo0N/FbkKFD3f
         lLHtlT1onv9blWledNMvsSZCM3oIRtq4CcWriTjc2u1KNBaYCWRQxmUvsGQBkqUXQFAR
         DOfqDcMA/A2cXsv5IxDdxk2v7nH4UVvEHhVcMv+3wYYAj3fg0tvNqQPSnqn6aOSaizK2
         24sA==
X-Gm-Message-State: AOAM5326UC72h6yIUT2fa5gGN+iqxGpU74gM3BzcilxdJ3Sctf4JbfjW
        mgK/wV9Uu+wTGPImUnfZzjuiZMixrHPa5TXT8VD/OW6VO0A=
X-Google-Smtp-Source: ABdhPJz+WIBJ0eJeUapLs+6L3phAN1LgkZJOYVwc4VagqPXhBYSU4lHBNyLYSzZevL0B1FuwgwB46nkhAiQfR9zoqHM=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr407945ejc.493.1640128552958;
 Tue, 21 Dec 2021 15:15:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <d022176618d76943743940da0787291d51c9b4f0.1640109948.git.gitgitgadget@gmail.com>
 <211221.868rwdr6wc.gmgdl@evledraar.gmail.com> <CABPp-BHZH=hdEZ=iYQK_Gg+3aXmJj4uv4SZcJB=J4_K=TTKwHQ@mail.gmail.com>
 <211222.86v8zhpnm5.gmgdl@evledraar.gmail.com>
In-Reply-To: <211222.86v8zhpnm5.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Dec 2021 15:15:41 -0800
Message-ID: <CABPp-BEh1y3X9GcEghEBNd_t+wog0ayXgD-Bftc5zA-nidPhZw@mail.gmail.com>
Subject: Re: [PATCH 2/9] ll-merge: make callers responsible for showing warnings
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 3:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Dec 21 2021, Elijah Newren wrote:
>
> > On Tue, Dec 21, 2021 at 1:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:
> >>
> >> > From: Elijah Newren <newren@gmail.com>
> >>
> >> > +     if (status =3D=3D LL_MERGE_BINARY_CONFLICT)
> >> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
> >> > +                     "base", "ours", "theirs");
> >>
> >> This & other messages in the series have warning/BUG etc. starting wit=
h
> >> upper-case.
> >
> > Yes, but I'm not introducing a new message here; I'm merely moving an
> > existing one.  It's important to me that readers of this patch be able
> > to verify that I have made no functional changes in this patch, so
> > fixing the case should definitely be a different patch from this one.
> > I kind of think that fixing the case distracts a bit from the point of
> > the series, and the series is already kind of long, but do you feel
> > strongly that I should fix the case with a new patch inserted into the
> > series?
>
> I just missed the bit where it was moved from below in the diff. Sorry
> about the noise.

Nah, no worries; thanks for taking a look at the patches!
