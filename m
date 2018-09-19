Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C861F453
	for <e@80x24.org>; Wed, 19 Sep 2018 18:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbeITAWb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 20:22:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36784 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbeITAWb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 20:22:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id w17-v6so6829583otk.3
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSenbSArIjOHNt9S+ly1U3GgFw99k2efjZCCYfD2+NU=;
        b=Rpcfzt3CeKE/gGZ7pZ068Jr9WtBa/E29zBHKqC/nK6whi42TXhJnDBECk7UTMoQF/3
         41GAQxFaeDvUFVbqwwz7YqH0yOTKSTOOOK5+9oUS/let8x7R32aHUpTJMxj8cM2GVpTL
         uAuAKNBtdOZH9SYWMWNI5BSrQfQFDFQCR7LgPnhKf9jRXw6/yo3YKk/u7kF6OOJ4lOY2
         x/bYk8+1TWim1YtCMrbbtFMQWE0JO1xaF++lQdGafFnmhc5W9hwu1LtT0ZH/Ouk/i04+
         Ez4TaFF6w+J1e0s0McG85wXnbPkJqjFwu/YAgNFSa4yd8cWHDPGxV867njZ66GVQtSjA
         gXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSenbSArIjOHNt9S+ly1U3GgFw99k2efjZCCYfD2+NU=;
        b=t8dCXLUgrjXrx00MkS2A35TDGpNe86JGFGr/B36wlxsEH68XpdWaxhtVfOBFoNFObg
         Wp/JU4nV27liqKrNi/3cFtuJelToDy6BLqmDd0gai/QYTYmYzcvWtgzBnVVhpxvH7Njz
         CWn7AvWH+QWthBJtpvNXpz0P3y2CoJFYQ6PVSg77VOpQaI7H3ZwaVRfZP9CpNlvnnbvn
         sRzUS7qb4ou4bKao0Iftmf5kbm2dNzPtFuiWcDr43xcRs/OSogc3inlf69qmmTKysF+m
         BAwFzEUv6xH4UBnQVaY2BO4w6yWXBg7IyeFuqQEIgWiOLpTg6EA8NuAmV7Gox3IlHX1H
         fPfw==
X-Gm-Message-State: APzg51BsubmYaAaFN6d469+1vpgQVHO0s5IiU6So52GybWRaNCTKD50V
        x+D2FU9ds6gOGImeebsO93fciI+qRzXwgA4X6Elp
X-Google-Smtp-Source: ANB0Vdasett2VawQPh3N9gB2PnGo8vISvwSFLtU4RKQRXfNnVggaHLIlsZeNHyJkoil1bgA+tJOKHErop9+QiTb64PA=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69-v6mr19332765otc.23.1537382598019;
 Wed, 19 Sep 2018 11:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <e01b719de662f0b150f78b5a6ab6ccfce9c675fa.1537223021.git.matvore@google.com>
 <CAPig+cT5BLu2onbuTBbZ_mMzNMkEuPk5-g2d5YKw4V6Z42Y3aQ@mail.gmail.com>
 <CAMfpvhJ3ye_7LWaQ1abXKtMB=O1sfOz6xYN=7acrVdLOksq9eA@mail.gmail.com> <CAPig+cQ3M+Wtyrm_GGRhL7kgM0eWPsXanK-AbLtJiQsORJ3A5A@mail.gmail.com>
In-Reply-To: <CAPig+cQ3M+Wtyrm_GGRhL7kgM0eWPsXanK-AbLtJiQsORJ3A5A@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 19 Sep 2018 11:43:05 -0700
Message-ID: <CAMfpvh+BO_7z_K52jNupLMmx-gbNSwJzfswVQeNsPWVx7onTEw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] t9109-git-svn-props.sh: split up several pipes
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 5:50 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> If so, then please use test_cmp() rather than raw 'cmp' since
> test_cmp() will show the actual difference between the expected and
> actual files, which can be helpful when diagnosing a failing test.
>
All the other testcases in this file use "cmp" and I would prefer to
maintain the consistency in this file. Note that the non-stylistic
fixes (breaking up pipes) in this test were originally not the goal of
this patchset, so changing this entire file to use test_cmp (or even
just a single testcase) seems like it's just getting even farther away
from the original goal of making pipe placement consistent in the code
base.

> Rather than escaping "$" with backslash, a cleaner fix would be to
> change the double quotes around the test body to single quotes. Those
> double quotes weren't needed anyhow since there are no variable
> interpolations in the body. Single quotes would make that obvious at a
> glance in addition to avoiding unexpected behavior in the future (like
> $1, $2, etc. being interpolated at the wrong time). Single quotes
> would also make the test more idiomatic and consistent with the bulk
> of other tests in the suite. If you do go the route of swapping
> quotes, please be sure to mention the change in the commit message.
Done. I thought of that earlier and thought that I should use double
quotes for consistency with the surrounding code, but then I saw that
there were testcases farther away in the same file that used single
quotes.

Here is the new commit message:

t9109: don't swallow Git errors upstream of pipes

'git ... | foo' will mask any errors or crashes in git, so split up such
pipes in this file.

One testcase uses several separate pipe sequences in a row which are
awkward to split up. Wrap the split-up pipe in a function so the
awkwardness is not repeated. Also change that testcase's surrounding
quotes from double to single to avoid premature string interpolation.

Signed-off-by: Matthew DeVore <matvore@google.com>

>
> Thanks.
Thank you!
