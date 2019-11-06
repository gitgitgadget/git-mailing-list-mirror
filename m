Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51DB61F454
	for <e@80x24.org>; Wed,  6 Nov 2019 00:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfKFALo (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 19:11:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32964 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKFALo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 19:11:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so287942wmb.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 16:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abcvxjY0IJXPfLsHy8BdRp4Sz6cJlyiig+jTR38fcNQ=;
        b=VvUuAYr/fXstT8ULeVQ8hDK4OxMVXKbv7ii+++xC+3t+HSXJWH/qZo7seWKmPV5omA
         8aoFePjk8T7E6noHN/eQg/pfJ7WlscnO9GfAu1X2YJtKF8qcxdCEQu16cWAlLPY9U8av
         5NXFwiSDCrj/yU3ca4ekL3qLI7pdnwRZpz9cnMqBilQ+gpfyS7EfXDc2aELJkI5ATk5C
         UPpw4aUhaDpmML4KWbKrUtNTW6iiMUCtQQvRYzT095XnhzjDl/5jps6P62HdxfCw2mTt
         UvTn8fD9eSlZYrgZnYUv8CbXMfF1M5kDvjr5uBeT4SYpVHBduq8ajjikJOHTg3ud1j+p
         +SGw==
X-Gm-Message-State: APjAAAUP/b0yEBNbyPzQe2+dZgSR0wIToeqJlmAxvRtHekjJvtd0yklU
        jj5zTTC1CdO1OK9bCe+sNF0WeJijhN8n31JqvhQ=
X-Google-Smtp-Source: APXvYqytxiafcBvW+Ni0mar4zTd9S26vgT7dMjejicjzBFE6iLh2nQfE8GxzpFrfS1kmMXjSKgWmhqZn46VRnAatGQ4=
X-Received: by 2002:a1c:3843:: with SMTP id f64mr1232070wma.129.1572999100469;
 Tue, 05 Nov 2019 16:11:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.455.git.1572998303.gitgitgadget@gmail.com> <c6349cdbd057ccbcced3220ff3474b2e2083617e.1572998303.git.gitgitgadget@gmail.com>
In-Reply-To: <c6349cdbd057ccbcced3220ff3474b2e2083617e.1572998303.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Nov 2019 19:11:29 -0500
Message-ID: <CAPig+cRdG+RZOeXuJLfF7UyiBccHs6yWnCqt2d1oyTTuwp6=YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] t6024: modernize style
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 5, 2019 at 6:58 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> No substantive changes, just a few cosmetic changes:
>   * Indent steps of an individual test
>   * Don't have logic between the "test_expect_success" blocks that
>     the next block will depend upon, move it into the
>     test_expect_success section itself
>   * Fix spacing around redirection operators to match git style
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
> @@ -15,73 +15,76 @@ GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
>  test_expect_success "setup tests" '

Since you're modernizing, perhaps use single quotes around the test
title rather than double quotes. Same comment applies to other test
titles.

> +       echo 1 > a1 &&

The commit message talks about fixing spacing around redirection
operators but neither this instance nor any of the others in this
function have been fixed.

> +       git add a1 &&
> +       GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
> +       ...
>  '
> +       cat >expect <<-EOF &&

Since there's no interpolation going on inside the here-doc, perhaps
use -\EOF instead. Same comment applies to other here-docs.

> +               <<<<<<< HEAD
> +               F
> +               =======
> +               G
> +               >>>>>>> G
> +               EOF

Custom in most scripts is to indent the here-doc body only as far as
the command which opens it (that is, give it the same indentation as
the 'cat' command). Same comment applies to other here-docs.
