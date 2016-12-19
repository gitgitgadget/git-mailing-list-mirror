Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347871FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbcLSXdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:33:19 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36765 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932155AbcLSXdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:33:18 -0500
Received: by mail-qk0-f181.google.com with SMTP id n21so26789987qka.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I5aIv+XEOCg3r5Y3b78MEVULsObWj9HnqYgHtIs7zk4=;
        b=kg63xkUaUdED0G5Yg9FAfT0wvNTc/1UBlHPMSDL7tFusq0yRNTfXmQgq2690M3OLLO
         DamPUYmJqxsR/IUDnGs6s0zT5zYCowDdgJx04BbtxIjx9C3ptDN4ZJRWm17jjd6ooqdf
         BorrmXNf+wEujwp+tp5ua47n4oPV8iaB/bRlcQsmQXTal1QbXm0FOV9eNLJm1aloKMts
         0ct1BEgr2YBwInWLjAEvQlbcEYQPADPGBCqP+/YlKQW/QPD2eFhmhlcjK0j5urHZUWTp
         jWpyHGAr9j/SM0S2BTST07TB4AvlhYGFVgwnrhMWoIPAT3JVk4IPHI5Zmkc4/URvK61M
         HgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I5aIv+XEOCg3r5Y3b78MEVULsObWj9HnqYgHtIs7zk4=;
        b=ZWAdroxbU4TNp++C4XB/xXV+IUELgxEqu/eT7ND8VGXGJlae+mHAAcexGgK6dS/VP2
         6JhialpdPvX2QYb4+H4s4VIpzPxNZngUggKrArFGGCd0sj7aySdbnnF8bY5EUolZUYeA
         d2ifUCFsQSkpFrbP4tggc8IUhjmZmlEhmSk7BDt9Hy9Qvd6AvFoZgpVTI7sIL+NwwozQ
         ruAhPXutL/6MeHbctyuecDe/OSBlvUvfa9K7Eb0Wz7eFP92TvWKyUMJxEANOJ5+ZWSr5
         xe3PhD4bFiw8lpeXW97KQvKUZYMcPjgSx6RiX2KWvXzj4QGPqo/BvnzJ9390lFVI82eo
         +Y4Q==
X-Gm-Message-State: AIkVDXLkj/34noPynI6v604VyLeovuE3O15AKjxyuRzPk/rczB6k0D7Dxk0BTXEC9w++VKRT7RatseRS8B5EBOg5
X-Received: by 10.55.53.147 with SMTP id c141mr2689755qka.255.1482190397704;
 Mon, 19 Dec 2016 15:33:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 15:33:17 -0800 (PST)
In-Reply-To: <xmqqfuljod70.fsf@gitster.mtv.corp.google.com>
References: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
 <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com>
 <CAFAcib9-rUSqyBRpauw3pTf9OPTKLYNf7bdh2gyykBNtJTZKGg@mail.gmail.com>
 <CAGZ79ka=RzAjrb=7u7p5xnveo=kcNCoGn=TC=0j-CBp8Oby7OA@mail.gmail.com>
 <xmqqk2avodi1.fsf@gitster.mtv.corp.google.com> <xmqqfuljod70.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 15:33:17 -0800
Message-ID: <CAGZ79kZxxEOXgRv5KJ-mj5Djzx1KbaWr1TGuXeH542EOA5-JWg@mail.gmail.com>
Subject: Re: Bug report: $program_name in error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Bleecher Snyder <josharian@gmail.com>, vascomalmeida@sapo.pt,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 12:50 PM, Junio C Hamano <gitster@pobox.com> wrote:

>
> -- >8 --
> Subject: rebase -i: fix mistaken i18n
>
> f2d17068fd ("i18n: rebase-interactive: mark comments of squash for
> translation", 2016-06-17) attempted to apply sh-i18n and failed to
> use $(eval_gettext "string with \$variable interpolation").
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks sensible.
Thanks,
Stefan

>         else
> -               commit_message HEAD > "$fixup_msg" || die "$(gettext "Cannot write \$fixup_msg")"
> +               commit_message HEAD >"$fixup_msg" ||
> +               die "$(eval_gettext "Cannot write \$fixup_msg")"
>                 count=2
