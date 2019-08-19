Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEC31F461
	for <e@80x24.org>; Mon, 19 Aug 2019 17:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfHSRJT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 13:09:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45192 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHSRJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 13:09:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so9481261wrj.12
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 10:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sy932AoRWTA3E0FKKS3nLYIRnU8QK9tvtJn8KytLjig=;
        b=Y9hUlUCrSV1GX72PfFqvIwLbF1Ja6jnSUkzWrkGN/NwRqKn4d02PY3ejgrC1yVKXZj
         cmoF5hu4aOeoul8JisNxKxdboE6J8p0EsGW9mVTJqCOJbkkeYCskkB2dhGTia+jMTdE0
         geOLm+SvBwwI/yHa7l3jhy4hm+C09iras8Eq0RxG+SN2xKbAo2u9iDAXhSLgFaCIGqp1
         WWzQY78giwPWH+ZZzMSs6RMsxcN5C7CgLmrExCVR/AnEl6LJ6+RkHFZmFcNaalSX2KkM
         0UnxwWyCwbVbSsgl4RDQl5gEE3Tgwsyk8QsYTa05CW4uF5dwtleg+5gp7/KHPQCGA1Yf
         efBg==
X-Gm-Message-State: APjAAAXvYafcyd6jq6K8+9PlJr7mFH0qOM+XdVwGBbGSNyAZNid7J9nv
        qwMyMEb3Tolxkle8TbQHa+DWxN6O15BeIW5NZTI=
X-Google-Smtp-Source: APXvYqy3Kc4mD59knVbP2M7wSjV/XbrOXkbcp/faqZzP3DKiNskqppLzoxquJCMDUtKHEeoq+bBFwncuT9s5v+MX4EQ=
X-Received: by 2002:adf:fa42:: with SMTP id y2mr29250958wrr.170.1566234556606;
 Mon, 19 Aug 2019 10:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566182184.git.liu.denton@gmail.com> <7619da962d1fc804392e3552fbd56bf4bc68ac38.1566182184.git.liu.denton@gmail.com>
In-Reply-To: <7619da962d1fc804392e3552fbd56bf4bc68ac38.1566182184.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Aug 2019 13:09:04 -0400
Message-ID: <CAPig+cSG6mHCgLRw=QLWkVhK4oVSFkQRCszrBdO6SCGA+M0B3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] Doc: add more detail for git-format-patch
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 18, 2019 at 10:37 PM Denton Liu <liu.denton@gmail.com> wrote:
> In git-format-patch.txt, we were missing some key user information.
> First of all, using the `--to` and `--cc` options don't override
> `format.to` and `format.cc` variables, respectively. They add on to each
> other. Document this.
>
> In addition, document the special value of `--base=auto`.
>
> Next, while we're at it, surround option arguments with <>.
>
> Finally, document the `format.outputDirectory` config and change
> `format.coverletter` to use camelcase.

I can't figure out if you typeset "camelcase" like that intentionally,
as opposed to "camelCase" or "camel case" or "camel-case".

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
>  --to=<email>::
>         Add a `To:` header to the email headers. This is in addition
> -       to any configured headers, and may be used multiple times.
> +       to any configured headers, and may be used multiple times. The
> +       emails given will be used along with any emails given by
> +       `format.to` configurations.

Hmph. This seems redundant. The description already says "This is in
addition to...", so a new sentence saying "...used along with..." is
just parroting what was already stated.

>         The negated form `--no-to` discards all `To:` headers added so
>         far (from config or command line).
> @@ -314,7 +318,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  --base=<commit>::
>         Record the base tree information to identify the state the
>         patch series applies to.  See the BASE TREE INFORMATION section
> -       below for details.
> +       below for details. If <commit> is equal to "auto", a base commit
> +       is automatically chosen.

"is equal to" is unnecessarily technical-sounding. How about:

    If <commit> is "auto", ...
