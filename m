Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B1C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AB62313C
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbhAFW0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbhAFW0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 17:26:12 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC85C061757
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 14:25:32 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x15so4810775ilq.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 14:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsHdOTDdCr7grXucsv6oufVeNZjaVktfWUx7YcXNkPQ=;
        b=A0i+CjIkhh+NCxTw7UkY3RBYUR4VON05SAcDSKNnzr68xVd+oUD47hkoVj0u2ftz2z
         aBRAx7VpZl6z4/OFPfl/DhDiGTbgzWUyA1Uzwoi2E0HmTU930xQsNkVpbvTfbTnXXfoD
         JVbamtTVRcbvvz2cM2wv0RWOkYILkZO2xfcjgde/K94qxnOysgN1QbUjj1xKb/DFXiFs
         bSM5RqmSlfPZ5oVPm1ug0gZwpFY4MDA/l25RjEn75kaRiAymuBYM9pxZwBbVpdqn5aYG
         1HP/3T5akv2QtHkbW28F/z5HgahfP41yPIzewaWprmFNedbrkRL0YphNAlzKiVB43E4j
         jeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsHdOTDdCr7grXucsv6oufVeNZjaVktfWUx7YcXNkPQ=;
        b=JDLpGls+4vrhE/mUHEjzdSUE/9xjdto1Ai8TMHY+u+DKGopMOMCBnYWf2e+7U/Sd/t
         s7PQ9AAPw9Hl+gU4IbcNSHR/cW6M69xPaWoftI1PW20UNzcN1mbDdInXvobp/y655JMt
         yTHia0aerO0WseEtIvyRai1GyKdxAb6fxLHIVwxJWekrC7ldae8Ea9dCzdxs2lePKcJW
         8mHHuqt0EmbZfo7x3ghkgAmackUIzAfcoCFWALiRqFfpJxKTyrK49MxvWm6lc9xEwpdz
         rnfxmKQHoz7uAIowE2QRq71b+HDv2opWF93/mKxW9rXN/Ezvq+/3hfPkIlNmyHKW/5QT
         Fz2g==
X-Gm-Message-State: AOAM530wXCJmAac9gc8T+CAuYR0i81PdNP6DC+6dMTPI/gF9uswDZtJH
        Jir5nX8juMLn4Xvs396nePi5TPvDk2IaiU2Pl4Q=
X-Google-Smtp-Source: ABdhPJxoGKJabm89zAv2BD2OYVYrR8TJSn5ym1NX94prj0YVqrovphERXK087yxfoO7IBLanWTKhwvHSB7ddRX46/5M=
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr6368129ili.141.1609971931746;
 Wed, 06 Jan 2021 14:25:31 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
 <xmqq1rexrbz1.fsf@gitster.c.googlers.com> <CAEE75_0e4_m_7hQXycVK1f=4LOb82U2DYveAvcF2XKKNgmfpNw@mail.gmail.com>
 <xmqqr1mxpv8n.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1mxpv8n.fsf@gitster.c.googlers.com>
From:   Jim Hill <gjthill@gmail.com>
Date:   Wed, 6 Jan 2021 14:25:20 -0800
Message-ID: <CAEE75_1o+A13+8SBeF9S0SN0ZaYhgK3D1bhbfWNWZWsj9jOXrw@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 2:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> not a good example to support the use of the "--orphan" option.

I agree with that part, slathering infrastructure and abstractions on
oneliners (okay, twoliners) is suspect in my book. worktree add,
symoblic ref (really, no need to get lowlevel there, checkout --orphan
does it) done. Tag an empty commit and the sequence gets closer
to a legit oneliner

    git worktree add foo empty; git -C foo checkout --orphan newbranch
