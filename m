Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C2D1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 20:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeBWUbH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 15:31:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54078 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeBWUbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 15:31:02 -0500
Received: by mail-wm0-f65.google.com with SMTP id t74so6896584wme.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 12:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BC3Cac5KVWikr4cGPnEa2cNJaH44ehqewCINNiwTBTo=;
        b=OcT7Nw27Mim+8jDC93siKpUubkNwu++f8uz2oRdXLJHmnSe+3tJ48UZsC7m61Ra2LU
         yCAIbaF1oSNtG+lQVMSV9qDxEmnXt0GIW+akz/1aRAMEd05CuEhCKRmF5WgU5fnsVlP1
         ABU0DAI8adMDwyC15TVutq5AozR6PRyIwVd9RwE+VYjZmu58vYU5gtxJWpRwRudNeQwV
         0qGMuTk9wWatdMyTs9VnkG+28TO7Bv/6wnmDYMV24DbL/Cfsw9H51bqP/zrm5ogjyY3K
         Hi/N04GJweH+LoZ5ZIMP+fEpprC4m4RFP1tFj+WYLCcRy1O4En7gfQrjy/Bi2IIVmpVM
         wZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BC3Cac5KVWikr4cGPnEa2cNJaH44ehqewCINNiwTBTo=;
        b=VW78Oi4EYKmY/GxIGnmKPC1eGkhsLiJSD1xyV+TyhYPt+cFfW342bWN1HB8CaVCeHu
         B4odbQa0xS0FZBiAb9BcVm8BJBonCiexQgWlPfGmWV46RpjEMBo1NtIPD3DTrdNaCd+N
         J8PVQloqepb15Sgz4PRPFXdGuCUUtTXswB9u4N29fCLu2iobWRARCky5w4P9AWJayk2H
         mXIG0OqRxUQ/UJ48a4fNkogD5t9CxC1auvdR+9kiLhTT8lPBrso10nlokOLMRZj/RZld
         9y8qIu/wpAr2FMqGDyQfKu+By9tgBtiayImhJNd9nkSWQP1wMtM2PrEcGo1jOmktno1B
         K4qA==
X-Gm-Message-State: APf1xPB5d9YSfnDMk6EgAvWF4VvBTMciFq3IFW+XHJRUFxoFJAXrC0sG
        60iti+CruL0rBY+NeUpIWM0=
X-Google-Smtp-Source: AG47ELtkMGg3NpTWZc+zeJtkSCkwxQkmUf7dRn2r66MQ+saexNZeI142QebTR3J84H4uDjbgylQgIA==
X-Received: by 10.28.125.197 with SMTP id y188mr2609862wmc.150.1519417861355;
        Fri, 23 Feb 2018 12:31:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t191sm171004wmt.35.2018.02.23.12.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 12:31:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julius Musseau <julius@mergebase.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: git squash
References: <CAA7Zk=tMMPE_Ov6cSJuzgYwWmTuMTSd_909c5JY3a2k5KFzHgQ@mail.gmail.com>
        <xmqqfu5sutrc.fsf@gitster-ct.c.googlers.com>
        <CAA7Zk=smFOZ5+ThOZ9bfr8+UB_tD1371Oiy501sR=J4xjKdhsQ@mail.gmail.com>
Date:   Fri, 23 Feb 2018 12:31:00 -0800
In-Reply-To: <CAA7Zk=smFOZ5+ThOZ9bfr8+UB_tD1371Oiy501sR=J4xjKdhsQ@mail.gmail.com>
        (Julius Musseau's message of "Fri, 23 Feb 2018 09:03:30 -0800")
Message-ID: <xmqq371rtpmj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julius Musseau <julius@mergebase.com> writes:

> I'm embarrassed to realise your approach matches the top-voted
> stack-overflow answer on the subject:
> https://stackoverflow.com/a/5201642

I personally do not visit stack-overflow, but I am happy to see that
there are people who remember "right" way to do this among the folks
who do.

"reset --soft" was invented exactly for this use case, and you can
use it even with dirty working tree and dirty index (they are left
intact).
