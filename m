Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53921F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfJKWUv (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:20:51 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34564 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfJKWUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:20:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id d3so7246376vsr.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwfb4LAxacqBnQObMwdqoAXtHRDGwloT5bOYZ/Vd6vk=;
        b=oZwzQhmrOEDI+mZ86TIYz1/ob7R4CD50K/54ONJQ/OAXmFlayOAqY1vlX/PrQTeV/R
         VlIbqBYlOwcqBStpnC+sri/5ccyhzJtOl0sKnELil7XBYYARc7uN8NNd/u2Y2AakoXJk
         44u2UgNE/60jwJxDgTpJPdizdfBG0i2ypGLjBF7SLE9lyFINssOt289OEaA8fiHOY4yG
         wh01hYkbkOU6+Lme0Qg66etPpZrJy5k9aOX6vySfhumVdRPr6pe9eb60MKb6isUzvFbc
         z0RC+Q7Q/aLadVkiRE0/tGEcMwKrOmVGrMEA1G+ln7InML7MPvUsh/6d/KZ2/jjXiAyr
         qrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwfb4LAxacqBnQObMwdqoAXtHRDGwloT5bOYZ/Vd6vk=;
        b=Pm7BpN7wlp3FWCXXnwYApQ70Wnm1IJByUPyzPNF2FBGt7YMfm6e3tWVsivre5X+TPJ
         vfqz59w4B2M+WleQL0U24op3Owuwt7qa5zioNfvM3CVFhv1Qhklo9X+MItk4kiFPvXKU
         OJIS+sS1j63godqrrzJzTetWUnN0hLdtZy5N/3PvT4Tde6eIwGLK60dnrXPuowrI4IhQ
         95nY09B/CGeyOO9/bsPD2ByFprACPjyiptnImXPYFK698kJDP5IAPOd+G+xEbSmRvjpq
         WLxwu3IVfl4OPcU8SNtXafNAPkK53LxJ3exLcfNgyzGtuMTdEhwnxxp2nh1JZJake5MY
         ltMQ==
X-Gm-Message-State: APjAAAVvCBbwQYp7/rMsQYzVCXEUzu+F9kNj1sz/0TQgJ4TZ0631JNdI
        QjyILpWa6FzbIo8vC5c8e40cBhVX2AQfOcN4YZA=
X-Google-Smtp-Source: APXvYqxQFP5vuEI82J0mFoYHxFTN56b/dKaC42bv+9Z9ULF9g/WhLKhKOojBcOCEnVzAuTYf0fqDCVuaY/rLg+DHVPY=
X-Received: by 2002:a05:6102:2130:: with SMTP id f16mr10301485vsg.117.1570832450632;
 Fri, 11 Oct 2019 15:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <c8587a1fb0e335f9cbafdbb44b20d02a1e57886b.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <c8587a1fb0e335f9cbafdbb44b20d02a1e57886b.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 15:20:38 -0700
Message-ID: <CABPp-BEcS2fT8XyrU+cghbN5YwO97HR5+xgi5=dGZPJ8ut+eUQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] clone: add --sparse mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> During the 'git sparse-checkout init' call, we must first look
> to see if HEAD is valid, since 'git clone' does not have a valid
> HEAD.

...does not have a valid HEAD by the time git_sparse_checkout_init() is called?

> The first checkout will create the HEAD ref and update the
> working directory correctly.

Is this checkout you reference a manual-initiated user checkout after
the clone, or the checkout performed as part of the clone?  (I'm
almost certain it's the latter, but your wording makes me question.)
