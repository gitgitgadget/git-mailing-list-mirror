Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D9C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 05:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75FA61263
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 05:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhKQF6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 00:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhKQF6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 00:58:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F06DC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 21:55:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x7so1481041pjn.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 21:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yaxAHCMqHly5BiYc3xI2OkJrOnjz1syQLhC9tfPAS4Q=;
        b=NoyFhhFKNXR2B6u2ODDBQJYuKOc10OcRHoIR7JL1RRFSkNl8rtEKgcLjcU/ZS4KJd4
         1LoWYAdIApaiIOPKn1zGZG8OgsZOJ1K01rRvWftcRi+2ikOAXGiXDtHFUA1CXbrHpVWi
         WRVMfa4PwIAmS63iN6+wDnf+4tNsj2XXMKzyoiSmTXYn3tQPuSsedInaeo8MPj1ONp7x
         CSj1kVreR/xS8bWsJwcfvf3QsWBmOIAOiM3SkALq59rZlTgpJP59rBsJcnWZ0ea/ldcy
         GrWx84P/ICfXIS83vdLxQ8jUsz/iGKAk5ML2VOIpjapTOdDeOFYFo8U32dR3ox1vS3Bx
         jIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaxAHCMqHly5BiYc3xI2OkJrOnjz1syQLhC9tfPAS4Q=;
        b=a5Mk2GNcfm5Jr1cuq5A9R/kxh79bPnji2sJoN68flnEch5w2rHLHOnY0JPt4nePw63
         rLgJuS1YiDiXeDlauHcbEL6v2qDoUgtqckSSLkrGuP1bB01w85Tcy8lqXUpiOVEmoGkP
         SBYSzcgp/9QTjFqwuNYHwjZr7QH/8w2/AhPezy64gZDEiCJ4ehs4dUw2JMCP5m/RbE3S
         sNeEPwAYfaFbdsFMB+OwCkfAPNGAbc/FYAiXkOm6fR1zXAYHD4hAqSyJcEolntmlKY88
         mlbRC09CM5naBZ81aQNpYhcrY/uUAEmvrAazBTQeV62J5r/x3o2KptuDdTFHxUZwxzx0
         acEA==
X-Gm-Message-State: AOAM530TRq9gQJUcGEonlxyz7AqrHai8tNR8kwT1hXWcSUwvjJ5ADZQr
        tCsb71G+b6b6en3rT4POyva8VNTc7A+Xv/AvlPM=
X-Google-Smtp-Source: ABdhPJwQK6SHAaYX509U3oQGcLFH8isWB3SDC0wEqdSuDM2yZH7Rs2b8HSH8MVCjyO0a3+tTWvEHQtchcDQcebVpiFo=
X-Received: by 2002:a17:90a:974a:: with SMTP id i10mr6226169pjw.117.1637128521024;
 Tue, 16 Nov 2021 21:55:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1078.v5.git.git.1633521772731.gitgitgadget@gmail.com>
 <pull.1078.v6.git.git.1633523057369.gitgitgadget@gmail.com>
 <xmqqwnmopqqk.fsf@gitster.g> <CAA4dvxgNJ8eyuc5B6_GnSLHMWjdbJN5k_rTCLjWndEyjv_vOnw@mail.gmail.com>
 <xmqqy25o9bie.fsf@gitster.g>
In-Reply-To: <xmqqy25o9bie.fsf@gitster.g>
From:   Mugdha Pattnaik <mugdhapattnaik@gmail.com>
Date:   Wed, 17 Nov 2021 11:25:06 +0530
Message-ID: <CAA4dvxixLKAQeLTUnLFvnwrAzQg2w0zqH7gCUqYLXjf=SAP-wA@mail.gmail.com>
Subject: Re: [PATCH v6] submodule: absorb git dir instead of dying on deinit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 12:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Mugdha Pattnaik <mugdhapattnaik@gmail.com> writes:
>
> >> OK.  That sounds like an improvement, albeit possibly an overly
> >> cautious one, as a casual "deinit" user will get an error as before
> >> without "--force", which may or may not be a good thing.  Requiring
> >> "--force" means it is safer by default by not changing the on-disk
> >> data.  But requiring "--force" also means we end up training users
> >> to say "--force" when it shouldn't have to be.
> >> ...
> >> Does "git submodule" currently reject a "deinit" request due to some
> >> _other_ conditions or safety concerns and require the "--force"
> >> option to continue?  Requiring the "--force" option to resolve ".git
> >> is a directory, and the user wants to make it absorbed" means that
> >> the user will be _forced_ to bypass these _other_ safety valves only
> >> to save the submodule repository from destruction when running
> >> "deinit", which may not be a good trade-off between the safety
> >> requirements of these _other_ conditions, if exists, and the one we
> >> are dealing with.
> >
> > This is definitely a situation we want to avoid. How about we try to run
> > a check for uncommitted local modifications first?
>
> I am not sure if I follow.  If we stop (ab)using "--force" for the
> situation (i.e. where today's "deinit" would die because .git needs
> to be absorbed first), then the user would not have to say "--force"
> which may override other safety valve.  You'd check if .git needs to
> be absorbed, make it absorbed as needed while reporting the fact
> that you did so, and then let the existing "deinit" code to take
> over.  If there are other safety checks that needs "--force" to be
> overridden, that is handled (presumably) correctly by the existing
> code, no?  So other than "do we need absorbing, and if so do it for
> the user" check, I do not think you'd need to add any new "we try to
> run a check for ..." at all.

Yes, I understand why "--force" should not be used. The reason why I
suggested the check for local modifications is because I thought we
should warn users that they have local modifications before we absorb
the gitdir. But I see now that this is okay, considering deinit would
die in such a situation anyway, and users would not lose their work.
The only side-effect of running deinit despite users having local
modifications, would be that the gitdir of the submodule has been
absorbed and that should be okay.

-- 
Mugdha
