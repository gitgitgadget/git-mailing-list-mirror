Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A038AC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8922361184
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhJDN4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbhJDN4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170BFC061746
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:45:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j4so9663651plx.4
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27+ahQQ9s0u98j5EAUSAbUO1giZJa92qxdgb113V86M=;
        b=NjwP8pUsrX1iozv+lXQtgOVEzc56lgIXf2+JSzA0MivsKswsSD8mEsavJPyBgoLYky
         MUXk4z1I7lzTp4l3B9NjzqzrHpJ5yjrRe628inpg6bLyNtxEtzVCFKdvd1oPFf7unwTp
         do0NrnEvkiK2aa/KsH2Qs2nnx+Ns4+n2B9Kc+RQjCI5KOKUT2x8rZFCw6hWWU4MLnYFZ
         9BVOUZGqbbz07ztIeaHKXWGJNDPS/kmhENX7k7UgAh8gYYq7mlPrCLLJ1W+WShVyYMbB
         U9Pado7W//KWkYXQHhIkzrjgBu2LFMfX+4SS8sriuFUdjNPWDIASdi2JNx/CQbCBqHim
         Mg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27+ahQQ9s0u98j5EAUSAbUO1giZJa92qxdgb113V86M=;
        b=YfUT8I+c8F0vlu4sDjYna+JseXF6BbMhdNOC4/QoKJ+TWzvErZmIvmECfKN21lSYNQ
         U40OlS8px8VESC2sEY91fXfGh7hlb2rGNmPlYoo+21gNLzv2++rqf7y5+2CkRIn0PyiX
         dKHx3k5RLvxeILlg9h3j7RYq11u8C7hYdOgmeL5eemvf1ukISao4PT/MqYfPlxH4McMx
         B9PlHnxVvW5+fPT88KlrAAv3KixmG8tcSIvsHI5sOF+cmvvGinpbdW5e6DAf//VJ7ToY
         zbVMXUeNpLTBCXjMSA9+P4IlPpPDZyPZe9WPEw7lHO3wYanq/Mb+AcTiTDgGhedHMD6O
         q2og==
X-Gm-Message-State: AOAM532Lya7o3k45rpO2gq72pHqH6he/Rdqr1/3qOKeb1CTVVQQRJLXz
        g+bfL2FURbkxfxrIYX6ck9UgBFVjq++ABveTDvrBt/8xaIw=
X-Google-Smtp-Source: ABdhPJx46J9pr38hmRoZqA4LTQqyl1NVEI7zUVluiT9pJMpmTxLpRnmD/Ph3HGRPQd8vodKpLodV+BvTdj4+3fbGyvQ=
X-Received: by 2002:a17:90b:1642:: with SMTP id il2mr37277722pjb.133.1633355122483;
 Mon, 04 Oct 2021 06:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com> <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
 <87ee97utaq.fsf@evledraar.gmail.com> <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
 <87lf3etaih.fsf@evledraar.gmail.com> <CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKWatz8-B4RsA@mail.gmail.com>
 <87k0ixrv23.fsf@evledraar.gmail.com> <CABPp-BE_aY4smj_b0+Zz=YrURKMniS=DmyMWVc=q2mVDL8zUOg@mail.gmail.com>
 <87k0ivpzfx.fsf@evledraar.gmail.com>
In-Reply-To: <87k0ivpzfx.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BFE_5zPCZY8adJSQchdQzxq3uH-oma-S=_Sw0OUXx03OQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to unpack_trees_options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 2:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Fri, Oct 01 2021, Elijah Newren wrote:
>
...
> > So maybe I'll submit some patches on top that rip these direct members
> > out of of unpack_trees_options and push them inside some opaque
> > struct.
>
> Sure, that sounds good. I only had a mild objection to doing it in a way
> where you'll need that sort of code I removed in the linked commit in
> prep_exclude() because you were trying not to expose that at any cost,
> including via some *_INIT macro. I.e. if it's private we can just name
> it "priv_*" or have a :
>
>     struct dont_touch_this {
>         struct dir_struct dir;
>     };
>
> Which are both ways of /messaging/ that it's private, and since the
> target audience is just the rest of the git.git codebase I think that
> ultimately something that 1) sends the right message 2) makes accidents
> pretty much impossible suffices. I.e. you don't accidentally introduce a
> new API user accessing a field called "->priv_*" or
> "->private_*". Someone will review those patches...

An internal struct with all the members meant to be internal-only
provides nearly all the advantages that I was going for with the
opaque struct, while also being a smaller change than what I was
thinking of doing.  I like that idea; thanks for the suggestion.
