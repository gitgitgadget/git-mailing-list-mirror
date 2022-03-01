Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C11C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiCAISO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiCAIRs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 03:17:48 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E485669
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 00:17:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p14so29774981ejf.11
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 00:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i9zYCzjq7o7QLO7rCw85Hq3awRioi/mdciwLn+OFR0=;
        b=6xPJivyAqhAFdmT1WohR32EgMJy7WW/rRF/sVWniFiJj+RCb4QeiG+Eg0MeFThmqcm
         F9wOPNPaZirxUMV69AIgNyCqHEMVul0FbxI21J3To+/OFbVDAKxnmIljs8+Cr6QDdXyI
         +p1W4bYLIYWOBaCcjleWTxCT+3qslkBf2TxtgRAGk1Ngy++iYEM4266n/JkfP/c+38+P
         770URqSfR9EMz5BapYiRAa5yHAptsxWMkxoWIGGB7KBK83auVnRLBJ/FybtwWDsIdTGN
         DkC5j1ZtXiZjCOIK/6b4kKsutGnpcRFqT5vSdNIwC52vqamORwrYfMJ6MAc+RDt+oIjb
         o9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i9zYCzjq7o7QLO7rCw85Hq3awRioi/mdciwLn+OFR0=;
        b=3/L5wIjy7zUcYW0d2QegHGMzJ68KG6M/WThzrFarAiWMq9gFOHv2kbqBGq1g7HCm6+
         uyHyXbk1z4wj88qKw02+mPFVRcXJNCGTzQn/enJgcqcdWsS7JWxpuF/hNwUUIQNybL85
         pqVk03zuNfwCoihDx7578NI4SHhwlWV+KwHiC4SPqmSo4H1mXJ2oJnFhpE4q8GTwPP4P
         +7BpAUxq/KYURTs6PQsD8VsJ0YmvXFevDIdxG0P8uDXffeg8IKbEZFKhmYc6GdUgf/K8
         vA16F29SRex8FDgYojKFxdLybfEMKLg7vtSJY1wHT4GpBGEDGyjd9op5YWZA7buJwlnf
         Zz7w==
X-Gm-Message-State: AOAM5311YYuordGiIJfCIp4vPX2Rv0X2LSTJbk+lZADfr+ZDOp8q4Nyo
        zUOkUzB86e58fRXLaQyHVl7P/yQMQvTif38aQ90EA5KTP57TxFl8
X-Google-Smtp-Source: ABdhPJxKptPBZxmMMgBwaxNdpZOCd4xCpg1ILQ55pbP1ixudChLId03hCnDGq2v9wXWTPS0P6ghydwgL0ldwffgUBQY=
X-Received: by 2002:a17:906:a210:b0:6d5:9fa:11ce with SMTP id
 r16-20020a170906a21000b006d509fa11cemr18557212ejy.172.1646122625009; Tue, 01
 Mar 2022 00:17:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
 <76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com>
 <b5fb21f5-4aa6-fa36-a8f6-abf82b543c1d@jeffhostetler.com>
In-Reply-To: <b5fb21f5-4aa6-fa36-a8f6-abf82b543c1d@jeffhostetler.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 09:16:52 +0100
Message-ID: <CAPMMpoiQw0UhnH0WP_opB0iQn8cRx8qT_Cy_W8PnHpxbwATw2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] t/helper/test-chmtime: update mingw to support
 chmtime on directories
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 4:27 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
>
> On 2/28/22 4:40 AM, Tao Klerks via GitGitGadget wrote:

> > +     HANDLE osfilehandle;
>
> I'd be more comfortable initializing this variable to
> INVALID_HANDLE_VALUE.
>

Makes sense, thanks. (but less relevant after switch to CreateFileW)

> > +             fh = 0;
>
> and here initializing fh = -1.

Makes sense, thanks. (but overshadowed by switch to CreateFileW)

> > +             osfilehandle = CreateFileW(wfilename,
> > +                                        0x100 /*FILE_WRITE_ATTRIBUTES*/,
> > +                                        0 /*FileShare.None*/,
>
> Is there a reason that you're not using the #define's here?
> I assume you ran into a header file problem or something, but
> there are other symbols used nearby, so I'm not sure.

I couldn't find these, and am a complete C APIs n00b - I have no idea
whether or how to add them. I figured commenting on their meaning
is the simplest safest thing to do locally?

> > +     if (fh)
> > +             close(fh);
> > +     else if (osfilehandle)
> > +             CloseHandle(osfilehandle);
>
> And then this becomes:
>
>         if (fh != -1)
>                 close(fh)
>         else if (osfilehandle != INVALID_HANDLE_VALUE)
>                 Closehandle(osfilehandle);
>
> Which I think makes it more clear that we'll properly close the handle.

Perfect, thx.

>
> >
> >   revert_attrs:
> >       if (attrs != INVALID_FILE_ATTRIBUTES &&
> >
>
> An alternative solution would be to replace the _wopen() with
> a call to CreateFileW() without the backup flag for non-directories
> and just convert the whole routine to use HANDLE's rather fd's.
>

I was at first scared of making changes to things I don't fully
understand, but looking at the existing use of GetFileAttributesW
I don't think that makes much sense. This is cleaner/simpler
even if it is a bigger change, and consistent with other things.
