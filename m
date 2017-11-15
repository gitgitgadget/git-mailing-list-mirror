Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1951D201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 17:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbdKORvs (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 12:51:48 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:55702 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757667AbdKORvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 12:51:48 -0500
Received: by mail-qt0-f170.google.com with SMTP id v41so36245607qtv.12
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 09:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z1iKxIYrYIrGHt9qSNk/fXwZZW+WHvhI9rUjfin4Jj4=;
        b=NUdWy+PybxtNYER4Y6xHyDkVMe5A/psXFfc0YtGnboyoAw59vlHteUyRE2v71ASSJl
         sMNw1Fk8rNEL1+Xo48hCpHYHZcGrlf1emOxjzlCPUDGhwXuT7hucY8LZmdqt9vGNfJwR
         3s086qQEg7Txui0cB12quEF0H9UQhrv8ab/RawPjJXYjL4etzqGy8FvWTbrJJ0RyqEzD
         QjTAjgU2owHts0jLcK7gzMy+4MlbNy7JCGYv5h6JTkPZt6MikcRbmPeQ7a2UPQzW3Qoz
         eFpMNGrKxzY+GGCoTduDztNGMaVYSJqYG/PgLPHlIjoWQ1EYCI0SxIq2/1IgWJh00SZV
         yNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z1iKxIYrYIrGHt9qSNk/fXwZZW+WHvhI9rUjfin4Jj4=;
        b=fATjF4fXHQSa5xm2wkxS4GslcxZTdZ7xSFFpJ2ROKRKGmxhrb0UNTv5jlona1IwrDo
         sdpc7FxNdji1il+cPi1ZVHQJX7nwJ7b/z761eKo6Net/LE4RD8QVp/365lW9J4bT+m1k
         bZkg3JrOVM/tmkf/9GIvJA8vRUe4naXBj39VwpM1QvVP1ZeCMZSIjuW/cWvTdy53mWX5
         e/k2hM1iJb138Srf0Eceg6X3g7O2lBRVz4OV6rjoOCpKxL6wn+Fkj89BXjpWPjExQQDS
         iNq5p07SAM+qZUMCNpZ41iy/VN7fSTILFV26W++T1KMyL/D2dmjFRL3CQl/eU0t86yW3
         OKFg==
X-Gm-Message-State: AJaThX5zXQSc8aCDT2g2ZodQmIG9C7hhrTBiww/q8tRj2zQH0kih8zLR
        NEBMtgn6GNB8hjxGpPEFNoxz3kORsG9Z3cdTPZzMTw==
X-Google-Smtp-Source: AGs4zMaCYbEC66Uvxq224ulhtE6Mr9SmDTEBFbgEP8HpPMAdNmajl9N1HnwQAt1YgV3BHYwi9Pdl2oooSEp1MDF3Xt4=
X-Received: by 10.237.62.5 with SMTP id l5mr14683460qtf.299.1510768307094;
 Wed, 15 Nov 2017 09:51:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 09:51:46 -0800 (PST)
In-Reply-To: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 09:51:46 -0800
Message-ID: <CAGZ79kaqyRTaj6=-7Jmb1K6_aSH5-BaEhm7PPyRgJLsHuDF-tw@mail.gmail.com>
Subject: Re: [RFC] Indicate that Git waits for user input via editor
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 7:08 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> Git gathers user input via text editor in certain commands (e.g. "git commit").
> If you configure a text based editor, such as vi, then this works great as the
> editor is opened in your terminal window in the foreground and in focus.
>
> However, if you configure an editor that runs outside your terminal window then
> you might run into the following problem:
> Git opens the editor but the editor is the background or on another screen and
> consequently you don't see the editor. You only see the Git command line
> interface which appears to hang.
>
> I wonder if would make sense to print "Opening editor for user input..." or
> something to the screen to make the user aware of the action. Does this sound
> sensible to you? Am I missing an existing solution to this problem?

Can this be put in a wrapper that opens the text editor?
The wrapper would print these lines and then open the text editor;
depending on the operating system, there might even be a command to
focus on that editor window.

Regarding Git, maybe improve the documentation for how to set the editor
variable?



>
> Thanks,
> Lars
