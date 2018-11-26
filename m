Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A994F1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 20:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeK0HOb (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 02:14:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44502 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeK0HOa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 02:14:30 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so16987444edd.11
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSFrjxf2cmEFDZoE6u1hwb7h4P3u4x1F0DsG11k78Vc=;
        b=R3qQF03X4MHjQZvLCi4zUNaHB0efi7WMsq4Zdy+gA1zMl5rCqMzzupLiDgwdkj+PVQ
         ZXtxCHE1xYo4fSUvPCwq5JASbHfB8MrdO25d2PSXMz/9eIKfvwUDDYI2uA9rf62E+TEi
         ykTuGg7XV0XKeCmfWxcPTNcKaSMdhKIr63bvWzFYcV1Mgj/rc8YrAi7oQ0MIskE6+LGv
         d/k+pZaPX3ulHt2+pufD28aVpQhfvzNzL56YeSL2465+e1VFBw+p0BHs2eG0fRBYOuz0
         +NhPUhZecAg0ILIer1B89ko4GStGMZ8a8fM7gLEsBBKED1WEUxMFm0j9RseUTx3ilaJp
         EaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSFrjxf2cmEFDZoE6u1hwb7h4P3u4x1F0DsG11k78Vc=;
        b=l54Lq6BOCkIOD5K63SZh3XBndlx8VhsxbmBu4VJUL+LQv+c4iWtvcMkL2/9WJizdA5
         R4RMe9Hy899byHtDm9gYp9j1OwXKKXbNIERgM9mdU/B4DfjT5pjOzGXqR5Kg5Ky2M2wJ
         /RJkKSt9Y8CAt2pCU+Q+3kIQV4VQlJSVVHkhRDh04d3uDT+XepF2gMpCl1HS5R7KbxUo
         cYkYxClXG1ec7GzVNH5IplwETkLUtMHkZqBwlMZkBFo7XVGfMfuy+kP+nPRPH32GhHvo
         F7h+ZUnRgAMLCfiqTxAR4ydA5rhK6nIUPjvKyMilNGYXdOfJlz8S5DbqnRDyH5kJsLii
         JNFQ==
X-Gm-Message-State: AGRZ1gL1MNEOZ7+nQHN4K9wUIgfhoXEjnga4d3rWnqQIVXUTrhL9Kpop
        nUwzqydz+SUHQs77SnzQb1mpPfJcF2VeSxSKzTcaEw==
X-Google-Smtp-Source: AJdET5e0z3FNDwjmCJkupO6/I2JmY8D4fc8DxFoREqBp1p/7UpOnAwfpMd55S2Lqn5UHBKUgHk1LkaeZtyxfGwsrJZk=
X-Received: by 2002:a17:906:2dc1:: with SMTP id h1-v6mr21259033eji.67.1543263553095;
 Mon, 26 Nov 2018 12:19:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de> <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
In-Reply-To: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Nov 2018 12:19:01 -0800
Message-ID: <CAGZ79kaaLeaffMnkyd7Z1gF5yxq=GDH_Fy_PG1=FfcL=9b9nRQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 1:08 PM Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
>
> The -G <regex> option of log looks for the differences whose patch text
> contains added/removed lines that match regex.
>
> The concept of differences only makes sense for text files, therefore
> we need to ignore binary files when searching with -G <regex> as well.

What about partial text/partial binary files?

I recall using text searching tools (not necessarily git machinery,
my memory is fuzzy) to check for strings in pdf files, which are
usually marked binary in context of git, such that we do not
see their diffs in `log -p`.

But I would expect a search with -G or -S to still work...
until I find the exception in the docs, only to wonder if
there is a switch to turn off this optimisation for this
corner case.

Stefan
