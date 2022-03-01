Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A0C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiCAKAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiCAKAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:00:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C732888F7
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:00:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id bq11so21271831edb.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ut4pJ8uklurg9oL86opiXck30TZaVcIejL9z0Y6/hqM=;
        b=yO5KRpX82HW+6cEwt0YKird1bCo+hUAr9Fdid9eBB3C0ssAOw557jt9pNLPLdKBrRr
         GH0ypqHHzc4k7CRmNxSQiJpQ7LjNnDigvz/6VlPbMZ3LFyxjIYt24leectMqQBOePCKd
         /AcnTbToARnWISRnzhSQRKxGD3P0TBKLbk1ZokC5ScHY3an4Iq7Hyyb5LShLFB8vas9q
         iTdKantewDftA8/585BqwvasolxPFDri/hMxob1ebqL8X0L1WpsGNwNiBk+XCre5llyH
         XDHXpkf08ArGukdzrNAWX5Q17tFalFKj+K4ipSjcgdr7oGynHk+HgYc6tEGJ5RNxysSF
         kJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ut4pJ8uklurg9oL86opiXck30TZaVcIejL9z0Y6/hqM=;
        b=lIVcJJZ0Z1zijS2LMU1z4EhuaH62teztjUX1GoNEWbGmWXuJJgdLJsf3BOK5BecXhv
         F1u5aeCds/yRTVj1NKh4KeFaNSJxnVr8Wc0LoMR0a6vYKiyECRQ8KmBa+KFOXWmLNW9K
         YGow/ArvwlcunOo3oCmOMk+S68CrrhHzTLNcUj+yFfIkrTbFN5sXahq6d94o1yS0/+Rs
         5QDq5z6orb/4Kh1wG/UkkH+yKdGz1+P+qB3V8l5Ldt5R1VjlzZPhW4IEwaS/OvTe2r8c
         3ONgqwLUv3JMc1rtchzRhzzMHjHNQZ6iPfBuoTDlzevhwTvLfNq0nFTKVH8QNtt7sCBG
         zL+A==
X-Gm-Message-State: AOAM533z5geDw9KO+QqRdlgjzp0qmFIkirTX2u7SdW1IxIjpBMdgSzlv
        HrXxIsrumibHgu1ikRSlKRGKQdbp3ZCUQ4swTYJibA==
X-Google-Smtp-Source: ABdhPJyKgzSKDYBWJ5iMGYEGTZlpi+UVTiWYKbwyFDqtz6YIVm75VvK7K0G+vIfeYWIuNHxJ/TqM6YFTbz/fP9lCfr4=
X-Received: by 2002:a50:fc05:0:b0:408:4d18:5070 with SMTP id
 i5-20020a50fc05000000b004084d185070mr23693199edr.365.1646128806019; Tue, 01
 Mar 2022 02:00:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
 <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com> <d5b18c7949fdea966d31b2b8ca3f8aa8ed3a86b6.1646032466.git.gitgitgadget@gmail.com>
 <220228.86o82r5nzm.gmgdl@evledraar.gmail.com> <CAPig+cQQ30XZ1zAguZNgEMTFK3P029Ds-miXQq=A-_pd4HGiGQ@mail.gmail.com>
In-Reply-To: <CAPig+cQQ30XZ1zAguZNgEMTFK3P029Ds-miXQq=A-_pd4HGiGQ@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 10:59:53 +0100
Message-ID: <CAPMMpoj6JM84v5kD8sFWG+157r9DHGckt9_uNrY6LMz3rQKA2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t3200: tests for new branch.autosetupmerge option "simple"
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 1, 2022 at 3:59 AM Eric Sunshine <sunshine@sunshineco.com> wrot=
e:
>
> On Mon, Feb 28, 2022 at 5:54 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > On Mon, Feb 28 2022, Tao Klerks via GitGitGadget wrote:
> > > +     test $(git config branch.feature.remote) =3D otherserver &&
> > > +     test $(git config branch.feature.merge) =3D refs/heads/feature
> >
> > Use:
> >
> >     echo otherserver >expect &&
> >     git config ... >actual &&
> >     test_cmp expect actual
> >
> > etc., the pattern you're using here will hide git's exit code on
> > segfaults, abort() etc., and also makes for less useful debug info on
> > failure than test_cmp.
>
> Better yet, use test_cmp_config():
>
>     test_cmp_config otherserver branch.feature.remote &&

Noted, thx.
