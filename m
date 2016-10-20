Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9831F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbcJTUGF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:06:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34182 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbcJTUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:06:04 -0400
Received: by mail-yw0-f194.google.com with SMTP id u124so2285266ywg.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iYhg+SGIjLM6wlJLsEUA0eGjEjobabfV9ujvaxE7ZbA=;
        b=xU8SA0/GgwoqiaXCv0xXqHcGoxmORmaLgqziaO3kT4Yn6d0q8OdkuIgxglOdsAwOTD
         g/0qSmZ2eJAyinXzwaFJ+T+lcMTzXQo4c04RWY9Fvb+nuinSD+aQcg0uXaLzPIh4Fn86
         PLvCqRrNn40rBttatDHnJT6utGry3+YPrPd2ZkT9omQV3cukLwygLnqNs6Fxrgt/6k+e
         oWvYLQ9aLCD3JqvHvpC9Z+echpYp7TkWb9gikMwoGdjQeNx8p47gTr0TzxQmFnAG/OLQ
         MM43YxYZm1HsuIusqI6QAqEqTDNhuXZuC0AmnmgTKoRombMhL1NmJu44v9YFqW+xukFU
         mdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iYhg+SGIjLM6wlJLsEUA0eGjEjobabfV9ujvaxE7ZbA=;
        b=M/vGeo8jpoPCU8nJs4FOyyBS5KO9bEhg2t+KO7PwNkQ7c/6HSNgubz6uacjaNo97ha
         xNEF7zvd4kdGvrdOo17WsMEgLy5bOcDfvm8ajX8qkDk3hY1KSlYl+ludCgbXLpgNWWP8
         APRM1UVdocbXTXgzVPBcAUB7213c17buYyXikm+BwGddIqYsSxI3nWqpdi2Sq8smZ85m
         TfsJRLLSe5bPeJCTig5LaRQSzfFHIwJRMsRUi//dKzWNQbshbYIFShw0gJzflEPlnO7e
         JYaz85x/NDPlLcCTsDn/gL10Rn0X/0NfRVh3Q+kZ/Q1mU8VNCh1GEIaLYJNSntuL7nF9
         q/sA==
X-Gm-Message-State: AA6/9Rmfn+l0GSnStkBfwzoGAA7PgJvfpj3zuH3nFkfKjgRZCmusA2Uj7aS2iA9oIcWcnvuqS8a0Qy+aMs+TRw==
X-Received: by 10.13.231.131 with SMTP id q125mr3493554ywe.122.1476993963002;
 Thu, 20 Oct 2016 13:06:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Thu, 20 Oct 2016 13:05:42 -0700 (PDT)
In-Reply-To: <xmqq4m46hmvq.fsf@gitster.mtv.corp.google.com>
References: <20161020181930.21084-1-jacob.e.keller@intel.com> <xmqq4m46hmvq.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 20 Oct 2016 13:05:42 -0700
Message-ID: <CA+P7+xp1GevYkrSfDo2OtEve3RCXokawEf6c=5gF0daZOUF00Q@mail.gmail.com>
Subject: Re: [PATCH] rev-list: use hdr_termination instead of a always using a newline
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 11:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The main part of the patch looks good.  For "passing NUL to sed",
> I'd probably work it around like so:
>

Yep. I wasn't sure on the test as it was, because of the portability concern.

>  t/t6000-rev-list-misc.sh | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index e8c6979baf..737026c34f 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -4,12 +4,6 @@ test_description='miscellaneous rev-list tests'
>
>  . ./test-lib.sh
>
> -test_ends_with_nul() {
> -       printf "\0" >nul
> -       sed '$!d' "$@" >contents
> -       test_cmp_bin nul contents
> -}
> -
>  test_expect_success setup '
>         echo content1 >wanted_file &&
>         echo content2 >unwanted_file &&
> @@ -107,8 +101,17 @@ test_expect_success '--bisect and --first-parent can not be combined' '
>  '
>
>  test_expect_success '--header shows a NUL after each commit' '
> -       git rev-list --header --max-count=1 HEAD | sed \$!d >actual &&
> -       test_ends_with_nul actual
> +       # We know there is no Q in the true payload; names and
> +       # addresses of the authors and the committers do not have
> +       # any, and object names or header names do not, either.
> +       git rev-list --header --max-count=2 HEAD |
> +       nul_to_q |
> +       grep "^Q" >actual &&
> +       cat >expect <<-EOF &&
> +       Q$(git rev-parse HEAD~1)
> +       Q
> +       EOF
> +       test_cmp expect actual
>  '
>
>  test_done

I will squash this in and re-send.

Thanks,
Jake
