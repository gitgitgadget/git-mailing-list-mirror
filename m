Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4F220248
	for <e@80x24.org>; Tue,  5 Mar 2019 00:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfCEAhB (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 19:37:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37101 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 19:37:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so7521029wrs.4
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 16:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJXUOWZGqzfyW24m59yESEO/iFFfUXUOQPAVaANEvlQ=;
        b=mepg0X6wXv6V/jeL4cNG4AZaIx7twoZ8RTLpz82Z26jeRSIt25h1wGMmstGon/dJMN
         UYTcH/jRqbZlaUcGivpU9Sa25vP8OHyB08s9nLt6/thSVw+JSi7XFWsmlp/yF/ZpS9Es
         8iGKmrnye/iP5v/L1e+K/WM+QSDvzyVOjGPm+HfilKYOOoZCLGFpSDKo8zNspHVN66Ec
         HfcIDhNNcvaZLWPjURlsc8HRyLXbsCPbw7c6+a4tx4Pa21NyTnCvgX8h6jXvDqW6OYRc
         wblAKthZzDhHQNWx3mBz0dItVcFRkzKfeVygUJFYx51IsxXYWGb6gpQWFf7GKwj57sGY
         +8eQ==
X-Gm-Message-State: APjAAAXu41385OSgnZFFG1GFyPMXHqyQvG1wV5v6fJOrSNzYIka/I21I
        USLQOJDLTZAyChPiC1clIKtgymwfST8XyPU2juo=
X-Google-Smtp-Source: APXvYqzDWiEAW0zznZoMqe3hUdgKnQXmOVvMxL6Fzi/mG09y2nUTwIA0niJgNh5JwHSaFQKZc7qfm9tgMuEFaNxivBs=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr14729263wrg.88.1551746219131;
 Mon, 04 Mar 2019 16:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190304120801.28763-1-rohit.ashiwal265@gmail.com> <20190304120801.28763-3-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190304120801.28763-3-rohit.ashiwal265@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Mar 2019 19:36:48 -0500
Message-ID: <CAPig+cQ=Uoa3G0mvJ6MGfEM=W6bpghS-+Ub32UtmdoC0OAZD7w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] t3600: modernize style
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 7:08 AM Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> The tests in `t3600-rm.sh` were written  long time ago, and has a lot of
> style violations, including the mixed use of tabs and spaces, not having
> the title  and the  opening quote of the body on  the first line of  the
> tests, and other  shell script  style violations. Update it to match the
> CodingGuidelines.

Many of the words in this commit message are separated by multiple
spaces. Please fold out the excess so there is only a single space
between words.

> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> @@ -217,23 +218,25 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
>  test_expect_success 'Call "rm" from outside the work tree' '
>         mkdir repo &&
> +       (
> +               cd repo &&
> +               git init &&
> +               echo something >somefile &&
> +               git add somefile &&
> +               git commit -m "add a file" &&
> +               (
> +                       cd .. &&
> +                       git --git-dir=repo/.git --work-tree=repo rm somefile
> +               ) &&
> +               test_must_fail git ls-files --error-unmatch somefile
> +       )
>  '

This test is unusual in that it first cd's into a subdirectory and
then cd's back out with "cd ..". And, while the use of subshells is
correct to ensure that all 'cd' commands are undone at the end of the
test (whether successful or not), the entire construction is
unnecessarily confusing. This is not the sort of issue which should be
fixed in this style-fix patch, however, it is something which could be
cleaned up with a follow-up patch. For instance, the test might be
reworked like this:

    git init repo &&
    (
        cd repo &&
        echo something >somefile &&
        git add somefile &&
        git commit -m "add a file"
    ) &&
    git --git-dir=repo/.git --work-tree=repo rm somefile &&
    test_must_fail git -C repo ls-files --error-unmatch somefile

It's up to you whether you actually want to include such a follow-up
patch in your series; it's certainly not a requirement.
