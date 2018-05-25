Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA101F42D
	for <e@80x24.org>; Fri, 25 May 2018 22:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030651AbeEYWxo (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 18:53:44 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45615 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030538AbeEYWxn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 18:53:43 -0400
Received: by mail-yb0-f194.google.com with SMTP id r13-v6so2339923ybm.12
        for <git@vger.kernel.org>; Fri, 25 May 2018 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UcP2d3QmyfTvR1fXf3wUELtXWorYbK63kCCQDoPYOHc=;
        b=FfF6tT5eUNfMNFuV+GPeY4EL0a0rxYwGRIs3xLIYQJYY4kZGnTrmthDgZO6UQduUbW
         TKUNuYt2srcN6RAV0JbnBngrdHButI7FBL6j2rf8XncfW62YFuKaQ7T9qjoM0QxMn4RW
         x5Ltc4ldvR44FgMLE6tKh6cExMbzwXpPvEdi/O5cHtGeV/ReomkME3r3HlUb7CDtiUIH
         A2UlcqCkT6GuYxlD5eRa9xE7zpuZIjU+6hzw6akaPwaZAYTgVQTPac73Zij157YZeCQZ
         RY+oqSjwmwC7DWAtXeLE3ughpZ6L/9VS8g52SY9EwsjQxRFFffcP0eV3CTyK5hL5npjw
         t2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UcP2d3QmyfTvR1fXf3wUELtXWorYbK63kCCQDoPYOHc=;
        b=rr/eDdNzvYc9uFkCKaRYhLTtNuBKVAt1HS3gshnfYQXJJPLzDDQNvcDkl+zSNblnmH
         KlFMLgl5d6vsNhTvZ7y0bOKmGVS0gbtGgL1qOHs3VHztj2xPbOzesSaBVmLeACvDObMK
         fejdyM/2NJDJ++LTPkxZ5brdGf4NQ+qWnTROVVHY3obNnbj+EbbjcYE8Tlcpp6J58vP2
         52hfcN4YXMlwyurnIgvWLP04HWJmIOKdHBErsUdAZ7eZSnkcNIfEhzZCfbKnUEnawAMV
         Mu9Md6M2IC1zVLErpYFwAJqWP6zyjNhDEAmWURN6P6APhZdEQobRKoohpR/WPnyOjOm0
         t9zQ==
X-Gm-Message-State: ALKqPwc0g3DmKceWvlhNL/iuw8xHmCaPkTtMYRol9nDlF13h3R+1WgTP
        LoZTkbYgKbg2R550qCxRZcVf72Hs6WjyQ2axPT5oNw==
X-Google-Smtp-Source: ADUXVKIx1O5pCAWRljUsr6gGvIMsfBNxUDSuQCetsIyc6I/wnCBRXTHSy1YCMKog+noqhd4/lOu0+ZIu3kTTTvm55ZY=
X-Received: by 2002:a25:5f12:: with SMTP id t18-v6mr2461952ybb.167.1527288822832;
 Fri, 25 May 2018 15:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 25 May 2018 15:53:42 -0700 (PDT)
In-Reply-To: <BL0PR2101MB11068051AD589871D4D707CBCE6A0@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180523144637.153551-1-jamill@microsoft.com>
 <xmqqa7spsle1.fsf@gitster-ct.c.googlers.com> <BL0PR2101MB11068051AD589871D4D707CBCE6A0@BL0PR2101MB1106.namprd21.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 May 2018 15:53:42 -0700
Message-ID: <CAGZ79kbZcqzRAqip_CbEmxxhXr_UcAfO-siRgoVjqdd7XsH8sg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] allocate cache entries from memory pool
To:     Jameson Miller <jamill@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> The memory pool design makes some tradeoffs. It is not meant to
> be completely replace malloc / free as a general purpose
> allocator, but rather used in scenarios where the benefit (faster
> allocations, lower bookkeeping overhead) is worth the
> tradeoffs (not able to free individual allocations).

So this is the actual stated design goal of this memory pool?
Fast&cheap allocation with little overhead for giving up individual frees?

> We debated several approaches for what to do here

it would be awesome if the list could participate in the discussion
even if only read-only.
