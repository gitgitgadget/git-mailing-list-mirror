Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF20DC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443333AbiDVCdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443342AbiDVCdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:33:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF18AE60
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:30:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f17so8771921edt.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIwpgls3vCYkQbwjT6bYSoNYerBkkfxHQ33Ql78I7I4=;
        b=Udfp1GthLd8kYuX9cjGR9yC8esQ5cI2Ptd3U+1y779QyJFHZiy9K0Tz21enqmfhTqC
         qVJ+Kn+aVtiQ+ORFgkpmO+wb1xVNne6ZzHOaIjlWXQNRo8yCdCP4+FKGfjyjrxabdolu
         kGrpXXCerMCMQl8Rwrx7tPwTYah6izPZf1Aym6cjJie9ir4sLupGTN2Q+F/Md/dfVNhb
         7hxeY6gJR5d/gVMJ6zTDecmBRUPBTHrKU8OcP82+yeX43qyof9DcG1rOU+elvmbZ3uWz
         GWgoZ/LozbzNesQEbzJ0Wq25j/AKl92D4P0RVq/j2174OaO2L4aGUlqBL0xt8rsLZyfr
         IOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIwpgls3vCYkQbwjT6bYSoNYerBkkfxHQ33Ql78I7I4=;
        b=jFY5CLYErdj0Iha/cVz6jE2dis//ftIOXP2U9EgXZ+5PY+pr+jKmSFXHO69O0Nacvx
         9+FwpoT5fFTPoc6YjpLMSOMMWt1B6IXIGLywJC8SlzT4uBwx+2RpgiRZgl/agurATUpH
         f5PBRXs+2b+v5VZ4dA0hHmd0htwB2myWci3zZh44gyV/6J3qglh/U21QbUy9cLu7x1D0
         E9i2qNQc97xCSV5wfnmL7Q4twKZMWwo4J+8clMkyzX1oZXgitimavxjdnBPDKu2zcs+O
         BrSR3+Bpzi1J6WQ/gOnN4jKmddX9Dl/PPbuCUexIMpsCZlg61deGoYbR2q2rNm74rYst
         cPNw==
X-Gm-Message-State: AOAM532MMv+F4tHeV0TIfxU6SuNWgci7Y+9pbkQ/4Kz2YyNc6hCX8JQq
        Q71A+jnAnegrAWu1IhHydqkdYBVoZSJz+ecMj+s=
X-Google-Smtp-Source: ABdhPJyQ9b8AixgGkLyVlztKs3nqQWHdAgYDWQo+OsAUD5fVEU3R4dHPm93/EsZIxEjRK8N5j1CnXu0eSRaXIVchhEU=
X-Received: by 2002:a05:6402:50d0:b0:423:f4a1:597d with SMTP id
 h16-20020a05640250d000b00423f4a1597dmr2551931edb.228.1650594613844; Thu, 21
 Apr 2022 19:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com> <7333198b7785ff4ab6d424b3384c9e4d264e96b2.1647054681.git.gitgitgadget@gmail.com>
 <xmqqsfrkp83y.fsf@gitster.g>
In-Reply-To: <xmqqsfrkp83y.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Apr 2022 19:30:02 -0700
Message-ID: <CABPp-BGaVvUBadGWn5rCgjO8tP9OVmjD0WvYw2dR36Brf=Rbmw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] git-sparse-checkout.txt: shuffle some sections and
 mark as internal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 14, 2022 at 1:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -CONE PATTERN SET
> > -----------------
> > +INTERNALS -- CONE PATTERN SET
> > +-----------------------------
>
> Ah, this is why I was confused during my review of an earlier step,
> where it refered to this (and the other) sections as "sections on
> 'pattern set'", because I was reading the end-result of applying the
> whole series.
>
> With this change, shouldn't the reference be updated?

Makes sense; will do.
