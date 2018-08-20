Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C845B1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeHTWX5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 18:23:57 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38338 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeHTWX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 18:23:56 -0400
Received: by mail-yb0-f195.google.com with SMTP id c1-v6so3356205ybq.5
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQljymknR1mlFCpdwYYxysH71ajjw4YTZIXuCNmGtjo=;
        b=C+sS4qQ9Mvbc2xwBcot+JxRxQHYxqiOBwxZLDsbxCgjDer57Ch1fbPgw2AyHRjh+wa
         SJFgOYshjqs213YN+bmhCh/ePttbfdlNG3Da28av5qDgw8ZSH4wxtvnvKVvYY0Jez+qS
         GynL4V8rmyxTEKaSZoNZF3HgW6KwontGbhdhQcf//ndwsAOK13Eyi/Wgr0t8i1dELlMd
         wJgzjczffFj4wk92zsx+RSyhOo1f5tl5O/FFYCkADfO3c9MKl0AhJNjuznwH5rdLmR7t
         tVj3UKfPU0qzZX4tZVTDxSqcVvlBILTbSjycBJfHxDq7yjGxUZP8cknx3lSWJl2m9YI/
         yMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQljymknR1mlFCpdwYYxysH71ajjw4YTZIXuCNmGtjo=;
        b=LnL5Hk0Hk6NyJ7I5GkrXGwaFmakuXSWGm7rgDKNsdNr4rLEdPb/8YNt9Y7gTCnmtZl
         v5oy0OZf0d+8q+C3akug9+8gdUxHT5ocPRFToRz/Ie5ZDwfavp1JHoP01xqFLWc8c8aJ
         2IDC2/N1menBj6uRxpsJK/HD1jRWPHv8haqAYxIedtsiBmdFuElzlBGwUBMqh5huis/S
         UbJEeghFO/RNK5VYoj4HjGoAO+xRx5HNlB6vOXzdV7nHNq3FiXetK2WMSLD7ShkicwRE
         qUyZbcknOeRj8uSmQK4n1VMXrLPX3W1G7WamZ6MDNyjrapqDo5vTnAxXqb3L46XpEed8
         cHsw==
X-Gm-Message-State: AOUpUlHNEnPwf1UqoUv45tun8teENaQC5d5PfUeU+f02N+/8Pi713Pzb
        e2CbqAbIU1uARJe2v85ngaFVtruHnBDfP9wl+pd9cg==
X-Google-Smtp-Source: AA+uWPz0PidhK5iG/2c3C1V2jrijtc2KcsInblEKxDfA3d/dnXW6guTxAI4vplt5BLE5B1m0eoReDLR9vYbPO+YyrcI=
X-Received: by 2002:a25:842:: with SMTP id 63-v6mr26586097ybi.425.1534792027276;
 Mon, 20 Aug 2018 12:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.11.git.gitgitgadget@gmail.com> <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 12:06:56 -0700
Message-ID: <CAGZ79kaAAo+=nrcipfd4kp2iHXFPdo_zNxv8mEgQkN3JbTwicg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Clarify commit-graph and grafts/replace/shallow incompatibilities
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 11:24 AM Derrick Stolee <dstolee@microsoft.com> wrote:
> Because of the change of base, it is hard to provide a side-by-side diff
> from v1.

I thought that was the whole point of range-diff. ;-)

I'll take a look.

Thanks,
Stefan
