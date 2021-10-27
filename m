Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF32C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE4560EB4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhJ0TUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbhJ0TUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:20:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FAFC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:17:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l186so3905024pge.7
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8PWs0OSvGZsHDgiVR5iduQARY0hUpttP8D/m1O7ShM=;
        b=Au41IxtK8G90yvEToQHVmtbgtQGNqh2x3nh+CVWsoq58Ina7SWo1QyKpsXuGruNdaF
         VgIpnWkykn3EY6yf4aY33sxsSShK/MvCLcU9T8bCRDDkIYmWInsBzHJO49aYRatS+97K
         Gz06n1hxIqolqNIKgY+n7Shg2jQKVIotLPYyTO4rmENLFJ+b2UtF6l9Yb+jaT5Jo1iue
         I+HSCopLJPfO2cGa2DYU12gWbuPS+giVsHx+F0y7QMwWx7/NdW3Z2L6XG832ztOrCw6J
         ueDf8nLhs0FHmxirGqELqaWQoiEAClmF4ZyjTvLh95jzG1jS+fbRJMEUUTD9JA3KTf+3
         HTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8PWs0OSvGZsHDgiVR5iduQARY0hUpttP8D/m1O7ShM=;
        b=sX7UUhcvHwmEP0emq+B7BkOiPJiYqEDCouI3a5Y0TgndoeEuT4mjuX5/gQ/N58L6GE
         appBrlFhnDFDAyT6RkLsCZz4XT0rpba99gV1uEAdlhpQFd6n2Mazv32GPMXfqpT62GoX
         olcVhcYi4Mk/SIfm4eub+2CsEjNV1suJBeksJXffZfwgzpd99mOYuWMbsT76DZcEKFoR
         CX09olmQ0fKmJhT9mOyr64k0gZs4sEEDG24y+2pjszT4vSgy3R40rDFhp1g3+whfVeM0
         f6HAuoGZAFAA4eT6YrYA00Q6Q44a2sfWDdYDYkB8tswkflGUJ/Vkg0ErpwnkfuEDXbDx
         SgxQ==
X-Gm-Message-State: AOAM531H5V+i0FRgWklQlFof/8IIHiPT9sH+vnVl3GHi1qyImGC+Nb5A
        95fn1ZK8VOCuOCifdO0XSCBQ/54XUVN/6i1BcTQ=
X-Google-Smtp-Source: ABdhPJw4bgalGq/b8T6JlKZ1SWfSCiSX+pXEwJ3DByQuyMNDDg8TiYRUlPRbjftbJuvscnwdkZjJtRjgyGCoOInIMIs=
X-Received: by 2002:a63:348d:: with SMTP id b135mr15447644pga.87.1635362276571;
 Wed, 27 Oct 2021 12:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5ytkzbt7.fsf@gitster.g>
In-Reply-To: <xmqq5ytkzbt7.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 27 Oct 2021 21:17:43 +0200
Message-ID: <CAN0heSoxxCR2S8uFuF_bGk8667=RP2=B+SeEDn2XoJanCtehxA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Oct 2021 at 09:00, Junio C Hamano <gitster@pobox.com> wrote:
> * ma/doc-git-version (2021-10-25) 1 commit
>   (merged to 'next' on 2021-10-25 at 9f74afec0c)
>  + git.txt: fix typo
>
>  Typofix.
>
>  Will merge to 'master'.

I notice you didn't pick up [1] which was posted as part of the same
mini-series as this one. Maybe you intended to place it on
ab/unbundle-progress and got distracted. Or if you don't agree with the
patch, that's also fine. :-) Just checking.

[1] https://lore.kernel.org/git/7defb11c1c295550105a47bfdd9f030e0ef7c636.1635093692.git.martin.agren@gmail.com/

Martin
