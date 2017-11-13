Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6821F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 23:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdKMXVB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 18:21:01 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:47819 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdKMXVA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 18:21:00 -0500
Received: by mail-qk0-f177.google.com with SMTP id 136so11089638qkd.4
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZixXwLXqPXiAewHpEydOP4AtlUmKeZ748xxXExlOixU=;
        b=i4QQGAZFgmkcN9+mtfhpX6riB93BLxOxWZjN6QBSmPpyUZtIObSQFnqDMwXXg1qfv8
         xlgQPx3i4SQmjuePSPyf+ma7fwdg9UMeUZpL22+qAQ/8zwqxRwB4MgD0AJuKoF3zRDFH
         fj0ml4yh3qbjPm8tOwDHtUJUql2cpqCzokwIBRyMd7MhszmSJhOHawkCgYRumarw6DbB
         isYirYoYO3NCXt0wrobuBfiOvXLOVVy4hhnsxostlMquykIyU5dcPeIJUrhaGIYza+Tf
         R345t+ZNnMH9Y9X1Jj4tCz8JQHclDXQ/Cijqnh/dWvalHCfhQR+45ycP5LjUmNsaFfIQ
         L95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZixXwLXqPXiAewHpEydOP4AtlUmKeZ748xxXExlOixU=;
        b=OAkJ0JER0rDb2soexSiGgnp6PnxbcZ4olOnv/+JUTCZufHuAhHr9dkG5AP5r+7TOjU
         jr9IYICdpEFGuBINfhrLtdSihk5ROAKByMITd/rbIFB34HIsWeQecvG3Ix2ep7u8Mcim
         yH16X4EXhbOjjcXaXQW3VUUjAcsRZLLxsM235wGf+sNF1rXqdGjWdN7K8/JFzvJ49u70
         UmAPc0VFM7iutTd+aVKY0+2n2FRHxg9/zWonydLY4LEa7XXjRsKZxeDD1HKkS3bMViFa
         dSmiukdyJgse/R5jwhSnSnJbs65+oNOYidKPlvtZhKGdyanKVJturHxAj6UQwe1m33Kk
         HLhg==
X-Gm-Message-State: AJaThX7u/7BsKSt0VVqDPFulid7mpPbO0Wj186ywRmPkdO2PPN0jw7+U
        rKVbj7yjPgamqU4feisIDW68dtsPrR0WkiJ/cghsNXMX
X-Google-Smtp-Source: AGs4zMaLb/8Lr7TUZZP9hg/1+Ihc4tuw7BqtHCO1wXR7BX/wJTyOq28dWEFuYQyKj9k3azfbj6RUu5uLcMYqUZyqY/g=
X-Received: by 10.55.129.70 with SMTP id c67mr17249875qkd.230.1510615259216;
 Mon, 13 Nov 2017 15:20:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 15:20:58 -0800 (PST)
In-Reply-To: <20171110190550.27059-6-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-6-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 15:20:58 -0800
Message-ID: <CAGZ79kY=JWXs3ASmWQPt__REMbcWQinkJt8ZcZWQEM6V5S7x+w@mail.gmail.com>
Subject: Re: [PATCH 05/30] directory rename detection: directory splitting testcases
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6043-merge-rename-directories.sh | 125 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index b737b0a105..00811f512a 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -388,4 +388,129 @@ test_expect_failure '1f-check: Split a directory into two other directories' '
>  #   in section 2, plus testcases 3a and 4a.
>  ###########################################################################
>
> +
> +###########################################################################
> +# SECTION 2: Split into multiple directories, with equal number of paths
> +#
> +# Explore the splitting-a-directory rules a bit; what happens in the
> +# edge cases?
> +#
> +# Note that there is a closely related case of a directory not being
> +# split on either side of history, but being renamed differently on
> +# each side.  See testcase 8e for that.
> +###########################################################################
> +
> +# Testcase 2a, Directory split into two on one side, with equal numbers of paths
> +#   Commit A: z/{b,c}
> +#   Commit B: y/b, w/c
> +#   Commit C: z/{b,c,d}
> +#   Expected: y/b, w/c, z/d, with warning about z/ -> (y/ vs. w/) conflict

> +       test_i18ngrep "CONFLICT.*directory rename split" out



> +# Testcase 2b, Directory split into two on one side, with equal numbers of paths
> +#   Commit A: z/{b,c}
> +#   Commit B: y/b, w/c
> +#   Commit C: z/{b,c}, x/d
> +#   Expected: y/b, w/c, x/d; No warning about z/ -> (y/ vs. w/) conflict

This makes sense.

> +
> +###########################################################################
> +# Rules suggested by section 2:
> +#
> +#   None; the rule was already covered in section 1.  These testcases are
> +#   here just to make sure the conflict resolution and necessary warning
> +#   messages are handled correctly.
> +###########################################################################

okay, then I'll go back to 1. and discuss "the number of files as a
hint where to rename it to" there
