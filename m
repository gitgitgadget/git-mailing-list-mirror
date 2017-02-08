Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285081FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 12:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbdBHMfj (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 07:35:39 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:35611 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754286AbdBHMfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 07:35:09 -0500
Received: by mail-ot0-f172.google.com with SMTP id 65so111451953otq.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 04:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BbbckVfTnVqKkNSCMlxXG/0a9FQ8KryHjibvvpte93A=;
        b=QLw1ZN2WBkMPKAEjJWGRpWU3GWx0ghibD/jwL3/WlXSrsUJgVekUM0sqs26u7Gcohk
         QlwGkHbtr6Om7z0nKs4HIEbnSMF8YLLjmsZhuvNaUswwvTwcc6X2SWjmeQzczPUiRxXP
         p7o4G2J+uzdEp1ZiJdsJKNKf35fP13Mz2zrQajEfow7fIr9OD5ThgQDJnmhUVdwqMFbs
         dqnAGHng17CLmbEbYMhhPf1+CdzS9tCoXvsVzxw+C+5+xtAtVdxTPJe3mvak9U5uHaHo
         aVqpVjwm3PWMG/9KAVuwS292yvQtT1qfTIXRrmNwDUO5cpRvML11uXXEEKP0LAInXuEe
         EeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BbbckVfTnVqKkNSCMlxXG/0a9FQ8KryHjibvvpte93A=;
        b=RSv/uxI4uX8iXGQcHGtoDhOIrzQaU6YKQbmRKkO/+LLrwzv9M7cXEwYeQD4WsTFpnt
         6ICjojxVYZXuuKabQb9Fvmh5Kwnxqep/6ENp+Sif7mTps7FMjrpQ72GYsKReiexXJ+7M
         Sq7NeaAO2XMuHR0BXoHOwoixY2foWI5EnRQly71T5BRZkZx7e4+G+OfXFhmWzUYH0em5
         HlNwKoF6Y9+XmbwdLF0nXJ5CtFchph9vBKAgrdEWrJkPvSOVPtRGupks7EZYRR+rml47
         ymlRTpF/+qcPuSW7e7V3gBCXzjqmBQsagBdlYZ/AtuStQYzhD+UrmNj6a8V08zb3VILv
         XtRg==
X-Gm-Message-State: AMke39kmBLOWrZa55bl1+nYiB8g1iGzz9nFv3KNe6FBYT13oP6zX6NkHJsRfd50CUSOeNyljyqri1O59MxcSKA==
X-Received: by 10.157.46.57 with SMTP id q54mr12503915otb.28.1486556923824;
 Wed, 08 Feb 2017 04:28:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Wed, 8 Feb 2017 04:28:13 -0800 (PST)
In-Reply-To: <cover.1486556262.git.johannes.schindelin@gmx.de>
References: <cover.1486556262.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 Feb 2017 19:28:13 +0700
Message-ID: <CACsJy8AmjkPbwRAykQM+aQosVwSamGwKpHox7FTPr6H7MgZQ7g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Demonstrate a critical worktree/gc bug
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 7:17 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> ... and a half-working workaround for the auto-gc case.
>
> This patch series really is just another attempt to prod Duy into fixing
> this instead of dabbling with shiny new toys ;-)

FYI work is ongoing [1] [2]. If you want it even faster, go do it yourself.

[1] https://github.com/pclouds/git/commits/prune-in-worktrees-2
[2] https://public-inbox.org/git/20170208113144.8201-1-pclouds@gmail.com/
-- 
Duy
