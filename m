Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C571F42D
	for <e@80x24.org>; Thu, 26 Apr 2018 01:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDZBsO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 21:48:14 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34040 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDZBsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 21:48:13 -0400
Received: by mail-wr0-f172.google.com with SMTP id p18-v6so35869273wrm.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 18:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8w58zV6f8EpvsP1uQ/NCa6oO3oXkbNonHFj7a9/XT0k=;
        b=lGo7M+kmrG8mWY6ooCrF/NSYij383734mtZlFFvX5NTknhdcEdXC5WBmXWvfqcRH6g
         RsYfVfEmgryYiTQv84d/uNjNutksiD2xPXWHuDWTztdDO5pBtn3yO41QbP9bg7RvsqmI
         9It9OiVb65SKc48Mwq1bMELqF2qMb9rlfrG9ypHAPaob0B964bNyQJgo78+/vO6iWFof
         jyNEQG2if5hbkHxee+72qWZcH2KWnXvSUeeLceeE2jeHL+10h7tF81vL74mOrdUIDNdT
         StiLIEaXvIin4sJ+lzcsiiwP0XSR+HuxSPP36U/iScz21WYRLo8obO9oAJiGizuMr1qk
         7EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8w58zV6f8EpvsP1uQ/NCa6oO3oXkbNonHFj7a9/XT0k=;
        b=jk0oYEULZELOG9oCo9srgXetq/pPzS+wk/Fn3Xl8Snt3lINSTrMkZ7jvFnKzXPiPe2
         CUzWKxZjn7ncxgjIyvGcbDDzSyN758fyb3v/s+2vF/7pXq9DPg8RN/BlpdnThwjkh6uP
         YaEwHgDLvQWxGE5qOkiDMtdW+adl5DGc5NEAsUqXolQQds8XQ6efu7jRI0MiUsYDAwlw
         agZ+IpDTII8yY7FwzLnhy7cs5ytgkHB/KIM/fV7boPtc3Z7nEtCsXtIiinYaSisc8qS/
         6XmDHFKLNdFIgHSeLZn1XumcBpdrGpu8hghG57epAwir49tQXfuq1yezWdiTBd7pfoqP
         FCPg==
X-Gm-Message-State: ALQs6tDjDwd3XiUi3Csq7VDJEwSzWwA6cJcs/5XHKifS6YIZuGrkDVb8
        i3LUBi7/k1BNXWbpJKHIqJI=
X-Google-Smtp-Source: AB8JxZonPTJ0gyAsmmHsZsng7EZb/8rVkh8dlwJxdf6cBAjiXHRQNKhuasS2t1ciPJmzMMcPJGf6pg==
X-Received: by 2002:adf:e445:: with SMTP id t5-v6mr3951196wrm.130.1524707291672;
        Wed, 25 Apr 2018 18:48:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w69-v6sm17845972wrb.94.2018.04.25.18.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 18:48:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "newren\@gmail.com" <newren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass\@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v2 0/2] add additional config settings for merge
References: <20180420133632.17580-1-benpeart@microsoft.com>
        <20180424171124.12064-1-benpeart@microsoft.com>
        <xmqqd0yo5ejb.fsf@gitster-ct.c.googlers.com>
        <365838dc-d988-b72c-ef29-20369a7f54a2@gmail.com>
Date:   Thu, 26 Apr 2018 10:48:10 +0900
In-Reply-To: <365838dc-d988-b72c-ef29-20369a7f54a2@gmail.com> (Ben Peart's
        message of "Wed, 25 Apr 2018 11:22:33 -0400")
Message-ID: <xmqqa7tq4u1x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> To be clear, this documentation change isn't trying to document any
> changes to the code or behavior - it is just an attempt to clarify
> what the existing behavior is.

Yeah, I know, and I do think the new text is a good first step in
the right direction; I merely was trying to help in the clarifying
effort ;-)

