Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646891F404
	for <e@80x24.org>; Fri, 20 Apr 2018 16:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeDTQkt (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 12:40:49 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37092 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeDTQks (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 12:40:48 -0400
Received: by mail-yb0-f193.google.com with SMTP id i13-v6so3224285ybl.4
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mGy5MFLu9/Toai1K/cA66Bvwcg9jDkwEePA1tW+qVSs=;
        b=BeRZ6XGNUdUSiHgJspiBGsDeUGurlJboO0AgpqgeHE8QQwZ2b+6KsRmTUff+VqY4KY
         y1v5oKazP90xWCRwDq5yC+5ynSwXZC+r/gpvkB3KoDz1t25SvPOS0856Jlyz11pZVNI0
         dAbtXGy8uoK/Nl8TyZHB64k3/2pcMO/LgUZkYMVyqGCvKn0vubYBcNMCp621JisHGFZK
         qo0E9NgtxxTZywGWsZeq1w0SEX1ypnKxhQgYgF3vCI74L6G1ImvsUKhOvxglFPuo6uiS
         0ABTN8MRT4ZqIXljH+G/5Mq0SVnZ06qRtr7L/jiwOXqD+gS2wZCl/8x0RaoQJb3HERra
         wkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mGy5MFLu9/Toai1K/cA66Bvwcg9jDkwEePA1tW+qVSs=;
        b=gTRpVmnY7NhpoeoUR9HOiv5+6JWI1a+BSsQseBvmRb5ItZHAR7PUeQdjcnTEtRDSd5
         sypnAD1p7kA4hWYJXBa5k8HEkN1E8ClhC/nHCD/Fu/IEYpi2xrYilbNQEYiizjqol3M+
         sfAFVNQxE9aNpEgaGFdQ/yH0Q+rh+1rHxLmgFRD834SjIA95a229VMqm8AF2LiBWmgqR
         0BWiUAyAK/5vQOnu3GgWrtxk5R0rCY0MhRu6KrwZC8jvdEDtg5Kz5+iDr0BQjTSKRIG/
         PbdEJDwSudY0N1e8teKQ6AC6aS+SGd8TaaGBEx3voS5aqOzAb2149QYP/1AAaKstzK6M
         E8Ug==
X-Gm-Message-State: ALQs6tDzQz6HQildWry6pdILwJ7I/UVaySpKveaa16T/K4+15o+K7Bnu
        aflsd548lv5MYH+iz9Pdub2fCbqZyAuSn9DWyoq3cA==
X-Google-Smtp-Source: AIpwx4/ZM8MDTaZXVFY8rvK1OvKk0F4z5VkzyFRxddfClmv4sOqdYLkfM2tnukBiRkIzaBtkqsBObtmLr1KW5N98phw=
X-Received: by 2002:a25:a568:: with SMTP id h95-v6mr6419467ybi.515.1524242447251;
 Fri, 20 Apr 2018 09:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 09:40:46
 -0700 (PDT)
In-Reply-To: <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de>
References: <cover.1524226637.git.johannes.schindelin@gmx.de> <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Apr 2018 09:40:46 -0700
Message-ID: <CAGZ79kZONQ_xuDYJ5Z8cUnF0odwz3+Sh+ST6g+5Tefav-QXEBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit messages
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 5:17 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When multiple fixup/squash commands are processed and the last one
> causes merge conflicts and is skipped, we leave the "This is a
> combination of ..." comments in the commit message.
>
> Noticed by Eric Sunshine.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3418-rebase-continue.sh | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 9214d0bb511..b177baee322 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -88,6 +88,27 @@ test_expect_success 'rebase passes merge strategy options correctly' '
>         git rebase --continue
>  '
>
> +test_expect_failure '--continue after failed fixup cleans commit message' '
> +       git checkout -b with-conflicting-fixup &&
> +       test_commit wants-fixup &&
> +       test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
> +       test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
> +       test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
> +       test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
> +               git rebase -i HEAD~4 &&
> +
> +       : now there is a conflict, and comments in the commit message &&
> +       git show HEAD >out &&
> +       grep "This is a combination of" out &&

test_i18n_grep ?

> +
> +       : skip and continue &&
> +       git rebase --skip &&
> +
> +       : now the comments in the commit message should have been cleaned up &&
> +       git show HEAD >out &&
> +       ! grep "This is a combination of" out

same

Thanks,
Stefan
