Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453A220954
	for <e@80x24.org>; Sun, 26 Nov 2017 01:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbdKZBph (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 20:45:37 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46520 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbdKZBpg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 20:45:36 -0500
Received: by mail-vk0-f68.google.com with SMTP id 138so4147877vko.13
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 17:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iPEUQrLyuTj2OTaUNbRENeESRQkfZTpyKV7zJgMy8HI=;
        b=rD69XcjIMl8/nK2V84/E9u7rbGQj0eu5NfCUNzPsTzXziMbp/7yijRk3LtZ2r43Kub
         h9jbStfc9ADISTJJHb/rQUYuqm8x4kZaCQG+nIb5z/0HMMmygD4/nkDuUHPr/31ES6qR
         NHtw1PT6cC4RsoE1WsoTEjHzj/J0OIRdRg+10c4Olpy5sIiLo1eTN8w3mlNQlS72kdoC
         uizbPhbwONIsDzMk4Ug3IVw0rSEK7QtYLgO3Bi8nvvtPv5gLmvN3s3R6DOaCBxolc9p1
         +BZY5Mtwl8pRJ/HXPYDW5lCToO2wwrVESJ1l7DQS0/Ck1CZyCLWQYNtQlcGLhGR6aAHA
         rv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iPEUQrLyuTj2OTaUNbRENeESRQkfZTpyKV7zJgMy8HI=;
        b=UvAxloT2fRAJufqN4piSaDRiAyK7oOmvYyi4TPUh+vB+7jje8NYb7GQo2KtmqljRqN
         wXAucAvlVcwFVdO4sF3EPRO0WXbbOLZdr7nWU0fv0DnCGbyp+2Whf0FcvYiBGk6RE9/a
         lHI+8+9G6CEh0khCwUzJeTYTZQCN0ro5QZwzKBp/JTyH//LEGCRvDRZzkLdkzGR2MgtR
         AEyX+8dxJGIREKlttHj4kFY02Cl3qGpqF7vmcCt4LjF6lcnUUumP4Uy43tjs0GA9qMCQ
         2fCRgtULlIXxRGIQklTzBuEBHacuI6yKunxHW0vzOqcvw1F7EsurVSZHn8okpjE40n+i
         3YCQ==
X-Gm-Message-State: AJaThX7ssNQ/ZKTov0aWIx3jfihNp0oICRmFwH3q07mNVG3GvXrKp1EP
        /qpYqBinlWB62hJu9A0pjseLni62SyyLac4K1Yg=
X-Google-Smtp-Source: AGs4zMZ3iIfEeu91r+qs0fmetF2akqmO0vADLFO0dDjhmVuqrQ2+DZJp4JpuHcMT9DHLk3suJDQLlfx96VTf92haEM8=
X-Received: by 10.31.125.75 with SMTP id y72mr23907103vkc.79.1511660735699;
 Sat, 25 Nov 2017 17:45:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Sat, 25 Nov 2017 17:45:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1711260147330.6482@virtualbox>
References: <20171121080059.32304-1-newren@gmail.com> <20171121080059.32304-22-newren@gmail.com>
 <alpine.DEB.2.21.1.1711260147330.6482@virtualbox>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 25 Nov 2017 17:45:35 -0800
Message-ID: <CABPp-BHYNQzNnXqCuUafyN0UK5y6KQZapdjsXj+dW+dwL=B+nQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/33] merge-recursive: add get_directory_renames()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 25, 2017 at 4:52 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 21 Nov 2017, Elijah Newren wrote:
>
>> diff --git a/merge-recursive.c b/merge-recursive.c
<snip>
>> +     if (old_len != new_len || strncmp(old_path, new_path, old_len)) {
>> +             *old_dir = strndup(old_path, old_len);
>> +             *new_dir = strndup(new_path, new_len);
>
> These two callers of strndup() are the only ones in Git's code base now.
> It is also causing a compile error on Windows.
>
> Any reason you did not use xstrndup() here?
>
> Ciao,
> Dscho

Nope, was just unaware.  I'll go ahead and switch them over for my
next roll of the series.  Sorry for the pain.
