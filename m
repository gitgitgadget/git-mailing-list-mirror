Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC0EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 06:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjF3GJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 02:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjF3GJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 02:09:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59303591
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 23:09:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69ff54321so23517611fa.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 23:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688105360; x=1690697360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N61+SbBmVfoRDLmfL5PPazomsAXOUPv9ICApr2bb5QM=;
        b=F2Rb9YJhZTZwdyqKuKz6GOeUGW2uY3qtuU0DkHf+2Ox5aes1nhwMj8pJPxhD5YdULf
         9ReQOl3JuV/tioAA7dcGd9RiEabFXY6HfGP9A0ehugu19paQpJZWxxt2ZUKRjC8M/a90
         DifrLaXP/+jo+opa1Vk8I1n5i2IRZV3IwbUezomcfd0uiu+1xTsJLlxVvs44nJFQKEKV
         Vs8jXuJPPerEN+hlnkvi7EzInLyFD/2viaLs4l0ktxda1gY7PVXEglUnzsNr9hFovZ3l
         mmVCAZ2WJ2OTkJ2nfAvP5FintB2bvp46fDCjUCLu85Jvx859rfmDwLB4IRj/9AlaDa7K
         QR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688105360; x=1690697360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N61+SbBmVfoRDLmfL5PPazomsAXOUPv9ICApr2bb5QM=;
        b=Wf/mElpBzFcvhEyexUiC8WdMlpWaE8VsDim/HLetiOrcmvnA/OcgXHckQSNrOBXdBD
         ZkfEKRCyKDHWAGmmvR/9jIctDtbhKzBMIKMyf15tdde3IgjI6uZByhYCq8iXgSoUX3Kz
         q9o8SCT7ZUvYl2UyD17nA36abVnQKItwpcvdrUZ0l2/QfZV/w5Kam3jct7LUKonyF6pc
         IVVaHt90jccLL2ADt2kE85GbosGnOsNUJJatOWvNz1+83GuU+tXtiexXmGmiR1vRdg8k
         VpEU6gG/FRPsMr9tRvgOIXMIjHrEtKP+UMxY202gqRPhBzx0IeiekCAzKwY+fO/8o6nB
         gcFQ==
X-Gm-Message-State: ABy/qLZEziwRnBjGXo8XJekKZnr2zeqgOs+DECsS6jZ+mfU0hd5LQvYv
        +j6iRv0M6aEnO5OAulZZJwvqc7/m40v9/BZWC0e+1E2D
X-Google-Smtp-Source: APBJJlEc1kfBxPOi/uu9ncaDz+/ezQnbLmC+gcERITK6iMG6YuD9y8grGdyRk9s/0UVrvgdmyErmXbUyhnqbL9di2Ew=
X-Received: by 2002:a2e:9bd6:0:b0:2b5:95a8:4126 with SMTP id
 w22-20020a2e9bd6000000b002b595a84126mr1171072ljj.52.1688105359601; Thu, 29
 Jun 2023 23:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230629185238.58961-1-vinayakdev.sci@gmail.com> <xmqqjzvm7z13.fsf@gitster.g>
In-Reply-To: <xmqqjzvm7z13.fsf@gitster.g>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Fri, 30 Jun 2023 11:39:08 +0530
Message-ID: <CADE8NapyQJU1rDPvyMcRXcJfz3kzzg_fYXSSEvYJ7dFO+UHGaQ@mail.gmail.com>
Subject: Re: [PATCH] docs: include "trace.h" in MyFirstObjectWalk.txt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, nasamuffin@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Jun 2023 at 02:43, Junio C Hamano <gitster@pobox.com> wrote:
>

Hi, thanks for replying!

> All of the above may be good currently, but as soon as somebody does
> another round of header shuffling, we risk a very similar breakage.
> It is a good time to think about ways to avoid that, while the pain
> is fresh in our mind.
>
> One "cop out" thing we can do to limit the damage may be to loosen
> the text in the "NOTE:", so that it does *NOT* mention exact header
> files the API functions appear and let the readers learn from the
> source themselves, with "git grep" helping their way.  Or tone down
> "defined in X" somehow to hint that these details may change.

That is a good suggestion, but wouldn't the same argument apply to
including trace.h itself? It makes it necessary for the code to work
that any API changes must involve changing the included headers.
Either way, I would be happy to fix my mistake. Should I send out a V2?

> More effective things that would involve higher implementation cost
> (but will reduce maintenance cost) would be to actually make sure
> that those who update the API will notice that they are breaking
> these samples when they develop their series.
>
> In https://lore.kernel.org/git/xmqq1qhu9ifp.fsf@gitster.g/, I've
> floated some strawman ideas but people may be able to invent better
> ways.

I do want to be a part of the discussion and the solution, so if I am
able to find a reasonable way(or to implement a solution), I would
inform everyone for sure.

Thanks a lot!
Vinayak
