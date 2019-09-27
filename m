Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DBAB1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 16:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfI0Qzd (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 12:55:33 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34348 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0Qzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 12:55:33 -0400
Received: by mail-wr1-f47.google.com with SMTP id a11so4009896wrx.1
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 09:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hN/Bra0uMI6zpUYvpPZ/sH7bhIu7QBWaUXuCxeH1dVA=;
        b=mfi2QzynIr+DGwZlKrCb9a6p/YFPXty1QZ1bNpy/tpuk4zgOWexeWkAQtzASt2s61J
         4gHPf9dCakq5N/nWoW+QSo/fvQhqFXpbmN5v9VbUQhDmgVo9nxhzi969FfVuTsPAwmad
         KW4C7WnmCE5pUvUIWNz3iYvYpgnFiI5EwlXN41CtUa8Il55+gQsxuKEsZdvwmH6LV0xX
         kMNU9jmi8FacttSEi9UX9BJ69hpIbYLifKoZH5EnE4dYfNimy/hn4PYQfOUjYR2XFBue
         DIGPuAcnaXCpUu0zjrdw9oSMAhl4B4Xr8OuE4hAfyuKSuPUbUEZ856zC+fh1zPupzlwM
         ++og==
X-Gm-Message-State: APjAAAWvRxaEyPGq1D7mzZlIYyovzfcTyMs0hDr/gQAEWmY+s+++y+R3
        aviksFKGQ46ky+mNIJCxaAQvKDmAdlElS+Js/5S4t+4S
X-Google-Smtp-Source: APXvYqxsEuzsLrn/XYKBLBmPgfcB0h6SjAhR1CbCqj+kWQmN13ZXL9NIsNEAZ/lZbW4tgdg6c2x1eoGB10TLpUxmcZU=
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr7562449wmf.129.1569603331227;
 Fri, 27 Sep 2019 09:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <CADZUK1cjvifbFYk9w6+vE95jgEBuwjoOi_1QfZHoPFBXuXHCCg@mail.gmail.com>
In-Reply-To: <CADZUK1cjvifbFYk9w6+vE95jgEBuwjoOi_1QfZHoPFBXuXHCCg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Sep 2019 12:55:18 -0400
Message-ID: <CAPig+cSsSHCNK9yogRUq+gRv+yb5JdPO5ECW0FKZgbW-RXGw8A@mail.gmail.com>
Subject: Re: Feature request: different exit codes for git stash depending on
 whether stash was created or not
To:     Ian Kemp <ian.kemp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 27, 2019 at 8:55 AM Ian Kemp <ian.kemp@gmail.com> wrote:
> Currently, git stash's exit code is 0 regardless of whether it
> performed a stash operation or not. Third parties invoking git stash
> are therefore unable to determine whether a stash was actually made or
> not.
>
> It would be helpful if there were different exit codes for the case
> when a stash was created (working directory dirty) vs when a stash was
> not (working dir clean). git stash create suffers from the same issue.

There was a recent discussion[1] about this which might interest you.

[1]: https://public-inbox.org/git/01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com/
