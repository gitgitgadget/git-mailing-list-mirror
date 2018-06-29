Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A091F516
	for <e@80x24.org>; Fri, 29 Jun 2018 22:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936721AbeF2WHF (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 18:07:05 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33668 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932935AbeF2WHE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 18:07:04 -0400
Received: by mail-yw0-f196.google.com with SMTP id c135-v6so2388636ywa.0
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZy7z0O5QlgeKUqJFPKS2Xd+7DJaazp4Y2ICgmYuN+4=;
        b=NL9T/pJuHI7Q7pD5YV6CniSjFaHfTCmDAgqc5rhT+ZLgEuvaP13VZag+GNckllVldW
         FZNLwNCoeGYbpuuuuvCXdm360xexGFFXguR5x0wnE5RUdxvWvTYztCyhzysxCAkyXX8Y
         Nps0OT+4OLstDoXwKtC7m2bgUZk747ZwIJR8AGdUDMTeJX3PogoJZYJMdVQT6xPuBTuI
         cx8CnftniKveEoctufFwfWZFNH7JKUZ/LWcYKtrX//CMYayc93QP++cvw31RWRWsvHuI
         xZzseJkS1aT/3kxHe9sYkvJyJ5hhSrOSi6knZ7yFU313rCQQ3zGt7/z0hxb/BfwgYBcd
         kjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZy7z0O5QlgeKUqJFPKS2Xd+7DJaazp4Y2ICgmYuN+4=;
        b=VCMNyMw4T2Zygq5rb5xdykBlxs+Bj8TRD7/XPPXmk+ZHLD/aVspc3VOqPs2CpPpraS
         X3MG5vA8YrcPgF39mOn1TKk1KJJOnd7D3nZca+BOhjE+7Id/Xd/pMpyXGzKD5YYB4lES
         G1XfNOdajmrm4436BS0EZ2GsRM7xQSHUFKQj2BNKAZ0r0pAhCyPzkipuYB21dFvU0taP
         pA22NerjiKrns2H1u1yusulLDE1S88QJavFMn40HySoKdUCL9haU1DsFagCMI1gcmDEu
         J7SBEfxz95HiFoAl1p7fFdkooVIDdx7Gxs97QSIxDEU0uBHtKZs2fCfWlzS7Z188+8Qk
         /qjA==
X-Gm-Message-State: APt69E29iLG4j3+hiAAtIEqQdGV2Ze1UmU/Dz7ddZhetlw30KP2e8n6/
        6RtMtJhdNPO9XtiNRvjN1bH5qvtvZQMvxs0Saa1VDEjejxI=
X-Google-Smtp-Source: AAOMgpcS2OTeqOREYklgGQvR4LAjKyIkWzBuXUmeaBNHHhnjT/+fTu6UXGtOK2bXJbWOGmUkAObgrVSxGrgItr7vkn0=
X-Received: by 2002:a81:3743:: with SMTP id e64-v6mr3153845ywa.340.1530310023026;
 Fri, 29 Jun 2018 15:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180629161223.229661-1-dstolee@microsoft.com> <20180629161223.229661-9-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-9-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 15:06:52 -0700
Message-ID: <CAGZ79kafYmpzYws7WQJO4-zmWwTBo9Pwo-PpkbmJF+Z9GzsvZA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/13] test-reach: test reduce_heads()
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 29, 2018 at 9:13 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t6600-test-reach.sh | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index c9337b6b46..0f60db9c60 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -78,4 +78,30 @@ test_expect_success 'ref_newer:miss' '
>         test_reach_two_modes "ref_newer"
>  '
>
> +test_expect_success 'reduce_heads' '
> +       cat >input <<- EOF &&
> +       X:commit-1-10
> +       X:commit-2-8
> +       X:commit-3-6
> +       X:commit-4-4
> +       X:commit-1-7
> +       X:commit-2-5
> +       X:commit-3-3
> +       X:commit-5-1
> +       Y:commit-10-10
> +       Y:commit-3-10
> +       Y:commit-9-9
> +       Y:commit-8-1
> +       EOF
> +       printf "reduce_heads(X):\n" >expect &&
> +       git rev-parse commit-5-1 >>expect &&

See 6ac767e5c00 (t6036, t6042: prefer test_cmp to sequences of test, 2018-05-24)
on how to avoid some forks here:

    git rev-parse >expect \
        many HEADs or Tips &&
