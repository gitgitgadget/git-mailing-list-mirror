Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1A31F42D
	for <e@80x24.org>; Wed, 23 May 2018 23:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935032AbeEWXiy (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 19:38:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32884 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935015AbeEWXix (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 19:38:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12-v6so24246439wmc.0
        for <git@vger.kernel.org>; Wed, 23 May 2018 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7EB15WProdpTGNmk3rx1VwQHSAh4rHxTOuHKRer1UL8=;
        b=uHFoMAM0h3hsVAd1F7tpWm0NIzX0eW6V2GuPOnfL1nM/qUYzud19YolF8dLyEpDUXi
         8VmYBZGqXxpfdpMRm5duar9qNTvYR13Dx85altrMl8V8xG1AE8HnGDxKOE2b7KuyVARy
         eh7omxvRuxybDDgsQyxm7XL6+9N21uf3pk9qD5uZ1+a8fhff3sTEKWF449jdmZTa2NHO
         s6xbBDyK5i4XVMnDK0jmWPO+w1SLRhjQWVtU1Abs+eDxpvEmFkcaqLX4IwJPQswy0oiP
         GBjWPItZoqIhBHrHmfxGT3xNPns+df0RGjUTeVhyxxsI7zbyY+79yCq23hAgaCKMSOs0
         tTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7EB15WProdpTGNmk3rx1VwQHSAh4rHxTOuHKRer1UL8=;
        b=qTVqEarDVT2FfHPCWxQlA7s8XaeV47WjxJghnwOzWfRAkucKl8424MPiuNNlOHyZ/e
         wEEaHZ8sVElKsJV4XeqOLbOLl6Sj5q2/u2qq/1UQEEoJZ1vFmLm/bIVPOEhV6TFzAKhB
         eFgisEHxFYwY4r73jqN1aVDSnSy9PwSNYEmRv5e2jcQdtgYTzl5fsHD0aaPyUDciym/i
         Hzan1UcZmlxOMSJOblCHmNEegXOP4TTl+j4HxWrq2GtUCfK+whxngvZSlaKQR9eMepk9
         kH0qeV4JbOYb6DUiEeGVGJrtk2vaTszOCoqXO7dukIhCIDos5DezPpz9fkzrA2TfIMZT
         GySQ==
X-Gm-Message-State: ALKqPwcfLe9RyaWSrn/XpiR3Axwg70qEpQ1bs4SN4u73BxVnvi9qwRfm
        f7xLpHYpn1LKRXRUQS3NQvo=
X-Google-Smtp-Source: AB8JxZpt/JppQaJllW9vFZWMPp3oEl6eCyAyFVsXGkDKDL8S8L0kCLUhlqegItCaE+t2bLKkAaX3OA==
X-Received: by 2002:a1c:a84d:: with SMTP id r74-v6mr6123795wme.114.1527118731943;
        Wed, 23 May 2018 16:38:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j8-v6sm39889889wra.58.2018.05.23.16.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 16:38:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Pedro Alvarez <pedro.alvarez@codethink.co.uk>, git@vger.kernel.org,
        Pedro Alvarez Piedehierro <palvarez89@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add initial support for pax extended attributes
References: <20180522100548.29881-1-pedro.alvarez@codethink.co.uk>
        <xmqqd0xnw14j.fsf@gitster-ct.c.googlers.com>
        <20180523045714.GA5567@sigill.intra.peff.net>
Date:   Thu, 24 May 2018 08:38:50 +0900
In-Reply-To: <20180523045714.GA5567@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 23 May 2018 00:57:15 -0400")
Message-ID: <xmqq1se2uelx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think we'd fail to notice the truncation, which isn't ideal. But it
> looks like the rest of the script suffers from the same issue.
>
> If anybody cares, it might not be too hard to wrap all of the 512-byte
> read calls into a helper that dies on bogus input.

Perhaps.  In any case, the patch presented here is an improvement
over the status quo, so let's move the world forward by taking it
without any further "while at it" fixes, which can come later when
people feel inclined to do so.

Thanks, both, for writing and reviewing ;-)
