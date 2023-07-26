Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E751C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 17:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjGZRT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjGZRTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 13:19:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D085F2707
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:19:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bbbc4ae328so40015ad.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690391960; x=1690996760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUCZVCxIp88kbZJeh0IAgRn9PfxQRRWo2aovxAHgNxA=;
        b=6XcAPAZgTXnaEBKC8vmds9I3jAgrNYDQzXgZK511E6A2DgX5bcedhaiQl1FoxqSxNx
         qYd+1Aee3+CsEVPjjF3MP0JcjlZ0tX7AOjDTDFaiH+E9xQcgfDyD8C6ttGS53UZ6lxN1
         WbAUaITd7XwRPLTsOQR4YVSTOW39bADIupU6n96mBc7RlCgjq53vkYy1E8qBbTfgpKRQ
         AYL8SVejJZJBMi9C+bTX7MzSO4DuWNYvg6UqXOE9ad7gmMZeMCrn1KcRAfDhlUUQi+r9
         I3pIKAyjsILIPK+0v7dDa1k9/e7RFa6jQjfVCM2wXkM2a/NGOa2lJlV/Vd6XDn/rxM+h
         jtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690391960; x=1690996760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUCZVCxIp88kbZJeh0IAgRn9PfxQRRWo2aovxAHgNxA=;
        b=A7zyj3ah1R7JlQjxxikyDOCA+xhxh3btI4lbVWV5NHS8UX68rptljDe6/kjWh9pFWx
         1ffK5g9a51fR8Jr9+OQCpch+hTzy+dGj1Ej88QfA2eyaFjFKZbdeHNhunZhvNrbumQRo
         V95vt0cUvwncgDA3pLrfDBkMkXxF2uTja34xyIhmcAM8q4qJ8e/Gou/7wCHmGtIof1Bk
         F+pOxix2/TlUUNizcA6C17ZzNEWYzQDkqFaDP0oIJvjNi5ajMQWh8nekosH5BDmdpjdp
         WSkGtuZKaogwl52XbIpNzS545QepIUDLkYI7jiC+eSGE6hmCkx3TH/V1DAkxcBzwcmk5
         mkbw==
X-Gm-Message-State: ABy/qLYR1YmF3aE5XtN/nCiKfT9jl2CAW0ZxrZCI69+rgeSL2JXOZ66h
        Vf2I0EQn3j6VxLCksZbJdH5w8Nx6B98=
X-Google-Smtp-Source: APBJJlEdBoIvKrjDcyrqRKvqLN6WzKqU9P9bvKQJp3hbWEXJVNGP1VZAUsYV/orkvwHg4XGOKXO7ciDAZcc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:c951:b0:1ba:1704:89d1 with SMTP id
 i17-20020a170902c95100b001ba170489d1mr13052pla.10.1690391960028; Wed, 26 Jul
 2023 10:19:20 -0700 (PDT)
Date:   Wed, 26 Jul 2023 10:19:18 -0700
In-Reply-To: <xmqqpm4ffe3m.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
 <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com> <xmqqpm4ffe3m.fsf@gitster.g>
Message-ID: <owlypm4efv55.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 0/5] SubmittingPatches: clarify which branch to use
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Well, both of us forgot that the previous round has already been in
> 'next' for quite a while.
>
> So, I've split the difference between the previous round and the
> result of applying this round into two patches, and then added a bit
> of fix-ups on top. ...

Sorry about that (but also, I didn't know any better). So I guess the
guidance is:

    Sometimes, you may want to work on a topic (typically your own)
    which has already been in `next` for quite a while. Perhaps you had
    an unplanned break of a couple weeks, or some other circumstance. In
    such cases, consider sending out patches that build on top of the
    latest patch series round instead of directly modifying (locally
    rebasing) the patches for a new series. This way, your new changes
    will be easier to apply to `next` as is, without rebuilding `next`
    all over again.

Would you prefer to include this guidance in the docs as well, or is it
sufficiently rare enough that we shouldn't include it?
