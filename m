Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9BC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJLQEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLQEA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:04:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46AD9954
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:03:58 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h15so6321728qtu.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jUAnf6hQGnKD5eckyTjXPY0W7uyx4XDEoWj+uh64ONA=;
        b=ManmmG+GhCZr6Gxfso74Vn0fIzJ3+ZIVMzhsfITk+O65J5afK38FhBMGxAvvqR/cwh
         qtf3NurC/j1AlMxAROXnH78CgC81MuPJa+8rg1Lle/QAhwjdlAh3F8zYB66SY7MOhmn/
         uTLRo090/YqYXS7Lq4UdPpM3LfhZDkw3zIrus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUAnf6hQGnKD5eckyTjXPY0W7uyx4XDEoWj+uh64ONA=;
        b=o8gSDa8AS+emO84SdURQmIqJS70uZ+iyzUCDYKG0g8uZApzp8traYVQLaBawHyuFT9
         0cb990Qll+yvIWFuwx2Jei+zWmPQoCpqxr0G790NJjQ/kvpcm6ZjYyxHTPneoD2lcR4T
         XowuguWeqmy8lSMzDLUE1u7AHUeh4TqzPA6d27/e7IoEYyEVnN443UY0S4dCKNJzOgj0
         EDjMMr78XpL/aDpQTd866hJ1lrlqQgN7eDjVLwvoE7ZMDvXL8AjfK6nVSRYjS5Fpirj/
         pHJppQJ25qhO+C2h41Dtf+LHjWVExG5M5520+O9MqJben4GF5FaPDlFfHjQ8hOiqLV1g
         WWiQ==
X-Gm-Message-State: ACrzQf3+xBPC896PrHD6BeZ5aLCQkYtA1MVDBZUm8U2Q0lGIiMTUbZav
        TM4rFnEzLCbFxlbhGPYdCw+whuKqs9yywVvSWFnyJyuaO86DfA==
X-Google-Smtp-Source: AMsMyM4NXtcrV/Ce6Ag2qA7ZsrMKKyUk2H+z+m5jWpt7rG5UlodMpe+Sdk3BSx7sUB/efW1do6lJrocImctBZKXSiR4=
X-Received: by 2002:a05:622a:1911:b0:35d:20c7:6226 with SMTP id
 w17-20020a05622a191100b0035d20c76226mr24102536qtc.619.1665590637891; Wed, 12
 Oct 2022 09:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogZd_em4_Fdk0sNFqAXqH19VOVyw3WsNT2LHsQNOb0_rw@mail.gmail.com>
 <xmqqpmg4lbnd.fsf@gitster.g> <CAPMMpoj9ww18j4gUKhXsLFUGrYsbuq6Aww4z9VDboA3h78eHsw@mail.gmail.com>
 <xmqqmtb8jsej.fsf@gitster.g>
In-Reply-To: <xmqqmtb8jsej.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 12 Oct 2022 18:03:47 +0200
Message-ID: <CAPMMpojtZDiJcTgQDrnXuOvDrR2RB30BdyhNZB4MmryO0RxJ=g@mail.gmail.com>
Subject: Re: git mergetool, merge.tool, merge.guitool and DISPLAY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2022 at 8:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I wonder if we can think of a new config knob as giving the default
> value for the --gui option that is a tristate <false, auto, true>.
> When the knob is not set, it default to 'false', which is the
> current behaviour.  The default most likely to be the most sensible
> would be 'auto' which is "see the environment to guess if use of GUI
> is appropriate".
>

I just submitted an RFC patch along those lines. I have a few
"niggles" I'd like feedback on, but in general I'm happy with it.
