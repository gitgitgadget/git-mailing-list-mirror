Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D688F200B9
	for <e@80x24.org>; Thu,  3 May 2018 19:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeECTAT (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 15:00:19 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34403 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeECS7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:59:01 -0400
Received: by mail-yw0-f194.google.com with SMTP id x27-v6so3389436ywj.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iCpE9H+6LQlK17Zw1UBHTBzB3YHl5qpZyuRKaVxXpWc=;
        b=nVd5pFMTfbgCZBm4ivWPcF2rY0lrrvCyds6nFvrg04Z9H+0Rqajw8lfC7/bvV5yAOe
         NpcSt2bqOeVtDzRmbu2X1Nz7TGRBIOiyxLFQMMp0FYvwR/ryc0dPWpJ4q799Kv/GGQYC
         W8PJ/KuZF6bqONijt1bkq6KHi2H53r3E6tBjoLfIoAEy6KJo19w7zG1QUhJjqcNPi/N0
         w/MZFnmjNhqmyhB1TWTFU0fsNUpsMMHUBzgpKimfuAq4h8tqlyFojwIza4VkwT52KuXs
         Esw2kyHFrednt5p6rpSrq8WkRYHQ4g3sCTtG6bZqAgxZflDkVaoPCqX2wjeoLKk2uRCr
         M4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iCpE9H+6LQlK17Zw1UBHTBzB3YHl5qpZyuRKaVxXpWc=;
        b=W2N3g6o4z4pwc9zP23Aj/g2bNFLr0JT/5DtHc+wL5bdgIzYtwCJB6GEgP+mzxHbAtY
         1RmENAmNx2odWWAVyt7f7hzHobTIxv3xpDKbn5G0FxZQd3uy6QILiJj1ezje7H871Njt
         ZkTd1EE1MIXaSjl0JBLOstCr+WI6zdCDZc3o8+rDhqL6G8oXZ/J+xAUT+CVBR4+Xi9BQ
         pT5dSAzXDKdnL3ejoMP532ZZ64EcIzw+IyZrjtsO7iCJzVpqrrQrjO8dqus5b1TqTG51
         v4p1+gzYUcQiCOcAKEzwUXypF0zkpv0NTWzna1vFDmvAZ64/ShujTC/P96ISaucdbMPW
         ORyg==
X-Gm-Message-State: ALQs6tAtw/bDJx6tFH5Cl03jcQwselFsDzVLXRY9bJGoUgMxX0LW3w1s
        qu3lpjU1iPK4Q3CbfUB/ooL9tmENdEEX0YqLiGPdUg==
X-Google-Smtp-Source: AB8JxZpd3LTMV96kIw6dN79EuNWnymYablBJ8ESTQF8pxXIQ2+OIqm+Gr+wVrkNrQ4FcL0mgfLLTZxbnMA4Bzicn8EQ=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr13889841ywf.33.1525373939954;
 Thu, 03 May 2018 11:58:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 11:58:59 -0700 (PDT)
In-Reply-To: <177c6eb7058adc1996f0595ddc3cc848c91b578f.1525220786.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
 <cover.1525220786.git.jonathantanmy@google.com> <177c6eb7058adc1996f0595ddc3cc848c91b578f.1525220786.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 11:58:59 -0700
Message-ID: <CAGZ79kbTwqzKgZjN7GSXn-NpKX0kkDVYbXmdz6CC6TrDWbqyQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] upload-pack: fix error message typo
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 5:31 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Fix a typo in an error message.
>
> Also, this line was introduced in 3145ea957d2c ("upload-pack: introduce
> fetch server command", 2018-03-15), which did not contain a test for the
> case which causes this error to be printed, so introduce a test.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

This is Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  t/t5701-git-serve.sh | 14 ++++++++++++++
>  upload-pack.c        |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 72d7bc562..1b4b13cc2 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -173,4 +173,18 @@ test_expect_success 'symrefs parameter' '
>         test_cmp actual expect
>  '
>
> +test_expect_success 'unexpected lines are not allowed in fetch request' '
> +       git init server &&
> +
> +       test-pkt-line pack >in <<-EOF &&
> +       command=fetch
> +       0001
> +       this-is-not-a-command
> +       0000
> +       EOF
> +
> +       test_must_fail git -C server serve --stateless-rpc <in >/dev/null 2>err &&

Minor nit:
Why do we pipe stdout to /dev/null ?
