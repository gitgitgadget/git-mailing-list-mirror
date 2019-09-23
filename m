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
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D281F463
	for <e@80x24.org>; Mon, 23 Sep 2019 16:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390851AbfIWQwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 12:52:22 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45695 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbfIWQwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 12:52:22 -0400
Received: by mail-ua1-f66.google.com with SMTP id j5so4551721uak.12
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B9+duR4W07vx9JmGNz++s0GZiGWHv7euOVLtMkQqaNc=;
        b=SSWXqgXb/nWgEyPPTwfCBUb+Q5wZwmvCg8LEwWXoWTrHO9FnSmMrqVHsCyfj7qU43c
         MarVNPbbqo8WxwiXyDLAQ3ste+osWNh7BG7C/d2Akx66Mg9QE8Ns6rejXbYdJUtRLIeb
         Z1K5gXuKybjl0LLzNs1G9YT4oBMfD/MfiJEEKLcTjjv0kcrxMCrYagXyWZxMM7U8hRQo
         nBRtpPAPnjcLZuYJixTthzTwhbpHPw5CbTbs/rSxtBoY7XC/AMYvRJvVeZhMGwnkIkXy
         /dUAWVhwF82lYnDbtEpiz0/EHWGg5ZV6ofxcgRupyZhnis7kzQMrGFsEN8Iay2FqfI7h
         xLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B9+duR4W07vx9JmGNz++s0GZiGWHv7euOVLtMkQqaNc=;
        b=r2YYQy3QzGQcKN1FpWUbIn0iWIZm1Mh/NjnG3NDdbM/BJfyuPzQUWfUDHud4qA35zh
         Lq1cog2JetYYdxHva/GlprpOlkkADToNjRvVBtosvXHXhL+1VmIOiVaCoGvx8srrlKGP
         5HUHmzvq2756RrApLtaG1NJ+p7PF08tjdeGOqf05KqDA3UGMRjjqMsA8uCSaN+gfmmg5
         uufkP2WU+znJ7mDLhi6k6z3rUeSEheDk4t92u6f1Li5u47qvfby1me69F8XoaT6sum1o
         3vuYueRlij0qqp4zQvPMXUpp1w5narcevkF632GYgEHtRXjp3/AlpRwQ5rLHb5pM6CAF
         mZtg==
X-Gm-Message-State: APjAAAWsgMexMyyy5pVlIdX27HhgY3S5wYXfW+AwBtz3ci8cXgovFK65
        nG5OmdxJXtmmJ/s3yKQfg57J2oNzse+4HSjsgVxbUd8T
X-Google-Smtp-Source: APXvYqycCGf7jTamRpVqALl40jMFYMZeY+8N7dya7vjwuc5tvi/CYO+NxrDMcf5TEGJB4HlUJ2UkjJBlpTdO4oJmfyw=
X-Received: by 2002:ab0:734f:: with SMTP id k15mr199368uap.18.1569257541156;
 Mon, 23 Sep 2019 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190920220601.8090-1-cb@hashpling.org>
In-Reply-To: <20190920220601.8090-1-cb@hashpling.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Sep 2019 09:52:10 -0700
Message-ID: <CABPp-BFF1Vqa7QoH6s1Vf6QtXcBoy1v7XzSsLjOTOCVh4GL3vg@mail.gmail.com>
Subject: Re: [PATCH] t4038: Remove non-portable '-a' option passed to test_cmp
To:     CB Bailey <cb@hashpling.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 3:07 PM CB Bailey <cb@hashpling.org> wrote:
>
> From: CB Bailey <cbailey32@bloomberg.net>
>
> Signed-off-by: CB Bailey <cbailey32@bloomberg.net>
> ---
>  t/t4038-diff-combined.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
> index d4afe12554..b9d876efa2 100755
> --- a/t/t4038-diff-combined.sh
> +++ b/t/t4038-diff-combined.sh
> @@ -509,7 +509,7 @@ test_expect_success FUNNYNAMES '--combined-all-paths =
and --raw and funny names'
>  test_expect_success FUNNYNAMES '--combined-all-paths and --raw -and -z a=
nd funny names' '
>         printf "aaf8087c3cbd4db8e185a2d074cf27c53cfb75d7\0::100644 100644=
 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c=
2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttab=
s\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
>         git diff-tree -c -M --raw --combined-all-paths -z HEAD >actual &&
> -       test_cmp -a expect actual
> +       test_cmp expect actual
>  '

This will mean slightly less useful diagnostic output should the test
ever fail on a platform that does support diff -a, but that's a small
price to pay to make sure the test is portable.  If anyone does ever
see this test fail, they can go in and inspect further themselves.

Thanks for the fix.
