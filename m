Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5FEC433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 19:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiDFTmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiDFTlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 15:41:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB32F3D33
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 11:30:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k21so5608541lfe.4
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rLOup0GOEqhoaMMZhAdevax8ZIbsgxqeUb1VEioLBZc=;
        b=bTcyTpY/Ae71k99TGRsmBHcMQFLkjPBZKN/0+eRQIpANw5NsPRfPFFXnw5sTs9bi4u
         6H/VekbzdEYEIccGRTPZtTeDOqpQfgQUmOMVzJy7jGDJkBan+3ge1mRDiNo5zRCj5OKP
         s1vnYHvzXKUkC1X/90+glYyv/jl+WynQCbUi1z59qruqCUHGEtj9u0isRFjFWYF7QcPH
         tu1+nwIm8fFTFN0iYvRDi3C6uEHIARXIIC/8cJSmfjHnvlVC8bI02ugfpn3icgFG/li6
         Gg1xsrlers2ngs3nv+A3/jK/BAH5UxANjVuKZZYRE9rvlGhT0QtOp7z2ilO/+is1wNCC
         iVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rLOup0GOEqhoaMMZhAdevax8ZIbsgxqeUb1VEioLBZc=;
        b=YuCsPnvFvwofpxila26/AizHPLPc579Wu3mcgJh4vpU4l03TizuUSWPmuzCv++AU0C
         4Bxu7S++Sa+nnMN9gYKKSo8HSRkO9Pj+5NIok7euf+zkggh/yYDu+S2Xsvj0KfbRP4bu
         Gbuw1ba9QfD/frND/kCjBdNFkLW6gFrWlEUjiBjIQW6+YPCwXpsUPSAKwkMA6D/7rjyg
         YghwOYT4/dtm6BMUIJzPXZPpGWYIBbUyfXlgOvSZO1hvqc8Rl9wHdv2V7HqXIHLFLPor
         L//elPEJ6/GfxtCMgUvAzT0znl1F0DWQYqvvUP20JcHMpv0+6K2zn+gT8z2DRTPFBqxI
         aj+Q==
X-Gm-Message-State: AOAM530Nvh3nGV/xyoG1d9PconUz1k0DU6axcjx/F+nyTsFlow6YpuaJ
        K5ymyijK9xDT1FPSO0PywW1SG/sKtPdKC5rJN30=
X-Google-Smtp-Source: ABdhPJxlaJX+AnG1PKHgIZfPsq8WdQ++t3ceIPPrT3cna/egCXmxEEEIB9l47AD1rDMvUcwPtSYgcyDFLCDezeFXAO0=
X-Received: by 2002:a05:6512:1322:b0:44b:75d:ac8 with SMTP id
 x34-20020a056512132200b0044b075d0ac8mr6558009lfu.213.1649269813965; Wed, 06
 Apr 2022 11:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220405053559.1072115-1-alexhenrie24@gmail.com>
 <20220406180434.4zlb2bwpu6cfumta@tb-raspi4> <CAPMMpohYRTSaTcRVTJ6y=Q7+FSOcSNjHjwDvUMhVv4JO7QDB_g@mail.gmail.com>
In-Reply-To: <CAPMMpohYRTSaTcRVTJ6y=Q7+FSOcSNjHjwDvUMhVv4JO7QDB_g@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 6 Apr 2022 12:30:02 -0600
Message-ID: <CAMMLpeRw2SMaPhesXn7Q5CGq2Kmk=eJrPBnFBnJex8-OvfSz5w@mail.gmail.com>
Subject: Re: [PATCH v2] convert: clarify line ending conversion warning
To:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 6, 2022 at 12:18 PM Tao Klerks <tao@klerks.biz> wrote:
>
> On Wed, Apr 6, 2022 at 8:04 PM Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>
> > May be we can use "updates" instead of "touches" ?
> >
> > "In '%s', CRLF will be replaced by LF the next time Git updates it"
>
> Makes sense to me.

I don't like this wording as much because "update" could more easily
be taken to mean something that happens in the index or in a commit,
not in the working directory. But maybe it needs more clarification
anyway, e.g. "In the working copy of '%s'..."

=C3=86var, would the phrase "In the working copy" resolve your concern
about the new message "[not offering] the working directory advice at
all"?

> > Or may be
> >
> > "In '%s', CRLF will be replaced by LF the next time a `git checkout` up=
dates it"
> >
>
> I believe we should stay away from the word "checkout" because it's
> neither accurate nor clear, for at least a couple of reasons:
> 1. We have long, in principle, been promoting the use of "git switch",
> and it's not obvious in a message like this one that this is
> considered to be equivalent.
> 2. Files can be touched/updated by other commands/processes, like "git
> pull" (and "rebase", and probably others I can't think of)

I agree: Talking about the `git checkout` command is too specific.

-Alex
