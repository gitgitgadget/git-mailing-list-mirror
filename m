Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DA9C64ED6
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 12:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCAMqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 07:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCAMqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 07:46:45 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C9A3D93D
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 04:46:44 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x199so164457ybg.5
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 04:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfacHbhDQrcelaJn/LZ+otdaN+tHBO4S7R/j3EDB7FQ=;
        b=V/k1HGmxC8u3IM8PPCdmbXYfTA78VQgbDMBFFrFtsrSMixIqR92s8E5/wd4iloRR6l
         aqTpz0Lx7kwWOjYeZCGyTt1+ZkhzfJxz8sb6WY1BlyFQ8J1sCue7EDoNl+3ZT+J9AbLq
         L5mpGVuKeEYBsIzlHaeSBGX4NdUUAaLZhWKxEyxp357m/DVqVaAT4VAFoZ6BB/Ie3X/V
         1RLQnBxY334MD7Cqcz5Rv98a8aqE9SyYg7KlwyZyH1U7FhStGNDC3OLUMlxJMbWJuhli
         +/L0RwD0dWCkotsO/Ju4Ozyu2hhevEtLIEKT2M872MVfe7is4zO32ydWBO98PDTmCGl8
         jbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfacHbhDQrcelaJn/LZ+otdaN+tHBO4S7R/j3EDB7FQ=;
        b=WrYwrn8OOdW+5E4zS7wGVfor6PYtecxonZ8t6H6O/GyR2U21aPWdJQ/8SHmeoq0dG7
         KH22wbe7EzlZKkvkClzArjzyVQ9fx0ZINhzYiU8mx+Aw1RyFwjp6+NlaPDj/Uwjh/z2m
         cyHiObA9cHQEoEi4BO/NNoZDPefEvXz+Yrv9Wm7vuUteNJY8tiMOkbwi2i1pftgwjct9
         GhMwDNB1wWIllKQrOvVHeDp+IjJ0pPLYrRQejHqfKhLbPw3EfIWyUai1owy4SfiJ0VHe
         ECSS6V/gEMjBxYyL2tMIZqotA3zZovf7otDcjnAdr+HNMw0hqyB89X1a5yshTgnWZmmH
         0uIQ==
X-Gm-Message-State: AO0yUKUUFP0J/KpYBpQmN08FiQQz7leh8lxtKIhbqVMU7JXLkJy+S93v
        SykVRr9oMlegdxmcATDAQ+PGB1LEhqJEhgFxjWjEtmwR
X-Google-Smtp-Source: AK7set9RpPBsXD7ysDywH+JDo6gJ7kT2p1d6IWMHiG0Npw9g2OGLmmZQnnbcvA622Ga6Gm9sNMiYm/XzeKOhKl66pQE=
X-Received: by 2002:a25:9f0a:0:b0:a36:3875:564a with SMTP id
 n10-20020a259f0a000000b00a363875564amr3295272ybq.2.1677674803886; Wed, 01 Mar
 2023 04:46:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMP44s1_Oy8GzoALnvQMJEVRkDB3EBmn4drTyY6T+9BatRpjUA@mail.gmail.com> <CAMMLpeRCKMqVNYvL9i0HGTEKvaACaEyCWCotzKfo-OQW2y_BpQ@mail.gmail.com>
In-Reply-To: <CAMMLpeRCKMqVNYvL9i0HGTEKvaACaEyCWCotzKfo-OQW2y_BpQ@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 1 Mar 2023 06:46:32 -0600
Message-ID: <CAMP44s3XS=43ZWF6MaLHvhf_VMuJKog8T46tHsmypu-xcMAw-Q@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2023 at 2:04=E2=80=AFPM Alex Henrie <alexhenrie24@gmail.com=
> wrote:

> I think everybody agrees that the current situation is kind of a mess.
> For better or for worse, there was no consensus to get away from the
> current set of config options and introduce something more
> straightforward, so we keep making incremental evolutionary changes
> within the current framework.

Yes, but my proposed incremental evolutionary changes would have
solved the problems by now if the maintainer club bothered to look at
them.

Instead, they implemented a solution from one of their club, which in
my opinion is an incremental change that made the situation *worse*,
not better.

This issue with pull.rebase=3Dmerges is one that I had *already*
explained to them, and they ignored it. And it's not the only one.

When you ignore the opinions of certain kinds of people, and only
listen to certain kinds of people, you end up with worse code.

Cheers.

--=20
Felipe Contreras
