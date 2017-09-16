Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE6F20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 07:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdIPHsr (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 03:48:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36745 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdIPHsq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 03:48:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id r136so4470968wmf.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=95h2m1J4956CqO/xu7t+7TuZK1OopUD8Lm+QsDK8EY0=;
        b=OAkH1FeCEYwryAgnOGSo+sRgGImE353Q/NoQvol6Jx9KtQxKfyxKEEjuZmk6phOLVb
         OMIWcztH/pyYBmBBT744orSF7gSbzfo9/uJ1h8CTeaGpwtaACwypRHIZeHkEQk7JPZxV
         wMO0F5LUp49sYT66jZWzGXLsmMpIRVoNdxTe0n9RtwYvFLCfo1/9+BNzh1Oo0T7YmJ0W
         IDaNM3P9RPxxm8/BXU3Qh7qToBDqU8dnDB1rUgQyU8nLawp44chCvxudYc3eQQAb/cZK
         6a11OzhOqpDzTCp1GKi9FQgJFz5D69c/C3VxAqYIeojH+dOcvSqS/BijCdHhQqLZ0wXw
         Xi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=95h2m1J4956CqO/xu7t+7TuZK1OopUD8Lm+QsDK8EY0=;
        b=K7ZEWOx5r7/WSCnyjnYutWwHtJvvI6pI6lGh+mUPjifTM/PZZeE8kwf0RmN7xLUu3m
         g9VIJjVryGOlz9ZJWj3l3VeDPnoSQXjCCnTwYHqURS1BWE7Rpk8z88Df67icNpC5ePG7
         zJx0Ttil/+qJiBd/KpsdzfUArHu3P6dqtqT2sP62O2c1yYZSdaYLiqy06gGRJnHBMgbe
         MJkYcgudPdGfbcodVQHkKInYLm7Hm9p3I08Ze0YLqhG3znDDJm34eeAsIzuvwhWX3AyI
         HhfaYhuJCXc+wGTK4jP5AJ0ZgsnooLjwoIpwnw32FzAuo8mmKOoUGnRostNKUVB6zywK
         b+VQ==
X-Gm-Message-State: AHPjjUjxQW/yjoyFlDPj3w9CKjVdqry6y7GfaDi8sZKhaHyrl6QLdK2Q
        2miPb0DMNJovagLkTVvUd+yvAnts+fqDwbQmGrA=
X-Google-Smtp-Source: AOwi7QAxno8JqBAV1xlcA8yiGDgKo2cFN+p9PNvi4OoZPZy+5FX3M4RfCgNpKDEy2T7ZwoqaaRZyOF4E9e3iWfXCxgs=
X-Received: by 10.80.139.65 with SMTP id l59mr6534945edl.187.1505548125014;
 Sat, 16 Sep 2017 00:48:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.146.185 with HTTP; Sat, 16 Sep 2017 00:48:24 -0700 (PDT)
In-Reply-To: <20170916055344.31866-1-max@max630.net>
References: <20170916055344.31866-1-max@max630.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 16 Sep 2017 00:48:24 -0700
Message-ID: <CA+P7+xqQQAd4X9PjjbRy7RTZVO6BqomQ2uiRXZ6pCSb-z+RC6Q@mail.gmail.com>
Subject: Re: [PATCH] describe: fix matching to actually match all patterns
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 10:53 PM, Max Kirillov <max@max630.net> wrote:
> `git describe --match` with multiple patterns matches only first pattern.
> If it fails, next patterns are not tried.
>
> Fix it, add test cases and update existing test which has wrong
> expectation.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  builtin/describe.c  | 9 ++++++---
>  t/t6120-describe.sh | 6 +++++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 89ea1cdd60..94ff2fba0b 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -155,18 +155,21 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
>          * pattern.
>          */
>         if (patterns.nr) {
> +               int found = 0;
>                 struct string_list_item *item;
>
>                 if (!is_tag)
>                         return 0;
>
>                 for_each_string_list_item(item, &patterns) {
> -                       if (!wildmatch(item->string, path + 10, 0))
> +                       if (!wildmatch(item->string, path + 10, 0)) {
> +                               found = 1;
>                                 break;

I see what was wrong. The "if we got here" check is inside the loop,
so after the first wildmatch we never loop again. The fix is to add an
additional variable to store when we found something and exit the
loop, and ensure that we actually did the whole loop without finding a
match.

Thanks for the fix and proper tests!

Regards,
Jake


> +                       }
> +               }
>
> -                       /* If we get here, no pattern matched. */
> +               if (!found)
>                         return 0;
> -               }
>         }
>
>         /* Is it annotated? */
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index aa74eb8f0d..25110ea55d 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -182,10 +182,14 @@ check_describe "test2-lightweight-*" --tags --match="test2-*"
>
>  check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
>
> -check_describe "test1-lightweight-*" --long --tags --match="test1-*" --match="test2-*" HEAD^
> +check_describe "test2-lightweight-*" --long --tags --match="test1-*" --match="test2-*" HEAD^
>
>  check_describe "test2-lightweight-*" --long --tags --match="test1-*" --no-match --match="test2-*" HEAD^
>
> +check_describe "test1-lightweight-*" --long --tags --match="test1-*" --match="test3-*" HEAD
> +
> +check_describe "test1-lightweight-*" --long --tags --match="test3-*" --match="test1-*" HEAD
> +
>  test_expect_success 'name-rev with exact tags' '
>         echo A >expect &&
>         tag_object=$(git rev-parse refs/tags/A) &&
> --
> 2.11.0.1122.gc3fec58.dirty
>
