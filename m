Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3D41FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 22:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbdDCWfZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 18:35:25 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35994 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdDCWfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 18:35:24 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so131861258pge.3
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EjPMZ5gxn5nBx7nr8bKppWKcotZkoRTRVTvshTLkUDo=;
        b=vyb2Rk0exujQwNEZoLG0UTZCmrjyFLKW1X/uehVzLFi5M3Palr4TvckwHsKUVASaDe
         VtswW3zS8cq2dNDsXHT7g7XybfkkmC6jCdfTNVV7BKb3wgoxPnksV+hm792cWmNzc/+P
         Do8+F6+q6yrsX/J4CEHFdMVd53v1U2UTClB7vs1Yx91LsPjwX+90O1OTElxd42GDjx7h
         K8bJDOOtvAP5aO28WHK5uYuubSGWjMPaBsAjbX3AWAl0aEzYhi+zrxwnYVWcLHyjQJkZ
         wPebLXfPvQEVu9dxnMoacnlTLqJ8hKMuDRn3AyxjVYXsGACqQ+tZByqJu8fm6ue1z9/u
         ciZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EjPMZ5gxn5nBx7nr8bKppWKcotZkoRTRVTvshTLkUDo=;
        b=IvYQxuKP4lUeynj/uWUsI5GDth103zWBnou/MbxZER1DY93SxRS3bR0dW2uVcDoSTG
         Su8jmxs12xeJqan6foaEqJA0lCdCqOwSaocL4V/oj7mT44kFFa89xMOK+r03fl97UvrI
         7YNQpdSJ1evcvpIB+ySVM+lWh4jiyHgrWWGdw/vthOcoJjl+N7GKz78jOw+72jm31kBa
         rK+jgq0KkST3Xz6gJ2Ijk8ET+rgM8Y+WZh31PmnsFU5K13b+QCDSkD/mOQwIQhsFkpcP
         MPG4gjN8GRkk2DqQKyLRSxlC/S638ITchg+GY+WbN2L3gyXzPVcNH0/TLBnIZ3YMXx1m
         vtcw==
X-Gm-Message-State: AFeK/H3MEqs8pA5cPoVQaRfPOcL9avmhaI6etSfgT9Usm5Znf5shU3BoEM/Y1P8hU4Z3xkB/OTWRaABrHHaYVatg
X-Received: by 10.99.137.66 with SMTP id v63mr20377995pgd.183.1491258923564;
 Mon, 03 Apr 2017 15:35:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Mon, 3 Apr 2017 15:35:23 -0700 (PDT)
In-Reply-To: <1491163388-41255-3-git-send-email-bnmvco@gmail.com>
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com> <1491163388-41255-3-git-send-email-bnmvco@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Apr 2017 15:35:23 -0700
Message-ID: <CAGZ79kbrPjKV=Gi0AHHwSAS_DviysvpSd_6g-w-XuD0R3ceDwg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] remove_subtree(): test removing nested directories
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2017 at 1:03 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> Test removing a nested directory when an attempt is made to restore the
> index to a state where it does not exist. A similar test could be found
> previously in t/t2000-checkout-cache-clash.sh, but it did not check for
> nested directories, which could allow a faulty implementation of
> remove_subtree() pass the tests.
>
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  t/t2000-checkout-cache-clash.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
> index de3edb5..ac10ba3 100755
> --- a/t/t2000-checkout-cache-clash.sh
> +++ b/t/t2000-checkout-cache-clash.sh
> @@ -57,4 +57,15 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
>         git checkout-index -a -f --prefix=there/
>  '
>
> +test_expect_success 'git checkout-index -f should remove nested subtrees' '
> +       echo content >path &&
> +       git update-index --add path &&
> +       rm path &&
> +       mkdir -p path/with/nested/paths &&
> +       echo content >path/file1 &&
> +       echo content >path/with/nested/paths/file2 &&
> +       git checkout-index -f -a &&
> +       test ! -d path
> +'
> +

Looks good to me.

Thanks,
Stefan
