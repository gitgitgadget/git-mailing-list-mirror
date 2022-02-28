Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06733C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiB1SYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiB1SYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:24:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAFF9D4F0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:02:30 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id bd1so11383912plb.13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tg9rb6KI2ERAPGTSFtxBpDCi435MrFN5uMyFF5GTCE=;
        b=gFXcethkQ5pEoOJfBxT/Mljw+yz4w4PfI8HlPloUrNlrXAUU0/MdhrscC36ZpfyNc6
         gWT3l9uw6Hss+2HZd23DeyA7Bd3pHeOKsopXEJdDLwQbbF2ciooelzQ5FkUmxHJGmBPg
         gLyR2EyoZhuI6lZHb7TZswgkJJg78vT1/0Z8LhmyjAEVUQYBLQgWxvVRgAFEAW+iUQds
         L8t/LKZzzhbMRJk8Jboxsy47bX+gi18H2vaKTCkF9UBs5NiOHBTfwOf4nT4Aoo/I2qEy
         9nPVOef938WHPLccVE2G3Ao6ejPVzkYTpnuhNTsc1DEmsIwzvdvN9lpstNCv/VqNZrc6
         jMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tg9rb6KI2ERAPGTSFtxBpDCi435MrFN5uMyFF5GTCE=;
        b=B2Q3tjvg53PVhNvFNAtQFcxdJqDluoOLPzcJvw4q0wipDDVwEt20NxV5LpYuoHblD3
         ZziuKso79Wgyeeoby2zK5nCgaJZDR0rlDsqplmDxcnHglOIgggf7u4yYOZ0Su5ZjrW2K
         ZYhgQsr3uNa2ywA8D0BNSM9mUbA32oKm509bxiZdzX4D9eTPKyF2nZDLDFDcZi0ky68A
         JLacWJcObQ00poE8GxDMt6Gl5Uly/07jxNGLFUEwdfhhDp9qMHI0+zqYkuERAV/sVDTv
         SjWj9lHYbj+oIAIiCBFpoYn57OTjh7HQl0TagRWPXb0Ns7Kvcg26W147hFmyjDHDxslo
         unHg==
X-Gm-Message-State: AOAM5302UVgA/7SJvhLnWKwz/KLHd0bvUpg2QvGi+EhYrch9Yyk8OzMT
        B09IZW9TdYUGO+VbJTDG6ubjZsB2yfhVFImObww=
X-Google-Smtp-Source: ABdhPJyOUN+YY0HTIuFxYvJSpZvt8ANTy2wYIDUHuWLC8ZFjSyLX/v1FdYrMBc3wDm6UbkLF1+w8JAY7WVeACqESSUo=
X-Received: by 2002:a17:902:ed83:b0:14f:c969:7669 with SMTP id
 e3-20020a170902ed8300b0014fc9697669mr22092142plj.96.1646071348136; Mon, 28
 Feb 2022 10:02:28 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local> <742c7455-8f74-ac03-350a-7c3851f2b792@gmail.com>
 <CAP8UFD1bEjg20Twn0pjVqxmgCU7Nhzkg16O2t6gacSsqCYfXng@mail.gmail.com>
In-Reply-To: <CAP8UFD1bEjg20Twn0pjVqxmgCU7Nhzkg16O2t6gacSsqCYfXng@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date:   Mon, 28 Feb 2022 23:32:16 +0530
Message-ID: <CA+ARAtrwt-Ov=b13s2g8AGuATS8fNfk_ohNQPscSjAs3n0y=0w@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Mon, Feb 28, 2022 at 4:33 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Feb 26, 2022 at 9:30 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>
> > Thanks for adding the ideas to the SoC-2022-Ideas[1] list! I noticed that
> > you're the only one mentioned as mentor for the idea there. It's usually
> > good to have at least 2 mentors per project. Is anyone else interested
> > in co-mentoring with Taylor for the idea?
>
> If no one else wants to co-mentor with Taylor, I am happy with it.

If it's fine, I would be willing to co-mentor with Taylor. In case
there are other
potential mentors who are willing to volunteer, do chime in :-)

-- 
Sivaraam
