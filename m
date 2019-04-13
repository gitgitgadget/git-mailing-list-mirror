Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BC620248
	for <e@80x24.org>; Sat, 13 Apr 2019 07:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDMHjJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 03:39:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35892 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfDMHjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 03:39:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so13583597wml.1
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WK3oVa5q1bbJ/ca3HuiB2yPiprIPI/Xm37npBB0s800=;
        b=SAf9zbH2NJQRXqFBl627ul7muq1N0a/enteK8kxvNm/QroO2+r6uyUkxjaltgIpEmW
         c+GAART8D2VcjMyn7/tQi73nwG9nae/kWJ1iwlm1Ib3NiJjYglV61INOws9HwjyHnpSJ
         atsbol1Ys4x+dICk3utFQEB9kgTlobnSwjFAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WK3oVa5q1bbJ/ca3HuiB2yPiprIPI/Xm37npBB0s800=;
        b=HFSN9eG2vYqTnt9RzR6rdNQRjjtfu0lOEAnK/dTwzAoTsJl1QAhwepO9zs8wkZPhtM
         q8zQBhRxKuGO0eZd6KIk2A1CnLqNJ43WY4aLKW1OAgcZlb7Zq/Bzse1pS/0y8214ueao
         th+u2koTgdt3wseQgSNzTjwzqufStHQWBznwvJAsEkh4R+j9j+eWk2JaS7wV6/lb5dKt
         NorTD2BilELPrR23gkZw4Z0xYgxvNKyZd57R1tesafAL9Qq+e2sdbZ/d2K5mBXdKBsf4
         XKbkOaA/XgDPITjQWXfr4iwja+9aemeaYzkR/lF1iriqHgt72i8bXYJEeM31xI5BTQJI
         c4Rw==
X-Gm-Message-State: APjAAAXuQoyAe//Mmji90/4wT4mgaY0nF6Mv0SpdPpWFyM3udDJh5WC9
        V1T98yKChjtBtQiNnS7zbZlfHVe6VNR/+AZkTvEglQ==
X-Google-Smtp-Source: APXvYqyLMWRMny17TsB3jFjoym0Ky68sp0D+mKmD1/TPnVIA8o9y2WtXN0idzUbpoNqFxbWmwwQMlXHR5eUNHaq8CKs=
X-Received: by 2002:a1c:9942:: with SMTP id b63mr14460019wme.116.1555141147490;
 Sat, 13 Apr 2019 00:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.179.git.gitgitgadget@gmail.com> <52681aee0a9657691521baf13f792bcfb9eeb898.1555069181.git.gitgitgadget@gmail.com>
In-Reply-To: <52681aee0a9657691521baf13f792bcfb9eeb898.1555069181.git.gitgitgadget@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 13 Apr 2019 08:39:05 +0100
Message-ID: <CAE5ih79dyauRN3Kc17JMAx+p6dWFsy-P_1G=jTug-i9T=RrKLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t9822: skip tests if file names cannot be ISO-8895-1 encoded
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Apr 2019 at 12:39, Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Most notably, it seems that macOS' APFS does not allow that.

Did you mean in the subject "ISO-8895-1" encoded or "ISO-8859-1" encoded?

It seems reasonable other than that!

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t9822-git-p4-path-encoding.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
> index c78477c19b..de0b46581d 100755
> --- a/t/t9822-git-p4-path-encoding.sh
> +++ b/t/t9822-git-p4-path-encoding.sh
> @@ -7,6 +7,13 @@ test_description='Clone repositories with non ASCII paths'
>  UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
>  ISO8859_ESCAPED="a-\344_o-\366_u-\374.txt"
>
> +ISO8859="$(printf "$ISO8859_ESCAPED")" &&
> +echo content123 >"$ISO8859" &&
> +rm "$ISO8859" || {
> +       skip_all="fs does not accept ISO-8859-1 filenames"
> +       test_done
> +}
> +
>  test_expect_success 'start p4d' '
>         start_p4d
>  '
> --
> gitgitgadget
>
