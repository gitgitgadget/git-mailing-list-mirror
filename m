Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42AD8203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 06:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbcGZGGS (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 02:06:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35273 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcGZGGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 02:06:17 -0400
Received: by mail-it0-f65.google.com with SMTP id f6so8910525ith.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 23:06:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qVyf/1Rh8RMQ/UZcD0GLLCqwcsMNwJWgrPzsVIm1Brc=;
        b=LU8VfbG+A/6A1rqqgR7/vQ4il+440P6R2TsY23f/6OVdtx8Zv99d/UbROkdYfFL2Nh
         wZIwVwWLHzIOqUVK16m+whB54cEqry1XxpRdyt6KpokYxAPrFb9/TpT9uIqzn6L+Femi
         SbUuXD+3LrHzuK+vrKKKx3UBHt6TUi9+Np4g1F4amm9dZhtUTALKGDBliAvdkuW3kNgU
         pp/nt7G8oqzuoi958MPqS9XwflpUBva/+hWYZWbRA1NIp92o9wQAfH28cOsE6R1taDwV
         fG7tq+/bxnl9KHXc2zu1JpskZpzIRsOQOBw4s0kqlg0H7rEOQtnE0x/4VS8YCs3QGVrn
         esWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qVyf/1Rh8RMQ/UZcD0GLLCqwcsMNwJWgrPzsVIm1Brc=;
        b=KW1qvxKY3mlZvCcNOX3GURBw5fBbcFX8YMEksaIxPWwu4o6m7L/PWarvghSAz+G0HR
         shS3A4azWy2BPK8Pw8mytcQm3lmiSk7CVw5fyyhqf5BY/HtgcphJMYWBPNwadFpfPmyO
         7Hen6KEKIDIIezpVXjU8SJ90zy8efyV1RbIUmB0QeYvfYEf1CrDtIeWT8scUmWs8P8H6
         /1W4IHASi/srx5pZxK+e5vGYt2vGFEPljntuFHZdLKDgFimM+MmKkZ7g3+liqicYTltU
         P74ByCzG8McH0V8YKFlSpR7HCmkNvTlU3V3OVfaUfu636Y7x/3n3WSRooiLCh8bjFgNJ
         GIcQ==
X-Gm-Message-State: AEkoousaLsNgvmPwQks9mp+cmUMjxvtVlo73hw6rOXVnUaM9XNPIYhMzKx9JqySlPSaHE/aGvW8F1rhpjodGzA==
X-Received: by 10.36.54.135 with SMTP id l129mr24840302itl.73.1469513176267;
 Mon, 25 Jul 2016 23:06:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Mon, 25 Jul 2016 23:06:15 -0700 (PDT)
In-Reply-To: <20160726041416.9438-1-davvid@gmail.com>
References: <20160726041416.9438-1-davvid@gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Tue, 26 Jul 2016 02:06:15 -0400
X-Google-Sender-Auth: bPRVc0nr5KbqTR8wiqsBTJqk7Jc
Message-ID: <CAPig+cRGz2eqPK0uaih3hYCV0eLayot3VGyjKaz5Qf8Jy5o=DA@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7900-subtree.sh: fix quoting and broken && chains
To:	David Aguilar <davvid@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 12:14 AM, David Aguilar <davvid@gmail.com> wrote:
> Allow whitespace in arguments to subtree_test_create_repo.
> Add missing && chains.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> @@ -16,16 +16,16 @@ export TEST_DIRECTORY
>  subtree_test_create_repo()
>  {
> -       test_create_repo "$1"
> +       test_create_repo "$1" &&
>         (
> -               cd $1
> +               cd "$1" &&

Thanks, I noticed this in December 2015 while reviewing a patch on the
list and have had a patch to fix it sitting in my queue since then but
never found time to formalize it.

>                 git config log.date relative
>         )
>  }
>
>  create()
>  {
> -       echo "$1" >"$1"
> +       echo "$1" >"$1" &&
>         git add "$1"
>  }
>
> @@ -73,10 +73,10 @@ join_commits()
>  test_create_commit() (
>         repo=$1
>         commit=$2

Perhaps &&-chain the above two lines also to future-proof against
someone inserting important code somewhere above the following 'cd'.

> -       cd "$repo"
> -       mkdir -p $(dirname "$commit") \
> +       cd "$repo" &&
> +       mkdir -p "$(dirname "$commit")" \
>         || error "Could not create directory for commit"
> -       echo "$commit" >"$commit"
> +       echo "$commit" >"$commit" &&
>         git add "$commit" || error "Could not add commit"
>         git commit -m "$commit" || error "Could not commit"
>  )
