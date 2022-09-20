Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D0FC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 15:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiITPJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiITPJt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 11:09:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575D11809
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:09:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y3so6976649ejc.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Z5t/1tdRNVdKl49mxozf+T1tFs69b0hkL/gxOTfg3m4=;
        b=mgUW9tSuOyg3Dx9iqD0VeT3plLTzHDKeRh9S5cttAVl6WuE52FJJOhqVlfrfvyiBhT
         R4ZX6IVh555CDldotF3gL2mHi+D9586zt6HAxdi5jSMP8hG05qc4cEWVJUG0JnjT9v6Y
         +CzzhOXO5oqQMoRDRvZHOEF9m+bqI7YfvhSyIvBZi7MjfZrK1JRZYwSOq/+YtxfaWM+j
         H+hhH47IvbGEEf41TBSIfUF86GsbeQ+iWGzL2GMnCPoipgefkNyIMnODv4pWt/EpDFwm
         KauydUCYLkhhpdn4DO8Gr8qL1/2gs+WqdpNF+PH85Km1vvZZopkYwcXh6Wgy/nNFFmDt
         /zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Z5t/1tdRNVdKl49mxozf+T1tFs69b0hkL/gxOTfg3m4=;
        b=cz3j01+aJY+d5U13tfB202nkvBWa/VxF3F792H1e5rIDDOc84lDOTevKcEtTDReGrF
         JbBmYRRfDyDbrdhvIAiDfD3H1GFBHztH3a/ZF1htPdz18jf6rDcPbqZZ7HjrAx7f5yik
         M+cEDewvhcJQDJHUOo7LS7yPNeEwD9fJoxLmlX/DkyFEbcoHyTMVqR/KlMn4EHsvGj4s
         TdVOUl8DDaYs71hUvM9jg8O6QnkgwarRQQcUTAhcs7WH4i2MPzJWPEL2Ydaxnpog5PwB
         Uq5oXNNIFtn3dXsJuCOYAoEmOHDwj/tygOXqMJpbyZb9xBzkqms7v2u7sXNzd3nsUY/6
         f7dA==
X-Gm-Message-State: ACrzQf0Xt0FUpv6RJjPbg5iJK+4D9qg0a43XbxD2z+rKJDnXVlvmEQ1j
        btGOQ8FxHV2WigEwykisHcaH5i4atujrLv7qx4g=
X-Google-Smtp-Source: AMsMyM7Wm+XKWZUZgvYRk9pSIURyU3HCFpBzCIB11jPvYnS2tOjh/jPdcnoztjJaou3Z5Kly9uGihGk7UCQq87p3zUg=
X-Received: by 2002:a17:906:eecb:b0:73c:5c85:142b with SMTP id
 wu11-20020a170906eecb00b0073c5c85142bmr17362292ejb.433.1663686586652; Tue, 20
 Sep 2022 08:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <38ec2360f4fbfe65fa2d9f1e9cfb7d4944d1714f.1663609659.git.gitgitgadget@gmail.com>
 <b727c25c-469f-ca56-bbd6-82f82c762523@github.com> <xmqqr10781lx.fsf@gitster.g>
 <990f84f9-fdd9-0d0a-4fc0-d0dbd19ee5a9@github.com>
In-Reply-To: <990f84f9-fdd9-0d0a-4fc0-d0dbd19ee5a9@github.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 20 Sep 2022 20:39:34 +0530
Message-ID: <CAPOJW5yeg-+5F-Tabdt2PbmBg=qebF-7F38rFaGKJ7zROrSRqQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] roaring.[ch]: apply Git specific changes to the
 roaring API
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 5:49 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 9/19/2022 6:02 PM, Junio C Hamano wrote:
> > Derrick Stolee <derrickstolee@github.com> writes:
> >
> >>>  int32_t array_container_write(const array_container_t *container, char *buf);
> >>> +
> >>> +int array_container_network_write(const array_container_t *container,
> >>> +                             int (*write_fn) (void *, const void *, size_t),
> >>> +                             void *data);
> >>
> >> Should we make write_fn a defined type? I'm not sure I've seen this
> >> implicit type within a function declaration before.
> >
> > Unless we can point out why having a named type is a good idea
> > (e.g. we add such a function pointer as a member of a struct, or we
> > keep a variable of that type somewhere), I actually would prefer to
> > do without them.
> >
> > Perhaps there are some more important reasons I am missing why we
> > often come up with explicit types for callback function pointers in
> > many parts of our API, but if there aren't, my preference actually
> > is to lose them, not add more of them.
> >
> > Hmph.... could "a typedef can become a place to give definitive
> > documentation for the class of callback functions" be a good reason
> > why we would want one?  I dunno.
> >
> > In the posted patch, readers cannot tell what kind of three
> > parameters they are supposed to give to write_fn().
>
> This is exactly my reasoning. Having a clear definition gives us an
> opportunity to document what each parameter is for, even if it is
> just a variable name.

Agreed.

> This anonymous type is used in multiple places, so it can be helpful
> to know that the type is connected across call sites or a stack of
> method calls.
>
> In the unlikely event that we needed to modify this callback
> signature, changing it in one place makes it clear that we cover
> all connected uses instead of tracking all of these anonymous
> functions across multiple methods.

Got it. Thanks!
