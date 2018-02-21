Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9070E1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeBUXpu (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:45:50 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:52059 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUXpt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:45:49 -0500
Received: by mail-it0-f52.google.com with SMTP id o9so4190868itc.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HWEBv3oIW2JoWVz41I2/DqpXD0rOMK6baq3Bh7uLqe4=;
        b=e0P91zgqKPCEYak/UdmuVUaHGFb0H1G8UTLkckMH1DA9HSoTRufpYXk0Ewy6ILfuEL
         kOfYLcTtu1Zf/BdA8I4HUbNX5pLYfTPLZQGmi9rZSnIn0dBLijzds82pOg/Cvtkjix+m
         PHEfSIGs7jGkQd9lCwdXnp97OOtsoJf4IPJwePGdEig+mtvZdHG5rtM0rMTWe8h37Ia0
         e/JtojriY6D4THcn7epwn4nuRJnnuXj0FeUf+SQ7YmgzMm5a0C2K09eAqLsa4zRy8r/2
         +fCylHZdbaD7eNy783ArLedzv7LqaMZepuQ13kfwwdYTMYNpv8kWKGyuDJ1BE5puT0R8
         AllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HWEBv3oIW2JoWVz41I2/DqpXD0rOMK6baq3Bh7uLqe4=;
        b=tkzwFJ/5IHosNksdfmaqiUawAc9bGyBWzvBCkXljncC1FLsNlJ5WWGfmJiqknje4ju
         Y0J3hGy/nZCFVej5Mk6YBMxbUq7ICZp+haXyy8zfdAe52PVrdGc2dndncambXRT46UH/
         yiSHmOoFXCjuZiiI1L8X+WDKZ8cjXmYwpd04UiKZLu9HyzADuiEkGl7jdSv3g7FFX+gn
         F+dZ7SGjhZr+dFStvJMmbqpne/ajEpfbIE++cZEHlDOxr5tnRe5drY0qXeNDgqAI6R7V
         RKTQD/t+sbAJmhDsLK6RILOlD0s+dZDfDCOwPtatuKRdCxv4t1tjoutySc95YEUNiOcT
         IOdw==
X-Gm-Message-State: APf1xPASr672/PkHa/6fsb0HwK3OsAXZoXkuRZ+XnffNK2MMWDrD9V9J
        s4sDBRFED+/B2HqpaFnYLQtz0T6OoKzEEx/DV48=
X-Google-Smtp-Source: AH8x225MhqfPM7UnyVrDZ7FHuWNfJbKklG2fK0ADWQmpH3eQTvDi+eflF8VYZ883rGjetdZB4imy/FtdRkqroxIm41U=
X-Received: by 10.36.150.134 with SMTP id z128mr5807716itd.108.1519256748499;
 Wed, 21 Feb 2018 15:45:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.135.221 with HTTP; Wed, 21 Feb 2018 15:45:48 -0800 (PST)
In-Reply-To: <20180221232724.GD7944@sigill.intra.peff.net>
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
 <20180220225726.GA17496@sigill.intra.peff.net> <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
 <20180221184811.GD4333@sigill.intra.peff.net> <xmqqtvuax9te.fsf@gitster-ct.c.googlers.com>
 <20180221225002.GB7944@sigill.intra.peff.net> <xmqqinaqx7wp.fsf@gitster-ct.c.googlers.com>
 <20180221232724.GD7944@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Feb 2018 15:45:48 -0800
X-Google-Sender-Auth: nxyPnngLWybWay2P7Rn0sN8_K8Y
Message-ID: <CA+55aFxLU+KVs0s43chYpiw0NhFb=t8QsxotcJSWVrNcx7Z=NQ@mail.gmail.com>
Subject: Re: [PATCH] revision: drop --show-all option
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 3:27 PM, Jeff King <peff@peff.net> wrote:
>
> We'll skip the usual deprecation period because this was
> explicitly a debugging aid that was never documented.

Ack. I don't think I've used it since, and probably nobody else ever used it.

              Linus
