Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BDB202FC
	for <e@80x24.org>; Thu, 19 Oct 2017 21:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbdJSVPP (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:15:15 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:50547 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdJSVPO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:15:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id d9so9415663qtd.7
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JgVO0o1hgwmP/GvhC0GYJU55xgBQopExugz2SAMsjzw=;
        b=V5KGlQHA2c3JcaZGllp+QUJN2v601E3aDHZ0zfe5vqMqa/Spg7yGwhSYV/gBz4kxqO
         Om4zf/1Sqs/95Nwxj1hVnsgbSDuyHZY6OnO7alR/DX53QN2oaOUuyLHz88xw3NEz2v4/
         Tm1dB3yXCjQpRHCn3jMd0OWgT5zOGz4VMxq76oqJUolZ4ZpTT9ura4V1DKklsrAPMfvZ
         k7v0wct2kjriF212usUxbx7Q71AqMqYtLHsbze5HuHQ65eWqBEYBKW3LY2xltsCXRwE1
         9SjaPhYiYzJA08hs+Y0yCRuOGsIw5M79pXgx1ol/E48JUfnPzJ0glHf0aMjDrvWD/xUI
         FW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JgVO0o1hgwmP/GvhC0GYJU55xgBQopExugz2SAMsjzw=;
        b=KMbOD0pg5oIuD/Gmj4HjXslpSF4WVplzsHJHGP7lN/6bUPo03psCS/6YshksOCvwhm
         WR+Lvlafy9+L7fQ+2avoC/vap870nBnb4JW67kU+L1+QRs6NJrTboJKQq1rMP3Z+odRL
         2Cc1qSl05D7NT1vvwsTJjZCmQS/FjpV0S+DRtBM2fQUWq23/gfsedAJ9+RgQ2mKWBnbc
         rxvqd/pliBhvgyOdCwRu6d8ISVs2iK2WfNKuaFi+yy/oy7Tq3hY3RBGsGi/xJPA4EMEs
         zlBNlY1B6dI+CpBc2qlzWKSImyQ6boqpr94XegPTnLCW46PC3WR1s/edBl9R3FJ7toB4
         NbSQ==
X-Gm-Message-State: AMCzsaXysh0bgA7reEJ1PijTw2vEE1XqXYuSl/vAdffSxAYKORSyA4zb
        AU3o93kWPyo3o9+aW0I/JVlnzTh2ELL2AFoxIym5zg==
X-Google-Smtp-Source: ABhQp+SUMw8N/K8qEsFAuhvQwdMhO5S9eiABIEnsz3N1zJyBYyzbVE6Md5yvqR24kcdnzbYrt1ALO1X4Nv8PLAG2iuA=
X-Received: by 10.237.34.201 with SMTP id q9mr4192229qtc.198.1508447713427;
 Thu, 19 Oct 2017 14:15:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 14:15:12 -0700 (PDT)
In-Reply-To: <20171019202926.irldca42wqosmxrd@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net> <20171019202926.irldca42wqosmxrd@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 14:15:12 -0700
Message-ID: <CAGZ79kZhCoFe1P_gwigzrgzzcqRunrUWGOAgy9xvS2ugNeVLmA@mail.gmail.com>
Subject: Re: [PATCH 4/5] diff: fix whitespace-skipping with --color-moved
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 1:29 PM, Jeff King <peff@peff.net> wrote:
> The code for handling whitespace with --color-moved
> represents partial strings as a pair of pointers. There are
> two possible conventions for the end pointer:
>
>   1. It points to the byte right after the end of the
>      string.
>
>   2. It points to the final byte of the string.
>
> But we seem to use both conventions in the code:
>
>   a. we assign the initial pointers from the NUL-terminated
>      string using (1)
>
>   b. we eat trailing whitespace by checking the second
>      pointer for isspace(), which needs (2)
>
>   c. the next_byte() function checks for end-of-string with
>      "if (cp > endp)", which is (2)
>
>   d. in next_byte() we skip past internal whitespace with
>      "while (cp < end)", which is (1)
>
> This creates fewer bugs than you might think, because there
> are some subtle interactions. Because of (a) and (c), we
> always return the NUL-terminator from next_byte(). But all
> of the callers of next_byte() happen to handle that
> gracefully.
>
> Because of the mismatch between (d) and (c), next_byte()
> could accidentally return a whitespace character right at
> endp. But because of the interaction of (a) and (b), we fail
> to actually chomp trailing whitespace, meaning our endp
> _always_ points to a NUL, canceling out the problem.
>
> But that does leave (b) as a real bug: when ignoring
> whitespace only at the end-of-line, we don't correctly trim
> it, and fail to match up lines.
>
> We can fix the whole thing by moving consistently to one
> convention. Since convention (1) is idiomatic in our code
> base, we'll pick that one.
>
> The existing "-w" and "-b" tests continue to pass, and a new
> "--ignore-space-at-eol" shows off the breakage we're fixing.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diff.c                     | 15 +++++++----
>  t/t4015-diff-whitespace.sh | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 6fd288420b..09081a207c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -712,7 +712,7 @@ static int next_byte(const char **cp, const char **endp,
>  {
>         int retval;
>
> -       if (*cp > *endp)
> +       if (*cp >= *endp)
>                 return -1;

This converts (c) from (2) to (1).

>                         while (*cp < *endp && isspace(**cp))
>                                 (*cp)++;
> -                       /* return the first non-ws character via the usual below */
> +                       /*
> +                        * return the first non-ws character via the usual
> +                        * below, unless we ate all of the bytes
> +                        */
> +                       if (*cp >= *endp)
> +                               return -1;

This fixes the mismatch between (d) and (c).

When I wrote the code, I did not follow proper commenting style
by capitalizing the sentence start and putting periods. :(
(Well it was a single line comment, which I have seen to not
follow style occasionally unlike any multi line comment. Anyway
no need to fix it here and now, just pointing out my bad code
in the beginning.)

> -               while (ae > ap && isspace(*ae))
> +               while (ae > ap && isspace(ae[-1]))
>                         ae--;
> -               while (be > bp && isspace(*be))
> +               while (be > bp && isspace(be[-1]))
>                         be--;
...
> -               while (ae > ap && isspace(*ae))
> +               while (ae > ap && isspace(ae[-1]))

These fixes convert (b) to (1), so we're all on (1).
As we check for strict endpointer > firstpointer
(and not >=), the check of -1 is fine, too.


> @@ -1463,6 +1463,73 @@ test_expect_success 'move detection ignoring whitespace changes' '
>         test_cmp expected actual
>  '
>
> +test_expect_failure 'move detection ignoring whitespace at eol' '
> +       git reset --hard &&
> +       # Lines 6-9 have new eol whitespace, but 9 also has it in the middle
> +       q_to_tab <<-\EOF >lines.txt &&
> +       long line 6Q
> +       long line 7Q
> +       long line 8Q
> +       longQline 9Q
> +       line 1
> +       line 2
> +       line 3
> +       line 4
> +       line 5
> +       EOF
> +
> +       # avoid cluttering the output with complaints about our eol whitespace
> +       test_config core.whitespace -blank-at-eol &&

We avoid the eol space change as we want to test the move detection
without interference. Do we want to test it with that as well?

> +       git diff HEAD --no-renames --color-moved --color |
> +               grep -v "index" |
> +               test_decode_color >actual &&
..
> +       git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color |
> +               grep -v "index" |
> +               test_decode_color >actual &&
..
> +       <GREEN>+<RESET><GREEN>long      line 9  <RESET>

ok, we also have no interference with space changes,
which we assume is orthogonal.

The commit message really enlightened me,
Thanks!

Stefan
