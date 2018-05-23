Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E901F51C
	for <e@80x24.org>; Wed, 23 May 2018 00:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeEWAsP (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 20:48:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40615 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEWAsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 20:48:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id j5-v6so4396488wme.5
        for <git@vger.kernel.org>; Tue, 22 May 2018 17:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=O1x7rk/zroN6s0wPht9DZqDiHJ9p9ybxY4y1QGRhGEU=;
        b=EDKcP/o0FzdnGSi1AsFLSXHG7qDCry7pAkJPCG7vPbnRlmTjc2gpFpfPOtlER6E43Y
         kYJYMeyUNZLGsWOjqSwMAl0Fz2pq6yXT2zdzl9VvTx6N487cg4ei/SvkG2rTR7HAuf9X
         zJAZmk2dJVQHANgPwOdSGbzuhFCuoe+FNEu81+2OaI//bY0aFo5uLVBeGwZZzLo8/AjH
         p+WWLa3L2YDzX9YSMvFdcY0vQ9bQYHyHYt09AFWI88lx1L1oCS/m0HxsQgFz0zHsqb4s
         jWIwLWm0ZpewgSYOCsa7Vbs8GHHiGkr0+98vCNjxjnV6fcinEm6Yn5KbODYFvmU5iUZo
         30CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=O1x7rk/zroN6s0wPht9DZqDiHJ9p9ybxY4y1QGRhGEU=;
        b=X4Ogg/Y2bdMk6p0YpH7KvpL+It6eqToGHh4n66Jnudo5Y/+BjQ3e0/NisFby3PQ8Jt
         yCBVnIWQMlXBukB31vqrx5JvkWrzvxma9VfkVNf6O6n8HrhqIlivrbOcSciVlDrZF66F
         rJiwUys6YBSokiORoePXl7PzH7sCoxcmFlP/YXuldRN4p9BifaMOJ+ZQE/+rWR3j+1Ny
         LNtBt/Oz7KLY+WmwX5GeG6ViQZ2gzTivKg8FqviWK2hrrXF6gOGcyC6NL2Yn3MMEktJ2
         lgs0OY0j9ZUWKo2BmsCefYOpNzJb0slbU1VKbz9aQb19wpWlgs66HazdGpLuOXRQXTvy
         Zcnw==
X-Gm-Message-State: ALKqPwcvsNFxGxB4iz+swcl6V8TetV4IdFQw+Yke2f7pBZFk7sQysxJe
        frsrBKi+b5wVZF5M1/SlZp0=
X-Google-Smtp-Source: AB8JxZrx5gdQ9HaHu4XdISI8LgF4k5fU1b8nieFi36RJaRitsD2NYbCgUbPx+HrfZw4r6+v5PQLHVA==
X-Received: by 2002:a1c:af4b:: with SMTP id y72-v6mr2538503wme.148.1527036493272;
        Tue, 22 May 2018 17:48:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h12-v6sm1580497wmc.7.2018.05.22.17.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 17:48:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/4] unpack_trees_options: free messages when done
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
        <cover.1526913784.git.martin.agren@gmail.com>
        <xmqqa7ssz9u1.fsf@gitster-ct.c.googlers.com>
        <xmqq1se4z9fu.fsf@gitster-ct.c.googlers.com>
        <CAN0heSr0uZvaRqjNmD5=8RLpcLiWHjG2OoZovYK7TkGkCKu=7g@mail.gmail.com>
Date:   Wed, 23 May 2018 09:48:11 +0900
In-Reply-To: <CAN0heSr0uZvaRqjNmD5=8RLpcLiWHjG2OoZovYK7TkGkCKu=7g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 22 May 2018 13:11:20
 +0200")
Message-ID: <xmqq7envxkms.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> (Maybe not to fix the leaking as such, but to keep 'maint' more up to
> date with 'master' for easier merging of other topics?)

I admit that I occasionally do such a "presumably no-op" merge to
'maint' out of sheer laziness, but in general I'd prefer to keep
'maint' quieter than that.  As we do not have any repeated caller
that calls unpack_trees unbounded number of times in a process, I
think it is OK to limit this update only to 'master', especially at
this late in the cycle.

Thanks.
