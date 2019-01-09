Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2451F803
	for <e@80x24.org>; Wed,  9 Jan 2019 09:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfAIJNN (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 04:13:13 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:35302 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfAIJNN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 04:13:13 -0500
Received: by mail-it1-f172.google.com with SMTP id p197so10014599itp.0
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 01:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FrVFycy7W6h0647bZBfTKnPKXUkc6ruAItWNipQHQz4=;
        b=g/WIE9/WES9AyI/ImEid9v3yRWRm4V9pcVkbcqgT7mncFUcGlfeMcxDuhQhunhUASB
         Hk1X72hEpybDTZN/VebAZjOaXETxAMu60fI4VfTlHp/laWZ3WUSFCyStUC5q3RCCmRDq
         JDjs/PZrtneynKAh4g5c5DExKIDJC5Omvq23QkoKrc1qbbBYN2iiD/2pfQJkNizqUjOR
         vfGJG9Cvq4+kpv1acOYNJMFc32z+/AcTdxHSvGeqTkvlzLAzhJYdb6vokTAgQ8kyPy8j
         3Z9kU6KxbOPvHigL8gVWHaqBu91qhe0YwqkLGjqz5YKDVA/ZCJ23GeqgzCdCVNhpkkyr
         AT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FrVFycy7W6h0647bZBfTKnPKXUkc6ruAItWNipQHQz4=;
        b=AP6PiJZjloFGdmbgmtC9KR1smTQtk1dduTsPiEm0vuHOi6PxGk9aFulVjWmuKgNhfU
         gNh8H4XgELEmND26gG1NZaYUqI8nbPoFyTL1AIm1ENdyTvXNJ/7FiNuDhASyT2hv+ley
         7c0M9y5wcGa+2p4tVVMLFlVNrO2M5v48GgmqbrCPTcX7D6EeTsenI02H9T1MTng6EXy+
         n4ijIdV34gHOkfzHNVYJNe+Rt8rEJ8Y+qGRNfDSoq86TsRugRluh626mMbRXtYp2so4V
         nOu3qiDT+H3+4FUd93Zt8jR5GVmPxUQgOBZnq5/kx6Nu/w0+mt+f8pVammcCTjxghaJt
         GjOA==
X-Gm-Message-State: AJcUuke1G5nRXy2oPa1qZ6fDUy3dSUz+ebe5fQgryi0cLBtPcA3S/ZuV
        VM7hf/q2vG9QzQu82QHFTKMIq3JT6ZrxhPLNtn//WR8CPY4=
X-Google-Smtp-Source: ALg8bN4uZNycG3s4RaJeYvpj39H0Y9J+r0PTkWyEzKxy8G30RGyUf/3K7T45w2ve0k6YnN/wjU5l5NNSg9hFN4SO/P4=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr3211549jak.30.1547025192323;
 Wed, 09 Jan 2019 01:13:12 -0800 (PST)
MIME-Version: 1.0
References: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
 <CACsJy8Cvc8v_4OEmpgKPWSO5csV6jRya7mnSQjEs4mMhHRq4AQ@mail.gmail.com> <CAG0vfyTdAyEeAuNUpjTrMjUpmT0XNx1ffdbQwYS3fs13UFnP6w@mail.gmail.com>
In-Reply-To: <CAG0vfyTdAyEeAuNUpjTrMjUpmT0XNx1ffdbQwYS3fs13UFnP6w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 Jan 2019 16:12:46 +0700
Message-ID: <CACsJy8B=XyGaDS4XA7fhBqfnWAORJhhKc2giiOf+bm9fWJgoUQ@mail.gmail.com>
Subject: Re: Regression: submodule worktrees can clobber core.worktree config
To:     =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 9, 2019 at 1:40 PM Tomasz =C5=9Aniatowski <tsniatowski@vewd.com=
> wrote:
> > The good news is, I have something that should make it work reliably.
> > But I don't know if it will make it to 2.21 or not.
>
> That's good to hear, is there something I can try out or track?

You can try this

https://gitlab.com/pclouds/git/commits/submodules-in-worktrees

which should support multiple worktrees in either submodules or
supermodules. Be careful though, that branch is only reviewed by me
and I'm not a heavy submodule user to give it more day-to-day testing.

For tracking, if you want I can CC you when I send these patches here
for review. Otherwise you can check Junio's "what's cooking" mails
from time to time and search "submodule".
--=20
Duy
