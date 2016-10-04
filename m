Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D305D207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbcJDF6K (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:58:10 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:32841 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbcJDF6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:58:09 -0400
Received: by mail-yw0-f193.google.com with SMTP id g192so7284477ywh.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jouaXHVARN7TPIR1aRyDjQCcOqH/ziYXL93prLAr8VQ=;
        b=MdO5Dq7X2zOinL3UBQVYnkiZ8omIuMmMzWIzi7AJPTSHtOL9yK4E8NamY7yfd/OKg3
         gcSytclrvkVM5zKAmPY/vbKpCm8+zKtn+kd9uE8kqlQsuWsVNRs2qGzam+edV54A5BDX
         dBCZDAXDr8rp6LQfwecfwH5ynf3C7MWJYX49btUrlaNDAP1uJoJTvPJBfnya/YrgMlnr
         mep5gIg+Tk8TOAitQKNxfxOYKU3c4zvYDydFN6SAzcbB090F2ZjvvR/XT2J2gbprZXmX
         8jr1BUcuXg3lPKyJWZoeJLKnjXqzzKWhnLVrimhrO3MoftTTfN7SRFAfVaPKw4QZ7kAP
         eecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jouaXHVARN7TPIR1aRyDjQCcOqH/ziYXL93prLAr8VQ=;
        b=cQ+4REhN9kf34SmcXbu7wm2F45uzXuRZ1Jnc5Ul69XKFD16Cze0GAkr5Ocsf/wnzh6
         uHM+5bx9nZr+rcHWwr24+E+Q/XuYVJxXx3GiK0foSm7ziNOySoyw/877BX2FxZnYiq1P
         vnzjKu1tgoO9ISet6oSE2anZ/uWoOf/WIeXfc1r8LrCBiEQ9u+1miR9u7EJcUs32zKPp
         E5JzeFa7vtsKGzF+CBjfGwDVsDiets8b54C0dOCCr9Z+Y6UjDekMog73bXbT5va30pvD
         FRB+DRdoN+YHUZykuuLI6bB7iUOEUsrPTezwdb77wLL1IYQoqBZM+Jrp9kfsiW0lEzw3
         xScA==
X-Gm-Message-State: AA6/9Rnx4SVrKIkgu+ChL49C92ZuKQYFyJvL8+QWoXYnsdmmqRxBfo4MxR0Z0OISEIkcEWXPvX3qWU7RvVhI6A==
X-Received: by 10.129.76.194 with SMTP id z185mr1418110ywa.257.1475560688401;
 Mon, 03 Oct 2016 22:58:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 22:57:48 -0700 (PDT)
In-Reply-To: <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 22:57:48 -0700
Message-ID: <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> These tests are just trying to show that we allow recursion
> up to a certain depth, but not past it. But the counting is
> a bit non-intuitive, and rather than test at the edge of the
> breakage, we test "OK" cases in the middle of the chain.
> Let's explain what's going on, and explicitly test the
> switch between "OK" and "too deep".
>

Makes sense to actually test the edge case here instead of just in the middle.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5613-info-alternate.sh | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index 7bc1c3c..b393613 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -39,6 +39,18 @@ test_expect_success 'preparing third repository' '
>         )
>  '
>
> +# Note: These tests depend on the hard-coded value of 5 as "too deep". We start
> +# the depth at 0 and count links, not repositories, so in a chain like:
> +#
> +#   A -> B -> C -> D -> E -> F -> G -> H
> +#      0    1    2    3    4    5    6
> +#

Ok so we count links, but wouldn't we have 5 links when we hit F, and
not G? Or am I missing something here?

> +# we are OK at "G", but break at "H".
> +#

Seems like from the wording of this comment that we'd break at G and
not H..? Obviously the test below shows G is ok. Aren't the numbers
here off by 1?

Regards,
Jake

> +# Note also that we must use "--bare -l" to make the link to H. The "-l"
> +# ensures we do not do a connectivity check, and the "--bare" makes sure
> +# we do not try to checkout the result (which needs objects), either of
> +# which would cause the clone to fail.



>  test_expect_success 'creating too deep nesting' '
>         git clone -l -s C D &&
>         git clone -l -s D E &&
> @@ -47,16 +59,12 @@ test_expect_success 'creating too deep nesting' '
>         git clone --bare -l -s G H
>  '
>
> -test_expect_success 'invalidity of deepest repository' '
> -       test_must_fail git -C H fsck
> -'
> -
> -test_expect_success 'validity of third repository' '
> -       git -C C fsck
> +test_expect_success 'validity of fifth-deep repository' '
> +       git -C G fsck
>  '
>
> -test_expect_success 'validity of fourth repository' '
> -       git -C D fsck
> +test_expect_success 'invalidity of sixth-deep repository' '
> +       test_must_fail git -C H fsck
>  '
>
>  test_expect_success 'breaking of loops' '
> --
> 2.10.0.618.g82cc264
>
