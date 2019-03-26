Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66AB320248
	for <e@80x24.org>; Tue, 26 Mar 2019 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfCZP5y (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 11:57:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35189 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732041AbfCZP5x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 11:57:53 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so20871985itc.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OO990CzO+iS4C97bid4b/IcaXIK+HjZG5PpfxN+Q+1Q=;
        b=G1KU80fU5xGf4Hd81ZubYmJOnu4D1+7/70HRMDS0EAabZywvSr4kjCDe+7QlOQcom3
         uPwaBAFdL9iho7IIS1aZ/h7jw4+B55qX6L5mXT15h7x53xtWfJlgFC3Q0sA849CDRjvq
         ILc9Xd9WP5mZgqMywL2z0CuSz1MGu44vUG/MBfcDnFlyc6ONPkkhQPe08Y7O8FhUwGPi
         vPmPXEEJeSTTtADvB0MeIwaz9wOc9NY7FjHQbJxuLFPNwJQ22iPz4UWi5x0EGuIpLoOC
         j2GRJWjc+bb26P1DXRc9LVWRTuNRQCRh37zDZOjxx84GCs59Vjm4Ghp6Ik80wlpOTK5C
         x8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OO990CzO+iS4C97bid4b/IcaXIK+HjZG5PpfxN+Q+1Q=;
        b=eDqBc3W6uRzo5lTgskql+c2iaQ63qn7aMAbFHDL/XidhOsVNqSbol9aZoE9Y8dp1jr
         CWx1PKEbqcv395g612hfvEVGSUkQPoD0Z3y4VYYMI8rkedvSj5VkFjq2A85yzPPiQo04
         +NaR6k8W3frNuyJk4/l98/+7Re6haDKSX2ZhsCnMaMWUtceNvhqmKB87AcRMHYifp2+5
         7gAUBFGVGDoJzjGbH1nMngJGZVhvLCN44p5Nd1Og+2TD3l2pNEuW8QvYayfaLQ7cEJjz
         E0f+3UTLS1J4LChEHxjZ/6Vmsa24bVGntFpAMr6W8YfEjQSscs/kP8+TYZ8sRKbYWDQN
         Wb4A==
X-Gm-Message-State: APjAAAVVO0Uu6pgdgx4ytTn/KLHvDHOfrG4rPc8Ilrz85UItj4qo7Xpi
        94pDvNJmIKgfyJ822/h8ONKwY+mAPxon5a21sBEUgifY
X-Google-Smtp-Source: APXvYqzWPacJnVt6wMG7ZcLpk3VjkEaiBRMM7GVq3TMetCs/BUqzhIkA7vhfQIJhuDaGpJXjQbcEQ8imTYnVbgjVmx0=
X-Received: by 2002:a02:1c49:: with SMTP id c70mr16148580jac.92.1553615872853;
 Tue, 26 Mar 2019 08:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
 <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com> <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
In-Reply-To: <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Mar 2019 22:57:26 +0700
Message-ID: <CACsJy8B0ZWHWGbaE8eDAO_+xzATZRkwJTBGLZnQkR7jSrTv9-g@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 10:48 PM Elijah Newren <newren@gmail.com> wrote:
> > > > PS. git-reset shares the same behavior, but it's in a different boa=
t,
> > > > I think. Or maybe I should scrap/replace that one as well.
> > >
> > > reset has traditionally been the home of
> > > how-to-clear-in-progress-state.  e.g. aborting a merge or cherry-pick
> > > or revert was 'reset --hard' (or later 'reset --merge'), skipping a
> > > become-empty cherry-pick or rebase is still 'reset', etc.  So it's no=
t
> > > that surprising to me that it clears out state.
> > > ...
> >
> > Yeah but it was surprising to me that this is not even mentioned
> > anywhere in git-reset.txt. You learn by examples basically, or by
> > experience. But I digress.
>
> Yeah that is slightly odd -- but that at least provides a small silver
> lining: it makes it easier to decide to change it and move all the
> mid-operation-state-clearing to other commands.  :-)

Don't tempt me. Elsewhere in some discussion with =C3=86var I wrote it's
better to add "git-ng" instead of going through the deprecation
process to change behavior of current commands, which also means that
you better design git-ng well because you can't just go "oops, i did
it again" and add "git-nng". And I'm slowly realizing that 'switch'
and 'restore' are just "git-ng checkout" in disguise. That already
increases my stress level a bit.
--=20
Duy
