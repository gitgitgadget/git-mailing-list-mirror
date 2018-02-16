Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF511F404
	for <e@80x24.org>; Fri, 16 Feb 2018 12:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967845AbeBPMzZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 07:55:25 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36955 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967661AbeBPMzX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 07:55:23 -0500
Received: by mail-io0-f193.google.com with SMTP id t126so4022327iof.4
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FRZhJTMV+zrAOrk91dbztJuo/NSvxnpxhAIZE4IgzU8=;
        b=jJHkEbmTjyJTpWXQnEAGUH574gU3T3N+bLTG2z9R58/KXMQ+LgkNdN3WI9oE0U7r1m
         G9BIydQGxKz1AxPgj847d5QHLHDql8JB/3JXLe9Y3Uub3nnILU1W85S4+s509t+AAFMP
         L77Qmuunylm9iDQ5eb4YMoSHPWyTs/n01t5nO4HCAuxWNBfiLJBepg3aXIsyHJ2iyspx
         6R4Y+2BX8UxHpzq0uC7ysGaRIOF+SEsSL8ASk5ojn7ATx8sdElLaWzSLfaAdaC/vS2J6
         P2l0QHYXP2mWlLFNbV6fvvZTi8Ae9JX7Fb39Bu38WDFckNPUS3NxHgeVdoXGm4rFTFb0
         I0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FRZhJTMV+zrAOrk91dbztJuo/NSvxnpxhAIZE4IgzU8=;
        b=Iu7w0PilipjMnnhR+xtrxpDOL6SwPTjVpFKIJRjFzpr6MBu81IE90orOyiN0oUj1VI
         JJlO9un3Sw56HkJ/OHuQew5lCYsD/VTrF4+XCB8uR+6r1nYvklD618mMEBX64cCtJzmw
         0fGaXntkVLDZdd5c1MvLzmzTws6/AeWx3qg3wCxKxqDVka9/VNATkRK8CujRGfYPwJ1g
         /sI9zn3ceibrOR3UFSLxK74AeaGQvZPYYBtbg0YWIDuttIkRP9MqSzQaKr/v62LngnsO
         rCLMwfCSYKsQYh48GbbokVAH8vRj9CjzbdXkNYcOfsKx/kM/bz5dsY5ao+pBjt6IC5pS
         obTw==
X-Gm-Message-State: APf1xPAZIT3isC46GWeU31/SnhMxFvGP0b7vCbalpzqRvs+/tFkub5g9
        /AYeV8pw2WqxXycU1tdhbQw8yvMAlT9Ut0UqYKE=
X-Google-Smtp-Source: AH8x224yInpCKgU4jNlnEgykOJ/ikGqSJQjZo2tgCOKXRNyn9zdX/I/dpIEieveUfztrOqBc5V4XWqe3aQyol3Jh980=
X-Received: by 10.107.178.206 with SMTP id b197mr8560414iof.9.1518785723161;
 Fri, 16 Feb 2018 04:55:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.47.11 with HTTP; Fri, 16 Feb 2018 04:55:02 -0800 (PST)
In-Reply-To: <20180215152711.158-2-lars.schneider@autodesk.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com> <20180215152711.158-2-lars.schneider@autodesk.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 16 Feb 2018 13:55:02 +0100
Message-ID: <CACBZZX7mh6TpbaKUYQkCgL0j0waO4=RhR55GuawrzLSBnqDmXA@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
To:     lars.schneider@autodesk.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 4:27 PM,  <lars.schneider@autodesk.com> wrote:
> Since 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22) we
> allocate the buffer for the lower case string with xmallocz(). This
> already ensures a NUL at the end of the allocated buffer.
>
> Remove the unnecessary assignment.
> [...]
>         for (i = 0; i < len; i++)
>                 result[i] = tolower(string[i]);
> -       result[i] = '\0';
>         return result;
>  }

I agree with this approach, but it's worth noting for other reviewers
that there's been some disagreement here on-list (between Eric & I)
about whether these sorts of patterns should be removed or kept
(although the calloc() case is slightly different from mallocz()),
see: https://public-inbox.org/git/871shum182.fsf@evledraar.gmail.com/
